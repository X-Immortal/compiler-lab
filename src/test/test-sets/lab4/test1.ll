; ModuleID = 'test1.c'
source_filename = "test1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = dso_local local_unnamed_addr constant i32 10, align 4
@b = dso_local local_unnamed_addr constant i32 20, align 4
@x = dso_local local_unnamed_addr global i32 5, align 4
@y = dso_local local_unnamed_addr global i32 10, align 4

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local void @do_nothing() local_unnamed_addr #0 {
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
  %1 = load i32, i32* @x, align 4, !tbaa !5
  %2 = add nsw i32 %1, 20
  store i32 %2, i32* @x, align 4, !tbaa !5
  %3 = mul i32 %2, 9
  store i32 %3, i32* @y, align 4, !tbaa !5
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @sum(i32 %0, i32 %1) local_unnamed_addr #0 {
  ret i32 30
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local void @test() local_unnamed_addr #0 {
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
  br i1 %43, label %44, label %21, !llvm.loop !9

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
  br i1 %61, label %62, label %51, !llvm.loop !11

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
  br i1 %76, label %77, label %71, !llvm.loop !13

77:                                               ; preds = %71, %62, %1
  %78 = phi i32 [ 1, %1 ], [ %66, %62 ], [ %75, %71 ]
  ret i32 %78
}

; Function Attrs: nofree norecurse nosync nounwind readnone uwtable
define dso_local void @calculate() local_unnamed_addr #3 {
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #4

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.mul.v4i32(<4 x i32>) #5

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree norecurse nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { nofree nosync nounwind readnone willreturn }

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
!10 = !{!"llvm.loop.isvectorized", i32 1}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = distinct !{!13, !14, !10}
!14 = !{!"llvm.loop.unroll.runtime.disable"}
