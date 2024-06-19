Return-Path: <linux-rdma+bounces-3312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2990E8C1
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38101C2104D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC26135A67;
	Wed, 19 Jun 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAIIZlik"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C213211E
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794560; cv=none; b=b4Jd5aWEgCn1jpciAbPWKwbi4yxgcwB2vmDXOFu2+yYHYpRMpjGTSCL1sCz9Z5ngUHEVki9YtEmMqIZk1qzWdV0XHx2KJjMm9BYKSiFl9A4Nrkx8W4SQkiXTMHpI6JTY623t3Ox5SbS8VrIDpf8/5eswh4gN90RSl8X7VJaBHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794560; c=relaxed/simple;
	bh=kGxMAaJvLmfXkBIK3NGXhSRM0AwoYHtsGbNLEE0bnpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaGaYhHXLvrtv/G773IrsnWMVw/rgTNrZ8lXeav5PecFpfbXIJ/Osz+JFbN5bj5qlFWbDCBSkm4ilNU31FVEFYKD+b6Mz5z9lKBkvMw528j8NyathsFrRLDOdYR77cFP6EKuLkOF9T3IGYx1MdAHV/E4zKcW0zdNrNiyWzolJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAIIZlik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
	b=MAIIZlikYOlUmH5kS9AslrRHuPZ1GDuGor0MCHhPMzwa8alD5JsRrYRlHGftGSZbikoq29
	FA6Gt/PcvohS4IU6oTcpQO5aqBk04TOEX63H6ZQnxwagR4F2K8ODrFIclXwXtDlcYFzl7y
	ZKt9TYS9Ffx/X12HYrEsdnyL3WRVUZU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-_LlsWaoWM7-254dJDMj56w-1; Wed, 19 Jun 2024 06:55:54 -0400
X-MC-Unique: _LlsWaoWM7-254dJDMj56w-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62fb4a1f7bfso145651917b3.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 03:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794553; x=1719399353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
        b=T/pGKYupc8p/56vZPZkTocpgc0tS9qzYI4QNwbynF7moKE98g3wIHzp5Hl3Q1fCDEM
         +r+E95c47Bm3vVx7WaCAuQ9Hij0TPYbBz4slJEiFakI3nmdJH8vducssp2fifGFQqyDf
         PKD1EsPvjnxzJ0porKjPwN1I4aDEZa2wcc5H1pmwlAPwVu2irUAodlFzeaehO8fEmEGL
         cvO7AypxEffDKLm9wL/5oURKNczZyeKS2V9lHXWWXaE2RzZOjqa2z9tWBaAbhMJ2O5Z+
         BltaR6iwsN8FP5Lt20Z6dInU2qC0eht67P9QQlbmgfhd5Hvt7W59kLEQiMgFGuF7uhRx
         WtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO3EtgTsmRe7WXoSSxRRGIMAENgfEbE/tW4uUyT8UY54hYRn6fFU2xzh2bASgB/9wg7IKjLGJESEnWx96iBW0cl0mm7XH9mIAAGQ==
X-Gm-Message-State: AOJu0Yw3m65F1E0p+HDxXMdQj9LgT9SLCBWS73pW1g4lnfNZC9Gq5dqx
	viGO2Jo0FiypD+3dOllmzPY8KMGF1Vg+R3kPgrodE6DpWLzTtfKYmdbIEcjltlcBFiSzUecNdLi
	lhS9QMqXXYPq+2ZhrP05oXi+QTFEgmCgma4M2mWZBVIBBrov4uLw2IL6n7NmmNs3cE+tpMiyUZp
	nFYt3exObJkb5sj8XA6d7ya2YbJzcTJ1A1dA==
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id 00721157ae682-63a8f6196cfmr23423207b3.39.1718794553597;
        Wed, 19 Jun 2024 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvxPUUYPpg9QjOGGTil9Q0vxhLdibJM9rIX47lCpLHxV4IIFiJXXL5B/tBGDpyegeZIjHDn8kj0g1taUiWYss=
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id
 00721157ae682-63a8f6196cfmr23423047b3.39.1718794553297; Wed, 19 Jun 2024
 03:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:55:17 +0200
Message-ID: <CAJaqyWdWSbua3HJaAHP0vetugyy5-ryAD8d-z-Xi26VQXiRSiA@mail.gmail.com>
Subject: Re: [PATCH vhost 03/23] vdpa/mlx5: Drop redundant code
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

Patch message suggestion:
Originally, the second loop initialized the CVQ. But (acde3929492b
("vdpa/mlx5: Use consistent RQT size") initialized all the queues in
the first loop, so the second iteration in ...

>
> The second iteration in init_mvqs() is never called because the first
> one will iterate up to max_vqs.
>

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1ad281cbc541..b4d9ef4f66c8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3519,12 +3519,6 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->fwqp.fw =3D true;
>                 mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         }
> -       for (; i < ndev->mvdev.max_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> -               mvq->index =3D i;
> -               mvq->ndev =3D ndev;
> -       }
>  }
>
>  struct mlx5_vdpa_mgmtdev {
>
> --
> 2.45.1
>


