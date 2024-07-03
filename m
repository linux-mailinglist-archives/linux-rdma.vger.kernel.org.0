Return-Path: <linux-rdma+bounces-3632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3B9265E0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 18:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1BD1F23802
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43074184116;
	Wed,  3 Jul 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX6ZtfEb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1676183099
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jul 2024 16:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023569; cv=none; b=LQjVnW+bLXQ2Lwcj0H1YEidaBvMO/YqUIfxXOvdnNDQ4D3dq24CGlWtQdzkBOCml6NckDdVgYUm3s1auFNkSpMV14r5MrKoqHWP+vkiQeO3Bfb4DQ6NgQ/mBykvk8sfoEmkee4CeMTvJUuLTBp5Kt5WlArvOvubuB58hnPVTihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023569; c=relaxed/simple;
	bh=XZQ2khpGw92ayYyOOjfsbAZCVbk4sLWNq5yArPaelbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhtdNU5bgGSkX8Q3lPVpX8NTds6iq79uuE/57uQtIAj9WK671ySKQbeLYkVKSrBlTweWmQGZdzncXYFsEbjvm8MZfvKL3jGyqnFKOySgypw1PMkdgCcqKBCRAbpWT1WzlJmY8W3wAez6xj5FxN9w3IiN48t/jJBtAdEnRJfGFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX6ZtfEb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c65T9aGcCrnJaJaWK+o0SC+aJQfT0XzRMaqMZ/EJDM4=;
	b=aX6ZtfEbo98pypUCvf4AMeZ1spGLC32UTmmcXs+aK7ozjLJHnoFUZ7HmLrpnjMTAxsdZP/
	ayB7dawGtYr4FgEVTR9ILLN/mUjWd3IUCXJWxnPzzmC0MtTfA4kGfv/765ZlPeLzjweqS3
	njOP0lMWO5o/ZBR+CobUU8MV4E6gv8A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-_9ngDM62PR-jMXVnU_l-Mg-1; Wed, 03 Jul 2024 12:19:23 -0400
X-MC-Unique: _9ngDM62PR-jMXVnU_l-Mg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58d7b8f1e1bso531260a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2024 09:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023562; x=1720628362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c65T9aGcCrnJaJaWK+o0SC+aJQfT0XzRMaqMZ/EJDM4=;
        b=MJl8FIBerdU3MBVF7AqdQUNjTbgxbNVq6zVLaCR2XIe2hTSOwC/goHEamFoZTyKxBh
         F4pa8+q9o3grv+2qTbBTD5c69wNsUbR02NIU0DXA3CA8hPm4ZdEVaZycYusHQNREqawp
         LarHKYSQ3g0j2l9xQA/TNAT5Mythq4ggiNeVA3jf3wycvWbjgC1sdqAgze/7HLcN6PEw
         BHl/6rOgQI4wja6VZVdB/Tm2TEXSjv0p7CmP5innR2eqvSVaKTej0ZAWhQD/utykHQBe
         uTS2Sn2jJXQbVRbX6aNwfysC4jI3ay+Zzi2547YlXzmqPR4xauB1CQkeE5zOaihVZYk0
         MvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/GBCy9wKi9Ta31pFW9A1RQ5xeILaOW+PM1FMo05C8XEgdnvK4+U3HKPYXieaqTQYangrq9KdSPZtiSAodeUAUKo50EGxyhA8ccQ==
X-Gm-Message-State: AOJu0YwJNrSXsK/YkN1xPrPYZwP2YYRJV1hw8punHwUoI12rQNerPFAR
	QvTmIZ/hCvts8a0/JCSzVPiAiUhyonmkrxJmtuYKQlv3A01xBp1lPSgsLrYhCtP03mTd8OwLvYg
	+AkTmPu5RuQyY5x2H45sQ23I11QjW3h/KQnwz9CS3XjoEpRbmjhVeEn2El3Z2m/MAcdMI2l4LsS
	GY1qNdziwhFz8GNoihiGK5Q2Ia8/iMGD/sRg==
X-Received: by 2002:a05:6402:3591:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-58ce5ef6ad8mr1719692a12.17.1720023562396;
        Wed, 03 Jul 2024 09:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPm2RKAFqhIP4SkrsoOYtpsOdJlOeWv6pMlJEn55IU/y69hvTL9KLEEXmYY5vce/n+pf4qv0hzVawdzxulgw=
X-Received: by 2002:a05:6402:3591:b0:58c:b2b8:31b2 with SMTP id
 4fb4d7f45d1cf-58ce5ef6ad8mr1719679a12.17.1720023562050; Wed, 03 Jul 2024
 09:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-15-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-15-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:18:44 +0200
Message-ID: <CAJaqyWfEv9KLKDSZidiO=ZoJvKVLaHzHW3+ModPxfGEiu1xMUw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 15/24] vdpa/mlx5: Allow creation of blank VQs
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Based on the filled flag, create VQs that are filled or blank.
> Blank VQs will be filled in later through VQ modify.
>
> Downstream patches will make use of this to pre-create blank VQs at
> vdpa device creation.
>

s/Downstream/Later/ ?

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 85 +++++++++++++++++++++++++--------=
------
>  1 file changed, 55 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index a8ac542f30f7..0a62ce0b4af8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -158,7 +158,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
>  static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
> -static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
>  static bool mlx5_vdpa_debug;
> @@ -874,13 +874,16 @@ static bool msix_mode_supported(struct mlx5_vdpa_de=
v *mvdev)
>                 pci_msix_can_alloc_dyn(mvdev->mdev->pdev);
>  }
>
> -static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa=
_virtqueue *mvq)
> +static int create_virtqueue(struct mlx5_vdpa_net *ndev,
> +                           struct mlx5_vdpa_virtqueue *mvq,
> +                           bool filled)
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
>         u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] =3D {};
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         struct mlx5_vdpa_mr *vq_mr;
>         struct mlx5_vdpa_mr *vq_desc_mr;
> +       u64 features =3D filled ? mvdev->actual_features : mvdev->mlx_fea=
tures;
>         void *obj_context;
>         u16 mlx_features;
>         void *cmd_hdr;
> @@ -898,7 +901,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>                 goto err_alloc;
>         }
>
> -       mlx_features =3D get_features(ndev->mvdev.actual_features);
> +       mlx_features =3D get_features(features);
>         cmd_hdr =3D MLX5_ADDR_OF(create_virtio_net_q_in, in, general_obj_=
in_cmd_hdr);
>
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CRE=
ATE_GENERAL_OBJECT);
> @@ -906,8 +909,6 @@ static int create_virtqueue(struct mlx5_vdpa_net *nde=
v, struct mlx5_vdpa_virtque
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.ui=
d);
>
>         obj_context =3D MLX5_ADDR_OF(create_virtio_net_q_in, in, obj_cont=
ext);
> -       MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mv=
q->avail_idx);
> -       MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->us=
ed_idx);
>         MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask=
_12_3,
>                  mlx_features >> 3);
>         MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask=
_2_0,
> @@ -929,17 +930,36 @@ static int create_virtqueue(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtque
>         MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
>         MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
>         MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
> -                !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSIO=
N_1)));
> -       MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> -       MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
> -       MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
> -       vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
> -       if (vq_mr)
> -               MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
> -
> -       vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_=
GROUP]];
> -       if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported))
> -               MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->m=
key);
> +                !!(features & BIT_ULL(VIRTIO_F_VERSION_1)));
> +
> +       if (filled) {
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_available_i=
ndex, mvq->avail_idx);
> +               MLX5_SET(virtio_net_q_object, obj_context, hw_used_index,=
 mvq->used_idx);
> +
> +               MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> +               MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr)=
;
> +               MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_=
addr);
> +
> +               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               if (vq_mr)
> +                       MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->=
mkey);
> +
> +               vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATA=
VQ_DESC_GROUP]];
> +               if (vq_desc_mr &&
> +                   MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_m=
key_supported))
> +                       MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_de=
sc_mr->mkey);
> +       } else {
> +               /* If there is no mr update, make sure that the existing =
ones are set
> +                * modify to ready.
> +                */
> +               vq_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GR=
OUP]];
> +               if (vq_mr)
> +                       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
VIRTIO_Q_MKEY;
> +
> +               vq_desc_mr =3D mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATA=
VQ_DESC_GROUP]];
> +               if (vq_desc_mr)
> +                       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
DESC_GROUP_MKEY;
> +       }
>
>         MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>         MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> @@ -959,12 +979,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *n=
dev, struct mlx5_vdpa_virtque
>         kfree(in);
>         mvq->virtq_id =3D MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
>
> -       mlx5_vdpa_get_mr(mvdev, vq_mr);
> -       mvq->vq_mr =3D vq_mr;
> +       if (filled) {
> +               mlx5_vdpa_get_mr(mvdev, vq_mr);
> +               mvq->vq_mr =3D vq_mr;
>
> -       if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_g=
roup_mkey_supported)) {
> -               mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
> -               mvq->desc_mr =3D vq_desc_mr;
> +               if (vq_desc_mr &&
> +                   MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_m=
key_supported)) {
> +                       mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
> +                       mvq->desc_mr =3D vq_desc_mr;
> +               }
>         }
>
>         return 0;
> @@ -1442,7 +1465,9 @@ static void dealloc_vector(struct mlx5_vdpa_net *nd=
ev,
>                 }
>  }
>
> -static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque=
ue *mvq)
> +static int setup_vq(struct mlx5_vdpa_net *ndev,
> +                   struct mlx5_vdpa_virtqueue *mvq,
> +                   bool filled)
>  {
>         u16 idx =3D mvq->index;
>         int err;
> @@ -1471,7 +1496,7 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, str=
uct mlx5_vdpa_virtqueue *mvq)
>                 goto err_connect;
>
>         alloc_vector(ndev, mvq);
> -       err =3D create_virtqueue(ndev, mvq);
> +       err =3D create_virtqueue(ndev, mvq, filled);
>         if (err)
>                 goto err_vq;
>
> @@ -2062,7 +2087,7 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvd=
ev, int newqps)
>         } else {
>                 ndev->cur_num_vqs =3D 2 * newqps;
>                 for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> -                       err =3D setup_vq(ndev, &ndev->vqs[i]);
> +                       err =3D setup_vq(ndev, &ndev->vqs[i], true);
>                         if (err)
>                                 goto clean_added;
>                 }
> @@ -2558,14 +2583,14 @@ static int verify_driver_features(struct mlx5_vdp=
a_dev *mvdev, u64 features)
>         return 0;
>  }
>
> -static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
> +static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev, bool filled)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         int err;
>         int i;
>
>         for (i =3D 0; i < mvdev->max_vqs; i++) {
> -               err =3D setup_vq(ndev, &ndev->vqs[i]);
> +               err =3D setup_vq(ndev, &ndev->vqs[i], filled);
>                 if (err)
>                         goto err_vq;
>         }
> @@ -2877,7 +2902,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         if (teardown) {
>                 restore_channels_info(ndev);
> -               err =3D setup_vq_resources(ndev);
> +               err =3D setup_vq_resources(ndev, true);
>                 if (err)
>                         return err;
>         }
> @@ -2888,7 +2913,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>  }
>
>  /* reslock must be held for this function */
> -static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         int err;
> @@ -2906,7 +2931,7 @@ static int setup_vq_resources(struct mlx5_vdpa_net =
*ndev)
>         if (err)
>                 goto err_setup;
>
> -       err =3D setup_virtqueues(mvdev);
> +       err =3D setup_virtqueues(mvdev, filled);
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
>                 goto err_setup;
> @@ -3000,7 +3025,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_vq_resources(ndev);
> +                       err =3D setup_vq_resources(ndev, true);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
>                                 goto err_driver;
>
> --
> 2.45.1
>


