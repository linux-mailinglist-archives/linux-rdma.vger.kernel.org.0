Return-Path: <linux-rdma+bounces-8499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA45A57DBD
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 20:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B236189164B
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD21E51E5;
	Sat,  8 Mar 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUH/Ze+p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469D148857
	for <linux-rdma@vger.kernel.org>; Sat,  8 Mar 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741461716; cv=none; b=rWyywKRneHzbQD1OH0bu1aE673D/RzncxPeBE3JA9alJPtZZN4tqo1UwQm/bci43DqETNUx+c5BAiQGlVrI1rn3yQI8HQeCfbbke0LEwg1laJazWfsdnFfPIh9Nlpl+ev32fMhhtZv3kuIiC3IsPwHXOWlM0Y+hTXLS0uUICK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741461716; c=relaxed/simple;
	bh=Z2o84R0dNOHCfbQpUhqk6FN9D0Vfp5R48F5IQGIvu2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWB04vnXTvXZLr7fDk6dHVqoAuoB7ExALsbFlbcUiDKFwFepz/Z6zt7hTRnqvqvxPaJFwXPEAdfdMjMYkebxkB8wz0yMTOr+wfMuJazpSc/PMvpnYCAn6kH7lLThiUWA/WSI19jeKWx/+QxjGgwuh0M83JLWk9s/dHYEZeNThJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUH/Ze+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734EAC4CEE0;
	Sat,  8 Mar 2025 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741461716;
	bh=Z2o84R0dNOHCfbQpUhqk6FN9D0Vfp5R48F5IQGIvu2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUH/Ze+pNvo2YEbO1+Qqov4CnUSVKj0ryWwX8k5+4l4NXXfjEutwouHF97zsjcyj3
	 mFXjtv2U7TinsVAX9wQSBhEThg7Ffv9rirFpvmySDQXFdI8sIfA9SJGXp4aPY4M9Qy
	 ziH1MB83Y/ZBHggGNJ2lpZvOWtfuFbea7Bka7EwpjKACbkjv16ktV+ZT8CIj+QvVue
	 CAOiez2dlEFd3WssGREWJOWIAX0TLuf+vd7PW+BsQmubLVPJXseqIr/yLCbAhQ9slo
	 cY0TnR8JRpecb79S6El0RZro4kjlxWhfIFzCAhfl9rveb/yUBJSpoL0OMJlyAohvnU
	 2+OS/9ODpbNmA==
Date: Sat, 8 Mar 2025 21:21:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v1 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
Message-ID: <20250308192151.GW1955273@unreal>
References: <cover.1741261611.git.leon@kernel.org>
 <5a1379187cd21178e8554afc81a3c941f21af22f.1741261611.git.leon@kernel.org>
 <42bdf595-4b4d-475f-9dcf-13176bdaa1ea@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42bdf595-4b4d-475f-9dcf-13176bdaa1ea@linux.dev>

On Sat, Mar 08, 2025 at 08:25:55AM +0100, Zhu Yanjun wrote:
> 在 2025/3/6 12:51, Leon Romanovsky 写道:
> > From: Chiara Meiohas <cmeiohas@nvidia.com>
> > 
> > Implement a new User CAPabilities (UCAP) API to provide fine-grained
> > control over specific firmware features.
> > 
> > This approach offers more granular capabilities than the existing Linux
> > capabilities, which may be too generic for certain FW features.
> > 
> > This mechanism represents each capability as a character device with
> > root read-write access. Root processes can grant users special
> > privileges by allowing access to these character devices (e.g., using
> > chown).
> 
> Hi, Chiara
> 
> I read this patch-set carefully. If I get this patch-set correctly, this
> patch-set introduces a new User CAPabilities API to control specific
> firmware feature.
> Do we have a user guide to use this UCAP? For example, we suspect that a
> Firmware problem will occur in production environment, how can we use this
> UCAP to debug this Firmware problem?

It is not helpful for debugging FW as these capabilities are needed when
you are opening ucontext. Your FW shouldn't get an access from one ucontext
access to others.

These UCAPs are used when administrator wants to control specific FW feature
by separating between userA(containerA) and userB(containerB), which are running
on same machine with same FW.

The better debug interface is provided by FWCTL, use it:
https://lore.kernel.org/linux-rdma/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/

Thanks

> 
> Thanks.
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Zhu Yanjun
> 
> > 
> > UCAP character devices are located in /dev/infiniband and the class path
> > is /sys/class/infiniband_ucaps.
> > 
> > Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> > ---
> >   drivers/infiniband/core/Makefile      |   3 +-
> >   drivers/infiniband/core/ucaps.c       | 267 ++++++++++++++++++++++++++
> >   drivers/infiniband/core/uverbs_main.c |   2 +
> >   include/rdma/ib_ucaps.h               |  25 +++
> >   4 files changed, 296 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/infiniband/core/ucaps.c
> >   create mode 100644 include/rdma/ib_ucaps.h
> > 
> > diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> > index 8ab4eea5a0a5..d49ded7e95f0 100644
> > --- a/drivers/infiniband/core/Makefile
> > +++ b/drivers/infiniband/core/Makefile
> > @@ -39,6 +39,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
> >   				uverbs_std_types_async_fd.o \
> >   				uverbs_std_types_srq.o \
> >   				uverbs_std_types_wq.o \
> > -				uverbs_std_types_qp.o
> > +				uverbs_std_types_qp.o \
> > +				ucaps.o
> >   ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
> >   ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
> > diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
> > new file mode 100644
> > index 000000000000..6853c6d078f9
> > --- /dev/null
> > +++ b/drivers/infiniband/core/ucaps.c
> > @@ -0,0 +1,267 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > +/*
> > + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> > + */
> > +
> > +#include <linux/kref.h>
> > +#include <linux/cdev.h>
> > +#include <linux/mutex.h>
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > +#include <rdma/ib_ucaps.h>
> > +
> > +#define RDMA_UCAP_FIRST RDMA_UCAP_MLX5_CTRL_LOCAL
> > +
> > +static DEFINE_MUTEX(ucaps_mutex);
> > +static struct ib_ucap *ucaps_list[RDMA_UCAP_MAX];
> > +static bool ucaps_class_is_registered;
> > +static dev_t ucaps_base_dev;
> > +
> > +struct ib_ucap {
> > +	struct cdev cdev;
> > +	struct device dev;
> > +	struct kref ref;
> > +};
> > +
> > +static const char *ucap_names[RDMA_UCAP_MAX] = {
> > +	[RDMA_UCAP_MLX5_CTRL_LOCAL] = "mlx5_perm_ctrl_local",
> > +	[RDMA_UCAP_MLX5_CTRL_OTHER_VHCA] = "mlx5_perm_ctrl_other_vhca"
> > +};
> > +
> > +static char *ucaps_devnode(const struct device *dev, umode_t *mode)
> > +{
> > +	if (mode)
> > +		*mode = 0600;
> > +
> > +	return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
> > +}
> > +
> > +static const struct class ucaps_class = {
> > +	.name = "infiniband_ucaps",
> > +	.devnode = ucaps_devnode,
> > +};
> > +
> > +static const struct file_operations ucaps_cdev_fops = {
> > +	.owner = THIS_MODULE,
> > +	.open = simple_open,
> > +};
> > +
> > +/**
> > + * ib_cleanup_ucaps - cleanup all API resources and class.
> > + *
> > + * This is called once, when removing the ib_uverbs module.
> > + */
> > +void ib_cleanup_ucaps(void)
> > +{
> > +	mutex_lock(&ucaps_mutex);
> > +	if (!ucaps_class_is_registered) {
> > +		mutex_unlock(&ucaps_mutex);
> > +		return;
> > +	}
> > +
> > +	for (int i = RDMA_UCAP_FIRST; i < RDMA_UCAP_MAX; i++)
> > +		WARN_ON(ucaps_list[i]);
> > +
> > +	class_unregister(&ucaps_class);
> > +	ucaps_class_is_registered = false;
> > +	unregister_chrdev_region(ucaps_base_dev, RDMA_UCAP_MAX);
> > +	mutex_unlock(&ucaps_mutex);
> > +}
> > +
> > +static int get_ucap_from_devt(dev_t devt, u64 *idx_mask)
> > +{
> > +	for (int type = RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) {
> > +		if (ucaps_list[type] && ucaps_list[type]->dev.devt == devt) {
> > +			*idx_mask |= 1 << type;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int get_devt_from_fd(unsigned int fd, dev_t *ret_dev)
> > +{
> > +	struct file *file;
> > +
> > +	file = fget(fd);
> > +	if (!file)
> > +		return -EBADF;
> > +
> > +	*ret_dev = file_inode(file)->i_rdev;
> > +	fput(file);
> > +	return 0;
> > +}
> > +
> > +/**
> > + * ib_ucaps_init - Initialization required before ucap creation.
> > + *
> > + * Return: 0 on success, or a negative errno value on failure
> > + */
> > +static int ib_ucaps_init(void)
> > +{
> > +	int ret = 0;
> > +
> > +	if (ucaps_class_is_registered)
> > +		return ret;
> > +
> > +	ret = class_register(&ucaps_class);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = alloc_chrdev_region(&ucaps_base_dev, 0, RDMA_UCAP_MAX,
> > +				  ucaps_class.name);
> > +	if (ret < 0) {
> > +		class_unregister(&ucaps_class);
> > +		return ret;
> > +	}
> > +
> > +	ucaps_class_is_registered = true;
> > +
> > +	return 0;
> > +}
> > +
> > +static void ucap_dev_release(struct device *device)
> > +{
> > +	struct ib_ucap *ucap = container_of(device, struct ib_ucap, dev);
> > +
> > +	kfree(ucap);
> > +}
> > +
> > +/**
> > + * ib_create_ucap - Add a ucap character device
> > + * @type: UCAP type
> > + *
> > + * Creates a ucap character device in the /dev/infiniband directory. By default,
> > + * the device has root-only read-write access.
> > + *
> > + * A driver may call this multiple times with the same UCAP type. A reference
> > + * count tracks creations and deletions.
> > + *
> > + * Return: 0 on success, or a negative errno value on failure
> > + */
> > +int ib_create_ucap(enum rdma_user_cap type)
> > +{
> > +	struct ib_ucap *ucap;
> > +	int ret;
> > +
> > +	if (type >= RDMA_UCAP_MAX)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&ucaps_mutex);
> > +	ret = ib_ucaps_init();
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	ucap = ucaps_list[type];
> > +	if (ucap) {
> > +		kref_get(&ucap->ref);
> > +		mutex_unlock(&ucaps_mutex);
> > +		return 0;
> > +	}
> > +
> > +	ucap = kzalloc(sizeof(*ucap), GFP_KERNEL);
> > +	if (!ucap) {
> > +		ret = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	device_initialize(&ucap->dev);
> > +	ucap->dev.class = &ucaps_class;
> > +	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> > +	ucap->dev.release = ucap_dev_release;
> > +	ret = dev_set_name(&ucap->dev, ucap_names[type]);
> > +	if (ret)
> > +		goto err_device;
> > +
> > +	cdev_init(&ucap->cdev, &ucaps_cdev_fops);
> > +	ucap->cdev.owner = THIS_MODULE;
> > +
> > +	ret = cdev_device_add(&ucap->cdev, &ucap->dev);
> > +	if (ret)
> > +		goto err_device;
> > +
> > +	kref_init(&ucap->ref);
> > +	ucaps_list[type] = ucap;
> > +	mutex_unlock(&ucaps_mutex);
> > +
> > +	return 0;
> > +
> > +err_device:
> > +	put_device(&ucap->dev);
> > +unlock:
> > +	mutex_unlock(&ucaps_mutex);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(ib_create_ucap);
> > +
> > +static void ib_release_ucap(struct kref *ref)
> > +{
> > +	struct ib_ucap *ucap = container_of(ref, struct ib_ucap, ref);
> > +	enum rdma_user_cap type;
> > +
> > +	for (type = RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) {
> > +		if (ucaps_list[type] == ucap)
> > +			break;
> > +	}
> > +	WARN_ON(type == RDMA_UCAP_MAX);
> > +
> > +	ucaps_list[type] = NULL;
> > +	cdev_device_del(&ucap->cdev, &ucap->dev);
> > +	put_device(&ucap->dev);
> > +}
> > +
> > +/**
> > + * ib_remove_ucap - Remove a ucap character device
> > + * @type: User cap type
> > + *
> > + * Removes the ucap character device according to type. The device is completely
> > + * removed from the filesystem when its reference count reaches 0.
> > + */
> > +void ib_remove_ucap(enum rdma_user_cap type)
> > +{
> > +	struct ib_ucap *ucap;
> > +
> > +	mutex_lock(&ucaps_mutex);
> > +	ucap = ucaps_list[type];
> > +	if (WARN_ON(!ucap))
> > +		goto end;
> > +
> > +	kref_put(&ucap->ref, ib_release_ucap);
> > +end:
> > +	mutex_unlock(&ucaps_mutex);
> > +}
> > +EXPORT_SYMBOL(ib_remove_ucap);
> > +
> > +/**
> > + * ib_get_ucaps - Get bitmask of ucap types from file descriptors
> > + * @fds: Array of file descriptors
> > + * @fd_count: Number of file descriptors in the array
> > + * @idx_mask: Bitmask to be updated based on the ucaps in the fd list
> > + *
> > + * Given an array of file descriptors, this function returns a bitmask of
> > + * the ucaps where a bit is set if an FD for that ucap type was in the array.
> > + *
> > + * Return: 0 on success, or a negative errno value on failure
> > + */
> > +int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
> > +{
> > +	int ret = 0;
> > +	dev_t dev;
> > +
> > +	*idx_mask = 0;
> > +	mutex_lock(&ucaps_mutex);
> > +	for (int i = 0; i < fd_count; i++) {
> > +		ret = get_devt_from_fd(fds[i], &dev);
> > +		if (ret)
> > +			goto end;
> > +
> > +		ret = get_ucap_from_devt(dev, idx_mask);
> > +		if (ret)
> > +			goto end;
> > +	}
> > +
> > +end:
> > +	mutex_unlock(&ucaps_mutex);
> > +	return ret;
> > +}
> > diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> > index 85cfc790a7bb..973fe2c7ef53 100644
> > --- a/drivers/infiniband/core/uverbs_main.c
> > +++ b/drivers/infiniband/core/uverbs_main.c
> > @@ -52,6 +52,7 @@
> >   #include <rdma/ib.h>
> >   #include <rdma/uverbs_std_types.h>
> >   #include <rdma/rdma_netlink.h>
> > +#include <rdma/ib_ucaps.h>
> >   #include "uverbs.h"
> >   #include "core_priv.h"
> > @@ -1345,6 +1346,7 @@ static void __exit ib_uverbs_cleanup(void)
> >   				 IB_UVERBS_NUM_FIXED_MINOR);
> >   	unregister_chrdev_region(dynamic_uverbs_dev,
> >   				 IB_UVERBS_NUM_DYNAMIC_MINOR);
> > +	ib_cleanup_ucaps();
> >   	mmu_notifier_synchronize();
> >   }
> > diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
> > new file mode 100644
> > index 000000000000..8f0552a2b2b0
> > --- /dev/null
> > +++ b/include/rdma/ib_ucaps.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> > +/*
> > + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> > + */
> > +
> > +#ifndef _IB_UCAPS_H_
> > +#define _IB_UCAPS_H_
> > +
> > +#define UCAP_ENABLED(ucaps, type) (!!((ucaps) & (1U << (type))))
> > +
> > +enum rdma_user_cap {
> > +	RDMA_UCAP_MLX5_CTRL_LOCAL,
> > +	RDMA_UCAP_MLX5_CTRL_OTHER_VHCA,
> > +	RDMA_UCAP_MAX
> > +};
> > +
> > +void ib_cleanup_ucaps(void);
> > +
> > +int ib_create_ucap(enum rdma_user_cap type);
> > +
> > +void ib_remove_ucap(enum rdma_user_cap type);
> > +
> > +int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
> > +
> > +#endif /* _IB_UCAPS_H_ */
> 
> 

