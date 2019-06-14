function [xc, n, v, c] = hexBinHist(dat,nbin,doPlot,eCol,ks,th,bound,rscale)

if nargin<3, doPlot=1; end
if nargin<4, eCol='none'; end
if nargin<5, ks=-1; end
if nargin<6, th=0; end
if nargin<7, bound=Inf; end
if nargin<8, rscale=[min(dat); range(dat)]; end

% Hexagonal grid
xp = linspace(-1.5,1.5,4*nbin-1);
[X, Y] = meshgrid(xp);
n = size(X,1);
X = sqrt(3) / 2 * X;
Yshift = repmat([mean(diff(xp))/2 0],ceil([n,n/2]));
Y = Y + Yshift(:,1:size(Y,2));
xc = [X(:) Y(:)];
xc = xc*[cos(pi/6) -sin(pi/6); sin(pi/6) cos(pi/6)];

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
n(abs(xci(:,2))>bound+eps)=NaN;
xci = xci*[cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)];
n(abs(xci(:,2))>bound+eps)=NaN;
xci = xci*[cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)];
n(abs(xci(:,2))>bound+eps)=NaN;

% Plot hexagonal bins
if doPlot
    cla
    [v,c]=voronoin(xc);
    v = bsxfun(@times,v,rscale(2,:));
    v = bsxfun(@plus,v,rscale(1,:));
    if doPlot==1
        selected_hexes = cellfun(@length,c)==6;
    elseif doPlot==2
        selected_hexes = cellfun(@length,c)==6 & n>0;
    end
    pts = cell2mat(c(selected_hexes));
    xm = reshape(v(pts(:),1),size(pts));
    ym = reshape(v(pts(:),2),size(pts));
    patch(xm',ym',n(selected_hexes),'EdgeColor',eCol)
        box off
end