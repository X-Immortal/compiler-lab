; ModuleID = 'test8.c'
source_filename = "test8.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %n) local_unnamed_addr #0 {
entry:
  %smax = call i32 @llvm.smax.i32(i32 %n, i32 0)
  %0 = add nuw i32 %smax, 1
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %result.0 = phi i32 [ 1, %entry ], [ %mul, %while.body ]
  %i.0 = phi i32 [ 1, %entry ], [ %add, %while.body ]
  %exitcond = icmp eq i32 %i.0, %0
  br i1 %exitcond, label %while.end, label %while.body

while.body:                                       ; preds = %while.cond
  %mul = mul nsw i32 %i.0, %result.0
  %add = add nuw nsw i32 %i.0, 1
  %exitcond8 = icmp eq i32 %add, 11
  br i1 %exitcond8, label %while.end, label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %while.body, %while.cond
  %result.1 = phi i32 [ %mul, %while.body ], [ %result.0, %while.cond ]
  ret i32 %result.1
}

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %factorial.exit
  %j.09 = phi i32 [ 0, %entry ], [ %0, %factorial.exit ]
  %sum.08 = phi i32 [ 0, %entry ], [ %add, %factorial.exit ]
  %0 = add nuw nsw i32 %j.09, 1
  %exitcond.i10 = icmp eq i32 %j.09, 0
  br i1 %exitcond.i10, label %factorial.exit, label %while.body.i

while.body.i:                                     ; preds = %while.body, %while.body.i
  %i.0.i12 = phi i32 [ %add.i, %while.body.i ], [ 1, %while.body ]
  %result.0.i11 = phi i32 [ %mul.i, %while.body.i ], [ 1, %while.body ]
  %mul.i = mul nsw i32 %i.0.i12, %result.0.i11
  %add.i = add nuw nsw i32 %i.0.i12, 1
  %exitcond.i = icmp eq i32 %i.0.i12, %j.09
  br i1 %exitcond.i, label %factorial.exit, label %while.body.i, !llvm.loop !5

factorial.exit:                                   ; preds = %while.body.i, %while.body
  %result.0.i.lcssa = phi i32 [ 1, %while.body ], [ %mul.i, %while.body.i ]
  %add = add nuw nsw i32 %result.0.i.lcssa, %sum.08
  %exitcond.not = icmp eq i32 %0, 5
  br i1 %exitcond.not, label %while.end, label %while.body, !llvm.loop !8

while.end:                                        ; preds = %factorial.exit
  ret i32 %add
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #1

attributes #0 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

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
!8 = distinct !{!8, !6, !7}
