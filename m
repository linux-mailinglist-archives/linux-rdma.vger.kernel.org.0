Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04BF227B9F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 11:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGUJYc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 05:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJYc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 05:24:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B87C061794
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 02:24:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so14555713otw.10
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 02:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nquXkdQRYOPtoNI/3pjve4BmhzPYso4IxoVNtZc0VME=;
        b=CjocwH1W7nFMYJlFZJt0tm40L0soTBLF2A1OyB8G88wf51ZiFhqG/CutsmKeZ5Tdmn
         Y5Pra1EDDvtZhDbFNA40Deym9NI9pzjBkrIByHZc4nyCatLi/P96S+39Zw9EyC+sMvmu
         rkq8EcEXbJqZEJMu9S+hwNyEDe9BYYwCY1240=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nquXkdQRYOPtoNI/3pjve4BmhzPYso4IxoVNtZc0VME=;
        b=JwuBX9FaCzEQqj2InjLoCTqkoEsmV6O5hsi+Yhz7kSqxCVC+AXcGCdSw2km+n5C2V8
         YnRUoCz+rHCunMy6tOpF/iFhvXl5GA+64QwCtRuk2xhjE+Mk5E8afRcafsA3IUmB36QL
         FueQ4h9BAes7A6LsFY1ZwhKToA88YvXjIjYZnFs9scNPwBKMq5zYY2h90V6iSxzXVyjU
         6v7LiHksaAX8q0x6i9l+hmBGJOgiv8eaGC+hjvE0V8B/mBbolRHlt9hvoiquQ94c9IDL
         BVPRrwPKEY3vRgHLGy0zvy/zJZ78sHYaWS/UpX6SK4PAj6IacxUXQltz+MCGUQzBhLma
         g4aw==
X-Gm-Message-State: AOAM533p4h4MA3Ffdcdfo9118iGLAYpB0/m78BaSU9nP+gjpGzZkCCeP
        eLsuy+yUPTaV3HfNL62H9+34lJKaG1aIhZHHn3tTVg==
X-Google-Smtp-Source: ABdhPJwWzQp8+gEl+OMQCIoHdSTE3WuDzqd0vQntTpza9P5RjwTtbLNRcl1/BieXye7/bW+4dhAaba2R8DiOHrzunIU=
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr25072001ota.188.1595323471609;
 Tue, 21 Jul 2020 02:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
 <CAKMK7uHcWMGnLqmNqoyYmk_UcErEZwRon-ybc9t-Joa+bHacaQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHcWMGnLqmNqoyYmk_UcErEZwRon-ybc9t-Joa+bHacaQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 21 Jul 2020 11:24:20 +0200
Message-ID: <CAKMK7uF6L1vZR9VxTdvN80xQ3Qn6jBnGV5QQCBUrNOwrWPjruw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
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

On Tue, Jul 21, 2020 at 11:16 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Jul 21, 2020 at 10:55 AM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 21.07.20 um 10:47 schrieb Thomas Hellstr=C3=B6m (Intel):
> > >
> > > On 7/21/20 9:45 AM, Christian K=C3=B6nig wrote:
> > >> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
> > >>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellstr=C3=B6m (In=
tel)
> > >>> wrote:
> > >>>> Hi,
> > >>>>
> > >>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
> > >>>>> Comes up every few years, gets somewhat tedious to discuss, let's
> > >>>>> write this down once and for all.
> > >>>>>
> > >>>>> What I'm not sure about is whether the text should be more
> > >>>>> explicit in
> > >>>>> flat out mandating the amdkfd eviction fences for long running
> > >>>>> compute
> > >>>>> workloads or workloads where userspace fencing is allowed.
> > >>>> Although (in my humble opinion) it might be possible to completely
> > >>>> untangle
> > >>>> kernel-introduced fences for resource management and dma-fences
> > >>>> used for
> > >>>> completion- and dependency tracking and lift a lot of restrictions
> > >>>> for the
> > >>>> dma-fences, including prohibiting infinite ones, I think this make=
s
> > >>>> sense
> > >>>> describing the current state.
> > >>> Yeah I think a future patch needs to type up how we want to make th=
at
> > >>> happen (for some cross driver consistency) and what needs to be
> > >>> considered. Some of the necessary parts are already there (with lik=
e
> > >>> the
> > >>> preemption fences amdkfd has as an example), but I think some clear
> > >>> docs
> > >>> on what's required from both hw, drivers and userspace would be rea=
lly
> > >>> good.
> > >>
> > >> I'm currently writing that up, but probably still need a few days fo=
r
> > >> this.
> > >
> > > Great! I put down some (very) initial thoughts a couple of weeks ago
> > > building on eviction fences for various hardware complexity levels he=
re:
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
itlab.freedesktop.org%2Fthomash%2Fdocs%2F-%2Fblob%2Fmaster%2FUntangling%252=
0dma-fence%2520and%2520memory%2520allocation.odt&amp;data=3D02%7C01%7Cchris=
tian.koenig%40amd.com%7C8978bbd7823e4b41663708d82d52add3%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637309180424312390&amp;sdata=3DtTxx2vfzfwLM1IBJS=
qqAZRw1604R%2F0bI3MwN1%2FBf2VQ%3D&amp;reserved=3D0
> > >
> >
> > I don't think that this will ever be possible.
> >
> > See that Daniel describes in his text is that indefinite fences are a
> > bad idea for memory management, and I think that this is a fixed fact.
> >
> > In other words the whole concept of submitting work to the kernel which
> > depends on some user space interaction doesn't work and never will.
> >
> > What can be done is that dma_fences work with hardware schedulers. E.g.
> > what the KFD tries to do with its preemption fences.
> >
> > But for this you need a better concept and description of what the
> > hardware scheduler is supposed to do and how that interacts with
> > dma_fence objects.
>
> Yeah I think trying to split dma_fence wont work, simply because of
> inertia. Creating an entirely new thing for augmented userspace
> controlled fencing, and then jotting down all the rules the
> kernel/hw/userspace need to obey to not break dma_fence is what I had
> in mind. And I guess that's also what Christian is working on. E.g.
> just going through all the cases of how much your hw can preempt or
> handle page faults on the gpu, and what that means in terms of
> dma_fence_begin/end_signalling and other constraints would be really
> good.

Or rephrased in terms of Thomas' doc: dma-fence will stay the memory
fence, and also the sync fence for current userspace and winsys.

Then we create a new thing and complete protocol and driver reving of
the entire world. The really hard part is that running old stuff on a
new stack is possible (we'd be totally screwed otherwise, since it
would become a system wide flag day). But running new stuff on an old
stack (even if it's just something in userspace like the compositor)
doesn't work, because then you tie the new synchronization fences back
into the dma-fence memory fences, and game over.

So yeah around 5 years or so for anything that wants to use a winsys,
or at least that's what it usually takes us to do something like this
:-/ Entirely stand-alone compute workloads (irrespective whether it's
cuda, cl, vk or whatever) doesn't have that problem ofc.
-Daniel

> -Daniel
>
> >
> > Christian.
> >
> > >
> > > /Thomas
> > >
> > >
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
