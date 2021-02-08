function PlotHandle=Plot_CDFPlane3D(CDFs,CorrespondingVector)
%Input nx1 Cell including one CDF per cell where n is the number of CDFs.
%the CDF is a kx2 matrix k is the number of entries. the first and the second column i
% are the actral entries and the corresponding cumulative probablility


    nCDFs=size(CorrespondingVector,1);
    xDim=nCDFs;
    yDim=NaN;
    for iCDF=1:nCDFs
            yDim=max(size(CDFs{iCDF,1},1),yDim);
    end

    % x Matrix
    xMatrix=(CorrespondingVector.*ones(1,yDim));

    %Zmatrix
    zmin=0;
    zmax=1;
    zVector=(zmin:(zmax-zmin)/(yDim-1):zmax)';
    zMatrix=(zVector.*ones(1,xDim))';
    
    %Ymatrix
    yMatrix=NaN(xDim,yDim);
    for iCDF=1:nCDFs
        F = griddedInterpolant(CDFs{iCDF,1} (:,2),CDFs{iCDF,1}(:,1),'nearest');
        yVector=F(zVector);
        yMatrix(iCDF,:)=yVector';

    end
    
    %plot
    s= surf(xMatrix,yMatrix,zMatrix);
    s.EdgeColor = 'r';
    s.FaceAlpha=0.3;
    PlotHandle=s;
end
