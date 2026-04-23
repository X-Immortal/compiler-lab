; ModuleID = 'module'
source_filename = "module"

define i32 @max(i32 %x, i32 %y) {
entry:
  %cmp = icmp sgt i32 %x, %y
  %x.y = select i1 %cmp, i32 %x, i32 %y
  ret i32 %x.y
}

define i32 @gcd(i32 %a, i32 %b) {
entry:
  %tobool.not5 = icmp eq i32 %b, 0
  br i1 %tobool.not5, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %a.addr.07 = phi i32 [ %b.addr.06, %while.body ], [ %a, %entry ]
  %b.addr.06 = phi i32 [ %rem, %while.body ], [ %b, %entry ]
  %rem = srem i32 %a.addr.07, %b.addr.06
  %tobool.not = icmp eq i32 %rem, 0
  br i1 %tobool.not, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  %a.addr.0.lcssa = phi i32 [ %a, %entry ], [ %b.addr.06, %while.body ]
  ret i32 %a.addr.0.lcssa
}

define i32 @main() {
entry:
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %entry
  %a.addr.07.i = phi i32 [ %b.addr.06.i, %while.body.i ], [ 7, %entry ]
  %b.addr.06.i = phi i32 [ %rem.i, %while.body.i ], [ 2, %entry ]
  %rem.i = srem i32 %a.addr.07.i, %b.addr.06.i
  %tobool.not.i = icmp eq i32 %rem.i, 0
  br i1 %tobool.not.i, label %while.body.i7, label %while.body.i

while.body.i7:                                    ; preds = %while.body.i, %while.body.i7
  %a.addr.07.i3 = phi i32 [ %b.addr.06.i4, %while.body.i7 ], [ 18, %while.body.i ]
  %b.addr.06.i4 = phi i32 [ %rem.i5, %while.body.i7 ], [ 12, %while.body.i ]
  %rem.i5 = srem i32 %a.addr.07.i3, %b.addr.06.i4
  %tobool.not.i6 = icmp eq i32 %rem.i5, 0
  br i1 %tobool.not.i6, label %gcd.exit8, label %while.body.i7

gcd.exit8:                                        ; preds = %while.body.i7
  %cmp.i = icmp sgt i32 %b.addr.06.i, %b.addr.06.i4
  %x.y.i = select i1 %cmp.i, i32 %b.addr.06.i, i32 %b.addr.06.i4
  ret i32 %x.y.i
}

