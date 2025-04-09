import SwiftUI

// Enum representando as páginas disponíveis na aplicação
enum Page {
    case home
    case settings
    case about
}

struct ContentView: View {
    
    // Página atualmente selecionada
    @State private var selectedPage: Page = .home
    
    // Controle da visibilidade da sidebar
    @State private var isSidebarVisible: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            // MARK: - Conteúdo Principal
            VStack {
                HStack {
                    // Botão para abrir a sidebar
                    Button(action: {
                        withAnimation {
                            isSidebarVisible.toggle()
                        }
                    }) {
                        Image(systemName: "sidebar.left")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.primary)
                    }
                    // Alinhamento horizontal e vertical consistente com o botão de fechar
                    .padding(.leading, 26)
                    .padding(.top, 20)

                    Spacer()
                }

                Spacer()
                
                // Exibe o conteúdo com base na página selecionada
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

                Spacer()
            }
            .zIndex(0) // Conteúdo principal fica atrás da sidebar

            // MARK: - Sidebar
            if isSidebarVisible {
                
                // Camada de fundo escurecida que fecha a sidebar ao ser tocada
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isSidebarVisible = false
                        }
                    }
                    .zIndex(1) // Fica acima do conteúdo principal, mas abaixo da sidebar

                // Conteúdo da sidebar
                VStack(alignment: .leading) {
                    
                    // Botão de fechar no mesmo alinhamento do botão de abrir
                    Button(action: {
                        withAnimation {
                            isSidebarVisible = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .padding(.leading, 14) // Alinhamento em pixel "fixo" testar em outros modelos de iphone para ver se existe mudandaça nas posições
                    .padding(.top, 6)

                    Divider().padding(.vertical, 10)

                    // Botões de navegação entre páginas
                    Group {
                        Button(action: {
                            selectedPage = .home
                            isSidebarVisible = false
                        }) {
                            Label("Home", systemImage: "house")
                                .padding(.vertical)
                        }

                        Button(action: {
                            selectedPage = .settings
                            isSidebarVisible = false
                        }) {
                            Label("Settings", systemImage: "gear")
                                .padding(.vertical)
                        }

                        Button(action: {
                            selectedPage = .about
                            isSidebarVisible = false
                        }) {
                            Label("About", systemImage: "info.circle")
                                .padding(.vertical)
                        }
                    }
                    // Recuo interno da sidebar, proporcional à largura da tela
                    .padding(.leading, UIScreen.main.bounds.width * 0.10)

                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width * 0.70) // Sidebar com 70% da largura da tela
                .background(Color(.systemGray6)) // Cor de fundo clara e neutra
                .transition(.move(edge: .leading)) // Animação de entrada pela esquerda
                .zIndex(2) // Fica acima de todo o restante
            }
        }
    }
}

#Preview {
    ContentView()
}
