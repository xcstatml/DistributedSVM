function [  ] = plot_svm( x , y , b )
% INPUTS:
% x: n by p covariate matrix
% y: n by 1 label vector, each element should be 1 or -1
% b: the estimated SVM coefficient

d = [2,3];

scatter(x(:,d(1)),x(:,d(2)),10,y>0);
xlimits = get(gca,'XLim');
ylimits = get(gca,'YLim');
hold on
plot([-100,100],[-(b(1)-100*b(d(1)))/b(d(2)),-(b(1)+100*b(d(1)))/b(d(2))],'LineWidth',2);
xlim(xlimits)
ylim(ylimits)
lab = (x*b>0)*2-1;
acc = mean(lab==y)*100;
text(0.5,0.9,['error=',num2str(100-acc),'%'],'Units','normalized','FontSize',20);
hold off
end

