# Bluetooth Device should be defined at the command

width        = '1000px'
labelColor   = '#fff'
usedColor    = '#2f3033'
freeColor    = '#5382da'
bgColor      = '#fff'
bgOpacity    = 0.9

command: "Keyboard.widget/keyboard.sh"

refreshFrequency: 20000

style: """
  border: none
  margin: 0
  padding: 0
  left: 70px
  top: 620px
  width: 1000px
  height: 200px
  
circle.back
    fill: transparent;
    stroke: #{usedColor};
  .circle
    stroke: #{freeColor};
    fill: none;
    stroke-width: 4;
    stroke-linecap: round;
"""


renderInfo: (used, temp) -> """
<svg viewBox="0 0 90 90" width='150' height='250' id="meter1">
  <circle class='back' cx="28" cy="28" r="15.9155" stroke-width="1"/>
  <path class="circle"
    stroke-dasharray="#{temp}, 100"
    d="M18 2.0845
      a 15.9155 15.9155 0 0 1 0 31.831
      a 15.9155 15.9155 0 0 1 0 -31.831"
    transform="translate(10,10)"
    filter="url(#red-glow)"
  />
  <defs>
      <filter id="red-glow" filterUnits="userSpaceOnUse"
              x="-50%" y="-50%" width="100%" height="100%">
         <!-- blur the path at different levels-->
        <feGaussianBlur in="SourceGraphic" stdDeviation="5" result="blur5"/>
        <feGaussianBlur in="SourceGraphic" stdDeviation="5" result="blur10"/>
        <feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur20"/>
        <!-- merge all the blurs except for the first one -->
        <feMerge result="blur-merged">
          <feMergeNode in="blur10"/>
          <feMergeNode in="blur10"/>
        </feMerge>
        <!-- recolour the merged blurs red-->
        <feColorMatrix result="red-blur" in="blur-merged" type="matrix"
                       values="1 0 0 0 0
                               0 0.06 0 0 0
                               0 0 0.44 0 0
                               0 0 0 1 0" />
        <feMerge>
          <feMergeNode in="red-blur"/>       <!-- largest blurs coloured red -->
          <feMergeNode in="blur20"/>          <!-- smallest blur left white -->
          <feMergeNode in="SourceGraphic"/>  <!-- original white text -->
        </feMerge>
      </filter>
    </defs>
<text fill="#fff" font-size="6" font-family="Helvetica Light" x="15" y="55">Keyboard</text>
</svg>
"""

update: (output, domEl) ->
  $(domEl).find('.uptime').html
  $(domEl).html ''
  $(domEl).append @renderInfo(100,parseInt(output))
  $(domEl).append ''
