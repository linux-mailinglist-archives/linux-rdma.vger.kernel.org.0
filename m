Return-Path: <linux-rdma+bounces-4017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C093D522
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 16:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534AA2850E5
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD514A82;
	Fri, 26 Jul 2024 14:30:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D32125DE;
	Fri, 26 Jul 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004249; cv=none; b=J1NmYixnl1MS3Gfa9j0ml0WN7KYgD1voTFOxuw8nbcKDpv88GlImGzUkr/qFDcK8BruIs8C0NGd0SLQh5JuDOvE8qULuJ30MsopLOAINtftkmVw0X7kbTkxY/Tf6tS8Qyd2fUx5+MBNm4gX/OVXmuRThAw3wrHZbg016sav26/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004249; c=relaxed/simple;
	bh=hOesA2QWedcPj35Rmx+Hknb/KLR2+krxr/tfRQkK0IM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnLG9ThYCEGrjE0u9p/34X20nvja0eW4tKc+/caUQIymlF/pA8GTjNMIlbetDeTCCuc3BcbO2Mv0NGuGURdN+wWEjHPGY0JzDxA8wmHIhQjA04Epr/LTZehlcclL26WMAJyJrRqfkfSlPr0lOpM8xiMc0hAZgKuWapIyL9P4E/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVqqN5K68z6K7JW;
	Fri, 26 Jul 2024 22:28:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E1C4140D27;
	Fri, 26 Jul 2024 22:30:44 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 15:30:43 +0100
Date: Fri, 26 Jul 2024 15:30:42 +0100
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
Subject: Re: [PATCH v2 1/8] fwctl: Add basic structure for a class subsystem
 with a cdev
Message-ID: <20240726153042.00002749@Huawei.com>
In-Reply-To: <1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
	<1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 19:47:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Create the class, character device and functions for a fwctl driver to
> un/register to the subsystem.
> 
> A typical fwctl driver has a sysfs presence like:
> 
> $ ls -l /dev/fwctl/fwctl0
> crw------- 1 root root 250, 0 Apr 25 19:16 /dev/fwctl/fwctl0
> 
> $ ls /sys/class/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> $ ls /sys/class/fwctl/fwctl0/device/infiniband/
> ibp0s10f0
> 
> $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
> fwctl0/
> 
> $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
> dev  device  power  subsystem  uevent
> 
> Which allows userspace to link all the multi-subsystem driver components
> together and learn the subsystem specific names for the device's
> components.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Hi Jason,

Mostly looking at this to get my head around what the details are,
but whilst I'm reading might as well offer some review comments.

I'm not a fan of too many mini patches as it makes it harder
to review rather than easier, but meh, I know others prefer
it this way.  If you are going to do it though, comments
need to be carefully tracking what they are talking about.

Jonathan



...

> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> new file mode 100644
> index 00000000000000..6e9bf15c743b5c
> --- /dev/null
> +++ b/drivers/fwctl/main.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +#define pr_fmt(fmt) "fwctl: " fmt
> +#include <linux/fwctl.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/container_of.h>
> +#include <linux/fs.h>

Trivial: Pick an ordering scheme perhaps as then we know where you'd
like new headers to be added.

> +
> +enum {
> +	FWCTL_MAX_DEVICES = 256,
> +};
> +static dev_t fwctl_dev;
> +static DEFINE_IDA(fwctl_ida);


> +static struct fwctl_device *
> +_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> +{
> +	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> +	int devnum;
> +
> +	if (!fwctl)
> +		return NULL;

I'd put a blank line here.

> +	fwctl->dev.class = &fwctl_class;
> +	fwctl->dev.parent = parent;
> +
> +	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
> +	if (devnum < 0)
> +		return NULL;
> +	fwctl->dev.devt = fwctl_dev + devnum;
> +
> +	device_initialize(&fwctl->dev);
> +	return_ptr(fwctl);
> +}
> +
> +/* Drivers use the fwctl_alloc_device() wrapper */
> +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> +					 const struct fwctl_ops *ops,
> +					 size_t size)
> +{
> +	struct fwctl_device *fwctl __free(fwctl) =
> +		_alloc_device(parent, ops, size);
> +
> +	if (!fwctl)
> +		return NULL;
> +
> +	cdev_init(&fwctl->cdev, &fwctl_fops);
> +	fwctl->cdev.owner = THIS_MODULE;

Owned by fwctl core, not the parent driver?  Perhaps a comment on why.
I guess related to the lifetime being independent of parent driver.

> +
> +	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))
> +		return NULL;
> +
> +	fwctl->ops = ops;
> +	return_ptr(fwctl);
> +}
> +EXPORT_SYMBOL_NS_GPL(_fwctl_alloc_device, FWCTL);
> +
> +/**
> + * fwctl_register - Register a new device to the subsystem
> + * @fwctl: Previously allocated fwctl_device
> + *
> + * On return the device is visible through sysfs and /dev, driver ops may be
> + * called.
> + */
> +int fwctl_register(struct fwctl_device *fwctl)
> +{
> +	int ret;
> +
> +	ret = cdev_device_add(&fwctl->cdev, &fwctl->dev);
> +	if (ret)
> +		return ret;
> +	return 0;

Doesn't look like this ever gets more complex so 

	return cdev_device_add(...)

If you expect to see more here in near future maybe fair enough
to keep the handling as is.


> +}
> +EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
> +
> +/**
> + * fwctl_unregister - Unregister a device from the subsystem
> + * @fwctl: Previously allocated and registered fwctl_device
> + *
> + * Undoes fwctl_register(). On return no driver ops will be called. The
> + * caller must still call fwctl_put() to free the fwctl.
> + *
> + * Unregister will return even if userspace still has file descriptors open.
> + * This will call ops->close_uctx() on any open FDs and after return no driver
> + * op will be called. The FDs remain open but all fops will return -ENODEV.

Perhaps bring the docs in with the support?  I got (briefly) confused
by the lack of a path to close_uctx() in here.

> + *
> + * The design of fwctl allows this sort of disassociation of the driver from the
> + * subsystem primarily by keeping memory allocations owned by the core subsytem.
> + * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
> + * callback. This allows the module to remain unlocked while FDs are open.
> + */
> +void fwctl_unregister(struct fwctl_device *fwctl)
> +{
> +	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> +
> +	/*
> +	 * The driver module may unload after this returns, the op pointer will
> +	 * not be valid.
> +	 */
> +	fwctl->ops = NULL;
I'd bring that in with the logic doing close_uctx() etc as then it will align
with the comments that I'd also suggest only adding there (patch 2 I think).

> +}
> +EXPORT_SYMBOL_NS_GPL(fwctl_unregister, FWCTL);
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> new file mode 100644
> index 00000000000000..ef4eaa87c945e4
> --- /dev/null
> +++ b/include/linux/fwctl.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __LINUX_FWCTL_H
> +#define __LINUX_FWCTL_H
> +#include <linux/device.h>
> +#include <linux/cdev.h>
> +#include <linux/cleanup.h>
> +
> +struct fwctl_device;
> +struct fwctl_uctx;
> +
> +struct fwctl_ops {
> +};
> +
> +/**
> + * struct fwctl_device - Per-driver registration struct
> + * @dev: The sysfs (class/fwctl/fwctlXX) device
> + *
> + * Each driver instance will have one of these structs with the driver
> + * private data following immeidately after. This struct is refcounted,

immediately

> + * it is freed by calling fwctl_put().
> + */
> +struct fwctl_device {
> +	struct device dev;
> +	/* private: */
> +	struct cdev cdev;
> +	const struct fwctl_ops *ops;
> +};
> +
> +struct fwctl_device *_fwctl_alloc_device(struct device *parent,
> +					 const struct fwctl_ops *ops,
> +					 size_t size);
> +/**
> + * fwctl_alloc_device - Allocate a fwctl
> + * @parent: Physical device that provides the FW interface
> + * @ops: Driver ops to register
> + * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
> + * @member: Name of the struct fwctl_device in @drv_struct
> + *
> + * This allocates and initializes the fwctl_device embedded in the drv_struct.
> + * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
> + * failure. Returns a 'drv_struct *' on success, NULL on error.
> + */
> +#define fwctl_alloc_device(parent, ops, drv_struct, member)                  \
> +	container_of(_fwctl_alloc_device(                                    \
> +			     parent, ops,                                    \
> +			     sizeof(drv_struct) +                            \
> +				     BUILD_BUG_ON_ZERO(                      \
> +					     offsetof(drv_struct, member))), \
Doesn't that fire a build_bug when the member is at the start of drv_struct?
Or do I have that backwards?

Does container_of() safely handle a NULL?  
I'm staring at the definition and can't spot code to do that in 6.10

> +		     drv_struct, member)
> +



