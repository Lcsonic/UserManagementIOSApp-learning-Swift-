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

    // Largura da sidebar, proporcional à tela (70%)
    private var sidebarWidth: CGFloat {
        UIScreen.main.bounds.width * 0.70
    }

    var body: some View {
        ZStack(alignment: .leading) {

            // MARK: - Sidebar flutuante com transição lateral
            if isSidebarVisible {
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

                    // Navegação pelas páginas
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
                    // Recuo horizontal dos botões de navegação
                    .padding(.leading, UIScreen.main.bounds.width * 0.10)

                    Spacer()
                }
                .frame(width: sidebarWidth) // Aplica a largura proporcional definida
                .background(Color(.systemBackground)) // Cor de fundo adaptável (modo claro/escuro)
                .transition(.move(edge: .leading)) // Transição animada vinda da esquerda
                .zIndex(2) // Camada superior
            }

            // MARK: - Tela principal com offset e overlay escurecido
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
                    // Mesmo posicionamento do botão de fechar da sidebar
                    .padding(.leading, 26)
                    .padding(.top, 20)

                    Spacer()
                }

                Spacer()

                // Exibe o conteúdo da página atual
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .offset(x: isSidebarVisible ? sidebarWidth : 0) // Desloca a tela para a direita ao abrir a sidebar
            .disabled(isSidebarVisible) // Evita interações com o conteúdo enquanto a sidebar estiver visível
            .overlay(
                // Overlay escurecido por cima da tela ao abrir a sidebar
                isSidebarVisible ?
                    Color.black.opacity(0.3)
                        .ignoresSafeArea() // Cobre toda a área da tela
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isSidebarVisible = false
                            }
                        }
                    : nil
            )
            .zIndex(1) // Fica abaixo da sidebar, acima do fundo
        }
        // Animação slide da sidebar aplicada a qualquer mudança no estado da visibilidade da sidebar
        .animation(.easeInOut, value: isSidebarVisible)
    }
}

#Preview {
    ContentView()
}
