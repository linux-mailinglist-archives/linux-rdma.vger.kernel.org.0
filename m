Return-Path: <linux-rdma+bounces-2394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DC8C1F90
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 10:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19AD1F21BF5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFC15F41D;
	Fri, 10 May 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZngF10St"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F414901F;
	Fri, 10 May 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328926; cv=none; b=pBTZ4El930sTCdB01hqxDn91dKm6Vs2QD78p1UBdKXViTAS+oVzZQfTkUilsK1H+l+klNdQCcW6vw0GP5hQYjS5ZlVqwWyzxUA9DF4DBNPEQGbg19xGqdp94M8UFQLRJGKbJPZvu2/02jh+WQHimWG4CYikR2yugGlFpt3XbIxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328926; c=relaxed/simple;
	bh=jfrht1k3slQlbQO/XWPTrQUvaVDx9zpVddGp5OuBGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm8QSjLWLaC6KAKOPLD2Pn9IyjnMPV+OpkOYBULOtafiiJZI3RQjwkmOT7ej2NEVSWkERzzDk3FNpAro3IbK2q0RiZWdHJICKRuCSjhzGC/92XBHbERqhpQCD6Rl1CE4db4d2xs+tC4gKShi9XL9F0rF9JcSPfi2VUWQAmQCnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZngF10St; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9911C113CC;
	Fri, 10 May 2024 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715328925;
	bh=jfrht1k3slQlbQO/XWPTrQUvaVDx9zpVddGp5OuBGWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZngF10StLSpHtWsFx+jr3vPPYzz6eUObYob4HFu8P+jYAORLFjiwC9bsBGnmrRNzc
	 x4TfzybgyU4GrlC1xGR84oW88GM48negJ2wFd8kPMWe/UgSTq8ZXCKQJciTE6XHhyI
	 Uawgv15PQk9zu15Btg6NENqIzqvWF5zrhSsErxw4=
Date: Fri, 10 May 2024 09:15:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <2024051056-encrypt-divided-30d2@gregkh>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509091411.627775-2-shayd@nvidia.com>

On Thu, May 09, 2024 at 12:14:10PM +0300, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus.

"Some PCI subfunctions can be on the auxiliary bus"

Or maybe "Sometimes the auxiliary bus interface is used for PCI
subfunctions."

Either way, the text here as-is is not correct as that is not how the
auxbus code is always used, sorry.

> PCI physical
> and virtual functions are anchored on the PCI bus;  the irq information

Odd use of ';'?  And an extra ' '?

> of each such function is visible to users via sysfs directory "msi_irqs"
> containing file for each irq entry. However, for PCI SFs such information
> is unavailable. Due to this users have no visibility on IRQs used by the
> SFs.

Not even in /proc/irq/ ?

> Secondly, an SF is a multi function device supporting rdma, netdevice

Not "is", it should be "can be"  Not all the world is your crazy
hardware :)

> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.

How would affinity be relevent here?  You are just allowing them to be
viewed, not set.

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
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v3->4:
> - remove global mutex (Przemek)
> v2->v3:
> - fix function declaration in case SYSFS isn't defined (Parav)
> - convert auxdev->groups array with auxiliary_irqs_groups (Przemek)
> v1->v2:
> - move #ifdefs from drivers/base/auxiliary.c to
>   include/linux/auxiliary_bus.h (Greg)
> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
> - Fix auxiliary_irq_mode_show doc (kernel test boot)
> ---
>  Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>  drivers/base/auxiliary.c                      | 178 +++++++++++++++++-
>  include/linux/auxiliary_bus.h                 |  24 ++-
>  3 files changed, 213 insertions(+), 3 deletions(-)
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

So this can be msi irqs?  Or not msi irqs?  How do we know?


> +
> +What:		/sys/bus/auxiliary/devices/.../irqs/<N>
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		auxiliary devices can share IRQs. This attribute indicates if
> +		the irq is shared with other SFs or exclusively used by the SF.
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..def02f5f1220 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -158,6 +158,176 @@
>   *	};
>   */
>  
> +#ifdef CONFIG_SYSFS
> +/* Xarray of irqs to determine if irq is exclusive or shared. */
> +static DEFINE_XARRAY(irqs);
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
> +static const struct attribute_group *auxiliary_irqs_groups[2] = {

Why list the array size?

> +	&auxiliary_irqs_group,
> +	NULL
> +};
> +
> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
> + * shared or exclusive.
> + */
> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct auxiliary_irq_info *info =
> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> +
> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)

refcount combined with xa?  That feels wrong, why is refcount used for
this at all?

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
> +	refcount_t *new_ref = kzalloc(sizeof(*new_ref), GFP_KERNEL);
> +	refcount_t *ref;
> +	int ret = 0;
> +
> +	if (!new_ref)
> +		return -ENOMEM;
> +
> +	xa_lock(&irqs);
> +	ref = xa_load(&irqs, irq);
> +	if (ref) {
> +		kfree(new_ref);
> +		refcount_inc(ref);

Why do you need to use refcounts for these?  What does that help out
with?

> +		goto out;
> +	}
> +
> +	refcount_set(new_ref, 1);
> +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
> +	if (ref) {
> +		kfree(new_ref);
> +		if (xa_is_err(ref)) {
> +			ret = xa_err(ref);
> +			goto out;
> +		}
> +
> +		/* Another thread beat us to creating the enrtry. */
> +		refcount_inc(ref);

How can that happen?  Why not just use a normal simple lock for all of
this so you don't have to mess with refcounts at all?  This is not
performance-relevent code at all, but yet with a refcount you cause
almost the same issues that a normal lock would have, plus the increased
complexity of all of the surrounding code (like this, and the crazy
__xa_cmpxchg() call)

Make this simple please.


> +	}
> +
> +out:
> +	xa_unlock(&irqs);
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
> + *
> + * Return: zero on success or an error code on failure.
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

Adding dynamic sysfs attributes like this means that you normally just
raced with userspace and lost.  How are you ensuring that you did not
just do that?

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

How can this ever happen?  If not, don't check for it please.  If it can
happen, properly handle it and move on, don't reboot the box.

thanks,

greg k-h

