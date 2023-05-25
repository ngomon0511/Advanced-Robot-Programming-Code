clc
close all
clear 
%% Setup initial parameter for Spider Robot
center = [5, 15];
length = 6;
width = 3;
diagonal = sqrt(length^2 + width^2);
h = 1.5;
length1 = 1.2;
length2 = 1.5;
dx = width/2;
dy = length/2;
dxy = 0.5 * diagonal;
dcenter = [dx -dy;
            -dx -dy;
            -dx 0;
            -dx dy;
            dx dy;
            dx 0];
angle = [0 60 120 180 -120 -60];
[servo1, servo2, toe] = coordinateJoint(dxy, dcenter, center, h, length1, length2); % calculate the coordinates of the joints
Draw(servo1, center, h, servo2, toe) % draw robot
%% Make move for robot
for y=0:40
%% Step1
for i=0:5:30
    if (i<=15)
        beta = (i*2)*pi/180;
    else
        beta = (60-i*2)*pi/180;
    end
    k=2;
        angle2 = angle(1,5)/2-i+210;
        alpha = -pi*angle2/180;
        servo2(2,1) = servo1(k,1)+length1*sin(alpha);
        servo2(2,2) = servo1(k,2)+length1*cos(alpha);
        %
        toe(2,:) = servo2(k,:);
        toe(2,1) = toe(k,1)+length2*sin(beta)*sin(alpha);
        toe(2,2) = toe(k,2)+length2*sin(beta)*cos(alpha);
        toe(2,3) = toe(k,3)-length2*cos(beta);
    k=4;
        angle4 = angle(1,4)/2-i;
        alpha = -pi*angle4/180;
        servo2(4,1) = servo1(k,1)+length1*sin(alpha);
        servo2(4,2) = servo1(k,2)+length1*cos(alpha);
        %
        toe(4,:) = servo2(k,:);
        toe(4,1) = toe(k,1)+length2*sin(beta)*sin(alpha);
        toe(4,2) = toe(k,2)+length2*sin(beta)*cos(alpha);
        toe(4,3) = toe(k,3)-length2*cos(beta);
    k=6;
        angle6 = angle(1,6)/2-i-180;
        alpha = pi*angle6/180;
        servo2(6,1) = servo1(k,1)+length1*sin(alpha);
        servo2(6,2) = servo1(k,2)+length1*cos(alpha);
        %
        toe(6,:) = servo2(k,:);
        toe(6,1) = toe(k,1)+length2*sin(beta)*sin(alpha);
        toe(6,2) = toe(k,2)+length2*sin(beta)*cos(alpha);
        toe(6,3) = toe(k,3)-length2*cos(beta);
Draw(servo1, center, h, servo2, toe) % draw robot
end
%% Step 2
center = center+[0 0.2];
[servo1, servo2, toe] = coordinateJoint(dxy, dcenter, center, h, length1, length2); % calculate the coordinates of the joints
Draw(servo1, center, h, servo2, toe) % draw robot
%% Step3
for i=0:5:30
    if (i<=15)
        beta = (i*2)*pi/180;
    else
        beta = (60-i*2)*pi/180;
    end
    k=3;
        angle3 = angle(1,1)/2-i+30;
        alpha = -pi*angle3/180;
        servo2(k,1) = servo1(k,1)+length1*sin(alpha);
        servo2(k,2) = servo1(k,2)+length1*cos(alpha);
        %
        toe(k,:) = servo2(k,:);
        toe(k,1) = toe(k,1)+length2*sin(beta)*sin(alpha);
        toe(k,2) = toe(k,2)+length2*sin(beta)*cos(alpha);
        toe(k,3) = toe(k,3)-length2*cos(beta);
    k=5;
        angle5 = angle(1,2)/2-i;
        alpha = pi*angle5/180;
        servo2(k,1) = servo1(k,1)+length1*sin(alpha);
        servo2(k,2) = servo1(k,2)+length1*cos(alpha);
        %
        toe(k,:) = servo2(k,:);
        toe(k,1) = toe(k,1)+length2*sin(beta)*sin(alpha);
        toe(k,2) = toe(k,2)+length2*sin(beta)*cos(alpha);
        toe(k,3) = toe(k,3)-length2*cos(beta);
    k=1;
        angle1 = angle(1,1)/2-i+90;
        alpha = pi*angle1/180;
        servo2(k,1) = servo1(k,1)+length1*sin(alpha);
        servo2(k,2) = servo1(k,2)+length1*cos(alpha);
        %
        toe(k,:) = servo2(k,:);
        toe(k,1) = toe(k,1)+length2*sin(beta)*sin(alpha);
        toe(k,2) = toe(k,2)+length2*sin(beta)*cos(alpha);
        toe(k,3) = toe(k,3)-length2*cos(beta);
Draw(servo1, center, h, servo2, toe) % draw robot
end
%% Step 4
center = center+[0 0.2];
[servo1, servo2, toe] = coordinateJoint(dxy, dcenter, center, h, length1, length2); % calculate the coordinates of the joints
Draw(servo1, center, h, servo2, toe) % draw robot
end
%% Function: calculate the coordinates of the joints
function  [servo1, servo2, toe] = coordinateJoint(dxy, dcenter, center, h, length1, length2)
% Body joint
servo1 = [];
for i=1:6 
    temp = [servo1; [dcenter(i,:)+center h]];
    servo1 = temp;
end
centerservo1 = servo1(:,1:2);
dservo1 =  dcenter*length1/dxy;
% Thigh joint
servo2 = [];
for i=1:6
    temp = [servo2; [dservo1(i,:)+centerservo1(i,:) h]];
    servo2 = temp;
end     
% Toe joint
toe = [];
for i=1:6
    temp = [toe; servo2(i,1:2) servo2(i,3)-length2];
    toe = temp;
end
end
%% Function: Draw robot
function Draw(servo1, center, h, servo2, toe)
% Draw body
p1 = plot3([servo1(:,1); servo1(1,1)], [servo1(:,2); servo1(1,2)], [servo1(:,3); servo1(1,3)], 'o-black');
p1.LineWidth = 3;
% Draw center
hold on
plot3(center(1), center(2), h, '*-r')
% Draw thigh
for i=1:6
    hold on
    p2 = plot3([servo1(i,1); servo2(i,1)], [servo1(i,2); servo2(i,2)], [servo1(i,3); servo2(i,3)], 'o-b');
    p2.LineWidth = 2;
end
% Draw toe
for i=1:6
    hold on
    p3 = plot3([toe(i,1); servo2(i,1)], [toe(i,2); servo2(i,2)], [toe(i,3); servo2(i,3)], 'x-b');
    p3.LineWidth = 2;
end
% Draw center
hold on
plot3(center(1), center(2), h, '*-r')
%
grid on
axis([-5 15 0 45 0 5]);
set(gca, 'DataAspectRatio',[1 1 1])
pause(.0001);
hold off
end