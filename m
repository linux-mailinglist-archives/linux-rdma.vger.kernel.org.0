Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE6F219A8D
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGIIJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 04:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgGIIJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 04:09:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1DC061A0B
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 01:09:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so1344655wrn.3
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xILi+P7oxRN9bsl9W4i3+0ke3SSO/cGJKcOayGROABg=;
        b=Z8SGMwegjGqLUQQfKqZmW8OnZt4atfyK+euHQ66oyCKzXXabJQBna2CgnG6gYEwSxx
         JTBXk5cMDf6pHwZTG/X54Jme6aPmwyba+D85KHNMCZiewSxIUuN5gy8I1HAZsFiE5L39
         Zasqwt5fVM3jrkrCUHQ9O5XKDxbXPWsMXZZ4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xILi+P7oxRN9bsl9W4i3+0ke3SSO/cGJKcOayGROABg=;
        b=hp1iCF17BfAzBrmL3HMmITCaNNAh3iedqivCrBjRivDL+kBBe9QricghGopP5zn7Co
         JDFoWEg67/W8kyVB9BOk5Oz9x+K2Hb8anUFOs1Tzsp624E7rBnnHVPgDGcbjB2Yh6PPn
         ZrWD/LtZeVitL9RqLoajj1SBHZCcYr1JG7CFH8dMQ/jPVjOFJ3ptd4pionxCeTwd2pgn
         RdhmdF9k6kR3um+ZF3fF544iixG2taRI2KtOIZ0BVWLNmu/EjdnX4HAsdppmTwnmVI2j
         TM40YCv7ewUmtUzzGigRyRTbzbByoIuerJe+sBlwLhQ9InjOq8BxqCB1UPwfFhdzz/er
         1VoQ==
X-Gm-Message-State: AOAM530Kgo89xhBz8UeGVScHCb/HOsuwq+i7ucT2RAvz0Gj9YZyFthdi
        +0Cx6NfokYgIKaZff5zEGHTB6g==
X-Google-Smtp-Source: ABdhPJyXjosHa1e1FEUu0z2TQteu7t+nU4sUeh2Velm8Y72+jQHU242c3Oro8DJvZSDfcbp2iGZgaA==
X-Received: by 2002:adf:828b:: with SMTP id 11mr66734825wrc.58.1594282154016;
        Thu, 09 Jul 2020 01:09:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d132sm3541640wmd.35.2020.07.09.01.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 01:09:13 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:09:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        kernel test robot <lkp@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 02/25] dma-fence: prime lockdep annotations
Message-ID: <20200709080911.GP3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707201229.472834-3-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Below the paragraph I've added after our discussions around dma-fences
outside of drivers/gpu. Good enough for an ack on this, or want something
changed?

Thanks, Daniel

> + * Note that only GPU drivers have a reasonable excuse for both requiring
> + * &mmu_interval_notifier and &shrinker callbacks at the same time as having to
> + * track asynchronous compute work using &dma_fence. No driver outside of
> + * drivers/gpu should ever call dma_fence_wait() in such contexts.


On Tue, Jul 07, 2020 at 10:12:06PM +0200, Daniel Vetter wrote:
> Two in one go:
> - it is allowed to call dma_fence_wait() while holding a
>   dma_resv_lock(). This is fundamental to how eviction works with ttm,
>   so required.
> 
> - it is allowed to call dma_fence_wait() from memory reclaim contexts,
>   specifically from shrinker callbacks (which i915 does), and from mmu
>   notifier callbacks (which amdgpu does, and which i915 sometimes also
>   does, and probably always should, but that's kinda a debate). Also
>   for stuff like HMM we really need to be able to do this, or things
>   get real dicey.
> 
> Consequence is that any critical path necessary to get to a
> dma_fence_signal for a fence must never a) call dma_resv_lock nor b)
> allocate memory with GFP_KERNEL. Also by implication of
> dma_resv_lock(), no userspace faulting allowed. That's some supremely
> obnoxious limitations, which is why we need to sprinkle the right
> annotations to all relevant paths.
> 
> The one big locking context we're leaving out here is mmu notifiers,
> added in
> 
> commit 23b68395c7c78a764e8963fc15a7cfd318bf187f
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Mon Aug 26 22:14:21 2019 +0200
> 
>     mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end
> 
> that one covers a lot of other callsites, and it's also allowed to
> wait on dma-fences from mmu notifiers. But there's no ready-made
> functions exposed to prime this, so I've left it out for now.
> 
> v2: Also track against mmu notifier context.
> 
> v3: kerneldoc to spec the cross-driver contract. Note that currently
> i915 throws in a hard-coded 10s timeout on foreign fences (not sure
> why that was done, but it's there), which is why that rule is worded
> with SHOULD instead of MUST.
> 
> Also some of the mmu_notifier/shrinker rules might surprise SoC
> drivers, I haven't fully audited them all. Which is infeasible anyway,
> we'll need to run them with lockdep and dma-fence annotations and see
> what goes boom.
> 
> v4: A spelling fix from Mika
> 
> v5: #ifdef for CONFIG_MMU_NOTIFIER. Reported by 0day. Unfortunately
> this means lockdep enforcement is slightly inconsistent, it won't spot
> GFP_NOIO and GFP_NOFS allocations in the wrong spot if
> CONFIG_MMU_NOTIFIER is disabled in the kernel config. Oh well.
> 
> v5: Note that only drivers/gpu has a reasonable (or at least
> historical) excuse to use dma_fence_wait() from shrinker and mmu
> notifier callbacks. Everyone else should either have a better memory
> manager model, or better hardware. This reflects discussions with
> Jason Gunthorpe.
> 
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: kernel test robot <lkp@intel.com>
> Reviewed-by: Thomas Hellström <thomas.hellstrom@intel.com> (v4)
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
>  Documentation/driver-api/dma-buf.rst |  6 ++++
>  drivers/dma-buf/dma-fence.c          | 46 ++++++++++++++++++++++++++++
>  drivers/dma-buf/dma-resv.c           |  8 +++++
>  include/linux/dma-fence.h            |  1 +
>  4 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
> index 05d856131140..f8f6decde359 100644
> --- a/Documentation/driver-api/dma-buf.rst
> +++ b/Documentation/driver-api/dma-buf.rst
> @@ -133,6 +133,12 @@ DMA Fences
>  .. kernel-doc:: drivers/dma-buf/dma-fence.c
>     :doc: DMA fences overview
>  
> +DMA Fence Cross-Driver Contract
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: drivers/dma-buf/dma-fence.c
> +   :doc: fence cross-driver contract
> +
>  DMA Fence Signalling Annotations
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 0005bc002529..af1d8ea926b3 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -64,6 +64,52 @@ static atomic64_t dma_fence_context_counter = ATOMIC64_INIT(1);
>   *   &dma_buf.resv pointer.
>   */
>  
> +/**
> + * DOC: fence cross-driver contract
> + *
> + * Since &dma_fence provide a cross driver contract, all drivers must follow the
> + * same rules:
> + *
> + * * Fences must complete in a reasonable time. Fences which represent kernels
> + *   and shaders submitted by userspace, which could run forever, must be backed
> + *   up by timeout and gpu hang recovery code. Minimally that code must prevent
> + *   further command submission and force complete all in-flight fences, e.g.
> + *   when the driver or hardware do not support gpu reset, or if the gpu reset
> + *   failed for some reason. Ideally the driver supports gpu recovery which only
> + *   affects the offending userspace context, and no other userspace
> + *   submissions.
> + *
> + * * Drivers may have different ideas of what completion within a reasonable
> + *   time means. Some hang recovery code uses a fixed timeout, others a mix
> + *   between observing forward progress and increasingly strict timeouts.
> + *   Drivers should not try to second guess timeout handling of fences from
> + *   other drivers.
> + *
> + * * To ensure there's no deadlocks of dma_fence_wait() against other locks
> + *   drivers should annotate all code required to reach dma_fence_signal(),
> + *   which completes the fences, with dma_fence_begin_signalling() and
> + *   dma_fence_end_signalling().
> + *
> + * * Drivers are allowed to call dma_fence_wait() while holding dma_resv_lock().
> + *   This means any code required for fence completion cannot acquire a
> + *   &dma_resv lock. Note that this also pulls in the entire established
> + *   locking hierarchy around dma_resv_lock() and dma_resv_unlock().
> + *
> + * * Drivers are allowed to call dma_fence_wait() from their &shrinker
> + *   callbacks. This means any code required for fence completion cannot
> + *   allocate memory with GFP_KERNEL.
> + *
> + * * Drivers are allowed to call dma_fence_wait() from their &mmu_notifier
> + *   respectively &mmu_interval_notifier callbacks. This means any code required
> + *   for fence completeion cannot allocate memory with GFP_NOFS or GFP_NOIO.
> + *   Only GFP_ATOMIC is permissible, which might fail.
> + *
> + * Note that only GPU drivers have a reasonable excuse for both requiring
> + * &mmu_interval_notifier and &shrinker callbacks at the same time as having to
> + * track asynchronous compute work using &dma_fence. No driver outside of
> + * drivers/gpu should ever call dma_fence_wait() in such contexts.
> + */
> +
>  static const char *dma_fence_stub_get_name(struct dma_fence *fence)
>  {
>          return "stub";
> diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
> index e7d7197d48ce..0e6675ec1d11 100644
> --- a/drivers/dma-buf/dma-resv.c
> +++ b/drivers/dma-buf/dma-resv.c
> @@ -36,6 +36,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/sched/mm.h>
> +#include <linux/mmu_notifier.h>
>  
>  /**
>   * DOC: Reservation Object Overview
> @@ -116,6 +117,13 @@ static int __init dma_resv_lockdep(void)
>  	if (ret == -EDEADLK)
>  		dma_resv_lock_slow(&obj, &ctx);
>  	fs_reclaim_acquire(GFP_KERNEL);
> +#ifdef CONFIG_MMU_NOTIFIER
> +	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
> +	__dma_fence_might_wait();
> +	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
> +#else
> +	__dma_fence_might_wait();
> +#endif
>  	fs_reclaim_release(GFP_KERNEL);
>  	ww_mutex_unlock(&obj.lock);
>  	ww_acquire_fini(&ctx);
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 3f288f7db2ef..09e23adb351d 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -360,6 +360,7 @@ dma_fence_get_rcu_safe(struct dma_fence __rcu **fencep)
>  #ifdef CONFIG_LOCKDEP
>  bool dma_fence_begin_signalling(void);
>  void dma_fence_end_signalling(bool cookie);
> +void __dma_fence_might_wait(void);
>  #else
>  static inline bool dma_fence_begin_signalling(void)
>  {
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
