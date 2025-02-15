function [A_ineq,b_ineq,A_eq, b_eq]=compute_constraints(NumAssets)

    index_c=[2, 4, 6, 10, 11];     % indices related to the Cyclical Sectors
    index_sen=[1, 5, 8];           % indices related to the Sensible Sectors
    index_def=[3, 7, 9];           % indices related to the Defensive Sectors

    % exposure to sensible sectors <=50%
    % exposure to comunication services <=10%
    % exposure to energy <=10%
    A_max=zeros(3,NumAssets);

    A_max(1,index_sen)=1;
    A_max(2,5)=1;
    A_max(3,8)=1;
    b_max=[0.5;0.1;0.1];

    % exposure todefensive sectors >=30%
    % exposure to comunication services >=1%
    % exposure to energy >=1%
    A_min=zeros(3,NumAssets);

    A_min(1,index_def)=-1;
    A_min(2,5)=-1;
    A_min(3,8)=-1;
    b_min=[-0.3;-0.05;-0.05];

    % Collect constraints
    A_ineq=[A_min;A_max];
    b_ineq=[b_min;b_max];

    A_eq=zeros(1,NumAssets);
    A_eq(index_def)=1;
    A_eq(index_c)=-1;

    b_eq=0;
end