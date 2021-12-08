var config =
{
  "hosts": {
    "domain": "meet.marnov.cz",
    "muc": "conference.meet.marnov.cz",
    "focus": "focus.meet.marnov.cz"
  },


  "bosh": "//meet.marnov.cz/http-bind",
  "clientNode": "http://jitsi.org/jitsimeet",

  "testing": {
    "p2pTestMode": false
  },


  "enableNoAudioDetection": true,
  "enableNoisyMicDetection": true,
  "channelLastN": -1,
  "enableWelcomePage": true,


  "p2p": {
    "enabled": true,

    "stunServers": [
      {
        "urls": "stun:meet-jit-si-turnrelay.jitsi.net:443"
      }
    ]
  },
  "analytics": {},
  "deploymentInfo": {},
  "makeJsonParserHappy": "even if last key had a trailing comma",
  "websocket": "wss://meet.marnov.cz/xmpp-websocket"
}
;

