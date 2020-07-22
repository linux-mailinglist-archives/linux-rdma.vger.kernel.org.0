Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879702299C8
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGVOHw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbgGVOHv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 10:07:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72850C0619DE
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 07:07:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t4so1952666oij.9
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAHV/rpaUbGt0q99VF6bHWxElygJ/Z2JZXz353VfAMQ=;
        b=SITU1kgFHOpxrGfAvN/xsy6y/SqUaSONdNDH3tOAGvk0gA4uhHJweALhI0Dxw7n0Y/
         w0T54rjK6YJq44cbIqPDTyG7Y3ioXKYTGAPQ+Af2WyK7pWiq7s4i7JHD2KwgwimcxbZb
         ra+ouxUIDC6ClGXL8ZIqULwe0ZZzNG8n+cYmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAHV/rpaUbGt0q99VF6bHWxElygJ/Z2JZXz353VfAMQ=;
        b=QbNjXb9xCMCSut0Z7OGkv8vBhVPoyWl0KJx3s/cFApm5vGV6BPVoePclsUOdOVw9pY
         Sx/wIWBcpKnrtmLMOGP/CqKI+s67I5QtqMRDY6xKaijFnvEZxn24nZN5sKARa+th/enz
         cLG38WfYoluLP/c/yUYJVia4I1xDURKFXrNVbhCm3aT/gShhoYynOAaZnw56UTSXi4xM
         9DVkcL2vwPVurjpQu3lamaSyeoBgPLfFRjjjGYB0sXNcpa1nvhvnN3beTuS4wQj3eFAb
         OTdN9xweb/RQO0mx8R+D0aPvgllJbsFR6js/UOQRdpPMdwlstinxZt3mvuhGx1FoTztm
         INOg==
X-Gm-Message-State: AOAM531K50hYHd6IYLKfaHXKN/lXwqLhX4099blq0bQurUnF3ectgDrB
        k4K/wUNCN6+bBt4iH//lZ8ob5MCMMXhJJNEni4EqdA==
X-Google-Smtp-Source: ABdhPJxsmP01VwUh+xqO5FIOiyXHA61FZ3yhIgmjFOUSqLR+0KcXAPEhRCCAl08pk9WqF5Dcre5YesNtfI3JuxHSNWo=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr7273449oig.128.1595426870693;
 Wed, 22 Jul 2020 07:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch> <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local> <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org> <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org> <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org> <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org> <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
 <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org> <CAKMK7uF27SifuvMatuP2kJPTf+LVmVbG098cE2cqorYYo7UHkw@mail.gmail.com>
 <697d1b5e-5d1c-1655-23f8-7a3f652606f3@shipmail.org>
In-Reply-To: <697d1b5e-5d1c-1655-23f8-7a3f652606f3@shipmail.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 22 Jul 2020 16:07:39 +0200
Message-ID: <CAKMK7uGSkgdJyyvGe8SF_vWfgyaCWn5p0GvZZdLvkxmrS6tYbQ@mail.gmail.com>
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

On Wed, Jul 22, 2020 at 3:12 PM Thomas Hellstr=C3=B6m (Intel)
<thomas_os@shipmail.org> wrote:
> On 2020-07-22 14:41, Daniel Vetter wrote:
> > Ah I think I misunderstood which options you want to compare here. I'm
> > not sure how much pain fixing up "dma-fence as memory fence" really
> > is. That's kinda why I want a lot more testing on my annotation
> > patches, to figure that out. Not much feedback aside from amdgpu and
> > intel, and those two drivers pretty much need to sort out their memory
> > fence issues anyway (because of userptr and stuff like that).
> >
> > The only other issues outside of these two drivers I'm aware of:
> > - various scheduler drivers doing allocations in the drm/scheduler
> > critical section. Since all arm-soc drivers have a mildly shoddy
> > memory model of "we just pin everything" they don't really have to
> > deal with this. So we might just declare arm as a platform broken and
> > not taint the dma-fence critical sections with fs_reclaim. Otoh we
> > need to fix this for drm/scheduler anyway, I think best option would
> > be to have a mempool for hw fences in the scheduler itself, and at
> > that point fixing the other drivers shouldn't be too onerous.
> >
> > - vmwgfx doing a dma_resv in the atomic commit tail. Entirely
> > orthogonal to the entire memory fence discussion.
>
> With vmwgfx there is another issue that is hit when the gpu signals an
> error. At that point the batch might be restarted with a new meta
> command buffer that needs to be allocated out of a dma pool. in the
> fence critical section. That's probably a bit nasty to fix, but not
> impossible.

Yeah reset is fun. From what I've seen this isn't any worse than the
hw allocation issue for drm/scheduler drivers, they just allocate
another hw fence with all that drags along. So the same mempool should
be sufficient.

The really nasty thing around reset is display interactions, because
you just can't take drm_modeset_lock. amdgpu fixed that now (at least
the modeset_lock side, not yet the memory allocations that brings
along). i915 has the same problem for gen2/3 (so really old stuff),
and we've solved that by breaking&restarting all i915 fence waits, but
that predates multi-gpu and wont work for shared fences ofc. But it's
so old and predates all multi-gpu laptops that I think wontfix is the
right take.

Other drm/scheduler drivers don't have that problem since they're all
render-only, so no display driver interaction.

> > I'm pretty sure there's more bugs, I just haven't heard from them yet.
> > Also due to the opt-in nature of dma-fence we can limit the scope of
> > what we fix fairly naturally, just don't put them where no one cares
> > :-) Of course that also hides general locking issues in dma_fence
> > signalling code, but well *shrug*.
> Hmm, yes. Another potential big problem would be drivers that want to
> use gpu page faults in the dma-fence critical sections with the
> batch-based programming model.

Yeah that's a massive can of worms. But luckily there's no such driver
merged in upstream, so hopefully we can think about all the
constraints and how to best annotate&enforce this before we land any
code and have big regrets.
-Daniel



--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
