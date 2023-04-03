; ModuleID = 'LazyList_set.c'
source_filename = "LazyList_set.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._Entry_t = type { i32, %struct._Entry_t*, i32, i32 }
%struct._List_t = type { %struct._Entry_t*, %struct._Entry_t*, %struct._Entry_t* }
%union.pthread_attr_t = type { i64, [48 x i8] }

@counter = dso_local global i64 0, align 8
@shared_nodes = dso_local global [10 x %struct._Entry_t] zeroinitializer, align 16
@this = dso_local global %struct._List_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct._Entry_t* @new_element(i32 %0) #0 {
  %2 = alloca %struct._Entry_t*, align 8
  %3 = alloca i32, align 4
  %4 = alloca %struct._Entry_t*, align 8
  store i32 %0, i32* %3, align 4
  %5 = load i64, i64* @counter, align 8
  %6 = icmp ult i64 %5, 10
  br i1 %6, label %7, label %21

7:                                                ; preds = %1
  %8 = load i64, i64* @counter, align 8
  %9 = add i64 %8, 1
  store i64 %9, i64* @counter, align 8
  %10 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* getelementptr inbounds ([10 x %struct._Entry_t], [10 x %struct._Entry_t]* @shared_nodes, i64 0, i64 0), i64 %8
  store %struct._Entry_t* %10, %struct._Entry_t** %4, align 8
  %11 = load i32, i32* %3, align 4
  %12 = load %struct._Entry_t*, %struct._Entry_t** %4, align 8
  %13 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %12, i32 0, i32 0
  store i32 %11, i32* %13, align 8
  %14 = load %struct._Entry_t*, %struct._Entry_t** %4, align 8
  %15 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %14, i32 0, i32 1
  store %struct._Entry_t* null, %struct._Entry_t** %15, align 8
  %16 = load %struct._Entry_t*, %struct._Entry_t** %4, align 8
  %17 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %16, i32 0, i32 2
  store i32 0, i32* %17, align 8
  %18 = load %struct._Entry_t*, %struct._Entry_t** %4, align 8
  %19 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %18, i32 0, i32 3
  %20 = call i32 @pthread_spin_init(i32* %19, i32 0) #2
  br label %22

21:                                               ; preds = %1
  store %struct._Entry_t* null, %struct._Entry_t** %2, align 8
  br label %22

22:                                               ; preds = %21, %7
  %23 = load %struct._Entry_t*, %struct._Entry_t** %2, align 8
  ret %struct._Entry_t* %23
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_spin_init(i32*, i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init(%struct._List_t* %0) #0 {
  %2 = alloca %struct._List_t*, align 8
  store %struct._List_t* %0, %struct._List_t** %2, align 8
  %3 = call %struct._Entry_t* @new_element(i32 0)
  %4 = load %struct._List_t*, %struct._List_t** %2, align 8
  %5 = getelementptr inbounds %struct._List_t, %struct._List_t* %4, i32 0, i32 0
  store %struct._Entry_t* %3, %struct._Entry_t** %5, align 8
  %6 = load %struct._List_t*, %struct._List_t** %2, align 8
  %7 = getelementptr inbounds %struct._List_t, %struct._List_t* %6, i32 0, i32 0
  %8 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %9 = load %struct._List_t*, %struct._List_t** %2, align 8
  %10 = getelementptr inbounds %struct._List_t, %struct._List_t* %9, i32 0, i32 1
  store %struct._Entry_t* %8, %struct._Entry_t** %10, align 8
  %11 = load %struct._List_t*, %struct._List_t** %2, align 8
  %12 = getelementptr inbounds %struct._List_t, %struct._List_t* %11, i32 0, i32 0
  %13 = load %struct._Entry_t*, %struct._Entry_t** %12, align 8
  %14 = load %struct._List_t*, %struct._List_t** %2, align 8
  %15 = getelementptr inbounds %struct._List_t, %struct._List_t* %14, i32 0, i32 2
  store %struct._Entry_t* %13, %struct._Entry_t** %15, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @validate(%struct._Entry_t* %0, %struct._Entry_t* %1) #0 {
  %3 = alloca %struct._Entry_t*, align 8
  %4 = alloca %struct._Entry_t*, align 8
  store %struct._Entry_t* %0, %struct._Entry_t** %3, align 8
  store %struct._Entry_t* %1, %struct._Entry_t** %4, align 8
  %5 = load %struct._Entry_t*, %struct._Entry_t** %3, align 8
  %6 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %5, i32 0, i32 2
  %7 = load i32, i32* %6, align 8
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %20, label %9

9:                                                ; preds = %2
  %10 = load %struct._Entry_t*, %struct._Entry_t** %4, align 8
  %11 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %10, i32 0, i32 2
  %12 = load i32, i32* %11, align 8
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %20, label %14

14:                                               ; preds = %9
  %15 = load %struct._Entry_t*, %struct._Entry_t** %3, align 8
  %16 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %15, i32 0, i32 1
  %17 = load %struct._Entry_t*, %struct._Entry_t** %16, align 8
  %18 = load %struct._Entry_t*, %struct._Entry_t** %4, align 8
  %19 = icmp eq %struct._Entry_t* %17, %18
  br label %20

20:                                               ; preds = %14, %9, %2
  %21 = phi i1 [ false, %9 ], [ false, %2 ], [ %19, %14 ]
  %22 = zext i1 %21 to i32
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @remove(i32 %0, %struct._List_t* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct._List_t*, align 8
  %6 = alloca %struct._Entry_t*, align 8
  %7 = alloca %struct._Entry_t*, align 8
  store i32 %0, i32* %4, align 4
  store %struct._List_t* %1, %struct._List_t** %5, align 8
  br label %8

8:                                                ; preds = %2, %54
  %9 = load %struct._List_t*, %struct._List_t** %5, align 8
  %10 = getelementptr inbounds %struct._List_t, %struct._List_t* %9, i32 0, i32 1
  %11 = load %struct._Entry_t*, %struct._Entry_t** %10, align 8
  store %struct._Entry_t* %11, %struct._Entry_t** %6, align 8
  %12 = load %struct._List_t*, %struct._List_t** %5, align 8
  %13 = getelementptr inbounds %struct._List_t, %struct._List_t* %12, i32 0, i32 1
  %14 = load %struct._Entry_t*, %struct._Entry_t** %13, align 8
  %15 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %14, i32 0, i32 1
  %16 = load %struct._Entry_t*, %struct._Entry_t** %15, align 8
  store %struct._Entry_t* %16, %struct._Entry_t** %7, align 8
  br label %17

17:                                               ; preds = %23, %8
  %18 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %19 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %18, i32 0, i32 0
  %20 = load i32, i32* %19, align 8
  %21 = load i32, i32* %4, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %28

23:                                               ; preds = %17
  %24 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  store %struct._Entry_t* %24, %struct._Entry_t** %6, align 8
  %25 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %26 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %25, i32 0, i32 1
  %27 = load %struct._Entry_t*, %struct._Entry_t** %26, align 8
  store %struct._Entry_t* %27, %struct._Entry_t** %7, align 8
  br label %17, !llvm.loop !2

28:                                               ; preds = %17
  %29 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %30 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %29, i32 0, i32 3
  %31 = call i32 @pthread_spin_lock(i32* %30) #2
  %32 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %33 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %32, i32 0, i32 3
  %34 = call i32 @pthread_spin_lock(i32* %33) #2
  %35 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %36 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %37 = call i32 @validate(%struct._Entry_t* %35, %struct._Entry_t* %36)
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %54

39:                                               ; preds = %28
  %40 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %41 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %40, i32 0, i32 0
  %42 = load i32, i32* %41, align 8
  %43 = load i32, i32* %4, align 4
  %44 = icmp ne i32 %42, %43
  br i1 %44, label %45, label %46

45:                                               ; preds = %39
  store i32 0, i32* %3, align 4
  br label %61

46:                                               ; preds = %39
  %47 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %48 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %47, i32 0, i32 2
  store i32 1, i32* %48, align 8
  %49 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %50 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %49, i32 0, i32 1
  %51 = load %struct._Entry_t*, %struct._Entry_t** %50, align 8
  %52 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %53 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %52, i32 0, i32 1
  store %struct._Entry_t* %51, %struct._Entry_t** %53, align 8
  store i32 1, i32* %3, align 4
  br label %61

54:                                               ; preds = %28
  %55 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %56 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %55, i32 0, i32 3
  %57 = call i32 @pthread_spin_unlock(i32* %56) #2
  %58 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %59 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %58, i32 0, i32 3
  %60 = call i32 @pthread_spin_unlock(i32* %59) #2
  br label %8

61:                                               ; preds = %46, %45
  %62 = load i32, i32* %3, align 4
  ret i32 %62
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_spin_lock(i32*) #1

; Function Attrs: nounwind
declare dso_local i32 @pthread_spin_unlock(i32*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @add(i32 %0, %struct._List_t* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct._List_t*, align 8
  %6 = alloca %struct._Entry_t*, align 8
  %7 = alloca %struct._Entry_t*, align 8
  %8 = alloca %struct._Entry_t*, align 8
  store i32 %0, i32* %4, align 4
  store %struct._List_t* %1, %struct._List_t** %5, align 8
  br label %9

9:                                                ; preds = %2, %56
  %10 = load %struct._List_t*, %struct._List_t** %5, align 8
  %11 = getelementptr inbounds %struct._List_t, %struct._List_t* %10, i32 0, i32 1
  %12 = load %struct._Entry_t*, %struct._Entry_t** %11, align 8
  store %struct._Entry_t* %12, %struct._Entry_t** %6, align 8
  %13 = load %struct._List_t*, %struct._List_t** %5, align 8
  %14 = getelementptr inbounds %struct._List_t, %struct._List_t* %13, i32 0, i32 1
  %15 = load %struct._Entry_t*, %struct._Entry_t** %14, align 8
  %16 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %15, i32 0, i32 1
  %17 = load %struct._Entry_t*, %struct._Entry_t** %16, align 8
  store %struct._Entry_t* %17, %struct._Entry_t** %7, align 8
  br label %18

18:                                               ; preds = %24, %9
  %19 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %20 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = load i32, i32* %4, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %29

24:                                               ; preds = %18
  %25 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  store %struct._Entry_t* %25, %struct._Entry_t** %6, align 8
  %26 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %27 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %26, i32 0, i32 1
  %28 = load %struct._Entry_t*, %struct._Entry_t** %27, align 8
  store %struct._Entry_t* %28, %struct._Entry_t** %7, align 8
  br label %18, !llvm.loop !4

29:                                               ; preds = %18
  %30 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %31 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %30, i32 0, i32 3
  %32 = call i32 @pthread_spin_lock(i32* %31) #2
  %33 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %34 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %33, i32 0, i32 3
  %35 = call i32 @pthread_spin_lock(i32* %34) #2
  %36 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %37 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %38 = call i32 @validate(%struct._Entry_t* %36, %struct._Entry_t* %37)
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %40, label %56

40:                                               ; preds = %29
  %41 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %42 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %41, i32 0, i32 0
  %43 = load i32, i32* %42, align 8
  %44 = load i32, i32* %4, align 4
  %45 = icmp eq i32 %43, %44
  br i1 %45, label %46, label %47

46:                                               ; preds = %40
  store i32 0, i32* %3, align 4
  br label %63

47:                                               ; preds = %40
  %48 = load i32, i32* %4, align 4
  %49 = call %struct._Entry_t* @new_element(i32 %48)
  store %struct._Entry_t* %49, %struct._Entry_t** %8, align 8
  %50 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %51 = load %struct._Entry_t*, %struct._Entry_t** %8, align 8
  %52 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %51, i32 0, i32 1
  store %struct._Entry_t* %50, %struct._Entry_t** %52, align 8
  %53 = load %struct._Entry_t*, %struct._Entry_t** %8, align 8
  %54 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %55 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %54, i32 0, i32 1
  store %struct._Entry_t* %53, %struct._Entry_t** %55, align 8
  store i32 1, i32* %3, align 4
  br label %63

56:                                               ; preds = %29
  %57 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  %58 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %57, i32 0, i32 3
  %59 = call i32 @pthread_spin_unlock(i32* %58) #2
  %60 = load %struct._Entry_t*, %struct._Entry_t** %6, align 8
  %61 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %60, i32 0, i32 3
  %62 = call i32 @pthread_spin_unlock(i32* %61) #2
  br label %9

63:                                               ; preds = %47, %46
  %64 = load i32, i32* %3, align 4
  ret i32 %64
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @contains(i32 %0, %struct._List_t* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct._List_t*, align 8
  %5 = alloca %struct._Entry_t*, align 8
  store i32 %0, i32* %3, align 4
  store %struct._List_t* %1, %struct._List_t** %4, align 8
  %6 = load %struct._List_t*, %struct._List_t** %4, align 8
  %7 = getelementptr inbounds %struct._List_t, %struct._List_t* %6, i32 0, i32 1
  %8 = load %struct._Entry_t*, %struct._Entry_t** %7, align 8
  store %struct._Entry_t* %8, %struct._Entry_t** %5, align 8
  br label %9

9:                                                ; preds = %15, %2
  %10 = load %struct._Entry_t*, %struct._Entry_t** %5, align 8
  %11 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = load i32, i32* %3, align 4
  %14 = icmp slt i32 %12, %13
  br i1 %14, label %15, label %19

15:                                               ; preds = %9
  %16 = load %struct._Entry_t*, %struct._Entry_t** %5, align 8
  %17 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %16, i32 0, i32 1
  %18 = load %struct._Entry_t*, %struct._Entry_t** %17, align 8
  store %struct._Entry_t* %18, %struct._Entry_t** %5, align 8
  br label %9, !llvm.loop !5

19:                                               ; preds = %9
  %20 = load %struct._Entry_t*, %struct._Entry_t** %5, align 8
  %21 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %20, i32 0, i32 0
  %22 = load i32, i32* %21, align 8
  %23 = load i32, i32* %3, align 4
  %24 = icmp eq i32 %22, %23
  br i1 %24, label %25, label %31

25:                                               ; preds = %19
  %26 = load %struct._Entry_t*, %struct._Entry_t** %5, align 8
  %27 = getelementptr inbounds %struct._Entry_t, %struct._Entry_t* %26, i32 0, i32 2
  %28 = load i32, i32* %27, align 8
  %29 = icmp ne i32 %28, 0
  %30 = xor i1 %29, true
  br label %31

31:                                               ; preds = %25, %19
  %32 = phi i1 [ false, %19 ], [ %30, %25 ]
  %33 = zext i1 %32 to i32
  ret i32 %33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @leftThread(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %21, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %24

8:                                                ; preds = %5
  %9 = call i32 @rand() #2
  %10 = srem i32 %9, 2
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %16

12:                                               ; preds = %8
  %13 = call i32 @rand() #2
  %14 = srem i32 %13, 2
  %15 = call i32 @add(i32 %14, %struct._List_t* @this)
  br label %20

16:                                               ; preds = %8
  %17 = call i32 @rand() #2
  %18 = srem i32 %17, 2
  %19 = call i32 @contains(i32 %18, %struct._List_t* @this)
  br label %20

20:                                               ; preds = %16, %12
  br label %21

21:                                               ; preds = %20
  %22 = load i32, i32* %4, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %4, align 4
  br label %5, !llvm.loop !6

24:                                               ; preds = %5
  %25 = load i8*, i8** %2, align 8
  ret i8* %25
}

; Function Attrs: nounwind
declare dso_local i32 @rand() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @rightThread(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %21, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %24

8:                                                ; preds = %5
  %9 = call i32 @rand() #2
  %10 = srem i32 %9, 2
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %16

12:                                               ; preds = %8
  %13 = call i32 @rand() #2
  %14 = srem i32 %13, 2
  %15 = call i32 @remove(i32 %14, %struct._List_t* @this)
  br label %20

16:                                               ; preds = %8
  %17 = call i32 @rand() #2
  %18 = srem i32 %17, 2
  %19 = call i32 @contains(i32 %18, %struct._List_t* @this)
  br label %20

20:                                               ; preds = %16, %12
  br label %21

21:                                               ; preds = %20
  %22 = load i32, i32* %4, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %4, align 4
  br label %5, !llvm.loop !7

24:                                               ; preds = %5
  %25 = load i8*, i8** %2, align 8
  ret i8* %25
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @init(%struct._List_t* @this)
  %3 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @leftThread, i8* null) #2
  %4 = call i8* @rightThread(i8* null)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
!6 = distinct !{!6, !3}
!7 = distinct !{!7, !3}
