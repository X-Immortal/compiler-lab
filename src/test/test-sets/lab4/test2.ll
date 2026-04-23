; ModuleID = 'test2.c'
source_filename = "test2.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @max(i32 noundef %x, i32 noundef %y) local_unnamed_addr #0 {
entry:
  %cmp = icmp sgt i32 %x, %y
  %x.y = select i1 %cmp, i32 %x, i32 %y
  ret i32 %x.y
}

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @gcd(i32 noundef %a, i32 noundef %b) local_unnamed_addr #1 {
entry:
  %tobool.not5 = icmp eq i32 %b, 0
  br i1 %tobool.not5, label %while.end, label %while.body

while.body:                                       ; preds = %entry, %while.body
  %a.addr.07 = phi i32 [ %b.addr.06, %while.body ], [ %a, %entry ]
  %b.addr.06 = phi i32 [ %rem, %while.body ], [ %b, %entry ]
  %rem = srem i32 %a.addr.07, %b.addr.06
  %tobool.not = icmp eq i32 %rem, 0
  br i1 %tobool.not, label %while.end, label %while.body, !llvm.loop !5

while.end:                                        ; preds = %while.body, %entry
  %a.addr.0.lcssa = phi i32 [ %a, %entry ], [ %b.addr.06, %while.body ]
  ret i32 %a.addr.0.lcssa
}

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
entry:
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %entry
  %a.addr.07.i = phi i32 [ %b.addr.06.i, %while.body.i ], [ 7, %entry ]
  %b.addr.06.i = phi i32 [ %rem.i, %while.body.i ], [ 2, %entry ]
  %rem.i = srem i32 %a.addr.07.i, %b.addr.06.i
  %tobool.not.i = icmp eq i32 %rem.i, 0
  br i1 %tobool.not.i, label %while.body.i7, label %while.body.i, !llvm.loop !5

while.body.i7:                                    ; preds = %while.body.i, %while.body.i7
  %a.addr.07.i3 = phi i32 [ %b.addr.06.i4, %while.body.i7 ], [ 18, %while.body.i ]
  %b.addr.06.i4 = phi i32 [ %rem.i5, %while.body.i7 ], [ 12, %while.body.i ]
  %rem.i5 = srem i32 %a.addr.07.i3, %b.addr.06.i4
  %tobool.not.i6 = icmp eq i32 %rem.i5, 0
  br i1 %tobool.not.i6, label %gcd.exit8, label %while.body.i7, !llvm.loop !5

gcd.exit8:                                        ; preds = %while.body.i7
  %cmp.i = icmp sgt i32 %b.addr.06.i, %b.addr.06.i4
  %x.y.i = select i1 %cmp.i, i32 %b.addr.06.i, i32 %b.addr.06.i4
  ret i32 %x.y.i
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.unroll.disable"}
