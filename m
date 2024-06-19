Return-Path: <linux-rdma+bounces-3337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681890F2D5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033031F238AC
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43330156F25;
	Wed, 19 Jun 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1hCtMbX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30A15253F
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811841; cv=none; b=mHP+I9Q2kiqKWEfo7MEeIV5/ft+hf1JVK4KWlW/J5J/nMSbAgD+YjsMv/kDw1B4JinZDw3CaXo2zM2OjhUzrTXakKANOM0YeAGsnykWm2NgSpXQHXbaw2t65B817UpixEQ6aj4LXgMWrDo6r8wbKYWPlr8hgEfrQW2VhSLfz2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811841; c=relaxed/simple;
	bh=gjIlVC0Qv56i7mNLzpX6QNyDh2wQBd29Qq8BecOvO84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmi6xIm2Hx34ZKAhhcBEk/AaAB5N2LR1QoVjYjiUlWwJ2qGPU8QYyTlzKa++kqBDlWKaKdYeaf+CKJlFHB8wyvkui7/jxndOoOaNdBxxoclXL5y/7J8N3mAcspQmRrRd7XN55ICUXkC8nuS7C+WF2QIj+XAfBM+lMBQJCxkL/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1hCtMbX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fKPssBEwyag1A5CHcVe8reEUsaYqb5YQavo355OrZo=;
	b=I1hCtMbXNHdeXpNSZ9TcW6wQ4oF4/GLnR4mh/44GiC7pQ/6Ed1joM2Ahy/tqrepP8QO9Gu
	Py/Gd4mTWTpZzoh0WEw2s3/LtK46TQL9JYoPTtc8tUNzzEGs701TekhKQAC1dDJ5JWy6W4
	zAz6Jv4xz+X8pR6vjwsP2Ec3Ko9Fld0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-FtbyGJnoMla-sz2l3pQxdQ-1; Wed, 19 Jun 2024 11:43:57 -0400
X-MC-Unique: FtbyGJnoMla-sz2l3pQxdQ-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso3336784276.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 08:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811836; x=1719416636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fKPssBEwyag1A5CHcVe8reEUsaYqb5YQavo355OrZo=;
        b=JK3vYC6HRK9rrisUkYjfMuPuHK8u09+CZ/d1+4yqu0HgrG4bQdTKpxZdW3zQoW+6Zp
         DIOw7rGq1yD+N5KpDHKzD3YxgCD8Yjm2U1t2MLzXVgfWEH9p4ODbdWOGqzKn16EALsxV
         w9wFYs0yo3AStPPRNHZUs+scXq13WOD+ol6G06wbsb8+RIz8rGmWn3RR6RmtDLBHYTGz
         AAACr8tyHJuQLeInEfKTRFKxAT0tTf2Zy9gU95Ov0fHFOUdiapVjRQDqPmrrygEWbBrB
         GzuZ64AE630Gb7+n/j/epKrajTtY7ifuTJGB6LA03SUW3OH1AmQhgW3mZcF8QqNzIolu
         c2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV67LZ1J9XQM34j3WmOk7DV7op8QuDyC+tK0XUrydlF5jDAML4SkMEmPfPLidOkQBKP+x6nKP3Qq+K/hqnrT3SNZfyX2Xc3RI+nlg==
X-Gm-Message-State: AOJu0Yy2qwVPSWO4GfyFRm4almhFS9LIaBcjvcvZKJma9JFBec24lbAM
	RQqyqlW2umbnSSWUCp2MZd8WPQlcaQIsedrvOPFfN13PHEflV4DYETi6XyCTozUJBZuqHYHakWe
	a67v7a4UDidHnSC7I/50hALk/a50YM5phTL0pUIvd02tsnFQ3qE+Iwf7l6LmJjauj2BPiw2SF6M
	IDyHlsMdXfoq5cvrJwfmop+SrOIHLpNamDOg==
X-Received: by 2002:a25:ab90:0:b0:dff:3055:3c26 with SMTP id 3f1490d57ef6-e02be20b4b0mr3347988276.40.1718811836567;
        Wed, 19 Jun 2024 08:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuq/mg3ERM9FqZxfhIbhFa52BBDZJDga9awTj9rzgPpjCM8aGAm1pB6AklaTDW2TTBksgypWtCPQxl0ge9AZY=
X-Received: by 2002:a25:ab90:0:b0:dff:3055:3c26 with SMTP id
 3f1490d57ef6-e02be20b4b0mr3347976276.40.1718811836245; Wed, 19 Jun 2024
 08:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-17-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-17-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:43:20 +0200
Message-ID: <CAJaqyWc3HZpyMj_LVq5nmDaDSijxcXiHAXtjSQMSuS2bZQV-aQ@mail.gmail.com>
Subject: Re: [PATCH vhost 17/23] vdpa/mlx5: Consolidate all VQ modify to Ready
 to use resume_vq()
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
> There are a few more places modifying the VQ to Ready directly. Let's
> consolidate them into resume_vq().
>
> The redundant warnings for resume_vq() errors can also be dropped.
>
> There is one special case that needs to be handled for virtio-vdpa:
> the initialized flag must be set to true earlier in setup_vq() so that
> resume_vq() doesn't return early.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e3a82c43b44e..f5d5b25cdb01 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -160,6 +160,7 @@ static void free_fixed_resources(struct mlx5_vdpa_net=
 *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
> +static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu=
eue *mvq);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -1500,16 +1501,14 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
>         if (err)
>                 goto err_vq;
>
> +       mvq->initialized =3D true;
> +
>         if (mvq->ready) {
> -               err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET=
_Q_OBJECT_STATE_RDY);
> -               if (err) {
> -                       mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to=
 ready vq idx %d(%d)\n",
> -                                      idx, err);
> +               err =3D resume_vq(ndev, mvq);
> +               if (err)
>                         goto err_modify;
> -               }
>         }
>
> -       mvq->initialized =3D true;
>         return 0;
>
>  err_modify:
> @@ -2422,7 +2421,6 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_devi=
ce *vdev, u16 idx, bool ready
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
> -       int err;
>
>         if (!mvdev->actual_features)
>                 return;
> @@ -2439,14 +2437,10 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_de=
vice *vdev, u16 idx, bool ready
>         if (!ready) {
>                 suspend_vq(ndev, mvq);
>         } else {
> -               err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET=
_Q_OBJECT_STATE_RDY);
> -               if (err) {
> -                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready fail=
ed (%d)\n", idx, err);
> +               if (resume_vq(ndev, mvq))
>                         ready =3D false;
> -               }
>         }
>
> -
>         mvq->ready =3D ready;
>  }
>
>
> --
> 2.45.1
>


