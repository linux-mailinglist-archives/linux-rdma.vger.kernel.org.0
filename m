Return-Path: <linux-rdma+bounces-2850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F93F8FB984
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA38D1F26FBE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912C14884B;
	Tue,  4 Jun 2024 16:50:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27334171BA;
	Tue,  4 Jun 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519833; cv=none; b=Fh03J4siX2asQ1o4wDjJV/GAKIeiVolhH+BWh4JisuAIp9BkXKG1/CYf3CLoWa8J/HETD0oAA+TSw/ahmtRBdeZvdCAw6zIVY2NJuStKxFMZ+xt/jExHFm6j0S+nQMM5C8h0wGc0dOvNL3+yxz1BGvXS9+ylYcnRIkJswMoY9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519833; c=relaxed/simple;
	bh=scGzEw8LUM23Rsoia9NpRlqNk4ZC/Hx5Vl1Dtn0KH6k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJ9aneLuRimWEDhL+7KzY+mUyVlyN9t/YHMu7Q1wP0WaoXdseWMo6AEHygrcsXdfTjjE/1KFFnc6lYWf8tZasAM1MiFsb8h4dC4ijMpecvTtZtK8/bjTCFEqEckwhNrjrN4Ey/+z8kEXcXFfkXPpDsp1L1W9+oc0b84n8tMfJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtxQ34B16z6K8xj;
	Wed,  5 Jun 2024 00:49:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5489A1400D4;
	Wed,  5 Jun 2024 00:50:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 17:50:24 +0100
Date: Tue, 4 Jun 2024 17:50:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, "Aron
 Silverton" <aron.silverton@oracle.com>, Dan Williams
	<dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
	<lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240604175023.000004e2@Huawei.com>
In-Reply-To: <20240604122221.GR3884@unreal>
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
	<20240604122221.GR3884@unreal>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 4 Jun 2024 15:22:21 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Jun 04, 2024 at 02:16:12PM +0200, Zhu Yanjun wrote:
> > On 03.06.24 17:53, Jason Gunthorpe wrote:  
> > > Each file descriptor gets a chunk of per-FD driver specific context that
> > > allows the driver to attach a device specific struct to. The core code
> > > takes care of the memory lifetime for this structure.
> > > 
> > > The ioctl dispatch and design is based on what was built for iommufd. The
> > > ioctls have a struct which has a combined in/out behavior with a typical
> > > 'zero pad' scheme for future extension and backwards compatibility.
> > > 
> > > Like iommufd some shared logic does most of the ioctl marshalling and
> > > compatibility work and tables diatches to some function pointers for
> > > each unique iotcl.
> > > 
> > > This approach has proven to work quite well in the iommufd and rdma
> > > subsystems.
> > > 
> > > Allocate an ioctl number space for the subsystem.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> > >   MAINTAINERS                                   |   1 +
> > >   drivers/fwctl/main.c                          | 124 +++++++++++++++++-
> > >   include/linux/fwctl.h                         |  31 +++++
> > >   include/uapi/fwctl/fwctl.h                    |  41 ++++++
> > >   5 files changed, 196 insertions(+), 2 deletions(-)
> > >   create mode 100644 include/uapi/fwctl/fwctl.h  
> 
> <...>
> 
> > >   static int fwctl_fops_open(struct inode *inode, struct file *filp)
> > >   {
> > >   	struct fwctl_device *fwctl =
> > >   		container_of(inode->i_cdev, struct fwctl_device, cdev);
> > > +	struct fwctl_uctx *uctx __free(kfree) = NULL;
> > > +	int ret;
> > > +
> > > +	guard(rwsem_read)(&fwctl->registration_lock);
> > > +	if (!fwctl->ops)
> > > +		return -ENODEV;
> > > +
> > > +	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
> > > +	if (!uctx)
> > > +		return -ENOMEM;
> > > +
> > > +	uctx->fwctl = fwctl;
> > > +	ret = fwctl->ops->open_uctx(uctx);
> > > +	if (ret)
> > > +		return ret;  
> > 
> > When something is wrong, uctx is freed in "fwctl->ops->open_uctx(uctx);"?
> > 
> > If not, the allocated memory uctx leaks here.  
> 
> See how uctx is declared:
> struct fwctl_uctx *uctx __free(kfree) = NULL;
> 
> It will be released automatically.
> See include/linux/cleanup.h for more details.

I'm lazy so not finding the discussion now, but Linus has been pretty clear
that he doesn't like this pattern because of possibility of additional cleanup
magic getting introduced and then the cleanup happening in an order that
causes problems. 

Preferred option is drag the declaration to where is initialized so break
with our tradition of declarations all at the top

struct fwctl_uctx *uctx __free(kfree) =
	kzalloc(...);
etc


> 
> Thanks
> 


