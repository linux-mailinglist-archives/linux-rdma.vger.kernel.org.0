Return-Path: <linux-rdma+bounces-4517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02CC95CECF
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A5E281DAF
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B387191F7E;
	Fri, 23 Aug 2024 14:02:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8151917EC;
	Fri, 23 Aug 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421735; cv=none; b=TbndYdohDbcV3n5PF0eDnqzueLldeyUbOxTft08vac2pe56gmltubmBTrp6P097crMx6f8hpRyYOigWasfiswsiLQZsB29nT8qnBwjxgevCuwrLlm0Ffm0HM6rOU2eb1FJ0fLkWaVZTTv7oOANueleV5QV68+bJGiCff8FHY3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421735; c=relaxed/simple;
	bh=pXVT8snCE8jR2BENCqbk8tDgtd4Q5B2UmejOmQPZeGw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOmGw0ksFaFF6FvzJmm2Ty95yUe59xwubbI1CE8Hz6EPs1YnKPw8yzCboQ2w3Arlj4FNOf9ipEBBN3rog3Lud6+laK1rhnaSc/GxFry6mbiUMNlTAD8CFuXKB6zA4q3eMAxbpdsLy8Q8/XQNDhQRfR/LI4mHKHFu16BJ4fKQA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr1rh0jzbz6K8xG;
	Fri, 23 Aug 2024 21:59:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B894140B3C;
	Fri, 23 Aug 2024 22:02:09 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 15:02:08 +0100
Date: Fri, 23 Aug 2024 15:02:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Daniel
 Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, David
 Ahern <dsahern@kernel.org>, "Greg Kroah-Hartman"
	<gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 02/10] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240823150207.000000e9@Huawei.com>
In-Reply-To: <2-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<2-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 21 Aug 2024 15:10:54 -0300
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
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Hi Jason,

A few minor things inline, but all trivial so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 7f3e7713d0e6e9..f2e30ffc1e0cb5 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c



>  
> @@ -71,6 +183,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
>  
>  	fwctl->dev.class = &fwctl_class;
>  	fwctl->dev.parent = parent;
> +	init_rwsem(&fwctl->registration_lock);
> +	mutex_init(&fwctl->uctx_list_lock);

If the ida_alloc_max() fails,I don't think you destroy the mutex as the
device isn't yet initialized / put in the error path.

Whilst i find it hard to care, it's nice to always destroy mutex, or not do it at all.
Feels odd to only do it if things go well.

> +	INIT_LIST_HEAD(&fwctl->uctx_list);
>  
>  	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
>  	if (devnum < 0)
> @@ -127,6 +242,10 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
>   * Undoes fwctl_register(). On return no driver ops will be called. The
>   * caller must still call fwctl_put() to free the fwctl.
>   *
> + * Unregister will return even if userspace still has file descriptors open.
> + * This will call ops->close_uctx() on any open FDs and after return no driver
> + * op will be called. The FDs remain open but all fops will return -ENODEV.
> + *
>   * The design of fwctl allows this sort of disassociation of the driver from the
>   * subsystem primarily by keeping memory allocations owned by the core subsytem.
>   * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
> @@ -134,7 +253,23 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
>   */
>  void fwctl_unregister(struct fwctl_device *fwctl)
>  {
> +	struct fwctl_uctx *uctx;
> +
>  	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> +
> +	/* Disable and free the driver's resources for any still open FDs. */
> +	guard(rwsem_write)(&fwctl->registration_lock);
> +	guard(mutex)(&fwctl->uctx_list_lock);
> +	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
> +						struct fwctl_uctx,
> +						uctx_list_entry)))
> +		fwctl_destroy_uctx(uctx);
> +
> +	/*
> +	 * The driver module may unload after this returns, the op pointer will
> +	 * not be valid.
> +	 */
> +	fwctl->ops = NULL;
>  }
>  EXPORT_SYMBOL_NS_GPL(fwctl_unregister, FWCTL);
>  
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index 68ac2d5ab87481..ca4245825e91bf 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h

>  
>  /**
> @@ -26,6 +49,15 @@ struct fwctl_device {
>  	struct device dev;
>  	/* private: */
>  	struct cdev cdev;
> +
> +	/*
> +	 * Protect ops, held for write when ops becomes NULL during unregister,
> +	 * held for read whenver ops is loaded or an ops function is running.
> +	 */
> +	struct rw_semaphore registration_lock;

Maybe move down to just above ops?

> +	/* Protect uctx_list */
> +	struct mutex uctx_list_lock;
> +	struct list_head uctx_list;
>  	const struct fwctl_ops *ops;
>  };

> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> new file mode 100644
> index 00000000000000..22fa750d7e8184
> --- /dev/null
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
> + */
> +#ifndef _UAPI_FWCTL_H
> +#define _UAPI_FWCTL_H
> +
> +#define FWCTL_TYPE 0x9A
> +
> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
Pedantic Englishman time:
passed a structure pointer

(otherwise I read that as passing an ioctl in a pointer which is weird).

> + * the structure in the first u32. The kernel checks that any structure space 
...



