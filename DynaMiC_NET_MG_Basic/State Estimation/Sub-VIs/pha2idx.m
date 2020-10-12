function index = pha2idx(byphase,n)

node  = byphase(:,1);
phase = byphase(:,2);
row   = size(byphase,1);
index = zeros(row,1);
for i = 1:row
switch phase(i)
  case 1
    index(i) = node(i);
  case 2
    index(i) = node(i) + n;
  case 3
    index(i) = node(i) + 2*n;
end
end