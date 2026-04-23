; ModuleID = 'test3.c'
source_filename = "test3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  br label %while.cond1.preheader

while.cond1.preheader:                            ; preds = %entry, %while.end
  %result.043 = phi i32 [ 0, %entry ], [ %result.1.ph.lcssa, %while.end ]
  %i.040 = phi i32 [ 0, %entry ], [ %add10, %while.end ]
  %0 = icmp ugt i32 %i.040, 4
  br i1 %0, label %while.end, label %if.end.lr.ph

if.end.lr.ph:                                     ; preds = %while.cond1.preheader, %if.end7
  %result.1.ph38 = phi i32 [ %add8, %if.end7 ], [ %result.043, %while.cond1.preheader ]
  %j.0.ph37 = phi i32 [ %add9, %if.end7 ], [ %i.040, %while.cond1.preheader ]
  %smax = call i32 @llvm.smax.i32(i32 %j.0.ph37, i32 4)
  br label %if.end

if.end:                                           ; preds = %if.end.lr.ph, %if.then6
  %j.035 = phi i32 [ %j.0.ph37, %if.end.lr.ph ], [ %add, %if.then6 ]
  %1 = and i32 %j.035, 1
  %cmp5 = icmp eq i32 %1, 0
  br i1 %cmp5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end
  %add = add i32 %j.035, 1
  %exitcond = icmp eq i32 %j.035, %smax
  br i1 %exitcond, label %while.end, label %if.end, !llvm.loop !5

if.end7:                                          ; preds = %if.end
  %add8 = add nsw i32 %result.1.ph38, 1
  %add9 = add nsw i32 %j.035, 1
  %2 = icmp sgt i32 %j.035, 3
  br i1 %2, label %while.end, label %if.end.lr.ph, !llvm.loop !5

while.end:                                        ; preds = %if.end7, %if.then6, %while.cond1.preheader
  %result.1.ph.lcssa = phi i32 [ %result.043, %while.cond1.preheader ], [ %result.1.ph38, %if.then6 ], [ %add8, %if.end7 ]
  %add10 = add nuw nsw i32 %i.040, 1
  %exitcond47.not = icmp eq i32 %add10, 6
  br i1 %exitcond47.not, label %cleanup, label %while.cond1.preheader, !llvm.loop !8

cleanup:                                          ; preds = %while.end
  ret i32 %result.1.ph.lcssa
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
