Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10231FC65C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQGtC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgFQGtC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 02:49:02 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C851C061573
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 23:49:02 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x202so829657oix.11
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2020 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5ZhuFAutHEAeCHrC5mjvXu1Iq0NUc7YMfX/IRu3ZyA=;
        b=OIOD71wghmL3BJ+4LTxzheuNdBbWNpLdKTVng8Cfhv9Fc+rfz1Bmpja7NkfffcXZ5t
         F6agC8t3Bl3XSNz2wvhQVeG89txiQ4Fg0oTmf4NqMRP+P7i0aE2AqATgmZ8aSvLna89q
         jo8UfjgpSF4gK32/sAugm1Q4Ddzgv8tjJWzGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5ZhuFAutHEAeCHrC5mjvXu1Iq0NUc7YMfX/IRu3ZyA=;
        b=XcK4uj/SidHpts41OPIK0eZQoNjbS068B5HfOSNDTvPYcLAvkbpQyXiZAuNwxkkwc3
         ZVyycmR7UcwYI+7b+OENOwsbpviBpibzSkudwtpyilLBA83cnTRDVX79dP6MCg2XHczg
         Yv2YDSy1xcxXgaiWEX2nfFawKZx3ey5XlPgovAaDtwRw6TLvXxx6nMHIPDbkyYZCP6kX
         0d8y2rgHjMRHMNo8lWS4yPaSPQ0FXDGflH8WhukPZKfJoCK4pI/Djl6hZK9OiEKvNwB2
         f+g7je2zwoaSkZ5kN1Jwc1ArksP+xH8XcGWna57S4C0xZIzEd9XFyyjRaMrAUPwt9Zln
         +3nA==
X-Gm-Message-State: AOAM530/AgPwUMOEN94IF9TADVpZF4nDA8mQ6QQpDywoZC9uAy3gSfMM
        w/1vMFF+e6JJ/LRjSLFDSf7NvHHhO+DwP/5NRY64yg==
X-Google-Smtp-Source: ABdhPJwGAcimp20dQiWfb4LYQbPcyitWuj+om1jev4TmvwlxEdnrUo68m+2HSkZsaPumvrGpeUMSVFkd4tAKg9ZB6PA=
X-Received: by 2002:aca:ad97:: with SMTP id w145mr6315470oie.128.1592376541438;
 Tue, 16 Jun 2020 23:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch> <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local> <20200611141515.GW6578@ziepe.ca> <20200616120719.GL20149@phenom.ffwll.local>
In-Reply-To: <20200616120719.GL20149@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 17 Jun 2020 08:48:50 +0200
Message-ID: <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 2:07 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Hi Jason,
>
> Somehow this got stuck somewhere in the mail queues, only popped up just
> now ...
>
> On Thu, Jun 11, 2020 at 11:15:15AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 11, 2020 at 10:34:30AM +0200, Daniel Vetter wrote:
> > > > I still have my doubts about allowing fence waiting from within shrinkers.
> > > > IMO ideally they should use a trywait approach, in order to allow memory
> > > > allocation during command submission for drivers that
> > > > publish fences before command submission. (Since early reservation object
> > > > release requires that).
> > >
> > > Yeah it is a bit annoying, e.g. for drm/scheduler I think we'll end up
> > > with a mempool to make sure it can handle it's allocations.
> > >
> > > > But since drivers are already waiting from within shrinkers and I take your
> > > > word for HMM requiring this,
> > >
> > > Yeah the big trouble is HMM and mmu notifiers. That's the really awkward
> > > one, the shrinker one is a lot less established.
> >
> > I really question if HW that needs something like DMA fence should
> > even be using mmu notifiers - the best use is HW that can fence the
> > DMA directly without having to get involved with some command stream
> > processing.
> >
> > Or at the very least it should not be a generic DMA fence but a
> > narrowed completion tied only into the same GPU driver's command
> > completion processing which should be able to progress without
> > blocking.
>
> The problem with gpus is that these completions leak across the board like
> mad. Both internally within memory managers (made a lot worse with p2p
> direct access to vram), and through uapi.
>
> Many gpus still have a very hard time preempting, so doing an overall
> switch in drivers/gpu to a memory management model where that is required
> is not a very realistic option.  And minimally you need either preempt
> (still takes a while, but a lot faster generally than waiting for work to
> complete) or hw faults (just a bunch of tlb flushes plus virtual indexed
> caches, so just the caveat of that for a gpu, which has lots and big tlbs
> and caches). So preventing the completion leaks within the kernel is I
> think unrealistic, except if we just say "well sorry, run on windows,
> mkay" for many gpu workloads. Or more realistic "well sorry, run on the
> nvidia blob with nvidia hw".
>
> The userspace side we can somewhat isolate, at least for pure compute
> workloads. But the thing is drivers/gpu is a continum from tiny socs
> (where dma_fence is a very nice model) to huge compute stuff (where it's
> maybe not the nicest, but hey hw sucks so still neeeded). Doing full on
> break in uapi somewhere in there is at least a bit awkward, e.g. some of
> the media codec code on intel runs all the way from the smallest intel soc
> to the big transcode servers.
>
> So the current status quo is "total mess, every driver defines their own
> rules". All I'm trying to do is some common rules here, do make this mess
> slightly more manageable and overall reviewable and testable.
>
> I have no illusions that this is fundamentally pretty horrible, and the
> leftover wiggle room for writing memory manager is barely more than a
> hairline. Just not seeing how other options are better.

So bad news is that gpu's are horrible, but I think if you don't have
to review gpu drivers it's substantially better. If you do have hw
with full device page fault support, then there's no need to ever
install a dma_fence. Punching out device ptes and flushing caches is
all that's needed. That is also the plan we have, for the workloads
and devices where that's possible.

Now my understanding for rdma is that if you don't have hw page fault
support, then the only other object is to more or less permanently pin
the memory. So again, dma_fence are completely useless, since it's
entirely up to userspace when a given piece of registered memory isn't
needed anymore, and the entire problem boils down to how much do we
allow random userspace to just pin (system or device) memory. Or at
least I don't really see any other solution.

On the other end we have simpler devices like video input/output.
Those always need pinned memory, but through hw design it's limited in
how much you can pin (generally max resolution times a limited set of
buffers to cycle through). Just including that memory pinning
allowance as part of device access makes sense.

It's only gpus (I think) which are in this awkward in-between spot
where dynamic memory management really is much wanted, but the hw
kinda sucks. Aside, about 10+ years ago we had a similar problem with
gpu hw, but for security: Many gpu didn't have any kinds of page
tables to isolate different clients from each another. drivers/gpu
fixed this by parsing&validating what userspace submitted to make sure
it's only every accessing its own buffers. Most gpus have become
reasonable nowadays and do have proper per-process pagetables (gpu
process, not the pasid stuff), but even today there's still some of
the old model left in some of the smallest SoC.

tldr; of all this: gpus kinda suck sometimes, but  that's also not news :-/

Cheers, Daniel

> > The intent of notifiers was never to endlessly block while vast
> > amounts of SW does work.
> >
> > Going around and switching everything in a GPU to GFP_ATOMIC seems
> > like bad idea.
>
> It's not everyone, or at least not everywhere, it's some fairly limited
> cases. Also, even if we drop the mmu_notifier on the floor, then we're
> stuck with shrinkers and GFP_NOFS. Still need a mempool of some sorts to
> guarantee you get out of a bind, so not much better.
>
> At least that's my current understanding of where we are across all
> drivers.
>
> > > I've pinged a bunch of armsoc gpu driver people and ask them how much this
> > > hurts, so that we have a clear answer. On x86 I don't think we have much
> > > of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> > > (but nouveau I think doesn't use dma_fence in there).
> >
> > Right, nor will RDMA ODP.
>
> Hm, what's the context here? I thought RDMA side you really don't want
> dma_fence in mmu_notifiers, so not clear to me what you're agreeing on
> here.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
