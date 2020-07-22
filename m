Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A82291C9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgGVHMH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 03:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgGVHMG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 03:12:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A50C0619DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 00:12:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k22so1036317oib.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JwkeYyBomvbYnFOaLpEKlvJ8DzuwKSpH8FekeAKJGLk=;
        b=SkJhztXGGkVSi+CMtPZ9mnNyIZWb3W+Hi8+3aiJVas3tDxC/kBOhWX+3nnbfTpWlDa
         9UwfYCUVg3UUFxW3a9F7GY0tSXLJgK74FxaZAlm/QwZzPlIEgPRh/x41/ptVhbOLyUY4
         gUYP4TSQcKLUYmmU2jU3ByYY0yTbp47s9NoiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JwkeYyBomvbYnFOaLpEKlvJ8DzuwKSpH8FekeAKJGLk=;
        b=TlWWvEjTqJMy5t/IEQGpGMTA21AKYj9yhX8n8iuLYGoJa/epAMnpOnGGFi2on4mLdt
         ucPJZqWKDZAHUwYs8cnFW4lDhhIJbLrHhrRw7i5ehnDLrp/W+HH7PImd6gMihLROCZ8K
         6A/NZUGc/O3TRnNcTf9q/acdNte2sCme2q/iwSOMvm86iWsQI34Lkg4dNjMLOsTDeaZ7
         1N58EHjMoAyHPSxpNOCU600UYkIIHy/Oa9s0SHDTY3EqShFWiYFidygbFd/uvV+HQJ7o
         qhI5LlCDu22Yi+I5pufIuxyXrdvr8AL0k7HmrJc8N+W2tisQwClBSKnbJypwNaeDCpIh
         629g==
X-Gm-Message-State: AOAM531aVdaIKLuwNGLCi92RXKzWAwwq4kuRC8vD17OX5mQFbbCirZuC
        /ReQ3fyf+EaVs97oNl2Hv+YquoX9JzC+15IavPyvvQ==
X-Google-Smtp-Source: ABdhPJw79eBtwBgNaIl2ZcTK/cPqRyZb7BtTpgm+YE8+ssCbvckOKoeqxVWT4IlUKWv7BYthNQjzDv0cdeiPNmWCvMQ=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr5710875oic.101.1595401926052;
 Wed, 22 Jul 2020 00:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
In-Reply-To: <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 22 Jul 2020 09:11:55 +0200
Message-ID: <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
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

On Wed, Jul 22, 2020 at 8:45 AM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
>
>
> On 2020-07-22 00:45, Dave Airlie wrote:
> > On Tue, 21 Jul 2020 at 18:47, Thomas Hellstr=C3=B6m (Intel)
> > <thomas_os@shipmail.org> wrote:
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
> >>>>>> What I'm not sure about is whether the text should be more explici=
t in
> >>>>>> flat out mandating the amdkfd eviction fences for long running com=
pute
> >>>>>> workloads or workloads where userspace fencing is allowed.
> >>>>> Although (in my humble opinion) it might be possible to completely
> >>>>> untangle
> >>>>> kernel-introduced fences for resource management and dma-fences use=
d
> >>>>> for
> >>>>> completion- and dependency tracking and lift a lot of restrictions
> >>>>> for the
> >>>>> dma-fences, including prohibiting infinite ones, I think this makes
> >>>>> sense
> >>>>> describing the current state.
> >>>> Yeah I think a future patch needs to type up how we want to make tha=
t
> >>>> happen (for some cross driver consistency) and what needs to be
> >>>> considered. Some of the necessary parts are already there (with like=
 the
> >>>> preemption fences amdkfd has as an example), but I think some clear =
docs
> >>>> on what's required from both hw, drivers and userspace would be real=
ly
> >>>> good.
> >>> I'm currently writing that up, but probably still need a few days for
> >>> this.
> >> Great! I put down some (very) initial thoughts a couple of weeks ago
> >> building on eviction fences for various hardware complexity levels her=
e:
> >>
> >> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling%2=
0dma-fence%20and%20memory%20allocation.odt
> > We are seeing HW that has recoverable GPU page faults but only for
> > compute tasks, and scheduler without semaphores hw for graphics.
> >
> > So a single driver may have to expose both models to userspace and
> > also introduces the problem of how to interoperate between the two
> > models on one card.
> >
> > Dave.
>
> Hmm, yes to begin with it's important to note that this is not a
> replacement for new programming models or APIs, This is something that
> takes place internally in drivers to mitigate many of the restrictions
> that are currently imposed on dma-fence and documented in this and
> previous series. It's basically the driver-private narrow completions
> Jason suggested in the lockdep patches discussions implemented the same
> way as eviction-fences.
>
> The memory fence API would be local to helpers and middle-layers like
> TTM, and the corresponding drivers.  The only cross-driver-like
> visibility would be that the dma-buf move_notify() callback would not be
> allowed to wait on dma-fences or something that depends on a dma-fence.

Because we can't preempt (on some engines at least) we already have
the requirement that cross driver buffer management can get stuck on a
dma-fence. Not even taking into account the horrors we do with
userptr, which are cross driver no matter what. Limiting move_notify
to memory fences only doesn't work, since the pte clearing might need
to wait for a dma_fence first. Hence this becomes a full end-of-batch
fence, not just a limited kernel-internal memory fence.

That's kinda why I think only reasonable option is to toss in the
towel and declare dma-fence to be the memory fence (and suck up all
the consequences of that decision as uapi, which is kinda where we
are), and construct something new&entirely free-wheeling for userspace
fencing. But only for engines that allow enough preempt/gpu page
faulting to make that possible. Free wheeling userspace fences/gpu
semaphores or whatever you want to call them (on windows I think it's
monitored fence) only work if you can preempt to decouple the memory
fences from your gpu command execution.

There's the in-between step of just decoupling the batchbuffer
submission prep for hw without any preempt (but a scheduler), but that
seems kinda pointless. Modern execbuf should be O(1) fastpath, with
all the allocation/mapping work pulled out ahead. vk exposes that
model directly to clients, GL drivers could use it internally too, so
I see zero value in spending lots of time engineering very tricky
kernel code just for old userspace. Much more reasonable to do that in
userspace, where we have real debuggers and no panics about security
bugs (or well, a lot less, webgl is still a thing, but at least
browsers realized you need to container that completely).

Cheers, Daniel

> So with that in mind, I don't foresee engines with different
> capabilities on the same card being a problem.
>
> /Thomas
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
