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

    // Largura da sidebar baseada em 70% da largura da tela
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
                    .padding(.leading, 14) // Alinhamento horizontal
                    .padding(.top, 6)      // Alinhamento vertical

                    Divider().padding(.vertical, 10)

                    // Botões de navegação entre as páginas
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
                    // Recuo interno dos botões
                    .padding(.leading, UIScreen.main.bounds.width * 0.10)

                    Spacer()
                }
                .frame(width: sidebarWidth) // Define a largura da sidebar
                .background(Color(.systemBackground)) // Usa o fundo do sistema (compatível com dark/light mode)
                .transition(.move(edge: .leading)) // Animação ao aparecer pela esquerda
                .zIndex(2) // Fica sobre o conteúdo principal
            }

            // MARK: - Conteúdo principal da tela
            VStack {
                HStack {
                    // Botão para abrir ou fechar a sidebar
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

                // Exibe o conteúdo de acordo com a página selecionada
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
            .background(Color(.systemBackground)) // Cor de fundo da tela principal
            .offset(x: isSidebarVisible ? sidebarWidth : 0) // Move o conteúdo quando a sidebar está visível
            .blur(radius: isSidebarVisible ? 1 : 0) // Aplica um leve desfoque ao fundo
            .overlay(
                // Overlay escurecido com leve opacidade (quando a sidebar está visível)
                Group {
                    if isSidebarVisible {
                        Color.black.opacity(0.12)
                            .ignoresSafeArea() // Cobre toda a tela
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isSidebarVisible = false
                                }
                            }
                    }
                }
            )
            .disabled(isSidebarVisible) // Impede interação com o conteúdo ao abrir a sidebar
            .zIndex(1) // Fica abaixo da sidebar

            // Método antigo com overlay mais opaco e sem blur
//            .offset(x: isSidebarVisible ? sidebarWidth : 0)
//            .disabled(isSidebarVisible)
//            .overlay(
//                isSidebarVisible ?
//                    Color.black.opacity(0.35)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            withAnimation(.easeInOut) {
//                                isSidebarVisible = false
//                            }
//                        }
//                    : nil
//            )
            
        }
        // Aplica a animação suave sempre que `isSidebarVisible` mudar
        .animation(.easeInOut, value: isSidebarVisible)
    }
}

#Preview {
    ContentView()
}
