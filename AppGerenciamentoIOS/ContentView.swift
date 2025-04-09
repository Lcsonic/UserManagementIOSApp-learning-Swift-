import SwiftUI

// Enum representando as páginas disponíveis
enum Page {
    case home
    case settings
    case about
}

// MARK: - View da Sidebar Modularizada
struct SidebarView: View {
    // Bindings para controle externo da visibilidade da sidebar e da página selecionada
    @Binding var isSidebarVisible: Bool
    @Binding var selectedPage: Page
    let sidebarWidth: CGFloat // Largura configurável da sidebar

    var body: some View {
        VStack(alignment: .leading) {
            
            // Botão para fechar a sidebar
            Button(action: {
                withAnimation(.easeInOut) {
                    isSidebarVisible = false
                }
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.primary)
                    .padding()
            }
            .padding(.leading, 14)
            .padding(.top, 6)

            Divider().padding(.vertical, 10)

            // Botões para navegação entre as páginas
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
            // Espaçamento horizontal dos botões em relação à borda
            .padding(.leading, UIScreen.main.bounds.width * 0.10)

            Spacer() // Empurra conteúdo para o topo
        }
        .frame(width: sidebarWidth) // Define a largura da sidebar
        .background(Color(.systemBackground)) // Cor de fundo adaptável ao modo claro/escuro
        .transition(.move(edge: .leading)) // Animação de entrada pela esquerda
        .zIndex(2) // Garante que a sidebar fique acima da tela principal
    }
}

// MARK: - View genérica para empacotar o conteúdo principal com slide e overlay
struct SlidePageView<Content: View>: View {
    @Binding var isSidebarVisible: Bool // Controle da sidebar
    let sidebarWidth: CGFloat // Largura usada para deslocar o conteúdo principal
    let content: () -> Content // Closure com o conteúdo da tela

    var body: some View {
        VStack {
            HStack {
                // Botão para abrir/fechar a sidebar
                Button(action: {
                    withAnimation(.easeInOut) {
                        isSidebarVisible.toggle()
                    }
                }) {
                    Image(systemName: "sidebar.left")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 26)
                .padding(.top, 20)

                Spacer()
            }

            Spacer()

            // Conteúdo específico passado pela ContentView
            content()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground)) // Fundo neutro para a tela principal
        .offset(x: isSidebarVisible ? sidebarWidth : 0) // Move a tela ao abrir a sidebar
        .blur(radius: isSidebarVisible ? 1 : 0) // Aplica leve desfoque para efeito visual
        .overlay(
            // Overlay escurecido com gesto para fechar a sidebar
            Group {
                if isSidebarVisible {
                    Color.black.opacity(0.12)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isSidebarVisible = false
                            }
                        }
                }
            }
        )
        .disabled(isSidebarVisible) // Desabilita interações com o conteúdo ao abrir a sidebar
        .zIndex(1) // Fica abaixo da sidebar, mas acima do fundo
    }
}

// MARK: - View Principal
struct ContentView: View {
    @State private var selectedPage: Page = .home // Página atual selecionada
    @State private var isSidebarVisible: Bool = false // Controle da visibilidade da sidebar

    // Define a largura da sidebar com base na largura da tela
    private var sidebarWidth: CGFloat {
        UIScreen.main.bounds.width * 0.70
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // Exibe a sidebar somente quando visível
            if isSidebarVisible {
                SidebarView(
                    isSidebarVisible: $isSidebarVisible,
                    selectedPage: $selectedPage,
                    sidebarWidth: sidebarWidth
                )
            }

            // Conteúdo principal da tela, com suporte a slide e overlay
            SlidePageView(isSidebarVisible: $isSidebarVisible, sidebarWidth: sidebarWidth) {
                // Define o conteúdo de acordo com a página selecionada
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
        }
        // Aplica a animação de forma automática ao mudar `isSidebarVisible`
        .animation(.easeInOut, value: isSidebarVisible)
    }
}
