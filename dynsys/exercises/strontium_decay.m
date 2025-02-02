% exercise: decay of 90Sr in a forest

A = [-0.093 0 0 0.081 0.0081; 
    0.07 -0.232 0 0 0;
    0.021 0.23 -0.0071 0 0.042;
    0 0 0.0038 -0.083 0;
    0 0 0 0 -0.0521];

e = eig(A);                     % eigenvalues of A
%disp(e);

e1 = e(3);
e2 = e(4);
e3 = e(1);
e4 = e(5);
e5 = e(2);                      % seperate variable for each eigenvalue, 
                                % complex eigenvalues first

sigma = real(e1);               % real part of complex eigenvalue
omega = imag(e1);               % imaginary part of complex eigenvalue
%disp(sigma);
%disp(omega);

[V, D] = eig(A);                % V matrix where each column is an eigenvector
%disp(V);

v1 = V(:, 3);
v2 = V(:, 4);
v3 = V(:, 1);
v4 = V(:, 5);
v5 = V(:, 2);                   % put the complex eigenvectors first

re_v1 = real(v1);               % real part of eigenvector v1
im_v1 = imag(v1);               % imaginary part of eigenvector v1

T_r = [re_v1 im_v1 v3 v4 v5];   % matrix T_r
%disp(T_r);

inv_T_r = inv(T_r);             % inverse of T_r
%disp(inv_T_r); 

Delta_r = [sigma omega 0 0 0; 
           -omega sigma 0 0 0;
           0 0 e3 0 0;
           0 0 0 e4 0;
           0 0 0 0 e5];
%disp(Delta_r);

