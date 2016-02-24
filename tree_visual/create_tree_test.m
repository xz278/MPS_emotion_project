% create a tree for test purpose
n1 = TestTreeNode(1);
n2 = TestTreeNode(2);
n3 = TestTreeNode(3);
n4 = TestTreeNode(4);
n5 = TestTreeNode(5);
n6 = TestTreeNode(6);
n7 = TestTreeNode(7);
n8 = TestTreeNode(8);
n9 = TestTreeNode(9);
n10 = TestTreeNode(10);
n1.addChild({n2,n4});
n2.addChild({n3});
n4.addChild({n5,n6,n7});
n6.addChild({n8});
n7.addChild({n9,n10});