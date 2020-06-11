Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE01F6A0C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgFKO34 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgFKO3z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 10:29:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA920C08C5C2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 07:29:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id e20so2725033qvu.0
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iS2yXa8gKHNwS2UChvutG5V1O7eVsWQuqeZ34MVLXc0=;
        b=FseEPp8Fso/6As15zVP3Ym7NPs9kvuOvCIptWPzePslhXjFzBDqQXKhNnYWATD+15R
         Al/WYp+hbHsKFK4X2ojiK+EHs7yhQmmL+EDMNyPnOR89aEMfOJc5yjRH0aJYrgc62Vs4
         Doe6mzmOoH4EXTAuqTBF2FSP/hDXXwvjF9/30kmpRxNG9NB7+P9LM/fisKeD5/yoOQW2
         PEChRlkS/fkvSbixN4O37472Uu4NlrAggCY6VhNzkkPK4SDvGr55LxYD+4T/EdoOhWVl
         4gdKknLaMPLAltUrhRVsboI89uK5/pkjAghK31JbmOaIh7KRRHIu3+t+3Jd7dolDArof
         vWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iS2yXa8gKHNwS2UChvutG5V1O7eVsWQuqeZ34MVLXc0=;
        b=kjyr63QZWmN5cliINI/ii7l2CN6QKTO28x6Eey5BfXo7b13jawAkWaEwXsyKCV8SIo
         frX5uZEjTwpdG7J57LYsFaQyCg74hE4b+Tn/CrzwN3r2MuoIf66+z9/UREI/a880kgOM
         ujI6gas5BMy+yiQ+Lbh05jmMS9P94dbJimsiKQPdTZ4cMWUl5EIdeLjgMBK9yMixQlaf
         DcqfD10syNvLqEfSVTpnhGzNKcUk83eT8EMFr7xvvQaY21TaY78ZplpVNwqcD/m2E4YA
         uOQCD0XZtuh4uAvMYmUgLJTrv0spJBA8WzEC+ijkZ7vQQh1V+62g9ZSTEvcbSdobw5pi
         cYXg==
X-Gm-Message-State: AOAM531Ybsv/ajfqVw0HUnyffhTs/C6ecFFyajj+91FIuBH4SMH4xfTf
        blf93YFUtHOSlr3YSaJLnRDPGg==
X-Google-Smtp-Source: ABdhPJyglizbugl/WH3rPRKasgzr+R/H6TfhyQSpLDpaYV29o2R1YgDECnGExOwsuREk0P31Na2jyw==
X-Received: by 2002:a05:6214:13e6:: with SMTP id ch6mr8093893qvb.29.1591885794923;
        Thu, 11 Jun 2020 07:29:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 195sm2287728qkg.74.2020.06.11.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:29:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jjODJ-005xNV-Ml; Thu, 11 Jun 2020 11:29:53 -0300
Date:   Thu, 11 Jun 2020 11:29:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
Message-ID: <20200611142953.GA1419658@ziepe.ca>
References: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
 <20200610194101.1668038-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610194101.1668038-1-daniel.vetter@ffwll.ch>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 10, 2020 at 09:41:01PM +0200, Daniel Vetter wrote:
> fs_reclaim_acquire/release nicely catch recursion issues when
> allocating GFP_KERNEL memory against shrinkers (which gpu drivers tend
> to use to keep the excessive caches in check). For mmu notifier
> recursions we do have lockdep annotations since 23b68395c7c7
> ("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end").
> 
> But these only fire if a path actually results in some pte
> invalidation - for most small allocations that's very rarely the case.
> The other trouble is that pte invalidation can happen any time when
> __GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
> choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
> recursion.
> 
> I was pondering whether we should just do the general annotation, but
> there's always the risk for false positives. Plus I'm assuming that
> the core fs and io code is a lot better reviewed and tested than
> random mmu notifier code in drivers. Hence why I decide to only
> annotate for that specific case.
> 
> Furthermore even if we'd create a lockdep map for direct reclaim, we'd
> still need to explicit pull in the mmu notifier map - there's a lot
> more places that do pte invalidation than just direct reclaim, these
> two contexts arent the same.
> 
> Note that the mmu notifiers needing their own independent lockdep map
> is also the reason we can't hold them from fs_reclaim_acquire to
> fs_reclaim_release - it would nest with the acquistion in the pte
> invalidation code, causing a lockdep splat. And we can't remove the
> annotations from pte invalidation and all the other places since
> they're called from many other places than page reclaim. Hence we can
> only do the equivalent of might_lock, but on the raw lockdep map.
> 
> With this we can also remove the lockdep priming added in 66204f1d2d1b
> ("mm/mmu_notifiers: prime lockdep") since the new annotations are
> strictly more powerful.
> 
> v2: Review from Thomas Hellstrom:
> - unbotch the fs_reclaim context check, I accidentally inverted it,
>   but it didn't blow up because I inverted it immediately
> - fix compiling for !CONFIG_MMU_NOTIFIER
> 
> Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: linux-mm@kvack.org
> Cc: linux-rdma@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
> This is part of a gpu lockdep annotation series simply because it
> really helps to catch issues where gpu subsystem locks and primitives
> can deadlock with themselves through allocations and mmu notifiers.
> But aside from that motivation it should be completely free-standing,
> and can land through -mm/-rdma/-hmm or any other tree really whenever.
> -Daniel

I'm still not totally clear on how all the GFP flags map to
different behaviors, but this seems plausible to me

At this point it should go through Andrew's tree, thanks

Acked-by: Jason Gunthorpe <jgg@mellanox.com> # For mmu_notifiers

Jason
