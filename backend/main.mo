import Func "mo:base/Func";

import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Text "mo:base/Text";

actor {
  // Type for storing messages
  type Message = {
    sender: Text;
    content: Text;
  };

  // Stable variable to store conversation history
  stable var conversationHistory : [Message] = [];

  // Simulated Claude responses
  let claudeResponses = [
    "Hello! How can I assist you today?",
    "That's an interesting question. Let me think about it.",
    "I'm sorry, I don't have enough information to answer that accurately.",
    "Could you please provide more context?",
    "That's a great point! Here's what I think about it...",
  ];

  // Function to get a simulated Claude response
  func getClaudeResponse() : Text {
    let index = conversationHistory.size() % claudeResponses.size();
    claudeResponses[index]
  };

  // Public function to send a message and get a response
  public func sendMessage(userMessage: Text) : async Message {
    let userMsg : Message = {
      sender = "User";
      content = userMessage;
    };

    let claudeMsg : Message = {
      sender = "Claude";
      content = getClaudeResponse();
    };

    conversationHistory := Array.append(conversationHistory, [userMsg, claudeMsg]);

    claudeMsg
  };

  // Query function to get the conversation history
  public query func getConversationHistory() : async [Message] {
    conversationHistory
  };

  // System functions for upgrades
  system func preupgrade() {
    // Conversation history is already in a stable variable
  };

  system func postupgrade() {
    // No need to restore state as it's preserved in the stable variable
  };
}
