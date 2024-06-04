Return-Path: <linux-rdma+bounces-2834-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF27D8FB1F7
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4DD1C20C84
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40805145FE0;
	Tue,  4 Jun 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0QbDcOG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA412A8D0;
	Tue,  4 Jun 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503378; cv=none; b=ZbWngoyx/0iJNzB53jY5Y6tF6CrG0Z402o1SePTD1ZYKvMywWOtAgyvHvDyzVRLYl5b51cQhAAQIS2EKemZHz41x2PvHLrijn1mP83QLWP8NO21yBaeqs8yLAbk3a43xoKagxQksR38i2tcn8Sejz5CwF2j++N0kHR72vUVY9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503378; c=relaxed/simple;
	bh=5qfQ+m0Ppfqh1pWJdE1XuJw0YcZ+Dirns8mYWXIr0ww=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=on5xvz9QXK7fRhcY22NaMiQDU+8+1FqJ/Ac/hLKMu15FYh+rUlobPEg0vJfGG/78eopEZ3LDNQv33VDP5fp08MiYlg3+lZClP274O0JgRY0q8FmZy+NRrxR32nwF9nJOQ6YURZ5BmqOjHE1oVNXrTanYt0x6qozq6joHhHrQviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0QbDcOG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b894021cbso4977024e87.0;
        Tue, 04 Jun 2024 05:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717503374; x=1718108174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DxvJJ/Tg1s2/HE51RT5qYFxYTGkHV3tSli38G5zLJYU=;
        b=R0QbDcOGRHmUM/wpinuAR6S0XyRgPtxJ3SK8iBhoUGciXbxzwEs8qRl1FySKWMqCZ4
         LoIxLPCHuXtxXxRlhHx9GDjiGh65IJSSCYx1XrQm0yMvk+iTvuPfDEQludPEMHzitGR6
         lOqOBwIJ6+QkT7A3nmNhaIEu0T7+XyPFEcz7FA1TC26utJofa/OcLEADX50wXrEGS9PB
         pf92M9sy28SxvuJrEo2nEfO4+Eq7SLUvN19s2YpGYT8C3h3pQrwPm7iiXgPaWA6TJZ1G
         F6hG92gI0fi4xVn+elfkqVJvpT2hMKFG6AoWnekyPXILS0YJ0h3y+6VwqYb2yozmh3xa
         1nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717503374; x=1718108174;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxvJJ/Tg1s2/HE51RT5qYFxYTGkHV3tSli38G5zLJYU=;
        b=HjYL2gz7gcHqvapeJTSBcRM1nU38SkqrJlG6AUaZPBrxXqk+1HFdYk/y/t3QSlJ3On
         f/w9OJRqXP9pP2mh/KqGFgaJL7OE82c6/3RDcnhP2ZDHqpXrfCJx2x4Y7XI8Jiulbfog
         8Mc33T/J1wR331GJOMCV4jDotE8cQtuWGTWK6FEyTQ0fSCqZs2L6sxUVxAZm5Z4enPmh
         f9ugoE7KY04DuFOrAX0ZYCeo799a0jbwYAK2gpYf2ioMsPtUzQ0mgCZxBP7WqS4D20pg
         AD9KWsD5lDS4A7aBmiKVuZXGz9TL9ip6K1AdQ3DddKE+U01TSx48RFFLAAdU1yChiUIp
         TqYg==
X-Forwarded-Encrypted: i=1; AJvYcCV/ztvlpPxwk1vR46s/1GOcuLAnELyn5qazufO33ycow0KoXQoKUlhBAsVnheT8zqVWfo+xjAb+gKmoKyJZREZKfXMWI2YrnbLlddGMVn7t5fz7QhNRqLN+YwxZdvs5gWp2vlNDJtFHCttDbMzC3eSb/Dv7W9tCjvo3TeXJKyd0M5Mqe17VMEGcJ4HavgSjeGl+f8p73/sAfg==
X-Gm-Message-State: AOJu0Ywit5WQcX8ivw7S2+gCbr3+mRLEtG8X/Ufo2Pf7q3xcDy0uUPz9
	7qoxQItf1Lkv3bzYDHyQohU3qRgyhSaVrWy/kuOVfDJpdDn/g6JR
X-Google-Smtp-Source: AGHT+IGPKBNX0Sx+LirCXPaxuch1Ia3Z6kYBdlRWGcKYs7ztFMLmagd3E0yEoir4XTsgMHcYt0/ReA==
X-Received: by 2002:a05:6512:3b25:b0:52a:d87f:60e3 with SMTP id 2adb3069b0e04-52b896f7eebmr10330052e87.57.1717503373840;
        Tue, 04 Jun 2024 05:16:13 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214a9ff986sm23355935e9.42.2024.06.04.05.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:16:13 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <6cfe00ce-1860-4aba-bcb8-54f8d365d2dc@linux.dev>
Date: Tue, 4 Jun 2024 14:16:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] fwctl: Basic ioctl dispatch for the character device
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Language: en-US
In-Reply-To: <2-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 17:53, Jason Gunthorpe wrote:
> Each file descriptor gets a chunk of per-FD driver specific context that
> allows the driver to attach a device specific struct to. The core code
> takes care of the memory lifetime for this structure.
> 
> The ioctl dispatch and design is based on what was built for iommufd. The
> ioctls have a struct which has a combined in/out behavior with a typical
> 'zero pad' scheme for future extension and backwards compatibility.
> 
> Like iommufd some shared logic does most of the ioctl marshalling and
> compatibility work and tables diatches to some function pointers for
> each unique iotcl.
> 
> This approach has proven to work quite well in the iommufd and rdma
> subsystems.
> 
> Allocate an ioctl number space for the subsystem.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   MAINTAINERS                                   |   1 +
>   drivers/fwctl/main.c                          | 124 +++++++++++++++++-
>   include/linux/fwctl.h                         |  31 +++++
>   include/uapi/fwctl/fwctl.h                    |  41 ++++++
>   5 files changed, 196 insertions(+), 2 deletions(-)
>   create mode 100644 include/uapi/fwctl/fwctl.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d3a..4d91c5a20b98c8 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -324,6 +324,7 @@ Code  Seq#    Include File                                           Comments
>   0x97  00-7F  fs/ceph/ioctl.h                                         Ceph file system
>   0x99  00-0F                                                          537-Addinboard driver
>                                                                        <mailto:buk@buks.ipn.de>
> +0x9A  00-0F  include/uapi/fwctl/fwctl.h
>   0xA0  all    linux/sdp/sdp.h                                         Industrial Device Project
>                                                                        <mailto:kenji@bitgate.com>
>   0xA1  0      linux/vtpm_proxy.h                                      TPM Emulator Proxy Driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 833b853808421e..94062161e9c4d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9084,6 +9084,7 @@ S:	Maintained
>   F:	Documentation/userspace-api/fwctl.rst
>   F:	drivers/fwctl/
>   F:	include/linux/fwctl.h
> +F:	include/uapi/fwctl/
>   
>   GALAXYCORE GC0308 CAMERA SENSOR DRIVER
>   M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
> index ff9b7bad5a2b0d..7ecdabdd9dcb1e 100644
> --- a/drivers/fwctl/main.c
> +++ b/drivers/fwctl/main.c
> @@ -9,26 +9,131 @@
>   #include <linux/container_of.h>
>   #include <linux/fs.h>
>   
> +#include <uapi/fwctl/fwctl.h>
> +
>   enum {
>   	FWCTL_MAX_DEVICES = 256,
>   };
>   static dev_t fwctl_dev;
>   static DEFINE_IDA(fwctl_ida);
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
>   static int fwctl_fops_open(struct inode *inode, struct file *filp)
>   {
>   	struct fwctl_device *fwctl =
>   		container_of(inode->i_cdev, struct fwctl_device, cdev);
> +	struct fwctl_uctx *uctx __free(kfree) = NULL;
> +	int ret;
> +
> +	guard(rwsem_read)(&fwctl->registration_lock);
> +	if (!fwctl->ops)
> +		return -ENODEV;
> +
> +	uctx = kzalloc(fwctl->ops->uctx_size, GFP_KERNEL |  GFP_KERNEL_ACCOUNT);
> +	if (!uctx)
> +		return -ENOMEM;
> +
> +	uctx->fwctl = fwctl;
> +	ret = fwctl->ops->open_uctx(uctx);
> +	if (ret)
> +		return ret;

When something is wrong, uctx is freed in "fwctl->ops->open_uctx(uctx);"?

If not, the allocated memory uctx leaks here.

Zhu Yanjun

> +
> +	scoped_guard(mutex, &fwctl->uctx_list_lock) {
> +		list_add_tail(&uctx->uctx_list_entry, &fwctl->uctx_list);
> +	}
>   
>   	get_device(&fwctl->dev);
> -	filp->private_data = fwctl;
> +	filp->private_data = no_free_ptr(uctx);
>   	return 0;
>   }
>   
> +static void fwctl_destroy_uctx(struct fwctl_uctx *uctx)
> +{
> +	lockdep_assert_held(&uctx->fwctl->uctx_list_lock);
> +	list_del(&uctx->uctx_list_entry);
> +	uctx->fwctl->ops->close_uctx(uctx);
> +}
> +
>   static int fwctl_fops_release(struct inode *inode, struct file *filp)
>   {
> -	struct fwctl_device *fwctl = filp->private_data;
> +	struct fwctl_uctx *uctx = filp->private_data;
> +	struct fwctl_device *fwctl = uctx->fwctl;
>   
> +	scoped_guard(rwsem_read, &fwctl->registration_lock) {
> +		if (fwctl->ops) {
> +			guard(mutex)(&fwctl->uctx_list_lock);
> +			fwctl_destroy_uctx(uctx);
> +		}
> +	}
> +
> +	kfree(uctx);
>   	fwctl_put(fwctl);
>   	return 0;
>   }
> @@ -37,6 +142,7 @@ static const struct file_operations fwctl_fops = {
>   	.owner = THIS_MODULE,
>   	.open = fwctl_fops_open,
>   	.release = fwctl_fops_release,
> +	.unlocked_ioctl = fwctl_fops_ioctl,
>   };
>   
>   static void fwctl_device_release(struct device *device)
> @@ -46,6 +152,7 @@ static void fwctl_device_release(struct device *device)
>   
>   	if (fwctl->dev.devt)
>   		ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
> +	mutex_destroy(&fwctl->uctx_list_lock);
>   	kfree(fwctl);
>   }
>   
> @@ -69,6 +176,9 @@ _alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
>   		return NULL;
>   	fwctl->dev.class = &fwctl_class;
>   	fwctl->dev.parent = parent;
> +	init_rwsem(&fwctl->registration_lock);
> +	mutex_init(&fwctl->uctx_list_lock);
> +	INIT_LIST_HEAD(&fwctl->uctx_list);
>   	device_initialize(&fwctl->dev);
>   	return_ptr(fwctl);
>   }
> @@ -134,8 +244,18 @@ EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
>    */
>   void fwctl_unregister(struct fwctl_device *fwctl)
>   {
> +	struct fwctl_uctx *uctx;
> +
>   	cdev_device_del(&fwctl->cdev, &fwctl->dev);
>   
> +	/* Disable and free the driver's resources for any still open FDs. */
> +	guard(rwsem_write)(&fwctl->registration_lock);
> +	guard(mutex)(&fwctl->uctx_list_lock);
> +	while ((uctx = list_first_entry_or_null(&fwctl->uctx_list,
> +						struct fwctl_uctx,
> +						uctx_list_entry)))
> +		fwctl_destroy_uctx(uctx);
> +
>   	/*
>   	 * The driver module may unload after this returns, the op pointer will
>   	 * not be valid.
> diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
> index ef4eaa87c945e4..1d9651de92fc19 100644
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -11,7 +11,20 @@
>   struct fwctl_device;
>   struct fwctl_uctx;
>   
> +/**
> + * struct fwctl_ops - Driver provided operations
> + * @uctx_size: The size of the fwctl_uctx struct to allocate. The first
> + *	bytes of this memory will be a fwctl_uctx. The driver can use the
> + *	remaining bytes as its private memory.
> + * @open_uctx: Called when a file descriptor is opened before the uctx is ever
> + *	used.
> + * @close_uctx: Called when the uctx is destroyed, usually when the FD is
> + *	closed.
> + */
>   struct fwctl_ops {
> +	size_t uctx_size;
> +	int (*open_uctx)(struct fwctl_uctx *uctx);
> +	void (*close_uctx)(struct fwctl_uctx *uctx);
>   };
>   
>   /**
> @@ -26,6 +39,10 @@ struct fwctl_device {
>   	struct device dev;
>   	/* private: */
>   	struct cdev cdev;
> +
> +	struct rw_semaphore registration_lock;
> +	struct mutex uctx_list_lock;
> +	struct list_head uctx_list;
>   	const struct fwctl_ops *ops;
>   };
>   
> @@ -65,4 +82,18 @@ DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
>   int fwctl_register(struct fwctl_device *fwctl);
>   void fwctl_unregister(struct fwctl_device *fwctl);
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
>   #endif
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> new file mode 100644
> index 00000000000000..0bdce95b6d69d9
> --- /dev/null
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES.
> + */
> +#ifndef _UAPI_FWCTL_H
> +#define _UAPI_FWCTL_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define FWCTL_TYPE 0x9A
> +
> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
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


