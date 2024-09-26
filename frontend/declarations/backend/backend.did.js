export const idlFactory = ({ IDL }) => {
  const Message = IDL.Record({ 'content' : IDL.Text, 'sender' : IDL.Text });
  return IDL.Service({
    'getConversationHistory' : IDL.Func([], [IDL.Vec(Message)], ['query']),
    'sendMessage' : IDL.Func([IDL.Text], [Message], []),
  });
};
export const init = ({ IDL }) => { return []; };
