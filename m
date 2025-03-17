Return-Path: <linux-rdma+bounces-8748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90394A6507A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 14:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A4E7A523B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489C239592;
	Mon, 17 Mar 2025 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sANmLoSq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F09221723;
	Mon, 17 Mar 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217462; cv=none; b=Z/brXzs1kWfYt5aSnZYZ/Ur1BKOn0wgO/360P68DbdTww/QFFjWRCyXOXzM2pHagYO5SB4yN9fhrr6vGY3LuvLebdfzSJXB5siC4/h0+UgPuXr1Ol2ouz2uIWmvxhglDNCi8VSW4wf5aQERSqFMuLe6whKkvmhEgNHlNEr0GNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217462; c=relaxed/simple;
	bh=TPKHUiHB8npev+o/UGiouI0z2ofhbOshB8WZo/QHzho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6kpX+dfSTRUP/dCJF1EcDEgrOEnG1yUd6XNsH1VBxpuSi0vO/Hq5mJ0LUnaBky97wtKkFAHv7qnkHdBC/sz8Ny1sOauMqbMRLbmYRC4IUaGZNkRljNSX6lPDSRvocPKSGx+FvRdD5xtKaISlfavsdn3v4GymWdDvvCfALJPXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sANmLoSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D61C4CEE3;
	Mon, 17 Mar 2025 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742217461;
	bh=TPKHUiHB8npev+o/UGiouI0z2ofhbOshB8WZo/QHzho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sANmLoSqJM4QLLMO1IeYa67AZ5wgqu22WjonvrN8VYOUdJi/00OaCt5HCvu1QmcGQ
	 cGvrcmE6QjVz5E0jsS5JcOK1YbcZL3twB4sAHjnS3cITAqb4WcqZIx++MscVyFj0yF
	 ciryUwQRx62o959XR4oPCw7Ju6uRrKlS4JdOgpJg=
Date: Mon, 17 Mar 2025 14:16:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, horms@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, leon@kernel.org, shayd@nvidia.com,
	przemyslaw.kitszel@intel.com, parav@nvidia.com,
	Amir Tzin <amirtz@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
Message-ID: <2025031710-herald-sinner-cbc2@gregkh>
References: <20250317103254.573985-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317103254.573985-1-mbloch@nvidia.com>

On Mon, Mar 17, 2025 at 12:32:54PM +0200, Mark Bloch wrote:
> From: Amir Tzin <amirtz@nvidia.com>
> 
> In case an auxiliary device with IRQs directory is unbinded, the
> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
> This leads to a failure recreating the directory on bind.
> 
> Remove flag auxdev->sysfs.irq_dir_exists, add an API for updating
> managed attributes group and use it to create the IRQs attribute group
> as it does not fail if the group exists. Move initialization of the
> sysfs xarray to auxiliary device probe.

This feels like a lot of different things all tied up into one patch,
why isn't this a series?

> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Why the [net] on the subject line, this is not for the networking
tree...

> ---
>  drivers/base/auxiliary.c       | 20 +++++++++--
>  drivers/base/auxiliary_sysfs.c | 13 +------
>  drivers/base/core.c            | 65 +++++++++++++++++++++++++++-------
>  include/linux/auxiliary_bus.h  |  2 --
>  include/linux/device.h         |  2 ++
>  5 files changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index afa4df4c5a3f..56a487fce053 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -201,6 +201,18 @@ static const struct dev_pm_ops auxiliary_dev_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
>  };
>  
> +static void auxiliary_bus_sysfs_probe(struct auxiliary_device *auxdev)
> +{
> +	mutex_init(&auxdev->sysfs.lock);
> +	xa_init(&auxdev->sysfs.irqs);

You aren't adding anything to sysfs here, so why is this called
auxiliary_bus_sysfs_probe()?  Naming is hard, I know :(

> +}
> +
> +static void auxiliary_bus_sysfs_remove(struct auxiliary_device *auxdev)
> +{
> +	xa_destroy(&auxdev->sysfs.irqs);
> +	mutex_destroy(&auxdev->sysfs.lock);

Same here, you aren't removing anything from sysfs.

> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2835,17 +2835,8 @@ static void devm_attr_group_remove(struct device *dev, void *res)
>  	sysfs_remove_group(&dev->kobj, group);
>  }
>  
> -/**
> - * devm_device_add_group - given a device, create a managed attribute group
> - * @dev:	The device to create the group for
> - * @grp:	The attribute group to create
> - *
> - * This function creates a group for the first time.  It will explicitly
> - * warn and error if any of the attribute files being created already exist.
> - *
> - * Returns 0 on success or error code on failure.
> - */
> -int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
> +static int __devm_device_add_group(struct device *dev, const struct attribute_group *grp,
> +				   bool sysfs_update)
>  {
>  	union device_attr_group_devres *devres;
>  	int error;
> @@ -2855,7 +2846,8 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>  	if (!devres)
>  		return -ENOMEM;
>  
> -	error = sysfs_create_group(&dev->kobj, grp);
> +	error = sysfs_update ? sysfs_update_group(&dev->kobj, grp) :
> +			       sysfs_create_group(&dev->kobj, grp);

Add is really an update?  That feels broken.

>  	if (error) {
>  		devres_free(devres);
>  		return error;
> @@ -2865,8 +2857,57 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>  	devres_add(dev, devres);
>  	return 0;
>  }
> +
> +/**
> + * devm_device_add_group - given a device, create a managed attribute group
> + * @dev:	The device to create the group for
> + * @grp:	The attribute group to create
> + *
> + * This function creates a group for the first time.  It will explicitly
> + * warn and error if any of the attribute files being created already exist.
> + *
> + * Returns 0 on success or error code on failure.
> + */
> +int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
> +{
> +	return __devm_device_add_group(dev, grp, false);
> +}
>  EXPORT_SYMBOL_GPL(devm_device_add_group);
>  
> +static int devm_device_group_match(struct device *dev, void *res, void *grp)
> +{
> +	union device_attr_group_devres *devres = res;
> +
> +	return devres->group == grp;
> +}
> +
> +/**
> + * devm_device_update_group - given a device, update managed attribute group
> + * @dev:	The device to update the group for
> + * @grp:	The attribute group to update
> + *
> + * This function updates a managed attribute group, create it if it does not
> + * exist and converts an unmanaged attributes group into a managed attributes
> + * group. Unlike devm_device_add_group it will explicitly not warn or error if
> + * any of the attribute files being created already exist. Furthermore, if the
> + * visibility of the files has changed through the is_visible() callback, it
> + * will update the permissions and add or remove the relevant files. Changing a
> + * group's name (subdirectory name under kobj's directory in sysfs) is not
> + * allowed.
> + *
> + * Returns 0 on success or error code on failure.
> + */
> +int devm_device_update_group(struct device *dev, const struct attribute_group *grp)
> +{
> +	union device_attr_group_devres *devres;
> +
> +	devres = devres_find(dev, devm_attr_group_remove, devm_device_group_match, (void *)grp);
> +
> +	return devres ? sysfs_update_group(&dev->kobj, grp) :
> +			__devm_device_add_group(dev, grp, true);
> +}
> +EXPORT_SYMBOL_GPL(devm_device_update_group);

Who is now using this new function?  I don't see it here in this patch,
so why is it included here?

> +
>  static int device_add_attrs(struct device *dev)
>  {
>  	const struct class *class = dev->class;
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index 65dd7f154374..d8684cbff54e 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -146,7 +146,6 @@ struct auxiliary_device {
>  	struct {
>  		struct xarray irqs;
>  		struct mutex lock; /* Synchronize irq sysfs creation */
> -		bool irq_dir_exists;
>  	} sysfs;
>  };
>  
> @@ -238,7 +237,6 @@ auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
>  
>  static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
>  {
> -	mutex_destroy(&auxdev->sysfs.lock);
>  	put_device(&auxdev->dev);
>  }
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 80a5b3268986..faec7a3fab68 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1273,6 +1273,8 @@ static inline void device_remove_group(struct device *dev,
>  
>  int __must_check devm_device_add_group(struct device *dev,
>  				       const struct attribute_group *grp);
> +int __must_check devm_device_update_group(struct device *dev,
> +					  const struct attribute_group *grp);

Oh no, please no.  I hate the devm_device_add_group() to start with (and
still think it is wrong and will break people's real use cases), I don't
want to mess with a update group thing as well.

Please fix this up and make this a patch series to make it more obvious
why all of this is needed, and that the change really is fixing a real
problem.  As it is, I can't take this, sorry.

greg k-h

