; ModuleID = 'test5.c'
source_filename = "test5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@BASE = dso_local local_unnamed_addr constant i32 10, align 4
@globalCounter = dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @power(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = call i32 @llvm.smax.i32(i32 %1, i32 0)
  br label %4

4:                                                ; preds = %8, %2
  %5 = phi i32 [ 1, %2 ], [ %9, %8 ]
  %6 = phi i32 [ 0, %2 ], [ %10, %8 ]
  %7 = icmp eq i32 %6, %3
  br i1 %7, label %12, label %8

8:                                                ; preds = %4
  %9 = mul nsw i32 %5, %0
  %10 = add nuw i32 %6, 1
  %11 = icmp sgt i32 %9, 1000
  br i1 %11, label %12, label %4, !llvm.loop !5

12:                                               ; preds = %4, %8
  %13 = phi i32 [ %9, %8 ], [ %5, %4 ]
  ret i32 %13
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #1 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %77, label %3

3:                                                ; preds = %1
  %4 = add i32 %0, 1
  %5 = call i32 @llvm.umin.i32(i32 %0, i32 2)
  %6 = sub i32 %4, %5
  %7 = icmp ult i32 %6, 8
  br i1 %7, label %68, label %8

8:                                                ; preds = %3
  %9 = and i32 %6, -8
  %10 = sub i32 %0, %9
  %11 = insertelement <4 x i32> poison, i32 %0, i64 0
  %12 = shufflevector <4 x i32> %11, <4 x i32> poison, <4 x i32> zeroinitializer
  %13 = add <4 x i32> %12, <i32 0, i32 -1, i32 -2, i32 -3>
  %14 = add i32 %9, -8
  %15 = lshr exact i32 %14, 3
  %16 = add nuw nsw i32 %15, 1
  %17 = and i32 %16, 3
  %18 = icmp ult i32 %14, 24
  br i1 %18, label %44, label %19

19:                                               ; preds = %8
  %20 = and i32 %16, 1073741820
  br label %21

21:                                               ; preds = %21, %19
  %22 = phi <4 x i32> [ %13, %19 ], [ %41, %21 ]
  %23 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %19 ], [ %39, %21 ]
  %24 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %19 ], [ %40, %21 ]
  %25 = phi i32 [ 0, %19 ], [ %42, %21 ]
  %26 = add <4 x i32> %22, <i32 -4, i32 -4, i32 -4, i32 -4>
  %27 = mul <4 x i32> %22, %23
  %28 = mul <4 x i32> %26, %24
  %29 = add <4 x i32> %22, <i32 -8, i32 -8, i32 -8, i32 -8>
  %30 = add <4 x i32> %22, <i32 -12, i32 -12, i32 -12, i32 -12>
  %31 = mul <4 x i32> %29, %27
  %32 = mul <4 x i32> %30, %28
  %33 = add <4 x i32> %22, <i32 -16, i32 -16, i32 -16, i32 -16>
  %34 = add <4 x i32> %22, <i32 -20, i32 -20, i32 -20, i32 -20>
  %35 = mul <4 x i32> %33, %31
  %36 = mul <4 x i32> %34, %32
  %37 = add <4 x i32> %22, <i32 -24, i32 -24, i32 -24, i32 -24>
  %38 = add <4 x i32> %22, <i32 -28, i32 -28, i32 -28, i32 -28>
  %39 = mul <4 x i32> %37, %35
  %40 = mul <4 x i32> %38, %36
  %41 = add <4 x i32> %22, <i32 -32, i32 -32, i32 -32, i32 -32>
  %42 = add i32 %25, 4
  %43 = icmp eq i32 %42, %20
  br i1 %43, label %44, label %21, !llvm.loop !7

44:                                               ; preds = %21, %8
  %45 = phi <4 x i32> [ undef, %8 ], [ %39, %21 ]
  %46 = phi <4 x i32> [ undef, %8 ], [ %40, %21 ]
  %47 = phi <4 x i32> [ %13, %8 ], [ %41, %21 ]
  %48 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %8 ], [ %39, %21 ]
  %49 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %8 ], [ %40, %21 ]
  %50 = icmp eq i32 %17, 0
  br i1 %50, label %62, label %51

51:                                               ; preds = %44, %51
  %52 = phi <4 x i32> [ %59, %51 ], [ %47, %44 ]
  %53 = phi <4 x i32> [ %57, %51 ], [ %48, %44 ]
  %54 = phi <4 x i32> [ %58, %51 ], [ %49, %44 ]
  %55 = phi i32 [ %60, %51 ], [ 0, %44 ]
  %56 = add <4 x i32> %52, <i32 -4, i32 -4, i32 -4, i32 -4>
  %57 = mul <4 x i32> %52, %53
  %58 = mul <4 x i32> %56, %54
  %59 = add <4 x i32> %52, <i32 -8, i32 -8, i32 -8, i32 -8>
  %60 = add i32 %55, 1
  %61 = icmp eq i32 %60, %17
  br i1 %61, label %62, label %51, !llvm.loop !9

62:                                               ; preds = %51, %44
  %63 = phi <4 x i32> [ %45, %44 ], [ %57, %51 ]
  %64 = phi <4 x i32> [ %46, %44 ], [ %58, %51 ]
  %65 = mul <4 x i32> %64, %63
  %66 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %65)
  %67 = icmp eq i32 %6, %9
  br i1 %67, label %77, label %68

68:                                               ; preds = %3, %62
  %69 = phi i32 [ %0, %3 ], [ %10, %62 ]
  %70 = phi i32 [ 1, %3 ], [ %66, %62 ]
  br label %71

71:                                               ; preds = %68, %71
  %72 = phi i32 [ %74, %71 ], [ %69, %68 ]
  %73 = phi i32 [ %75, %71 ], [ %70, %68 ]
  %74 = add nsw i32 %72, -1
  %75 = mul nsw i32 %72, %73
  %76 = icmp ult i32 %72, 3
  br i1 %76, label %77, label %71, !llvm.loop !11

77:                                               ; preds = %71, %62, %1
  %78 = phi i32 [ 1, %1 ], [ %66, %62 ], [ %75, %71 ]
  ret i32 %78
}

; Function Attrs: nofree nosync nounwind uwtable
define dso_local i32 @fibonacci(i32 noundef %0) local_unnamed_addr #2 {
  %2 = load i32, i32* @globalCounter, align 4, !tbaa !13
  %3 = add nsw i32 %2, 1
  store i32 %3, i32* @globalCounter, align 4, !tbaa !13
  %4 = icmp slt i32 %0, 2
  br i1 %4, label %15, label %5

5:                                                ; preds = %1, %5
  %6 = phi i32 [ %10, %5 ], [ %0, %1 ]
  %7 = phi i32 [ %11, %5 ], [ 0, %1 ]
  %8 = add nsw i32 %6, -1
  %9 = tail call i32 @fibonacci(i32 noundef %8)
  %10 = add nsw i32 %6, -2
  %11 = add nsw i32 %9, %7
  %12 = load i32, i32* @globalCounter, align 4, !tbaa !13
  %13 = add nsw i32 %12, 1
  store i32 %13, i32* @globalCounter, align 4, !tbaa !13
  %14 = icmp ult i32 %6, 4
  br i1 %14, label %15, label %5

15:                                               ; preds = %5, %1
  %16 = phi i32 [ 0, %1 ], [ %11, %5 ]
  %17 = phi i32 [ %0, %1 ], [ %10, %5 ]
  %18 = add nsw i32 %17, %16
  ret i32 %18
}

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local i32 @complexCalculation(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp slt i32 %1, %0
  br i1 %3, label %4, label %12

4:                                                ; preds = %2
  %5 = icmp sgt i32 %0, 1000
  %6 = select i1 %5, i32 1, i32 %0
  %7 = mul nsw i32 %6, %0
  %8 = icmp sgt i32 %1, 1000
  %9 = select i1 %8, i32 1, i32 %1
  %10 = mul nsw i32 %9, %1
  %11 = sub nsw i32 %7, %10
  br label %95

12:                                               ; preds = %2
  %13 = icmp sgt i32 %1, %0
  br i1 %13, label %14, label %92

14:                                               ; preds = %12
  %15 = sub i32 %1, %0
  %16 = icmp slt i32 %15, 2
  br i1 %16, label %106, label %17

17:                                               ; preds = %14
  %18 = add i32 %1, 1
  %19 = call i32 @llvm.umin.i32(i32 %15, i32 2)
  %20 = add i32 %19, %0
  %21 = sub i32 %18, %20
  %22 = icmp ult i32 %21, 8
  br i1 %22, label %83, label %23

23:                                               ; preds = %17
  %24 = and i32 %21, -8
  %25 = sub i32 %15, %24
  %26 = insertelement <4 x i32> poison, i32 %15, i64 0
  %27 = shufflevector <4 x i32> %26, <4 x i32> poison, <4 x i32> zeroinitializer
  %28 = add <4 x i32> %27, <i32 0, i32 -1, i32 -2, i32 -3>
  %29 = add i32 %24, -8
  %30 = lshr exact i32 %29, 3
  %31 = add nuw nsw i32 %30, 1
  %32 = and i32 %31, 3
  %33 = icmp ult i32 %29, 24
  br i1 %33, label %59, label %34

34:                                               ; preds = %23
  %35 = and i32 %31, 1073741820
  br label %36

36:                                               ; preds = %36, %34
  %37 = phi <4 x i32> [ %28, %34 ], [ %56, %36 ]
  %38 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %34 ], [ %54, %36 ]
  %39 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %34 ], [ %55, %36 ]
  %40 = phi i32 [ 0, %34 ], [ %57, %36 ]
  %41 = add <4 x i32> %37, <i32 -4, i32 -4, i32 -4, i32 -4>
  %42 = mul <4 x i32> %38, %37
  %43 = mul <4 x i32> %39, %41
  %44 = add <4 x i32> %37, <i32 -8, i32 -8, i32 -8, i32 -8>
  %45 = add <4 x i32> %37, <i32 -12, i32 -12, i32 -12, i32 -12>
  %46 = mul <4 x i32> %42, %44
  %47 = mul <4 x i32> %43, %45
  %48 = add <4 x i32> %37, <i32 -16, i32 -16, i32 -16, i32 -16>
  %49 = add <4 x i32> %37, <i32 -20, i32 -20, i32 -20, i32 -20>
  %50 = mul <4 x i32> %46, %48
  %51 = mul <4 x i32> %47, %49
  %52 = add <4 x i32> %37, <i32 -24, i32 -24, i32 -24, i32 -24>
  %53 = add <4 x i32> %37, <i32 -28, i32 -28, i32 -28, i32 -28>
  %54 = mul <4 x i32> %50, %52
  %55 = mul <4 x i32> %51, %53
  %56 = add <4 x i32> %37, <i32 -32, i32 -32, i32 -32, i32 -32>
  %57 = add i32 %40, 4
  %58 = icmp eq i32 %57, %35
  br i1 %58, label %59, label %36, !llvm.loop !17

59:                                               ; preds = %36, %23
  %60 = phi <4 x i32> [ undef, %23 ], [ %54, %36 ]
  %61 = phi <4 x i32> [ undef, %23 ], [ %55, %36 ]
  %62 = phi <4 x i32> [ %28, %23 ], [ %56, %36 ]
  %63 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %23 ], [ %54, %36 ]
  %64 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %23 ], [ %55, %36 ]
  %65 = icmp eq i32 %32, 0
  br i1 %65, label %77, label %66

66:                                               ; preds = %59, %66
  %67 = phi <4 x i32> [ %74, %66 ], [ %62, %59 ]
  %68 = phi <4 x i32> [ %72, %66 ], [ %63, %59 ]
  %69 = phi <4 x i32> [ %73, %66 ], [ %64, %59 ]
  %70 = phi i32 [ %75, %66 ], [ 0, %59 ]
  %71 = add <4 x i32> %67, <i32 -4, i32 -4, i32 -4, i32 -4>
  %72 = mul <4 x i32> %68, %67
  %73 = mul <4 x i32> %69, %71
  %74 = add <4 x i32> %67, <i32 -8, i32 -8, i32 -8, i32 -8>
  %75 = add i32 %70, 1
  %76 = icmp eq i32 %75, %32
  br i1 %76, label %77, label %66, !llvm.loop !18

77:                                               ; preds = %66, %59
  %78 = phi <4 x i32> [ %60, %59 ], [ %72, %66 ]
  %79 = phi <4 x i32> [ %61, %59 ], [ %73, %66 ]
  %80 = mul <4 x i32> %79, %78
  %81 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %80)
  %82 = icmp eq i32 %21, %24
  br i1 %82, label %95, label %83

83:                                               ; preds = %17, %77
  %84 = phi i32 [ %15, %17 ], [ %25, %77 ]
  %85 = phi i32 [ 1, %17 ], [ %81, %77 ]
  br label %86

86:                                               ; preds = %83, %86
  %87 = phi i32 [ %89, %86 ], [ %84, %83 ]
  %88 = phi i32 [ %90, %86 ], [ %85, %83 ]
  %89 = add nsw i32 %87, -1
  %90 = mul nsw i32 %88, %87
  %91 = icmp ult i32 %87, 3
  br i1 %91, label %95, label %86, !llvm.loop !19

92:                                               ; preds = %12
  %93 = mul nsw i32 %1, %0
  %94 = add nsw i32 %93, 10
  br label %95

95:                                               ; preds = %86, %77, %92, %4
  %96 = phi i32 [ %11, %4 ], [ %94, %92 ], [ %81, %77 ], [ %90, %86 ]
  %97 = icmp sgt i32 %96, 10
  br i1 %97, label %98, label %106

98:                                               ; preds = %95
  %99 = add nuw i32 %96, 9
  %100 = call i32 @llvm.umin.i32(i32 %96, i32 20)
  %101 = sub nuw i32 %99, %100
  %102 = urem i32 %101, 10
  %103 = sub nsw i32 %102, %101
  %104 = add nsw i32 %96, -10
  %105 = add nsw i32 %103, %104
  br label %106

106:                                              ; preds = %98, %14, %95
  %107 = phi i32 [ %96, %95 ], [ 1, %14 ], [ %105, %98 ]
  ret i32 %107
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define dso_local void @nestedScopesTest() local_unnamed_addr #3 {
  %1 = load i32, i32* @globalCounter, align 4, !tbaa !13
  %2 = add nsw i32 %1, 9
  store i32 %2, i32* @globalCounter, align 4, !tbaa !13
  ret void
}

; Function Attrs: nofree nosync nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #2 {
  %1 = tail call i32 @fibonacci(i32 noundef 5)
  %2 = load i32, i32* @globalCounter, align 4, !tbaa !13
  %3 = add nsw i32 %2, 9
  store i32 %3, i32* @globalCounter, align 4, !tbaa !13
  %4 = add nsw i32 %1, 2
  %5 = add nsw i32 %4, %3
  %6 = add nsw i32 %5, 152
  ret i32 %6
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #4

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #4

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #5

attributes #0 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { nofree nosync nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !8}
!8 = !{!"llvm.loop.isvectorized", i32 1}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.unroll.disable"}
!11 = distinct !{!11, !12, !8}
!12 = !{!"llvm.loop.unroll.runtime.disable"}
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !15, i64 0}
!15 = !{!"omnipotent char", !16, i64 0}
!16 = !{!"Simple C/C++ TBAA"}
!17 = distinct !{!17, !8}
!18 = distinct !{!18, !10}
!19 = distinct !{!19, !12, !8}
