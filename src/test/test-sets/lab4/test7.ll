; ModuleID = 'test7.c'
source_filename = "test7.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@count = dso_local local_unnamed_addr global i32 0, align 4
@n = dso_local local_unnamed_addr global i32 3, align 4

; Function Attrs: nofree nosync nounwind uwtable
define dso_local void @hanoi(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = icmp eq i32 %0, 1
  br i1 %5, label %6, label %11

6:                                                ; preds = %4
  %7 = load i32, i32* @count, align 4, !tbaa !5
  br label %8

8:                                                ; preds = %11, %6
  %9 = phi i32 [ %7, %6 ], [ %17, %11 ]
  %10 = add nsw i32 %9, 1
  store i32 %10, i32* @count, align 4, !tbaa !5
  ret void

11:                                               ; preds = %4, %11
  %12 = phi i32 [ %13, %11 ], [ %3, %4 ]
  %13 = phi i32 [ %12, %11 ], [ %1, %4 ]
  %14 = phi i32 [ %15, %11 ], [ %0, %4 ]
  %15 = add nsw i32 %14, -1
  tail call void @hanoi(i32 noundef %15, i32 noundef %13, i32 noundef %12, i32 noundef %2)
  %16 = load i32, i32* @count, align 4, !tbaa !5
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* @count, align 4, !tbaa !5
  %18 = icmp eq i32 %15, 1
  br i1 %18, label %8, label %11
}

; Function Attrs: nofree nosync nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
  %1 = load i32, i32* @n, align 4, !tbaa !5
  tail call void @hanoi(i32 noundef %1, i32 noundef 1, i32 noundef 3, i32 noundef 2)
  %2 = load i32, i32* @count, align 4, !tbaa !5
  ret i32 %2
}

attributes #0 = { nofree nosync nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
