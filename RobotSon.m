R = 100;
b = 10;
p = 3;

for t=0:0.1:100*pi
    x=(R-b)*cos(t);
    y=(R-b)*sin(t);
    z=p*t;
    
    t1 = atan2(-x,y);
    l2 = sqrt(x^2+y^2);
    
    px = -l2*sin(t1);
    py = l2*cos(t1);
    pz = z;
    k1=plot3([0 0 px],[0 0 py],[0 pz pz],'Color','blue');
    hold on;
    plot3(px,py,z,'*');
    hold on;
    axis([-100 100 -100 100 0 300]);
    pause(0.1);
    delete(k1);
    
end