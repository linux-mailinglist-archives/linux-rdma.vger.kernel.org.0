Return-Path: <linux-rdma+bounces-15546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0192D1D194
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 09:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E44DB304434A
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9137E2E5;
	Wed, 14 Jan 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgF2FP7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C743126C2
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379008; cv=none; b=SP58uD7ST5DrX1fdKvgH2zYg6kOrj9Es/utsBLC6HMSH2iX7qyIvzuiCjoUr6VQoOjU1COPP9+6oAwdQ3uY1JgbgG4gDJIxRvtowYDCdg0gjjw6QdOFetQx1VAeSYTfh34kOpxbWpGpna77NPcey0tSr7dyxnvzRy7YNzfI/Uzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379008; c=relaxed/simple;
	bh=Hhv50DMy54K6yApXKNaezvMnwfKgacI4gVN/trwQBYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siut8ftDR2IP/3/fuwy6tZGFy9gM+4mDCna2O/S9wKLnOlxs+CQKVwr9xn5gdOI8ScrHZwyDplKdPPcvV0azZdcBwtDfcvS2B/6u16aIaoIDoj4MZanTpfhieh8R9FqQ+GgoDex9pPJXJUSaYygokYm+8Cb39OgOQ51VOoFelZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgF2FP7s; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432dc56951eso3059449f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 00:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768379002; x=1768983802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xepdu9EdtORochsQaLUxrQzpD3d02s+vvZF2V6lRJ0=;
        b=MgF2FP7snIq3oim2WiHSO9smo2K0ZStn7UxTVsZhuAbL8a/yyvQTZwY5ZG3okM1VYq
         tvYzn9V/SPW8+4NIj1wu9Q9RoPeA+YAoIEBfKNb6l3WmvvRUvnhtqPVp5wwmgbwXSC7q
         D+e0c2yJl1i3/WjnJ7Yrzky4UumySnleSFxrmRR2GGaNyhGhuMiVebzrBxREW1YqHblO
         bEUIgdFQuZ33488RhaUEM4aHwG/xTFfQyKmAwf2VZXRR+aUGVeg/TbKoumGxPFA4ZNol
         CWLWkSGYXHQPZ6TE2hBa7lRm7EroEfZQjdM5jBoCE54cRNllOVEjjwf90ygc57aL7Ljs
         yZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768379002; x=1768983802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xepdu9EdtORochsQaLUxrQzpD3d02s+vvZF2V6lRJ0=;
        b=KKk75uTc+pUtnclUvL+Z1Ycbe/nD/2nT1O/I900T2NybYqPvf+40+EBWJB802XRU0t
         a/LDqyF5mn07ZeQ1CXX+KGu6sDIFBsHPByGdYfPeP36DJVE/m+jQ+yyXXF+xDE3YJQ+E
         2bVifyj28A7Z1qxdFNpb/xnehC6J4hZHQGGnBFS6qV8IQ2RGYuQgx6EsbQBw4E8lXLRs
         4axpv5q+ussADLUIuDS9C5hODJjk/03eBIIaOmq2fvqQ7h0VQPm9D1q0pgv/wkD0ppcP
         0UDMgsB3jbh9J+vLqWFL03YI8l/83bSerGLg14GKLWpxISs1PMiHZN00aZqoOXmrTfC/
         MzgA==
X-Forwarded-Encrypted: i=1; AJvYcCXROXZ6oIXU9aTHhhRlzRvDzLraK3FhtXn14UnZMMN4CmqFKRAYr6ZtuKe2HiV9nindwObG/idq3WU8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ncqA4VogntDlBGm9mavFcgy9dXZUUsnS0MEUkK6jb3oAmUEN
	MwKnQmN/0Inwl+fUbSssM2FUEz3nqgdPKszj6yqeJjKGmEaBtayf0Hc4
X-Gm-Gg: AY/fxX7OSmLNFI8meAbhdDY78CMj7zael25CuRL/4WXh50F1Q3bdfvguVKIncOB86EB
	nmZKDTeE+aAHAxyjGMh2FjE3gI8dAnMEdHOWB14uFZmK0hvhAq/YMcNCUyvkoyQfwlhJ4PK/+E+
	ankCWR9OmlHbhv5Vo1zyejo1DuNcSfvt/PsNKeSdetVyL6H97mDI8ohhXfL44rI3Sm+rgHNnQrW
	wr2A+1uzMarBhcEd+2IQGy4YBQODebdLY+U0r55PWIc2aT6OmxTFDTRcQE2gWdi653G+riegodm
	9eHg0BOJy0t1K+sYpBg4kQqEDe096WetRRDaskmNu38vZOodTnH3YpS4iCKlheiVWFtdDYCRTQR
	9BGaBZxHUY8eowBYxZIIXD0rqTA2nR1+xz+37JRUP2+QB9fbTHzJ2Bu3uWK4sNAfM7zJw/X5hSk
	z796+4XdSdwdl/U1pMOT3NY4AzxMEHpD/1QuDn7kU=
X-Received: by 2002:a05:6000:1b86:b0:432:8667:51c7 with SMTP id ffacd0b85a97d-4342c553a63mr1357139f8f.44.1768379002222;
        Wed, 14 Jan 2026 00:23:22 -0800 (PST)
Received: from [10.80.1.200] ([72.25.96.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm48672478f8f.29.2026.01.14.00.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 00:23:21 -0800 (PST)
Message-ID: <cfa6e78d-82ca-43d2-a8df-48fcb7d6301e@gmail.com>
Date: Wed, 14 Jan 2026 10:23:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Mask wqe_id when handling rx cqe
To: Leon Hwang <leon.hwang@linux.dev>, netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oz Shlomo <ozsh@mellanox.com>, Paul Blakey <paulb@mellanox.com>,
 Khalid Manaa <khalidm@nvidia.com>, Achiad Shochat <achiad@mellanox.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Huang Fu <leon.huangfu@shopee.com>
References: <20260112080323.65456-1-leon.hwang@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260112080323.65456-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/01/2026 10:03, Leon Hwang wrote:
> The wqe_id from CQE contains wrap counter bits in addition to the WQE
> index. Mask it with sz_m1 to prevent out-of-bounds access to the
> rq->mpwqe.info[] array when wrap counter causes wqe_id to exceed RQ size.
> 
> Without this fix, the driver crashes with NULL pointer dereference:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000020
>    RIP: 0010:mlx5e_skb_from_cqe_mpwrq_linear+0xb3/0x280 [mlx5_core]
>    Call Trace:
>     <IRQ>
>     mlx5e_handle_rx_cqe_mpwrq+0xe3/0x290 [mlx5_core]
>     mlx5e_poll_rx_cq+0x97/0x820 [mlx5_core]
>     mlx5e_napi_poll+0x110/0x820 [mlx5_core]
> 

Hi,

We do not expect out-of-bounds index, fixing it this way is not 
necessarily correct.

Can you please elaborate on your test case, setup, and how to repro?

> Fixes: dfd9e7500cd4 ("net/mlx5e: Rx, Split rep rx mpwqe handler from nic")
> Fixes: f97d5c2a453e ("net/mlx5e: Add handle SHAMPO cqe support")
> Fixes: 461017cb006a ("net/mlx5e: Support RX multi-packet WQE (Striding RQ)")
> Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 5 +++++
>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 6 +++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> index 7e191e1569e8..df8e671d5115 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
> @@ -583,4 +583,9 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
>   
>   	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
>   }
> +
> +static inline u16 mlx5e_rq_cqe_wqe_id(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
> +{
> +	return be16_to_cpu(cqe->wqe_id) & rq->mpwqe.wq.fbc.sz_m1;
> +}
>   #endif
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1f6930c77437..25c04684271c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1957,7 +1957,7 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
>   static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
>   {
>   	u16 cstrides       = mpwrq_get_cqe_consumed_strides(cqe);
> -	u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
> +	u16 wqe_id         = mlx5e_rq_cqe_wqe_id(rq, cqe);
>   	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
>   	u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
>   	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
> @@ -2373,7 +2373,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
>   	u16 cstrides		= mpwrq_get_cqe_consumed_strides(cqe);
>   	u32 data_offset		= wqe_offset & (PAGE_SIZE - 1);
>   	u32 cqe_bcnt		= mpwrq_get_cqe_byte_cnt(cqe);
> -	u16 wqe_id		= be16_to_cpu(cqe->wqe_id);
> +	u16 wqe_id		= mlx5e_rq_cqe_wqe_id(rq, cqe);
>   	u32 page_idx		= wqe_offset >> PAGE_SHIFT;
>   	u16 head_size		= cqe->shampo.header_size;
>   	struct sk_buff **skb	= &rq->hw_gro_data->skb;
> @@ -2478,7 +2478,7 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
>   static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
>   {
>   	u16 cstrides       = mpwrq_get_cqe_consumed_strides(cqe);
> -	u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
> +	u16 wqe_id         = mlx5e_rq_cqe_wqe_id(rq, cqe);
>   	struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
>   	u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
>   	u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;


