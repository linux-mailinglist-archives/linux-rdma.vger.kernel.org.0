Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F9204B5F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 09:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgFWHja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 03:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731217AbgFWHj3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 03:39:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CAC061796
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 00:39:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n6so15665773otl.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+92MYnF3Gh08MmStig+tCn2Q/L2yjmneEHZzzW7GGvs=;
        b=PwrvE5jS1kTu+fi0Cr9QUPwDbx3xz+X3B7OgQDwGyTKoe9mBLoNsF4PcRQZYhzKOnV
         CkL4lja+OqOY0gBbJB+pER0fYFWMEmKIpSKjbJhfHshefh7JCoDF0Ko4gDHaNPu08gpL
         UTuHeptkXd8ej8TjPFULXiSQ/JHJc7+5RujUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+92MYnF3Gh08MmStig+tCn2Q/L2yjmneEHZzzW7GGvs=;
        b=t8netreShc+8PYUoeQl3fDjTb7a2bPanHeZ5vZe3ooXPuMTu44ovGiynMONTm46xE2
         41hehsTHWxugZ2d/grWRMbL9jDnNrm2ofu8B+T3dXvDfMetNDOn1Fa2PVVQJ8ukb5EU7
         aI0kR594Pykii5L/C5awSk8//cRTsdK/S55Pen+E6zHBrFusgBdKs5nL6JLRB6f6OufN
         8LqlWv848AILE8/wOsLd0snrbfz1a3MA3bxCcARtVRAEi3rXLmJu1v0Q2peB3VJoe0tx
         1z9/yknzlyXN9htthnZ9bFQx6NshgesMrblB3SxXKTdhDe/C/I4otkIHsqLIq58S9pUc
         xzfg==
X-Gm-Message-State: AOAM532ONF+iMyk7Ju2W0a5GhsNQNb3+UiRtxCdJUha9I3wgQWxYKadX
        U7KGSkikvjoFluxTVIJL4LM+mvN74gDezDT8sNCdXw==
X-Google-Smtp-Source: ABdhPJyuTPn8gHto3Zj0qvtBWFEZww/Nxosv6E4e67PZOhsc7GOGHkoFk1BcCVm2dLP+f9GAnXbuSF6PpstaZHEQELA=
X-Received: by 2002:a4a:d415:: with SMTP id n21mr17485719oos.89.1592897968519;
 Tue, 23 Jun 2020 00:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch> <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local> <20200611141515.GW6578@ziepe.ca> <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
In-Reply-To: <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Jun 2020 09:39:17 +0200
Message-ID: <CAKMK7uHBKrpDWu+DvtYncDK=LOdGJyMK7t6fpOaGovnYFiBUZw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
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

On Fri, Jun 12, 2020 at 1:35 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> Am 2020-06-11 um 10:15 a.m. schrieb Jason Gunthorpe:
> > On Thu, Jun 11, 2020 at 10:34:30AM +0200, Daniel Vetter wrote:
> >>> I still have my doubts about allowing fence waiting from within shrinkers.
> >>> IMO ideally they should use a trywait approach, in order to allow memory
> >>> allocation during command submission for drivers that
> >>> publish fences before command submission. (Since early reservation object
> >>> release requires that).
> >> Yeah it is a bit annoying, e.g. for drm/scheduler I think we'll end up
> >> with a mempool to make sure it can handle it's allocations.
> >>
> >>> But since drivers are already waiting from within shrinkers and I take your
> >>> word for HMM requiring this,
> >> Yeah the big trouble is HMM and mmu notifiers. That's the really awkward
> >> one, the shrinker one is a lot less established.
> > I really question if HW that needs something like DMA fence should
> > even be using mmu notifiers - the best use is HW that can fence the
> > DMA directly without having to get involved with some command stream
> > processing.
> >
> > Or at the very least it should not be a generic DMA fence but a
> > narrowed completion tied only into the same GPU driver's command
> > completion processing which should be able to progress without
> > blocking.
> >
> > The intent of notifiers was never to endlessly block while vast
> > amounts of SW does work.
> >
> > Going around and switching everything in a GPU to GFP_ATOMIC seems
> > like bad idea.
> >
> >> I've pinged a bunch of armsoc gpu driver people and ask them how much this
> >> hurts, so that we have a clear answer. On x86 I don't think we have much
> >> of a choice on this, with userptr in amd and i915 and hmm work in nouveau
> >> (but nouveau I think doesn't use dma_fence in there).
>
> Soon nouveau will get company. We're working on a recoverable page fault
> implementation for HMM in amdgpu where we'll need to update page tables
> using the GPUs SDMA engine and wait for corresponding fences in MMU
> notifiers.

Can you pls cc these patches to dri-devel when they show up? Depending
upon how your hw works there's and endless amount of bad things that
can happen.

Also I think (again depending upon how the hw exactly works) this
stuff would be a perfect example for the dma_fence annotations.

The worst case is if your hw cannot preempt while a hw page fault is
pending. That means none of the dma_fence will ever signal (the amdkfd
preempt ctx fences wont, and the classic fences from amdgpu might be
also stall). At least when you're unlucky and the fence you're waiting
on somehow (anywhere in its dependency chain really) need the engine
that's currently blocked waiting for the hw page fault.

That in turn means anything you do in your hw page fault handler is in
the critical section for dma fence signalling, which has far reaching
implications.
-Daniel

>
> Regards,
>   Felix
>
>
> > Right, nor will RDMA ODP.
> >
> > Jason
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
