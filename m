Return-Path: <linux-rdma+bounces-7571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8001A2D1E8
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EC9188DD83
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ABDDDAD;
	Sat,  8 Feb 2025 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvdsdY8y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E415C0;
	Sat,  8 Feb 2025 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973777; cv=none; b=D/fbi5Nb6F9/8NR5dOyDUYTOIcqHs38A199mzA46gwlkQlpeFhdfm4uImD0wF8+Yn8JM1W7gmhTqw/0FTgmDl8RO8ufeQJMfMtrhjxhjW7kJ0J5sd9giSiD+kIZQ6Ox8sfBHh+T8bdooR47rBekFBZWrFYwOe9gspbDW14qVjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973777; c=relaxed/simple;
	bh=GHUqBmHYBFAJQSuU2osCWImKdW75FVh2KEJlrFYl7vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SO8cZoc9Iraht7u0AM4yK/tIi9u2Q0i7IRq2C2ITbTQ8DSIH37JdIBGtuACCSEaLx2vb/d3k+LZgTtgt8MsChSah6s0nkgsGhCJ8eA5qfjwDmqLcKZdXy/Zdcle3yhAUsAKIOUxy2f702n/R8FjfSgwtDeTcuf9Cc/MF9rS0PJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvdsdY8y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738973775; x=1770509775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GHUqBmHYBFAJQSuU2osCWImKdW75FVh2KEJlrFYl7vk=;
  b=KvdsdY8yJh6Cg4hPoTZi2A9K0ydrEkCfGkavCWVQc+O348mImB3TMjwM
   NU/tuIxhVnPot8XbmAgODkgr2r/mOm93CyDFQsWj60vLKes7OXiA1Wasd
   9IB1SJXD+ZI52gVWVy4GlCc75mBrT8m79713nbpZERQeNV/ADG7LNGly5
   JZ0GymcvWpvS7x2gevDc5utLyyIUgvYotE3c4TPvOoIzQ7n+D04s4OoE2
   iZ/jTAk9j7Hq/3GDYydOoBbERTVTXJKC0sPJiYNcQtC2SDcn/uEW8p1Uq
   2dI5xtZVf1UzpiJfqTxafDuOXT/F3KH4rSQNKM24aMSQcXqR6v0pi9jXH
   Q==;
X-CSE-ConnectionGUID: +LELIfAuSfWkrWU+sZQcLw==
X-CSE-MsgGUID: y8+WLlpJREGaupw/bZ2TyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="62102948"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="62102948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:16:15 -0800
X-CSE-ConnectionGUID: eFfIv1GhRSqeOZi5SdeTYw==
X-CSE-MsgGUID: suWQrQnlRxSo/FYDvL4BWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111511641"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:16:13 -0800
Message-ID: <4c636d2a-939b-47a9-8e60-e9e78d757fe3@intel.com>
Date: Fri, 7 Feb 2025 17:16:12 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] fwctl: Basic ioctl dispatch for the character
 device
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Ahern <dsahern@kernel.org>,
 Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>
References: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
> Each file descriptor gets a chunk of per-FD driver specific context that
> allows the driver to attach a device specific struct to. The core code
> takes care of the memory lifetime for this structure.
> 
> The ioctl dispatch and design is based on what was built for iommufd. The
> ioctls have a struct which has a combined in/out behavior with a typical
> 'zero pad' scheme for future extension and backwards compatibility.
> 
> Like iommufd some shared logic does most of the ioctl marshalling and
s/marshalling/marshaling/

> compatibility work and tables diatches to some function pointers for

s/diatches/dispatches/

> each unique iotcl.

s/iotcl/ioctl/

> 
> This approach has proven to work quite well in the iommufd and rdma
> subsystems.
> 
> Allocate an ioctl number space for the subsystem.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |   1 +
>  drivers/fwctl/main.c                          | 145 +++++++++++++++++-
>  include/linux/fwctl.h                         |  46 ++++++
>  include/uapi/fwctl/fwctl.h                    |  38 +++++
>  5 files changed, 226 insertions(+), 5 deletions(-)
>  create mode 100644 include/uapi/fwctl/fwctl.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 6d1465315df328..3410b020a9d093 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -331,6 +331,7 @@ Code  Seq#    Include File                                           Comments
>  0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
>  0x99  00-0F                                                          537-Addinboard driver
>                                                                       <mailto:buk@buks.ipn.de>
> +0x9A  00-0F  include/uapi/fwctl/fwctl.h
>  0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
>                                                                       <mailto:kenji@bitgate.com>
>  0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff418a77f39e4d..5f30adbe6c8521 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9564,6 +9564,7 @@ S:	Maintained
>  F:	Documentation/userspace-api/fwctl.rst
>  F:	drivers/fwctl/
>  F:	include/linux/fwctl.h
> +F:	include/uapi/fwctl/
>  
>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index 34946bdc3bf3d7..d561deaf2b86d8 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -10,6 +10,8 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> +#include <uapi/fwctl/fwctl.h>
> +
>  enum {
>  	FWCTL_MAX_DEVICES = 4096,
>  };
> @@ -18,20 +20,128 @@ static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
>  static dev_t fwctl_dev;
>  static DEFINE_IDA(fwctl_ida);
>  
> +struct fwctl_ucmd {
> +	struct fwctl_uctx *uctx;
> +	void __user *ubuffer;
> +	void *cmd;
> +	u32 user_size;
> +};
> +
> +/* On stack memory for the ioctl structs */
> +union ucmd_buffer {
> +};
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
> +
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
> +		kzalloc(fwctl->ops->uctx_size, GFP_KERNEL_ACCOUNT);
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
> +		/*
> +		 * fwctl_unregister() has already removed the driver and
> +		 * destroyed the uctx.
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
> @@ -40,6 +150,7 @@ static const struct file_operations fwctl_fops = {
>  	.owner = THIS_MODULE,
>  	.open = fwctl_fops_open,
>  	.release = fwctl_fops_release,
> +	.unlocked_ioctl = fwctl_fops_ioctl,
>  };
>  
>  static void fwctl_device_release(struct device *device)
> @@ -48,6 +159,7 @@ static void fwctl_device_release(struct device *device)
>  		container_of(device, struct fwctl_device, dev);
>  
>  	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
> +	mutex_destroy(&fwctl->uctx_list_lock);
>  	kfree(fwctl);
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
> +	init_rwsem(&fwctl->registration_lock);
> +	mutex_init(&fwctl->uctx_list_lock);
> +	INIT_LIST_HEAD(&fwctl->uctx_list);
> +
>  	device_initialize(&fwctl->dev);
>  	return_ptr(fwctl);
>  }
> @@ -129,6 +244,10 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
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
> @@ -136,7 +255,23 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
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
>  EXPORT_SYMBOL_NS_GPL(fwctl_unregister, "FWCTL");
>  
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
>  
>  /**
> @@ -26,6 +49,15 @@ struct fwctl_device {
>  	struct device dev;
>  	/* private: */
>  	struct cdev cdev;
> +
> +	/* Protect uctx_list */
> +	struct mutex uctx_list_lock;
> +	struct list_head uctx_list;
> +	/*
> +	 * Protect ops, held for write when ops becomes NULL during unregister,
> +	 * held for read whenever ops is loaded or an ops function is running.
> +	 */
> +	struct rw_semaphore registration_lock;
>  	const struct fwctl_ops *ops;
>  };
>  
> @@ -66,4 +98,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
>  int fwctl_register(struct fwctl_device *fwctl);
>  void fwctl_unregister(struct fwctl_device *fwctl);
>  
> +/**
> + * struct fwctl_uctx - Per user FD context
> + * @fwctl: fwctl instance that owns the context
> + *
> + * Every FD opened by userspace will get a unique context allocation. Any driver
> + * private data will follow immediately after.
> + */
> +struct fwctl_uctx {
> +	struct fwctl_device *fwctl;
> +	/* private: */
> +	/* Head at fwctl_device::uctx_list */
> +	struct list_head uctx_list_entry;
> +};
> +
>  #endif
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> new file mode 100644
> index 00000000000000..f4718a6240f281
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
> + * ioctl is passed a structure pointer as the argument providing the size of
> + * the structure in the first u32. The kernel checks that any structure space
> + * beyond what it understands is 0. This allows userspace to use the backward
> + * compatible portion while consistently using the newer, larger, structures.
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


