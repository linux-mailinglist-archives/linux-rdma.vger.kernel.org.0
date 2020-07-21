Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54965227C19
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGUJuu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGUJut (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 05:50:49 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7EC061794
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 02:50:49 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z127so3810346ooa.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Mxwe8+/2sAl5aV7lSivEyRgzWsOGsAmcnpV4ySF6Ks=;
        b=Vbv8Xzl+vP1jTrX4oYxiAQUq3baNzA3kvZo8juXKiWI936pBlM7UD9ehHYU8sQT/Hy
         4guaqZae/3o9/Kn7QMqL0MsT9d0YWJtCCjdLzzkoQD3lDd3N95c/N9K1/ArLqu5nHj6X
         h8Jom6d8XDQwOSM0tY9t3bYMJ6hYTvysZ67BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Mxwe8+/2sAl5aV7lSivEyRgzWsOGsAmcnpV4ySF6Ks=;
        b=Bj1mYg0ABNIFqPsmXFtt+BrJ4kb8r/jurWP5Y0WwWkmoSQDhZARzFkxP/7fW1IORGW
         T+5TGcHLFrrFOAMmVCBeYv3JXPgeItrXVO9PTql52PRyToE5nOUxWLkWyJirv/Xv/qGw
         2p6b5bi7QoF4MYmS+RK+2y0h7LVGaNkSO23wftDNpHSYor0GCne7Xvdl0QTDuj8h2J2r
         dADbcXnA0tyO9Kvh4/g5ZvSHoUtwo7Sqz7DHrgmjqZ8j241B1zK40oQMvPuYBFOW9bPd
         xXuJC9xWWBBR56sCqY0v+76mk1ymwOGswuJrYDtLPkXj2Bc00d91xe9eKzuvMspAG71c
         w0Kg==
X-Gm-Message-State: AOAM530Jxw6ZXyXauN+vJfJgcOA0Iz5ptVHNfvXh23eYCqIVIKzLZLpO
        EkhlbEYzj/FEM36AX5R6Wd1MLYCGaan9hgQnjj+mYQ==
X-Google-Smtp-Source: ABdhPJwI3gJQ0NtOaqhq9TtKHG92T7bavDoHOsV389jg+GbUKhN9jTjMRfRhnq5aQBSDS1D+4bTxdMPUI50KzrE96fM=
X-Received: by 2002:a4a:b6c5:: with SMTP id w5mr2677127ooo.89.1595325048653;
 Tue, 21 Jul 2020 02:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
 <74727f17-b3a5-ca12-6db6-e47543797b72@shipmail.org>
In-Reply-To: <74727f17-b3a5-ca12-6db6-e47543797b72@shipmail.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 21 Jul 2020 11:50:37 +0200
Message-ID: <CAKMK7uFfMi5M5EkCeG6=tjuDANH4=gDLnFpxCYU-E-xyrxwYUg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 21, 2020 at 11:38 AM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 7/21/20 10:55 AM, Christian K=C3=B6nig wrote:
> > Am 21.07.20 um 10:47 schrieb Thomas Hellstr=C3=B6m (Intel):
> >>
> >> On 7/21/20 9:45 AM, Christian K=C3=B6nig wrote:
> >>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
> >>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellstr=C3=B6m (Int=
el)
> >>>> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
> >>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
> >>>>>> write this down once and for all.
> >>>>>>
> >>>>>> What I'm not sure about is whether the text should be more
> >>>>>> explicit in
> >>>>>> flat out mandating the amdkfd eviction fences for long running
> >>>>>> compute
> >>>>>> workloads or workloads where userspace fencing is allowed.
> >>>>> Although (in my humble opinion) it might be possible to completely
> >>>>> untangle
> >>>>> kernel-introduced fences for resource management and dma-fences
> >>>>> used for
> >>>>> completion- and dependency tracking and lift a lot of restrictions
> >>>>> for the
> >>>>> dma-fences, including prohibiting infinite ones, I think this
> >>>>> makes sense
> >>>>> describing the current state.
> >>>> Yeah I think a future patch needs to type up how we want to make tha=
t
> >>>> happen (for some cross driver consistency) and what needs to be
> >>>> considered. Some of the necessary parts are already there (with
> >>>> like the
> >>>> preemption fences amdkfd has as an example), but I think some clear
> >>>> docs
> >>>> on what's required from both hw, drivers and userspace would be real=
ly
> >>>> good.
> >>>
> >>> I'm currently writing that up, but probably still need a few days
> >>> for this.
> >>
> >> Great! I put down some (very) initial thoughts a couple of weeks ago
> >> building on eviction fences for various hardware complexity levels her=
e:
> >>
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fthomash%2Fdocs%2F-%2Fblob%2Fmaster%2FUntangling%2520=
dma-fence%2520and%2520memory%2520allocation.odt&amp;data=3D02%7C01%7Cchrist=
ian.koenig%40amd.com%7C8978bbd7823e4b41663708d82d52add3%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637309180424312390&amp;sdata=3DtTxx2vfzfwLM1IBJSq=
qAZRw1604R%2F0bI3MwN1%2FBf2VQ%3D&amp;reserved=3D0
> >>
> >
> > I don't think that this will ever be possible.
> >
> > See that Daniel describes in his text is that indefinite fences are a
> > bad idea for memory management, and I think that this is a fixed fact.
> >
> > In other words the whole concept of submitting work to the kernel
> > which depends on some user space interaction doesn't work and never wil=
l.
>
> Well the idea here is that memory management will *never* depend on
> indefinite fences: As soon as someone waits on a memory manager fence
> (be it eviction, shrinker or mmu notifier) it breaks out of any
> dma-fence dependencies and /or user-space interaction. The text tries to
> describe what's required to be able to do that (save for non-preemptible
> gpus where someone submits a forever-running shader).

Yeah I think that part of your text is good to describe how to
untangle memory fences from synchronization fences given how much the
hw can do.

> So while I think this is possible (until someone comes up with a case
> where it wouldn't work of course), I guess Daniel has a point in that it
> won't happen because of inertia and there might be better options.

Yeah it's just I don't see much chance for splitting dma-fence itself.
That's also why I'm not positive on the "no hw preemption, only
scheduler" case: You still have a dma_fence for the batch itself,
which means still no userspace controlled synchronization or other
form of indefinite batches allowed. So not getting us any closer to
enabling the compute use cases people want. So minimally I think hw
needs to be able to preempt, and preempt fairly quickly (i.e. within
shaders if you have long running shaders as your use-case), or support
gpu page faults. And depending how it all works different parts of the
driver code end up in dma fence critical sections, with different
restrictions.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
