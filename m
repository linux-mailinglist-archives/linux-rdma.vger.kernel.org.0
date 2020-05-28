Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B516A1E628A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 15:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgE1Nnh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 09:43:37 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:33920 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390468AbgE1Nng (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 May 2020 09:43:36 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 09:43:35 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id D92C53F3E6;
        Thu, 28 May 2020 15:37:40 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=i8189QXo;
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
        with ESMTP id tWEVle6VlQ0m; Thu, 28 May 2020 15:37:36 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 4772F3F398;
        Thu, 28 May 2020 15:37:33 +0200 (CEST)
Received: from Gunillas-MacBook-Pro.local (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5B030360165;
        Thu, 28 May 2020 15:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1590673053; bh=hzBvGtdMVY1yFDhX6vHBpO0alm4n63ua22McT7gZosc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i8189QXoVaRwcn+moTSIMQD7TJ7H9n0I1yFj2IMYL7PullzNred3UO8BAAnz2DeMq
         j/VrfOha1hYBt/0oje3SsVmDflH1Wva31htryiedFwwGczZJYD1NmbCNmJNQfVSK5z
         6PWj3YdF/MSpTB+pJ0H/4RhVF8RvgNw2PZv4Ful4=
Subject: Re: [RFC 02/17] dma-fence: basic lockdep annotations
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     linux-rdma@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linaro-mm-sig@lists.linaro.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-3-daniel.vetter@ffwll.ch>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <81b3a3be-b818-9e7c-e93e-ecf161bec94c@shipmail.org>
Date:   Thu, 28 May 2020 15:36:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200512085944.222637-3-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-05-12 10:59, Daniel Vetter wrote:
> Design is similar to the lockdep annotations for workers, but with
> some twists:
>
> - We use a read-lock for the execution/worker/completion side, so that
>    this explicit annotation can be more liberally sprinkled around.
>    With read locks lockdep isn't going to complain if the read-side
>    isn't nested the same way under all circumstances, so ABBA deadlocks
>    are ok. Which they are, since this is an annotation only.
>
> - We're using non-recursive lockdep read lock mode, since in recursive
>    read lock mode lockdep does not catch read side hazards. And we
>    _very_ much want read side hazards to be caught. For full details of
>    this limitation see
>
>    commit e91498589746065e3ae95d9a00b068e525eec34f
>    Author: Peter Zijlstra <peterz@infradead.org>
>    Date:   Wed Aug 23 13:13:11 2017 +0200
>
>        locking/lockdep/selftests: Add mixed read-write ABBA tests
>
> - To allow nesting of the read-side explicit annotations we explicitly
>    keep track of the nesting. lock_is_held() allows us to do that.
>
> - The wait-side annotation is a write lock, and entirely done within
>    dma_fence_wait() for everyone by default.
>
> - To be able to freely annotate helper functions I want to make it ok
>    to call dma_fence_begin/end_signalling from soft/hardirq context.
>    First attempt was using the hardirq locking context for the write
>    side in lockdep, but this forces all normal spinlocks nested within
>    dma_fence_begin/end_signalling to be spinlocks. That bollocks.
>
>    The approach now is to simple check in_atomic(), and for these cases
>    entirely rely on the might_sleep() check in dma_fence_wait(). That
>    will catch any wrong nesting against spinlocks from soft/hardirq
>    contexts.
>
> The idea here is that every code path that's critical for eventually
> signalling a dma_fence should be annotated with
> dma_fence_begin/end_signalling. The annotation ideally starts right
> after a dma_fence is published (added to a dma_resv, exposed as a
> sync_file fd, attached to a drm_syncobj fd, or anything else that
> makes the dma_fence visible to other kernel threads), up to and
> including the dma_fence_wait(). Examples are irq handlers, the
> scheduler rt threads, the tail of execbuf (after the corresponding
> fences are visible), any workers that end up signalling dma_fences and
> really anything else. Not annotated should be code paths that only
> complete fences opportunistically as the gpu progresses, like e.g.
> shrinker/eviction code.
>
> The main class of deadlocks this is supposed to catch are:
>
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
>
> v2: handle soft/hardirq ctx better against write side and dont forget
> EXPORT_SYMBOL, drivers can't use this otherwise.
>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

LGTM. Perhaps some in-code documentation on how to use the new functions 
are called.

Otherwise for patch 2 and 3,

Reviewed-by: Thomas Hellstrom <thomas.hellstrom@intel.com>


