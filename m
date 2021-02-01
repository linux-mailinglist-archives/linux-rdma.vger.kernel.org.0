Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D230AB56
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhBAPaT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 10:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhBAPaE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Feb 2021 10:30:04 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C0C06174A
        for <linux-rdma@vger.kernel.org>; Mon,  1 Feb 2021 07:29:24 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t63so16576363qkc.1
        for <linux-rdma@vger.kernel.org>; Mon, 01 Feb 2021 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0GXOS7+mzX0TE2Qp//hk/lkiASVs1Lp79Aq1a9Ju4Q=;
        b=mwF+XQ/bR5R0UQ9p0VaLGKM4TPdAZunLBWP0ELnamkGJSw/WlbsR1nYHB6TfIEBhYi
         ZSvN6GabuLRKT56OF32/wI/6FoSUHDcCgqxVUc7Wlydca+0K9v/FDXjN2T6i/Ffl1zO8
         LzC8fV8EJou3u3t9ik5C4/+xtCj315QjRncjt2qIIYAU5IWE4lAoskVp4QqbqwEanbiM
         geB0Rnxcb5505U6rtrun/MmO9+cSSqeoEPDYZAoAElwkSYLKUODFCKrBXwYLx/O/7Xwa
         RCAA2gpGL+7nu0pbiXRYXp2wspIXjXiNXa8ll8EDco4AdtMe+trpQsKfj4eo4rJqdFvz
         /Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0GXOS7+mzX0TE2Qp//hk/lkiASVs1Lp79Aq1a9Ju4Q=;
        b=Zttog2qFJFop2OQx95g5ETQ1S29xRChhPwCCsD7DMfy98QppnyjDORIG5cnoQ85MDQ
         gH3mlZKOfP5m13QnPzJdBLDTLpHqCirNQL4tM4W+zef0IDr1PLJbd1jPJG+rAJgDATJS
         /PuQSvXG8I/dF5ZYmMYY/YIGSkJGkAV0pZDFsKPcM/prGNYF+R/k3EDW+2MS/nKJY1KN
         c973fqBLr6LsNzEJcSLS0V647aeGAlKepMLTHHnl3lKn5R7ovlfQatpyeaVHooTq6M/o
         LsMuejiRLLDA/sbiNiAhfeDALOwCfSbe7Yo3DfZkZkQbzXoP2yjsXy4NQomHv6hMTL+a
         hRQw==
X-Gm-Message-State: AOAM533NlbBhTmOePhth+nJxplZ9tyhwghW19qnE4sFATyq9fNoUGT4L
        uRHO7sFpdYpm2/z/zQtfRsY9DQ==
X-Google-Smtp-Source: ABdhPJyFiHY5UuFhaM6bf0XGVV7w/DUR8CFB09e/cP4Pk3MvJpFZLWaEf1gyRO830JqfHK/1qE9TOw==
X-Received: by 2002:a37:c0c:: with SMTP id 12mr17069709qkm.314.1612193363350;
        Mon, 01 Feb 2021 07:29:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id p22sm14302462qkk.128.2021.02.01.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 07:29:22 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l6b8k-002Ea0-14; Mon, 01 Feb 2021 11:29:22 -0400
Date:   Mon, 1 Feb 2021 11:29:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20210201152922.GC4718@ziepe.ca>
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com>
 <20210201061603.GC4593@unreal>
 <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 01, 2021 at 03:10:00PM +0100, Daniel Vetter wrote:
> On Mon, Feb 1, 2021 at 7:16 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sun, Jan 31, 2021 at 05:31:16PM +0200, Gal Pressman wrote:
> > > On 25/01/2021 21:57, Jianxin Xiong wrote:
> > > > Define a new sub-class of 'MR' that uses dma-buf object for the memory
> > > > region. Define a new class 'DmaBuf' as a wrapper for dma-buf allocation
> > > > mechanism implemented in C.
> > > >
> > > > Update the cmake function for cython modules to allow building modules
> > > > with mixed cython and c source files.
> > > >
> > > > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > > >  buildlib/pyverbs_functions.cmake |  78 +++++++----
> > > >  pyverbs/CMakeLists.txt           |  11 +-
> > > >  pyverbs/dmabuf.pxd               |  15 +++
> > > >  pyverbs/dmabuf.pyx               |  73 ++++++++++
> > > >  pyverbs/dmabuf_alloc.c           | 278 +++++++++++++++++++++++++++++++++++++++
> > > >  pyverbs/dmabuf_alloc.h           |  19 +++
> > > >  pyverbs/libibverbs.pxd           |   2 +
> > > >  pyverbs/mr.pxd                   |   6 +
> > > >  pyverbs/mr.pyx                   | 105 ++++++++++++++-
> > > >  9 files changed, 557 insertions(+), 30 deletions(-)
> > > >  create mode 100644 pyverbs/dmabuf.pxd
> > > >  create mode 100644 pyverbs/dmabuf.pyx
> > > >  create mode 100644 pyverbs/dmabuf_alloc.c
> > > >  create mode 100644 pyverbs/dmabuf_alloc.h
> >
> > <...>
> >
> > > > index 0000000..05eae75
> > > > +++ b/pyverbs/dmabuf_alloc.c
> > > > @@ -0,0 +1,278 @@
> > > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > > +/*
> > > > + * Copyright 2020 Intel Corporation. All rights reserved. See COPYING file
> > > > + */
> > > > +
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <stdint.h>
> > > > +#include <unistd.h>
> > > > +#include <string.h>
> > > > +#include <errno.h>
> > > > +#include <drm/drm.h>
> > > > +#include <drm/i915_drm.h>
> > > > +#include <drm/amdgpu_drm.h>
> > > > +#include <drm/radeon_drm.h>
> > >
> > > I assume these should come from the kernel headers package, right?
> >
> > This is gross, all kernel headers should be placed in kernel-headers/*
> > and "update" script needs to be extended to take drm/* files too :(.
> 
> drm kernel headers are in the libdrm package. You need that anyway for
> doing the ioctls (if you don't hand-roll the restarting yourself).
> 
> Also our userspace has gone over to just outright copying the driver
> headers. Not the generic headers, but for the rendering side of gpus,
> which is the topic here, there's really not much generic stuff.
> 
> > Jianxin, are you fixing it?
> 
> So fix is either to depend upon libdrm for building, or have copies of
> the headers included in the package for the i915/amdgpu/radeon headers
> (drm/drm.h probably not so good idea).

We should have a cmake test to not build the drm parts if it can't be
built, and pyverbs should skip the tests.

Jason
