function snowflake_annotate(L)

% Boundary box
bcol='k';
line([-L/sqrt(3) L/sqrt(3)],[L L],'Color',bcol)
line([-L/sqrt(3) L/sqrt(3)],-[L L],'Color',bcol)
line([-L*2/sqrt(3) -L/sqrt(3)],[0 L],'Color',bcol)
line([-L*2/sqrt(3) -L/sqrt(3)],[0 -L],'Color',bcol)
line([L/sqrt(3) L*2/sqrt(3)],[L 0],'Color',bcol)
line([L/sqrt(3) L*2/sqrt(3)],[-L 0],'Color',bcol)

% Grid
gcol=lines(2); gcol=gcol(2,:);
line([-L*2/sqrt(3) L*2/sqrt(3)],[0 0],'Color',gcol)
line([-L/sqrt(3) L/sqrt(3)],[-L L],'Color',gcol)
line([-L/sqrt(3) L/sqrt(3)],[L -L],'Color',gcol)

% Text
text(-L/sqrt(3),L,'A=C ','HorizontalAlignment','right')
text(L/sqrt(3),L,' C=B','HorizontalAlignment','left')
text(L*2/sqrt(3),0,' B=A','HorizontalAlignment','left')

% Scale bar
line([L L*1.2],[-L -L],'LineWidth',4,'Color','k')
text(L*1.1,-1.1*L,num2str(L*.2),'HorizontalAlignment','center')