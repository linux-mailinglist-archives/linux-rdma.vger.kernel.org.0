Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7221E63CD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391124AbgE1OXi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 10:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391022AbgE1OXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 May 2020 10:23:03 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD58C05BD1E
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 07:23:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x22so2486714otq.4
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mfUajei3iY431nisNFP6PkBPo+jJ4W41Aia4LnYABWQ=;
        b=WDzd8SjjNwXMO9jBFUV22UICn3QjNtcIylC9U7B5hY6KJbg26B2840mcDU5p4vDnUv
         Nr2/JmqmCShZ5RHiRzLG/iiQrswuopP6l/PjjSpVLaGCA/ItEoLa3w9ZwykJpdQf2c6i
         n28dNbkFyHKyZVM6cJTF+DTySwOnOIkSVXCnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mfUajei3iY431nisNFP6PkBPo+jJ4W41Aia4LnYABWQ=;
        b=jjn/CgWiCFm7FylWgyVCjGWpG9f3LdppYIvqqsZBtGT/sED9CeoaPmJOSma/uwJA4V
         8Ny20zu/2EEanhIazLdiKplgakuHU/Q+EhJ7S3ui/B6dgzvo3auKbA5cIswgFsLDsp4k
         uWFaUMKVVwIvVkAPt44HDxqh1F8RURGnL0xMUggHEfXwf/Kg0Ec4kBXySXrK45vV4TgO
         OT2T2ZZ5yjEw0pFg3v2lrRGmOxfyCm6JxXofWYwkWxo8pYYdRjnyX6l7hazl8GCU0hN+
         MJgwCxMQVfXliOIOWsPlNNx5iqP8yakzLtco0gr+A1P4gNmPYDmckzsPcBBW8XsrKDa/
         ZSEg==
X-Gm-Message-State: AOAM533kCtcitjZ9KubgeqGP5Nz6lulPt3Q4YvPFCj9AXJAGwoGB1a2I
        Ke5GaqsQxJdxpNe4OCs1o+2wFi3jjJdFtydL9hZv3g==
X-Google-Smtp-Source: ABdhPJwNxg9CMM36a6ht/5xuPEOxoI2pKA/i8iJaW3IruTtJtLbKte8opXy9jpqttbU0T/qneElqZ9s39dTzaiuFbOY=
X-Received: by 2002:a9d:1d1:: with SMTP id e75mr2300297ote.303.1590675782856;
 Thu, 28 May 2020 07:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch> <81b3a3be-b818-9e7c-e93e-ecf161bec94c@shipmail.org>
In-Reply-To: <81b3a3be-b818-9e7c-e93e-ecf161bec94c@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 28 May 2020 16:22:51 +0200
Message-ID: <CAKMK7uHb-DTKqiBKbcKuVeWPmRBsnq2QjWXQ44oLDE=qxLVvJA@mail.gmail.com>
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 28, 2020 at 3:37 PM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
> On 2020-05-12 10:59, Daniel Vetter wrote:
> > Design is similar to the lockdep annotations for workers, but with
> > some twists:
> >
> > - We use a read-lock for the execution/worker/completion side, so that
> >    this explicit annotation can be more liberally sprinkled around.
> >    With read locks lockdep isn't going to complain if the read-side
> >    isn't nested the same way under all circumstances, so ABBA deadlocks
> >    are ok. Which they are, since this is an annotation only.
> >
> > - We're using non-recursive lockdep read lock mode, since in recursive
> >    read lock mode lockdep does not catch read side hazards. And we
> >    _very_ much want read side hazards to be caught. For full details of
> >    this limitation see
> >
> >    commit e91498589746065e3ae95d9a00b068e525eec34f
> >    Author: Peter Zijlstra <peterz@infradead.org>
> >    Date:   Wed Aug 23 13:13:11 2017 +0200
> >
> >        locking/lockdep/selftests: Add mixed read-write ABBA tests
> >
> > - To allow nesting of the read-side explicit annotations we explicitly
> >    keep track of the nesting. lock_is_held() allows us to do that.
> >
> > - The wait-side annotation is a write lock, and entirely done within
> >    dma_fence_wait() for everyone by default.
> >
> > - To be able to freely annotate helper functions I want to make it ok
> >    to call dma_fence_begin/end_signalling from soft/hardirq context.
> >    First attempt was using the hardirq locking context for the write
> >    side in lockdep, but this forces all normal spinlocks nested within
> >    dma_fence_begin/end_signalling to be spinlocks. That bollocks.
> >
> >    The approach now is to simple check in_atomic(), and for these cases
> >    entirely rely on the might_sleep() check in dma_fence_wait(). That
> >    will catch any wrong nesting against spinlocks from soft/hardirq
> >    contexts.
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
> >       mutex_lock(A);
> >       mutex_unlock(A);
> >
> >       dma_fence_signal();
> >
> > Thread B:
> >
> >       mutex_lock(A);
> >       dma_fence_wait();
> >       mutex_unlock(A);
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
> LGTM. Perhaps some in-code documentation on how to use the new functions
> are called.

See cover letter, that's going to be done for next round. For this one
here I just wanted to showcase a bit how it's used in a few different
places, mostly selected to get as much feedback from across different
drivers. Hence e.g. annotating drm/scheduler.

> Otherwise for patch 2 and 3,
>
> Reviewed-by: Thomas Hellstrom <thomas.hellstrom@intel.com>

I think I'll just cc you for the next round with docs, so you can make
sure it looks ok :-)
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
