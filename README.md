# Inter-Symbol Interference due to band limited channels
The band-limited channel only allows a limited range of frequency components to pass, while blocking frequency components outside this range. We investigate the simplest of
such channels: a channel that has a flat response in the allowable range.
Figure 1 shows the system that we will consider.

![image](https://user-images.githubusercontent.com/46444593/113660739-0f931600-96a5-11eb-8b22-57c0a95011c5.png)

The channel obviously limits the kind of signals that can pass unchanged through the channel, because if a signal has frequency components that are outside the allowable range of the channel, these components will not pass and therefore the output signal from the channel will be changed from the input signal. This issue will face the most common of signals that we use to represent bits: the square signal!

band-limited channel with a band 𝑩 = 𝟏𝟎𝟎 𝒌𝑯𝒛, square pulse of duration 𝑻 = 𝟐/𝑩
If there are multiple square signals after each other (one square signal for each bit), these leaked parts will interfere with the signals of other bits. This phenomenon is called Inter-Symbol Interference (ISI).

![image](https://user-images.githubusercontent.com/46444593/113661033-a52ea580-96a5-11eb-9864-f29bb96b215c.png)

ISI can negatively affect the detection performance of multiple consecutive signals. To combat the effect of ISI in band-limited channels, one cannot use square pulses anymore. Instead, there are other pulse shapes that are better such as sinc function

# Output of the matlab code
![image](https://user-images.githubusercontent.com/46444593/113661593-b5935000-96a6-11eb-836b-64cf6fc3dfbe.png)
![image](https://user-images.githubusercontent.com/46444593/113661639-c5129900-96a6-11eb-8110-4eadc0cd8851.png)
![image](https://user-images.githubusercontent.com/46444593/113661674-d22f8800-96a6-11eb-9279-d3887ea60705.png)
![image](https://user-images.githubusercontent.com/46444593/113661699-de1b4a00-96a6-11eb-8977-bcaa85759520.png)

