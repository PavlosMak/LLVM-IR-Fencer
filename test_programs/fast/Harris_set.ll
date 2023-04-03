; ModuleID = 'Harris_set.c'
source_filename = "Harris_set.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._node_t = type { %struct._node_t*, %struct._node_t*, i32 }

@Dummy = dso_local global %struct._node_t { %struct._node_t* @Dummy, %struct._node_t* @Dummy, i32 0 }, align 8
@LeftHat = dso_local global %struct._node_t* @Dummy, align 8
@RightHat = dso_local global %struct._node_t* @Dummy, align 8
@counter = dso_local global i64 0, align 8
@shared_nodes = dso_local global [10 x %struct._node_t] zeroinitializer, align 16

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct._node_t* @new_node() #0 {
  %1 = alloca %struct._node_t*, align 8
  %2 = load i64, i64* @counter, align 8
  %3 = icmp ult i64 %2, 10
  br i1 %3, label %4, label %8

4:                                                ; preds = %0
  %5 = load i64, i64* @counter, align 8
  %6 = add i64 %5, 1
  store i64 %6, i64* @counter, align 8
  %7 = getelementptr inbounds %struct._node_t, %struct._node_t* getelementptr inbounds ([10 x %struct._node_t], [10 x %struct._node_t]* @shared_nodes, i64 0, i64 0), i64 %5
  store %struct._node_t* %7, %struct._node_t** %1, align 8
  br label %9

8:                                                ; preds = %0
  store %struct._node_t* null, %struct._node_t** %1, align 8
  br label %9

9:                                                ; preds = %8, %4
  %10 = load %struct._node_t*, %struct._node_t** %1, align 8
  ret %struct._node_t* %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pushRight(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct._node_t*, align 8
  %5 = alloca %struct._node_t*, align 8
  %6 = alloca %struct._node_t*, align 8
  %7 = alloca %struct._node_t*, align 8
  store i32 %0, i32* %3, align 4
  %8 = call %struct._node_t* @new_node()
  store %struct._node_t* %8, %struct._node_t** %4, align 8
  %9 = load %struct._node_t*, %struct._node_t** %4, align 8
  %10 = icmp eq %struct._node_t* %9, null
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  store i32 -3, i32* %2, align 4
  br label %53

12:                                               ; preds = %1
  %13 = load %struct._node_t*, %struct._node_t** %4, align 8
  %14 = getelementptr inbounds %struct._node_t, %struct._node_t* %13, i32 0, i32 0
  store %struct._node_t* @Dummy, %struct._node_t** %14, align 8
  %15 = load i32, i32* %3, align 4
  %16 = load %struct._node_t*, %struct._node_t** %4, align 8
  %17 = getelementptr inbounds %struct._node_t, %struct._node_t* %16, i32 0, i32 2
  store i32 %15, i32* %17, align 8
  br label %18

18:                                               ; preds = %12, %52
  %19 = load %struct._node_t*, %struct._node_t** @RightHat, align 8
  store %struct._node_t* %19, %struct._node_t** %5, align 8
  %20 = load %struct._node_t*, %struct._node_t** %5, align 8
  %21 = getelementptr inbounds %struct._node_t, %struct._node_t* %20, i32 0, i32 0
  %22 = load %struct._node_t*, %struct._node_t** %21, align 8
  store %struct._node_t* %22, %struct._node_t** %6, align 8
  %23 = load %struct._node_t*, %struct._node_t** %6, align 8
  %24 = load %struct._node_t*, %struct._node_t** %5, align 8
  %25 = icmp eq %struct._node_t* %23, %24
  br i1 %25, label %26, label %38

26:                                               ; preds = %18
  %27 = load %struct._node_t*, %struct._node_t** %4, align 8
  %28 = getelementptr inbounds %struct._node_t, %struct._node_t* %27, i32 0, i32 1
  store %struct._node_t* @Dummy, %struct._node_t** %28, align 8
  %29 = load %struct._node_t*, %struct._node_t** @LeftHat, align 8
  store %struct._node_t* %29, %struct._node_t** %7, align 8
  %30 = load %struct._node_t*, %struct._node_t** %5, align 8
  %31 = load %struct._node_t*, %struct._node_t** %7, align 8
  %32 = load %struct._node_t*, %struct._node_t** %4, align 8
  %33 = load %struct._node_t*, %struct._node_t** %4, align 8
  %34 = call i32 @DCAS(%struct._node_t** @RightHat, %struct._node_t** @LeftHat, %struct._node_t* %30, %struct._node_t* %31, %struct._node_t* %32, %struct._node_t* %33)
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %36, label %37

36:                                               ; preds = %26
  store i32 -1, i32* %2, align 4
  br label %53

37:                                               ; preds = %26
  br label %52

38:                                               ; preds = %18
  %39 = load %struct._node_t*, %struct._node_t** %5, align 8
  %40 = load %struct._node_t*, %struct._node_t** %4, align 8
  %41 = getelementptr inbounds %struct._node_t, %struct._node_t* %40, i32 0, i32 1
  store %struct._node_t* %39, %struct._node_t** %41, align 8
  %42 = load %struct._node_t*, %struct._node_t** %5, align 8
  %43 = getelementptr inbounds %struct._node_t, %struct._node_t* %42, i32 0, i32 0
  %44 = load %struct._node_t*, %struct._node_t** %5, align 8
  %45 = load %struct._node_t*, %struct._node_t** %6, align 8
  %46 = load %struct._node_t*, %struct._node_t** %4, align 8
  %47 = load %struct._node_t*, %struct._node_t** %4, align 8
  %48 = call i32 @DCAS(%struct._node_t** @RightHat, %struct._node_t** %43, %struct._node_t* %44, %struct._node_t* %45, %struct._node_t* %46, %struct._node_t* %47)
  %49 = icmp ne i32 %48, 0
  br i1 %49, label %50, label %51

50:                                               ; preds = %38
  store i32 -1, i32* %2, align 4
  br label %53

51:                                               ; preds = %38
  br label %52

52:                                               ; preds = %51, %37
  br label %18

53:                                               ; preds = %50, %36, %11
  %54 = load i32, i32* %2, align 4
  ret i32 %54
}

declare dso_local i32 @DCAS(%struct._node_t**, %struct._node_t**, %struct._node_t*, %struct._node_t*, %struct._node_t*, %struct._node_t*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @popRight() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct._node_t*, align 8
  %3 = alloca %struct._node_t*, align 8
  %4 = alloca %struct._node_t*, align 8
  %5 = alloca i32, align 4
  br label %6

6:                                                ; preds = %0, %51
  %7 = load %struct._node_t*, %struct._node_t** @RightHat, align 8
  store %struct._node_t* %7, %struct._node_t** %2, align 8
  %8 = load %struct._node_t*, %struct._node_t** @LeftHat, align 8
  store %struct._node_t* %8, %struct._node_t** %3, align 8
  %9 = load %struct._node_t*, %struct._node_t** %2, align 8
  %10 = getelementptr inbounds %struct._node_t, %struct._node_t* %9, i32 0, i32 0
  %11 = load %struct._node_t*, %struct._node_t** %10, align 8
  %12 = load %struct._node_t*, %struct._node_t** %2, align 8
  %13 = icmp eq %struct._node_t* %11, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %6
  store i32 -2, i32* %1, align 4
  br label %52

15:                                               ; preds = %6
  %16 = load %struct._node_t*, %struct._node_t** %2, align 8
  %17 = load %struct._node_t*, %struct._node_t** %3, align 8
  %18 = icmp eq %struct._node_t* %16, %17
  br i1 %18, label %19, label %29

19:                                               ; preds = %15
  %20 = load %struct._node_t*, %struct._node_t** %2, align 8
  %21 = load %struct._node_t*, %struct._node_t** %3, align 8
  %22 = call i32 @DCAS(%struct._node_t** @RightHat, %struct._node_t** @LeftHat, %struct._node_t* %20, %struct._node_t* %21, %struct._node_t* @Dummy, %struct._node_t* @Dummy)
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %28

24:                                               ; preds = %19
  %25 = load %struct._node_t*, %struct._node_t** %2, align 8
  %26 = getelementptr inbounds %struct._node_t, %struct._node_t* %25, i32 0, i32 2
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %1, align 4
  br label %52

28:                                               ; preds = %19
  br label %51

29:                                               ; preds = %15
  %30 = load %struct._node_t*, %struct._node_t** %2, align 8
  %31 = getelementptr inbounds %struct._node_t, %struct._node_t* %30, i32 0, i32 1
  %32 = load %struct._node_t*, %struct._node_t** %31, align 8
  store %struct._node_t* %32, %struct._node_t** %4, align 8
  %33 = load %struct._node_t*, %struct._node_t** %2, align 8
  %34 = getelementptr inbounds %struct._node_t, %struct._node_t* %33, i32 0, i32 1
  %35 = load %struct._node_t*, %struct._node_t** %2, align 8
  %36 = load %struct._node_t*, %struct._node_t** %4, align 8
  %37 = load %struct._node_t*, %struct._node_t** %4, align 8
  %38 = load %struct._node_t*, %struct._node_t** %2, align 8
  %39 = call i32 @DCAS(%struct._node_t** @RightHat, %struct._node_t** %34, %struct._node_t* %35, %struct._node_t* %36, %struct._node_t* %37, %struct._node_t* %38)
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %50

41:                                               ; preds = %29
  %42 = load %struct._node_t*, %struct._node_t** %2, align 8
  %43 = getelementptr inbounds %struct._node_t, %struct._node_t* %42, i32 0, i32 2
  %44 = load i32, i32* %43, align 8
  store i32 %44, i32* %5, align 4
  %45 = load %struct._node_t*, %struct._node_t** %2, align 8
  %46 = getelementptr inbounds %struct._node_t, %struct._node_t* %45, i32 0, i32 0
  store %struct._node_t* @Dummy, %struct._node_t** %46, align 8
  %47 = load %struct._node_t*, %struct._node_t** %2, align 8
  %48 = getelementptr inbounds %struct._node_t, %struct._node_t* %47, i32 0, i32 2
  store i32 0, i32* %48, align 8
  %49 = load i32, i32* %5, align 4
  store i32 %49, i32* %1, align 4
  br label %52

50:                                               ; preds = %29
  br label %51

51:                                               ; preds = %50, %28
  br label %6

52:                                               ; preds = %41, %24, %14
  %53 = load i32, i32* %1, align 4
  ret i32 %53
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pushLeft(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct._node_t*, align 8
  %5 = alloca %struct._node_t*, align 8
  %6 = alloca %struct._node_t*, align 8
  %7 = alloca %struct._node_t*, align 8
  store i32 %0, i32* %3, align 4
  %8 = call %struct._node_t* @new_node()
  store %struct._node_t* %8, %struct._node_t** %4, align 8
  %9 = load %struct._node_t*, %struct._node_t** %4, align 8
  %10 = icmp eq %struct._node_t* %9, null
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  store i32 -3, i32* %2, align 4
  br label %53

12:                                               ; preds = %1
  %13 = load %struct._node_t*, %struct._node_t** %4, align 8
  %14 = getelementptr inbounds %struct._node_t, %struct._node_t* %13, i32 0, i32 1
  store %struct._node_t* @Dummy, %struct._node_t** %14, align 8
  %15 = load i32, i32* %3, align 4
  %16 = load %struct._node_t*, %struct._node_t** %4, align 8
  %17 = getelementptr inbounds %struct._node_t, %struct._node_t* %16, i32 0, i32 2
  store i32 %15, i32* %17, align 8
  br label %18

18:                                               ; preds = %12, %52
  %19 = load %struct._node_t*, %struct._node_t** @LeftHat, align 8
  store %struct._node_t* %19, %struct._node_t** %5, align 8
  %20 = load %struct._node_t*, %struct._node_t** %5, align 8
  %21 = getelementptr inbounds %struct._node_t, %struct._node_t* %20, i32 0, i32 1
  %22 = load %struct._node_t*, %struct._node_t** %21, align 8
  store %struct._node_t* %22, %struct._node_t** %6, align 8
  %23 = load %struct._node_t*, %struct._node_t** %6, align 8
  %24 = load %struct._node_t*, %struct._node_t** %5, align 8
  %25 = icmp eq %struct._node_t* %23, %24
  br i1 %25, label %26, label %38

26:                                               ; preds = %18
  %27 = load %struct._node_t*, %struct._node_t** %4, align 8
  %28 = getelementptr inbounds %struct._node_t, %struct._node_t* %27, i32 0, i32 0
  store %struct._node_t* @Dummy, %struct._node_t** %28, align 8
  %29 = load %struct._node_t*, %struct._node_t** @RightHat, align 8
  store %struct._node_t* %29, %struct._node_t** %7, align 8
  %30 = load %struct._node_t*, %struct._node_t** %5, align 8
  %31 = load %struct._node_t*, %struct._node_t** %7, align 8
  %32 = load %struct._node_t*, %struct._node_t** %4, align 8
  %33 = load %struct._node_t*, %struct._node_t** %4, align 8
  %34 = call i32 @DCAS(%struct._node_t** @LeftHat, %struct._node_t** @RightHat, %struct._node_t* %30, %struct._node_t* %31, %struct._node_t* %32, %struct._node_t* %33)
  %35 = icmp ne i32 %34, 0
  br i1 %35, label %36, label %37

36:                                               ; preds = %26
  store i32 -1, i32* %2, align 4
  br label %53

37:                                               ; preds = %26
  br label %52

38:                                               ; preds = %18
  %39 = load %struct._node_t*, %struct._node_t** %5, align 8
  %40 = load %struct._node_t*, %struct._node_t** %4, align 8
  %41 = getelementptr inbounds %struct._node_t, %struct._node_t* %40, i32 0, i32 0
  store %struct._node_t* %39, %struct._node_t** %41, align 8
  %42 = load %struct._node_t*, %struct._node_t** %5, align 8
  %43 = getelementptr inbounds %struct._node_t, %struct._node_t* %42, i32 0, i32 1
  %44 = load %struct._node_t*, %struct._node_t** %5, align 8
  %45 = load %struct._node_t*, %struct._node_t** %6, align 8
  %46 = load %struct._node_t*, %struct._node_t** %4, align 8
  %47 = load %struct._node_t*, %struct._node_t** %4, align 8
  %48 = call i32 @DCAS(%struct._node_t** @LeftHat, %struct._node_t** %43, %struct._node_t* %44, %struct._node_t* %45, %struct._node_t* %46, %struct._node_t* %47)
  %49 = icmp ne i32 %48, 0
  br i1 %49, label %50, label %51

50:                                               ; preds = %38
  store i32 -1, i32* %2, align 4
  br label %53

51:                                               ; preds = %38
  br label %52

52:                                               ; preds = %51, %37
  br label %18

53:                                               ; preds = %50, %36, %11
  %54 = load i32, i32* %2, align 4
  ret i32 %54
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @popLeft() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct._node_t*, align 8
  %3 = alloca %struct._node_t*, align 8
  %4 = alloca %struct._node_t*, align 8
  %5 = alloca i32, align 4
  br label %6

6:                                                ; preds = %0, %51
  %7 = load %struct._node_t*, %struct._node_t** @LeftHat, align 8
  store %struct._node_t* %7, %struct._node_t** %2, align 8
  %8 = load %struct._node_t*, %struct._node_t** @RightHat, align 8
  store %struct._node_t* %8, %struct._node_t** %3, align 8
  %9 = load %struct._node_t*, %struct._node_t** %2, align 8
  %10 = getelementptr inbounds %struct._node_t, %struct._node_t* %9, i32 0, i32 1
  %11 = load %struct._node_t*, %struct._node_t** %10, align 8
  %12 = load %struct._node_t*, %struct._node_t** %2, align 8
  %13 = icmp eq %struct._node_t* %11, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %6
  store i32 -2, i32* %1, align 4
  br label %52

15:                                               ; preds = %6
  %16 = load %struct._node_t*, %struct._node_t** %2, align 8
  %17 = load %struct._node_t*, %struct._node_t** %3, align 8
  %18 = icmp eq %struct._node_t* %16, %17
  br i1 %18, label %19, label %29

19:                                               ; preds = %15
  %20 = load %struct._node_t*, %struct._node_t** %2, align 8
  %21 = load %struct._node_t*, %struct._node_t** %3, align 8
  %22 = call i32 @DCAS(%struct._node_t** @LeftHat, %struct._node_t** @RightHat, %struct._node_t* %20, %struct._node_t* %21, %struct._node_t* @Dummy, %struct._node_t* @Dummy)
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %28

24:                                               ; preds = %19
  %25 = load %struct._node_t*, %struct._node_t** %2, align 8
  %26 = getelementptr inbounds %struct._node_t, %struct._node_t* %25, i32 0, i32 2
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %1, align 4
  br label %52

28:                                               ; preds = %19
  br label %51

29:                                               ; preds = %15
  %30 = load %struct._node_t*, %struct._node_t** %2, align 8
  %31 = getelementptr inbounds %struct._node_t, %struct._node_t* %30, i32 0, i32 0
  %32 = load %struct._node_t*, %struct._node_t** %31, align 8
  store %struct._node_t* %32, %struct._node_t** %4, align 8
  %33 = load %struct._node_t*, %struct._node_t** %2, align 8
  %34 = getelementptr inbounds %struct._node_t, %struct._node_t* %33, i32 0, i32 0
  %35 = load %struct._node_t*, %struct._node_t** %2, align 8
  %36 = load %struct._node_t*, %struct._node_t** %4, align 8
  %37 = load %struct._node_t*, %struct._node_t** %4, align 8
  %38 = load %struct._node_t*, %struct._node_t** %2, align 8
  %39 = call i32 @DCAS(%struct._node_t** @LeftHat, %struct._node_t** %34, %struct._node_t* %35, %struct._node_t* %36, %struct._node_t* %37, %struct._node_t* %38)
  %40 = icmp ne i32 %39, 0
  br i1 %40, label %41, label %50

41:                                               ; preds = %29
  %42 = load %struct._node_t*, %struct._node_t** %2, align 8
  %43 = getelementptr inbounds %struct._node_t, %struct._node_t* %42, i32 0, i32 2
  %44 = load i32, i32* %43, align 8
  store i32 %44, i32* %5, align 4
  %45 = load %struct._node_t*, %struct._node_t** %2, align 8
  %46 = getelementptr inbounds %struct._node_t, %struct._node_t* %45, i32 0, i32 1
  store %struct._node_t* @Dummy, %struct._node_t** %46, align 8
  %47 = load %struct._node_t*, %struct._node_t** %2, align 8
  %48 = getelementptr inbounds %struct._node_t, %struct._node_t* %47, i32 0, i32 2
  store i32 0, i32* %48, align 8
  %49 = load i32, i32* %5, align 4
  store i32 %49, i32* %1, align 4
  br label %52

50:                                               ; preds = %29
  br label %51

51:                                               ; preds = %50, %28
  br label %6

52:                                               ; preds = %41, %24, %14
  %53 = load i32, i32* %1, align 4
  ret i32 %53
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @leftThread(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %19, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %22

8:                                                ; preds = %5
  %9 = call i32 @rand() #3
  %10 = srem i32 %9, 2
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %16

12:                                               ; preds = %8
  %13 = call i32 @rand() #3
  %14 = srem i32 %13, 2
  %15 = call i32 @pushLeft(i32 %14)
  br label %18

16:                                               ; preds = %8
  %17 = call i32 @popLeft()
  br label %18

18:                                               ; preds = %16, %12
  br label %19

19:                                               ; preds = %18
  %20 = load i32, i32* %4, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %4, align 4
  br label %5, !llvm.loop !2

22:                                               ; preds = %5
  %23 = load i8*, i8** %2, align 8
  ret i8* %23
}

; Function Attrs: nounwind
declare dso_local i32 @rand() #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @rightThread(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %19, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %22

8:                                                ; preds = %5
  %9 = call i32 @rand() #3
  %10 = srem i32 %9, 2
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %16

12:                                               ; preds = %8
  %13 = call i32 @rand() #3
  %14 = srem i32 %13, 2
  %15 = call i32 @pushRight(i32 %14)
  br label %18

16:                                               ; preds = %8
  %17 = call i32 @popRight()
  br label %18

18:                                               ; preds = %16, %12
  br label %19

19:                                               ; preds = %18
  %20 = load i32, i32* %4, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %4, align 4
  br label %5, !llvm.loop !4

22:                                               ; preds = %5
  %23 = load i8*, i8** %2, align 8
  ret i8* %23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %2

2:                                                ; preds = %0
  %3 = call i8* @leftThread(i8* null)
  %4 = call i8* @rightThread(i8* null)
  ret i32 0
}

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
