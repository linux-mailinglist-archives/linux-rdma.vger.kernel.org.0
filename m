Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D820830A960
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 15:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBAOKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBAOKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Feb 2021 09:10:52 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E149FC061573
        for <linux-rdma@vger.kernel.org>; Mon,  1 Feb 2021 06:10:11 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id m13so18851036oig.8
        for <linux-rdma@vger.kernel.org>; Mon, 01 Feb 2021 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1A4LjcU8Wm+KQIpG8ygJhxw/9q2mcR8XhADNs60aGpo=;
        b=QvGkIY3kIIxXCvF9WmThHTl0vA4ltpyiiAiepo9Xn60XY5Vl6X6tDfuNE7zJCcS63l
         988cciblOdIk7ryCsgAUm1zcqrNHZpg8RxJ86eUcDNvetVa0olwSustcmUVAmz3eFvnP
         kqnsGKehu5ssps79I/OsebC/5OFrQqf2dOY9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1A4LjcU8Wm+KQIpG8ygJhxw/9q2mcR8XhADNs60aGpo=;
        b=LmbAI2hT4GtAzqqxnEVIEBuXx1cZD+7LsUtQ9JwSZyMQi3D/42ik7oWw2LmSWqYMjk
         N0/NP4QWblpf02nDZCYl8XU6bAMBR8dDtgpP/KMDFAzAfmhwRCcfaL8/8eR5aI1v3vzT
         gdY2TaZZsAtMU87v9dCszQF6NbGN5XMIMxLEvp8VOHUVarSvtRPQgcfXHt+Rjle7d0vw
         y75Vop9duwzKCk8dHW/N3L/WxftR9QuPnYHZQCFIG0cLTHpqtugezeH8Yz5XWaalKGcb
         d6KDEadMty71NzGxvmTymg1ke4y0nhFx+l6fl0YfODElgI9MOE9EkuO7KqebSTyVXcIV
         UQxQ==
X-Gm-Message-State: AOAM532d0VWnZgQ8gjBUASKtXVTTBP/ugks2fADcTjxPAl1XVy+PdDOD
        3n4FSM8sQs8320JpC0G8SPy3C98q5vdpdRWKc+vqtg==
X-Google-Smtp-Source: ABdhPJy/qir5LfOIB2Xue0CzN0thmGS+0Shc+xOPK5I2WrjqVGrKqoJfrHL6hCCN+ND0CnPDsiljXc95OBHTH1oAX3A=
X-Received: by 2002:aca:ad92:: with SMTP id w140mr10932572oie.128.1612188611205;
 Mon, 01 Feb 2021 06:10:11 -0800 (PST)
MIME-Version: 1.0
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com> <20210201061603.GC4593@unreal>
In-Reply-To: <20210201061603.GC4593@unreal>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 1 Feb 2021 15:10:00 +0100
Message-ID: <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gal Pressman <galpress@amazon.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 1, 2021 at 7:16 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Sun, Jan 31, 2021 at 05:31:16PM +0200, Gal Pressman wrote:
> > On 25/01/2021 21:57, Jianxin Xiong wrote:
> > > Define a new sub-class of 'MR' that uses dma-buf object for the memory
> > > region. Define a new class 'DmaBuf' as a wrapper for dma-buf allocation
> > > mechanism implemented in C.
> > >
> > > Update the cmake function for cython modules to allow building modules
> > > with mixed cython and c source files.
> > >
> > > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > > ---
> > >  buildlib/pyverbs_functions.cmake |  78 +++++++----
> > >  pyverbs/CMakeLists.txt           |  11 +-
> > >  pyverbs/dmabuf.pxd               |  15 +++
> > >  pyverbs/dmabuf.pyx               |  73 ++++++++++
> > >  pyverbs/dmabuf_alloc.c           | 278 +++++++++++++++++++++++++++++++++++++++
> > >  pyverbs/dmabuf_alloc.h           |  19 +++
> > >  pyverbs/libibverbs.pxd           |   2 +
> > >  pyverbs/mr.pxd                   |   6 +
> > >  pyverbs/mr.pyx                   | 105 ++++++++++++++-
> > >  9 files changed, 557 insertions(+), 30 deletions(-)
> > >  create mode 100644 pyverbs/dmabuf.pxd
> > >  create mode 100644 pyverbs/dmabuf.pyx
> > >  create mode 100644 pyverbs/dmabuf_alloc.c
> > >  create mode 100644 pyverbs/dmabuf_alloc.h
>
> <...>
>
> > > index 0000000..05eae75
> > > --- /dev/null
> > > +++ b/pyverbs/dmabuf_alloc.c
> > > @@ -0,0 +1,278 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > +/*
> > > + * Copyright 2020 Intel Corporation. All rights reserved. See COPYING file
> > > + */
> > > +
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <stdint.h>
> > > +#include <unistd.h>
> > > +#include <string.h>
> > > +#include <errno.h>
> > > +#include <drm/drm.h>
> > > +#include <drm/i915_drm.h>
> > > +#include <drm/amdgpu_drm.h>
> > > +#include <drm/radeon_drm.h>
> >
> > I assume these should come from the kernel headers package, right?
>
> This is gross, all kernel headers should be placed in kernel-headers/*
> and "update" script needs to be extended to take drm/* files too :(.

drm kernel headers are in the libdrm package. You need that anyway for
doing the ioctls (if you don't hand-roll the restarting yourself).

Also our userspace has gone over to just outright copying the driver
headers. Not the generic headers, but for the rendering side of gpus,
which is the topic here, there's really not much generic stuff.

> Jianxin, are you fixing it?

So fix is either to depend upon libdrm for building, or have copies of
the headers included in the package for the i915/amdgpu/radeon headers
(drm/drm.h probably not so good idea).

Cheers, Daniel
>
> Thanks
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
