function [T_k,sigma,k]=tensor_truncate_svd( T, G, eps, k_max, relcutoff, p, orth_columns )
global max_numel_svd num_calls
global show_reductions

if nargin<7
    orth_columns=0;
end

if isempty(G); G={[],[]}; end
tqr=tic;
[Q1,R1]=qr_internal(T{1},G{1},orth_columns);
[Q2,R2]=qr_internal(T{2},G{2},orth_columns);
tqr=toc(tqr);
R=R1*R2';
tsvd=tic;
[U,S,V]=svd(R,0);
tsvd=toc(tsvd);

if isempty(max_numel_svd) || max_numel_svd<numel(R)
    max_numel_svd=numel(R);
end
if isempty(num_calls); num_calls=0; end
num_calls=num_calls+1;


sigma=diag(S);
k=schattenp_truncate( sigma, eps, relcutoff, p );
k=min(k,k_max);

U_k=U(:,1:k);
S_k=S(1:k,1:k);
V_k=V(:,1:k);

T_k={Q1*U_k*S_k,Q2*V_k};

if ~isempty(show_reductions) && show_reductions
    strvarexpand( 'truncate: $numel(sigma)$=>$k$  (qr: $tqr$, svd: $tsvd$)' );
end
