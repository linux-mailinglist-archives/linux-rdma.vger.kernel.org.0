Return-Path: <linux-rdma+bounces-3124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A14907855
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9951F230FA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EBD1448ED;
	Thu, 13 Jun 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbXLaVek"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275571420BC;
	Thu, 13 Jun 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296388; cv=none; b=LNWSapNjJX1D6e7Tp4+OVsPhMyKqHgHoKMvGFy6vNMYVhbychzFHWFmQLqOrfC4a+W/aRrTsrHx/zQf1BZSA74oBTNhfZoeUMdv7uiBgHOHLpdA6KPk8JFQ+OrlRtxMLQAUyHwiUS6jygOrhOKVEEN6ry18574UadYKxVM52oR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296388; c=relaxed/simple;
	bh=nm9cGc6+xh1I4luo8QBmay1xiRcXxldE8e4qrHpjJy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW/aRQd750GC48U00hoyggPKD49HJC6rXaf3uaFGnUTn1FSV96HrpqPSiRHEY2C82vtlfEqZrIlcWyF3Z5w/NKwbDxWqwsU5OI3+y6kE0Yd1DK362HrSYO99yliRZJOLFcTK03o/3GQB6CdOVsIQGEAs7+2/Z0yn9oEctV+lLI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbXLaVek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30197C2BBFC;
	Thu, 13 Jun 2024 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718296387;
	bh=nm9cGc6+xh1I4luo8QBmay1xiRcXxldE8e4qrHpjJy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbXLaVekOEvMok40AsBYllC8PrBd5cN+XoU9vWiEEiR/bu5s8MIKQc8ruxC/MvX3B
	 sheBGRMmiho9euZ3PHsxHdT+imsr6923G7h861+4aC0G0LB4PHgWDz42Bgej5q6Z1y
	 ppanmx5sMa92N81TNDbaOjGomtWE9UhU/F1h/CuQ=
Date: Thu, 13 Jun 2024 18:33:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v6 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024061306-from-equal-e2fc@gregkh>
References: <20240613161912.300785-1-shayd@nvidia.com>
 <20240613161912.300785-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613161912.300785-2-shayd@nvidia.com>

On Thu, Jun 13, 2024 at 07:19:11PM +0300, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus. The irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing files for each irq entry. However, for PCI SFs such
> information is unavailable. Due to this users have no visibility on IRQs
> used by the SFs.
> Secondly, an SF can be multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v5-v6:
> - removed concept of shared and exclusive and hence global xarray (Greg)
> v4-v5:
> - restore global mutex and replace refcount_t with simple integer (Greg)
> v3->4:
> - remove global mutex (Przemek)
> v2->v3:
> - fix function declaration in case SYSFS isn't defined
> v1->v2:
> - move #ifdefs from drivers/base/auxiliary.c to
>   include/linux/auxiliary_bus.h (Greg)
> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
> - Fix auxiliary_irq_mode_show doc (kernel test boot)
> ---
>  Documentation/ABI/testing/sysfs-bus-auxiliary |  7 ++
>  drivers/base/auxiliary.c                      | 96 ++++++++++++++++++-
>  include/linux/auxiliary_bus.h                 | 24 ++++-
>  3 files changed, 124 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
> new file mode 100644
> index 000000000000..e8752c2354bc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/auxiliary/devices/.../irqs/
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		The /sys/devices/.../irqs directory contains a variable set of
> +		files, with each file is named as irq number similar to PCI PF
> +		or VF's irq number located in msi_irqs directory.
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..fcd7dbf20f88 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -158,6 +158,94 @@
>   *	};
>   */
>  
> +#ifdef CONFIG_SYSFS

People really build boxes without sysfs?  Ok :(

But if so, why not move this to a whole new file?  That would make it
simpler to maintain.

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
> +static const struct attribute_group *auxiliary_irqs_groups[] = {
> +	&auxiliary_irqs_group,
> +	NULL
> +};
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
> +	if (ret)
> +		goto auxdev_xa_err;
> +
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);

Dynamic attributes are rough, because:


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

What is forcing you to remove the irqs after a device is removed from
the system?

Why not just remove them all automatically?  Why would you ever want to
remove them after they were added, will they ever actually change over
the lifespan of a device?

>  int auxiliary_device_init(struct auxiliary_device *auxdev);
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable);
> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME, false)
> +#define auxiliary_device_add_with_irqs(auxdev) \
> +	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)

Ick, no, that way lies madness.

Just keep the original function:
	auxiliary_device_add()
as is.

Then, if someone DOES call auxiliary_device_sysfs_irq_add() then add the
irq directory and file as needed then.

That way no "norml" paths are messed up and over time, we don't keep
having an explosion of combinations of function calls to create an aux
device (as we all know, this is NOT going to be the last feature ever
added to them...)

thanks,

greg k-h

