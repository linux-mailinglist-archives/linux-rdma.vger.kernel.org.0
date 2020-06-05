Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445EE1EF81F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2020 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgFEMls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Jun 2020 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgFEMlq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Jun 2020 08:41:46 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715A7C08C5C3
        for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2020 05:41:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 25so7153670oiy.13
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2020 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8lHa3VSsS3EH4GstrmtufuSPQnby9wIaLbKSXX2gR4=;
        b=Y0FSL3jop1Ktvp+81IKa884hHcJEOFCxyltl1k0MHEops3eSwWVVNdvKPpCE7Zx9WU
         //QeTiDmbXPc/dqdkmu7fHeWYxTzH103/85ltphoFY/gEm8OQl2oqXW4w61a7KN1Jhgb
         CSloh85q5YYyHCGG2UV5knxi5s6dBfhtE6irk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8lHa3VSsS3EH4GstrmtufuSPQnby9wIaLbKSXX2gR4=;
        b=MAYOzFMMKzC2scXJ7baLZEcnO4Q7/WLYw9EiiWWK81DkjwkBvGvMWJjRo2qICWi2xc
         Zon3zDW3D2SgSXMLWCHEcjuVmvA1LRz4Br88hZLJXnp2kgidO+YtkM0hrD83tYdnDQKL
         f1T9rA+jEKno7HYLIw0Qli5h2axr6Y5PYXnUug1IoNrzIg95y6w2vteUeF2CQ1EwnKnq
         TGwms/NprlmLwwcpVnXAhd3ZNrnayjawuoILDXXLtRshMPygf5UMJWIvwi+Duy2tbsfn
         4zjmhtrxjW8qZYJehjEu6IJDHPk0mQYv6VrenpbCRVvtflFKmir6r0HwO1na014KKzYL
         wtQA==
X-Gm-Message-State: AOAM53110440GNDYwWXf60ii2JkynW8+ieJj4bfa6wxyT9C7n4BeDb5P
        4ij9HrXL68fDEpRg/e3mESb3v7Rd/e3mVFYcHs/nTg==
X-Google-Smtp-Source: ABdhPJxDBFuxj/jT06KYKDwsSDsZtaJk7DJpn+CTYVJxr0/W+a1EfH/HPafid8DVkUdwYip+bwgoQY+h1NITtsGMh7k=
X-Received: by 2002:aca:ed42:: with SMTP id l63mr1645633oih.101.1591360905783;
 Fri, 05 Jun 2020 05:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-14-daniel.vetter@ffwll.ch> <e0bfd872-5d38-6718-a23d-6b14b3c14f25@amd.com>
In-Reply-To: <e0bfd872-5d38-6718-a23d-6b14b3c14f25@amd.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 5 Jun 2020 14:41:34 +0200
Message-ID: <CAKMK7uG6VN93ZS3Rbi6edvDAMefXJ6CotMx5j916VcUy2nuvqQ@mail.gmail.com>
Subject: Re: [PATCH 13/18] drm/amdgpu/dc: Stop dma_resv_lock inversion in commit_tail
To:     Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 5, 2020 at 10:30 AM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Hi Daniel,
>
> On 04/06/2020 10:12, Daniel Vetter wrote:
> [...]
> > @@ -6910,7 +6910,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> >                * explicitly on fences instead
> >                * and in general should be called for
> >                * blocking commit to as per framework helpers
> > +              *
> > +              * Yes, this deadlocks, since you're calling dma_resv_lock in a
> > +              * path that leads to a dma_fence_signal(). Don't do that.
> >                */
> > +#if 0
> >               r = amdgpu_bo_reserve(abo, true);
> >               if (unlikely(r != 0))
> >                       DRM_ERROR("failed to reserve buffer before flip\n");
> > @@ -6920,6 +6924,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> >               tmz_surface = amdgpu_bo_encrypted(abo);
> >
> >               amdgpu_bo_unreserve(abo);
> > +#endif
> > +             /*
> > +              * this races anyway, so READ_ONCE isn't any better or worse
> > +              * than the stuff above. Except the stuff above can deadlock.
> > +              */
> > +             tiling_flags = READ_ONCE(abo->tiling_flags);
>
> With this change "tmz_surface" won't be initialized properly.
> Adding the following line should fix it:
>
>   tmz_surface = READ_ONCE(abo->flags) & AMDGPU_GEM_CREATE_ENCRYPTED;

So to make this clear, I'm not really proposing to fix up all the
drivers in detail. There's a lot more bugs in all the other drivers,
I'm pretty sure. The driver fixups really are just quick hacks to
illustrate the problem, and at least in some cases, maybe illustrate a
possible solution.

For the real fixes I think this needs driver teams working on this,
and make sure it's all solid. I can help a bit with review (especially
for placing the annotations, e.g. the one I put in cs_submit()
annotates a bit too much), but that's it.

Also I think the patch is from before tmz landed, and I just blindly
rebased over it :-)
-Daniel

>
>
> Pierre-Eric
>
>
> >
> >               fill_dc_plane_info_and_addr(
> >                       dm->adev, new_plane_state, tiling_flags,
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
