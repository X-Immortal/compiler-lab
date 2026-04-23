; ModuleID = 'test4.c'
source_filename = "test4.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@globalVar = dso_local local_unnamed_addr global i32 100, align 4
@GLOBAL_CONST = dso_local local_unnamed_addr constant i32 1024, align 4

; Function Attrs: nofree norecurse nosync nounwind readonly uwtable
define dso_local i32 @complexFunction(i32 noundef %param1, i32 noundef %param2) local_unnamed_addr #0 {
entry:
  %cmp = icmp sgt i32 %param1, %param2
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %sub = sub nsw i32 %param1, %param2
  br label %if.end10

if.else:                                          ; preds = %entry
  %cmp1 = icmp slt i32 %param1, %param2
  br i1 %cmp1, label %if.then2, label %if.else7

if.then2:                                         ; preds = %if.else
  %sub3 = sub nsw i32 %param2, %param1
  %cmp4.old = icmp slt i32 %sub3, 1024
  br i1 %cmp4.old, label %while.body.preheader, label %if.end10

while.body.preheader:                             ; preds = %if.then2
  %0 = load i32, i32* @globalVar, align 4, !tbaa !5
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %localResult.0 = phi i32 [ %mul, %while.body ], [ %sub3, %while.body.preheader ]
  %mul = shl nsw i32 %localResult.0, 1
  %cmp5 = icmp sle i32 %mul, %0
  %cmp4 = icmp slt i32 %localResult.0, 512
  %or.cond = and i1 %cmp4, %cmp5
  br i1 %or.cond, label %while.body, label %if.end10, !llvm.loop !9

if.else7:                                         ; preds = %if.else
  %mul8 = mul nsw i32 %param2, %param1
  br label %if.end10

if.end10:                                         ; preds = %while.body, %if.else7, %if.then2, %if.then
  %localResult.1 = phi i32 [ %sub, %if.then ], [ %sub3, %if.then2 ], [ %mul8, %if.else7 ], [ %mul, %while.body ]
  ret i32 %localResult.1
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local void @nestedBlocks() local_unnamed_addr #1 {
entry:
  ret void
}

; Function Attrs: nofree nosync nounwind readnone uwtable
define dso_local i32 @factorial(i32 noundef %n) local_unnamed_addr #2 {
entry:
  %cmp = icmp slt i32 %n, 2
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %sub = add nsw i32 %n, -1
  %call = call i32 @factorial(i32 noundef %sub)
  %mul = mul nsw i32 %call, %n
  br label %return

return:                                           ; preds = %entry, %if.end
  %retval.0 = phi i32 [ %mul, %if.end ], [ 1, %entry ]
  ret i32 %retval.0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @mixedOperations(i32 noundef %a, i32 noundef %b) local_unnamed_addr #1 {
entry:
  %add = add nsw i32 %b, %a
  %sub = sub nsw i32 %a, %b
  %mul = mul nsw i32 %add, %sub
  %rem = srem i32 %mul, 1024
  %add1 = add nsw i32 %b, 1
  %div = sdiv i32 %rem, %add1
  ret i32 %div
}

; Function Attrs: nofree nosync nounwind readonly uwtable
define dso_local i32 @main() local_unnamed_addr #3 {
entry:
  %0 = load i32, i32* @globalVar, align 4, !tbaa !5
  %cmp.i = icmp sgt i32 %0, 42
  br i1 %cmp.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %entry
  %sub.i = add nsw i32 %0, -42
  br label %complexFunction.exit

if.else.i:                                        ; preds = %entry
  %cmp1.i.not = icmp eq i32 %0, 42
  br i1 %cmp1.i.not, label %if.else7.i, label %if.then2.i

if.then2.i:                                       ; preds = %if.else.i
  %sub3.i = sub nsw i32 42, %0
  %cmp4.old.i = icmp sgt i32 %0, -982
  br i1 %cmp4.old.i, label %while.body.i, label %complexFunction.exit

while.body.i:                                     ; preds = %if.then2.i, %while.body.i
  %localResult.0.i = phi i32 [ %mul.i, %while.body.i ], [ %sub3.i, %if.then2.i ]
  %mul.i = shl nsw i32 %localResult.0.i, 1
  %cmp5.i = icmp sle i32 %mul.i, %0
  %cmp4.i = icmp slt i32 %localResult.0.i, 512
  %or.cond.i = and i1 %cmp4.i, %cmp5.i
  br i1 %or.cond.i, label %while.body.i, label %complexFunction.exit, !llvm.loop !9

if.else7.i:                                       ; preds = %if.else.i
  %mul8.i = mul nsw i32 %0, 42
  br label %complexFunction.exit

complexFunction.exit:                             ; preds = %while.body.i, %if.then.i, %if.then2.i, %if.else7.i
  %localResult.1.i = phi i32 [ %sub.i, %if.then.i ], [ %sub3.i, %if.then2.i ], [ %mul8.i, %if.else7.i ], [ %mul.i, %while.body.i ]
  br label %while.body

while.body:                                       ; preds = %while.body.backedge, %complexFunction.exit
  %result2.1 = phi i32 [ 0, %complexFunction.exit ], [ %add, %while.body.backedge ]
  %counter.1 = phi i32 [ 0, %complexFunction.exit ], [ %counter.1.be, %while.body.backedge ]
  %add.i = add nsw i32 %counter.1, %localResult.1.i
  %sub.i32 = sub nsw i32 %localResult.1.i, %counter.1
  %mul.i33 = mul nsw i32 %add.i, %sub.i32
  %rem.i = srem i32 %mul.i33, 1024
  %add1.i = add nuw nsw i32 %counter.1, 1
  %div.i = sdiv i32 %rem.i, %add1.i
  %add = add nsw i32 %div.i, %result2.1
  %cmp3 = icmp eq i32 %add1.i, 3
  br i1 %cmp3, label %while.body.backedge, label %if.end

if.end:                                           ; preds = %while.body
  %cmp4 = icmp slt i32 %add, 1001
  %cmp = icmp ult i32 %counter.1, 4
  %or.cond15 = and i1 %cmp, %cmp4
  br i1 %or.cond15, label %while.body.backedge, label %while.end

while.body.backedge:                              ; preds = %if.end, %while.body
  %counter.1.be = phi i32 [ %add1.i, %if.end ], [ 3, %while.body ]
  br label %while.body, !llvm.loop !12

while.end:                                        ; preds = %if.end
  %rem = srem i32 %add, 6
  %call7 = call i32 @factorial(i32 noundef %rem)
  %cmp8 = icmp sgt i32 %call7, 10
  %cmp9 = icmp slt i32 %localResult.1.i, 200
  %or.cond = select i1 %cmp8, i1 %cmp9, i1 false
  %cmp10 = icmp eq i32 %add, 0
  %or.cond14 = select i1 %or.cond, i1 true, i1 %cmp10
  %.pn = select i1 %or.cond14, i32 %0, i32 -1024
  %finalResult.0 = add nsw i32 %.pn, %call7
  ret i32 %finalResult.0
}

attributes #0 = { nofree norecurse nosync nounwind readonly uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nofree nosync nounwind readnone uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nofree nosync nounwind readonly uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
!12 = distinct !{!12, !10, !11}
