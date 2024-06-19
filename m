Return-Path: <linux-rdma+bounces-3338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9111090F357
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0BE283572
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5536155CB8;
	Wed, 19 Jun 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEB9QkYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26985155759
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812061; cv=none; b=P/TtKTnL5n0EYQ11i7bOZ63hpQigkZM4bYraKoXE4gC/ybDRkATrDFlfNdvghS3qWkAfDwgcaY8ss7vp3bp1KbGBvEWd1SE5UdGCsN7noqPp5js1RYdYMXjsvYTtmaozVHN6AZ3TEuFwwaJgYz6jE/nIZobfbpehoCagpl9srbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812061; c=relaxed/simple;
	bh=JYrn5yh+hnO7LhELR0hV0l6YRXobPrRRbY9BLOUoMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iof4sKRFGtZ/0Dt1qZiWTYbMMeg8ogbLp/oQdntJ8kAgYxd7nIHCRgKrnc5IY0R5FmTedSiSjtzUaokQm1Y4+qFgssTIcNVZVtKj4YYwcBApgebhf81xsS+HVy3/Hvbj536aoUBp5EG+PPwhQvCLQ+sG528BhN8/8Vmp/5cYBHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEB9QkYJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718812058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
	b=IEB9QkYJSmq0CiR6L25XECUrJAfguPIZ9aJuKv0cw6BRIllXUi2rVi2Oy52KjyKEmoqRKt
	Z7r357uwzIvFFmd/IlqQy+wAwUAmUbgsXtqma+0nzIc7tUEyAWactLiwyNV7UIVf4BmfMX
	2CUyzNaaD6Lx0bnuyt5c5orv8HnfEkU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-wpWBWmi1M4WgSumdoxxuFw-1; Wed, 19 Jun 2024 11:47:35 -0400
X-MC-Unique: wpWBWmi1M4WgSumdoxxuFw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-632cdb75d5aso103827767b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812055; x=1719416855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
        b=pWc6Ueiy8ZakkqbyGKv90o2A0js4FNZYA7d+kOE424MtyKQmQGhE6fTqCjOLf45H0U
         di/EVLTaMQktaaIl2N0V0zt4s4bQR52iPqY81daC54jNWYijUPxpfEa764R8+zcC7GZs
         M+ATTRUgiKnqJiVPl9jFeVK3VXLyyeCY6iyVHwVMBNukXhFFryVskAZzLgQT+SXXdBMj
         FCl3NxbLEn1djV1ev4U4EwFy3m616GtoflOu8uCPPa0kRDcgUAh+5aHtPx6i18JplVuA
         hpUIf52b+HzfBbPJQki1XFsfty65GBu2Lut+SbYzsoJbcON+VINReOQFzk0gw/GEqrKx
         h3VA==
X-Forwarded-Encrypted: i=1; AJvYcCUuxqVFqNysMKDqgwYn/3kl9mLamiYNMkV9LhhG1xp3U66S6b5GVwdhs5h9FTHQB1J+L/37J9kgWZ9heXIiVuGg9zpNQOi0V/4RcQ==
X-Gm-Message-State: AOJu0YwnGVoxGeUMgw5lXcwkRMqv5xn8ZXA3uHgL+qnI6saKz+79uABa
	/WWq8oO0NAfbTBhwFdEEBUCiUmv2CLelFUUYgjKgNQlyYSaIexSDZ0CAuimDDEAEL3anP2cpQoa
	PlFxz3Zq8eEP+M7Rg5o0+Ja74hJ8mCbZs7hAsPjR0kirsIXYpxW0bRdClGpRxVHlZzdSmF3WXsC
	xmaL2rVsTPOA5ReZNpuGIoNBasiVwgJUrphw==
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id 00721157ae682-63a8e89bed9mr28085797b3.27.1718812054983;
        Wed, 19 Jun 2024 08:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGARc89i/ByokkRmsf8KW6yRGKzxLntpgug1yeSYVGWvi8wS+8L3zugBKbhE/rnCTMx3tu5/cQQG/VU5SbeX3c=
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id
 00721157ae682-63a8e89bed9mr28085337b3.27.1718812053908; Wed, 19 Jun 2024
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:46:57 +0200
Message-ID: <CAJaqyWc5rJT666R672f2RQZvAHxy1QdoUKRfCH_wV1F61pQ2Gg@mail.gmail.com>
Subject: Re: [PATCH vhost 19/23] vdpa/mlx5: Use suspend/resume during VQP change
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
> Resume a VQ if it is already created when the number of VQ pairs
> increases. This is done in preparation for VQ pre-creation which is
> coming in a later patch. It is necessary because calling setup_vq() on
> an already created VQ will return early and will not enable the queue.
>
> For symmetry, suspend a VQ instead of tearing it down when the number of
> VQ pairs decreases. But only if the resume operation is supported.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0e1c1b7ff297..249b5afbe34a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2130,14 +2130,22 @@ static int change_num_qps(struct mlx5_vdpa_dev *m=
vdev, int newqps)
>                 if (err)
>                         return err;
>
> -               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)
> -                       teardown_vq(ndev, &ndev->vqs[i]);
> +               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)=
 {
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       if (is_resumable(ndev))
> +                               suspend_vq(ndev, mvq);
> +                       else
> +                               teardown_vq(ndev, mvq);
> +               }
>
>                 ndev->cur_num_vqs =3D 2 * newqps;
>         } else {
>                 ndev->cur_num_vqs =3D 2 * newqps;
>                 for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> -                       err =3D setup_vq(ndev, &ndev->vqs[i], true);
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       err =3D mvq->initialized ? resume_vq(ndev, mvq) :=
 setup_vq(ndev, mvq, true);
>                         if (err)
>                                 goto clean_added;
>                 }
>
> --
> 2.45.1
>


