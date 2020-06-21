Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9FE202D59
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgFUWJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFUWJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Jun 2020 18:09:46 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138DC061794
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 15:09:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so1887755qkb.8
        for <linux-rdma@vger.kernel.org>; Sun, 21 Jun 2020 15:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PKmshvnxCi3S4qzqvpETs1bTZ4nXpcFNE/ZdSSfX0T8=;
        b=ok6whzLttVjTCO00ZovY5Qp+9Q/FskzrHZBq0nVmfOvL/dcgMm+F7BlV7yqhjjXb2X
         /GwABUb/F6auR4clLv8LxDt1lKCw3f8fujRm3J4i/7DDAQgKxLpG0EuX57O3kZWS14gK
         EsYW/RxS6uQwawrvN4U8hak6jfE0PruLgOG4UWxJzpqfzKghVgpaH+iIV0MUevUsYdyg
         xB1iej8rKxcKHL0hPe/QqnHpLcOSZqD8qT5a3oe6uj8mx/sPXjLPrR9H/ehgbtv1McrY
         iP1jdqNmUV9sf5TPwgiNsgcua92k6hyr6K5LzHUMB/vQlopQ/6WDMCA3F4wCOYffDokR
         bXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PKmshvnxCi3S4qzqvpETs1bTZ4nXpcFNE/ZdSSfX0T8=;
        b=HBCTgF93iJYYUHmWSn+jiA4vBb77Ubbhz/P7VzyNmxRlRkZ1s4OI3yhirQw9KmAvET
         20gKkra/O7+GsFjhUeKofjA/XbO52CYNB+PaOIJpoX2v1Jf28OOdpCYwpbQ/OdFg7axb
         oEY4ZV4KzYbQ610wrF7Li72sm1OEOaVgBT0UQQDEtTU8Kil9mp93DMEEcBTj0yNhL1kq
         6Yy6dugQzKBvtD4yBdKurMkzlP48IShgIvJo/iU791K3UHbHsvEvpzq2x5TJcn+znyRH
         GTb3xZVTfyy+qkKsIwGfpO4TYSwWAEk8krbXUmAlmDlCEbU3zuzk1erhqP3edAdaBSf6
         Zt0A==
X-Gm-Message-State: AOAM532nGQCEtdnH7eO9wJ5QbOt+FazelKrvalVTmbA4QeEbQMPN3M85
        rr4kmD+rX43EVS+xsDLtGbDlNg==
X-Google-Smtp-Source: ABdhPJxLimkm/zUVwedVJyzs6tH8cndzNlIvqCwJYXshoIa3c1bZDmz6pO0xFTlj2WcNXoCJFH1VsA==
X-Received: by 2002:a37:cd4:: with SMTP id 203mr8810965qkm.342.1592777385668;
        Sun, 21 Jun 2020 15:09:45 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k17sm13998471qtb.5.2020.06.21.15.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:09:45 -0700 (PDT)
Date:   Sun, 21 Jun 2020 18:09:37 -0400
From:   Qian Cai <cai@lca.pw>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] mm: Track mmu notifiers in fs_reclaim_acquire/release
Message-ID: <20200621220937.GA2034@lca.pw>
References: <20200604081224.863494-2-daniel.vetter@ffwll.ch>
 <20200610194101.1668038-1-daniel.vetter@ffwll.ch>
 <20200621174205.GB1398@lca.pw>
 <CAKMK7uFZAFVmceoYvqPovOifGw_Y8Ey-OMy6wioMjwPWhu9dDg@mail.gmail.com>
 <20200621200103.GV20149@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200621200103.GV20149@phenom.ffwll.local>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 10:01:03PM +0200, Daniel Vetter wrote:
> On Sun, Jun 21, 2020 at 08:07:08PM +0200, Daniel Vetter wrote:
> > On Sun, Jun 21, 2020 at 7:42 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Wed, Jun 10, 2020 at 09:41:01PM +0200, Daniel Vetter wrote:
> > > > fs_reclaim_acquire/release nicely catch recursion issues when
> > > > allocating GFP_KERNEL memory against shrinkers (which gpu drivers tend
> > > > to use to keep the excessive caches in check). For mmu notifier
> > > > recursions we do have lockdep annotations since 23b68395c7c7
> > > > ("mm/mmu_notifiers: add a lockdep map for invalidate_range_start/end").
> > > >
> > > > But these only fire if a path actually results in some pte
> > > > invalidation - for most small allocations that's very rarely the case.
> > > > The other trouble is that pte invalidation can happen any time when
> > > > __GFP_RECLAIM is set. Which means only really GFP_ATOMIC is a safe
> > > > choice, GFP_NOIO isn't good enough to avoid potential mmu notifier
> > > > recursion.
> > > >
> > > > I was pondering whether we should just do the general annotation, but
> > > > there's always the risk for false positives. Plus I'm assuming that
> > > > the core fs and io code is a lot better reviewed and tested than
> > > > random mmu notifier code in drivers. Hence why I decide to only
> > > > annotate for that specific case.
> > > >
> > > > Furthermore even if we'd create a lockdep map for direct reclaim, we'd
> > > > still need to explicit pull in the mmu notifier map - there's a lot
> > > > more places that do pte invalidation than just direct reclaim, these
> > > > two contexts arent the same.
> > > >
> > > > Note that the mmu notifiers needing their own independent lockdep map
> > > > is also the reason we can't hold them from fs_reclaim_acquire to
> > > > fs_reclaim_release - it would nest with the acquistion in the pte
> > > > invalidation code, causing a lockdep splat. And we can't remove the
> > > > annotations from pte invalidation and all the other places since
> > > > they're called from many other places than page reclaim. Hence we can
> > > > only do the equivalent of might_lock, but on the raw lockdep map.
> > > >
> > > > With this we can also remove the lockdep priming added in 66204f1d2d1b
> > > > ("mm/mmu_notifiers: prime lockdep") since the new annotations are
> > > > strictly more powerful.
> > > >
> > > > v2: Review from Thomas Hellstrom:
> > > > - unbotch the fs_reclaim context check, I accidentally inverted it,
> > > >   but it didn't blow up because I inverted it immediately
> > > > - fix compiling for !CONFIG_MMU_NOTIFIER
> > > >
> > > > Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-rdma@vger.kernel.org
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Christian König <christian.koenig@amd.com>
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > >
> > > Replying the right patch here...
> > >
> > > Reverting this commit [1] fixed the lockdep warning below while applying
> > > some memory pressure.
> > >
> > > [1] linux-next cbf7c9d86d75 ("mm: track mmu notifiers in fs_reclaim_acquire/release")
> > 
> > Hm, then I'm confused because
> > - there's not mmut notifier lockdep map in the splat at a..
> > - the patch is supposed to not change anything for fs_reclaim (but the
> > interim version got that wrong)
> > - looking at the paths it's kmalloc vs kswapd, both places I totally
> > expect fs_reflaim to be used.
> > 
> > But you're claiming reverting this prevents the lockdep splat. If
> > that's right, then my reasoning above is broken somewhere. Someone
> > less blind than me having an idea?
> > 
> > Aside this is the first email I've typed, until I realized the first
> > report was against the broken patch and that looked like a much more
> > reasonable explanation (but didn't quite match up with the code
> > paths).
> 
> Below diff should undo the functional change in my patch. Can you pls test
> whether the lockdep splat is really gone with that? Might need a lot of
> testing and memory pressure to be sure, since all these reclaim paths
> aren't very deterministic.

Well, I am running even heavy memory pressure workloads on linux-next
like every day, and never saw this splat until today where your patch
first show up.

Since I am rather busy tracking another regression, here is the steps to
reproduce (super easy to reproduce on multiple machines here.):

# git clone https://github.com/cailca/linux-mm.git
# cd linux-mm; make
# ./random 0

The .config is in there as well if ever matters.
