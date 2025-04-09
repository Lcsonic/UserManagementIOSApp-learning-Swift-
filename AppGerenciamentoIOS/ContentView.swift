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
    
    // Controla se a sidebar flutuante está visível ou não
    @State private var isSidebarVisible: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) { // Alinha o conteúdo principal e a sidebar à esquerda
            
            // MARK: - Conteúdo Principal
            VStack {
                HStack {
                    // Botão para abrir a sidebar
                    Button(action: {
                        withAnimation {
                            isSidebarVisible = true // Exibe a sidebar com animação
                        }
                    }) {
                        Image(systemName: "line.3.horizontal") // Ícone de "menu"
                            .resizable()
                            .frame(width: 24, height: 18)
                            .padding(16) // Espaçamento interno do botão
                    }

                    Spacer() // Empurra o botão para a esquerda
                }

                Spacer() // Espaço entre topo e conteúdo da página

                // Conteúdo principal com base na página selecionada
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

                Spacer() // Espaço entre o conteúdo e a parte inferior
            }
            .zIndex(0) // Mantém o conteúdo principal abaixo da sidebar

            // MARK: - Sidebar flutuante
            if isSidebarVisible {
                
                // Fundo escurecido semi-transparente que cobre a tela inteira
                // Fecha a sidebar quando clicado
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isSidebarVisible = false // Oculta a sidebar com animação
                        }
                    }
                    .zIndex(1) // Fica acima do conteúdo principal, mas abaixo da sidebar
                
                // Sidebar propriamente dita
                VStack(alignment: .leading) {
                    
                    // Botão de fechar (ícone X)
                    Button(action: {
                        withAnimation {
                            isSidebarVisible = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .padding()
                    }

                    Divider().padding(.vertical, 10) // Separador visual

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
                    .padding(.leading, UIScreen.main.bounds.width * 0.10) // Recuo interno de 10% da largura da tela
                    
                    Spacer() // Empurra os botões para o topo
                }
                .frame(width: UIScreen.main.bounds.width * 0.70) // Sidebar ocupa 70% da largura da tela
                .background(Color(.systemGray6)) // Cor de fundo clara e neutra
                .transition(.move(edge: .leading)) // Animação de entrada pela esquerda
                .zIndex(2) // Fica no topo da pilha de visualização
            }
        }

    }
}

#Preview {
    ContentView()
}
