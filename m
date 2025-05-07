Return-Path: <linux-rdma+bounces-10110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648AEAAD20D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 02:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07A3520D5F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 00:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D3A4B1E4E;
	Wed,  7 May 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvKdCbXV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABF1EEBA;
	Wed,  7 May 2025 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577003; cv=none; b=FfIujGr58DMnJRNal0a4fyIfUWK1mp7dKMEi6STCPgvUwG5R/pW+Yw9I3qRK2B6/sdrQ3y5qGnzA/N63SlkRnkxtRPjZTDy79qdb7oowy9b0UTjJG6M765UMipjSfxQPi5KB8zz5RWz7blJBnqd0Fl3Y5DI0l3AXX3KlrvinEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577003; c=relaxed/simple;
	bh=WIblESYxXagNVxFzdusv4dclpEA4QpzqQV7zQARweF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKbCr+2agNl6lJP5VwLEGM4qdbM5XeyFKORC/XKuxVbHVfcSgZNjatpWXrUNuN89duN6p/+x719Ck5/tQYeGCZRpjowvfSp8n+mF6ahqPnwvsff8K7OjGk/Kfl/6jtlXHWrkuwADc67KgPelnNbrexqBlPMIHJ0ig56Q4zfQYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvKdCbXV; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3da739653b2so974835ab.0;
        Tue, 06 May 2025 17:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746577001; x=1747181801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERN4tZBNNxWUBbXOxBBa/C7QnG/J+3w3a9uKSXFs/2E=;
        b=YvKdCbXV2NwAOiz7xKTYqU5wUDecj0eh6okGZgsqt+tfB3g4pJbPMs9JHRpG0jls34
         ltFa4zPf8yyGskqzbCNUm0NDKB9qWGovicrsPSK1pNBxWCOMcHlKymMnbJNHUtzueBRK
         43wN32MEtk+Hyutev11OA3fo71PxPAxVVCZiAp29ShcGay+KA0Ko591f50LHwzLRUw5d
         6yMsDeJ/h2ElGxu67W6fY0hGK7r0z50LSPpiX1TmyE6fUKRyik8GwKmiSzmkjroE1P1f
         ZVFo2benA1GPJXlDQVUEYIUX9KYSom61M7LBfQEw/AoRcYkSAcOhXR3KGB/FAFaUxgpM
         8Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746577001; x=1747181801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERN4tZBNNxWUBbXOxBBa/C7QnG/J+3w3a9uKSXFs/2E=;
        b=PBtryJ5QneWurcagCN3PamnjZePtvlZ985xGdS/3kdzjPGalppL30p3JiXDM5SbzyS
         sFqEhQUlAqL4gIrF47QsHEglk7pLL7xCqwBCXtB2mLtGEOUt0G5qGWnreQ19Cmsp0j2V
         Me8eMHuwSnSn/GUvNIUHJJ6DQ6GMfRpxroOFd5pw+Z7olofd6UwFSVuBVCX5KSBNDmXf
         G6M2kN0WNf/ysdH1Tcohp8TJYFhdugxEAUcna5EVPCWjo17QPL13ycUk23A0SM1O0tdN
         zCjE01PISNGQG4mDUebKqnT488kFntIy6n7pMwkwDR0nswaUmqJioALMMU/I1fzd+rCB
         9hwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSV/ElePCSCiUDLD3NcrITVjDAj+R/NaV8qMRl4ilFZr3QRBfiNO+H89TwL9LXyricXlroHHJ1ug6HR04=@vger.kernel.org, AJvYcCVaTGPNt92RMXxY4jyrZaq3p6EF7ofcKZv54pT5WhG/ZjcBUCvx5Z4vETyK/6yABGnbcVVZrzDqdEcFPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKZCz3sNaPhseBCHasAvSRletU5VqLeFv9XBm15VgHPruHzHQ
	KOg64etxJGJBbNoKIUZEBcEHB8JHwUIGry2ZRI4/BW/u5hTza2IIrFNjm7UFSH+Lvog6mz+Ctk9
	6Z762TfyU49n6FqqC7t/rtEEJHq0=
X-Gm-Gg: ASbGncs084bYV/TbcwOFtzeNHVvvegjWpXOSDvN6TAtLiSXhwAeb/S84HO8cLX47QzK
	cP83QLxunw0ZfH5y+oQCSSr0QvFHdUldrmQlZyikDu/k9KKJHizCAd2GN5A2FTnM3x5nh5av3VU
	v9hbFjiWz1lZVOvTZzCmyv6Q==
X-Google-Smtp-Source: AGHT+IF+RYfQnJXX2wiCv2f8FgLw9KAqzSO3hRhozP+0qGjgOmXPg5RSE0/cNow9QHK8qnUlcemlOTjy+nWSCQxf124=
X-Received: by 2002:a05:6e02:1d92:b0:3d3:f27a:9103 with SMTP id
 e9e14a558f8ab-3da738ed799mr12884645ab.1.1746577001455; Tue, 06 May 2025
 17:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506215508.3611977-1-stfomichev@gmail.com>
In-Reply-To: <20250506215508.3611977-1-stfomichev@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 7 May 2025 08:16:05 +0800
X-Gm-Features: ATxdqUHZDuiLA7f7witp6xXHQswch3oKUZrSiSSAzpg7yLhrFN5x-dJ8eqivnlA
Message-ID: <CAL+tcoCUofwE7zNf95KO75tkiVJkcJ3O4ybu07aYFo-wbV13JA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5: support software TX timestamp
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:57=E2=80=AFAM Stanislav Fomichev <stfomichev@gmail=
.com> wrote:
>
> Having a software timestamp (along with existing hardware one) is
> useful to trace how the packets flow through the stack.
> mlx5e_tx_skb_update_hwts_flags is called from tx paths
> to setup HW timestamp; extend it to add software one as well.
>
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Only one nit as below.

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_tx.c      | 1 +
>  2 files changed, 2 insertions(+)
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
> index 4fd853d19e31..f6dd26ad29e5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
> @@ -341,6 +341,7 @@ static void mlx5e_tx_skb_update_hwts_flags(struct sk_=
buff *skb)

nit: the function name including 'hwts' doesn't reflect the following
software behavior.

Thanks,
Jason

>  {
>         if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
>                 skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> +       skb_tx_timestamp(skb);
>  }
>
>  static void mlx5e_tx_check_stop(struct mlx5e_txqsq *sq)
> --
> 2.49.0
>
>

