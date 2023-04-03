; ModuleID = 'szymanski.c'
source_filename = "szymanski.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@flag1 = dso_local global i32 0, align 4
@flag2 = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  br label %3

3:                                                ; preds = %1, %25
  store i32 1, i32* @flag1, align 4
  %4 = load i32, i32* @flag2, align 4
  %5 = icmp slt i32 %4, 3
  %6 = zext i1 %5 to i32
  %7 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %6)
  store i32 3, i32* @flag1, align 4
  %8 = load i32, i32* @flag2, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %15

10:                                               ; preds = %3
  store i32 2, i32* @flag1, align 4
  %11 = load i32, i32* @flag2, align 4
  %12 = icmp eq i32 %11, 4
  %13 = zext i1 %12 to i32
  %14 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %13)
  br label %15

15:                                               ; preds = %10, %3
  store i32 4, i32* @flag1, align 4
  %16 = load i32, i32* @flag2, align 4
  %17 = icmp slt i32 %16, 2
  %18 = zext i1 %17 to i32
  %19 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %18)
  %20 = load i32, i32* @flag2, align 4
  %21 = icmp sgt i32 2, %20
  br i1 %21, label %25, label %22

22:                                               ; preds = %15
  %23 = load i32, i32* @flag2, align 4
  %24 = icmp sgt i32 %23, 3
  br label %25

25:                                               ; preds = %22, %15
  %26 = phi i1 [ true, %15 ], [ %24, %22 ]
  %27 = zext i1 %26 to i32
  %28 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %27)
  store i32 0, i32* @flag1, align 4
  br label %3
}

declare dso_local i32 @__CPROVER_assume(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  br label %3

3:                                                ; preds = %1, %25
  store i32 1, i32* @flag2, align 4
  %4 = load i32, i32* @flag1, align 4
  %5 = icmp slt i32 %4, 3
  %6 = zext i1 %5 to i32
  %7 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %6)
  store i32 3, i32* @flag2, align 4
  %8 = load i32, i32* @flag1, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %15

10:                                               ; preds = %3
  store i32 2, i32* @flag2, align 4
  %11 = load i32, i32* @flag1, align 4
  %12 = icmp eq i32 %11, 4
  %13 = zext i1 %12 to i32
  %14 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %13)
  br label %15

15:                                               ; preds = %10, %3
  store i32 4, i32* @flag2, align 4
  %16 = load i32, i32* @flag1, align 4
  %17 = icmp slt i32 %16, 2
  %18 = zext i1 %17 to i32
  %19 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %18)
  %20 = load i32, i32* @flag1, align 4
  %21 = icmp sgt i32 2, %20
  br i1 %21, label %25, label %22

22:                                               ; preds = %15
  %23 = load i32, i32* @flag1, align 4
  %24 = icmp sgt i32 %23, 3
  br label %25

25:                                               ; preds = %22, %15
  %26 = phi i1 [ true, %15 ], [ %24, %22 ]
  %27 = zext i1 %26 to i32
  %28 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %27)
  store i32 0, i32* @flag2, align 4
  br label %3
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
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
