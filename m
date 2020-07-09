Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC4219A38
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGIHwV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIHwV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 03:52:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDFC061A0B
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2020 00:52:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so1288140wrp.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jul 2020 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vXgT6RRirIs9vOBxNCexqhs644sbUqmDyiATQNLIZbg=;
        b=Icl1ZFwM/BdAnsf8QEusvKajGxL6WtxrEVa6WVdvI0tXEJu+yGu+Tl1+T+Lq9+Ltfx
         di7HE1NfD4T165TQhEz0gJRB8zahiuPoX1NT8Y3az+zqO2iQBJbIilY17qjFmJymrNXu
         Qv5/nR4nRnQ9Ht2scGKvCZAsXkwg4z4Ch2M5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vXgT6RRirIs9vOBxNCexqhs644sbUqmDyiATQNLIZbg=;
        b=cNqbl7C5WbLd+8MeUo9NhL/tCGiAqN88Z7NufZ1tvw45B119oRTM69ALEaBKe+jWC8
         kfruuI/mGBJKBwmKAfxsXWOq2t7/CrLLDpqtg9/e07r+BEIsNrDLCKkC9F6EmbudjGJy
         ebqLr4tp1h1gPZ0Tep6Twa06z4PWnWD820x0wIbMiaxrNGqh/4CmUD8W+xgyle1pDavF
         /PFAUH/mFME+zAM6TUf+jnqoloZSTEZql4qES/+YhptUoHxAnsjG40s4rnTKhaZq8MI5
         GlnntBz6PF8JK92NpLb56PWz+rS2kif2SXtQtrzHXoSJf57/l8baQm8m74sukzWUONEh
         oBuA==
X-Gm-Message-State: AOAM532QKxcc1K5lKmFEcYNYi10yWI6p+kVRe1OTSkETQ6AJ1yN2P48l
        2or3/+69q6wwQB+cPNsZB976dw==
X-Google-Smtp-Source: ABdhPJzMhhfOQP1SZlv1tfEvaf51xgSXmeFIfxfR93qhGPvCNOG/Wm/4jNQxGEgUdKBWYOlZaCggsw==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr59080956wrw.190.1594281139547;
        Thu, 09 Jul 2020 00:52:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f16sm3433990wmf.17.2020.07.09.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 00:52:18 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:52:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
Subject: Re: [Intel-gfx] [PATCH 01/25] dma-fence: basic lockdep annotations
Message-ID: <20200709075216.GM3278063@phenom.ffwll.local>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-2-daniel.vetter@ffwll.ch>
 <20c0a95b-8367-4f26-d058-1cb265255283@amd.com>
 <CAKMK7uFe7Pz4=UUkkunBms8vUrzwEpWJmScOMLO4KdADM43vnw@mail.gmail.com>
 <CAPj87rNXneE+Vry4aSV11=Qv2mbUsFjCLmNzRmx-Oeqj=u9dyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rNXneE+Vry4aSV11=Qv2mbUsFjCLmNzRmx-Oeqj=u9dyw@mail.gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 09, 2020 at 08:32:41AM +0100, Daniel Stone wrote:
> Hi,
> 
> On Wed, 8 Jul 2020 at 16:13, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > On Wed, Jul 8, 2020 at 4:57 PM Christian König <christian.koenig@amd.com> wrote:
> > > Could we merge this controlled by a separate config option?
> > >
> > > This way we could have the checks upstream without having to fix all the
> > > stuff before we do this?
> >
> > Since it's fully opt-in annotations nothing blows up if we don't merge
> > any annotations. So we could start merging the first 3 patches. After
> > that the fun starts ...
> >
> > My rough idea was that first I'd try to tackle display, thus far
> > there's 2 actual issues in drivers:
> > - amdgpu has some dma_resv_lock in commit_tail, plus a kmalloc. I
> > think those should be fairly easy to fix (I'd try a stab at them even)
> > - vmwgfx has a full on locking inversion with dma_resv_lock in
> > commit_tail, and that one is functional. Not just reading something
> > which we can safely assume to be invariant anyway (like the tmz flag
> > for amdgpu, or whatever it was).
> >
> > I've done a pile more annotations patches for other atomic drivers
> > now, so hopefully that flushes out any remaining offenders here. Since
> > some of the annotations are in helper code worst case we might need a
> > dev->mode_config.broken_atomic_commit flag to disable them. At least
> > for now I have 0 plans to merge any of these while there's known
> > unsolved issues. Maybe if some drivers take forever to get fixed we
> > can then apply some duct-tape for the atomic helper annotation patch.
> > Instead of a flag we can also copypasta the atomic_commit_tail hook,
> > leaving the annotations out and adding a huge warning about that.
> 
> How about an opt-in drm_driver DRIVER_DEADLOCK_HAPPY flag? At first
> this could just disable the annotations and nothing else, but as we
> see the annotations gaining real-world testing and maturity, we could
> eventually make it taint the kernel.

You can do that pretty much per-driver, since the annotations are pretty
much per-driver. No annotations in your code, no lockdep splat. Only if
there's some dma_fence_begin/end_signalling() calls is there even the
chance of a problem.

E.g. this round has the i915 patch dropped and *traraaaa* intel-gfx-ci is
happy (or well at least a lot happier, there's some noise in there that's
probably not from my stuff).

So I guess if amd wants this, we could do an DRM_AMDGPU_MOAR_LOCKDEP
Kconfig or similar. I haven't tested, but I think as long as we don't
merge any of the amdgpu specific patches, there's no splat in amdgpu. So
with that I think that's plenty enough opt-in for each driver. The only
problem is a bit shared helper code like atomic helpers and drm scheduler.
There we might need some opt-out (I don't think merging makes sense when
most of the users are still broken).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
