import 'dart:io';

class ListNode {
  int val;
  ListNode? next;
  ListNode(this.val, [this.next]);
}

ListNode? deleteDuplicates(ListNode? head) {
  var current = head;

  while (current?.next != null) {
    if (current!.val == current.next!.val) {
      current.next = current.next!.next;
    } else {
      current = current.next;
    }
  }

  return head;
}

// Linked List build
ListNode? buildList(List<int> values) {
  if (values.isEmpty) return null;
  var head = ListNode(values[0]);
  var current = head;
  for (var i = 1; i < values.length; i++) {
    current.next = ListNode(values[i]);
    current = current.next!;
  }
  return head;
}

void printList(ListNode? head) {
  while (head != null) {
    stdout.write('${head.val}${head.next != null ? ',' : ''}');
    head = head.next;
  }
  print('');
}

void main() {
  var input = [1, 1, 2, 3, 3, 4, 4, 8, 8, 9, 9, 10];
  var head = buildList(input);

  print('Original:');
  printList(head);
  print('After removing duplicates:');
  printList(deleteDuplicates(head));
}
