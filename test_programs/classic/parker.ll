; ModuleID = 'parker.c'
source_filename = "parker.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_counter = dso_local global i32 0, align 4
@__unbuffered_did_park = dso_local global i8 0, align 1
@__unbuffered_mutex = dso_local global i32 0, align 4
@__unbuffered_cond = dso_local global i8 0, align 1
@x = dso_local global i32 0, align 4
@__unbuffered_done = dso_local global i8 0, align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @mutex_trylock(i32* %0) #0 {
  %2 = alloca i32*, align 8
  %3 = alloca i8, align 1
  store i32* %0, i32** %2, align 8
  %4 = call i32 (...) @__CPROVER_atomic_begin()
  %5 = load i32*, i32** %2, align 8
  %6 = load i32, i32* %5, align 4
  %7 = icmp ne i32 %6, 0
  %8 = zext i1 %7 to i8
  store i8 %8, i8* %3, align 1
  %9 = load i8, i8* %3, align 1
  %10 = trunc i8 %9 to i1
  br i1 %10, label %13, label %11

11:                                               ; preds = %1
  %12 = load i32*, i32** %2, align 8
  store i32 1, i32* %12, align 4
  br label %13

13:                                               ; preds = %11, %1
  %14 = call i32 (...) @__CPROVER_atomic_end()
  %15 = load i8, i8* %3, align 1
  %16 = trunc i8 %15 to i1
  ret i1 %16
}

declare dso_local i32 @__CPROVER_atomic_begin(...) #1

declare dso_local i32 @__CPROVER_atomic_end(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @park() #0 {
  %1 = load volatile i32, i32* @_counter, align 4
  %2 = icmp sgt i32 %1, 0
  br i1 %2, label %3, label %4

3:                                                ; preds = %0
  store volatile i32 0, i32* @_counter, align 4
  br label %28

4:                                                ; preds = %0
  %5 = call zeroext i1 @mutex_trylock(i32* @__unbuffered_mutex)
  %6 = zext i1 %5 to i32
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %4
  br label %28

9:                                                ; preds = %4
  %10 = load volatile i32, i32* @_counter, align 4
  %11 = icmp sgt i32 %10, 0
  br i1 %11, label %12, label %13

12:                                               ; preds = %9
  store volatile i32 0, i32* @_counter, align 4
  store i32 0, i32* @__unbuffered_mutex, align 4
  br label %28

13:                                               ; preds = %9
  store i8 1, i8* @__unbuffered_did_park, align 1
  %14 = call i32 (...) @__CPROVER_atomic_begin()
  %15 = load i32, i32* @__unbuffered_mutex, align 4
  %16 = icmp eq i32 %15, 1
  %17 = zext i1 %16 to i32
  %18 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %17)
  store i8 0, i8* @__unbuffered_cond, align 1
  store i32 0, i32* @__unbuffered_mutex, align 4
  %19 = call i32 (...) @__CPROVER_atomic_end()
  %20 = call i32 (...) @__CPROVER_atomic_begin()
  %21 = load i8, i8* @__unbuffered_cond, align 1
  %22 = trunc i8 %21 to i1
  %23 = zext i1 %22 to i32
  %24 = icmp eq i32 %23, 1
  %25 = zext i1 %24 to i32
  %26 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %25)
  store i32 1, i32* @__unbuffered_mutex, align 4
  %27 = call i32 (...) @__CPROVER_atomic_end()
  store volatile i32 0, i32* @_counter, align 4
  store i32 0, i32* @__unbuffered_mutex, align 4
  br label %28

28:                                               ; preds = %13, %12, %8, %3
  ret void
}

declare dso_local i32 @__CPROVER_assume(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @unpark() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 (...) @__CPROVER_atomic_begin()
  %3 = load i32, i32* @__unbuffered_mutex, align 4
  %4 = icmp eq i32 %3, 0
  %5 = zext i1 %4 to i32
  %6 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %5)
  store i32 1, i32* @__unbuffered_mutex, align 4
  %7 = call i32 (...) @__CPROVER_atomic_end()
  %8 = load volatile i32, i32* @_counter, align 4
  store i32 %8, i32* %1, align 4
  store volatile i32 1, i32* @_counter, align 4
  store i32 0, i32* @__unbuffered_mutex, align 4
  %9 = load i32, i32* %1, align 4
  %10 = icmp slt i32 %9, 1
  br i1 %10, label %11, label %12

11:                                               ; preds = %0
  store i8 1, i8* @__unbuffered_cond, align 1
  br label %12

12:                                               ; preds = %11, %0
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @waiting(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  br label %4

4:                                                ; preds = %7, %1
  %5 = load volatile i32, i32* @x, align 4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %4
  call void @park()
  br label %4, !llvm.loop !2

8:                                                ; preds = %4
  %9 = load i8*, i8** %2, align 8
  ret i8* %9
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @signal(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store volatile i32 0, i32* @x, align 4
  call void (...) @fence()
  call void @unpark()
  store i8 1, i8* @__unbuffered_done, align 1
  %4 = load i8*, i8** %2, align 8
  ret i8* %4
}

declare dso_local void @fence(...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %3 = load i32, i32* %2, align 4
  store volatile i32 %3, i32* @x, align 4
  store volatile i32 1, i32* @_counter, align 4
  call void (...) @fence()
  br label %4

4:                                                ; preds = %0
  %5 = call i8* @waiting(i8* null)
  br label %6

6:                                                ; preds = %4
  %7 = call i8* @signal(i8* null)
  %8 = load i8, i8* @__unbuffered_did_park, align 1
  %9 = trunc i8 %8 to i1
  br i1 %9, label %10, label %20

10:                                               ; preds = %6
  %11 = load i8, i8* @__unbuffered_done, align 1
  %12 = trunc i8 %11 to i1
  br i1 %12, label %13, label %16

13:                                               ; preds = %10
  %14 = load i8, i8* @__unbuffered_cond, align 1
  %15 = trunc i8 %14 to i1
  br label %16

16:                                               ; preds = %13, %10
  %17 = phi i1 [ true, %10 ], [ %15, %13 ]
  %18 = zext i1 %17 to i32
  %19 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %18)
  br label %20

20:                                               ; preds = %16, %6
  %21 = load i32, i32* %1, align 4
  ret i32 %21
}

declare dso_local i32 @assert(...) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
