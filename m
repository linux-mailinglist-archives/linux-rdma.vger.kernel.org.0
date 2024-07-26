Return-Path: <linux-rdma+bounces-4018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1358D93D582
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67165B21B08
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616517B4ED;
	Fri, 26 Jul 2024 15:02:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27830BA42;
	Fri, 26 Jul 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006124; cv=none; b=cdlDmAT/k7HQ3ftfOcfO+pz/TwoNTVwvs5HwJJZkf1TSpSPwrqRDmVv828j3eY2jBbSFQcuYXv4Sq9pit097nMl+9M+lMAKeRMNmrqKjyVXXtqVtam/3jDdO6wUW0rCXa1ar7XIWQcSxyktnMEHuUA1yAkFCtjh3ewTyd13mv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006124; c=relaxed/simple;
	bh=sjlyXUhQ7zvv1asQmR5gj7X0ZVXOXk3cBSyQATQBvyk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SesoRvKpJ/XnRBclyuQrXLTXOJo+nxNx8r5a3DR2oF0qCqurV2lSpp1cvdiiIVn9L0g2VKY3Z+H938ud8QAQgimwM73V4vVgd5Dm8uzKJUNdOXpoZi6yujZ+TPc23WIXHdaG5dsbh9m8d7iZ49fxbY9SPwBnhHq2C/TIC0RpjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVrXH0WXHz6K5p8;
	Fri, 26 Jul 2024 23:00:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 55CE614065B;
	Fri, 26 Jul 2024 23:01:59 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 16:01:58 +0100
Date: Fri, 26 Jul 2024 16:01:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Jakub
 Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v2 2/8] fwctl: Basic ioctl dispatch for the character
 device
Message-ID: <20240726160157.0000797d@Huawei.com>
In-Reply-To: <2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<2-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 19:47:26 -0300
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
Minor stuff inline.

>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 6e9bf15c743b5c..6872c01d5c62e8 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c

> +
> +struct fwctl_ioctl_op {
> +	unsigned int size;
> +	unsigned int min_size;
> +	unsigned int ioctl_num;
> +	int (*execute)(struct fwctl_ucmd *ucmd);
> +};
> +
> +#define IOCTL_OP(_ioctl, _fn, _struct, _last)                         \
> +	[_IOC_NR(_ioctl) - FWCTL_CMD_BASE] = {                        \

If this is always zero indexed, maybe just drop the - FWCTL_CMD_BASE here
and elsewhere?  Maybe through in a BUILD_BUG to confirm it is always 0.


> +		.size = sizeof(_struct) +                             \
> +			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) < \
> +					  sizeof(_struct)),           \
> +		.min_size = offsetofend(_struct, _last),              \
> +		.ioctl_num = _ioctl,                                  \
> +		.execute = _fn,                                       \
> +	}
> +static const struct fwctl_ioctl_op fwctl_ioctl_ops[] = {
> +};
> +
> +static long fwctl_fops_ioctl(struct file *filp, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	struct fwctl_uctx *uctx = filp->private_data;
> +	const struct fwctl_ioctl_op *op;
> +	struct fwctl_ucmd ucmd = {};
> +	union ucmd_buffer buf;
> +	unsigned int nr;
> +	int ret;
> +
> +	nr = _IOC_NR(cmd);
> +	if ((nr - FWCTL_CMD_BASE) >= ARRAY_SIZE(fwctl_ioctl_ops))
> +		return -ENOIOCTLCMD;

I'd add a blank line here as two unconnected set and error check
blocks.

> +	op = &fwctl_ioctl_ops[nr - FWCTL_CMD_BASE];
> +	if (op->ioctl_num != cmd)
> +		return -ENOIOCTLCMD;
> +
> +	ucmd.uctx = uctx;
> +	ucmd.cmd = &buf;
> +	ucmd.ubuffer = (void __user *)arg;
> +	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
> +	if (ret)
> +		return ret;
> +
> +	if (ucmd.user_size < op->min_size)
> +		return -EINVAL;
> +
> +	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
> +				    ucmd.user_size);
> +	if (ret)
> +		return ret;
> +
> +	guard(rwsem_read)(&uctx->fwctl->registration_lock);
> +	if (!uctx->fwctl->ops)
> +		return -ENODEV;
> +	return op->execute(&ucmd);
> +}
> +
>  static int fwctl_fops_open(struct inode *inode, struct file *filp)
>  {
>  	struct fwctl_device *fwctl =
>  		container_of(inode->i_cdev, struct fwctl_device, cdev);
> +	int ret;
> +
> +	guard(rwsem_read)(&fwctl->registration_lock);
> +	if (!fwctl->ops)
> +		return -ENODEV;
> +
> +	struct fwctl_uctx *uctx __free(kfree) =
> +		kzalloc(fwctl->ops->uctx_size, GFP_KERNEL | GFP_KERNEL_ACCOUNT);

GFP_KERNEL_ACCOUNT seems to include GFP_KERNEL already.
Did I miss some racing change?

> +	if (!uctx)
> +		return -ENOMEM;
> +
> +	uctx->fwctl = fwctl;
> +	ret = fwctl->ops->open_uctx(uctx);
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(mutex, &fwctl->uctx_list_lock) {
> +		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
> +	}

I guess more may come later but do we need {}?


>  
>  	get_device(&fwctl->dev);
> -	filp->private_data = fwctl;
> +	filp->private_data = no_free_ptr(uctx);
>  	return 0;
>  }
>  
> +static void fwctl_destroy_uctx(struct fwctl_uctx *uctx)
> +{
> +	lockdep_assert_held(&uctx->fwctl->uctx_list_lock);
> +	list_del(&uctx->uctx_list_entry);
> +	uctx->fwctl->ops->close_uctx(uctx);
> +}
> +
>  static int fwctl_fops_release(struct inode *inode, struct file *filp)
>  {
> -	struct fwctl_device *fwctl = filp->private_data;
> +	struct fwctl_uctx *uctx = filp->private_data;
> +	struct fwctl_device *fwctl = uctx->fwctl;
>  
> +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> +		if (fwctl->ops) {

Maybe a comment on when this path happens to help the reader
along. (when the file is closed and device is still alive).
Otherwise was cleaned up already in fwctl_unregister()

> +			guard(mutex)(&fwctl->uctx_list_lock);
> +			fwctl_destroy_uctx(uctx);
> +		}
> +	}
> +
> +	kfree(uctx);
>  	fwctl_put(fwctl);
>  	return 0;
>  }
> @@ -37,6 +142,7 @@ static const struct file_operations fwctl_fops = {
>  	.owner = THIS_MODULE,
>  	.open = fwctl_fops_open,
>  	.release = fwctl_fops_release,
> +	.unlocked_ioctl = fwctl_fops_ioctl,
>  };

>  
>  	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
>  	if (devnum < 0)
> @@ -137,8 +247,18 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
>   */
>  void fwctl_unregister(struct fwctl_device *fwctl)
>  {
> +	struct fwctl_uctx *uctx;
> +
>  	cdev_device_del(&fwctl->cdev, &fwctl->dev);
>  
> +	/* Disable and free the driver's resources for any still open FDs. */
> +	guard(rwsem_write)(&fwctl->registration_lock);
> +	guard(mutex)(&fwctl->uctx_list_lock);
> +	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
> +						struct fwctl_uctx,
> +						uctx_list_entry)))
> +		fwctl_destroy_uctx(uctx);
> +

Obviously it's a little more heavy weight but I'd just use
list_for_each_entry_safe()

Less effort for reviewers than consider the custom iteration
you are doing instead.


>  	/*
>  	 * The driver module may unload after this returns, the op pointer will
>  	 * not be valid.
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index ef4eaa87c945e4..1d9651de92fc19 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -11,7 +11,20 @@
>  struct fwctl_device;
>  struct fwctl_uctx;
>  
> +/**
> + * struct fwctl_ops - Driver provided operations
> + * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
> + *	bytes of this memory will be a fwctl_uctx. The driver can use the
> + *	remaining bytes as its private memory.
> + * @open_uctx: Called when a file descriptor is opened before the uctx is ever
> + *	used.
> + * @close_uctx: Called when the uctx is destroyed, usually when the FD is
> + *	closed.
> + */
>  struct fwctl_ops {
> +	size_t uctx_size;
> +	int (*open_uctx)(struct fwctl_uctx *uctx);
> +	void (*close_uctx)(struct fwctl_uctx *uctx);
>  };
>  
>  /**
> @@ -26,6 +39,10 @@ struct fwctl_device {
>  	struct device dev;
>  	/* private: */
>  	struct cdev cdev;
> +
> +	struct rw_semaphore registration_lock;
> +	struct mutex uctx_list_lock;

Even for private locks, a scope statement would
be good to have.

> +	struct list_head uctx_list;
>  	const struct fwctl_ops *ops;
>  };

>  #endif
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> new file mode 100644
> index 00000000000000..0bdce95b6d69d9
> --- /dev/null
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
> + */
> +#ifndef _UAPI_FWCTL_H
> +#define _UAPI_FWCTL_H
> +
> +#include <linux/types.h>

Not used yet.

> +#include <linux/ioctl.h>

Arguably nor is this, but at least this related to the code
here.

> +
> +#define FWCTL_TYPE 0x9A
> +
> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
> + * the structure in the first u32. The kernel checks that any structure space
> + * beyond what it understands is 0. This allows userspace to use the backward
> + * compatible portion while consistently using the newer, larger, structures.

Is that particularly helpful?  Userspace needs to know not to put anything in
those fields, not hard for it to also know what the size it should send is?
The two will change together.

> + *
> + * ioctls use a standard meaning for common errnos:
> + *
> + *  - ENOTTY: The IOCTL number itself is not supported at all
> + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> + *    non-zero in a part the kernel does not understand.
> + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> + *    understood, however a known field has a value the kernel does not
> + *    understand or support.
> + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> + *    correct.
> + *  - ENOMEM: Out of memory.
> + *  - ENODEV: The underlying device has been hot-unplugged and the FD is
> + *            orphaned.
> + *
> + * As well as additional errnos, within specific ioctls.
> + */
> +enum {
> +	FWCTL_CMD_BASE = 0,
> +};
> +
> +#endif


