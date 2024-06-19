Return-Path: <linux-rdma+bounces-3318-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F190E96A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 13:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4451C235FA
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D9513D52E;
	Wed, 19 Jun 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bApIr7UT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F213A279
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796527; cv=none; b=m9mKaJ1ynDN+faAwNam4nbvjmbjvjpM9aMcsEYL136lUJEnyRf9SkTYSl9NHileJlIbOYoMjKg+LrXsNvtcJRApiVZkiIeeJCYwOCH5dK03j9XwnDtskYSz9flL7U5l0n7oayvSrntcnF190soH4nkg7zzprEVc/o9IMSD9NeSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796527; c=relaxed/simple;
	bh=UebvP+HuSTSd4+xs5uWLtAZajwRAnKbKtoQ1F5LF4fE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE7qhbUkUvpB439bQAOQqf32nTGrj+aMtfy+2mZGok4lUeqpEY60EOglHrp3bQmHwbpdPFXdw3Y8NB1f9Rjs7gTNWpCsIRfXSOeO8qQYEwteYRTKtnNBtcw4hPV7Yc51gr/VoEuJFqOYDCWlb3rCoTr/dTg337wypJ6GpT4tLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bApIr7UT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718796523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nu4T3Lf7xrksBQPYeiJSwp8o6qGfAc6ny6mt2UlNiA=;
	b=bApIr7UTqlPZXh/dsDRcun16Fmwgeffku1w/EgG0ohn+7NyT8aDnc0wPkyIHf/edQ071AL
	Esqf/eH+ky/MrdiF1WnDNU/IMAYzjJv2a1LsQ0GMVcymXQ1kQdwflUaI8miZUJ+8VXbshx
	cXzD6RtttsYSA3x+dOz47fUT7jOAOYQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-7tGPVppgPbO9uYDP8FFPwg-1; Wed, 19 Jun 2024 07:28:42 -0400
X-MC-Unique: 7tGPVppgPbO9uYDP8FFPwg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e025b272d07so3186792276.0
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 04:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718796522; x=1719401322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nu4T3Lf7xrksBQPYeiJSwp8o6qGfAc6ny6mt2UlNiA=;
        b=ZT3zFbcj9IB5SG1dNfygVZtKuObzmY8i7cNhZ5c3gtB8Rm10Zj9fLm7hWsNt4pbQBI
         L13Iwvx3/ARQO7A4jxfc+7c5A+QWHWBIv/H4CvFD6ExQPVEDOUQAQuEiHBcRkjp6EhkK
         xCb5paracSsD3m29B4wpbLFJZ0Q8FVuLWlh75uy50N7k4d1lc3lWCZxX67abCdU4jf9n
         D61K9b+KDmQY16IZ0BgEijWedaFMgudLZFR7flkjR6pWLcKkVDSMCDkqxXu6PrsDpCQx
         o2LzZhcoL93PdJZoi2wzAV4/8EcyrUARjHGVjrwXLGPAybr0W/EQq5Iy8PtaB0pU/U02
         A21Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTnrOeSD1mdcg1TfDSG0KrDFNNr/5U6OzYE8QZOFQWFh0Ab+qTpW3H7RpLfyp7z9dmWL3xgrt0J2fxSvEIWlLVr5L0sYIJlx0aHw==
X-Gm-Message-State: AOJu0YwvI6lC97OYM+Me9Pu4bheLBkM0e1StarDN/2KvXAKtNy8iAVqI
	55rka34qMX1uHgtFPO6GhfwQ1TwlhG/mDR/YMPNYkeyPa7WZJ6zlR9AetT60ChMObOUwlRKRauS
	slxPKJJ+Dx+rwKlB8cRNanOQ0ySCS8WC377nserLwPgxGv3jG+tkJsyYLF+HAfP3tiCOK7zPW8t
	5UdbTwc8hs6yGnRiYxm6TrjTiivLL2HKqxug==
X-Received: by 2002:a25:9e92:0:b0:dfe:f4e3:72cb with SMTP id 3f1490d57ef6-e02be16636amr2405835276.27.1718796522161;
        Wed, 19 Jun 2024 04:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2//M0xJEG1ac3l2EWYJOki/9vn16+rkHiPKi6eqTjS6c2HpE220pBNTiYol4LEfF4a8/TbCQvq5VtNyY6U/4=
X-Received: by 2002:a25:9e92:0:b0:dfe:f4e3:72cb with SMTP id
 3f1490d57ef6-e02be16636amr2405820276.27.1718796521806; Wed, 19 Jun 2024
 04:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-8-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-8-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:28:05 +0200
Message-ID: <CAJaqyWd5HRa2JVXVgPxYZn05drN8UyUHu=7jyxtON1d-XHneNg@mail.gmail.com>
Subject: Re: [PATCH vhost 08/23] vdpa/mlx5: Clear and reinitialize software VQ
 data on reset
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
> The hardware VQ configuration is mirrored by data in struct
> mlx5_vdpa_virtqueue . Instead of clearing just a few fields at reset,
> fully clear the struct and initialize with the appropriate default
> values.
>
> As clear_vqs_ready() is used only during reset, get rid of it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index c8b5c87f001d..de013b5a2815 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2941,18 +2941,6 @@ static void teardown_vq_resources(struct mlx5_vdpa=
_net *ndev)
>         ndev->setup =3D false;
>  }
>
> -static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> -{
> -       int i;
> -
> -       for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
> -               ndev->vqs[i].ready =3D false;
> -               ndev->vqs[i].modified_fields =3D 0;
> -       }
> -
> -       ndev->mvdev.cvq.ready =3D false;
> -}
> -
>  static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> @@ -3035,12 +3023,14 @@ static int mlx5_vdpa_compat_reset(struct vdpa_dev=
ice *vdev, u32 flags)
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
>         teardown_vq_resources(ndev);
> -       clear_vqs_ready(ndev);
> +       init_mvqs(ndev);

Nitpick / suggestion if you have to send a v2. The init_mvqs function
name sounds like it can allocate stuff that needs to be released to
me. But I'm very bad at naming :). Maybe something like
"mvqs_set_defaults" or similar?

> +
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
>         ndev->mvdev.status =3D 0;
>         ndev->mvdev.suspended =3D false;
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
> +       ndev->mvdev.cvq.ready =3D false;
>         ndev->mvdev.cvq.received_desc =3D 0;
>         ndev->mvdev.cvq.completed_desc =3D 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max=
_vqs + 1));
>
> --
> 2.45.1
>


