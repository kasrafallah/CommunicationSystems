%%
%part_a
clc;
clear;
s = linspace(-100,100,10000);
TEST = sin(2*pi*s+pi/3);%a vector for test hilbetri function
figure;
plot(s,TEST)
hold on;
plot(s,hilberti(TEST))
xlim([0,5])
title('hilbert func test')
legend('test','hilbert test')
%%
%part_b
clc;
clear;
w_0=150;
f = linspace(-1000,1000,40000);
X = (((heaviside(f+w_0)-heaviside(f+w_0/2)).*(2/w_0).*(f+w_0))...
    +(heaviside(f+w_0/2)-heaviside(f-w_0/2))...
    +(heaviside(f-w_0/2)-heaviside(f-w_0)).*(-2/w_0).*(f-w_0));%furier trasnsform of X
k=0;
x=zeros(1,40001);
for t=-10:0.0005:10 % find X(t)
    k=k+1;
    x(k)=sum(X.*exp(j*2*pi*f.*t))/20;
    
end
figure;
plot(f,X)
t=-10:0.0005:10;
sin_2pif = sin(2*pi*400*t);%sinusal vector
cos_2pif = cos(2*pi*400*t);%cosine vector
x1=x.*sin_2pif;%define system
x2=hilberti(x);
x3=hilberti(x1);
x4=x2.*sin_2pif;
x5=x4-x3;
x6=x5*2.*cos_2pif;
k=0;
for f=-1000:0.5:1000 %find X1(f)
    k=k+1;
    X1(k)=trapz(t,x1.*exp(-j*2*pi*f.*t));
end
f=-1000:0.5:1000;
hold on;
plot(f,abs(X1));
k=0;
for f=-1000:0.5:1000 %find X2(f)
    k=k+1;
    X2(k)=trapz(t,x2.*exp(-j*2*pi*f.*t));
    
end
f=-1000:0.5:1000;
hold on;
plot(f,abs(X2));
k=0;
for f=-1000:0.5:1000 %find X3(f)
    k=k+1;
    X3(k)=trapz(t,x3.*exp(-j*2*pi*f.*t));
end
f=-1000:0.5:1000;
hold on;
plot(f,abs(X3));
k=0;
for f=-1000:0.5:1000 %find X4(f)
    k=k+1;
    X4(k)=trapz(t,x4.*exp(-j*2*pi*f.*t));  
end
f=-1000:0.5:1000;
hold on;
plot(f,abs(X4));
k=0;
for f=-1000:0.5:1000 %find X5(f)
    k=k+1;
    X5(k)=trapz(t,x5.*exp(-j*2*pi*f.*t));
    
end
f=-1000:0.5:1000;
hold on;
plot(f,abs(X5));
k=0;
for f=-1000:0.5:1000 %find X6(f)
    k=k+1;
    X6(k)=trapz(t,x6.*exp(-j*2*pi*f.*t));
    
end
f=-1000:0.5:1000;
hold on;
plot(f,abs(X6));
X7 = X6.*(heaviside(f-w_0)-heaviside(f+w_0));
hold on;
plot(f,abs(X7));
grid on; grid minor;
legend('X','|X1|','|X2|','|X3|','|X4|','|X5|','|X6|','|X7|')

%seperate graph with sub plot
figure;
subplot(2,4,1);
plot(f,abs(X1));
title('|X1|');
grid on; grid minor;
subplot(2,4,2);
plot(f,abs(X2));
title('|X2|');
grid on; grid minor;
subplot(2,4,3);
plot(f,abs(X3));
title('|X3|');
grid on; grid minor;
subplot(2,4,4);
plot(f,abs(X4));
title('|X4|');
grid on; grid minor;
subplot(2,4,5);
plot(f,abs(X5));
title('|X5|');
grid on; grid minor;
subplot(2,4,6);
plot(f,abs(X6));
title('|X6|');
grid on; grid minor;
subplot(2,4,7);
plot(f,abs(X7));
title('|X7|');
grid on; grid minor;
function z=hilberti(x)
t = linspace(-100,100,100000);
h=(1./(pi*t));
z=conv(x,h,'same')/500;
end