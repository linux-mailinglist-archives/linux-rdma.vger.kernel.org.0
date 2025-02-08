Return-Path: <linux-rdma+bounces-7570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A879A2D1E4
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D63F188F075
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3A15C0;
	Sat,  8 Feb 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2/P+Bt9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8624A23;
	Sat,  8 Feb 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738973320; cv=none; b=N66x51xeHdu0iq2jd2IpxgdPucg2DBrbSynSoeb0JaEuHa6pGDRL6e+5pZcCTtgJ6xF+E6br++pt4qsdwJ+C4t0hIE+jJX7uetB3tB3q8qccwX8wK1DfiRx88Dw/nuJAQp5TmTpBAs1sGDGyK9NHqQyQgNY1aUjU4/a0HrneScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738973320; c=relaxed/simple;
	bh=CUrOTwdhAkpu9/t90RdwCXpIFBTgN2oISaf2ABYnLZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWfmL1lmMfTIsZnCGMhINV7nXiDTZfsOWISI459/PIe3usBJl8RT1eKACcPnwvvSNSDvXf7E82J6ubl3juLge5ry8tsVmKgiLlChY/pnIZmI8SVr9YANjrukMhkK5DnCgpcGAhI2dac9awdgJ2sq/3+zCXgXHyJkqrGeDIQJkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2/P+Bt9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738973318; x=1770509318;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CUrOTwdhAkpu9/t90RdwCXpIFBTgN2oISaf2ABYnLZs=;
  b=H2/P+Bt9dzJmHVaZjTouMHmVTz8ZZnRKxItGx0aNk7QPydKRY1/CI2hC
   5BmBSEOcD52ovz7Xb3Ca8yM6OTXWSD9M24Ef9DwbtpjxnI6qKdoW2XOW1
   W1SKwjn9wior7db8R1M0T+3uBl+f2vFUftdmbieUVv5DCaLPAEtvSyTx8
   1qAO3KtEPZPJWClKGH2mCHTuUxuu5Sd+pTz5iXcetH7hRNPDUVE8elwNo
   bZsggj2uKefVoQRwxL2acHpCEq9czVV8hRNm/FFOfJccmqSrHOWIbhFTz
   1h7pmQV8BNNLAHpdwfukvlT3SqKLlMa6os6J4iIvdY2mqH/WkmjH/VYIW
   g==;
X-CSE-ConnectionGUID: kwG0BV1rR3CtBunBkaF+iA==
X-CSE-MsgGUID: e/FFpJlHQe6qO1PGYO8eQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="64983033"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="64983033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:08:37 -0800
X-CSE-ConnectionGUID: jgys5A7uSEWRHEFcOI3MeA==
X-CSE-MsgGUID: iALZ9CDzRrOUnM2Kw9NCHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112095641"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:08:35 -0800
Message-ID: <3bcc562e-fae6-4237-9241-3ed7436ad469@intel.com>
Date: Fri, 7 Feb 2025 17:08:34 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] fwctl: Add basic structure for a class subsystem
 with a cdev
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
References: <1-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  MAINTAINERS            |   8 ++
>  drivers/Kconfig        |   2 +
>  drivers/Makefile       |   1 +
>  drivers/fwctl/Kconfig  |   9 +++
>  drivers/fwctl/Makefile |   4 +
>  drivers/fwctl/main.c   | 170 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/fwctl.h  |  69 +++++++++++++++++
>  7 files changed, 263 insertions(+)
>  create mode 100644 drivers/fwctl/Kconfig
>  create mode 100644 drivers/fwctl/Makefile
>  create mode 100644 drivers/fwctl/main.c
>  create mode 100644 include/linux/fwctl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa06545..ff418a77f39e4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9557,6 +9557,14 @@ F:	kernel/futex/*
>  F:	tools/perf/bench/futex*
>  F:	tools/testing/selftests/futex/
>  
> +FWCTL SUBSYSTEM
> +M:	Jason Gunthorpe <jgg@nvidia.com>
> +M:	Saeed Mahameed <saeedm@nvidia.com>
> +S:	Maintained
> +F:	Documentation/userspace-api/fwctl.rst
> +F:	drivers/fwctl/
> +F:	include/linux/fwctl.h
> +
>  GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>  M:	Sebastian Reichel <sre@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 7bdad836fc6207..7c556c5ac4fddc 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -21,6 +21,8 @@ source "drivers/connector/Kconfig"
>  
>  source "drivers/firmware/Kconfig"
>  
> +source "drivers/fwctl/Kconfig"
> +
>  source "drivers/gnss/Kconfig"
>  
>  source "drivers/mtd/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 45d1c3e630f754..b5749cf67044ce 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -135,6 +135,7 @@ obj-y				+= ufs/
>  obj-$(CONFIG_MEMSTICK)		+= memstick/
>  obj-$(CONFIG_INFINIBAND)	+= infiniband/
>  obj-y				+= firmware/
> +obj-$(CONFIG_FWCTL)		+= fwctl/
>  obj-$(CONFIG_CRYPTO)		+= crypto/
>  obj-$(CONFIG_SUPERH)		+= sh/
>  obj-y				+= clocksource/
> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
> new file mode 100644
> index 00000000000000..37147a695add9a
> --- /dev/null
> +++ b/drivers/fwctl/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig FWCTL
> +	tristate "fwctl device firmware access framework"
> +	help
> +	  fwctl provides a userspace API for restricted access to communicate
> +	  with on-device firmware. The communication channel is intended to
> +	  support a wide range of lockdown compatible device behaviors including
> +	  manipulating device FLASH, debugging, and other activities that don't
> +	  fit neatly into an existing subsystem.
> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
> new file mode 100644
> index 00000000000000..1cad210f6ba580
> --- /dev/null
> +++ b/drivers/fwctl/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_FWCTL) += fwctl.o
> +
> +fwctl-y += main.o
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> new file mode 100644
> index 00000000000000..34946bdc3bf3d7
> --- /dev/null
> +++ b/drivers/fwctl/main.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +#define pr_fmt(fmt) "fwctl: " fmt
> +#include <linux/fwctl.h>
> +
> +#include <linux/container_of.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +enum {
> +	FWCTL_MAX_DEVICES = 4096,
> +};
> +static_assert(FWCTL_MAX_DEVICES < (1U << MINORBITS));
> +
> +static dev_t fwctl_dev;
> +static DEFINE_IDA(fwctl_ida);
> +
> +static int fwctl_fops_open(struct inode *inode, struct file *filp)
> +{
> +	struct fwctl_device *fwctl =
> +		container_of(inode->i_cdev, struct fwctl_device, cdev);
> +
> +	get_device(&fwctl->dev);
> +	filp->private_data = fwctl;
> +	return 0;
> +}
> +
> +static int fwctl_fops_release(struct inode *inode, struct file *filp)
> +{
> +	struct fwctl_device *fwctl = filp->private_data;
> +
> +	fwctl_put(fwctl);
> +	return 0;
> +}
> +
> +static const struct file_operations fwctl_fops = {
> +	.owner = THIS_MODULE,
> +	.open = fwctl_fops_open,
> +	.release = fwctl_fops_release,
> +};
> +
> +static void fwctl_device_release(struct device *device)
> +{
> +	struct fwctl_device *fwctl =
> +		container_of(device, struct fwctl_device, dev);
> +
> +	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
> +	kfree(fwctl);
> +}
> +
> +static char *fwctl_devnode(const struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "fwctl/%s", dev_name(dev));
> +}
> +
> +static struct class fwctl_class = {
> +	.name = "fwctl",
> +	.dev_release = fwctl_device_release,
> +	.devnode = fwctl_devnode,
> +};
> +
> +static struct fwctl_device *
> +_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
> +{
> +	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
> +	int devnum;
> +
> +	if (!fwctl)
> +		return NULL;
> +
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
> +	/*
> +	 * The driver module is protected by fwctl_register/unregister(),
> +	 * unregister won't complete until we are done with the driver's module.
> +	 */
> +	fwctl->cdev.owner = THIS_MODULE;
> +
> +	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))
> +		return NULL;
> +
> +	fwctl->ops = ops;
> +	return_ptr(fwctl);
> +}
> +EXPORT_SYMBOL_NS_GPL(_fwctl_alloc_device, "FWCTL");
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
> +	return cdev_device_add(&fwctl->cdev, &fwctl->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(fwctl_register, "FWCTL");
> +
> +/**
> + * fwctl_unregister - Unregister a device from the subsystem
> + * @fwctl: Previously allocated and registered fwctl_device
> + *
> + * Undoes fwctl_register(). On return no driver ops will be called. The
> + * caller must still call fwctl_put() to free the fwctl.
> + *
> + * The design of fwctl allows this sort of disassociation of the driver from the
> + * subsystem primarily by keeping memory allocations owned by the core subsytem.
> + * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
> + * callback. This allows the module to remain unlocked while FDs are open.
> + */
> +void fwctl_unregister(struct fwctl_device *fwctl)
> +{
> +	cdev_device_del(&fwctl->cdev, &fwctl->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(fwctl_unregister, "FWCTL");
> +
> +static int __init fwctl_init(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&fwctl_dev, 0, FWCTL_MAX_DEVICES, "fwctl");
> +	if (ret)
> +		return ret;
> +
> +	ret = class_register(&fwctl_class);
> +	if (ret)
> +		goto err_chrdev;
> +	return 0;
> +
> +err_chrdev:
> +	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
> +	return ret;
> +}
> +
> +static void __exit fwctl_exit(void)
> +{
> +	class_unregister(&fwctl_class);
> +	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
> +}
> +
> +module_init(fwctl_init);
> +module_exit(fwctl_exit);
> +MODULE_DESCRIPTION("fwctl device firmware access framework");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> new file mode 100644
> index 00000000000000..68ac2d5ab87481
> --- /dev/null
> +++ b/include/linux/fwctl.h
> @@ -0,0 +1,69 @@
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
> + * Each driver instance will have one of these structs with the driver private
> + * data following immediately after. This struct is refcounted, it is freed by
> + * calling fwctl_put().
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
> + * Upon success the pointer must be freed via fwctl_put(). Returns a 'drv_struct
> + * \*' on success, NULL on error.
> + */
> +#define fwctl_alloc_device(parent, ops, drv_struct, member)               \
> +	({                                                                \
> +		static_assert(__same_type(struct fwctl_device,            \
> +					  ((drv_struct *)NULL)->member)); \
> +		static_assert(offsetof(drv_struct, member) == 0);         \
> +		(drv_struct *)_fwctl_alloc_device(parent, ops,            \
> +						  sizeof(drv_struct));    \
> +	})
> +
> +static inline struct fwctl_device *fwctl_get(struct fwctl_device *fwctl)
> +{
> +	get_device(&fwctl->dev);
> +	return fwctl;
> +}
> +static inline void fwctl_put(struct fwctl_device *fwctl)
> +{
> +	put_device(&fwctl->dev);
> +}
> +DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
> +
> +int fwctl_register(struct fwctl_device *fwctl);
> +void fwctl_unregister(struct fwctl_device *fwctl);
> +
> +#endif


