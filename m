Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBFD22985D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgGVMlV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 08:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbgGVMlU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 08:41:20 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404FC0619DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 05:41:20 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z23so376713ood.8
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B11rgCuSDm7rnPHkRWLGEbsJlxAF07q2S6NQTx0WNfw=;
        b=C1vFjzIs2AoYRYK57+hiESajyin3bgDvGwzpnzMtPE2VAkZDiK1JIebXmiSUF8uTAo
         VpI29CowMk9xFKriSXLarKDimgtIgUlB/ZhsdDu/Jas03lMgTMaTm4KhqwlymAvpcx+5
         ri9/B3H7C+nmvZRL2AYh/u2pewbPBfBAwIB/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B11rgCuSDm7rnPHkRWLGEbsJlxAF07q2S6NQTx0WNfw=;
        b=ahK7c6oKvMVOHJQyBio8M/qeroXLBcpVpZEYgvH72qXFKlBNipCvMy6g/0Izi/inEq
         ifs2qLfyDZ9kjlWph+bY440k+T4/wJwMTmv1ELTlNu1wZOfrj07PvZw00AhJOZIaf6+w
         4D0vv4T+5zSu1IcQA2I7G2oHkDmpCLYwxFDMzLfDlJkOhUEZc9TL78LnIrZkyVonBT96
         /LcxwGRPSgiiH9PSyfEIHnznVyIH6G/UzxY1eyP4xLYQ0urVTk8Gf0tzlmfhDMAKnavl
         54eZD1tFcaTBLfnCkpOo74PZOeK/Z/e2Nke6LsVUlGMEMqopEHKoBjZpArCaWeUsinZM
         GuuQ==
X-Gm-Message-State: AOAM531Br5aGsEgsISC4iVVReE+cB2LJgi+zsZyQfcsyhxj0nc1DVs4G
        h4ysjGZQpjgP9X2/OpQ8qemURelXH4YsHzmiUrI7UQ==
X-Google-Smtp-Source: ABdhPJx2JzghYtV9KdIsB+yPthBwSQEv3sfpdhfwEQjwX7AU/3/MpwqI4eF7ui7WnUCc9IKDruULhRUK6NGVZUMKqS8=
X-Received: by 2002:a4a:bb8a:: with SMTP id h10mr27523930oop.28.1595421679594;
 Wed, 22 Jul 2020 05:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org> <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org> <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org> <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
 <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
In-Reply-To: <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 22 Jul 2020 14:41:08 +0200
Message-ID: <CAKMK7uF27SifuvMatuP2kJPTf+LVmVbG098cE2cqorYYo7UHkw@mail.gmail.com>
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

On Wed, Jul 22, 2020 at 2:22 PM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 2020-07-22 13:39, Daniel Vetter wrote:
> > On Wed, Jul 22, 2020 at 12:31 PM Thomas Hellstr=C3=B6m (Intel)
> > <thomas_os@shipmail.org> wrote:
> >>
> >> On 2020-07-22 11:45, Daniel Vetter wrote:
> >>> On Wed, Jul 22, 2020 at 10:05 AM Thomas Hellstr=C3=B6m (Intel)
> >>> <thomas_os@shipmail.org> wrote:
> >>>> On 2020-07-22 09:11, Daniel Vetter wrote:
> >>>>> On Wed, Jul 22, 2020 at 8:45 AM Thomas Hellstr=C3=B6m (Intel)
> >>>>> <thomas_os@shipmail.org> wrote:
> >>>>>> On 2020-07-22 00:45, Dave Airlie wrote:
> >>>>>>> On Tue, 21 Jul 2020 at 18:47, Thomas Hellstr=C3=B6m (Intel)
> >>>>>>> <thomas_os@shipmail.org> wrote:
> >>>>>>>> On 7/21/20 9:45 AM, Christian K=C3=B6nig wrote:
> >>>>>>>>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
> >>>>>>>>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellstr=C3=B6=
m (Intel)
> >>>>>>>>>> wrote:
> >>>>>>>>>>> Hi,
> >>>>>>>>>>>
> >>>>>>>>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
> >>>>>>>>>>>> Comes up every few years, gets somewhat tedious to discuss, =
let's
> >>>>>>>>>>>> write this down once and for all.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What I'm not sure about is whether the text should be more e=
xplicit in
> >>>>>>>>>>>> flat out mandating the amdkfd eviction fences for long runni=
ng compute
> >>>>>>>>>>>> workloads or workloads where userspace fencing is allowed.
> >>>>>>>>>>> Although (in my humble opinion) it might be possible to compl=
etely
> >>>>>>>>>>> untangle
> >>>>>>>>>>> kernel-introduced fences for resource management and dma-fenc=
es used
> >>>>>>>>>>> for
> >>>>>>>>>>> completion- and dependency tracking and lift a lot of restric=
tions
> >>>>>>>>>>> for the
> >>>>>>>>>>> dma-fences, including prohibiting infinite ones, I think this=
 makes
> >>>>>>>>>>> sense
> >>>>>>>>>>> describing the current state.
> >>>>>>>>>> Yeah I think a future patch needs to type up how we want to ma=
ke that
> >>>>>>>>>> happen (for some cross driver consistency) and what needs to b=
e
> >>>>>>>>>> considered. Some of the necessary parts are already there (wit=
h like the
> >>>>>>>>>> preemption fences amdkfd has as an example), but I think some =
clear docs
> >>>>>>>>>> on what's required from both hw, drivers and userspace would b=
e really
> >>>>>>>>>> good.
> >>>>>>>>> I'm currently writing that up, but probably still need a few da=
ys for
> >>>>>>>>> this.
> >>>>>>>> Great! I put down some (very) initial thoughts a couple of weeks=
 ago
> >>>>>>>> building on eviction fences for various hardware complexity leve=
ls here:
> >>>>>>>>
> >>>>>>>> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untang=
ling%20dma-fence%20and%20memory%20allocation.odt
> >>>>>>> We are seeing HW that has recoverable GPU page faults but only fo=
r
> >>>>>>> compute tasks, and scheduler without semaphores hw for graphics.
> >>>>>>>
> >>>>>>> So a single driver may have to expose both models to userspace an=
d
> >>>>>>> also introduces the problem of how to interoperate between the tw=
o
> >>>>>>> models on one card.
> >>>>>>>
> >>>>>>> Dave.
> >>>>>> Hmm, yes to begin with it's important to note that this is not a
> >>>>>> replacement for new programming models or APIs, This is something =
that
> >>>>>> takes place internally in drivers to mitigate many of the restrict=
ions
> >>>>>> that are currently imposed on dma-fence and documented in this and
> >>>>>> previous series. It's basically the driver-private narrow completi=
ons
> >>>>>> Jason suggested in the lockdep patches discussions implemented the=
 same
> >>>>>> way as eviction-fences.
> >>>>>>
> >>>>>> The memory fence API would be local to helpers and middle-layers l=
ike
> >>>>>> TTM, and the corresponding drivers.  The only cross-driver-like
> >>>>>> visibility would be that the dma-buf move_notify() callback would =
not be
> >>>>>> allowed to wait on dma-fences or something that depends on a dma-f=
ence.
> >>>>> Because we can't preempt (on some engines at least) we already have
> >>>>> the requirement that cross driver buffer management can get stuck o=
n a
> >>>>> dma-fence. Not even taking into account the horrors we do with
> >>>>> userptr, which are cross driver no matter what. Limiting move_notif=
y
> >>>>> to memory fences only doesn't work, since the pte clearing might ne=
ed
> >>>>> to wait for a dma_fence first. Hence this becomes a full end-of-bat=
ch
> >>>>> fence, not just a limited kernel-internal memory fence.
> >>>> For non-preemptible hardware the memory fence typically *is* the
> >>>> end-of-batch fence. (Unless, as documented, there is a scheduler
> >>>> consuming sync-file dependencies in which case the memory fence wait
> >>>> needs to be able to break out of that). The key thing is not that we=
 can
> >>>> break out of execution, but that we can break out of dependencies, s=
ince
> >>>> when we're executing all dependecies (modulo semaphores) are already
> >>>> fulfilled. That's what's eliminating the deadlocks.
> >>>>
> >>>>> That's kinda why I think only reasonable option is to toss in the
> >>>>> towel and declare dma-fence to be the memory fence (and suck up all
> >>>>> the consequences of that decision as uapi, which is kinda where we
> >>>>> are), and construct something new&entirely free-wheeling for usersp=
ace
> >>>>> fencing. But only for engines that allow enough preempt/gpu page
> >>>>> faulting to make that possible. Free wheeling userspace fences/gpu
> >>>>> semaphores or whatever you want to call them (on windows I think it=
's
> >>>>> monitored fence) only work if you can preempt to decouple the memor=
y
> >>>>> fences from your gpu command execution.
> >>>>>
> >>>>> There's the in-between step of just decoupling the batchbuffer
> >>>>> submission prep for hw without any preempt (but a scheduler), but t=
hat
> >>>>> seems kinda pointless. Modern execbuf should be O(1) fastpath, with
> >>>>> all the allocation/mapping work pulled out ahead. vk exposes that
> >>>>> model directly to clients, GL drivers could use it internally too, =
so
> >>>>> I see zero value in spending lots of time engineering very tricky
> >>>>> kernel code just for old userspace. Much more reasonable to do that=
 in
> >>>>> userspace, where we have real debuggers and no panics about securit=
y
> >>>>> bugs (or well, a lot less, webgl is still a thing, but at least
> >>>>> browsers realized you need to container that completely).
> >>>> Sure, it's definitely a big chunk of work. I think the big win would=
 be
> >>>> allowing memory allocation in dma-fence critical sections. But I
> >>>> completely buy the above argument. I just wanted to point out that m=
any
> >>>> of the dma-fence restrictions are IMHO fixable, should we need to do
> >>>> that for whatever reason.
> >>> I'm still not sure that's possible, without preemption at least. We
> >>> have 4 edges:
> >>> - Kernel has internal depencies among memory fences. We want that to
> >>> allow (mild) amounts of overcommit, since that simplifies live so
> >>> much.
> >>> - Memory fences can block gpu ctx execution (by nature of the memory
> >>> simply not being there yet due to our overcommit)
> >>> - gpu ctx have (if we allow this) userspace controlled semaphore
> >>> dependencies. Of course userspace is expected to not create deadlocks=
,
> >>> but that's only assuming the kernel doesn't inject additional
> >>> dependencies. Compute folks really want that.
> >>> - gpu ctx can hold up memory allocations if all we have is
> >>> end-of-batch fences. And end-of-batch fences are all we have without
> >>> preempt, plus if we want backwards compat with the entire current
> >>> winsys/compositor ecosystem we need them, which allows us to inject
> >>> stuff dependent upon them pretty much anywhere.
> >>>
> >>> Fundamentally that's not fixable without throwing one of the edges
> >>> (and the corresponding feature that enables) out, since no entity has
> >>> full visibility into what's going on. E.g. forcing userspace to tell
> >>> the kernel about all semaphores just brings up back to the
> >>> drm_timeline_syncobj design we have merged right now. And that's imo
> >>> no better.
> >> Indeed, HW waiting for semaphores without being able to preempt that
> >> wait is a no-go. The doc (perhaps naively) assumes nobody is doing tha=
t.
> > preempt is a necessary but not sufficient condition, you also must not
> > have end-of-batch memory fences. And i915 has semaphore support and
> > end-of-batch memory fences, e.g. one piece is:
> >
> > commit c4e8ba7390346a77ffe33ec3f210bc62e0b6c8c6
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Tue Apr 7 14:08:11 2020 +0100
> >
> >      drm/i915/gt: Yield the timeslice if caught waiting on a user semap=
hore
> >
> > Sure it preempts, but that's not enough.
>
> Yes, i915 would fall in the "hardware with semaphores" category and
> implement memory fences different from the end-of-batch fences.
>
> >
> >>> That's kinda why I'm not seeing much benefits in a half-way state:
> >>> Tons of work, and still not what userspace wants. And for the full
> >>> deal that userspace wants we might as well not change anything with
> >>> dma-fences. For that we need a) ctx preempt and b) new entirely
> >>> decoupled fences that never feed back into a memory fences and c) are
> >>> controlled entirely by userspace. And c) is the really important thin=
g
> >>> people want us to provide.
> >>>
> >>> And once we're ok with dma_fence =3D=3D memory fences, then enforcing=
 the
> >>> strict and painful memory allocation limitations is actually what we
> >>> want.
> >> Let's hope you're right. My fear is that that might be pretty painful =
as
> >> well.
> > Oh it's very painful too:
> > - We need a separate uapi flavour for gpu ctx with preempt instead of
> > end-of-batch dma-fence.
> > - Which needs to be implemented without breaking stuff badly - e.g. we
> > need to make sure we don't probe-wait on fences unnecessarily since
> > that forces random unwanted preempts.
> > - If we want this with winsys integration we need full userspace
> > revisions since all the dma_fence based sync sharing is out (implicit
> > sync on dma-buf, sync_file, drm_syncobj are all defunct since we can
> > only go the other way round).
> > Utter pain, but I think it's better since it can be done
> > driver-by-driver, and even userspace usecase by usecase. Which means
> > we can experiment in areas where the 10+ years of uapi guarantee isn't
> > so painful, learn, until we do the big jump of new
> > zero-interaction-with-memory-management fences become baked in forever
> > into compositor/winsys/modeset protocols.
> >   With the other approach of
> > splitting dma-fence we need to do all the splitting first, make sure
> > we get it right, and only then can we enable the use-case for real.
>
> Again, let me stress, I'm not advocating for splitting the dma-fence in
> favour of the preempt ctx approach. My question is rather: Do we see the
> need for fixing dma-fence as well, with the motivation that fixing all
> drivers to adhere to the dma-fence restrictions might be just as
> painful. So far the clear answer is no, it's not worth it, and I'm fine
> with that.

Ah I think I misunderstood which options you want to compare here. I'm
not sure how much pain fixing up "dma-fence as memory fence" really
is. That's kinda why I want a lot more testing on my annotation
patches, to figure that out. Not much feedback aside from amdgpu and
intel, and those two drivers pretty much need to sort out their memory
fence issues anyway (because of userptr and stuff like that).

The only other issues outside of these two drivers I'm aware of:
- various scheduler drivers doing allocations in the drm/scheduler
critical section. Since all arm-soc drivers have a mildly shoddy
memory model of "we just pin everything" they don't really have to
deal with this. So we might just declare arm as a platform broken and
not taint the dma-fence critical sections with fs_reclaim. Otoh we
need to fix this for drm/scheduler anyway, I think best option would
be to have a mempool for hw fences in the scheduler itself, and at
that point fixing the other drivers shouldn't be too onerous.

- vmwgfx doing a dma_resv in the atomic commit tail. Entirely
orthogonal to the entire memory fence discussion.

I'm pretty sure there's more bugs, I just haven't heard from them yet.
Also due to the opt-in nature of dma-fence we can limit the scope of
what we fix fairly naturally, just don't put them where no one cares
:-) Of course that also hides general locking issues in dma_fence
signalling code, but well *shrug*.

So thus far I think fixing up the various small bugs the annotations
turn up is the least problem we have here. Much, much smaller then
either of "split dma-fence in two" or "add entire new fence
model/uapi/winsys protocol set on top of dma-fence". I think a big
reason we didn't screw up a lot worse on this is the atomic framework,
which was designed very much with a) no allocations in the wrong spot
and b) no lock taking in the wrong spot in mind from the start. Some
of the early atomic prototypes were real horrors in that regards, but
with the helper framework we have now drivers have to go the extra
mile to screw this up. And there's a lot more atomic drivers than
render drivers nowadays merged in upstream.

> > That's just not going to happen, at least not in upstream across all
> > drivers. Within a single driver in some vendor tree hacking stuff up
> > is totally fine ofc.
>
> Actually, due to the asynchronous restart, that's not really possible
> either. It's all or none.
>
> > -Daniel
>
> /Thomas
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
