Return-Path: <linux-rdma+bounces-3339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5890F384
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEC41F2527B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8A915B971;
	Wed, 19 Jun 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chsdEEjD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F6153561
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812491; cv=none; b=oRVya9c3vYF2LNsjEnGCRcOk14FFmZSkIOLwxrpMDDI/PVWOQXVA7zhx3gNQ8o0FGWpN2eoSehbGRGn8alweXeyDa36gXhJ/Ai0ph+S0xDEivQwK+YL0YU5sD85XJ0glgDk919sF6etemgrRcluguS6O+cCWnP8R9o8rJ4l9iQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812491; c=relaxed/simple;
	bh=sT8eTwvksE75eAHBd6bjsUlFaGgqOtK+oZB9YtpybaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQADdLdVw88o7T5HFxOd6Stb1ZRuZpjjYjG7XXbVyFIi62lzajPoMVNRIikJwATgR6hQRHUiCRUroOX7BP6RnKmCusgMD3O6mdadNoIu9H5NJgvtG8GusBeeRSl9fBcYoXrxcNJK3VHnzXbFlU7Wb7pnnTgEEtFMtLrnflmKxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chsdEEjD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718812488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHnCTPxtH9G59nobXFr/kIxd9TQRzv+enLUupkQvcbM=;
	b=chsdEEjDq+3xCRPAC/pVWM5r1oC01eS0ZYLEMH/CTG/3V2BOwp1QnMmeOY635Q03oXzdau
	u2zt3eLAL3WP7ebX2ngdm3T+EcHIVTS1mxDEj3eoq+OxkpSjngH+z++sxq2J+yEBMB0o2a
	ynuiVy5RU6fDO9Z95eqLIzBYbijsrEg=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20--oKUDOj8M7ii3a21M2DQvw-1; Wed, 19 Jun 2024 11:54:46 -0400
X-MC-Unique: -oKUDOj8M7ii3a21M2DQvw-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dfeff072f65so11418069276.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812486; x=1719417286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHnCTPxtH9G59nobXFr/kIxd9TQRzv+enLUupkQvcbM=;
        b=bMvH7wZOj+B5pDXJu4lbe8U9MYvX8AB59r4MGwIxnUxChqFl9RP80w/cfHNLtZ/P/M
         jIh/xFmVKp/zPXnNQWCfiHltzoksCtkTj0OF/ihIG4fVLUCxQ/dt2yoQnoDcsMa6+gL7
         EeVeR3DjwQRDfpYXrrLXUBslkauNU+DEURgqvR65nyon+fHsSMC985zI0fpCDlUZMYfx
         //rR2CADFcRLvyIXBGK2saWktq6e3kmtq76p/GDnMyKcrONWdLwpvqHDHZddiQIFd+XQ
         /Ayi+/pVG6rIr8xN967qtXZ1nWE37pa+LbmgzM3Z41snwP6pX4DVqQxB5er0Rx0Mm6dE
         tNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfXiN3ZhgpH213xvm+dkuN0obORljU9Dc09Bu8gxPAtsLtrOPZbupIrup14sFt/7v+M2hykE/35r4Ad86tXMRVoFAXyLIc/fgHzQ==
X-Gm-Message-State: AOJu0YzSL9iWspt9m9DsKVgo5VKa7p/4vZ55rNUhl/mbvimQ7wYzoShS
	3FOkYBvFQEYgIFCGUXAtdmRtBJ6/2oRuBsmZrb+Loq8/ijvPWufUH7aForjp82PwHJrioxN8Vwl
	C4aQ4DFvhmdSXp5URkUe4usExd0flW615jnNh6UYHX/Ru9Zxnag0+T61+2whHoh1cbtBjx0RG6K
	RLpTxIyduGfrUOWhH9t6/CHcPpIBWZvFxOGgteHTaDi2u4
X-Received: by 2002:a25:f622:0:b0:e02:8ab0:c940 with SMTP id 3f1490d57ef6-e02be203ac9mr3184008276.47.1718812485892;
        Wed, 19 Jun 2024 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZFBAbdDk5C33KuW9phrPEsdWFCncL/S7aJzm0AP8bBcXSMAZkab9c9AuLmu/k5xJ1fPHedp6Ccdvx+WB9tV4=
X-Received: by 2002:a25:f622:0:b0:e02:8ab0:c940 with SMTP id
 3f1490d57ef6-e02be203ac9mr3183981276.47.1718812485514; Wed, 19 Jun 2024
 08:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:54:09 +0200
Message-ID: <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Currently, hardware VQs are created right when the vdpa device gets into
> DRIVER_OK state. That is easier because most of the VQ state is known by
> then.
>
> This patch switches to creating all VQs and their associated resources
> at device creation time. The motivation is to reduce the vdpa device
> live migration downtime by moving the expensive operation of creating
> all the hardware VQs and their associated resources out of downtime on
> the destination VM.
>
> The VQs are now created in a blank state. The VQ configuration will
> happen later, on DRIVER_OK. Then the configuration will be applied when
> the VQs are moved to the Ready state.
>
> When .set_vq_ready() is called on a VQ before DRIVER_OK, special care is
> needed: now that the VQ is already created a resume_vq() will be
> triggered too early when no mr has been configured yet. Skip calling
> resume_vq() in this case, let it be handled during DRIVER_OK.
>
> For virtio-vdpa, the device configuration is done earlier during
> .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> setup_vq_resources() a second time in that case.
>

I guess this happens if virtio_vdpa is already loaded, but I cannot
see how this is different here. Apart from the IOTLB, what else does
it change from the mlx5_vdpa POV?

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 ++++++++++++++++++++++++++++++++-=
----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 249b5afbe34a..b2836fd3d1dd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_devi=
ce *vdev, u16 idx, bool ready
>         mvq =3D &ndev->vqs[idx];
>         if (!ready) {
>                 suspend_vq(ndev, mvq);
> -       } else {
> +       } else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
>                 if (resume_vq(ndev, mvq))
>                         ready =3D false;
>         }
> @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_devi=
ce *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_vq_resources(ndev, true);
> -                       if (err) {
> -                               mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
> -                               goto err_driver;
> +                       if (ndev->setup) {
> +                               err =3D resume_vqs(ndev);
> +                               if (err) {
> +                                       mlx5_vdpa_warn(mvdev, "failed to =
resume VQs\n");
> +                                       goto err_driver;
> +                               }
> +                       } else {
> +                               err =3D setup_vq_resources(ndev, true);
> +                               if (err) {
> +                                       mlx5_vdpa_warn(mvdev, "failed to =
setup driver\n");
> +                                       goto err_driver;
> +                               }
>                         }
>                 } else {
>                         mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK t=
o be cleared\n");
> @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>                 if (mlx5_vdpa_create_dma_mr(mvdev))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
>         }
> +       setup_vq_resources(ndev, false);
>         up_write(&ndev->reslock);
>
>         return 0;
> @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>                 goto err_reg;
>
>         mgtdev->ndev =3D ndev;
> +
> +       /* For virtio-vdpa, the device was set up during device register.=
 */
> +       if (ndev->setup)
> +               return 0;
> +
> +       down_write(&ndev->reslock);
> +       err =3D setup_vq_resources(ndev, false);
> +       up_write(&ndev->reslock);
> +       if (err)
> +               goto err_setup_vq_res;
> +
>         return 0;
>
> +err_setup_vq_res:
> +       _vdpa_unregister_device(&mvdev->vdev);
>  err_reg:
>         destroy_workqueue(mvdev->wq);
>  err_res2:
> @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev=
 *v_mdev, struct vdpa_device *
>
>         unregister_link_notifier(ndev);
>         _vdpa_unregister_device(dev);
> +
> +       down_write(&ndev->reslock);
> +       teardown_vq_resources(ndev);
> +       up_write(&ndev->reslock);
> +
>         wq =3D mvdev->wq;
>         mvdev->wq =3D NULL;
>         destroy_workqueue(wq);
>
> --
> 2.45.1
>


