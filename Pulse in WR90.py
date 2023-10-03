import numpy as np
import matplotlib.pyplot as plt

fc = 6.56e9
Fs = 5e10
t = np.arange(-50e-9, 50e-9, 1/Fs)

# Create pulse
pulse = np.zeros(len(t))
pulse[2250:2750] = 1

plt.plot(t, pulse)
plt.ylim([-1, 2])
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.title('10 ns Pulse')

# Modulate the pulse
w0 = 10e9 * 2 * np.pi
mpulse = np.exp(1j * w0 * t) * pulse

# Take FFT of modulated pulse
fftpulse = np.fft.fft(mpulse)
L = len(pulse)
f = Fs * np.arange(0, np.floor(L)) / L

plt.figure()
plt.plot(f, np.abs(fftpulse))
plt.xlabel('Frequency')
plt.ylabel('Magnitude')
plt.title('FFT of the Modulated Pulse')

# Cancel frequencies below cutoff
fftpulse[~(f >= fc)] = 0

plt.figure()
plt.plot(f, np.abs(fftpulse))
plt.xlabel('Frequency')
plt.ylabel('Magnitude')
plt.title('FFT after Cutoff')

m = np.where(fftpulse != 0)[0][0]
f2 = f[m:]
fftpulse2 = fftpulse[m:]

# Calculate propagation constants
beta = np.sqrt(1 - (fc / f2) ** 2)

# Shape of pulse at z=10
z = 1000
fftpulse2 *= np.exp(-1j * z * beta)

# Calculate IFFT to find the result signal
fftpulse3 = np.zeros(L, dtype=complex)
fftpulse3[m:] = fftpulse2

plt.figure()
plt.plot(f, np.abs(fftpulse3))
plt.xlabel('Frequency')
plt.ylabel('Magnitude')
plt.title('Modified FFT')

# Calculate IFFT to find the result signal
disppulse = np.fft.ifft(fftpulse3)
disppulse2 = disppulse * np.exp(-1j * w0 * t)

plt.figure()
plt.plot(t, np.abs(np.real(disppulse2)))
plt.xlabel('Time')
plt.ylabel('Amplitude')
plt.title('Resulting Signal')

# Set same x-axis limits for figures 2, 3, and 4 as figure 5
fig2, fig3, fig4 = plt.gcf(), plt.gcf(), plt.gcf()
axes2, axes3, axes4 = fig2.get_axes(), fig3.get_axes(), fig4.get_axes()
axes2[0].set_xlim([-5e-8, 5e-8])
axes3[0].set_xlim([-5e-8, 5e-8])
axes4[0].set_xlim([-5e-8, 5e-8])

plt.show()
