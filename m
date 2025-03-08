Return-Path: <linux-rdma+bounces-8492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA2AA578E7
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 08:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21FD18961BA
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Mar 2025 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1FC185920;
	Sat,  8 Mar 2025 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gd0kE3MI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF131392
	for <linux-rdma@vger.kernel.org>; Sat,  8 Mar 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741418766; cv=none; b=b0WGsGD+zl9emSzr7D51YR8NIoV16/pmLmqBY53zev20CTiiLcpl3BGAA36GcJFObBSYIEGp+nX7ysZhSBC8yFkK9VC628Zl5FiTXFqCs4thc/4sStiCn2BR2bJV/mFRVZl0uOc0HnY1YWEzx1Ze8i9XbOZCpJJg14mDoUzawnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741418766; c=relaxed/simple;
	bh=7Yx9NVg4q+F5rMeYsV8iL5A/aZrfoVgg5O9NCK+fEUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3CBOZCmOvdI0kxsrlMBHhRTjnSu/WbS4E315zwJvhWDNoBXxi3T0ZMx1YOWi1lHPr+uMSKkeUMj1ouGrx1kEr1C17D726V5dNwWa+8XMrG2gJEbk4N5TtCNafHKRSSpZ1u7EvLbB1Yf1L33Ye8ePB2rGc0A8vQR8RdBlSZgdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gd0kE3MI; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42bdf595-4b4d-475f-9dcf-13176bdaa1ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741418758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Lq0P8k2WN/MSEFqOAOYjrB/rOM/TpIBK6qJn6iA+qc=;
	b=gd0kE3MI0QWgcwXRp1Rqm2KD1y+N0O6Ymp0MdCJmZ5TOmtj/2lQvplluLd8/lK/+samr+i
	19bNswKqN6rFY9WFXgxjaBGXPuTEOS8QKM5Xzqhe66TgV9+Fty+xNyPbuFWBQmA6H8yLp/
	recn0EsUzqG/Ft8b30atiOqyuLTzZKA=
Date: Sat, 8 Mar 2025 08:25:55 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v1 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1741261611.git.leon@kernel.org>
 <5a1379187cd21178e8554afc81a3c941f21af22f.1741261611.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <5a1379187cd21178e8554afc81a3c941f21af22f.1741261611.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/6 12:51, Leon Romanovsky 写道:
> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> Implement a new User CAPabilities (UCAP) API to provide fine-grained
> control over specific firmware features.
> 
> This approach offers more granular capabilities than the existing Linux
> capabilities, which may be too generic for certain FW features.
> 
> This mechanism represents each capability as a character device with
> root read-write access. Root processes can grant users special
> privileges by allowing access to these character devices (e.g., using
> chown).

Hi, Chiara

I read this patch-set carefully. If I get this patch-set correctly, this 
patch-set introduces a new User CAPabilities API to control specific 
firmware feature.
Do we have a user guide to use this UCAP? For example, we suspect that a 
Firmware problem will occur in production environment, how can we use 
this UCAP to debug this Firmware problem?

Thanks.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> UCAP character devices are located in /dev/infiniband and the class path
> is /sys/class/infiniband_ucaps.
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>   drivers/infiniband/core/Makefile      |   3 +-
>   drivers/infiniband/core/ucaps.c       | 267 ++++++++++++++++++++++++++
>   drivers/infiniband/core/uverbs_main.c |   2 +
>   include/rdma/ib_ucaps.h               |  25 +++
>   4 files changed, 296 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/infiniband/core/ucaps.c
>   create mode 100644 include/rdma/ib_ucaps.h
> 
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index 8ab4eea5a0a5..d49ded7e95f0 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -39,6 +39,7 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
>   				uverbs_std_types_async_fd.o \
>   				uverbs_std_types_srq.o \
>   				uverbs_std_types_wq.o \
> -				uverbs_std_types_qp.o
> +				uverbs_std_types_qp.o \
> +				ucaps.o
>   ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
>   ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
> diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
> new file mode 100644
> index 000000000000..6853c6d078f9
> --- /dev/null
> +++ b/drivers/infiniband/core/ucaps.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include <linux/kref.h>
> +#include <linux/cdev.h>
> +#include <linux/mutex.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <rdma/ib_ucaps.h>
> +
> +#define RDMA_UCAP_FIRST RDMA_UCAP_MLX5_CTRL_LOCAL
> +
> +static DEFINE_MUTEX(ucaps_mutex);
> +static struct ib_ucap *ucaps_list[RDMA_UCAP_MAX];
> +static bool ucaps_class_is_registered;
> +static dev_t ucaps_base_dev;
> +
> +struct ib_ucap {
> +	struct cdev cdev;
> +	struct device dev;
> +	struct kref ref;
> +};
> +
> +static const char *ucap_names[RDMA_UCAP_MAX] = {
> +	[RDMA_UCAP_MLX5_CTRL_LOCAL] = "mlx5_perm_ctrl_local",
> +	[RDMA_UCAP_MLX5_CTRL_OTHER_VHCA] = "mlx5_perm_ctrl_other_vhca"
> +};
> +
> +static char *ucaps_devnode(const struct device *dev, umode_t *mode)
> +{
> +	if (mode)
> +		*mode = 0600;
> +
> +	return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
> +}
> +
> +static const struct class ucaps_class = {
> +	.name = "infiniband_ucaps",
> +	.devnode = ucaps_devnode,
> +};
> +
> +static const struct file_operations ucaps_cdev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = simple_open,
> +};
> +
> +/**
> + * ib_cleanup_ucaps - cleanup all API resources and class.
> + *
> + * This is called once, when removing the ib_uverbs module.
> + */
> +void ib_cleanup_ucaps(void)
> +{
> +	mutex_lock(&ucaps_mutex);
> +	if (!ucaps_class_is_registered) {
> +		mutex_unlock(&ucaps_mutex);
> +		return;
> +	}
> +
> +	for (int i = RDMA_UCAP_FIRST; i < RDMA_UCAP_MAX; i++)
> +		WARN_ON(ucaps_list[i]);
> +
> +	class_unregister(&ucaps_class);
> +	ucaps_class_is_registered = false;
> +	unregister_chrdev_region(ucaps_base_dev, RDMA_UCAP_MAX);
> +	mutex_unlock(&ucaps_mutex);
> +}
> +
> +static int get_ucap_from_devt(dev_t devt, u64 *idx_mask)
> +{
> +	for (int type = RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) {
> +		if (ucaps_list[type] && ucaps_list[type]->dev.devt == devt) {
> +			*idx_mask |= 1 << type;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int get_devt_from_fd(unsigned int fd, dev_t *ret_dev)
> +{
> +	struct file *file;
> +
> +	file = fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	*ret_dev = file_inode(file)->i_rdev;
> +	fput(file);
> +	return 0;
> +}
> +
> +/**
> + * ib_ucaps_init - Initialization required before ucap creation.
> + *
> + * Return: 0 on success, or a negative errno value on failure
> + */
> +static int ib_ucaps_init(void)
> +{
> +	int ret = 0;
> +
> +	if (ucaps_class_is_registered)
> +		return ret;
> +
> +	ret = class_register(&ucaps_class);
> +	if (ret)
> +		return ret;
> +
> +	ret = alloc_chrdev_region(&ucaps_base_dev, 0, RDMA_UCAP_MAX,
> +				  ucaps_class.name);
> +	if (ret < 0) {
> +		class_unregister(&ucaps_class);
> +		return ret;
> +	}
> +
> +	ucaps_class_is_registered = true;
> +
> +	return 0;
> +}
> +
> +static void ucap_dev_release(struct device *device)
> +{
> +	struct ib_ucap *ucap = container_of(device, struct ib_ucap, dev);
> +
> +	kfree(ucap);
> +}
> +
> +/**
> + * ib_create_ucap - Add a ucap character device
> + * @type: UCAP type
> + *
> + * Creates a ucap character device in the /dev/infiniband directory. By default,
> + * the device has root-only read-write access.
> + *
> + * A driver may call this multiple times with the same UCAP type. A reference
> + * count tracks creations and deletions.
> + *
> + * Return: 0 on success, or a negative errno value on failure
> + */
> +int ib_create_ucap(enum rdma_user_cap type)
> +{
> +	struct ib_ucap *ucap;
> +	int ret;
> +
> +	if (type >= RDMA_UCAP_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&ucaps_mutex);
> +	ret = ib_ucaps_init();
> +	if (ret)
> +		goto unlock;
> +
> +	ucap = ucaps_list[type];
> +	if (ucap) {
> +		kref_get(&ucap->ref);
> +		mutex_unlock(&ucaps_mutex);
> +		return 0;
> +	}
> +
> +	ucap = kzalloc(sizeof(*ucap), GFP_KERNEL);
> +	if (!ucap) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	device_initialize(&ucap->dev);
> +	ucap->dev.class = &ucaps_class;
> +	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
> +	ucap->dev.release = ucap_dev_release;
> +	ret = dev_set_name(&ucap->dev, ucap_names[type]);
> +	if (ret)
> +		goto err_device;
> +
> +	cdev_init(&ucap->cdev, &ucaps_cdev_fops);
> +	ucap->cdev.owner = THIS_MODULE;
> +
> +	ret = cdev_device_add(&ucap->cdev, &ucap->dev);
> +	if (ret)
> +		goto err_device;
> +
> +	kref_init(&ucap->ref);
> +	ucaps_list[type] = ucap;
> +	mutex_unlock(&ucaps_mutex);
> +
> +	return 0;
> +
> +err_device:
> +	put_device(&ucap->dev);
> +unlock:
> +	mutex_unlock(&ucaps_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ib_create_ucap);
> +
> +static void ib_release_ucap(struct kref *ref)
> +{
> +	struct ib_ucap *ucap = container_of(ref, struct ib_ucap, ref);
> +	enum rdma_user_cap type;
> +
> +	for (type = RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) {
> +		if (ucaps_list[type] == ucap)
> +			break;
> +	}
> +	WARN_ON(type == RDMA_UCAP_MAX);
> +
> +	ucaps_list[type] = NULL;
> +	cdev_device_del(&ucap->cdev, &ucap->dev);
> +	put_device(&ucap->dev);
> +}
> +
> +/**
> + * ib_remove_ucap - Remove a ucap character device
> + * @type: User cap type
> + *
> + * Removes the ucap character device according to type. The device is completely
> + * removed from the filesystem when its reference count reaches 0.
> + */
> +void ib_remove_ucap(enum rdma_user_cap type)
> +{
> +	struct ib_ucap *ucap;
> +
> +	mutex_lock(&ucaps_mutex);
> +	ucap = ucaps_list[type];
> +	if (WARN_ON(!ucap))
> +		goto end;
> +
> +	kref_put(&ucap->ref, ib_release_ucap);
> +end:
> +	mutex_unlock(&ucaps_mutex);
> +}
> +EXPORT_SYMBOL(ib_remove_ucap);
> +
> +/**
> + * ib_get_ucaps - Get bitmask of ucap types from file descriptors
> + * @fds: Array of file descriptors
> + * @fd_count: Number of file descriptors in the array
> + * @idx_mask: Bitmask to be updated based on the ucaps in the fd list
> + *
> + * Given an array of file descriptors, this function returns a bitmask of
> + * the ucaps where a bit is set if an FD for that ucap type was in the array.
> + *
> + * Return: 0 on success, or a negative errno value on failure
> + */
> +int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
> +{
> +	int ret = 0;
> +	dev_t dev;
> +
> +	*idx_mask = 0;
> +	mutex_lock(&ucaps_mutex);
> +	for (int i = 0; i < fd_count; i++) {
> +		ret = get_devt_from_fd(fds[i], &dev);
> +		if (ret)
> +			goto end;
> +
> +		ret = get_ucap_from_devt(dev, idx_mask);
> +		if (ret)
> +			goto end;
> +	}
> +
> +end:
> +	mutex_unlock(&ucaps_mutex);
> +	return ret;
> +}
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 85cfc790a7bb..973fe2c7ef53 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -52,6 +52,7 @@
>   #include <rdma/ib.h>
>   #include <rdma/uverbs_std_types.h>
>   #include <rdma/rdma_netlink.h>
> +#include <rdma/ib_ucaps.h>
>   
>   #include "uverbs.h"
>   #include "core_priv.h"
> @@ -1345,6 +1346,7 @@ static void __exit ib_uverbs_cleanup(void)
>   				 IB_UVERBS_NUM_FIXED_MINOR);
>   	unregister_chrdev_region(dynamic_uverbs_dev,
>   				 IB_UVERBS_NUM_DYNAMIC_MINOR);
> +	ib_cleanup_ucaps();
>   	mmu_notifier_synchronize();
>   }
>   
> diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
> new file mode 100644
> index 000000000000..8f0552a2b2b0
> --- /dev/null
> +++ b/include/rdma/ib_ucaps.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#ifndef _IB_UCAPS_H_
> +#define _IB_UCAPS_H_
> +
> +#define UCAP_ENABLED(ucaps, type) (!!((ucaps) & (1U << (type))))
> +
> +enum rdma_user_cap {
> +	RDMA_UCAP_MLX5_CTRL_LOCAL,
> +	RDMA_UCAP_MLX5_CTRL_OTHER_VHCA,
> +	RDMA_UCAP_MAX
> +};
> +
> +void ib_cleanup_ucaps(void);
> +
> +int ib_create_ucap(enum rdma_user_cap type);
> +
> +void ib_remove_ucap(enum rdma_user_cap type);
> +
> +int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask);
> +
> +#endif /* _IB_UCAPS_H_ */


