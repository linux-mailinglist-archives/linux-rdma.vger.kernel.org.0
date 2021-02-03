Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917E530E180
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBCRyN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 12:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBCRyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 12:54:11 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C846C061573
        for <linux-rdma@vger.kernel.org>; Wed,  3 Feb 2021 09:53:31 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w124so757590oia.6
        for <linux-rdma@vger.kernel.org>; Wed, 03 Feb 2021 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtellCtuRHt39fV3/yu1FjrgezEXEIq4OIkAdBng4Ts=;
        b=VLpKen1N7lDl43I6PTlTNoI6QsI0mU1Y1cWmWSZ6PaSl1FYWFNa0gjWZyeLLz49pCP
         DxLTLF3GNhvlF6QF9ru+n97f/p7FGVLJfkPBvliZGyryAbGuQTFxFcEIHW5SJeuPWfM3
         yPcrUjDtZpGjMbM1yUKoGXm21HcXU3bub2xfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtellCtuRHt39fV3/yu1FjrgezEXEIq4OIkAdBng4Ts=;
        b=PiX387DRPInZU3x2EsFlcFp1kSYaneFH+dueBEGwzdJDe/VEjvsNo+FGWppC5OOxBB
         uHtUjn0e2h/kgLs8Aq/Vv//FAooIxKsN6t840CiowHDpZkHmhGaVl1S34gC1lprK3SMX
         Lfln88uC+7EE++eYEvSw8parwMQPiZGE5N2KY4sbZFszqlhP4bLGL/nmJUBLGHBsfHnz
         NA748jGOt6E1aFoQI1FPTbeeP/1YaAWR/rgyVOtii53FyO4B4NUOB/42cgoIkfRfLDDQ
         ErQRg51Krlu1JUywV0lrXds/fCh+2pziSQ9hAqkD+aMZFPtdXQLIYZnnGMQ2CtmmloQ5
         7LBg==
X-Gm-Message-State: AOAM5328IMKeGmetThZgVGSr53/X4aa7Ad1tpRGGC9Dq6ECGOyb+Gu3n
        lh30++dlu0OmKmOd0p1fbT9EXBvVLAbUi2ZZSovFbA==
X-Google-Smtp-Source: ABdhPJxjKGrH3kmcv87UU6MfsVoIgLplBwJqW0cDMOUEJh9i1EwCDVmsyHS8yzJJLvHUWJ1kW4ZpziQ8HZQRbm7ibxo=
X-Received: by 2002:aca:1906:: with SMTP id l6mr2700082oii.101.1612374810519;
 Wed, 03 Feb 2021 09:53:30 -0800 (PST)
MIME-Version: 1.0
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com> <20210201061603.GC4593@unreal>
 <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
 <20210201152922.GC4718@ziepe.ca> <MW3PR11MB455569DF7B795272687669BFE5B69@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YBluvZn1orYl7L9/@phenom.ffwll.local> <20210203060320.GK3264866@unreal> <MW3PR11MB455563A3F337F789613A9940E5B49@MW3PR11MB4555.namprd11.prod.outlook.com>
In-Reply-To: <MW3PR11MB455563A3F337F789613A9940E5B49@MW3PR11MB4555.namprd11.prod.outlook.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Feb 2021 18:53:19 +0100
Message-ID: <CAKMK7uHAD5FbDPeT2cD03HjHhvmMMG__muXqo=rTjd=htSMhtg@mail.gmail.com>
Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 3, 2021 at 5:57 PM Xiong, Jianxin <jianxin.xiong@intel.com> wrote:
>
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Tuesday, February 02, 2021 10:03 PM
> > To: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Xiong, Jianxin <jianxin.xiong@intel.com>; Jason Gunthorpe <jgg@ziepe.ca>; Gal Pressman <galpress@amazon.com>; Yishai Hadas
> > <yishaih@nvidia.com>; linux-rdma <linux-rdma@vger.kernel.org>; Edward Srouji <edwards@nvidia.com>; dri-devel <dri-
> > devel@lists.freedesktop.org>; Christian Koenig <christian.koenig@amd.com>; Doug Ledford <dledford@redhat.com>; Vetter, Daniel
> > <daniel.vetter@intel.com>
> > Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
> >
>
> <...>
>
> > > > > > > > > +#include <drm/drm.h>
> > > > > > > > > +#include <drm/i915_drm.h> #include <drm/amdgpu_drm.h>
> > > > > > > > > +#include <drm/radeon_drm.h>
> > > > > > > >
> > > > > > > > I assume these should come from the kernel headers package, right?
> > > > > > >
> > > > > > > This is gross, all kernel headers should be placed in
> > > > > > > kernel-headers/* and "update" script needs to be extended to take drm/* files too :(.
> > > > > >
> > > > > > drm kernel headers are in the libdrm package. You need that
> > > > > > anyway for doing the ioctls (if you don't hand-roll the restarting yourself).
> > > > > >
> > > > > > Also our userspace has gone over to just outright copying the
> > > > > > driver headers. Not the generic headers, but for the rendering
> > > > > > side of gpus, which is the topic here, there's really not much generic stuff.
> > > > > >
> > > > > > > Jianxin, are you fixing it?
> > > > > >
> > > > > > So fix is either to depend upon libdrm for building, or have
> > > > > > copies of the headers included in the package for the
> > > > > > i915/amdgpu/radeon headers (drm/drm.h probably not so good idea).
> > > > >
> > > > > We should have a cmake test to not build the drm parts if it can't be built, and pyverbs should skip the tests.
> > > > >
> > > >
> > > > Yes, I will add a test for that. Also, on SLES, the headers could be under /usr/include/libdrm instead of /usr/include/drm. The make test
> > should check that and use proper path.
> > >
> > > Please use pkgconfig for this, libdrm installs a .pc file to make sure
> > > you can find the right headers.
> >
> > rdma-core uses cmake build system and in our case cmake find_library() is preferable over pkgconfig.
>
> Only the headers are needed, and they could be installed via either the libdrm-devel package or the kernel-headers package. The cmake find_path() command is more suitable here.

Except if your distro is buggy (or doesn't support any gpu drivers at
all) they will never be installed as part of kernel-headers.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
