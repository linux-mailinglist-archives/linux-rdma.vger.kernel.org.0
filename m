Return-Path: <linux-rdma+bounces-11234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00891AD675F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5723ABDA1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 05:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE71D7999;
	Thu, 12 Jun 2025 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rxnklgl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A61798F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 05:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706436; cv=none; b=HLBMNFDMefR40EctnwFiEcVGO/VUYUVQ2H5x3CM1808agl+BnNrTEQL74xHGMFSoZW7LKr97rxnuXGD6Ruxf39/rzxpX0tkpgc7hcxK5LiWOpY+empgM3s+Cr54KoJfb5pPFLS8h69KCphSt3Umm+1fF6yayDaOvnhO8JashYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706436; c=relaxed/simple;
	bh=Esu639NQ3h0pUolsE+L62kqRdItgxrjwHM5dB+O9x3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqAWMwx/v5AbAdKix/DcRU4zg7X/wAPGWdoneECA6zYacTogn8qVenhD1+0VwVYqrpvnn+RMFwHVLTkzdYNXxL/nUYCgi412vf1MnusblE26/GaflKUKZCiBKyl6MtzUplNWEPk4L9ns/rPqfqAoYWdhU6cmNlL6mNSZWMO1wS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rxnklgl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2348ac8e0b4so82335ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 22:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749706434; x=1750311234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MG8DHTvq/qRGMg3QrUciQGDqEK1excvKUOp84PPj3c=;
        b=3rxnklgli8VZrJiIqyvzeFF3ekCi35NjXdlTzK5t1ap/H1dnt/DlbrtZQOeRgvUO/7
         dZRGUNIr7gNxeGWoe5y+aAt/EJVbDpz+/Q00y3/GGaHwPCgpXQUa9eWb7odGB4vzerZN
         zgzncDR/9mZ3o08dQX3U4eMUlZeaWiW/F0bEabvFRVebimCJYMGDte/qoY5J8mzb9EQR
         30a5xgTmjBQGOJGKj0Fyi637Qmw43GpalD98aDQFJy8RvTvkozeSmh1TFY4AUPTF55+7
         BBjvxqABbIyTFhRvvtJGCUE2rcnnpqQvncyompZwvLaWGZT5f5dCrp4VdOUa3SA6/alO
         eM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749706434; x=1750311234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MG8DHTvq/qRGMg3QrUciQGDqEK1excvKUOp84PPj3c=;
        b=L9MGO36SYD6U26Wis8v5ypkH1tZLAGkYlJ3JBoBE0KkpFP9fj2Ohq+ckIF5WqQPh85
         KbnLaVBf3LSMa6xJNwsaw+LRPR7jTt6CRGYt7tsX0tCJmg0ux92kgmEE9kzzGwjBNeRC
         +Bw6kCmVnxAisjnrutWmTZKhOzeiWeVxSQ9WEZTMQqbkUx0pSK5S0RV/uq4Q845otI5K
         GRPk3hBpYKXT5M4KzP8nq7AiCXpy3qFPF/zQ1BFF3ErrTmpqgImi1JH5+EzE2UwzVJjc
         /fGIjEMYITlN7gbgpdlWuBPYS6BuVSHZBDKEqbEHbA56dkMlnLd2FdEfpvd8ukqpdiDg
         yqhg==
X-Forwarded-Encrypted: i=1; AJvYcCX3vREZflbx1j3fdC+5PpdUi67ej7h7qqaVck/mH0YDwyvUOH+YiOeZK/n8SRs4B37YPoAWRUp6i2Tk@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjcbawB5CiUWwb7f8nQblTnhaNiw6Wnj10am51MXyabc+Ha1Z
	EarWo4OgBtYlZDsu28WDDamROTU05bw4wVPUJVpFQNOOJV2NrnrfIV2YRzeIgr41y4NtKGe392J
	1NMgcCZp/UwdkfbqZiGrJTqOpRV+Hu6R26LHR8NOc
X-Gm-Gg: ASbGncv347nh5WQeBeaiZbF9kOgKPMR5e4ND7/i0RGZsHlhfuAMslH5V9FmdPmvIdHn
	zbMqBklYDoaQ3TNamyV0QIdKSSf3SefpCC9y89gJNSree3hAJBD+4pvIHN92AyHDIC5yZT/RPw7
	OW/EymskUfDzyEn6euiYrcn89stUzJJ04aei6uSWGZIF2b
X-Google-Smtp-Source: AGHT+IGXAg/B6LBkZbDCWSh7HnwG3gh9i4+QKa2dl2PrE4nN9ppued4dSt9P5QJ+xN+GLNCTbDB2L7Rfw46DFAwqD5E=
X-Received: by 2002:a17:902:e545:b0:22c:3cda:df11 with SMTP id
 d9443c01a7336-2364dd812f0mr1702785ad.10.1749706434224; Wed, 11 Jun 2025
 22:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609145833.990793-1-mbloch@nvidia.com> <20250609145833.990793-11-mbloch@nvidia.com>
In-Reply-To: <20250609145833.990793-11-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:33:41 -0700
X-Gm-Features: AX0GCFsYSgx73nrC-SXHzv68aZPiBHRhi1b3Qjgt6e6IXA1Ei-CkUqpGNyxM2ik
Message-ID: <CAHS8izOX8t-Xu+mseiRBvLDYmk6G+iH=tX6t4SWY2TKBau7r-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/12] net/mlx5e: Implement queue mgmt ops and
 single channel swap
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 8:08=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrote=
:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
> and create the new channel resources, similar to
> mlx5e_safe_switch_params, but here we do it for a single channel using
> existing params, sort of a clone channel.
> To swap the old channel with the new one, we deactivate and close the
> old channel then replace it with the new one, since the swap procedure
> doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index a51e204bd364..90687392545c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5494,6 +5494,102 @@ static const struct netdev_stat_ops mlx5e_stat_op=
s =3D {
>         .get_base_stats      =3D mlx5e_get_base_stats,
>  };
>
> +struct mlx5_qmgmt_data {
> +       struct mlx5e_channel *c;
> +       struct mlx5e_channel_param cparam;
> +};
> +
> +static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
> +                                int queue_index)
> +{
> +       struct mlx5_qmgmt_data *new =3D (struct mlx5_qmgmt_data *)newq;
> +       struct mlx5e_priv *priv =3D netdev_priv(dev);
> +       struct mlx5e_channels *chs =3D &priv->channels;
> +       struct mlx5e_params params =3D chs->params;
> +       struct mlx5_core_dev *mdev;
> +       int err;
> +
> +       mutex_lock(&priv->state_lock);
> +       if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
> +               err =3D -ENODEV;
> +               goto unlock;
> +       }
> +
> +       if (queue_index >=3D chs->num) {
> +               err =3D -ERANGE;
> +               goto unlock;
> +       }
> +
> +       if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
> +           chs->params.ptp_rx   ||
> +           chs->params.xdp_prog ||
> +           priv->htb) {
> +               netdev_err(priv->netdev,
> +                          "Cloning channels with Port/rx PTP, XDP or HTB=
 is not supported\n");
> +               err =3D -EOPNOTSUPP;
> +               goto unlock;
> +       }
> +
> +       mdev =3D mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
> +       err =3D mlx5e_build_channel_param(mdev, &params, &new->cparam);
> +       if (err) {
> +               return err;
> +               goto unlock;
> +       }
> +
> +       err =3D mlx5e_open_channel(priv, queue_index, &params, NULL, &new=
->c);
> +unlock:
> +       mutex_unlock(&priv->state_lock);
> +       return err;
> +}
> +
> +static void mlx5e_queue_mem_free(struct net_device *dev, void *mem)
> +{
> +       struct mlx5_qmgmt_data *data =3D (struct mlx5_qmgmt_data *)mem;
> +
> +       /* not supposed to happen since mlx5e_queue_start never fails
> +        * but this is how this should be implemented just in case
> +        */
> +       if (data->c)
> +               mlx5e_close_channel(data->c);
> +}
> +
> +static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queu=
e_index)
> +{
> +       /* mlx5e_queue_start does not fail, we stop the old queue there *=
/
> +       return 0;
> +}

Is this really better than maintaining uniformity of behavior between
the drivers that support the queue mgmt api and just doing the
mlx5e_deactivate_priv_channels and mlx5e_close_channel in the stop
like core sorta expects?

We currently use the ndos to restart a queue, but I'm imagining in the
future we can expand it to create queues on behalf of the queues. The
stop queue API may be reused in other contexts, like maybe to kill a
dynamically created devmem queue or something, and this specific
driver may stop working because stop actually doesn't do anything?

--=20
Thanks,
Mina

