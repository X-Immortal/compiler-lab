; ModuleID = 'test3.c'
source_filename = "test3.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  br label %1

1:                                                ; preds = %0, %12
  %2 = phi i32 [ %13, %12 ], [ 0, %0 ]
  %3 = phi i32 [ %14, %12 ], [ 0, %0 ]
  %4 = call i32 @llvm.smax.i32(i32 %3, i32 4)
  br label %5

5:                                                ; preds = %1, %9
  %6 = phi i32 [ %3, %1 ], [ %10, %9 ]
  %7 = and i32 %6, 1
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %12

9:                                                ; preds = %5
  %10 = add nuw i32 %6, 1
  %11 = icmp eq i32 %6, %4
  br i1 %11, label %16, label %5, !llvm.loop !5

12:                                               ; preds = %5
  %13 = add nuw nsw i32 %2, 1
  %14 = add nsw i32 %6, 1
  %15 = icmp sgt i32 %6, 3
  br i1 %15, label %16, label %1, !llvm.loop !5

16:                                               ; preds = %12, %9
  %17 = phi i32 [ %2, %9 ], [ %13, %12 ]
  br label %18

18:                                               ; preds = %16, %26
  %19 = phi i32 [ %27, %26 ], [ %17, %16 ]
  %20 = phi i32 [ %28, %26 ], [ 1, %16 ]
  %21 = call i32 @llvm.smax.i32(i32 %20, i32 4)
  br label %22

22:                                               ; preds = %30, %18
  %23 = phi i32 [ %20, %18 ], [ %31, %30 ]
  %24 = and i32 %23, 1
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %30, label %26

26:                                               ; preds = %22
  %27 = add nsw i32 %19, 1
  %28 = add nsw i32 %23, 1
  %29 = icmp sgt i32 %23, 3
  br i1 %29, label %33, label %18, !llvm.loop !5

30:                                               ; preds = %22
  %31 = add nuw i32 %23, 1
  %32 = icmp eq i32 %23, %21
  br i1 %32, label %33, label %22, !llvm.loop !5

33:                                               ; preds = %26, %30
  %34 = phi i32 [ %19, %30 ], [ %27, %26 ]
  br label %35

35:                                               ; preds = %33, %43
  %36 = phi i32 [ %44, %43 ], [ %34, %33 ]
  %37 = phi i32 [ %45, %43 ], [ 2, %33 ]
  %38 = call i32 @llvm.smax.i32(i32 %37, i32 4)
  br label %39

39:                                               ; preds = %47, %35
  %40 = phi i32 [ %37, %35 ], [ %48, %47 ]
  %41 = and i32 %40, 1
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %47, label %43

43:                                               ; preds = %39
  %44 = add nsw i32 %36, 1
  %45 = add nsw i32 %40, 1
  %46 = icmp sgt i32 %40, 3
  br i1 %46, label %50, label %35, !llvm.loop !5

47:                                               ; preds = %39
  %48 = add nuw i32 %40, 1
  %49 = icmp eq i32 %40, %38
  br i1 %49, label %50, label %39, !llvm.loop !5

50:                                               ; preds = %43, %47
  %51 = phi i32 [ %36, %47 ], [ %44, %43 ]
  br label %52

52:                                               ; preds = %50, %60
  %53 = phi i32 [ %61, %60 ], [ %51, %50 ]
  %54 = phi i32 [ %62, %60 ], [ 3, %50 ]
  %55 = call i32 @llvm.smax.i32(i32 %54, i32 4)
  br label %56

56:                                               ; preds = %64, %52
  %57 = phi i32 [ %54, %52 ], [ %65, %64 ]
  %58 = and i32 %57, 1
  %59 = icmp eq i32 %58, 0
  br i1 %59, label %64, label %60

60:                                               ; preds = %56
  %61 = add nsw i32 %53, 1
  %62 = add nsw i32 %57, 1
  %63 = icmp sgt i32 %57, 3
  br i1 %63, label %67, label %52, !llvm.loop !5

64:                                               ; preds = %56
  %65 = add nuw i32 %57, 1
  %66 = icmp eq i32 %57, %55
  br i1 %66, label %67, label %56, !llvm.loop !5

67:                                               ; preds = %60, %64
  %68 = phi i32 [ %53, %64 ], [ %61, %60 ]
  ret i32 %68
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
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
