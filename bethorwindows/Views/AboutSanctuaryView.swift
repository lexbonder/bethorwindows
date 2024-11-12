//
//  IntroductionView.swift
//  bethorwindows
//
//  Created by Alex Reyes-Bonder on 7/18/24.
//

import SwiftUI

struct AboutSanctuaryView: View {
    var body: some View {
        VStack {
            Text("About our Sanctuary")
                .titleGotham()
                .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        
                        Text("""
    \"Beth Or\" is literally translated as \"House of Light\". It was the intention of the architect, the stained glass artist, and the building committee to maintain the theme of \"light\" in the Gitlin Sanctuary.
    
    The bronze words over the ark, taken from Psalms 97:11, exemplify this intention in Hebrew:
""")

                        Text("אור זרע לצדיק ולישרי לב שמחה")
                            .font(.system(size: 18))
                            .fontWeight(.light)
                            .padding(.top, 15)
                        Text("OR ZARU'AH LATZADIK UL'YISHREI LEV SIMCHAH").italic()
                        Text("""
    \"Light is sown for the righteous and gladness for the upright in heart.\"
    
    The \"Ner Tamid\" or \"Eternal Light\" glowing over the ark continues the theme of \"light\" in the sanctuary. Note the solid quartz crystal in the center.

    To the left of the ark (from the viewpoint of the congregation) is the seven branched bronze menorah, also a symbol of light and the recognized symbol of all of Zion and Israel.

    To the right of the ark (from the viewpoint of the congregation) on the wall in the choir loft, is a magnificent tapestry that spells out
    """)
                        Text("\"לדור ודור\"").font(.system(size: 18)).fontWeight(.light)
                        Text("(") + Text("L'DOR VA'DOR").italic() + Text(")")
                        Text("""
    meaning \"From generation to generation.\" This tapestry reminds us of the tagline of our congregation: \"Lighting the path for all generations.\"

    You will also see that every window with the exception of the HOLOCAUST window has the same shade of blue in the background. This is important as the artist wished to emphasize the permanence of the generations of Israel. The representative color which is blue, continues throughout all generations and therefore is shown in all of the windows.
    """)
                    }
                }
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}
