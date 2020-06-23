Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61506205B63
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbgFWTCk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733218AbgFWTCj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 15:02:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D7C061755
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 12:02:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so21657051wrr.10
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XDcsteRMJEoW0C3+Kl+uWDnjv0MhfNk7S9Vrs1qi/2Y=;
        b=F8OUcVjuokEibmMSbToMoIBILFma7edYFwClorq7HqZPPZAsjl5aBIXM5rjHh2K4Lq
         dd+qeCoDkPHmPlGyVv6Z/wtdPrCUcn/gJSdfHe4BRGJdop50ca7laeXsmvDPZAFsD45G
         DpFfjBVLJGiCLnCx7MoPvm6Wpk0WJAYz4Suvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=XDcsteRMJEoW0C3+Kl+uWDnjv0MhfNk7S9Vrs1qi/2Y=;
        b=Wx1DgUJDuJLSoW+PDdZ8KpfQXmodjmvnkktvSR9gYQlIblJSYFSLF9xFf0lLN+djbB
         0+IVEwT68pPzlqIULNXeMusPnzvTyeL+kys8oLLrH28IXQ1yHIoWXFOT6ZTybMuO3PfB
         ISaw17WlfNUFOoMeeWhMbnxLLKfZgTT9aU46G6i5/DAaSY71Mj2GlrNr8EZU6bAcP0KZ
         +VbfPvirqZJTbK2IwcNUo9SWRcpHTXiG7n6SIfYUZFyct9T15LfKtgs9msdTf08OO7Xh
         VGPPgJtDH7W9bF0ztacnYe57agiNdlzytQx91MVXopP5nkQ8c7XqKTjdTDHzoPK/YhmZ
         znXQ==
X-Gm-Message-State: AOAM533Vz0Y3htvHpdDYoMekESQaA7vHsFSEntahIUwqN+tZL+1Plex0
        yHKEMgF/H0+C0y7sSfn7+2eJpw==
X-Google-Smtp-Source: ABdhPJynbn/cTBvNbobb+7TOV12TXtahoSjCWh3GnuIRy64vKHvTHEysZa+/3Plm+28KWqKEN1sWIw==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr18155209wrq.101.1592938956979;
        Tue, 23 Jun 2020 12:02:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l17sm4698578wmi.3.2020.06.23.12.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:02:35 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:02:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200623190233.GP20149@phenom.ffwll.local>
Mail-Followup-To: Felix Kuehling <felix.kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local>
 <20200611141515.GW6578@ziepe.ca>
 <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
 <CAKMK7uHBKrpDWu+DvtYncDK=LOdGJyMK7t6fpOaGovnYFiBUZw@mail.gmail.com>
 <99758c09-262a-e9a1-bf65-5702b35b4388@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99758c09-262a-e9a1-bf65-5702b35b4388@amd.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 02:44:24PM -0400, Felix Kuehling wrote:
> Am 2020-06-23 um 3:39 a.m. schrieb Daniel Vetter:
> > On Fri, Jun 12, 2020 at 1:35 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
> >> Am 2020-06-11 um 10:15 a.m. schrieb Jason Gunthorpe:
> >>> On Thu, Jun 11, 2020 at 10:34:30AM +0200, Daniel Vetter wrote:
> >>>>> I still have my doubts about allowing fence waiting from within shrinkers.
> >>>>> IMO ideally they should use a trywait approach, in order to allow memory
> >>>>> allocation during command submission for drivers that
> >>>>> publish fences before command submission. (Since early reservation object
> >>>>> release requires that).
> >>>> Yeah it is a bit annoying, e.g. for drm/scheduler I think we'll end up
> >>>> with a mempool to make sure it can handle it's allocations.
> >>>>
> >>>>> But since drivers are already waiting from within shrinkers and I take your
> >>>>> word for HMM requiring this,
> >>>> Yeah the big trouble is HMM and mmu notifiers. That's the really awkward
> >>>> one, the shrinker one is a lot less established.
> >>> I really question if HW that needs something like DMA fence should
> >>> even be using mmu notifiers - the best use is HW that can fence the
> >>> DMA directly without having to get involved with some command stream
> >>> processing.
> >>>
> >>> Or at the very least it should not be a generic DMA fence but a
> >>> narrowed completion tied only into the same GPU driver's command
> >>> completion processing which should be able to progress without
> >>> blocking.
> >>>
> >>> The intent of notifiers was never to endlessly block while vast
> >>> amounts of SW does work.
> >>>
> >>> Going around and switching everything in a GPU to GFP_ATOMIC seems
> >>> like bad idea.
> >>>
> >>>> I've pinged a bunch of armsoc gpu driver people and ask them how much this
> >>>> hurts, so that we have a clear answer. On x86 I don't think we have much
> >>>> of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> >>>> (but nouveau I think doesn't use dma_fence in there).
> >> Soon nouveau will get company. We're working on a recoverable page fault
> >> implementation for HMM in amdgpu where we'll need to update page tables
> >> using the GPUs SDMA engine and wait for corresponding fences in MMU
> >> notifiers.
> > Can you pls cc these patches to dri-devel when they show up? Depending
> > upon how your hw works there's and endless amount of bad things that
> > can happen.
> 
> Yes, I'll do that.
> 
> 
> >
> > Also I think (again depending upon how the hw exactly works) this
> > stuff would be a perfect example for the dma_fence annotations.
> 
> We have already applied your patch series to our development branch. I
> haven't looked into what annotations we'd have to add to our new code yet.
> 
> 
> >
> > The worst case is if your hw cannot preempt while a hw page fault is
> > pending. That means none of the dma_fence will ever signal (the amdkfd
> > preempt ctx fences wont, and the classic fences from amdgpu might be
> > also stall). At least when you're unlucky and the fence you're waiting
> > on somehow (anywhere in its dependency chain really) need the engine
> > that's currently blocked waiting for the hw page fault.
> 
> Our HW can preempt while handling a page fault, at least on the GPU
> generation we're working on now. On other GPUs we haven't included in
> our initial effort, we will not be able to preempt while a page fault is
> in progress. This is problematic, but that's for reasons related to our
> GPU hardware scheduler and unrelated to fences.

Well the trouble is if the page fault holds up a preempt, then there's no
way for a dma_fence to complete while your hw page fault handler is stuck
doing whatever. That means the entire hw page fault becomes a fence
signalling critical section, with the consequence that there's almost
nothing you can actually do. System memory becomes GFP_ATOMIC only, and
for vram you need to make sure that you never evict anything that might be
in active use.

So not enabling these platforms sounds like a very good plan to me :-)

> > That in turn means anything you do in your hw page fault handler is in
> > the critical section for dma fence signalling, which has far reaching
> > implications.
> 
> I'm not sure I agree, at least for KFD. The only place where KFD uses
> fences that depend on preemptions is eviction fences. And we can get rid
> of those if we can preempt GPU access to specific BOs by invalidating
> GPU PTEs. That way we don't need to preempt the GPU queues while a page
> fault is in progress. Instead we would create more page faults.

The big problem isn't pure kfd workloads, all the trouble comes in when
you mix kfd and amdgpu workloads. kfd alone is easy, just make sure
there's no fences to begin with, and there will be no problems.

> That assumes that we can invalidate GPU PTEs without depending on
> fences. We've discussed possible deadlocks due to memory allocations
> needed on that code paths for IBs or page tables. We've already
> eliminated page table allocations and reservation locks on the PTE
> invalidation code path. And we're using a separate scheduler entity so
> we can't get stuck behind other IBs that depend on fences. IIRC,
> Christian also implemented a separate memory pool for IBs for this code
> path.

Yeah it's the memory allocations that kill you. Both system memory, but
also vram. Since evicting vram might mean you end up stuck behind a
dma_fence of a legacy context hogging that memory, and probably also means
doing a few dma_resv_lock. All of these thing deadlock if you can't
preempt the context with something else.
-Daniel


> 
> Regards,
>   Felix
> 
> 
> > -Daniel
> >
> >> Regards,
> >>   Felix
> >>
> >>
> >>> Right, nor will RDMA ODP.
> >>>
> >>> Jason
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
