Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25DF30A1FE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 07:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhBAGd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 01:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhBAGQt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Feb 2021 01:16:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2201F64E06;
        Mon,  1 Feb 2021 06:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612160166;
        bh=U6U/9YgJ8fjKDahPOgJRNrUzRWZyTJ3dnSycpYl+m8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCEjCtuQjvQSAdqrMKoxNJ/rIPGOaCEa3aBt3+9g1eDIcmsIE3bxXhxe5MUDBNDSs
         8gJ55aaI9Jpk+buJa+Gk3mEyEuWFIqKAHLVLoHpfduQnS2pShCZ5WJEFg0hcs0CrtO
         sD4hjJj0wvU097HpuVY72DJMJn9WgP1FdB8I9jzVzFMWo0oEv49e0fkQ8KVm3c8qbq
         m4T4v9bbj1ZDSGrmGj+LXIgzFEObC/e/UfbJrrD1+Dt/4bwWeOi7dvfud3QPwSLRqF
         GCRKMwYJM4BmasjtmFdBm8Sia1KN4lQUR6K4Xz/VC59SfHByQaZv0FE++zetExDby6
         HAPGaP1igdsTA==
Date:   Mon, 1 Feb 2021 08:16:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Edward Srouji <edwards@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20210201061603.GC4593@unreal>
References: <1611604622-86968-1-git-send-email-jianxin.xiong@intel.com>
 <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 31, 2021 at 05:31:16PM +0200, Gal Pressman wrote:
> On 25/01/2021 21:57, Jianxin Xiong wrote:
> > Define a new sub-class of 'MR' that uses dma-buf object for the memory
> > region. Define a new class 'DmaBuf' as a wrapper for dma-buf allocation
> > mechanism implemented in C.
> >
> > Update the cmake function for cython modules to allow building modules
> > with mixed cython and c source files.
> >
> > Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> > ---
> >  buildlib/pyverbs_functions.cmake |  78 +++++++----
> >  pyverbs/CMakeLists.txt           |  11 +-
> >  pyverbs/dmabuf.pxd               |  15 +++
> >  pyverbs/dmabuf.pyx               |  73 ++++++++++
> >  pyverbs/dmabuf_alloc.c           | 278 +++++++++++++++++++++++++++++++++++++++
> >  pyverbs/dmabuf_alloc.h           |  19 +++
> >  pyverbs/libibverbs.pxd           |   2 +
> >  pyverbs/mr.pxd                   |   6 +
> >  pyverbs/mr.pyx                   | 105 ++++++++++++++-
> >  9 files changed, 557 insertions(+), 30 deletions(-)
> >  create mode 100644 pyverbs/dmabuf.pxd
> >  create mode 100644 pyverbs/dmabuf.pyx
> >  create mode 100644 pyverbs/dmabuf_alloc.c
> >  create mode 100644 pyverbs/dmabuf_alloc.h

<...>

> > index 0000000..05eae75
> > --- /dev/null
> > +++ b/pyverbs/dmabuf_alloc.c
> > @@ -0,0 +1,278 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > +/*
> > + * Copyright 2020 Intel Corporation. All rights reserved. See COPYING file
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <stdint.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <drm/drm.h>
> > +#include <drm/i915_drm.h>
> > +#include <drm/amdgpu_drm.h>
> > +#include <drm/radeon_drm.h>
>
> I assume these should come from the kernel headers package, right?

This is gross, all kernel headers should be placed in kernel-headers/*
and "update" script needs to be extended to take drm/* files too :(.

Jianxin, are you fixing it?

Thanks
