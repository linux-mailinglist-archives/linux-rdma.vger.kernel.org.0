Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90751CF123
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgELJIz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729341AbgELJIw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 05:08:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFCC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:08:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so8706027wmf.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jzP01IXQ5eGzmClfzRrzEt9a5pXaL37GUGmE/8HDFqg=;
        b=ZpO+oii6BJ0922ZWi/doBJJdNU8MgvEFRJGPPrgqvjItQyjxIAEt6nldriLjMMSi6E
         cbddUHWC+jMAlDoWDHnFidnZzW7kAgZtRQn4SlOFf8XMusi/It2bVulVLr2VvFLt+29A
         b6wKDwd90FXsjiUfeuJIVZ2kW6M1QNATTTUqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=jzP01IXQ5eGzmClfzRrzEt9a5pXaL37GUGmE/8HDFqg=;
        b=KXqxYHTNHb24PhvCV+6vw3stBzj4FwpX+JTM4ZEPNyt5LDy6EcZOTfPyxTtHlp2gl+
         80O7qFyeLGi878USb3lcbsScooO/W6A1ovdYgLIYlgX+UhIbl83Sm53XH9UIThRgd5gQ
         CAXHi9fuNYTmwK46BgFXQUBbdsX1OZ1L16+6EKsLqJDKVVRwAfOvxk1eDpXllWPBhJFo
         o4Nm3kOmb/ieeAbUs8VgRibNmWTBmIQ79c+MGxZU14A9cQiEn9SLpOd/5i+3g2O2gJQm
         FfjMBIvSWCgzQo6VDDne63k9rX6amO6H9AZZXqL6mS2hXhhIyr1t0SsbimRm9z0Cx9ch
         8KzQ==
X-Gm-Message-State: AGi0PuaSKS8RSfevGL+GRyIhHU2MdrvOPcrJzNpMpcTkbWKKIotZcVTf
        CwRaXsPCuLDIEQoGKGi7NjzQvg==
X-Google-Smtp-Source: APiQypIhpsRgAW4Qev4lJv2wjqsih/+HjYzRewf0be+k5nEHYH6mVDG9QApT/mcRCdYD95LJWrPJxQ==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr12839616wmf.103.1589274530333;
        Tue, 12 May 2020 02:08:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z1sm30605053wmf.15.2020.05.12.02.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:08:49 -0700 (PDT)
Date:   Tue, 12 May 2020 11:08:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
Message-ID: <20200512090847.GF206103@phenom.ffwll.local>
Mail-Followup-To: Chris Wilson <chris@chris-wilson.co.uk>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
 <158927426244.15653.14406159524439944950@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158927426244.15653.14406159524439944950@build.alporthouse.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 10:04:22AM +0100, Chris Wilson wrote:
> Quoting Daniel Vetter (2020-05-12 09:59:29)
> > Design is similar to the lockdep annotations for workers, but with
> > some twists:
> > 
> > - We use a read-lock for the execution/worker/completion side, so that
> >   this explicit annotation can be more liberally sprinkled around.
> >   With read locks lockdep isn't going to complain if the read-side
> >   isn't nested the same way under all circumstances, so ABBA deadlocks
> >   are ok. Which they are, since this is an annotation only.
> > 
> > - We're using non-recursive lockdep read lock mode, since in recursive
> >   read lock mode lockdep does not catch read side hazards. And we
> >   _very_ much want read side hazards to be caught. For full details of
> >   this limitation see
> > 
> >   commit e91498589746065e3ae95d9a00b068e525eec34f
> >   Author: Peter Zijlstra <peterz@infradead.org>
> >   Date:   Wed Aug 23 13:13:11 2017 +0200
> > 
> >       locking/lockdep/selftests: Add mixed read-write ABBA tests
> > 
> > - To allow nesting of the read-side explicit annotations we explicitly
> >   keep track of the nesting. lock_is_held() allows us to do that.
> > 
> > - The wait-side annotation is a write lock, and entirely done within
> >   dma_fence_wait() for everyone by default.
> > 
> > - To be able to freely annotate helper functions I want to make it ok
> >   to call dma_fence_begin/end_signalling from soft/hardirq context.
> >   First attempt was using the hardirq locking context for the write
> >   side in lockdep, but this forces all normal spinlocks nested within
> >   dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> > 
> >   The approach now is to simple check in_atomic(), and for these cases
> >   entirely rely on the might_sleep() check in dma_fence_wait(). That
> >   will catch any wrong nesting against spinlocks from soft/hardirq
> >   contexts.
> > 
> > The idea here is that every code path that's critical for eventually
> > signalling a dma_fence should be annotated with
> > dma_fence_begin/end_signalling. The annotation ideally starts right
> > after a dma_fence is published (added to a dma_resv, exposed as a
> > sync_file fd, attached to a drm_syncobj fd, or anything else that
> > makes the dma_fence visible to other kernel threads), up to and
> > including the dma_fence_wait(). Examples are irq handlers, the
> > scheduler rt threads, the tail of execbuf (after the corresponding
> > fences are visible), any workers that end up signalling dma_fences and
> > really anything else. Not annotated should be code paths that only
> > complete fences opportunistically as the gpu progresses, like e.g.
> > shrinker/eviction code.
> > 
> > The main class of deadlocks this is supposed to catch are:
> > 
> > Thread A:
> > 
> >         mutex_lock(A);
> >         mutex_unlock(A);
> > 
> >         dma_fence_signal();
> > 
> > Thread B:
> > 
> >         mutex_lock(A);
> >         dma_fence_wait();
> >         mutex_unlock(A);
> > 
> > Thread B is blocked on A signalling the fence, but A never gets around
> > to that because it cannot acquire the lock A.
> > 
> > Note that dma_fence_wait() is allowed to be nested within
> > dma_fence_begin/end_signalling sections. To allow this to happen the
> > read lock needs to be upgraded to a write lock, which means that any
> > other lock is acquired between the dma_fence_begin_signalling() call and
> > the call to dma_fence_wait(), and still held, this will result in an
> > immediate lockdep complaint. The only other option would be to not
> > annotate such calls, defeating the point. Therefore these annotations
> > cannot be sprinkled over the code entirely mindless to avoid false
> > positives.
> > 
> > v2: handle soft/hardirq ctx better against write side and dont forget
> > EXPORT_SYMBOL, drivers can't use this otherwise.
> > 
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  drivers/dma-buf/dma-fence.c | 53 +++++++++++++++++++++++++++++++++++++
> >  include/linux/dma-fence.h   | 12 +++++++++
> >  2 files changed, 65 insertions(+)
> > 
> > diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> > index 6802125349fb..d5c0fd2efc70 100644
> > --- a/drivers/dma-buf/dma-fence.c
> > +++ b/drivers/dma-buf/dma-fence.c
> > @@ -110,6 +110,52 @@ u64 dma_fence_context_alloc(unsigned num)
> >  }
> >  EXPORT_SYMBOL(dma_fence_context_alloc);
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +struct lockdep_map     dma_fence_lockdep_map = {
> > +       .name = "dma_fence_map"
> > +};
> 
> Not another false global sharing lockmap.

It's a global contract, it needs a global lockdep map. And yes a big
reason for the motivation here is that i915-gem has a tremendous urge to
just redefine all these global locks to fit to some local interpretation
of what's going on.

That doesn't make the resulting real&existing deadlocks go away.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
