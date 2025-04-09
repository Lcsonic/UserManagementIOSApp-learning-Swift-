import SwiftUI

// Enum com as páginas disponíveis
enum Page {
    case home       // Página inicial
    case settings   // Página de configurações
    case about      // Página sobre
}

struct ContentView: View {
    
    // Página atualmente selecionada pelo usuário
    @State private var selectedPage: Page = .home
    
    // Controle se a sidebar está expandida ou recolhida
    @State private var isSidebarExpanded: Bool = true
    
    var body: some View {
        HStack(spacing: 0) {
            
            // MARK: - Sidebar (menu lateral)
            VStack(alignment: .leading) {
                
                // Botão que expande ou recolhe a sidebar
                Button(action: {
                    withAnimation {
                        isSidebarExpanded.toggle() // Inverte o estado da sidebar com animação
                    }
                }) {
                    Image(systemName: "sidebar.leading") // Ícone padrão do sistema
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top)
                }
                .padding(.horizontal)
                
                Divider().padding(.vertical, 10) // Linha divisória para separação visual
                
                // Botões de navegação entre páginas
                Group {
                    Button(action: {
                        selectedPage = .home // Navega para a página inicial
                    }) {
                        Label("Home", systemImage: "house")
                            .labelStyle(SidebarLabelStyle(isExpanded: isSidebarExpanded))
                    }
                    
                    Button(action: {
                        selectedPage = .settings // Navega para configurações
                    }) {
                        Label("Settings", systemImage: "gear")
                            .labelStyle(SidebarLabelStyle(isExpanded: isSidebarExpanded))
                    }
                    
                    Button(action: {
                        selectedPage = .about // Navega para a página "Sobre"
                    }) {
                        Label("About", systemImage: "info.circle")
                            .labelStyle(SidebarLabelStyle(isExpanded: isSidebarExpanded))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                Spacer() // Empurra o conteúdo para o topo da sidebar
            }
            // Define a largura da sidebar conforme estado
            .frame(width: isSidebarExpanded ? 200 : 60) // <- AQUI é definido o tamanho recolhido (60)
            .background(Color.gray.opacity(0.15)) // Cor de fundo leve
            .animation(.easeInOut, value: isSidebarExpanded) // Anima a transição de expansão/recolhimento
            
            Divider() // Linha vertical entre sidebar e conteúdo principal
            
            // MARK: - Área de conteúdo principal
            ZStack {
                switch selectedPage {
                case .home:
                    Text("Home Page") // Conteúdo da página Home
                        .font(.largeTitle)
                        .fontWeight(.bold)
                case .settings:
                    Text("Settings Page") // Conteúdo da página Settings
                        .font(.largeTitle)
                        .fontWeight(.bold)
                case .about:
                    Text("About Page") // Conteúdo da página About
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Ocupa todo o espaço disponível
            .background(Color.white) // Fundo branco para o conteúdo principal
        }
    }
}

// MARK: - Estilo personalizado para mostrar ou ocultar texto do Label
struct SidebarLabelStyle: LabelStyle {
    var isExpanded: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon // Ícone do label (por exemplo, casa, engrenagem, etc.)
            if isExpanded {
                configuration.title // Só mostra o texto se a sidebar estiver expandida
                    .font(.body)
            }
        }
    }
}

#Preview {
    ContentView()
}
