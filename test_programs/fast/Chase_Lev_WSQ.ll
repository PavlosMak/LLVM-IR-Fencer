; ModuleID = 'Chase_Lev_WSQ.c'
source_filename = "Chase_Lev_WSQ.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@top = dso_local global i32 0, align 4
@bottom = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @pushBottom() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = load volatile i32, i32* @bottom, align 4
  store i32 %6, i32* %1, align 4
  %7 = load volatile i32, i32* @top, align 4
  store i32 %7, i32* %2, align 4
  %8 = load i32, i32* %1, align 4
  %9 = load i32, i32* %2, align 4
  %10 = sub nsw i32 %8, %9
  store i32 %10, i32* %3, align 4
  %11 = load i32, i32* %3, align 4
  %12 = call i32 (...) @nondet()
  %13 = sub nsw i32 %12, 1
  %14 = icmp sge i32 %11, %13
  br i1 %14, label %15, label %19

15:                                               ; preds = %0
  %16 = load i32, i32* %1, align 4
  %17 = load i32, i32* %2, align 4
  %18 = add nsw i32 %16, %17
  store i32 %18, i32* %4, align 4
  br label %19

19:                                               ; preds = %15, %0
  %20 = load i32, i32* %1, align 4
  store i32 %20, i32* %5, align 4
  %21 = load i32, i32* %1, align 4
  %22 = add nsw i32 %21, 1
  store volatile i32 %22, i32* @bottom, align 4
  ret void
}

declare dso_local i32 @nondet(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @popBottom() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = load volatile i32, i32* @bottom, align 4
  store i32 %6, i32* %2, align 4
  %7 = load i32, i32* %2, align 4
  %8 = sub nsw i32 %7, 1
  store i32 %8, i32* %2, align 4
  %9 = load i32, i32* %2, align 4
  store volatile i32 %9, i32* @bottom, align 4
  %10 = load volatile i32, i32* @top, align 4
  store i32 %10, i32* %3, align 4
  %11 = load i32, i32* %2, align 4
  %12 = load i32, i32* %3, align 4
  %13 = sub nsw i32 %11, %12
  store i32 %13, i32* %4, align 4
  %14 = load i32, i32* %4, align 4
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %18

16:                                               ; preds = %0
  %17 = load i32, i32* %3, align 4
  store volatile i32 %17, i32* @bottom, align 4
  store i32 0, i32* %1, align 4
  br label %35

18:                                               ; preds = %0
  %19 = load i32, i32* %2, align 4
  %20 = add nsw i32 1, %19
  store i32 %20, i32* %5, align 4
  %21 = load i32, i32* %4, align 4
  %22 = icmp sgt i32 %21, 0
  br i1 %22, label %23, label %25

23:                                               ; preds = %18
  %24 = load i32, i32* %5, align 4
  store i32 %24, i32* %1, align 4
  br label %35

25:                                               ; preds = %18
  %26 = load i32, i32* %3, align 4
  %27 = load i32, i32* %3, align 4
  %28 = add nsw i32 %27, 1
  %29 = call zeroext i1 @casTop(i32 %26, i32 %28)
  br i1 %29, label %31, label %30

30:                                               ; preds = %25
  store i32 0, i32* %5, align 4
  br label %31

31:                                               ; preds = %30, %25
  %32 = load i32, i32* %3, align 4
  %33 = add nsw i32 %32, 1
  store volatile i32 %33, i32* @bottom, align 4
  %34 = load i32, i32* %5, align 4
  store i32 %34, i32* %1, align 4
  br label %35

35:                                               ; preds = %31, %23, %16
  %36 = load i32, i32* %1, align 4
  ret i32 %36
}

declare dso_local zeroext i1 @casTop(i32, i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @steal() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = load volatile i32, i32* @top, align 4
  store i32 %6, i32* %2, align 4
  %7 = load volatile i32, i32* @bottom, align 4
  store i32 %7, i32* %3, align 4
  %8 = load i32, i32* %3, align 4
  %9 = load i32, i32* %2, align 4
  %10 = sub nsw i32 %8, %9
  store i32 %10, i32* %4, align 4
  %11 = load i32, i32* %4, align 4
  %12 = icmp sle i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %0
  store i32 0, i32* %1, align 4
  br label %24

14:                                               ; preds = %0
  %15 = load i32, i32* %2, align 4
  %16 = add nsw i32 1, %15
  store i32 %16, i32* %5, align 4
  %17 = load i32, i32* %2, align 4
  %18 = load i32, i32* %2, align 4
  %19 = add nsw i32 %18, 1
  %20 = call zeroext i1 @casTop(i32 %17, i32 %19)
  br i1 %20, label %22, label %21

21:                                               ; preds = %14
  store i32 -1, i32* %1, align 4
  br label %24

22:                                               ; preds = %14
  %23 = load i32, i32* %5, align 4
  store i32 %23, i32* %1, align 4
  br label %24

24:                                               ; preds = %22, %21, %13
  %25 = load i32, i32* %1, align 4
  ret i32 %25
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @owner(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %15, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %18

8:                                                ; preds = %5
  %9 = call i32 (...) @nondet()
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %13

11:                                               ; preds = %8
  %12 = call i32 @popBottom()
  br label %14

13:                                               ; preds = %8
  call void @pushBottom()
  br label %14

14:                                               ; preds = %13, %11
  br label %15

15:                                               ; preds = %14
  %16 = load i32, i32* %4, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* %4, align 4
  br label %5, !llvm.loop !2

18:                                               ; preds = %5
  %19 = load i8*, i8** %2, align 8
  ret i8* %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thief(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %10, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %13

8:                                                ; preds = %5
  %9 = call i32 @steal()
  br label %10

10:                                               ; preds = %8
  %11 = load i32, i32* %4, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, i32* %4, align 4
  br label %5, !llvm.loop !4

13:                                               ; preds = %5
  %14 = load i8*, i8** %2, align 8
  ret i8* %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  %3 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @owner, i8* null) #3
  %4 = call i8* @thief(i8* null)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
