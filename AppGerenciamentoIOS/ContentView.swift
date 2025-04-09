import SwiftUI

// Enum com as páginas disponíveis
enum Page {
    case home
    case settings
    case about
}

struct ContentView: View {
    
    // Página atualmente selecionada
    @State private var selectedPage: Page = .home
    
    // Controle de expansão da sidebar
    @State private var isSidebarExpanded: Bool = true
    
    var body: some View {
        HStack(spacing: 0) {
            
            // MARK: - Sidebar (menu lateral)
            VStack(alignment: .leading) {
                
                // Botão para expandir/recolher a sidebar
                Button(action: {
                    withAnimation {
                        isSidebarExpanded.toggle()
                    }
                }) {
                    Image(systemName: "sidebar.leading")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                }
                .padding(.horizontal)
                
                Divider().padding(.vertical, 10)
                
                // Botões de navegação
                Group {
                    Button(action: {
                        selectedPage = .home
                    }) {
                        Label("Home", systemImage: "house")
                            .labelStyle(SidebarLabelStyle(isExpanded: isSidebarExpanded))
                    }
                    
                    Button(action: {
                        selectedPage = .settings
                    }) {
                        Label("Settings", systemImage: "gear")
                            .labelStyle(SidebarLabelStyle(isExpanded: isSidebarExpanded))
                    }
                    
                    Button(action: {
                        selectedPage = .about
                    }) {
                        Label("About", systemImage: "info.circle")
                            .labelStyle(SidebarLabelStyle(isExpanded: isSidebarExpanded))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                Spacer()
            }
            .frame(width: isSidebarExpanded ? 200 : 60)
            .background(Color.gray.opacity(0.15))
            .animation(.easeInOut, value: isSidebarExpanded)
            
            Divider()
            
            // MARK: - Área de conteúdo principal
            ZStack {
                switch selectedPage {
                case .home:
                    Text("Home Page")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                case .settings:
                    Text("Settings Page")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                case .about:
                    Text("About Page")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

// MARK: - Estilo personalizado para mostrar ou ocultar texto do Label
struct SidebarLabelStyle: LabelStyle {
    var isExpanded: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            if isExpanded {
                configuration.title
                    .font(.body)
            }
        }
    }
}

#Preview {
    ContentView()
}
