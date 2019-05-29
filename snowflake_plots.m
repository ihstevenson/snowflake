

A = cumsum(exprnd(1,[1000,1]));
B = cumsum(exprnd(1,[1000,1]));
C = cumsum(exprnd(1,[1000,1]));
C = sort(B+randn(size(B))/50);

L = 1;
[xy,trips]=snowflake(A,B,C,L);
%%

figure(1)

%%%%%% Dot plot
subplot(1,3,1)
plot(xy(:,1),xy(:,2),'.')
axis equal
xlim([-1 1]*L*2.5/sqrt(3))
ylim([-1 1]*L*2.1/sqrt(3))
box off; set(gca,'TickDir','out')
snowflake_annotate(L)


%%%%%% Hexagonal histogram (no smoothing)
subplot(1,3,2)
% [xc, n, v, c] = hexBinHist(xy,35,1,'none',-1,0,Inf,[-L*2/sqrt(3) -L; L*4/sqrt(3) L*4/sqrt(3)]);
[xc, n, v, c] = hexBinHist(xy,4*20-1,1,'none',-1,0,L*1.01,[0 0; L*2/sqrt(3) L*2/sqrt(3)]);
axis equal
xlim([-1 1]*L*2.5/sqrt(3))
ylim([-1 1]*L*2.1/sqrt(3))
box off; set(gca,'TickDir','out')
set(gca,'Colormap',parula)
colorbar
snowflake_annotate(L)
cl=get(gca,'CLim');

%%%%%% Hexagonal histogram (smoothing)
subplot(1,3,3)
% [xc, n, v, c] = hexBinHist(xy,8,1,'none',.1,0,L,[-L*2/sqrt(3) -L*2/sqrt(3); L*4/sqrt(3) L*4/sqrt(3)]);
[xc, n, v, c] = hexBinHist(xy,4*20-1,1,'none',.09,0,L,[0 0; L*2/sqrt(3) L*2/sqrt(3)]);
axis equal
xlim([-1 1]*L*2.5/sqrt(3))
ylim([-1 1]*L*2.1/sqrt(3))
box off; set(gca,'TickDir','out')
set(gca,'Colormap',parula)
colorbar
snowflake_annotate(L)
set(gca,'CLim',cl)