Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6C41F63E5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFKIoj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 04:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgFKIoj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 04:44:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F640C03E96F;
        Thu, 11 Jun 2020 01:44:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so5587440ejn.10;
        Thu, 11 Jun 2020 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dyB5ymhOUYfsgOuYaL4XbtnTAmjSGqLiWLGp+voTc2A=;
        b=Sa24oVhm/8B5xet7EPJ4/MRwMG9pCgrKFGMqAe3SONnDQUnX4heXuYfBy5Ixt58MP5
         xjjCuE9m7IUwOAsEmYdy8mbACsq2ex8qXKLfczqSxYCfwJbSI+6PJBqh8vUW9xg74HL4
         8+ydyRFDyYemLFmoTytWTRwnnavoxsUZB6EtJIvtRkxgAoeIWTVXRWWnjygpyEWRdzYA
         VRtw3i2qGtGG92v9Ovzc6livvwR7v46V6KBGa9jwd7GEuXFpzXJTg+jT04dsEwCaoR7t
         n3QN951JwnOBhY4ynwkHV7DILiUf0gpnlpRa0g+KSCpO9fScPk4MODUv6SwFnIJkVAVT
         eEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dyB5ymhOUYfsgOuYaL4XbtnTAmjSGqLiWLGp+voTc2A=;
        b=GtijtW8VoHKp9EaBJ9+eiSf3x7sryTme24zo8iLNu7FZUK15Rfq32sNJT/uXcXZWXf
         O8DB/N0Hrx+9cDYC8hEYKa/0G8AhdCAXTQ21qP2lbHVyqNKUVivNzlDa97E7w4QUzuCi
         rJYCvsYmgQ8OA5OnnmDwwq/Wh56WZA+0AZ6eeQsGotjq13d4CL3e91YxjCqe1iw8GzUs
         U3+CPC88vujg5gN2IptrGQyMCwdEyjCQnU9hYEZ9HjgHJpndti4p39i4c5fCDi17fAUO
         4xMl5Bto1FkbaTKEMGcPRg5zsQm7AHg8FKxctIlUBVoZRUR45tHZK1LFhV2nRLIXsvnN
         VoPg==
X-Gm-Message-State: AOAM530TsI8xQw+i1KQMxxHELOszOgwxk3bIAvuHSPJe4WJgMhiG3Z8V
        s4IraL8fqLTmPYDGs59J080GNuaN7LMi4iO0qPo=
X-Google-Smtp-Source: ABdhPJyyvbmpR5itDPokp01aqVx37qiEbG+AaFyU2VF1ZF4GEMP/3/UQqu5mG6cuNL9hhOQyiLsMvAEgTVF/k/3e5Ck=
X-Received: by 2002:a17:906:c9d6:: with SMTP id hk22mr7161397ejb.101.1591865077473;
 Thu, 11 Jun 2020 01:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <159186243606.1506.4437341616828968890@build.alporthouse.com>
In-Reply-To: <159186243606.1506.4437341616828968890@build.alporthouse.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 11 Jun 2020 18:44:26 +1000
Message-ID: <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
Subject: Re: [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 11 Jun 2020 at 18:01, Chris Wilson <chris@chris-wilson.co.uk> wrote=
:
>
> Quoting Daniel Vetter (2020-06-04 09:12:09)
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
> > other lock is acquired between the dma_fence_begin_signalling() call an=
d
> > the call to dma_fence_wait(), and still held, this will result in an
> > immediate lockdep complaint. The only other option would be to not
> > annotate such calls, defeating the point. Therefore these annotations
> > cannot be sprinkled over the code entirely mindless to avoid false
> > positives.
> >
> > v2: handle soft/hardirq ctx better against write side and dont forget
> > EXPORT_SYMBOL, drivers can't use this otherwise.
> >
> > v3: Kerneldoc.
> >
> > v4: Some spelling fixes from Mika
> >
> > Cc: Mika Kuoppala <mika.kuoppala@intel.com>
> > Cc: Thomas Hellstrom <thomas.hellstrom@intel.com>
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>
> Introducing a global lockmap that cannot capture the rules correctly,

Can you document the rules all drivers should be following then,
because from here it looks to get refactored every version of i915,
and it would be nice if we could all aim for the same set of things
roughly. We've already had enough problems with amdgpu vs i915 vs
everyone else with fences, if this stops that in the future then I'd
rather we have that than just some unwritten rules per driver and
untestable.

Dave.
