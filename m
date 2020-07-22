Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A70229540
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 11:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgGVJpp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgGVJpo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 05:45:44 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501DC0619DE
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 02:45:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k6so1301401oij.11
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qBIWLU6qcUqEJgyOOjaf3wwRh65k3CpshcWulpGbQ00=;
        b=b7v0J64ozdmomqKEQ6uZSIlGbo5wk3oIUkS7uMkxRWDmvOEEZpMeELjL9c+CVy85SC
         gUH8d0MgWe5mXyblHV6yLLD3z8ZPA2kyzVHVTvXOkMvI99kq8CnUvxAOcyjPRGeRVFV6
         SlCRuZRdDuXm35855wF3cSNHDHeVNvKd8d8FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qBIWLU6qcUqEJgyOOjaf3wwRh65k3CpshcWulpGbQ00=;
        b=DquQNmP6y6+pUirs4d3yCovkyXRYfbgVpdwHHDhXQnlHAYkSnLFjjc9X1mzEPwfA5O
         Vym9gHpNk2ZK2m6QcazGHOddA2LtKyrS1Y4Z+eD+cIFSGv5L5EpIChote3adikr/O6zp
         leLV51YVLbRlsH3TVcRrUzJO6LOLILotlmKkX4mgZBnG5zcrHC6GRF+24uxd54N4uIGV
         puumCDBiQUlCcYThE6QNAqZRjfmSUuHcBmMR+HKWNwNGGnNHxaeMSSXNuMXwki4+SICj
         2gNAAh7rNATUUHIV+G1lRDwOy7hrjtp0Z2hIN0CRwnM7reLfbzBZIuyyDcC2hkn8Sag0
         vc2w==
X-Gm-Message-State: AOAM53144Jr1gRvSsVDHiB+d83QUc4PNhkbzj8jDU0UUpALdT3+sf1/6
        gVM4sp1c1LVQHOFNwmMCD3kCpbJscHNaiL2PX6TE9Q==
X-Google-Smtp-Source: ABdhPJy1reMqVN9iXBAWZWyEiuKUCCqdgZLvt5/qG9Vsgmqwsqrfha82OrYO3x8LcEo6S/gxrnVxRoEeNL4w2jUzrW8=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr6055422oic.101.1595411143320;
 Wed, 22 Jul 2020 02:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org> <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
In-Reply-To: <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 22 Jul 2020 11:45:32 +0200
Message-ID: <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 10:05 AM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 2020-07-22 09:11, Daniel Vetter wrote:
> > On Wed, Jul 22, 2020 at 8:45 AM Thomas Hellstr=C3=B6m (Intel)
> > <thomas_os@shipmail.org> wrote:
> >>
> >> On 2020-07-22 00:45, Dave Airlie wrote:
> >>> On Tue, 21 Jul 2020 at 18:47, Thomas Hellstr=C3=B6m (Intel)
> >>> <thomas_os@shipmail.org> wrote:
> >>>> On 7/21/20 9:45 AM, Christian K=C3=B6nig wrote:
> >>>>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
> >>>>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellstr=C3=B6m (I=
ntel)
> >>>>>> wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
> >>>>>>>> Comes up every few years, gets somewhat tedious to discuss, let'=
s
> >>>>>>>> write this down once and for all.
> >>>>>>>>
> >>>>>>>> What I'm not sure about is whether the text should be more expli=
cit in
> >>>>>>>> flat out mandating the amdkfd eviction fences for long running c=
ompute
> >>>>>>>> workloads or workloads where userspace fencing is allowed.
> >>>>>>> Although (in my humble opinion) it might be possible to completel=
y
> >>>>>>> untangle
> >>>>>>> kernel-introduced fences for resource management and dma-fences u=
sed
> >>>>>>> for
> >>>>>>> completion- and dependency tracking and lift a lot of restriction=
s
> >>>>>>> for the
> >>>>>>> dma-fences, including prohibiting infinite ones, I think this mak=
es
> >>>>>>> sense
> >>>>>>> describing the current state.
> >>>>>> Yeah I think a future patch needs to type up how we want to make t=
hat
> >>>>>> happen (for some cross driver consistency) and what needs to be
> >>>>>> considered. Some of the necessary parts are already there (with li=
ke the
> >>>>>> preemption fences amdkfd has as an example), but I think some clea=
r docs
> >>>>>> on what's required from both hw, drivers and userspace would be re=
ally
> >>>>>> good.
> >>>>> I'm currently writing that up, but probably still need a few days f=
or
> >>>>> this.
> >>>> Great! I put down some (very) initial thoughts a couple of weeks ago
> >>>> building on eviction fences for various hardware complexity levels h=
ere:
> >>>>
> >>>> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling=
%20dma-fence%20and%20memory%20allocation.odt
> >>> We are seeing HW that has recoverable GPU page faults but only for
> >>> compute tasks, and scheduler without semaphores hw for graphics.
> >>>
> >>> So a single driver may have to expose both models to userspace and
> >>> also introduces the problem of how to interoperate between the two
> >>> models on one card.
> >>>
> >>> Dave.
> >> Hmm, yes to begin with it's important to note that this is not a
> >> replacement for new programming models or APIs, This is something that
> >> takes place internally in drivers to mitigate many of the restrictions
> >> that are currently imposed on dma-fence and documented in this and
> >> previous series. It's basically the driver-private narrow completions
> >> Jason suggested in the lockdep patches discussions implemented the sam=
e
> >> way as eviction-fences.
> >>
> >> The memory fence API would be local to helpers and middle-layers like
> >> TTM, and the corresponding drivers.  The only cross-driver-like
> >> visibility would be that the dma-buf move_notify() callback would not =
be
> >> allowed to wait on dma-fences or something that depends on a dma-fence=
.
> > Because we can't preempt (on some engines at least) we already have
> > the requirement that cross driver buffer management can get stuck on a
> > dma-fence. Not even taking into account the horrors we do with
> > userptr, which are cross driver no matter what. Limiting move_notify
> > to memory fences only doesn't work, since the pte clearing might need
> > to wait for a dma_fence first. Hence this becomes a full end-of-batch
> > fence, not just a limited kernel-internal memory fence.
>
> For non-preemptible hardware the memory fence typically *is* the
> end-of-batch fence. (Unless, as documented, there is a scheduler
> consuming sync-file dependencies in which case the memory fence wait
> needs to be able to break out of that). The key thing is not that we can
> break out of execution, but that we can break out of dependencies, since
> when we're executing all dependecies (modulo semaphores) are already
> fulfilled. That's what's eliminating the deadlocks.
>
> > That's kinda why I think only reasonable option is to toss in the
> > towel and declare dma-fence to be the memory fence (and suck up all
> > the consequences of that decision as uapi, which is kinda where we
> > are), and construct something new&entirely free-wheeling for userspace
> > fencing. But only for engines that allow enough preempt/gpu page
> > faulting to make that possible. Free wheeling userspace fences/gpu
> > semaphores or whatever you want to call them (on windows I think it's
> > monitored fence) only work if you can preempt to decouple the memory
> > fences from your gpu command execution.
> >
> > There's the in-between step of just decoupling the batchbuffer
> > submission prep for hw without any preempt (but a scheduler), but that
> > seems kinda pointless. Modern execbuf should be O(1) fastpath, with
> > all the allocation/mapping work pulled out ahead. vk exposes that
> > model directly to clients, GL drivers could use it internally too, so
> > I see zero value in spending lots of time engineering very tricky
> > kernel code just for old userspace. Much more reasonable to do that in
> > userspace, where we have real debuggers and no panics about security
> > bugs (or well, a lot less, webgl is still a thing, but at least
> > browsers realized you need to container that completely).
>
> Sure, it's definitely a big chunk of work. I think the big win would be
> allowing memory allocation in dma-fence critical sections. But I
> completely buy the above argument. I just wanted to point out that many
> of the dma-fence restrictions are IMHO fixable, should we need to do
> that for whatever reason.

I'm still not sure that's possible, without preemption at least. We
have 4 edges:
- Kernel has internal depencies among memory fences. We want that to
allow (mild) amounts of overcommit, since that simplifies live so
much.
- Memory fences can block gpu ctx execution (by nature of the memory
simply not being there yet due to our overcommit)
- gpu ctx have (if we allow this) userspace controlled semaphore
dependencies. Of course userspace is expected to not create deadlocks,
but that's only assuming the kernel doesn't inject additional
dependencies. Compute folks really want that.
- gpu ctx can hold up memory allocations if all we have is
end-of-batch fences. And end-of-batch fences are all we have without
preempt, plus if we want backwards compat with the entire current
winsys/compositor ecosystem we need them, which allows us to inject
stuff dependent upon them pretty much anywhere.

Fundamentally that's not fixable without throwing one of the edges
(and the corresponding feature that enables) out, since no entity has
full visibility into what's going on. E.g. forcing userspace to tell
the kernel about all semaphores just brings up back to the
drm_timeline_syncobj design we have merged right now. And that's imo
no better.

That's kinda why I'm not seeing much benefits in a half-way state:
Tons of work, and still not what userspace wants. And for the full
deal that userspace wants we might as well not change anything with
dma-fences. For that we need a) ctx preempt and b) new entirely
decoupled fences that never feed back into a memory fences and c) are
controlled entirely by userspace. And c) is the really important thing
people want us to provide.

And once we're ok with dma_fence =3D=3D memory fences, then enforcing the
strict and painful memory allocation limitations is actually what we
want.

Cheers, Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
