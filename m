Return-Path: <linux-rdma+bounces-7514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E50BA2C325
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 13:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26993A07F0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793D1E1A33;
	Fri,  7 Feb 2025 12:59:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4B7FD;
	Fri,  7 Feb 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933169; cv=none; b=Pa3Sk4O3mudc5KB+URUj37B3oAptXKMhFb3qI2DHcco2NiQGbDBBiVV264SOw7pMFzflibWgicyxDBkReBWsFTjeLJ5ifXQQAXxA1mRnuXEzgA4mqG84v/IFOcXXTWR9Wl+nLRcu0F+qrwfExH0at6rCJESMzx8tteIXecz3kNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933169; c=relaxed/simple;
	bh=PiBkQPbiA1N3w3yTc/P+6JoMC2L6C5HIzraVGz5XBrI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvWDs/I9R6VUNMn0Qtk7sMXfqURtfDrQ+75CEp0RuXvG7ahOU4f2Q/yZhsTFI7glhku+k8Y0bJruEDRDqjDQrEsq8dfqRwMHYMTsCEtPKFPnqasbo6XIbiM4s2mdYVQe3yFsGVoHTwV0nn5DzqJvGKwf2+P10jtr+p0TrOb0hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqDW50x3hz67Ct8;
	Fri,  7 Feb 2025 20:56:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D57AF1406AC;
	Fri,  7 Feb 2025 20:59:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Feb
 2025 13:59:17 +0100
Date: Fri, 7 Feb 2025 12:59:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, Christoph
 Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Leonid Bloch
	<lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Nelson,
 Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20250207125915.000079e4@huawei.com>
In-Reply-To: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Feb 2025 20:13:24 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Each file descriptor gets a chunk of per-FD driver specific context that
> allows the driver to attach a device specific struct to. The core code
> takes care of the memory lifetime for this structure.
> 
> The ioctl dispatch and design is based on what was built for iommufd. The
> ioctls have a struct which has a combined in/out behavior with a typical
> 'zero pad' scheme for future extension and backwards compatibility.
> 
> Like iommufd some shared logic does most of the ioctl marshalling and
> compatibility work and tables diatches to some function pointers for
> each unique iotcl.
> 
> This approach has proven to work quite well in the iommufd and rdma
> subsystems.
> 
> Allocate an ioctl number space for the subsystem.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Hi Jason,

Fresh read through given it's been a while.

A few really trivial things inline + one passing comment on a future
entertaining corner.

Jonathan


>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 34946bdc3bf3d7..d561deaf2b86d8 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c




>  static int fwctl_fops_release(struct inode *inode, struct file *filp)
>  {
> -	struct fwctl_device *fwctl = filp->private_data;
> +	struct fwctl_uctx *uctx = filp->private_data;
> +	struct fwctl_device *fwctl = uctx->fwctl;
>  
> +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> +		/*
> +		 * fwctl_unregister() has already removed the driver and
> +		 * destroyed the uctx.

Comment is a little odd given it is I think referring to why
the code that follows wouldn't run. Perhaps just add a 'may'

fwctl_unregister() may have already removed the driver and destroyed
the uctx.

> +		 */
> +		if (fwctl->ops) {
> +			guard(mutex)(&fwctl->uctx_list_lock);
> +			fwctl_destroy_uctx(uctx);
> +		}
> +	}
> +
> +	kfree(uctx);
>  	fwctl_put(fwctl);
>  	return 0;
>  }

>  
> @@ -71,14 +183,17 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
>  	if (!fwctl)
>  		return NULL;
>  
> -	fwctl->dev.class = &fwctl_class;
> -	fwctl->dev.parent = parent;
> -
>  	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
>  	if (devnum < 0)
>  		return NULL;
>  	fwctl->dev.devt = fwctl_dev + devnum;
>  
> +	fwctl->dev.class = &fwctl_class;
> +	fwctl->dev.parent = parent;

Shunt this move back to previous patch?


> +	init_rwsem(&fwctl->registration_lock);
> +	mutex_init(&fwctl->uctx_list_lock);
> +	INIT_LIST_HEAD(&fwctl->uctx_list);
> +
>  	device_initialize(&fwctl->dev);
>  	return_ptr(fwctl);
>  }

> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index 68ac2d5ab87481..93b470efb9dbc3 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -11,7 +11,30 @@
>  struct fwctl_device;
>  struct fwctl_uctx;
>  
> +/**
> + * struct fwctl_ops - Driver provided operations
> + *
> + * fwctl_unregister() will wait until all excuting ops are completed before it
> + * returns. Drivers should be mindful to not let their ops run for too long as
> + * it will block device hot unplug and module unloading.

A passing comment on this.  Seems likely that at somepoint we'll want an
abort op to enable cancelling if the particular driver supports it
(abort background command in CXL).  Anyhow, problem for another day.

> + */
>  struct fwctl_ops {
> +	/**
> +	 * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
> +	 * bytes of this memory will be a fwctl_uctx. The driver can use the
> +	 * remaining bytes as its private memory.
> +	 */
> +	size_t uctx_size;
> +	/**
> +	 * @open_uctx: Called when a file descriptor is opened before the uctx
> +	 * is ever used.
> +	 */
> +	int (*open_uctx)(struct fwctl_uctx *uctx);
> +	/**
> +	 * @close_uctx: Called when the uctx is destroyed, usually when the FD
> +	 * is closed.
> +	 */
> +	void (*close_uctx)(struct fwctl_uctx *uctx);
>  };



