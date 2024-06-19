Return-Path: <linux-rdma+bounces-3333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5CC90F235
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB71F23257
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD214F9F9;
	Wed, 19 Jun 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7QH8gea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185D3E47E
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811249; cv=none; b=qNFtyNNcePiVoulS9wmgB567mEobbCtP4rJEfJOC+gc/PS1J4KsPbhLl/JGdyruhubrukQVs6d7ZL8xJhBzFR66fa2c80yJieJYKqX5pZtJ1zGgv8mol0hoAZLDxg9vYLPkBrm4x/BQiDZpN1ZLA3knnC+J0GXAiFJCHTattwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811249; c=relaxed/simple;
	bh=JjSCB6LS3wiyF3DbeDMWwT5TCIouVRcUPGA/j8R2++c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi0zBClbj5fbS2HPIV+7xOQSboEMcyrHQqWmTUmR4tQh0wK7mY8rS2qb1/iDzGMjjKSbQsFJrjZWQwXGzY5jM630VamzV/8jcNythopIx8LZtnKaoqRQO3amRiCSBlnbuBFmwBZWPBF5JK8zk0YiMA8dUMainjEFuA8h3pEdHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7QH8gea; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQMB2bziMZ2fnDCqmuIpfzI1okESa0ESyaD6J7CkheY=;
	b=Y7QH8geaZsl0V9e75Wfy+wSJRx5JF9tvbLOjtti/t4hC4/OaxZhvE4zQmB98S45G+cxkYF
	18I+RkLI0NYaCHqgFnb3IygCe6DLSqEc0i/3hhjAtYc5XS6OWo5IZZxAEAzKjSV+h4boKM
	cZWocCN723/WJ5EmcTU/tOmRHCO8uF4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-RycK863ZOnSv0gdz7exofA-1; Wed, 19 Jun 2024 11:34:04 -0400
X-MC-Unique: RycK863ZOnSv0gdz7exofA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-632b75cfff1so90777497b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 08:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811244; x=1719416044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQMB2bziMZ2fnDCqmuIpfzI1okESa0ESyaD6J7CkheY=;
        b=IcRxQ8MHjbpuVOhjOXVZWZiYeSrAAdB9U3iuhpb4qgfPzbbb7wZ5xH/AUerU/UTLK/
         zx9n75IzEIxzCBxrXkGiP8XjRzcDbHfW5xXiwCJAVj6FwvARmGhAnKMCbSuCUG3y1QMi
         7vfY0bWD8eZB2icd/XasqIVxs+H+avngFjE3IoE5zW2Tm+g1b2mtiEL7PaPAmNeUaJ5H
         BnTVNNB3QQUAvZIhJU5ivKFWq2eWuE1dlWzqyOpH6BX7x3DTSrtwlMtmXxdOjdqQRQxj
         jr41vOCo+IBY4oi0yNF8zI2Dkv76EuA7/XWMCrJkJxgP0lGi+RiBR1KXK3FAUWxHMkyt
         NJEw==
X-Forwarded-Encrypted: i=1; AJvYcCXMOMUkxWcnOJy2QdjAwW/tsu4PligZNAh4McHuco2KtOS/qRBXEdmSValQOHCZj2eSX6PZJ4cN8XOOcA7Nwq69HhI/e1okj9hq3w==
X-Gm-Message-State: AOJu0Yz4819nC+O/9/4BUyo1gv1LRGqYAsTvUw5z7Jk8cKmrsTQeUY0+
	gTcPlVI7c8ksk5xWRRNNE6tG1UmZ1aVLBwLEqbNur1ajkX+WKK+w1bF3I1jrTgQuSRWzHYuYKsA
	qMJydqQqiixZZHxkAITLpN/XIDFbyH+1W/NPP3pKyb2EnoOOBRdKIEdYG3/UjGi4Uz0lgVBiZvj
	dp6NcGs+4TvWg78QikYPXGq8IqHEgBbTeoWQ==
X-Received: by 2002:a0d:f4c7:0:b0:631:4a11:87eb with SMTP id 00721157ae682-63a8f6196fdmr28579247b3.39.1718811244114;
        Wed, 19 Jun 2024 08:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhL1C24oVrVXXFT1bj/sKCsRDk99AGD4Lt9ClFL/7aWmtSr0+siG64DMofh65/6MltG0ZNfQmZTPad19ddM0I=
X-Received: by 2002:a0d:f4c7:0:b0:631:4a11:87eb with SMTP id
 00721157ae682-63a8f6196fdmr28579157b3.39.1718811243814; Wed, 19 Jun 2024
 08:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-12-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-12-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:33:28 +0200
Message-ID: <CAJaqyWfOgNdyfmuwH2PZfh0jMkKmpEAs-jC9-OjsNrn_c5=4ig@mail.gmail.com>
Subject: Re: [PATCH vhost 12/23] vdpa/mlx5: Start off rqt_size with max VQPs
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
> Currently rqt_size is initialized during device flag configuration.
> That's because it is the earliest moment when device knows if MQ
> (multi queue) is on or off.
>
> Shift this configuration earlier to device creation time. This implies
> that non-MQ devices will have a larger RQT size. But the configuration
> will still be correct.
>
> This is done in preparation for the pre-creation of hardware virtqueues
> at device add time. When that change will be added, RQT will be created
> at device creation time so it needs to be initialized to its max size.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1181e0ac3671..0201c6fe61e1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2731,10 +2731,6 @@ static int mlx5_vdpa_set_driver_features(struct vd=
pa_device *vdev, u64 features)
>                 return err;
>
>         ndev->mvdev.actual_features =3D features & ndev->mvdev.mlx_featur=
es;
> -       if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> -               ndev->rqt_size =3D mlx5vdpa16_to_cpu(mvdev, ndev->config.=
max_virtqueue_pairs);
> -       else
> -               ndev->rqt_size =3D 1;
>
>         /* Interested in changes of vq features only. */
>         if (get_features(old_features) !=3D get_features(mvdev->actual_fe=
atures)) {
> @@ -3719,8 +3715,12 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>                 goto err_alloc;
>         }
>
> -       if (device_features & BIT_ULL(VIRTIO_NET_F_MQ))
> +       if (device_features & BIT_ULL(VIRTIO_NET_F_MQ)) {
>                 config->max_virtqueue_pairs =3D cpu_to_mlx5vdpa16(mvdev, =
max_vqs / 2);
> +               ndev->rqt_size =3D max_vqs / 2;
> +       } else {
> +               ndev->rqt_size =3D 1;
> +       }
>
>         ndev->mvdev.mlx_features =3D device_features;
>         mvdev->vdev.dma_dev =3D &mdev->pdev->dev;
>
> --
> 2.45.1
>


