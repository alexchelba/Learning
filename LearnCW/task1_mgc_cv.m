%
% Versin 0.9  (HS 06/03/2020)
%
function task1_mgc_cv(X, Y, CovKind, epsilon, Kfolds)
% Input:
%  X : N-by-D matrix of feature vectors (double)
%  Y : N-by-1 label vector (int32)
%  CovKind : scalar (int32)
%  epsilon : scalar (double)
%  Kfolds  : scalar (int32)
%
% Variables to save
%  PMap   : N-by-1 vector of partition numbers (int32)
%  Ms     : C-by-D matrix of mean vectors (double)
%  Covs   : C-by-D-by-D array of covariance matrices (double)
%  CM     : C-by-C confusion matrix (double)

  [n,d] = size(X);
  C = unique(Y);
  m = zeros(length(C),1);
  for i=1:length(C)
    m(i) = sum(Y==C(i));
  end
  PMap = zeros(n,1);
  for c=1:length(C)
    nr = 0;
    Mc = floor(m(c)/Kfolds);
    for i=1:n
      if Y(i) == c
        nr=nr+1;
        if nr/Mc == floor(nr/Mc)
          PMap(i) = floor(nr/Mc);
        else
          PMap(i) = floor(nr/Mc) + 1;
        end
        if PMap(i) > Kfolds
          PMap(i) = Kfolds;
        end
      end
    end
  end
  s1 = num2str(Kfolds); % Kfolds
  s3 = num2str(CovKind); % CovKind
  s= strcat('t1_mgc_',s1,'cv_PMap.mat');
  save(s, 'PMap');
  
  FinConfMat = zeros(length(C), length(C));
  % cross validation for each fold:
  for k=1:Kfolds
    x_k = X(PMap~=k,:); % training set
    train_labels = Y(PMap~=k);
    t_k = X(PMap==k,:); % test set
    test_labels = Y(PMap==k,:);
    [n, d] = size(x_k);
    prior(1:length(C))=1/length(C);
    Ms = zeros(length(C), d);
    Covs = zeros(length(C), d, d);
    Cov_shared = zeros(d,d);
    for c=1:length(C)
      no = sum(train_labels==c);
      Ms(c,:) = sum(x_k(train_labels==c,:))/no;
      X_shift = x_k(train_labels==c,:);
      X_shift = bsxfun(@minus, X_shift, Ms(c,:));
      Covs1 = 1/(no) * (X_shift' * X_shift);
      if CovKind == 2
          Covs1 = diag(Covs1);
      else
          if CovKind==3
              Cov_shared = Cov_shared + Covs1;
          end
      end
      Covs1 = Covs1 + eye(d)*epsilon;
      Covs(c,:,:) = Covs1;
    end
    if CovKind == 3
        Cov_shared = Cov_shared./length(C);
        Cov_shared = Cov_shared + eye(d)*epsilon;
        for c=1:length(C)
            Covs(c,:,:) = Cov_shared;
        end
    end
    test_prob = zeros(length(t_k), length(C));
    for c=1:length(C)
      Covs1(:,:) = Covs(c,:,:);
      lik_k = gaussianMV(Ms(c,:), Covs1, t_k);
      test_prob(:,c) = lik_k * prior(c);
    end
    [max_out, test_pred] = max(test_prob, [], 2);
    [lin col] = size(t_k);
    conf_mat = comp_confmat(test_labels, test_pred);
    FinConfMat = FinConfMat + conf_mat./lin;
    s2 = num2str(k); % p
    save(strcat('t1_mgc_',s1,'cv',s2,'_Ms.mat'), 'Ms');
    save(strcat('t1_mgc_',s1,'cv',s2,'_ck',s3,'_Covs.mat'), 'Covs');
    save(strcat('t1_mgc_',s1,'cv',s2,'_ck',s3,'_CM.mat'), 'conf_mat');
  end
  FinConfMat = FinConfMat./Kfolds;
  % Accuracy rate:
  % su = sum(diag(FinConfMat));
  s4 = num2str(Kfolds+1); % L
  save(strcat('t1_mgc_',s1,'cv',s4,'_ck',s3,'_CM.mat'), 'FinConfMat');
end
