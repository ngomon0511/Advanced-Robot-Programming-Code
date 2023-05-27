clc
close all
clear

l1 = 50;
l2 = 30;

while(true)
    for theta1 = pi/4 : 0.05 : pi/2
        for theta2 = pi/6 : 0.05 : pi
            x1 = 0;
            y1 = 0;
            
            x2 = l1 * cos(theta1);
            y2 = l1 * sin(theta1);
            
            x3 = x2 + l2 * cos(theta2);
            y3 = y2 + l2 * sin(theta2);
            
            line1 = line([x1, x2], [y1, y2], color='blue');
            line2 = line([x2, x3], [y2, y3], color='blue');
            
            plot(x3, y3, '.r');

            pause(0.01);
            
            delete(line1)
            delete(line2)

            axis([-50 100 0 100]);
            hold on
        end
    end
end
