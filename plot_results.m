close all;
[xd, dxd, ddxd] = reference_trajectory(out.t);

figure;
plot(out.t,xd,'r--',out.t,out.y(:,2),'b','linewidth',3);
legend('Ideal position signal','Position tracking');
xlabel('time(s)');ylabel('Angle response');
xlim([0 10]); %Các giá trị hiển thị trên trục x nằm trong [0;10]
ylim([-0.15 0.15]); %Các giá trị hiển thị trên trục y nằm trong [-0.15;0.15]
xticks(9:1:10); %Đánh dấu các điểm sẽ hiển thị trên trục x
yticks(-0.15:0.05:0.15); %Đánh dấu các điểm sẽ hiển thị trên trục y
set (gca, 'FontName', 'Times New Roman', 'FontSize', 20, 'LineWidth', 2); %Chinh Font chữ
grid on;

figure;
plot(out.t,dxd,'r--',out.t,out.y(:,3),'b','linewidth',3);
legend('Ideal speed signal','Speed tracking');
xlabel('time(s)');ylabel('Angle speed response');
grid on;

figure(2);
plot(out.t,out.u(:,1),'k','linewidth',0.01);
xlabel('time(s)');ylabel('Control input');grid on;

figure(3);
plot(out.e,out.de,'r',out.e,-pms.lambda'.*out.e,'k','linewidth',2);
xlabel('e');ylabel('de');
legend('s change','s=0');
title('phase trajectory');grid on;
