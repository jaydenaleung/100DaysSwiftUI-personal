//
//  ContentView.swift
//  Africa
//
//  Created by Student on 9/18/24.
//

import SwiftUI

// Hex code functionality for Color(hex: String)
extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        print(cleanHexCode)
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}


struct creditsView: View {
    
    var body: some View {
        
        VStack {
            Text("Credits")
                .font(.custom(
                    "Georgia",
                    fixedSize: 46))
                .bold()
                .foregroundStyle(.white)
                .padding()
            
            Text("""
                Developer: Jayden Leung
                
                Teacher: Mr. Toussaint
                Class: Global History II - The Atlantic World, Section 6
                
                Due Date of Project: Monday, Sept. 23, 2024
                
                ---
                
                Developing IDE: Xcode
                Language: Swift, SwiftUI
                
                ---
                
                Sources from Textbook, Class Documents
                Images from maps.google.com, worldhistory.org, khanacademy.org, theafricanhistory.com, britannica.com
                """)
                .font(.custom(
                    "Georgia",
                    fixedSize: 22))
                .foregroundStyle(.white)
                .padding()
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 20)
        .background(Image("mansa-musa-of-the-mali-empire-10128").resizable().scaledToFill().ignoresSafeArea().opacity(0.7))
        .background(.black)
        
    }
    
}

struct overviewView: View {
    
    let ghanaBKG = Image("259b1d5b524ee09a66a0dc9a540473167552b17b")
    let maliBKG = Image("Musa-I-of-Mali-Great-Mosque-Timbuktu-1327")
    let songhaiBKG = Image("tomb-of-askia-mohammad-i-gao-10160")
    
    var body: some View {
                
        VStack {
            Text("Overview")
                .font(.custom(
                    "Georgia",
                    fixedSize: 46))
                .bold()
                .foregroundStyle(.white)
                .padding(30)
            
            ScrollView {
                VStack {
                            
                    // Ghana
                    
                    ExpandableView(thumbnail: ThumbnailView(content: {
                        
                        VStack {
                            Text("Ghana Empire (Kingdom of Ghana)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMTBold", size: 20))
                        }
                        .padding()
                        
                    }), expanded: ExpandedView(content: {
                        
                        VStack {
                            Text("Ghana Empire (Kingdom of Ghana)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.bottom, 10)
                            
                            Text("""
                                Existing longer than both the Mali and Songhai Empires combined, the Kingdom of Ghana (Ghana Empire) was founded by the Soninke people and was a wealthy and prosperous kingdom. Ghana was located in an optimal location, surrounded by resources. North of it lay the salt mines, south of it lay the gold mines, and next to it was the Niger River. By mining for natural resources and taxing anyone who entered or left the boundaries of the kingdom, the king grew very wealthy. A Muslim historian from Spain, al-Bakri, wrote in 1057 that the Ghana, or ruler, most likely Ghana Bassi, also retained all gold nuggets, taxed one golden dinar for imports and two for exports, and had as many as two hundred thousand soldiers. Ghana effectively established a monopoly over the salt and gold trade due to its prosperous location and used it to gain influence outside the nation. Additionally, we know from al-Bakri that Ghana’s capital, Koumbi-Saleh, is a split city with a Muslim section and the section of the king, who practices a polytheistic African religion. Eventually, the son of the king of the Malinke people, under the Kingdom of Ghana, overthrew his father and established the Mali Empire.
                                """)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMT", size: 14))
                            
                            Spacer()
                        }
                        .padding()
                        .background(ghanaBKG.resizable().scaledToFill().opacity(0.75))
                        .background(.black)
                        
                    }))
                    
                    
                    // Mali
                    
                    ExpandableView(thumbnail: ThumbnailView(content: {
                        
                        VStack {
                            Text("Mali Empire")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMTBold", size: 20))
                        }
                        .padding()
                        
                    }), expanded: ExpandedView(content: {
                        
                        VStack {
                            Text("Mali Empire")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.bottom, 10)
                            
                            Text("""
                                The Mali Empire lasted 230 years, founded around the year 1230 by Sundiata Keita of the Malinke people, who had overthrown his father, the king of a section of the Kingdom of Ghana. He later converted to Islam. Encompassing a massive amount of land, the Mali Empire was prosperous and had much global influence, mainly because of Mansa Musa’s generous pilgrimage to Mecca. A Mansa, or ruler, of Mali, Mansa Musa gave out a lot of gold to the people and king of Egypt, solidifying ties with them and attracting traders and travelers from across Africa and the world to Mali. Though gifting was meant to be in private, Mansa Musa certainly succeeded in bringing global fame and prosperity to the Mali Empire. However, difficulties with ruling and succession in Mali in the 1400s caused it to decline, and it was conquered by the Songhai people in the 1460s, led by Sunni Ali.
                                """)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMT", size: 14))
                            
                            Spacer()
                        }
                        .padding()
                        .background(maliBKG.resizable().scaledToFill().opacity(0.75))
                        .background(.black)
                        
                    }))
                    
                    
                    // Songhai
                    
                    ExpandableView(thumbnail: ThumbnailView(content: {
                        
                        VStack {
                            Text("Songhai Empire")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMTBold", size: 20))
                        }
                        .padding()
                        
                    }), expanded: ExpandedView(content: {
                        
                        VStack {
                            Text("Songhai Empire")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMTBold", size: 20))
                                .padding(.bottom, 10)
                            
                            Text("""
                                Originating from the Songhai people, the Songhai Empire was formed when Sunni Ali led his army into the Mali Empire and conquered it in the 1460s. With its capital as Gao, Sunni Ali was known for his military prowess from gaining global influence through many successful conquests and was the first to use a navy on the Niger River. Among the places he conquered was Timbuktu, though he treated the Muslims there poorly. Askia Muhammad the Great succeeded him after his death and was known to support Islam, showing lavishness on his pilgrimage to Mecca like Mansa Musa did. During his rule, he mandated Islam across the Empire, though most people were found to still be practicing their own religions. However, Timbuktu became a global center of scholars and Islamic study, and the Songhai Empire also grew to prosperity through trading salt and gold, similar to the Kingdom of Ghana. Muhammad demonstrated strength in battle by defending his natural resources and showed astuteness by establishing a bureaucracy and provincial rule in hopes of avoiding a similar downfall to Mali. Its downfall came instead in 1591 through Morocco’s use of guns and novel military technology.
                                """)
                                .foregroundStyle(.white)
                                .font(.custom("ArialRoundedMT", size: 14))
                            
                            Spacer()
                        }
                        .padding()
                        .background(songhaiBKG.resizable().scaledToFill().opacity(0.75))
                        .background(.black)
                        
                    }))
                    
                    
                    
                }
            }
            .padding()
        }
        .scrollIndicators(.never)
        .background(Image("mansa-musa-of-the-mali-empire-10128").resizable().scaledToFill().ignoresSafeArea().opacity(0.7))
        .background(.black)
    }
}

struct compareView: View {
    @State private var panel1 = panelView(title: "Click on an Empire to Compare", overviewBody: "", rulersBody: "", wealthBody: "", color: LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom))
    @State private var panel2 = panelView(title: "Click on an Empire to Compare", overviewBody: "", rulersBody: "", wealthBody: "", color: LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom))
    
    
    let ghanaComparative = panelView(title: "Ghana Empire", overviewBody: """
                                •Period: ~500–1075 CE, ~575 years
                                •Location: Modern-day Southeast Mauritania
                                •Succeeded/created from: Soninke people
                                •Preceded: Mali Empire
                                •State religion: Rulers practiced a polytheistic African religion, but capital includes a Muslim section

        """, rulersBody: """
                                •Ghana Bassi - described in al-Bakri’s Roads and Kingdoms (published 1057) as heavily adorned with gold and very wealthy from retaining all the gold nuggets in the area, following a polytheistic African religion
        """, wealthBody: """
                                •Location optimal for natural resources and trade
                                •Monopoly over salt and gold trade
                                •Taxed anyone who entered or left the Kingdom of Ghana, including the many traveling across the Niger River
                                •King was very rich and prosperous
        """, color: LinearGradient(gradient: Gradient(colors: [Color(hex: "EDAE48"), Color(hex: "D1495B")]), startPoint: .topLeading, endPoint: .bottomTrailing))
    
    let maliComparative = panelView(title: "Mali Empire", overviewBody: """
                                •Period: ~1230-1460 CE, ~230 years
                                •Location: Modern-day Senegal, The Gambia, Guinea, Mali, Burkina Faso, Niger, Nigeria, Benin
                                •Succeeded/created from: Malinke people, Ghana Empire
                                •Preceded: Songhai Empire
                                •State religion: Rulers practiced Islam, but was not mandated
        """, rulersBody: """
                                •Sundiata Keita - the founder and first Mansa of the Mali Empire, born disabled but allegedly healed by a blacksmith/magician
                                •Mansa Musa - A famous Mansa who is known for his famous, generous, and pious pilgrimage to Mecca, where he brought many people and a great sum of money that he spent gifting to the Egyptian king, administrators, and people in order to attract traders and travelers to Mali and further increase its wealth
        """, wealthBody: """
                                •Reputation was greatly influenced by Mansa Musa’s generous gifting during his pilgrimage to Mecca
                                •Gifting attracted traders across the world and formed bonds with Egypt
                                •Mansa Musa’s investment set Mali up for economic prosperity
        """, color: LinearGradient(gradient: Gradient(colors: [Color(hex: "7FB7BE"), Color(hex: "D2F3EE")]), startPoint: .topLeading, endPoint: .bottomTrailing))
    
    let songhaiComparative = panelView(title: "Songhai Empire", overviewBody: """
                                •Period: ~1460-1591 CE, ~131 years
                                •Location: Modern-day Mali, Niger
                                •Succeeded/created from: Songhai people, Mali Empire
                                •Preceded: Morocco
                                •State religion: Islam mandated, but many people kept practicing local African religions or religious syncretism
        """, rulersBody: """
                                •Sunni Ali - the first ruler of the Songhai Empire and leader of the army that took down the Mali Empire; described as a cruel tyrant as well as a great military conqueror in different accounts
                                •Askia Muhammad the Great - ruler after Sunni Ali and known as “a great supporter of Islam”, mandated Islam and made a great and lavish pilgrimage to Mecca in the footsteps of Mansa Musa
        """, wealthBody: """
                                •Gained much land and international influence through military conquering by Sunni Ali
                                •Global influence through Timbuktu as a scholarly center of education and study, as well as many trading opportunities at the city
                                •Rich salt and gold mines allowed the empire to flourish
                                •Songhai Empire likely more well known after Muhammad’s great pilgrimage to Mecca, like Mansa Musa’s
        """, color: LinearGradient(gradient: Gradient(colors: [Color(hex: "EEBBD5"), Color(hex: "2F284E")]), startPoint: .topLeading, endPoint: .bottomTrailing))
    
    
    var body: some View {
        VStack {
            
            Text("Compare")
                .font(.custom(
                    "Georgia",
                    fixedSize: 46))
                .bold()
                .foregroundStyle(.white)
                .padding()
            
            HStack {
                
                Button("Ghana") { 
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        panel2 = panel1
                        panel1 = ghanaComparative
                    }
                }
                    .frame(maxWidth: 200, maxHeight: 50)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 15))
                    .foregroundStyle(.white)
                    .font(.custom("ArialRoundedMTBold", size: 20))
                
                Button("Mali") {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        panel2 = panel1
                        panel1 = maliComparative
                    }
                }
                    .frame(maxWidth: 200, maxHeight: 50)
                    .background(.red)
                    .clipShape(.rect(cornerRadius: 15))
                    .foregroundStyle(.white)
                    .font(.custom("ArialRoundedMTBold", size: 20))
                
                Button("Songhai") {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        panel2 = panel1
                        panel1 = songhaiComparative
                    }
                }
                    .frame(maxWidth: 200, maxHeight: 50)
                    .background(.orange)
                    .clipShape(.rect(cornerRadius: 15))
                    .foregroundStyle(.white)
                    .font(.custom("ArialRoundedMTBold", size: 20))
            }
            .padding()
            
            HStack {
                panel1
                panel2
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
        }
        .background(Image("mansa-musa-of-the-mali-empire-10128").resizable().scaledToFill().ignoresSafeArea().opacity(0.7))
        .background(.black)
    }
}

struct panelView: View {
    let title: String
    let overviewBody: String
    let rulersBody: String
    let wealthBody: String
    
    let color: LinearGradient
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text(title)
                    .bold()
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                
                Text("Overview")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .italic()
                
                Text(overviewBody)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 15)
                
                Text("Important Rulers")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .italic()
                
                Text(rulersBody)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 15)
                
                Text("Global Influence and Wealth")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .italic()
                
                Text(wealthBody)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 15)
                
            }
            .padding(15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(color)
        .clipShape(.rect(cornerRadius: 15))
        .foregroundStyle(.white)
        .font(.custom("Arial", size: 20))
        .scrollIndicators(.hidden)
    }
}

struct mapView: View {
    
    @State private var mapDestination = "African Empires Today Superimposed"
    
    var body: some View {
        Image(mapDestination)
            .resizable()
            .ignoresSafeArea()
    }
}

struct ContentView: View {
    
    @State private var title = "African Empires in the Second Millenium"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("")
                    .padding(10)
                
                Text(title)
                    .font(.custom(
                            "AutumnFlowersRegular",
                            fixedSize: 60))
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: 340, maxHeight: .infinity, alignment: .top)
                
                Spacer()
                
                NavigationLink(destination: creditsView()) {
                    Text("Credits")
                        .font(.custom(
                                "Georgia",
                                fixedSize: 18))
                        .foregroundStyle(.white)
                        .italic()
                        .frame(maxWidth: 100, maxHeight: 30)
                        .background(.cyan)
                }
                .clipShape(.rect(cornerRadius: 10))
                .padding(5)
                
                NavigationLink(destination: overviewView()) {
                    Text("Overview")
                        .font(.custom(
                                "Georgia",
                                fixedSize: 40))
                        .foregroundStyle(.white)
                        .italic()
                        .frame(maxWidth: 300, maxHeight: 100)
                        .background(.blue)
                }
                .clipShape(.rect(cornerRadius: 20))
                .padding(10)
                
                
                
                NavigationLink(destination: compareView()) {
                    Text("Compare")
                        .font(.custom(
                                "Georgia",
                                fixedSize: 40))
                        .foregroundStyle(.white)
                        .italic()
                        .frame(maxWidth: 300, maxHeight: 100)
                        .background(.red)
                }
                .clipShape(.rect(cornerRadius: 20))
                .padding(10)
                
                NavigationLink(destination: mapView()) {
                    Text("Map of Today")
                        .font(.custom(
                                "Georgia",
                                fixedSize: 36))
                        .foregroundStyle(.white)
                        .italic()
                        .frame(maxWidth: 300, maxHeight: 100)
                        .background(.orange)
                }
                .clipShape(.rect(cornerRadius: 20))
                .padding(10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("mansa-musa-of-the-mali-empire-10128").resizable().scaledToFill().ignoresSafeArea().opacity(0.7))
            .background(.black)
        }
    }
}

#Preview {
    ContentView()
}
