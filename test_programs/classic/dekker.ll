; ModuleID = 'dekker.c'
source_filename = "dekker.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@flag1 = dso_local global i32 0, align 4
@flag2 = dso_local global i32 0, align 4
@turn = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i32 1, i32* @flag1, align 4
  br label %4

4:                                                ; preds = %16, %1
  %5 = load i32, i32* @flag2, align 4
  %6 = icmp sge i32 %5, 1
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  %8 = load i32, i32* @turn, align 4
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  store i32 0, i32* @flag1, align 4
  br label %11

11:                                               ; preds = %14, %10
  %12 = load i32, i32* @turn, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  br label %11, !llvm.loop !2

15:                                               ; preds = %11
  store i32 1, i32* @flag1, align 4
  br label %16

16:                                               ; preds = %15, %7
  br label %4, !llvm.loop !4

17:                                               ; preds = %4
  store i32 1, i32* @turn, align 4
  store i32 0, i32* @flag1, align 4
  %18 = load i8*, i8** %2, align 8
  ret i8* %18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i32 1, i32* @flag2, align 4
  br label %4

4:                                                ; preds = %16, %1
  %5 = load i32, i32* @flag1, align 4
  %6 = icmp sge i32 %5, 1
  br i1 %6, label %7, label %17

7:                                                ; preds = %4
  %8 = load i32, i32* @turn, align 4
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  store i32 0, i32* @flag2, align 4
  br label %11

11:                                               ; preds = %14, %10
  %12 = load i32, i32* @turn, align 4
  %13 = icmp ne i32 %12, 1
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  br label %11, !llvm.loop !5

15:                                               ; preds = %11
  store i32 1, i32* @flag2, align 4
  br label %16

16:                                               ; preds = %15, %7
  br label %4, !llvm.loop !6

17:                                               ; preds = %4
  store i32 1, i32* @turn, align 4
  store i32 0, i32* @flag2, align 4
  %18 = load i8*, i8** %2, align 8
  ret i8* %18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  br label %1

1:                                                ; preds = %0
  %2 = call i8* @thr1(i8* null)
  %3 = call i8* @thr2(i8* null)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
!6 = distinct !{!6, !3}
