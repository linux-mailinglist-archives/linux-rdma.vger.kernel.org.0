Return-Path: <linux-rdma+bounces-3281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E590D8DC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246821F26635
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F885588F;
	Tue, 18 Jun 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nwyVp0VM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA7524C4;
	Tue, 18 Jun 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727222; cv=none; b=H5GH9vWLUSjXbsJtnHWBDzEuhtOm8Lqi0Sy3E+P/lR1Y09M/jYBUWUvGO3BGztX7zqEmAxKQssZ1AbiBDxLUW9xuvdUNlmOTp9vQrMIuCwjFFXDwaf6Zw29gwY6mv8svHotjzu4jY64GMnMGFuVwjeakp/XiVUwdLEDxH3Yvyig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727222; c=relaxed/simple;
	bh=K+ZgJRFtcOw1rvXzvtOs8fHZi5JIhFJypsiDrxlBV/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK3YE5Ch5zN+fsgRB8T1zB4zvA8/cpN/WbRttKfyWYO4JHrGNFvCOW7Z0Vn4WSQl5h8HTdVdIA68nG+m7sHPYOrzoGDCNP+T7PizHvnPxEFab5YfR+J0cVwCrkKQlwuAAQYFuLPks8LSmKm2b3+PX6fu3xgzWyLMqOR6PNpiP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nwyVp0VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F7CC3277B;
	Tue, 18 Jun 2024 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718727222;
	bh=K+ZgJRFtcOw1rvXzvtOs8fHZi5JIhFJypsiDrxlBV/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nwyVp0VMfXCZrdbsz9rtAx8aZBePsTR9hUjLpC/vvhU8Ehl49q+E6vTHibV5ZtK2u
	 m0HyFPErmMnCPJb1qD+lXGF1wVKPM5hYh34Jptb2ecD4oODfd10HZ4YBxKv27goA1/
	 pw7aHIiTE1A2F5orTYA0GTaUHhEKWtBnhnLGdbDE=
Date: Tue, 18 Jun 2024 18:13:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v7 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024061849-cupped-throwback-4fee@gregkh>
References: <20240618150902.345881-1-shayd@nvidia.com>
 <20240618150902.345881-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618150902.345881-2-shayd@nvidia.com>

On Tue, Jun 18, 2024 at 06:09:01PM +0300, Shay Drory wrote:
> diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
> new file mode 100644
> index 000000000000..3f112fd26e72
> --- /dev/null
> +++ b/drivers/base/auxiliary_sysfs.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/slab.h>
> +
> +struct auxiliary_irq_info {
> +	struct device_attribute sysfs_attr;
> +};
> +
> +static struct attribute *auxiliary_irq_attrs[] = {
> +	NULL
> +};
> +
> +static const struct attribute_group auxiliary_irqs_group = {
> +	.name = "irqs",
> +	.attrs = auxiliary_irq_attrs,
> +};
> +
> +static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&auxdev->lock);
> +	if (auxdev->dir_exists)
> +		goto unlock;

You do know about cleanup.h, right?  Please use it.

But what exactly are you trying to protect here?  How will you race and
add two irqs at the same time?  Driver probe is always single threaded,
so what would be calling this at the same time from multiple places?


> +
> +	xa_init(&auxdev->irqs);
> +	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
> +	if (!ret)
> +		auxdev->dir_exists = 1;
> +
> +unlock:
> +	mutex_unlock(&auxdev->lock);
> +	return ret;
> +}
> +
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct auxiliary_irq_info *info;
> +	int ret;
> +
> +	ret = auxiliary_irq_dir_prepare(auxdev);
> +	if (ret)
> +		return ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	sysfs_attr_init(&info->sysfs_attr.attr);
> +	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
> +	if (!info->sysfs_attr.attr.name) {
> +		ret = -ENOMEM;
> +		goto name_err;
> +	}
> +
> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);

So no lock happening here, either use it always, or not at all?


> +	if (ret)
> +		goto auxdev_xa_err;
> +
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);

You do know that you are never going to see these files from the
userspace library tools that watch sysfs, right?  libudev will never see
them as you are adding them AFTER the device is created.

So, because of that, who is really going to use these files?


> +	if (ret)
> +		goto sysfs_add_err;
> +
> +	return 0;
> +
> +sysfs_add_err:
> +	xa_erase(&auxdev->irqs, irq);
> +auxdev_xa_err:
> +	kfree(info->sysfs_attr.attr.name);
> +name_err:
> +	kfree(info);

Again, cleanup.h is your friend.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
> +
> +/**
> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: the IRQ to remove.
> + *
> + * This function should be called to remove an IRQ sysfs entry.
> + */
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
> +	struct device *dev = &auxdev->dev;
> +
> +	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
> +				     auxiliary_irqs_group.name);
> +	xa_erase(&auxdev->irqs, irq);
> +	kfree(info->sysfs_attr.attr.name);
> +	kfree(info);
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index de21d9d24a95..96be140bd1ff 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,7 @@
>   *       in
>   * @name: Match name found by the auxiliary device driver,
>   * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,
>   *
>   * An auxiliary_device represents a part of its parent device's functionality.
>   * It is given a name that, combined with the registering drivers
> @@ -138,7 +139,10 @@
>  struct auxiliary_device {
>  	struct device dev;
>  	const char *name;
> +	struct xarray irqs;
> +	struct mutex lock; /* Protects "irqs" directory creation */

Protects it from what?


>  	u32 id;
> +	u8 dir_exists:1;

I don't think this is needed, but if it really is, just use a bool.


>  };
>  
>  /**
> @@ -212,8 +216,24 @@ int auxiliary_device_init(struct auxiliary_device *auxdev);
>  int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
>  #define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
>  
> +#ifdef CONFIG_SYSFS
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
> +				       int irq);

You can use longer lines :)

thanks,

greg k-h

