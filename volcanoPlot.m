function volcanoPlot(p,FC)

    figure
    hold on
    c = linspace(1,10,length(FC));
    scatter(FC, -log10(p), [],c,'filled')
    maxFC = max(abs(FC));
    axis([-maxFC-0.1,maxFC+0.1,0,7])
    plot([-maxFC-0.1,maxFC+0.1], [-log10(0.05),-log10(0.05)], 'k')
    xlabel('fold change')
    ylabel('-log_{10} p-value')
    hold off