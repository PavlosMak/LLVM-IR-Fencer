; ModuleID = 'lamport.c'
source_filename = "lamport.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@b1 = dso_local global i32 0, align 4
@x = dso_local global i32 0, align 4
@y = dso_local global i32 0, align 4
@b2 = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  br label %4

4:                                                ; preds = %22, %7, %1
  store i32 1, i32* @b1, align 4
  store i32 1, i32* @x, align 4
  %5 = load i32, i32* @y, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %12

7:                                                ; preds = %4
  store i32 0, i32* @b1, align 4
  %8 = load i32, i32* @y, align 4
  %9 = icmp eq i32 %8, 0
  %10 = zext i1 %9 to i32
  %11 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %10)
  br label %4

12:                                               ; preds = %4
  store i32 1, i32* @y, align 4
  %13 = load i32, i32* @x, align 4
  %14 = icmp ne i32 %13, 1
  br i1 %14, label %15, label %28

15:                                               ; preds = %12
  store i32 0, i32* @b1, align 4
  %16 = load i32, i32* @b2, align 4
  %17 = icmp eq i32 %16, 0
  %18 = zext i1 %17 to i32
  %19 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %18)
  %20 = load i32, i32* @y, align 4
  %21 = icmp ne i32 %20, 1
  br i1 %21, label %22, label %27

22:                                               ; preds = %15
  %23 = load i32, i32* @y, align 4
  %24 = icmp eq i32 %23, 0
  %25 = zext i1 %24 to i32
  %26 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %25)
  br label %4

27:                                               ; preds = %15
  br label %28

28:                                               ; preds = %27, %12
  store i32 0, i32* @y, align 4
  store i32 0, i32* @b1, align 4
  %29 = load i8*, i8** %2, align 8
  ret i8* %29
}

declare dso_local i32 @__CPROVER_assume(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  br label %4

4:                                                ; preds = %22, %7, %1
  store i32 1, i32* @b2, align 4
  store i32 2, i32* @x, align 4
  %5 = load i32, i32* @y, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %12

7:                                                ; preds = %4
  store i32 0, i32* @b2, align 4
  %8 = load i32, i32* @y, align 4
  %9 = icmp eq i32 %8, 0
  %10 = zext i1 %9 to i32
  %11 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %10)
  br label %4

12:                                               ; preds = %4
  store i32 2, i32* @y, align 4
  %13 = load i32, i32* @x, align 4
  %14 = icmp ne i32 %13, 2
  br i1 %14, label %15, label %28

15:                                               ; preds = %12
  store i32 0, i32* @b2, align 4
  %16 = load i32, i32* @b1, align 4
  %17 = icmp eq i32 %16, 0
  %18 = zext i1 %17 to i32
  %19 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %18)
  %20 = load i32, i32* @y, align 4
  %21 = icmp ne i32 %20, 2
  br i1 %21, label %22, label %27

22:                                               ; preds = %15
  %23 = load i32, i32* @y, align 4
  %24 = icmp eq i32 %23, 0
  %25 = zext i1 %24 to i32
  %26 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %25)
  br label %4

27:                                               ; preds = %15
  br label %28

28:                                               ; preds = %27, %12
  store i32 0, i32* @y, align 4
  store i32 0, i32* @b2, align 4
  %29 = load i8*, i8** %2, align 8
  ret i8* %29
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
