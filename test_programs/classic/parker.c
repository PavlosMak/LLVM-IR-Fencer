void fence();

volatile int _counter = 0; 
int __unbuffered_mutex;
_Bool __unbuffered_cond; 

#define mutex_lock(c) \
{ \
  __CPROVER_atomic_begin(); \
  __CPROVER_assume(c==0); \
  c=1; \
  __CPROVER_atomic_end(); \
}
#define mutex_unlock(c) c=0
_Bool mutex_trylock(int * c)
{
  _Bool is_locked;
  __CPROVER_atomic_begin();
  is_locked=(*c!=0);
  if(!is_locked)
    *c=1;
  __CPROVER_atomic_end();
  return is_locked;
}

#define cond_wait(c, m) \
{ \
  __CPROVER_atomic_begin(); \
  __CPROVER_assume(m==1); \
  c=0; \
  m=0; \
  __CPROVER_atomic_end(); \
  __CPROVER_atomic_begin(); \
  __CPROVER_assume(c==1); \
  m=1; \
  __CPROVER_atomic_end(); \
}
#define cond_signal(c) c=1

_Bool __unbuffered_did_park=0;

void park() { 
  if (_counter > 0) { 
    _counter = 0; 
    // mfence needed here 
    return; 
  } 
  if (mutex_trylock(&__unbuffered_mutex) != 0) return; 
  if (_counter > 0) { // no wait needed 
    _counter = 0; 
    mutex_unlock(__unbuffered_mutex); 
    return; 
  } 
  __unbuffered_did_park=1;
  cond_wait(__unbuffered_cond, __unbuffered_mutex); 
  _counter = 0; 
  mutex_unlock(__unbuffered_mutex); 
} 

void unpark() { 
  mutex_lock(__unbuffered_mutex); 
  int s = _counter; 
  _counter = 1; 
  mutex_unlock(__unbuffered_mutex); 
  if (s < 1) cond_signal(__unbuffered_cond); 
} 

volatile int x;

void * waiting(void * arg)
{
  while (x!=0) park();
}

_Bool __unbuffered_done=0;

void * signal(void * arg)
{
  x=0;
  fence();
  unpark();
  __unbuffered_done=1;
}

int main()
{
  int _x;
  x=_x;
  _counter=1;
  fence();
__CPROVER_ASYNC_1: waiting(0);
__CPROVER_ASYNC_2: signal(0);
  if(__unbuffered_did_park)
    assert(!__unbuffered_done || __unbuffered_cond);
}
