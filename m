Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D892CA1A0
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgLALkM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 06:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbgLALkM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 06:40:12 -0500
Received: from coco.lan (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FAA220770;
        Tue,  1 Dec 2020 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606822771;
        bh=PQ9EZbSMFKUHeX+XY1hPlkXxxs7DFScv3x/xqnCA6Ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xsE2iYZLZhjhWy8fwKUBv5uNG5IGT6zeeytWsuNR2WK3hzRz4hCkWlmizxAWhYI68
         oytsPRsNsd86jy/cEo1HdWQi/2upVYfHgs/LjEUEs97agRWt2Jp3aTsemdLpGBydY8
         bHOmv7o38g/Uaw78EbGbuPnPg3VJR+3BIujLttHI=
Date:   Tue, 1 Dec 2020 12:39:21 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Divya Indi <divya.indi@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Moni Shoua <monis@mellanox.com>,
        "Or Gerlitz" <ogerlitz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Xi Wang <wangxi11@huawei.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH v4 07/27] IB: fix kernel-doc markups
Message-ID: <20201201123921.2009cbea@coco.lan>
In-Reply-To: <20201123234542.GA142861@nvidia.com>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
        <4983a0c6fe5dbc2c779d2b5950a6f90f81a16d56.1605521731.git.mchehab+huawei@kernel.org>
        <20201123234542.GA142861@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Em Mon, 23 Nov 2020 19:45:42 -0400
Jason Gunthorpe <jgg@nvidia.com> escreveu:

> On Mon, Nov 16, 2020 at 11:18:03AM +0100, Mauro Carvalho Chehab wrote:
> 
> > +/**
> > + * ib_alloc_pd - Allocates an unused protection domain.
> > + * @device: The device on which to allocate the protection domain.
> > + * @flags: protection domain flags
> > + *
> > + * A protection domain object provides an association between QPs, shared
> > + * receive queues, address handles, memory regions, and memory windows.
> > + *
> > + * Every PD has a local_dma_lkey which can be used as the lkey value for local
> > + * memory operations.
> > + */
> >  #define ib_alloc_pd(device, flags) \
> >  	__ib_alloc_pd((device), (flags), KBUILD_MODNAME)  
> 
> Why this hunk adding a completely new description in this patch?

In order to document ib_alloc_pd().

See, currently, verbs.c has this kernel-doc markup:

	/**
	 * ib_alloc_pd - Allocates an unused protection domain.
	 * @device: The device on which to allocate the protection domain.
	 * @flags: protection domain flags
	 * @caller: caller's build-time module name
	 *
	 * A protection domain object provides an association between QPs, shared
	 * receive queues, address handles, memory regions, and memory windows.
	 *
	 * Every PD has a local_dma_lkey which can be used as the lkey value for local
	 * memory operations.
	 */
	struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
	                const char *caller)

Which doesn't actually work as expected, as kernel-doc will, instead,
document __ib_alloc_pd():

	$ ./scripts/kernel-doc -sphinx-version 3.1 -function ib_alloc_pd drivers/infiniband/core/verbs.c 
	drivers/infiniband/core/verbs.c:1: warning: 'ib_alloc_pd' not found

	$ ./scripts/kernel-doc -sphinx-version 3.1 -function __ib_alloc_pd drivers/infiniband/core/verbs.c 
	.. c:function:: struct ib_pd * __ib_alloc_pd (struct ib_device *device, unsigned int flags, const char *caller)

	   Allocates an unused protection domain.

	**Parameters**

	``struct ib_device *device``
	  The device on which to allocate the protection domain.

	``unsigned int flags``
	  protection domain flags
	
	``const char *caller``
	  caller's build-time module name

	**Description**

	A protection domain object provides an association between QPs, shared
	receive queues, address handles, memory regions, and memory windows.

	Every PD has a local_dma_lkey which can be used as the lkey value for local
	memory operations.

So, what this patch does is to fix the kernel-doc markup at verbs.c for
it to reflect the function that it is documented, adding a new markup for
ib_alloc_pd(), which is identical to __ib_alloc_pd(), except for the
@caller field, which is set to KBUILD_MODNAME by this macro.

Thanks,
Mauro
