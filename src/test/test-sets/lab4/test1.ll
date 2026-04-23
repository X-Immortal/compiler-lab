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
entry:
  ret void
}

; Function Attrs: nofree norecurse nosync nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
entry:
  %x.promoted = load i32, i32* @x, align 4, !tbaa !5
  br label %while.body

while.body:                                       ; preds = %entry, %if.end
  %i.09 = phi i32 [ 0, %entry ], [ %add2, %if.end ]
  %0 = phi i32 [ %x.promoted, %entry ], [ %1, %if.end ]
  %rem = and i32 %i.09, 1
  %cmp1 = icmp eq i32 %rem, 0
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %while.body
  %add = add nsw i32 %0, %i.09
  store i32 %add, i32* @x, align 4, !tbaa !5
  br label %if.end

if.else:                                          ; preds = %while.body
  %mul = mul nsw i32 %0, %i.09
  store i32 %mul, i32* @y, align 4, !tbaa !5
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %1 = phi i32 [ %0, %if.else ], [ %add, %if.then ]
  %add2 = add nuw nsw i32 %i.09, 1
  %exitcond.not = icmp eq i32 %add2, 10
  br i1 %exitcond.not, label %while.end, label %while.body, !llvm.loop !9

while.end:                                        ; preds = %if.end
  ret i32 0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @sum(i32 %x, i32 %y) local_unnamed_addr #0 {
entry:
  ret i32 30
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local void @test() local_unnamed_addr #0 {
entry:
  ret void
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %n) local_unnamed_addr #2 {
entry:
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.else

if.else:                                          ; preds = %entry
  %sub = add nsw i32 %n, -1
  %call = call i32 @factorial(i32 noundef %sub)
  %mul = mul nsw i32 %call, %n
  br label %return

return:                                           ; preds = %entry, %if.else
  %retval.0 = phi i32 [ %mul, %if.else ], [ 1, %entry ]
  ret i32 %retval.0
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local void @calculate() local_unnamed_addr #2 {
entry:
  %call = call i32 @factorial(i32 noundef 5)
  ret void
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!9 = distinct !{!9, !10, !11}
!10 = !{!"llvm.loop.mustprogress"}
!11 = !{!"llvm.loop.unroll.disable"}
