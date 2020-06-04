Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CEA1EE056
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgFDI5o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:57:44 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:51674 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgFDI5o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:57:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 4097A3F4FD;
        Thu,  4 Jun 2020 10:57:40 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=HqWAuFbu;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gHnf6oPYo80P; Thu,  4 Jun 2020 10:57:38 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 746563F401;
        Thu,  4 Jun 2020 10:57:36 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B58D53600B0;
        Thu,  4 Jun 2020 10:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1591261055; bh=ZbyRQLsJUVnD4sxLkv+YhGfCJO1A8pOTwS8rf8tXIPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HqWAuFbuD/1tYxevTgYV9ZLBLqLq7G9qxt9v27g1cacKcrYNBaYVkj5Xae1evnIlh
         H6TGCwcpJnd9gcNafMXl0TVuPA6K6Drw+92JZ/tJqreAQpQMA/Jx8rhd7CBGQD6tWB
         O01SuvAO1pwNm3uCrkHMc0NPwHPS7vYDj+0AWPKE=
Subject: Re: [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linaro-mm-sig@lists.linaro.org,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <edbfc1aa-9297-8202-cef8-1facafaa0dfe@shipmail.org>
Date:   Thu, 4 Jun 2020 10:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604081224.863494-4-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/20 10:12 AM, Daniel Vetter wrote:
...
> Thread A:
>
> 	mutex_lock(A);
> 	mutex_unlock(A);
>
> 	dma_fence_signal();
>
> Thread B:
>
> 	mutex_lock(A);
> 	dma_fence_wait();
> 	mutex_unlock(A);
>
> Thread B is blocked on A signalling the fence, but A never gets around
> to that because it cannot acquire the lock A.
>
> Note that dma_fence_wait() is allowed to be nested within
> dma_fence_begin/end_signalling sections. To allow this to happen the
> read lock needs to be upgraded to a write lock, which means that any
> other lock is acquired between the dma_fence_begin_signalling() call and
> the call to dma_fence_wait(), and still held, this will result in an
> immediate lockdep complaint. The only other option would be to not
> annotate such calls, defeating the point. Therefore these annotations
> cannot be sprinkled over the code entirely mindless to avoid false
> positives.

Just realized, isn't that example actually a true positive, or at least 
a great candidate for a true positive, since if another thread reenters 
that signaling path, it will block on that mutex, and the fence would 
never be signaled unless there is another signaling path?

Although I agree the conclusion is sound: These annotations cannot be 
sprinkled mindlessly over the code.

/Thomas






>
> v2: handle soft/hardirq ctx better against write side and dont forget
> EXPORT_SYMBOL, drivers can't use this otherwise.
>
> v3: Kerneldoc.
>
> v4: Some spelling fixes from Mika
>
> Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>   Documentation/driver-api/dma-buf.rst |  12 +-
>   drivers/dma-buf/dma-fence.c          | 161 +++++++++++++++++++++++++++
>   include/linux/dma-fence.h            |  12 ++
>   3 files changed, 182 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> index 63dec76d1d8d..05d856131140 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -100,11 +100,11 @@ CPU Access to DMA Buffer Objects
>   .. kernel-doc:: drivers/dma-buf/dma-buf.c
>      :doc: cpu access
>   
> -Fence Poll Support
> -~~~~~~~~~~~~~~~~~~
> +Implicit Fence Poll Support
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
>   .. kernel-doc:: drivers/dma-buf/dma-buf.c
> -   :doc: fence polling
> +   :doc: implicit fence polling
>   
>   Kernel Functions and Structures Reference
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -133,6 +133,12 @@ DMA Fences
>   .. kernel-doc:: drivers/dma-buf/dma-fence.c
>      :doc: DMA fences overview
>   
> +DMA Fence Signalling Annotations
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/dma-buf/dma-fence.c
> +   :doc: fence signalling annotation
> +
>   DMA Fences Functions Reference
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 656e9ac2d028..0005bc002529 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -110,6 +110,160 @@ u64 dma_fence_context_alloc(unsigned num)
>   }
>   EXPORT_SYMBOL(dma_fence_context_alloc);
>   
> +/**
> + * DOC: fence signalling annotation
> + *
> + * Proving correctness of all the kernel code around &dma_fence through code
> + * review and testing is tricky for a few reasons:
> + *
> + * * It is a cross-driver contract, and therefore all drivers must follow the
> + *   same rules for lock nesting order, calling contexts for various functions
> + *   and anything else significant for in-kernel interfaces. But it is also
> + *   impossible to test all drivers in a single machine, hence brute-force N vs.
> + *   N testing of all combinations is impossible. Even just limiting to the
> + *   possible combinations is infeasible.
> + *
> + * * There is an enormous amount of driver code involved. For render drivers
> + *   there's the tail of command submission, after fences are published,
> + *   scheduler code, interrupt and workers to process job completion,
> + *   and timeout, gpu reset and gpu hang recovery code. Plus for integration
> + *   with core mm with have &mmu_notifier, respectively &mmu_interval_notifier,
> + *   and &shrinker. For modesetting drivers there's the commit tail functions
> + *   between when fences for an atomic modeset are published, and when the
> + *   corresponding vblank completes, including any interrupt processing and
> + *   related workers. Auditing all that code, across all drivers, is not
> + *   feasible.
> + *
> + * * Due to how many other subsystems are involved and the locking hierarchies
> + *   this pulls in there is extremely thin wiggle-room for driver-specific
> + *   differences. &dma_fence interacts with almost all of the core memory
> + *   handling through page fault handlers via &dma_resv, dma_resv_lock() and
> + *   dma_resv_unlock(). On the other side it also interacts through all
> + *   allocation sites through &mmu_notifier and &shrinker.
> + *
> + * Furthermore lockdep does not handle cross-release dependencies, which means
> + * any deadlocks between dma_fence_wait() and dma_fence_signal() can't be caught
> + * at runtime with some quick testing. The simplest example is one thread
> + * waiting on a &dma_fence while holding a lock::
> + *
> + *     lock(A);
> + *     dma_fence_wait(B);
> + *     unlock(A);
> + *
> + * while the other thread is stuck trying to acquire the same lock, which
> + * prevents it from signalling the fence the previous thread is stuck waiting
> + * on::
> + *
> + *     lock(A);
> + *     unlock(A);
> + *     dma_fence_signal(B);
> + *
> + * By manually annotating all code relevant to signalling a &dma_fence we can
> + * teach lockdep about these dependencies, which also helps with the validation
> + * headache since now lockdep can check all the rules for us::
> + *
> + *    cookie = dma_fence_begin_signalling();
> + *    lock(A);
> + *    unlock(A);
> + *    dma_fence_signal(B);
> + *    dma_fence_end_signalling(cookie);
> + *
> + * For using dma_fence_begin_signalling() and dma_fence_end_signalling() to
> + * annotate critical sections the following rules need to be observed:
> + *
> + * * All code necessary to complete a &dma_fence must be annotated, from the
> + *   point where a fence is accessible to other threads, to the point where
> + *   dma_fence_signal() is called. Un-annotated code can contain deadlock issues,
> + *   and due to the very strict rules and many corner cases it is infeasible to
> + *   catch these just with review or normal stress testing.
> + *
> + * * &struct dma_resv deserves a special note, since the readers are only
> + *   protected by rcu. This means the signalling critical section starts as soon
> + *   as the new fences are installed, even before dma_resv_unlock() is called.
> + *
> + * * The only exception are fast paths and opportunistic signalling code, which
> + *   calls dma_fence_signal() purely as an optimization, but is not required to
> + *   guarantee completion of a &dma_fence. The usual example is a wait IOCTL
> + *   which calls dma_fence_signal(), while the mandatory completion path goes
> + *   through a hardware interrupt and possible job completion worker.
> + *
> + * * To aid composability of code, the annotations can be freely nested, as long
> + *   as the overall locking hierarchy is consistent. The annotations also work
> + *   both in interrupt and process context. Due to implementation details this
> + *   requires that callers pass an opaque cookie from
> + *   dma_fence_begin_signalling() to dma_fence_end_signalling().
> + *
> + * * Validation against the cross driver contract is implemented by priming
> + *   lockdep with the relevant hierarchy at boot-up. This means even just
> + *   testing with a single device is enough to validate a driver, at least as
> + *   far as deadlocks with dma_fence_wait() against dma_fence_signal() are
> + *   concerned.
> + */
> +#ifdef CONFIG_LOCKDEP
> +struct lockdep_map	dma_fence_lockdep_map = {
> +	.name = "dma_fence_map"
> +};
> +
> +/**
> + * dma_fence_begin_signalling - begin a critical DMA fence signalling section
> + *
> + * Drivers should use this to annotate the beginning of any code section
> + * required to eventually complete &dma_fence by calling dma_fence_signal().
> + *
> + * The end of these critical sections are annotated with
> + * dma_fence_end_signalling().
> + *
> + * Returns:
> + *
> + * Opaque cookie needed by the implementation, which needs to be passed to
> + * dma_fence_end_signalling().
> + */
> +bool dma_fence_begin_signalling(void)
> +{
> +	/* explicitly nesting ... */
> +	if (lock_is_held_type(&dma_fence_lockdep_map, 1))
> +		return true;
> +
> +	/* rely on might_sleep check for soft/hardirq locks */
> +	if (in_atomic())
> +		return true;
> +
> +	/* ... and non-recursive readlock */
> +	lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _RET_IP_);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(dma_fence_begin_signalling);
> +
> +/**
> + * dma_fence_end_signalling - end a critical DMA fence signalling section
> + *
> + * Closes a critical section annotation opened by dma_fence_begin_signalling().
> + */
> +void dma_fence_end_signalling(bool cookie)
> +{
> +	if (cookie)
> +		return;
> +
> +	lock_release(&dma_fence_lockdep_map, _RET_IP_);
> +}
> +EXPORT_SYMBOL(dma_fence_end_signalling);
> +
> +void __dma_fence_might_wait(void)
> +{
> +	bool tmp;
> +
> +	tmp = lock_is_held_type(&dma_fence_lockdep_map, 1);
> +	if (tmp)
> +		lock_release(&dma_fence_lockdep_map, _THIS_IP_);
> +	lock_map_acquire(&dma_fence_lockdep_map);
> +	lock_map_release(&dma_fence_lockdep_map);
> +	if (tmp)
> +		lock_acquire(&dma_fence_lockdep_map, 0, 0, 1, 1, NULL, _THIS_IP_);
> +}
> +#endif
> +
> +
>   /**
>    * dma_fence_signal_locked - signal completion of a fence
>    * @fence: the fence to signal
> @@ -170,14 +324,19 @@ int dma_fence_signal(struct dma_fence *fence)
>   {
>   	unsigned long flags;
>   	int ret;
> +	bool tmp;
>   
>   	if (!fence)
>   		return -EINVAL;
>   
> +	tmp = dma_fence_begin_signalling();
> +
>   	spin_lock_irqsave(fence->lock, flags);
>   	ret = dma_fence_signal_locked(fence);
>   	spin_unlock_irqrestore(fence->lock, flags);
>   
> +	dma_fence_end_signalling(tmp);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL(dma_fence_signal);
> @@ -210,6 +369,8 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
>   
>   	might_sleep();
>   
> +	__dma_fence_might_wait();
> +
>   	trace_dma_fence_wait_start(fence);
>   	if (fence->ops->wait)
>   		ret = fence->ops->wait(fence, intr, timeout);
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 3347c54f3a87..3f288f7db2ef 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -357,6 +357,18 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu **fencep)
>   	} while (1);
>   }
>   
> +#ifdef CONFIG_LOCKDEP
> +bool dma_fence_begin_signalling(void);
> +void dma_fence_end_signalling(bool cookie);
> +#else
> +static inline bool dma_fence_begin_signalling(void)
> +{
> +	return true;
> +}
> +static inline void dma_fence_end_signalling(bool cookie) {}
> +static inline void __dma_fence_might_wait(void) {}
> +#endif
> +
>   int dma_fence_signal(struct dma_fence *fence);
>   int dma_fence_signal_locked(struct dma_fence *fence);
>   signed long dma_fence_default_wait(struct dma_fence *fence,
