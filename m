Return-Path: <linux-rdma+bounces-10178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404DBAB08FA
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 05:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08B24C7667
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811223A9BE;
	Fri,  9 May 2025 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffraIcol"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242DF1372;
	Fri,  9 May 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746762643; cv=none; b=og9EmKyVXO+EhWry/Jbo1wn+5IL6M6JBasZdM+Pqo4ho3NFFZoRpcu2yhiQG7xzmR02YnF5LORukci2H6s7e8rxvzKQpYo3is3+9vz3Zuo49uKiBw+VcG+6uf/VCgjHFC5aNiecNSDYGC9TMbM0rwbAGHorok86+fWtqsNGSJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746762643; c=relaxed/simple;
	bh=hy5pzYUav/BP0YDgiOVnShocA7zS7BA61sxle7neUg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRLaAhBkeJrE8rLW0+ZM+9Z5flFkRO4w3Y3IbbKijLsYKiYfdCWtV/v5b++lTW0bWq/7WXXWWhh5gz3ZQpfm7RknGt8+yzyFkZiil9ydnAk87NUkxN8b7huIqIbrIEy3Tdaq9BvCRexB/3YRTfaLTfFcRUUjLY+saKXUXUzabgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffraIcol; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d8fc9dbce4so10680865ab.0;
        Thu, 08 May 2025 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746762641; x=1747367441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaSQSE/HMH1qJ6r6p4XK/7TbsZvPwZPNrcjteVR+WAA=;
        b=ffraIcolguOcG6A5hkCFVz/Mhciihmqrd4Vltqyo65uVCEvmp8l/7W30443ztZ00jq
         l8TYkzIjxIUk8b9/V0MtDhGGCrXHhSKB9K8bETH27YgijEt7QUTIPit1cIxubc9PhW6V
         Ybl2Ui34ZyUKEElG+oR+lY3MhAgAEA1rq05Txbs2suVUr6XrRkc9hKaYqqB89APjxQ24
         d6NlU9zlNjjRkb9+VgED13mxRlC89gxmKZAnb43McCuxVN5Flg8eOIuq+SU8HeKtAZK8
         K/ziml3vF3YVVLSn9SGIqoG3+To5+1LRAcBbp1Qm5GMYOFUv4z2l6tEnYBVi+pDBqC6C
         y5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746762641; x=1747367441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaSQSE/HMH1qJ6r6p4XK/7TbsZvPwZPNrcjteVR+WAA=;
        b=MbkiliDROCrMdzLKJGxpbou10Jysss2ssSmqDojyIxapAMFe+cd27+8t2uhW3l/NIE
         sdW7+vRrRBwhrdS20owU7jUtkOyjo3i/oaiUMOefRQa2GaDpuGp+92xG108GxUpNDRLd
         tMh/Vshdq27TXfima6m274lo4cBPjcpPmV2wGODWcaeW+cvu5ywlsmQpG3tFZgjYnLL4
         KL+5el5jC5en8v9z+S3gmpqHHB3G5cmDWv9BaIv4GHtlXAdtD8PeNqGBCnb5M3evyRjw
         72PEJCGHBFCx1dg1tfNHD4IWlBrr8CRoK1VcYuTDgBBM4TftyTwNOmQrIN9IG8dpqaQX
         6ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm9LrgCDR/DGnBX/8aq8vksYsKsoUVdgmtuKrEqqnw7WAqTcZFzZkSY7hi8tbrz/1pbb7sOMAoqmPYf6s=@vger.kernel.org, AJvYcCUxj4c5D0CdKw9PdpJ7JrFsmCogx0qQ7lkgZNXEh3LgbMNgVaoG/WYxbph002KuaamiudnHlHRcu2haNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wXnn+Go4oGwSGcR1oJ3FabtaJrvwjHTVZ2C3R1Z0Y6QylZDj
	GXlaYyf/x9Il/HzewVQ2nGYPWvjGQahGVA1hRFYi47DA4M6LEJXdR0K57PZvzrKPEuM/BeESFYX
	ZlIpZiWhcuhm4Uk+oIJ7drYBrb10=
X-Gm-Gg: ASbGnctaUQqzGUsRRwAwOkFK1Svxidg4SCRXyrI72lXjMWYn11UR6T6/j2EmWOVgaku
	oZkwyOtj7kcNiER4euOHuA5qDGTi/oP8fJ5mawswoQD5Izr2kc2ps98eKSyc3Mi0MyVwY8iDs7p
	3ly8F/d7K1AkoKNzDe1+7Bk9D3AOqBnpSN
X-Google-Smtp-Source: AGHT+IGDsiNP6b7Ntgyd9mrDWZhyyjw+qLzWqKgXqKRu/+adjAGmGTajymdrLVvCtn7gmze+JihzDCvnPKWSScgjTWc=
X-Received: by 2002:a05:6e02:1fc8:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3da7e34871amr18179335ab.8.1746762641045; Thu, 08 May 2025
 20:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508235109.585096-1-stfomichev@gmail.com>
In-Reply-To: <20250508235109.585096-1-stfomichev@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 9 May 2025 11:50:04 +0800
X-Gm-Features: AX0GCFthO-yBe0GwNZFZ1xaNDpopRKOfM4mk-G42AtzYTfPnYJnCB8Sks0K_y7Y
Message-ID: <CAL+tcoCwAUNmBuN1KR5oa90nZGMqOeNc-xEYdi2nairE5-1BBw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 7:51=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>

Thanks for working on this.

An a bit irrelevant topic here is it seems we miss adding
SOF_TIMESTAMPING_TX_SOFTWARE in mlx4_en_get_ts_info() since mlx4 has
used skb_tx_timestamp function in mlx4_en_xmit(). IIUC, I'm going to
send a patch to add this flag.

Thanks,
Jason

> ---
> v2: rename mlx5e_tx_skb_update_hwts_flags (Tariq & Jason)
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index fdf9e9bb99ac..e399d7a3d6cb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -1689,6 +1689,7 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *pr=
iv,
>                 return 0;
>
>         info->so_timestamping =3D SOF_TIMESTAMPING_TX_HARDWARE |
> +                               SOF_TIMESTAMPING_TX_SOFTWARE |
>                                 SOF_TIMESTAMPING_RX_HARDWARE |
>                                 SOF_TIMESTAMPING_RAW_HARDWARE;
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_tx.c
> index 4fd853d19e31..55a8629f0792 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -337,10 +337,11 @@ static void mlx5e_sq_calc_wqe_attr(struct sk_buff *=
skb, const struct mlx5e_tx_at
>         };
>  }
>
> -static void mlx5e_tx_skb_update_hwts_flags(struct sk_buff *skb)
> +static void mlx5e_tx_skb_update_ts_flags(struct sk_buff *skb)
>  {
>         if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>                 skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +       skb_tx_timestamp(skb);
>  }
>
>  static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)
> @@ -392,7 +393,7 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct s=
k_buff *skb,
>         cseg->opmod_idx_opcode =3D cpu_to_be32((sq->pc << 8) | attr->opco=
de);
>         cseg->qpn_ds           =3D cpu_to_be32((sq->sqn << 8) | wqe_attr-=
>ds_cnt);
>
> -       mlx5e_tx_skb_update_hwts_flags(skb);
> +       mlx5e_tx_skb_update_ts_flags(skb);
>
>         sq->pc +=3D wi->num_wqebbs;
>
> @@ -625,7 +626,7 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk=
_buff *skb,
>         mlx5e_dma_push(sq, txd.dma_addr, txd.len, MLX5E_DMA_MAP_SINGLE);
>         mlx5e_skb_fifo_push(&sq->db.skb_fifo, skb);
>         mlx5e_tx_mpwqe_add_dseg(sq, &txd);
> -       mlx5e_tx_skb_update_hwts_flags(skb);
> +       mlx5e_tx_skb_update_ts_flags(skb);
>
>         if (unlikely(mlx5e_tx_mpwqe_is_full(&sq->mpwqe))) {
>                 /* Might stop the queue and affect the retval of __netdev=
_tx_sent_queue. */
> --
> 2.49.0
>

