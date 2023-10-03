close
clear

% Constants
f0 = 10e9;      % Center frequency (10 GHz)
t0 = 10e-9;     % Pulse duration (10 ns)
z = 10e-2;      % Propagation distance (10 cm)
c = 3e8;        % Speed of light

% Time and frequency vectors
Fs = 10 * f0;   % Sampling frequency
dt = 1 / Fs;    % Time step
t = -5 * t0 : dt : 5 * t0 - dt;
N = length(t);
df = Fs / N;
f = -Fs/2 : df : Fs/2 - df;

% Create Gaussian pulse
pulse = exp(-t.^2 / t0^2);

% Modulate the pulse
modulated_pulse = pulse .* exp(1i * 2 * pi * f0 * t);

% Propagate the pulse
beta = sqrt(1 - (2 * pi * f / c).^2);
modulated_pulse_z = fftshift(ifft(fftshift(modulated_pulse)) .* exp(-1i * beta * z));

% Plot the pulse shape at z = 10 cm
figure;
plot(t, abs(modulated_pulse_z).^2);
xlabel('Time (s)');
ylabel('Power');
title('Pulse Shape at z = 10 cm');

% Calculate the time it takes for the pulse shape to change significantly
group_delay = -diff(unwrap(angle(modulated_pulse_z))) / (2 * pi * df);
significant_change_time = max(group_delay);

fprintf('The pulse shape changes significantly after %.2f seconds.\n', significant_change_time);

%%
fc = 6.56e9;
Fs=5e10;
t=-50e-9:1/Fs:50e-9;
%%
%create pulse
pulse=zeros(1,length(t));
for i=2250:1:2750
    pulse(1,i)=1;
end
plot(t,pulse)
ylim([-1,2])
xlabel('time')
title('10 ns pulse')
%%      
%modulate the pulse
w0=10e9*2*pi;
mpulse=exp(1i*w0*t).*pulse;
%%
%take fft of modulated pulse
fftpulse=fft(mpulse);
L=length(pulse);
f = Fs*(0:floor((L))-1)/L;
plot(f,abs(fftpulse))
xlabel('frequency')
title('fft of the modulated pulse')
%%
%cancel frequancies below cutoff
for i=1:length(f)
    if (f(i)<fc)
        fftpulse(i)=0;

    end
end
figure
plot(f,abs(fftpulse))
%%
m=1;
for i=1:length(f)
    if (fftpulse(i)==0)
        m=m+1;
    else
        break
    end
end
f2=f(m:end);
fftpulse2=fftpulse(m:end);
%calculating propogation constants
beta=sqrt(1-(fc./f2).^2);
%shape of pulse in z=10
z=1000;
for i=1:length(fftpulse2)
    fftpulse2(i)=fftpulse2(i).*exp(-1i*z*beta(i));
end

%calculate ifft to find the result signal
fftpulse3=zeros(1,L);
fftpulse3(m:end)=fftpulse2;

figure
plot(f,abs(fftpulse3))

%%
%calculate ifft to find the result signal
disppulse=ifft(fftpulse3);
disppulse2=disppulse.*exp(-1i*w0*t);
plot(t,abs(real(disppulse2)))
