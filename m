Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE062228816
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGUSTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGUSTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 14:19:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A538C061794
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 11:19:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so15771647otf.7
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a22hQK6cJeMfHLvNiRw93Ty044K5y0nmFYyuDYDGOcI=;
        b=RRts8Pwr5UcXXv3Bw+O9xoHnODEWp1V/p9FlxiDtRAKNg+HxEHVHcKsKyJoEilJYdv
         q+rn4deBX9ggDziultofcYH0vtI7iUhGC1o2Sm09VJbb27z0uOKkDOVyZvjfaO7uPWWn
         7hh7xMU+JE9uzVYgLmFx+C9um8P94b6VFznq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a22hQK6cJeMfHLvNiRw93Ty044K5y0nmFYyuDYDGOcI=;
        b=VpyHMJjoWho3O6Zr7ZVI/ifqinGwax99gKEa5YfBdoflx1MvAmrzPphdDK78LsaVyw
         9XjTBeVTzeYsmVmVUct5SDSXhRrEQ7ZSczTGVNH+bJXJp8qQFcnlvmUUbWhyDCEaLDsM
         79aeYPnPRySOZno9Q/VfAjdRjrrbGi/Oc7LmPnRWDpxS18dWwXmhLt+g9uwutE6AWOA0
         EYuzo8CMCJ/wqsvQOfAUt22uIzQQFMEk8PmS9pGAI6RffRc/vKCEliF9JiaUOqYFHPdw
         5ROXu9qWMZ6kn5PMG/hS+59uBPZl3stDTNOJF9riY8wB6TTDV+f6nRnJBD/N28mnHNWa
         P/iQ==
X-Gm-Message-State: AOAM533XtB9nN5JSh6u8XTg3wsiOaLNiR8Naw54IxiE2voFNWqM94mPC
        gmvlqvMHnWRVYmh88uh/D7hSWiGp4bj1VdQjjZwW0A==
X-Google-Smtp-Source: ABdhPJxcmcdY93XzSZSgT29lbh/+9cL9bNlOYjhUUtCZpNsuNRauZwGL7jeysaYtumdQH4HCtzK6O992FnCwdZ8uYq0=
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr27028455ota.188.1595355548728;
 Tue, 21 Jul 2020 11:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
 <74727f17-b3a5-ca12-6db6-e47543797b72@shipmail.org> <CAKMK7uFfMi5M5EkCeG6=tjuDANH4=gDLnFpxCYU-E-xyrxwYUg@mail.gmail.com>
 <ae4e4188-39e6-ec41-c11d-91e9211b4d3a@shipmail.org> <f8f73b9f-ce8d-ea02-7caa-d50b75b72809@amd.com>
 <6ed364c9-893b-8974-501a-418585eb4def@shipmail.org>
In-Reply-To: <6ed364c9-893b-8974-501a-418585eb4def@shipmail.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 21 Jul 2020 20:18:57 +0200
Message-ID: <CAKMK7uF9kFD+=2_6LJ1Wa2UNUAhAAjs5MNz7dmTfe-4_EFYjWA@mail.gmail.com>
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

On Tue, Jul 21, 2020 at 7:46 PM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 2020-07-21 15:59, Christian K=C3=B6nig wrote:
> > Am 21.07.20 um 12:47 schrieb Thomas Hellstr=C3=B6m (Intel):
> ...
> >> Yes, we can't do magic. As soon as an indefinite batch makes it to
> >> such hardware we've lost. But since we can break out while the batch
> >> is stuck in the scheduler waiting, what I believe we *can* do with
> >> this approach is to avoid deadlocks due to locally unknown
> >> dependencies, which has some bearing on this documentation patch, and
> >> also to allow memory allocation in dma-fence (not memory-fence)
> >> critical sections, like gpu fault- and error handlers without
> >> resorting to using memory pools.
> >
> > Avoiding deadlocks is only the tip of the iceberg here.
> >
> > When you allow the kernel to depend on user space to proceed with some
> > operation there are a lot more things which need consideration.
> >
> > E.g. what happens when an userspace process which has submitted stuff
> > to the kernel is killed? Are the prepared commands send to the
> > hardware or aborted as well? What do we do with other processes
> > waiting for that stuff?
> >
> > How to we do resource accounting? When processes need to block when
> > submitting to the hardware stuff which is not ready we have a process
> > we can punish for blocking resources. But how is kernel memory used
> > for a submission accounted? How do we avoid deny of service attacks
> > here were somebody eats up all memory by doing submissions which can't
> > finish?
> >
> Hmm. Are these problems really unique to user-space controlled
> dependencies? Couldn't you hit the same or similar problems with
> mis-behaving shaders blocking timeline progress?

We just kill them, which we can because stuff needs to complete in a
timely fashion, and without any further intervention - all
prerequisite dependencies must be and are known by the kernel.

But with the long/endless running compute stuff with userspace sync
point and everything free-wheeling, including stuff like "hey I'll
submit this patch but the memory isn't even all allocated yet, so I'm
just going to hang it on this semaphore until that's done" is entirely
different. There just shooting the batch kills the programming model,
and abitrarily holding up a batch for another one to first get its
memory also breaks it, because userspace might have issued them with
dependencies in the other order.

So with that execution model you don't run batches, but just an entire
context. Up to userspace what it does with that, and like with cpu
threads just running a busy loop doing nothing is perfectly legit
(from the kernel pov's at least) workload. Nothing in the kernel ever
waits on such a context to do anything, if the kernel needs something
you just preempt (or if it's memory and you have gpu page fault
handling, rip out the page). Accounting is all done on a specific gpu
context too. And probably we need a somewhat consistent approach on
how we handle these gpu context things (definitely needed for cgroups
and all that).
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
