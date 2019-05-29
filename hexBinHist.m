function [xc, n, v, c] = hexBinHist(dat,nbin,doPlot,eCol,ks,th,bound,rscale)

if nargin<3, doPlot=1; end
if nargin<4, eCol='none'; end
if nargin<5, ks=-1; end
if nargin<6, th=0; end
if nargin<7, bound=Inf; end
if nargin<8, rscale=[min(dat); range(dat)]; end

% Hexagonal grid
% [X Y] = meshgrid(0:(nbin+(1-mod(nbin,2))));
% [X Y] = meshgrid(-2:(nbin+3));
xp = linspace(-1.5,1.5,nbin);
[X, Y] = meshgrid(xp);
n = size(X,1);
X = sqrt(3) / 2 * X;
Yshift = repmat([mean(diff(xp))/2 0],ceil([n,n/2]));
Y = Y + Yshift(:,1:size(Y,2));
% X = X/max(X(:));
% Y = Y/max(Y(:));
% X=X/nbin;
% Y=Y/nbin;
xc = [X(:) Y(:)];
% xc = xc(xc(:,1)>0 & xc(:,1)<1,:);
% xc = xc(xc(:,2)>0 & xc(:,2)<1,:);

% Rescale data
ds = bsxfun(@minus,dat,rscale(1,:));
ds = bsxfun(@rdivide,ds,rscale(2,:));

% Get histogram over the hexagonal bins
[D,I] = pdist2(xc,ds,'euclidean','Smallest',1);
n = histc(I,1:numel(X));

% Kernel smoothing
if ks>0
    D = pdist(xc,'euclidean');
    D = squareform(D);
    D = exp(-D/ks^2/2);
    D = D./sum(D);
    ns = n*D;
    n = ns;
end
n(n<th)=0;

xci = bsxfun(@times,xc,rscale(2,:));
xci = bsxfun(@plus,xci,rscale(1,:));
n(abs(xci(:,2))>bound)=NaN;
xci = xci*[cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)];
n(abs(xci(:,2))>bound)=NaN;
xci = xci*[cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)];
n(abs(xci(:,2))>bound)=NaN;

% Plot hexagonal bins
if doPlot
    cla
    [v,c]=voronoin(xc);
    v = bsxfun(@times,v,rscale(2,:));
    v = bsxfun(@plus,v,rscale(1,:));
    for i = 1:length(c)
        if all(c{i}~=1)&& length(c{i})==6   % closed, hexagonal patches only
            if doPlot==1
                patch(v(c{i},1),v(c{i},2),n(i),'EdgeColor',eCol);
            elseif doPlot==2 && n(i)>0  % in mode 2 don't plot empy bins
                patch(v(c{i},1),v(c{i},2),n(i),'EdgeColor',eCol);
            end
        end
    end
    box off
end