Return-Path: <linux-rdma+bounces-3315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A6190E8ED
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 13:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC531C2102D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94413664E;
	Wed, 19 Jun 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKrh+ty+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C4132119
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795118; cv=none; b=pTOMVXxGU/cMg54aNoYHLL20rMBgoJak+5XOY1ciiGs2ERPWlhUF3ZkBE6wqR2PznnJmNaZkWIwQg0RhqD6wuTYcQ44CVYdwY08Vm2DmHsBrJ4tpxyle9hwcFSMz+XGF4w+IJ0rmXw4t/jEJ6TEH2R/aiX7xFn6RiBmciUtjURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795118; c=relaxed/simple;
	bh=0dRR5aTDWvDECUZeTACFItq3dlsdteCaVW0/xAz+trc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgq48YfBjlx8WwaqAUXxKtsisf7RuxZjIh3MV0AxsO5xgZkRR+Snksz5uZsNkew4sP3hBq4kQvJNUeqBsGKkCPic+XKwyJ3OWauG81TkS8JujZeKmgjx8VlemEooeLm6VbSVKc+JTvPS38yDPEgxg1e3aDJ0XxCSf/oxbzcUulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKrh+ty+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718795116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDjyaWl/Y5cyCdQUhzIAoRmk8UfpGo+tEe8x0hJrdZo=;
	b=hKrh+ty+oSMMJ5ulQT05eHdOPh7TsQDgQVLIXBkTgCzcg6wy/bLS/DYXiL50AtdnKS8+HZ
	ajKvs/bX0vfLneIvD2cQEDxklQiStMgbjmnvBmNw/Qt1kkk4Gx3XOmCTM9g87VYcTxRyj0
	DfLhOnCdKpMj6/nX3H7GuiExowGpCoQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-3PuiYKQMPme6GsxaYta7Ag-1; Wed, 19 Jun 2024 07:05:14 -0400
X-MC-Unique: 3PuiYKQMPme6GsxaYta7Ag-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6344d164c35so78413527b3.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795114; x=1719399914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDjyaWl/Y5cyCdQUhzIAoRmk8UfpGo+tEe8x0hJrdZo=;
        b=nZYZtz7oEbTeFAfa60AqucitQyR4rrQuA6jbF/Ob7TxZkjBd4HP1VQUg+0B9/BRFcZ
         uzbI5EUveQ2BFMp5dBg5rquY7HEjGnlecFlMTzpBWyyh67EoJo7tynlzxW8TIOVuFQA7
         zyp8H8tLTChCSve7oZTB12DsZwSpBL2X4WE8koC2mAmy6QxqlgHPmk2hNZKjH2q/KPh3
         u4Ie5h1DebE4XTHk2hfAlqeG08YQHnPZjRyohL0mzES0sNiJcP1cMo3H3es11gmiPEww
         a8t0861Dm+INv2/IR4su0FkfxiClJ8EdrjCcbizgPLljEjWJPOcDoyambHxCL373BYhk
         2QcA==
X-Forwarded-Encrypted: i=1; AJvYcCUOD22z3RGDGMW9w06SJAbTGs3ctcZ1BJShn6B34QhbcJdEPJnfL/hiYyHjTl9oIF3AmBrv8lURfNsiiVKOX8muO88+tFYHlE6M8A==
X-Gm-Message-State: AOJu0YzKXyV3pyd/3mF1jIzw5IvnzjHp53ix4vWtwwZy+6g0oBD5yHeB
	1xgh5xctTWLrlyIMUiAFkKXXCUfUH2nGmHwQqJDEsehKKewqF7WcEVUXJvbkuzCS0Mju1Orj7/4
	Y/zefJwLg7ykvteSoOZRaHNt9kqY3L06NNmg0mTRz+66QThD/3hGyXbfXt4hXzbUMdanaj3etfH
	y2pv3YqArVRb8IfYPGrA5TzGdxJCjNzr7WJQ==
X-Received: by 2002:a81:c602:0:b0:631:2ebf:b8dc with SMTP id 00721157ae682-63a8dc0792amr23261687b3.4.1718795114361;
        Wed, 19 Jun 2024 04:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ6Lahkzgb076y8mwVE/rW64T5ZHzTRWqaXRb1RvSZblvaEByNxDwfUmyzdSIeGCQH2jJ+ANLd7BBvZ34oULM=
X-Received: by 2002:a81:c602:0:b0:631:2ebf:b8dc with SMTP id
 00721157ae682-63a8dc0792amr23261497b3.4.1718795114089; Wed, 19 Jun 2024
 04:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-5-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:04:38 +0200
Message-ID: <CAJaqyWfXe9+KTzucF6YsBXOzCkJL0_w-n7PUih_j43hMAgMX4A@mail.gmail.com>
Subject: Re: [PATCH vhost 05/23] vdpa/mlx5: Iterate over active VQs during suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> No need to iterate over max number of VQs.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 96782b34e2b2..51630b1935f4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1504,7 +1504,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
>  {
>         int i;
>
> -       for (i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (i =3D 0; i < ndev->cur_num_vqs; i++)
>                 suspend_vq(ndev, &ndev->vqs[i]);
>  }
>
> @@ -1522,7 +1522,7 @@ static void resume_vq(struct mlx5_vdpa_net *ndev, s=
truct mlx5_vdpa_virtqueue *mv
>
>  static void resume_vqs(struct mlx5_vdpa_net *ndev)
>  {
> -       for (int i =3D 0; i < ndev->mvdev.max_vqs; i++)
> +       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
>                 resume_vq(ndev, &ndev->vqs[i]);
>  }
>
>
> --
> 2.45.1
>


