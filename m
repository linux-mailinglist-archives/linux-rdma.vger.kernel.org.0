Return-Path: <linux-rdma+bounces-3633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4092660D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 18:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE7C1F21FE9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5A4191F9B;
	Wed,  3 Jul 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNCvfFsr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3B18308F
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jul 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023705; cv=none; b=LGjL+KgITgITTEduZiCiFpyKImLZ0P7VLlbC0XwZmEWUnJSX5UK9mGsb+LfCJwgehVjGFtA8jo08J61JCe97+tC1QFMlVRsaFFfi7dqLJVS1TkHzkzqQLNYOUck7hoYX77Lr6jtTy9m5QRTU2Z3cB/UcWDNDgVo4HQelbQfFTOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023705; c=relaxed/simple;
	bh=TcS0Nab4P1uInJHhXVtq4QA+KS6M5rJkuPOwVobX3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+K0CDBcTGFSRhWLW22/44np3e8ot5iuykUqd+0Ez3VJfue0QPWX5IVh+t6JeDPsJHHjzzp4/Cp/+5XVKjByPjDYzjYDh7axsyvxoVhpZ+9Js0KWDZaLbytLAiCpD8F28iy7gNhHlHJOsJoNJE+ZymAgF3HRMZIcX5AjNvyqxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNCvfFsr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
	b=ZNCvfFsrj1ZD24KrNrFi3ykV7/2ipNoOEmpI0h9H855ruVRT+kSIV4EVUflOWTN6mV/Hw1
	iOEFSJjAv8b55n9ntN3kVFOWqMQWVyy8oppX/RIP7aucF0VevF1huKb347R1P1JmPyIKPV
	qj/TX3P/i/ZseTHsGdMpGTikVPaxJUg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-PY60VuVMM5m-bVieIOg44w-1; Wed, 03 Jul 2024 12:21:40 -0400
X-MC-Unique: PY60VuVMM5m-bVieIOg44w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58c38bcd765so1268061a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2024 09:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023699; x=1720628499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
        b=N0yT+aqzAbPFDmy+BnQIcrfWQ/6bE5HjhwJ0EhH2TC0hJqeFCSvKPqJkIiEFKOtUtq
         vkKKL3+XSER1p51N1BS2/fvFKsIBKZ5juMyoJurWiaTeVibvQvsZUzGZ9JADEx2iKegj
         Y0oq64pJLo/tFR6C3f08RCXwXdToRJDYWFPifAxVkVqS9+cQg2Xh34Xj1hvFQ6FgHM//
         UoxjkHEOCYyGj77WbGoBbrSuf9QFT/2FCgoeiblTTI7W4k4EvxfM+HXJ2YTujF5Bt5vs
         ujQoYAF6/1Yep5DOI1RFjZ07TK9TZxt2n7mPZV4NuHLg5yjtCjWsBfCYmBCFqyeOcGFy
         Pqgg==
X-Forwarded-Encrypted: i=1; AJvYcCVq+9qVpM847vERQ1leWvH8l7dImBB6v4zCr1Ivi4vVaPIvk/hF0uJNcRsy7yNRdrC8L2/ApZCs8VKDvMiO57bTG/EQms6aq7MWJw==
X-Gm-Message-State: AOJu0Yyvmu/wURX7MBG0tA4gAnHa0mBQXHQn0ETTpVoqFzP6VNBKf027
	Y53CJZHVcvMs4+6tiT/icvQKNtjjO+ZH6D9wNtykX+k1duOY0R1eNTnRcFvhtSx32JMSXzp5XKj
	052pwvjyO09jK90ljz3EHLiBFADEUpxTE9T3dukhaQXGQf+iy+oU4YyTNhXFxsRBb2Xx1aP5pCs
	8od9Moox1erctd2vxlNsVnQ0SDAkTLyiTt3w==
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id 4fb4d7f45d1cf-5879f59bc0dmr8314479a12.16.1720023699469;
        Wed, 03 Jul 2024 09:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrQmfzqoCkSKEjGQCytFKKt1qFveCCZLiKDvdyFB5I6punigduS2DoMmXGBJNBjrgv6P7Ec5gPWUP4aOKX74=
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id
 4fb4d7f45d1cf-5879f59bc0dmr8314456a12.16.1720023699020; Wed, 03 Jul 2024
 09:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:21:01 +0200
Message-ID: <CAJaqyWdK4u0Y2EbgyWsYupLvybuBK=waf_qhUqne2q9wHvuEqA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 16/24] vdpa/mlx5: Accept Init -> Ready VQ
 transition in resume_vq()
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
> Until now resume_vq() was used only for the suspend/resume scenario.
> This change also allows calling resume_vq() to bring it from Init to
> Ready state (VQ initialization).
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0a62ce0b4af8..adcc4d63cf83 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *nde=
v)
>
>  static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
>  {
> -       if (!mvq->initialized || !is_resumable(ndev))
> +       if (!mvq->initialized)
>                 return;
>
> -       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
> +       switch (mvq->fw_state) {
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> +               /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
> +                * This should be fixed soon. After that, a single comman=
d can be used.
> +                */
> +               if (modify_virtqueue(ndev, mvq, 0))
> +                       mlx5_vdpa_warn(&ndev->mvdev,
> +                               "modify vq properties failed for vq %u\n"=
, mvq->index);
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +               if (!is_resumable(ndev)) {
> +                       mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resuma=
ble\n", mvq->index);
> +                       return;
> +               }
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
>                 return;
> +       default:
> +               mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from ba=
d state %d\n",
> +                              mvq->index, mvq->fw_state);
> +               return;
> +       }
>
>         if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_RDY))
>                 mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u\n", mvq->index);
>
> --
> 2.45.1
>


