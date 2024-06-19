Return-Path: <linux-rdma+bounces-3310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81690E87B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20980B239F2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 10:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDBB12FB37;
	Wed, 19 Jun 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW2keoCo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DE12D758
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793564; cv=none; b=EGVYLSQfHpzsne7qeeVKQhvSyNJXNUWg5a/+EwRA1cXED7vMz/xbA6AL7OnONeceUv4Kvv6azJbtsDmaRgYnA0+959+Y8VLHqC2uIqbmGhIEnL8pDJrFHPk40X2p81WOqcvANhG0V0lNMWNUtE4Sew3ybI34//yzQc9VcnoRNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793564; c=relaxed/simple;
	bh=NEALePxhkauIah69wkauRXHyvijSonZ/UaLFWa+B5DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6EbhE5EIId9nUWSV46cCCHd73BBq4xfN/TAkY4II8HwlMQNLfDVTc88mDQ7kDa1T3bYPUO2claad1vV014lNJXJWaSLECbx68gwMVGGRehF7/dwnB/XC1GrEhsMF6VCeVEbBhST/kZkIuqwr6GPER7gtaft/I/IA8tgqwKPVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW2keoCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718793561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntUKAapeHA785LXjMEANQKksPYzHK2y/PR5/y33x83o=;
	b=EW2keoCoTMbaf+RKzZB7T9hRi5+rGviPPOhI4WjeH+IK8pI6YSfPJDWSAPXEmNk+549S4G
	4Zd0y3MiEuMQEppFLKfu8TFhWGICZ6MRLjx6WRmLWeKFYuaTOAMrqhrub6cch63Q4XBKzf
	+DEIGbE3J+88ZKAFyFaNQcUWnvDHSgY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-sdwuBJHjM5ekoSmIwSFccQ-1; Wed, 19 Jun 2024 06:39:20 -0400
X-MC-Unique: sdwuBJHjM5ekoSmIwSFccQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-632b6ff93e4so92947187b3.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 03:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793560; x=1719398360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntUKAapeHA785LXjMEANQKksPYzHK2y/PR5/y33x83o=;
        b=ZXjiCfmaEGAlzBtWjJZS4zolCYfsu6Fu+UjnoxusWsOvwfkUwBiuyTERkQLEEppLT1
         n9YTwG13j+Kym+sldo/SjWjg1PCQ2WZpfWtpeI+Z+DBXjGLrD6YyNqo/axFLxQ5BCFt0
         LpaqbdmTLZQ5+MppgnsTC8d/BCkS1KJ8pVnHV9WsH/zJkojmtUSY6+UA3lq7gHVEQ07M
         YMi9Ub2LTmtJEv2dELOIIp2YVOi8/E6//EsBak+1IRDEY9qSM42VddxhjAew7y4Vv2t7
         Y6dcMdvUCkbF5LO0iaBdf+EraKw6aHHAYUyMyU4DlDOFqq7293bXhW2ECNQ5XLwUzw9D
         yNVA==
X-Forwarded-Encrypted: i=1; AJvYcCVIpMipJB7lV6gteSt4FHE8ET0XDfNefnuwWSPH7Cp4BPxf10McBnqkheXq7aXh0+HKsDEw13OOrxoJdDAGER1McAegrneomJxmXw==
X-Gm-Message-State: AOJu0YwSaKV0Rc2PDJseq4RgfmAxWWpK9Zc8K/hoft+6qSecM3VWXr6l
	iPWxmLmgDb3PK/jQVeWkBTHuK9OpkElF/1vsFBlC2pyaXp7pGSnPN+/IKBwePbE9zMtF9x9mInV
	8cnLvqeCnueGB9UzGgpTvTBPrWIQJIZ+2obDpa7KuUiJIh6tymFUGWPN8kFqLaJDZhq6nq4NEo9
	B/sbaNNNjt9fCqdVhkfNu/vXTeGUAUKJHcaA==
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id 00721157ae682-63a8db105efmr24056947b3.16.1718793559973;
        Wed, 19 Jun 2024 03:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg7zWipQPmtNid7RqIL4gVepYj5ThwzkTg8DjTOCa3QWkSm+6Gd4MRh4PEdRTHoGg/L4a8+m/Orqicl0ajhyo=
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-63a8db105efmr24056837b3.16.1718793559741; Wed, 19 Jun 2024
 03:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-2-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-2-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:38:43 +0200
Message-ID: <CAJaqyWdwn+w51r8t5NO0OTQMXsjQXzB+eC8Cs8xX7Ut_sFKscg@mail.gmail.com>
Subject: Re: [PATCH vhost 02/23] vdpa/mlx5: Make setup/teardown_vq_resources() symmetrical
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
> ... by changing the setup_vq_resources() parameter.

s/parameter/parameter type/ ?

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 3422da0e344b..1ad281cbc541 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -146,7 +146,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
> -static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
>  static bool mlx5_vdpa_debug;
> @@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         if (teardown) {
>                 restore_channels_info(ndev);
> -               err =3D setup_vq_resources(mvdev);
> +               err =3D setup_vq_resources(ndev);
>                 if (err)
>                         return err;
>         }
> @@ -2873,9 +2873,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>  }
>
>  /* reslock must be held for this function */
> -static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
>  {
> -       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         int err;
>
>         WARN_ON(!rwsem_is_locked(&ndev->reslock));
> @@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_vq_resources(mvdev);
> +                       err =3D setup_vq_resources(ndev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
>                                 goto err_driver;
>
> --
> 2.45.1
>


