; ModuleID = 'lamport.c'
source_filename = "lamport.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.pthread_attr_t = type { i64, [48 x i8] }

@b1 = dso_local global i32 0, align 4
@x = dso_local global i32 0, align 4
@y = dso_local global i32 0, align 4
@b2 = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr1(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  br label %3

3:                                                
  store i32 1, i32* @b1, align 4
  store i32 1, i32* @x, align 4

  fence acq_rel ; Inserted by ILP IR Fencer 
  %4 = load i32, i32* @y, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %7

6:                                                
  store i32 0, i32* @b1, align 4
  br label %3

7:                                                
  store i32 1, i32* @y, align 4

  fence acq_rel ; Inserted by ILP IR Fencer 
  %8 = load i32, i32* @x, align 4
  %9 = icmp ne i32 %8, 1
  br i1 %9, label %10, label %15

10:                                               
  store i32 0, i32* @b1, align 4

  fence acq_rel ; Inserted by ILP IR Fencer 
  %11 = load i32, i32* @y, align 4
  %12 = icmp ne i32 %11, 1
  br i1 %12, label %13, label %14

13:                                               
  br label %3

14:                                               
  br label %15

15:                                               
  store i32 0, i32* @y, align 4
  store i32 0, i32* @b1, align 4
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thr2(i8* %0) #0 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  br label %3

3:                                                
  store i32 1, i32* @b2, align 4
  store i32 2, i32* @x, align 4

  fence acq_rel ; Inserted by ILP IR Fencer 
  %4 = load i32, i32* @y, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %7

6:                                                
  store i32 0, i32* @b2, align 4
  br label %3

7:                                                
  store i32 2, i32* @y, align 4

  fence acq_rel ; Inserted by ILP IR Fencer 
  %8 = load i32, i32* @x, align 4
  %9 = icmp ne i32 %8, 2
  br i1 %9, label %10, label %15

10:                                               
  store i32 0, i32* @b2, align 4

  fence acq_rel ; Inserted by ILP IR Fencer 
  %11 = load i32, i32* @y, align 4
  %12 = icmp ne i32 %11, 2
  br i1 %12, label %13, label %14

13:                                               
  br label %3

14:                                               
  br label %15

15:                                               
  store i32 0, i32* @y, align 4
  store i32 0, i32* @b2, align 4
  ret i8* null
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i64, align 8
  %2 = alloca i64, align 8
  %3 = call i32 @pthread_create(i64* %1, %union.pthread_attr_t* null, i8* (i8*)* @thr1, i8* null) #3
  %4 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @thr2, i8* null) #3
  %5 = load i64, i64* %1, align 8
  %6 = call i32 @pthread_join(i64 %5, i8** null)
  %7 = load i64, i64* %2, align 8
  %8 = call i32 @pthread_join(i64 %7, i8** null)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #1

declare dso_local i32 @pthread_join(i64, i8**) #2

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
