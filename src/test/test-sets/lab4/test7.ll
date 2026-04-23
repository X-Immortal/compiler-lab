; ModuleID = 'test7.c'
source_filename = "test7.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@count = dso_local local_unnamed_addr global i32 0, align 4
@n = dso_local local_unnamed_addr global i32 3, align 4

; Function Attrs: nofree nosync nounwind uwtable
define dso_local void @hanoi(i32 noundef %n, i32 noundef %source, i32 noundef %target, i32 noundef %auxiliary) local_unnamed_addr #0 {
entry:
  %cmp = icmp eq i32 %n, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load i32, i32* @count, align 4, !tbaa !5
  %add = add nsw i32 %0, 1
  store i32 %add, i32* @count, align 4, !tbaa !5
  br label %return

if.end:                                           ; preds = %entry
  %sub = add nsw i32 %n, -1
  call void @hanoi(i32 noundef %sub, i32 noundef %source, i32 noundef %auxiliary, i32 noundef %target)
  %1 = load i32, i32* @count, align 4, !tbaa !5
  %add1 = add nsw i32 %1, 1
  store i32 %add1, i32* @count, align 4, !tbaa !5
  call void @hanoi(i32 noundef %sub, i32 noundef %auxiliary, i32 noundef %target, i32 noundef %source)
  br label %return

return:                                           ; preds = %if.end, %if.then
  ret void
}

; Function Attrs: nofree nosync nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  %0 = load i32, i32* @n, align 4, !tbaa !5
  call void @hanoi(i32 noundef %0, i32 noundef 1, i32 noundef 3, i32 noundef 2)
  %1 = load i32, i32* @count, align 4, !tbaa !5
  ret i32 %1
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
