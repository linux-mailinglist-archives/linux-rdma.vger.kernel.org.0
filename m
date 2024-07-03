Return-Path: <linux-rdma+bounces-3634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA1926615
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381EF1F233BE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BAA18628F;
	Wed,  3 Jul 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBxtOUuC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8452BD19
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jul 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023812; cv=none; b=ugtc/cle3ghpiF4kRx+XvyE9c08BXFLDCJsXHFmcQv3mFDbytoDHKGRqVWDfQfmY+fB6kZ+o453VcgAVqG3WL53yxdT0niZE/cpotOHbEPmRZ980xuJaPinOBh7RbW28+rycpFIV+VmNVeL3rQDFSpeNxph3GW6IF8WD9LmExPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023812; c=relaxed/simple;
	bh=yAl9WkIF75Z5792jsKO6kzvCg4MDRUb7mflCnX2qKpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOUEYtMQ8jLjgelEdGHlrEuuC4hStSX3q2diX5wkS7tRJvYtKwbg0KayowndCvimZnSnk0AuILZpHb80E2BxK3Ts24aAS4c3yILHrE1Yk2tlBRQ+3AFD16s0YNsjVMCi90xj6dd3ofudGGwTjFbnQ5o7Cb7MYhIuEDaMpS8fBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBxtOUuC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
	b=SBxtOUuCG3UlM9L0/b3N7Zp77cLVVF/US/TUsTxSeC4nGfSDpFDOGtesjWotgxUshvV+gP
	EIwjVhCiokLUL+H7l1ohcTqZFqrUGNCQ6PE3zQg6TsVzHg1IGVSj/8Sr0ZHZtpTQ4ylrEO
	kgA8yuEyI+RtcviyB5wlmgkJquZH3Mk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-T9qYGxP7PmSDq1fsyPfjKA-1; Wed, 03 Jul 2024 12:23:27 -0400
X-MC-Unique: T9qYGxP7PmSDq1fsyPfjKA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-58bd8406816so1407522a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2024 09:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023806; x=1720628606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
        b=oRdNhCYIOyIvQoBG1grIiocFnZOq+epWwGZB3q2GX0PPXGwoyTbKKZZmydIJZEwPPt
         /J2+oTQyiBW7RSiqw4NBZEdMOV8seM2cb/0rvP/1KpddwA3RUYWgdYuTecLABHzVTJQJ
         KPH7WkKyTR2/v2w+sBHfsZwjgoSfyTrY2dqH4q4lt18TAs1KtiCGHEwyoCm0gDcIqBA6
         AJs9N27E0scvaq/2SmXIIgXfE7g+4lK+ARnjdo+7l8RC4dfacgkyVveMI/jCWDe14yOn
         N0ozb35BFHoTaGS/da7xhX+bdJL4fHpvPcvrIeF4n697CTBTVWR5/8CQ0RkmN+sTMXd1
         l7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVH2k1oFhhjvPLAmHogyDOkeJqgEEDms9mBm1jw+mMIWLP2DDWXAc51c3aZkyFDqfYdaoSeFMn2wBpTinMe9f8f3xEg4DYmjLcIQQ==
X-Gm-Message-State: AOJu0YzLJ9G8niWbrbcnZRVkVdHd/dTfGdlNWUzw7HC7aSfZp2Wx68ZQ
	Il/in8E7HK08d8b5ZU7mjAe0sq9YMGXksCN/5xkxTLXm8EkIU8eCLh2vA3fGOA6JW6Mw5IM5/0U
	+hZezb6WVqB4wr0DUYBhqVp/b+nlO/W+gNOttwkxYddF/Fs9NZwdSFV9/jiZJtfQ7eJFwVwo9ef
	Pm1qm4SOaL6F2p1PrWx16qi3Qx8W4fda22iw==
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id 4fb4d7f45d1cf-587a0637437mr7847864a12.26.1720023806614;
        Wed, 03 Jul 2024 09:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDKcKhOUx+NmAMpJL8tgtpN3L8p4uaUWiZMnuqg99iVFuWIDVp5qSLrtsQb/GpER4ZLfVxi176Yy0Dko+cScU=
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-587a0637437mr7847840a12.26.1720023806248; Wed, 03 Jul 2024
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:22:47 +0200
Message-ID: <CAJaqyWccNsTo16CzUmSwNLFw2CTinrQ47YQ2JjRndyHLeRVFNg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 19/24] vdpa/mlx5: Forward error in suspend/resume device
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Start using the suspend/resume_vq() error return codes previously added.
>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e65d488f7a08..ce1f6a1f36cd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       int err;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       suspend_vqs(ndev);
> +       err =3D suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_vdpa_resume(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev;
> +       int err;
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> @@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *v=
dev)
>
>         down_write(&ndev->reslock);
>         mvdev->suspended =3D false;
> -       resume_vqs(ndev);
> +       err =3D resume_vqs(ndev);
>         register_link_notifier(ndev);
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
>
> --
> 2.45.1
>


