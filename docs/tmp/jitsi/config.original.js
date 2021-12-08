var config = {
    enableLipSync: false,
    //enableRemb: true,
    //enableTcc: true,
    openSctp: false,
    //disableRtx: true,
    //enableRtpStats: true, // Enables RTP stats processing
    //disableSimulcast: true,

    hosts: {
        domain: 'meet.vpsfree.cz',
        muc: 'conference.meet.vpsfree.cz'
    },

    etherpad_base: 'https://pad.vpsfree.cz/p/',
    //websocket: 'wss://meet.vpsfree.cz/colibri-ws', // FIXME: use xep-0156 for that
    websocket: 'wss://meet.vpsfree.cz/xmpp-websocket/', // FIXME: use xep-0156 for that
    openBridgeChannel: 'websocket', // One of true, 'datachannel', or 'websocket'

    bosh: '//meet.vpsfree.cz/http-bind',

    clientNode: 'http://jitsi.org/jitsimeet',

    testing: {
        enableFirefoxSimulcast: false,
        p2pTestMode: false
    },

    // webrtcIceUdpDisable: false,
    // webrtcIceTcpDisable: true,

    // disableAudioLevels: false,
    startAudioOnly: false,
    startAudioMuted: 50,
    // startWithAudioMuted: false,
    // startSilent: false
    // stereo: false,

    resolution: 720,
    //startBitrate: "800",
    minHDHeight: 540,
    constraints: {
        video: {
            aspectRatio: 16 / 9,
            height: {
                ideal: 640,
                max: 640,
                min: 240
            }
        }
    },
    //enableLayerSuspension: true,
    startVideoMuted: 20,
    // startWithVideoMuted: false,
    // preferH264: true,
    // disableH264: false,

    desktopSharingChromeExtId: 'kglhbbefdnlheedjiejgomgmfplipfeb',
    desktopSharingChromeDisabled: false,
    desktopSharingChromeSources: [ 'screen', 'window', 'tab' ],
    desktopSharingChromeMinExtVersion: '0.1',
    desktopSharingFirefoxDisabled: false,
    desktopSharingFrameRate: {
        min: 5,
        max: 24
    },
    // startScreenSharing: false,

    channelLastN: -1,

    // minParticipants: 2,
    //useStunTurn: true,
    useIPv6: false,

    // useNicks: false,
    // requireDisplayName: true,
    enableWelcomePage: true,
    // enableClosePage: false,
    // disable1On1Mode: false,
    defaultLanguage: 'cs',
    enableUserRolesBasedOnToken: false,
    // enableFeaturesBasedOnToken: false,
    // lockRoomGuestEnabled: false,
    // roomPasswordNumberOfDigits: 10,

    gatherStats: false,
    // enableDisplayNameInStats: false
    // enableEmailInStats: false

    disableThirdPartyRequests: true,
    p2p: {
        enabled: false,
        useStunTurn: true,
        stunServers: [
            { urls: 'stun:meet.vpsfree.cz:5349' }
        ],

        //iceTransportPolicy: 'relay',
        preferH264: true,
        // disableH264: false,
        backToP2PDelay: 90
    },

    analytics: {
    },

    deploymentInfo: {
    },

    e2eping: {
      pingInterval: 1000,
      analyticsInterval: 5000,
    }
};
