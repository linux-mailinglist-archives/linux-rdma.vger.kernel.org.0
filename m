Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC330D346
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 07:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhBCGEL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 01:04:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhBCGEF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 01:04:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46C3464F5F;
        Wed,  3 Feb 2021 06:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612332204;
        bh=TamFsy+dl4YKadlK6KUmKSWE8+JRnBdDbFZmUJ9evl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KndeHYtdEEwNxKe27RLvOZB++RzvTRcR5yBYQKy+ZDYs7mcRdDtw/FKLBVAGLOyAT
         Xd69sTTDSNxKnTmtbeplQ2aaxT3TS+GarfhpRHpO/O+tMyZU7mF1TBKE/fzm7jz7TD
         Xnj5BfFHtRurDNrZB4SRvihgfz/1FbIUsKPoDQLA6EFIGD1KsksKUYvJpAu9yJEsXW
         Yz+Ouj3WpC919UuZcRoFSchUd2200T3hMs2c2ejijD0AIjO8VmeIqmi1bKnTJhxDRm
         TlGkV++KHs1YJdy9XLinKRdquUpRCHI2q3p0okjI3an5AYkG/EOTqxaUOpP3bLTxG0
         8jxTGc/GfQ30A==
Date:   Wed, 3 Feb 2021 08:03:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20210203060320.GK3264866@unreal>
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com>
 <20210201061603.GC4593@unreal>
 <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
 <20210201152922.GC4718@ziepe.ca>
 <MW3PR11MB455569DF7B795272687669BFE5B69@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YBluvZn1orYl7L9/@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBluvZn1orYl7L9/@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 02, 2021 at 04:24:45PM +0100, Daniel Vetter wrote:
> On Mon, Feb 01, 2021 at 05:03:44PM +0000, Xiong, Jianxin wrote:
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Monday, February 01, 2021 7:29 AM
> > > To: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Leon Romanovsky <leon@kernel.org>; Gal Pressman <galpress@amazon.com>; Xiong, Jianxin <jianxin.xiong@intel.com>; Yishai Hadas
> > > <yishaih@nvidia.com>; linux-rdma <linux-rdma@vger.kernel.org>; Edward Srouji <edwards@nvidia.com>; dri-devel <dri-
> > > devel@lists.freedesktop.org>; Christian Koenig <christian.koenig@amd.com>; Doug Ledford <dledford@redhat.com>; Vetter, Daniel
> > > <daniel.vetter@intel.com>
> > > Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
> > >
> > > On Mon, Feb 01, 2021 at 03:10:00PM +0100, Daniel Vetter wrote:
> > > > On Mon, Feb 1, 2021 at 7:16 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Sun, Jan 31, 2021 at 05:31:16PM +0200, Gal Pressman wrote:
> > > > > > On 25/01/2021 21:57, Jianxin Xiong wrote:
> > > > > > > Define a new sub-class of 'MR' that uses dma-buf object for the
> > > > > > > memory region. Define a new class 'DmaBuf' as a wrapper for
> > > > > > > dma-buf allocation mechanism implemented in C.
> > > > > > >
> > > > > > > Update the cmake function for cython modules to allow building
> > > > > > > modules with mixed cython and c source files.
> > > > > > >
> > > > > > > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > > > > > > buildlib/pyverbs_functions.cmake |  78 +++++++----
> > > > > > >  pyverbs/CMakeLists.txt           |  11 +-
> > > > > > >  pyverbs/dmabuf.pxd               |  15 +++
> > > > > > >  pyverbs/dmabuf.pyx               |  73 ++++++++++
> > > > > > >  pyverbs/dmabuf_alloc.c           | 278 +++++++++++++++++++++++++++++++++++++++
> > > > > > >  pyverbs/dmabuf_alloc.h           |  19 +++
> > > > > > >  pyverbs/libibverbs.pxd           |   2 +
> > > > > > >  pyverbs/mr.pxd                   |   6 +
> > > > > > >  pyverbs/mr.pyx                   | 105 ++++++++++++++-
> > > > > > >  9 files changed, 557 insertions(+), 30 deletions(-)  create
> > > > > > > mode 100644 pyverbs/dmabuf.pxd  create mode 100644
> > > > > > > pyverbs/dmabuf.pyx  create mode 100644 pyverbs/dmabuf_alloc.c
> > > > > > > create mode 100644 pyverbs/dmabuf_alloc.h
> > > > >
> > > > > <...>
> > > > >
> > > > > > > index 0000000..05eae75
> > > > > > > +++ b/pyverbs/dmabuf_alloc.c
> > > > > > > @@ -0,0 +1,278 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > > > > > +/*
> > > > > > > + * Copyright 2020 Intel Corporation. All rights reserved. See
> > > > > > > +COPYING file  */
> > > > > > > +
> > > > > > > +#include <stdio.h>
> > > > > > > +#include <stdlib.h>
> > > > > > > +#include <stdint.h>
> > > > > > > +#include <unistd.h>
> > > > > > > +#include <string.h>
> > > > > > > +#include <errno.h>
> > > > > > > +#include <drm/drm.h>
> > > > > > > +#include <drm/i915_drm.h>
> > > > > > > +#include <drm/amdgpu_drm.h>
> > > > > > > +#include <drm/radeon_drm.h>
> > > > > >
> > > > > > I assume these should come from the kernel headers package, right?
> > > > >
> > > > > This is gross, all kernel headers should be placed in
> > > > > kernel-headers/* and "update" script needs to be extended to take drm/* files too :(.
> > > >
> > > > drm kernel headers are in the libdrm package. You need that anyway for
> > > > doing the ioctls (if you don't hand-roll the restarting yourself).
> > > >
> > > > Also our userspace has gone over to just outright copying the driver
> > > > headers. Not the generic headers, but for the rendering side of gpus,
> > > > which is the topic here, there's really not much generic stuff.
> > > >
> > > > > Jianxin, are you fixing it?
> > > >
> > > > So fix is either to depend upon libdrm for building, or have copies of
> > > > the headers included in the package for the i915/amdgpu/radeon headers
> > > > (drm/drm.h probably not so good idea).
> > >
> > > We should have a cmake test to not build the drm parts if it can't be built, and pyverbs should skip the tests.
> > >
> >
> > Yes, I will add a test for that. Also, on SLES, the headers could be under /usr/include/libdrm instead of /usr/include/drm. The make test should check that and use proper path.
>
> Please use pkgconfig for this, libdrm installs a .pc file to make sure you
> can find the right headers.

rdma-core uses cmake build system and in our case cmake find_library()
is preferable over pkgconfig.

Thanks

> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
