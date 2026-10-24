let utilizadores = [];

// admin
let admin = { 
    username: 'admin', 
    email: 'admin@admin',
    password: 'admin' 
};
utilizadores[0] = admin; 

// ==========================================
// MUDAR DE TELA (No index.html)
// ==========================================
function mostrarLogin() {
    ecraLogin.style.display = 'block';
    ecraRegisto.style.display = 'none';
    ecraCarregamento.style.display = 'none';
}

function mostrarRegisto() {
    ecraLogin.style.display = 'none';
    ecraRegisto.style.display = 'block';
    ecraCarregamento.style.display = 'none';
}

function mostrarCarregamento() {
    ecraLogin.style.display = 'none';
    ecraRegisto.style.display = 'none';
    ecraCarregamento.style.display = 'block';
}

// ==========================================
// MUDAR DE ARQUIVO HTML (Navegação)
// ==========================================
function mostrarDashboard() {
    location.href = 'dashboard.html';
}

function sair() {
    location.href = 'index.html';
}

// ==========================================
// REGISTRO
// ==========================================
function registar() {
    let u = regUser.value;
    let e = regEmail.value;
    let t = regTelefone.value;
    let p = regPass.value;

    let existe = false;
    let i = 0;

    // Verifica se já existe usando o laço WHILE
    while (i < utilizadores.length && existe == false) {
        if (utilizadores[i].username == u || utilizadores[i].email == e) {
            existe = true;
        }
        i++;
    }

    if (existe == true) {
        erroRegisto.innerHTML = 'Este usuário ou e-mail já existe!';
    } else {
        let novo = { 
            username: u, 
            email: e, 
            telefone: t, 
            password: p 
        };
        
        // Adiciona no final do vetor
        let tamanho = utilizadores.length;
        utilizadores[tamanho] = novo; 
        
        alert('Conta criada com sucesso!');
        
        // Limpa os campos
        regUser.value = '';
        regEmail.value = '';
        regTelefone.value = '';
        regPass.value = '';
        erroRegisto.innerHTML = '';
        
        mostrarLogin();
    }
}

// ==========================================
// LOGIN
// ==========================================
function entrar() {
    let u = logUser.value;
    let p = logPass.value;

    let achou = false;
    let i = 0;

    // Procura o usuário no vetor usando o laço WHILE
    while (i < utilizadores.length && achou == false) {
        if (utilizadores[i].email == u && utilizadores[i].password == p) {
            achou = true;
        }
        i++;
    }

    if (achou == true) {
        erroLogin.innerHTML = ''; 
        
        // Inicia a animação de loop
        mostrarCarregamento();
        
        // Espera 1.5 
        setTimeout(mostrarDashboard, 1500);
        
    } else {
        erroLogin.innerHTML = 'Dados inválidos!';
    }
}