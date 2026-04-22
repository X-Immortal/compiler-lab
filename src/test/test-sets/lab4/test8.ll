; ModuleID = 'test8.c'
source_filename = "test8.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@switch.table.factorial = private unnamed_addr constant [8 x i32] [i32 2, i32 6, i32 24, i32 120, i32 720, i32 5040, i32 40320, i32 362880], align 4

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #0 {
  %2 = call i32 @llvm.smax.i32(i32 %0, i32 0)
  %3 = icmp slt i32 %0, 1
  %4 = icmp eq i32 %2, 1
  %5 = select i1 %3, i1 true, i1 %4
  br i1 %5, label %13, label %6

6:                                                ; preds = %1
  %7 = add nsw i32 %2, -2
  %8 = icmp ult i32 %7, 8
  br i1 %8, label %9, label %13

9:                                                ; preds = %6
  %10 = sext i32 %7 to i64
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* @switch.table.factorial, i64 0, i64 %10
  %12 = load i32, i32* %11, align 4
  br label %13

13:                                               ; preds = %6, %9, %1
  %14 = phi i32 [ 1, %1 ], [ %12, %9 ], [ 3628800, %6 ]
  ret i32 %14
}

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  ret i32 34
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
