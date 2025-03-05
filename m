Return-Path: <linux-rdma+bounces-8351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4644A4F8D6
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A343AA357
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764951F4194;
	Wed,  5 Mar 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Uh2bFEsu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC01D86F6
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163488; cv=none; b=fbDZjBC6xlbIWPSLaOEuQh83PasJzsufIqj3ZEv1Yvjqs4mRi5tLW2Y9f/Wf28RsUeSVHxSYbRf1JrtRhSBUv8ye4mObY+iK1sO8kUkPPXAXJ/Idzgo/B6Do6cZOQW7feGxB+3VZRhenHPwbjXa7pbsgm+kWRVJQnkTJAAR7GHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163488; c=relaxed/simple;
	bh=r0zK0xIbvh8595l74onVBcNgAAr+w3qqkSMpP7tErjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rj7ePgtkoAIG5G+3bMGf/kBHUd+mgTe9iYaDAFOjb+EVpvQjNXWoqQ6k4vlgyUr2VB9pESOF8WAXoDaSv6j6vo+A16hfNohbuXNEXmjXeWHVndehq3qpEzt3aou43zpPicNzV+ElJ2wuPcraog4zxCS6YyHh7qET+7wwqeVHBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Uh2bFEsu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2235c5818a3so937885ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 00:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741163485; x=1741768285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vFIPnMmZJ06KvU8O+U7xRJDWJRkbe3YYEjPrGRDez4=;
        b=Uh2bFEsuQOu9L6GQ43APmojOC3v8mr3MR6QTvVxYHwt+GfXTPEYfpXNQNeC23op0yH
         KiPNQs8sUVNdan0RRTpVVEILSppGymtCvnWSDuYBIDbOdlS0aQKGBdTivwi7LTtM1UUa
         Q+AH3lVN1B7zadu9Y1eJwtQkHpZdwnbroaVms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163485; x=1741768285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vFIPnMmZJ06KvU8O+U7xRJDWJRkbe3YYEjPrGRDez4=;
        b=Na2TvY/dyOKDoA6jnl8SD4nyBfDxUDn1gOBx/Qx+MEvSmEq7ZttBGQl1JiKvOMlMKl
         SwGzxjXlIm8ZgIGzSNcVOOgkCU6zb+obyjFqylYs1Ly81ZDFGXqcLzEOPtT13RQoafWa
         ozBkdoQ/hiL4Xa4MeORDLp87PEPwHqsbmKafbwah8Tvqm7fYA0kLCFvlFpRHCBAAox98
         D4Sy4H5Igj5bdp6mLvTjzI0+PrqH3v7kDoZokJGhXpdXD8V8FOgBzaRNoC6GlXyh9Fvq
         RMcSG9AILEUXTctW73vFJBQ1+Ne9+0nXRITquWyk+NMAaKmClCX2DpH355N7AWhvqhpM
         fbDA==
X-Forwarded-Encrypted: i=1; AJvYcCWcYxaWTZigjLVROjubsQWYMBJ9Pjlbqtbf1P6Wt8iCZwPk3b93fYOLW3lHQsxH9J1wkev+x5eD4oY0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdh4NQ6pUh5PCWzeSmUDSTIe6d0lzNrUCrI3w2GK1yKhKbEZUE
	VbOUjNuDwjW5IZYIfcSG55nAmc8pXuYnwPv7ihqFJ1fw4MSBDW0Hj7Z+q6/Wfm5FR+weZkNs9BO
	ry69zNBiRQObeAU8jB1XhkG/yZiIVDNdE7AHM
X-Gm-Gg: ASbGnctVqIQ4TUZLblmaCfAnOJeSBW31lt4S42ZiUSRax5n19NP2h6Y2mTWPf01P5bn
	ZMbU1mg4zHSabfJ86WSwisKFsHi2zd8TYoFCwxUkbc6Z02m6ANiTb1zKXQCtpliE2Ux8E9PMWMz
	jB1HwDu5v5nfXPIliFzqUP73KyhfA=
X-Google-Smtp-Source: AGHT+IGG0iVSfjHHLAklkb3E0emwbx/dPNMmWgCJoA+XMimyQrifyvSl8Wz3/yn9HXe1OhmyhZOgyYOWbCXIwQwbWfA=
X-Received: by 2002:a05:6a00:928a:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-73682be4d64mr3171623b3a.14.1741163485385; Wed, 05 Mar 2025
 00:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740574943.git.leon@kernel.org> <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
In-Reply-To: <558b28bc07d2067478ec638da87e01a551caa367.1740574943.git.leon@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 5 Mar 2025 14:01:13 +0530
X-Gm-Features: AQ5f1Jr3D2CukO1ZZp-Rtb2O7WC9ztgT7u1fM7BDKW4xBG2ydobCqmoiB3zMgyo
Message-ID: <CAH-L+nPoVOMHq-hzAVBXa5-8Ehc75qg0pP4mBnYtT8qH7zNUpg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/6] RDMA/uverbs: Introduce UCAP (User
 CAPabilities) API
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org, 
	Yishai Hadas <yishaih@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000121aa3062f9437c4"

--000000000000121aa3062f9437c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:50=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
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
>
> UCAP character devices are located in /dev/infiniband and the class path
> is /sys/class/infiniband_ucaps.
>
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/core/Makefile      |   3 +-
>  drivers/infiniband/core/ucaps.c       | 255 ++++++++++++++++++++++++++
>  drivers/infiniband/core/uverbs_main.c |   2 +
>  include/rdma/ib_ucaps.h               |  25 +++
>  4 files changed, 284 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/infiniband/core/ucaps.c
>  create mode 100644 include/rdma/ib_ucaps.h
>
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/M=
akefile
> index 8ab4eea5a0a5..d49ded7e95f0 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -39,6 +39,7 @@ ib_uverbs-y :=3D                        uverbs_main.o u=
verbs_cmd.o uverbs_marshall.o \
>                                 uverbs_std_types_async_fd.o \
>                                 uverbs_std_types_srq.o \
>                                 uverbs_std_types_wq.o \
> -                               uverbs_std_types_qp.o
> +                               uverbs_std_types_qp.o \
> +                               ucaps.o
>  ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) +=3D umem.o umem_dmabuf.o
>  ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) +=3D umem_odp.o
> diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/uc=
aps.c
> new file mode 100644
> index 000000000000..82b1184891ed
> --- /dev/null
> +++ b/drivers/infiniband/core/ucaps.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reser=
ved
> + */
> +
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
> +       struct cdev cdev;
> +       struct device dev;
> +       int refcount;
> +};
> +
> +static const char *ucap_names[RDMA_UCAP_MAX] =3D {
> +       [RDMA_UCAP_MLX5_CTRL_LOCAL] =3D "mlx5_perm_ctrl_local",
> +       [RDMA_UCAP_MLX5_CTRL_OTHER_VHCA] =3D "mlx5_perm_ctrl_other_vhca"
> +};
> +
> +static char *ucaps_devnode(const struct device *dev, umode_t *mode)
> +{
> +       if (mode)
> +               *mode =3D 0600;
> +
> +       return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
> +}
> +
> +static const struct class ucaps_class =3D {
> +       .name =3D "infiniband_ucaps",
> +       .devnode =3D ucaps_devnode,
> +};
> +
> +static const struct file_operations ucaps_cdev_fops =3D {
> +       .owner =3D THIS_MODULE,
> +       .open =3D simple_open,
> +};
> +
> +/**
> + * ib_cleanup_ucaps - cleanup all API resources and class.
> + *
> + * This is called once, when removing the ib_uverbs module.
> + */
> +void ib_cleanup_ucaps(void)
> +{
> +       mutex_lock(&ucaps_mutex);
> +       if (!ucaps_class_is_registered) {
> +               mutex_unlock(&ucaps_mutex);
> +               return;
> +       }
> +
> +       for (int i =3D RDMA_UCAP_FIRST; i < RDMA_UCAP_MAX; i++)
> +               WARN_ON(ucaps_list[i]);
> +
> +       class_unregister(&ucaps_class);
> +       ucaps_class_is_registered =3D false;
> +       unregister_chrdev_region(ucaps_base_dev, RDMA_UCAP_MAX);
> +       mutex_unlock(&ucaps_mutex);
> +}
> +
> +static int get_ucap_from_devt(dev_t devt, u64 *idx_mask)
> +{
> +       for (int type =3D RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type++) =
{
> +               if (ucaps_list[type] && ucaps_list[type]->dev.devt =3D=3D=
 devt) {
> +                       *idx_mask |=3D 1 << type;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int get_devt_from_fd(unsigned int fd, dev_t *ret_dev)
> +{
> +       struct file *file;
> +
> +       file =3D fget(fd);
> +       if (!file)
> +               return -EBADF;
> +
> +       *ret_dev =3D file_inode(file)->i_rdev;
> +       fput(file);
> +       return 0;
> +}
> +
> +/**
> + * ib_ucaps_init - Initialization required before ucap creation.
> + *
> + * Return: 0 on success, or a negative errno value on failure
> + */
> +static int ib_ucaps_init(void)
> +{
> +       int ret =3D 0;
> +
> +       if (ucaps_class_is_registered)
> +               return ret;
> +
> +       ret =3D class_register(&ucaps_class);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D alloc_chrdev_region(&ucaps_base_dev, 0, RDMA_UCAP_MAX,
> +                                 ucaps_class.name);
> +       if (ret < 0) {
> +               class_unregister(&ucaps_class);
> +               return ret;
> +       }
> +
> +       ucaps_class_is_registered =3D true;
> +
> +       return 0;
> +}
> +
> +static void ucap_dev_release(struct device *device)
> +{
> +       struct ib_ucap *ucap =3D container_of(device, struct ib_ucap, dev=
);
> +
> +       kfree(ucap);
> +}
> +
> +/**
> + * ib_create_ucap - Add a ucap character device
> + * @type: UCAP type
> + *
> + * Creates a ucap character device in the /dev/infiniband directory. By =
default,
> + * the device has root-only read-write access.
> + *
> + * A driver may call this multiple times with the same UCAP type. A refe=
rence
> + * count tracks creations and deletions.
> + *
> + * Return: 0 on success, or a negative errno value on failure
> + */
> +int ib_create_ucap(enum rdma_user_cap type)
> +{
> +       struct ib_ucap *ucap;
> +       int ret;
> +
> +       if (type >=3D RDMA_UCAP_MAX)
> +               return -EINVAL;
> +
> +       mutex_lock(&ucaps_mutex);
> +       ret =3D ib_ucaps_init();
> +       if (ret)
> +               goto unlock;
> +
> +       ucap =3D ucaps_list[type];
> +       if (ucap) {
> +               ucap->refcount++;
> +               mutex_unlock(&ucaps_mutex);
> +               return 0;
> +       }
> +
> +       ucap =3D kzalloc(sizeof(*ucap), GFP_KERNEL);
> +       if (!ucap) {
> +               ret =3D -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       device_initialize(&ucap->dev);
> +       ucap->dev.class =3D &ucaps_class;
> +       ucap->dev.devt =3D MKDEV(MAJOR(ucaps_base_dev), type);
> +       ucap->dev.release =3D ucap_dev_release;
> +       dev_set_name(&ucap->dev, ucap_names[type]);
> +
> +       cdev_init(&ucap->cdev, &ucaps_cdev_fops);
> +       ucap->cdev.owner =3D THIS_MODULE;
> +
> +       ret =3D cdev_device_add(&ucap->cdev, &ucap->dev);
> +       if (ret)
> +               goto err_device;
Memory leak in the error path, need to free ucap here?
> +
> +       ucap->refcount =3D 1;
> +       ucaps_list[type] =3D ucap;
> +       mutex_unlock(&ucaps_mutex);
> +
> +       return 0;
> +
> +err_device:
> +       put_device(&ucap->dev);
> +unlock:
> +       mutex_unlock(&ucaps_mutex);
> +       return ret;
> +}
> +EXPORT_SYMBOL(ib_create_ucap);
> +
> +/**
> + * ib_remove_ucap - Remove a ucap character device
> + * @type: User cap type
> + *
> + * Removes the ucap character device according to type. The device is co=
mpletely
> + * removed from the filesystem when its reference count reaches 0.
> + */
> +void ib_remove_ucap(enum rdma_user_cap type)
> +{
> +       struct ib_ucap *ucap;
> +
> +       mutex_lock(&ucaps_mutex);
> +       ucap =3D ucaps_list[type];
> +       if (WARN_ON(!ucap))
> +               goto end;
> +
> +       ucap->refcount--;
> +       if (ucap->refcount)
> +               goto end;
> +
> +       ucaps_list[type] =3D NULL;
> +       cdev_device_del(&ucap->cdev, &ucap->dev);
> +       put_device(&ucap->dev);
need to free ucap here
> +
> +end:
> +       mutex_unlock(&ucaps_mutex);
> +}
> +EXPORT_SYMBOL(ib_remove_ucap);
> +
> +/**
> + * ib_get_ucaps - Get bitmask of ucap types from file descriptors
> + * @fds: Array of file descriptors
> + * @fd_count: Number of file descriptors in the array
> + * @idx_mask: Bitmask to be updated based on the ucaps in the fd list
> + *
> + * Given an array of file descriptors, this function returns a bitmask o=
f
> + * the ucaps where a bit is set if an FD for that ucap type was in the a=
rray.
> + *
> + * Return: 0 on success, or a negative errno value on failure
> + */
> +int ib_get_ucaps(int *fds, int fd_count, uint64_t *idx_mask)
> +{
> +       int ret =3D 0;
> +       dev_t dev;
> +
> +       *idx_mask =3D 0;
> +       mutex_lock(&ucaps_mutex);
> +       for (int i =3D 0; i < fd_count; i++) {
> +               ret =3D get_devt_from_fd(fds[i], &dev);
> +               if (ret)
> +                       goto end;
> +
> +               ret =3D get_ucap_from_devt(dev, idx_mask);
> +               if (ret)
> +                       goto end;
> +       }
> +
> +end:
> +       mutex_unlock(&ucaps_mutex);
> +       return ret;
> +}
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/c=
ore/uverbs_main.c
> index 85cfc790a7bb..973fe2c7ef53 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -52,6 +52,7 @@
>  #include <rdma/ib.h>
>  #include <rdma/uverbs_std_types.h>
>  #include <rdma/rdma_netlink.h>
> +#include <rdma/ib_ucaps.h>
>
>  #include "uverbs.h"
>  #include "core_priv.h"
> @@ -1345,6 +1346,7 @@ static void __exit ib_uverbs_cleanup(void)
>                                  IB_UVERBS_NUM_FIXED_MINOR);
>         unregister_chrdev_region(dynamic_uverbs_dev,
>                                  IB_UVERBS_NUM_DYNAMIC_MINOR);
> +       ib_cleanup_ucaps();
>         mmu_notifier_synchronize();
>  }
>
> diff --git a/include/rdma/ib_ucaps.h b/include/rdma/ib_ucaps.h
> new file mode 100644
> index 000000000000..d044d02f087f
> --- /dev/null
> +++ b/include/rdma/ib_ucaps.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/*
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reser=
ved
> + */
> +
> +#ifndef _IB_UCAPS_H_
> +#define _IB_UCAPS_H_
> +
> +#define UCAP_ENABLED(ucaps, type) (!!((ucaps) & (1U << type)))
> +
> +enum rdma_user_cap {
> +       RDMA_UCAP_MLX5_CTRL_LOCAL,
> +       RDMA_UCAP_MLX5_CTRL_OTHER_VHCA,
> +       RDMA_UCAP_MAX
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
> --
> 2.48.1
>
>


--=20
Regards,
Kalesh AP

--000000000000121aa3062f9437c4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcN
AQkEMSIEID4bcwcPr3Osnh98+EHvRaUVRrk6PLoqb0ire3yOPlWgMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDMwNTA4MzEyNVowXAYJKoZIhvcNAQkPMU8wTTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAA3sidLjdPpNtl4jo1SDhNqTmkoc
m4YcXwfuG0yFbVpZItW7qr3AErlkeMtuketePqQfBj4bNsotv8mwfaQUKKMqIsGABew1FfGgOpJp
+7ValFrsWK9SbJN/8Z4SfI/Z90vLeS6HQ23f+OC25XZ+UbJk/cIrPJc3GGZ7dr08wbvk8U8BnHSx
8tXK2/kzYFNV7t3TVvvPWQj7wHXqH/tHS04PXSt62ZBjAeucq3PjknjL8ySYUjVZbwHSXPLLFG+f
eNEP3WzbPcOO2h7mBGPlhnbvq1cS3WbyNt0n3Fw14CJMt8sqYzJZf5tt2r/dj5FKNFnWOyKkhfbI
HNEouT6rVKk=
--000000000000121aa3062f9437c4--

