clc;clear;
s=tf('s');

tf_motor = 1;
%c = motor constant decided by estimation or knowing back emf constant,
%    torque constant etc
%tf_motor = 1/(1+s*c); 

inertia_w = 1 ; %inertia of wheel in 1 axis
tf_wheel = 1/(inertia_w*s^2);

loop_inner = feedback(tf_motor*tf_wheel,s);
controller1 = pidtune(loop_inner,'PD');

loop_outer = feedback(loop_inner*controller1,1);
controller2 = pidtune(loop_outer,'PI');

figure(1);rlocus(loop_inner); %inner loop rlocus
figure(2);rlocus(loop_outer); %outer loop rlocus

figure(3);step(loop_outer); %reference tracking?

