import { backend } from 'declarations/backend';

const chatMessages = document.getElementById('chat-messages');
const userInput = document.getElementById('user-input');
const sendButton = document.getElementById('send-button');

async function loadConversationHistory() {
    const history = await backend.getConversationHistory();
    history.forEach(displayMessage);
}

function displayMessage(message) {
    const messageElement = document.createElement('div');
    messageElement.classList.add('message', message.sender.toLowerCase());
    messageElement.textContent = `${message.sender}: ${message.content}`;
    chatMessages.appendChild(messageElement);
    chatMessages.scrollTop = chatMessages.scrollHeight;
}

async function sendMessage() {
    const message = userInput.value.trim();
    if (message) {
        userInput.value = '';
        displayMessage({ sender: 'User', content: message });
        const response = await backend.sendMessage(message);
        displayMessage(response);
    }
}

sendButton.addEventListener('click', sendMessage);
userInput.addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        sendMessage();
    }
});

loadConversationHistory();
