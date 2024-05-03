Return-Path: <linux-rdma+bounces-2232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DB8BA67D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 07:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F140282577
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 05:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC05139CE2;
	Fri,  3 May 2024 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xlMcJP4h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EEEEDD;
	Fri,  3 May 2024 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713015; cv=none; b=UeSavgt9JR2T49YWroWqolLBT8CS+EItqAxOfrSoU6YRBDJqIkkrTbimmceXOy/dqRggB3qthAKamE7svS9ecvEXcoIx9swJO4Y4lus5sKFH4eBPW0VRmLKs8AumXHIxDOL6v5d6sWzzxHKZbZPOB79VRZ2rT+f+qpQx/jE9SFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713015; c=relaxed/simple;
	bh=o2sKVmvdDaNF3kLVWCaEK4/IGPiq1aU+SjHjWzCNIuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOYtLht+KJ2LtoOwpgEXPVf4Yr2p4kSYF209WD3KFux7JDBShPRcuw2JNFVQIK6RsenMKJn0NwXHCOjlxTZ1WSWPN3EiNQb2HZPvT04Cv7+fb/oYMueStPWdl/9U0paNkchcXdmzXz8+OO5Lwj6Cyq5o0JFli/IU0Iooal6coVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xlMcJP4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39741C116B1;
	Fri,  3 May 2024 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714713014;
	bh=o2sKVmvdDaNF3kLVWCaEK4/IGPiq1aU+SjHjWzCNIuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xlMcJP4hF98Bx4M63beIxyzqtqJPFtYREDPBrKpuXPLSVXAXm7fUinLf2wTOJegEG
	 IHikNMt4iujwoWGsitP5X5gPy5MYt7uZFLIoX0OfarLNWR+Qj6fAy4nXHcnPqjK4F+
	 /Sd1T/+1KR2sS/XDmJ4xt8dv5N1knS2epVD8ak9k=
Date: Fri, 3 May 2024 07:10:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 1/2] driver core: auxiliary bus: show auxiliary device
 IRQs
Message-ID: <2024050313-next-fried-4360@gregkh>
References: <20240503043104.381938-1-shayd@nvidia.com>
 <20240503043104.381938-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503043104.381938-2-shayd@nvidia.com>

On Fri, May 03, 2024 at 07:31:03AM +0300, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus;  the irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing file for each irq entry. However, for PCI SFs such information
> is unavailable. Due to this users have no visibility on IRQs used by the
> SFs.
> Secondly, an SF is a multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
> information is also not available to the users. To overcome this
> limitation, each irq sysfs entry shows if irq is exclusive or shared.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
> exclusive

Not all the world (i.e. not all auxbus users) are PCI devices, right?
So what happens for non-PCI devices?

> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>  drivers/base/auxiliary.c                      | 170 +++++++++++++++++-
>  include/linux/auxiliary_bus.h                 |  15 +-
>  3 files changed, 196 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
> new file mode 100644
> index 000000000000..3b8299d49d9e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
> @@ -0,0 +1,14 @@
> +What:		/sys/bus/auxiliary/devices/.../irqs/
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		The /sys/devices/.../irqs directory contains a variable set of
> +		files, with each file is named as irq number similar to PCI PF
> +		or VF's irq number located in msi_irqs directory.
> +
> +What:		/sys/bus/auxiliary/devices/.../irqs/<N>
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		auxiliary devices can share IRQs. This attribute indicates if
> +		the irq is shared with other SFs or exclusively used by the SF.
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..5c0efa2081b8 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -158,6 +158,167 @@
>   *	};
>   */
>  
> +#ifdef CONFIG_SYSFS
> +/* Xarray of irqs to determine if irq is exclusive or shared. */
> +static DEFINE_XARRAY(irqs);
> +/* Protects insertions into the irtqs xarray. */
> +static DEFINE_MUTEX(irqs_lock);
> +
> +struct auxiliary_irq_info {
> +	struct device_attribute sysfs_attr;
> +	int irq;
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
> +/**
> + * Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
> + * shared or exclusive.
> + */
> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct auxiliary_irq_info *info =
> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> +
> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> +		return sysfs_emit(buf, "%s\n", "shared");
> +	else
> +		return sysfs_emit(buf, "%s\n", "exclusive");
> +}
> +
> +static void auxiliary_irq_destroy(int irq)
> +{
> +	refcount_t *ref;
> +
> +	xa_lock(&irqs);
> +	ref = xa_load(&irqs, irq);
> +	if (refcount_dec_and_test(ref)) {
> +		__xa_erase(&irqs, irq);
> +		kfree(ref);
> +	}
> +	xa_unlock(&irqs);
> +}
> +
> +static int auxiliary_irq_create(int irq)
> +{
> +	refcount_t *ref;
> +	int ret = 0;
> +
> +	mutex_lock(&irqs_lock);
> +	ref = xa_load(&irqs, irq);
> +	if (ref && refcount_inc_not_zero(ref))
> +		goto out;
> +
> +	ref = kzalloc(sizeof(ref), GFP_KERNEL);
> +	if (!ref) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	refcount_set(ref, 1);
> +	ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);
> +	if (ret)
> +		kfree(ref);
> +
> +out:
> +	mutex_unlock(&irqs_lock);
> +	return ret;
> +}
> +
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated Linux interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.
> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct auxiliary_irq_info *info;
> +	int ret;
> +
> +	ret = auxiliary_irq_create(irq);
> +	if (ret)
> +		return ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto info_err;
> +	}
> +
> +	sysfs_attr_init(&info->sysfs_attr.attr);
> +	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
> +	if (!info->sysfs_attr.attr.name) {
> +		ret = -ENOMEM;
> +		goto name_err;
> +	}
> +	info->irq = irq;
> +	info->sysfs_attr.attr.mode = 0444;
> +	info->sysfs_attr.show = auxiliary_irq_mode_show;
> +
> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> +	if (ret)
> +		goto auxdev_xa_err;
> +
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);
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
> +info_err:
> +	auxiliary_irq_destroy(irq);
> +	return ret;
> +}
> +EXPORT_SYMBOL(auxiliary_device_sysfs_irq_add);
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
> +	if (WARN_ON(!info))
> +		return;
> +
> +	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
> +				     auxiliary_irqs_group.name);
> +	xa_erase(&auxdev->irqs, irq);
> +	kfree(info->sysfs_attr.attr.name);
> +	kfree(info);
> +	auxiliary_irq_destroy(irq);
> +}
> +EXPORT_SYMBOL(auxiliary_device_sysfs_irq_remove);

Any reason this isn't EXPORT_SYMBOL_GPL() like the rest of this file?
Same for the other export.

> +#else /* CONFIG_SYSFS */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq) {return 0; }
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
> +#endif

Shouldn't the #ifdef stuff be in a .h file?  Why .c?

And again, why do you think that all aux devices have irqs?

thanks,

greg k-h

