; ModuleID = 'test4.c'
source_filename = "test4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@globalVar = dso_local local_unnamed_addr global i32 100, align 4
@GLOBAL_CONST = dso_local local_unnamed_addr constant i32 1024, align 4

; Function Attrs: nofree norecurse nosync nounwind readonly uwtable
define dso_local i32 @complexFunction(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp sgt i32 %0, %1
  br i1 %3, label %4, label %6

4:                                                ; preds = %2
  %5 = sub nsw i32 %0, %1
  br label %21

6:                                                ; preds = %2
  %7 = icmp slt i32 %0, %1
  br i1 %7, label %8, label %19

8:                                                ; preds = %6
  %9 = sub nsw i32 %1, %0
  %10 = icmp slt i32 %9, 1024
  br i1 %10, label %11, label %21

11:                                               ; preds = %8
  %12 = load i32, i32* @globalVar, align 4, !tbaa !5
  br label %13

13:                                               ; preds = %11, %13
  %14 = phi i32 [ %15, %13 ], [ %9, %11 ]
  %15 = shl nsw i32 %14, 1
  %16 = icmp sle i32 %15, %12
  %17 = icmp slt i32 %14, 512
  %18 = and i1 %17, %16
  br i1 %18, label %13, label %21, !llvm.loop !9

19:                                               ; preds = %6
  %20 = mul nsw i32 %1, %0
  br label %21

21:                                               ; preds = %13, %19, %8, %4
  %22 = phi i32 [ %5, %4 ], [ %9, %8 ], [ %20, %19 ], [ %15, %13 ]
  ret i32 %22
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local void @nestedBlocks() local_unnamed_addr #1 {
  ret void
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #2 {
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
  br i1 %43, label %44, label %21, !llvm.loop !11

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
  br i1 %61, label %62, label %51, !llvm.loop !13

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
  br i1 %76, label %77, label %71, !llvm.loop !15

77:                                               ; preds = %71, %62, %1
  %78 = phi i32 [ 1, %1 ], [ %66, %62 ], [ %75, %71 ]
  ret i32 %78
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @mixedOperations(i32 noundef %0, i32 noundef %1) local_unnamed_addr #1 {
  %3 = add nsw i32 %1, %0
  %4 = sub nsw i32 %0, %1
  %5 = mul nsw i32 %3, %4
  %6 = srem i32 %5, 1024
  %7 = add nsw i32 %1, 1
  %8 = sdiv i32 %6, %7
  ret i32 %8
}

; Function Attrs: nofree norecurse nosync nounwind readonly uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  %1 = load i32, i32* @globalVar, align 4, !tbaa !5
  %2 = icmp sgt i32 %1, 42
  br i1 %2, label %3, label %5

3:                                                ; preds = %0
  %4 = add nsw i32 %1, -42
  br label %16

5:                                                ; preds = %0
  %6 = icmp eq i32 %1, 42
  br i1 %6, label %16, label %7

7:                                                ; preds = %5
  %8 = sub nsw i32 42, %1
  %9 = icmp ult i32 %8, 1024
  br i1 %9, label %10, label %16

10:                                               ; preds = %7, %10
  %11 = phi i32 [ %12, %10 ], [ %8, %7 ]
  %12 = shl nsw i32 %11, 1
  %13 = icmp sle i32 %12, %1
  %14 = icmp slt i32 %11, 512
  %15 = and i1 %14, %13
  br i1 %15, label %10, label %16, !llvm.loop !9

16:                                               ; preds = %10, %5, %3, %7
  %17 = phi i32 [ %4, %3 ], [ %8, %7 ], [ 1764, %5 ], [ %12, %10 ]
  br label %18

18:                                               ; preds = %36, %16
  %19 = phi i32 [ 0, %16 ], [ %30, %36 ]
  %20 = phi i32 [ 0, %16 ], [ %37, %36 ]
  %21 = add nsw i32 %20, %17
  %22 = sub nsw i32 %17, %20
  %23 = mul nsw i32 %21, %22
  %24 = srem i32 %23, 1024
  %25 = add nuw nsw i32 %20, 1
  %26 = trunc i32 %24 to i16
  %27 = trunc i32 %25 to i16
  %28 = sdiv i16 %26, %27
  %29 = sext i16 %28 to i32
  %30 = add nsw i32 %19, %29
  %31 = icmp eq i32 %25, 3
  br i1 %31, label %36, label %32

32:                                               ; preds = %18
  %33 = icmp slt i32 %30, 1001
  %34 = icmp ult i32 %20, 4
  %35 = and i1 %34, %33
  br i1 %35, label %36, label %38

36:                                               ; preds = %32, %18
  %37 = phi i32 [ %25, %32 ], [ 3, %18 ]
  br label %18, !llvm.loop !17

38:                                               ; preds = %32
  %39 = srem i32 %30, 6
  %40 = icmp slt i32 %39, 2
  br i1 %40, label %115, label %41

41:                                               ; preds = %38
  %42 = add nsw i32 %39, 1
  %43 = call i32 @llvm.umin.i32(i32 %39, i32 2)
  %44 = sub nsw i32 %42, %43
  %45 = icmp ult i32 %44, 8
  br i1 %45, label %106, label %46

46:                                               ; preds = %41
  %47 = and i32 %44, -8
  %48 = sub nsw i32 %39, %47
  %49 = insertelement <4 x i32> poison, i32 %39, i64 0
  %50 = shufflevector <4 x i32> %49, <4 x i32> poison, <4 x i32> zeroinitializer
  %51 = add <4 x i32> %50, <i32 0, i32 -1, i32 -2, i32 -3>
  %52 = add nsw i32 %47, -8
  %53 = lshr exact i32 %52, 3
  %54 = add nuw nsw i32 %53, 1
  %55 = and i32 %54, 3
  %56 = icmp ult i32 %52, 24
  br i1 %56, label %82, label %57

57:                                               ; preds = %46
  %58 = and i32 %54, 1073741820
  br label %59

59:                                               ; preds = %59, %57
  %60 = phi <4 x i32> [ %51, %57 ], [ %79, %59 ]
  %61 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %57 ], [ %77, %59 ]
  %62 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %57 ], [ %78, %59 ]
  %63 = phi i32 [ 0, %57 ], [ %80, %59 ]
  %64 = add <4 x i32> %60, <i32 -4, i32 -4, i32 -4, i32 -4>
  %65 = mul <4 x i32> %61, %60
  %66 = mul <4 x i32> %62, %64
  %67 = add <4 x i32> %60, <i32 -8, i32 -8, i32 -8, i32 -8>
  %68 = add <4 x i32> %60, <i32 -12, i32 -12, i32 -12, i32 -12>
  %69 = mul <4 x i32> %65, %67
  %70 = mul <4 x i32> %66, %68
  %71 = add <4 x i32> %60, <i32 -16, i32 -16, i32 -16, i32 -16>
  %72 = add <4 x i32> %60, <i32 -20, i32 -20, i32 -20, i32 -20>
  %73 = mul <4 x i32> %69, %71
  %74 = mul <4 x i32> %70, %72
  %75 = add <4 x i32> %60, <i32 -24, i32 -24, i32 -24, i32 -24>
  %76 = add <4 x i32> %60, <i32 -28, i32 -28, i32 -28, i32 -28>
  %77 = mul <4 x i32> %73, %75
  %78 = mul <4 x i32> %74, %76
  %79 = add <4 x i32> %60, <i32 -32, i32 -32, i32 -32, i32 -32>
  %80 = add i32 %63, 4
  %81 = icmp eq i32 %80, %58
  br i1 %81, label %82, label %59, !llvm.loop !18

82:                                               ; preds = %59, %46
  %83 = phi <4 x i32> [ undef, %46 ], [ %77, %59 ]
  %84 = phi <4 x i32> [ undef, %46 ], [ %78, %59 ]
  %85 = phi <4 x i32> [ %51, %46 ], [ %79, %59 ]
  %86 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %46 ], [ %77, %59 ]
  %87 = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, %46 ], [ %78, %59 ]
  %88 = icmp eq i32 %55, 0
  br i1 %88, label %100, label %89

89:                                               ; preds = %82, %89
  %90 = phi <4 x i32> [ %97, %89 ], [ %85, %82 ]
  %91 = phi <4 x i32> [ %95, %89 ], [ %86, %82 ]
  %92 = phi <4 x i32> [ %96, %89 ], [ %87, %82 ]
  %93 = phi i32 [ %98, %89 ], [ 0, %82 ]
  %94 = add <4 x i32> %90, <i32 -4, i32 -4, i32 -4, i32 -4>
  %95 = mul <4 x i32> %91, %90
  %96 = mul <4 x i32> %92, %94
  %97 = add <4 x i32> %90, <i32 -8, i32 -8, i32 -8, i32 -8>
  %98 = add i32 %93, 1
  %99 = icmp eq i32 %98, %55
  br i1 %99, label %100, label %89, !llvm.loop !19

100:                                              ; preds = %89, %82
  %101 = phi <4 x i32> [ %83, %82 ], [ %95, %89 ]
  %102 = phi <4 x i32> [ %84, %82 ], [ %96, %89 ]
  %103 = mul <4 x i32> %102, %101
  %104 = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> %103)
  %105 = icmp eq i32 %44, %47
  br i1 %105, label %115, label %106

106:                                              ; preds = %41, %100
  %107 = phi i32 [ %39, %41 ], [ %48, %100 ]
  %108 = phi i32 [ 1, %41 ], [ %104, %100 ]
  br label %109

109:                                              ; preds = %106, %109
  %110 = phi i32 [ %112, %109 ], [ %107, %106 ]
  %111 = phi i32 [ %113, %109 ], [ %108, %106 ]
  %112 = add nsw i32 %110, -1
  %113 = mul nsw i32 %111, %110
  %114 = icmp ult i32 %110, 3
  br i1 %114, label %115, label %109, !llvm.loop !20

115:                                              ; preds = %109, %100, %38
  %116 = phi i32 [ 1, %38 ], [ %104, %100 ], [ %113, %109 ]
  %117 = icmp sgt i32 %116, 10
  %118 = icmp slt i32 %17, 200
  %119 = select i1 %117, i1 %118, i1 false
  %120 = icmp eq i32 %30, 0
  %121 = select i1 %119, i1 true, i1 %120
  %122 = select i1 %121, i32 %1, i32 -1024
  %123 = add nsw i32 %122, %116
  ret i32 %123
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #3

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #4

attributes #0 = { nofree norecurse nosync nounwind readonly uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nofree nosync nounwind readnone willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.unroll.disable"}
!15 = distinct !{!15, !16, !12}
!16 = !{!"llvm.loop.unroll.runtime.disable"}
!17 = distinct !{!17, !10}
!18 = distinct !{!18, !12}
!19 = distinct !{!19, !14}
!20 = distinct !{!20, !16, !12}
