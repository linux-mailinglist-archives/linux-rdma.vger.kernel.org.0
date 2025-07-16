Return-Path: <linux-rdma+bounces-12208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0EB06DC8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 08:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1921891BFB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674027A455;
	Wed, 16 Jul 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZswQbBqL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3B1D5CED;
	Wed, 16 Jul 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646870; cv=none; b=flaoxyDhbd7v3PKycH8ZAY41RjS2/iwew3SjIhjqsKUMtD40PxcFy8w629qRVDM0DEq+rkmIxQy8Qvj2Eofdqv2JJkxeAvea5tJ52N3eB5dVYEIL5QbZ+XSlqS5gERNqRFndKXXmCwg7158/OhAV09v7DE418N5/HE34GNyY0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646870; c=relaxed/simple;
	bh=ELxF6Rsm67tznC+VYpiWbBK2wQPbxOR1mWi46OfR3xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4WVMduyYzd/ghpI0xYhUYMtK2Lko2aGmH62PZGEk7DlnKKWVFCPlTTIAAhrfS62bLs7rc5WvTqP99ouq8tgFC/+g3g0p/8YBFUJHlKN1zdGBmstdfwyfh/ofsNpTUEWhFzDd9vI8Labv63o+ETow1E3/gyDKoX8Dnxp7gUkbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZswQbBqL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00283a5so27975095e9.0;
        Tue, 15 Jul 2025 23:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752646866; x=1753251666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56uD9SyE0IQHcvuX/OShaw3UWeO3kygh4tIChfdx0hA=;
        b=ZswQbBqLeKKd0+ut6lLlSL/wW3QIYEabzTMvlYqgoDsQbV/1Kq3wr25vE5pX1tKLwY
         LhSv3RBXyf8cxxRL45O+scciqXePZAzWS98p+5JMTOUuPLFtwEJIiwPoupJ0REz5K6SR
         JEJyqzIKZR6qsaK+vEwcOcZPflGRswjWP9hWiPWsV5YEbo2Qvr2qVG4IxBDIO5QVDyZt
         vWc1zbGMG0c4ePGLbnyCn08H6Nv0yr3jQZh4Y8lsbBnQAUcmFKJlk3dsEPx5HHnqkVjH
         0Es6beTO+UZogTAQBEnG2KWc4NeTywyzg4AEpcmphVEq96Lp4m1GlB+8VM2dBym3rttY
         Jmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752646866; x=1753251666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56uD9SyE0IQHcvuX/OShaw3UWeO3kygh4tIChfdx0hA=;
        b=VIMfoX3VGCBmo7sbnabJG31naoPak3y6FlSxO7fz4LGTHcGhAuMbPXz5d6DvS/lzSq
         lZPdOy6mmPkntMVj41sW7LzBOHwfByW1G20YM15vlsOj2YLV3za0FVMm3RlVXAPGwdSk
         z+gDWGYqqotVObIHfabOIejop/fvUcHv6c33TygbB5BxAUGm0RPAVmTZTI6rXfTRuvwu
         BpR7GW68yHAh5GNfqrbNw4Xyg13cemN7f6J902P1ohYtt1Any08rpVQgZsdJjH0qj8bi
         qMXc07EgGUdQHedSoQx1mbWC4WDnM02DjSvo7n70a8y4cCiWhwRhMIv5AtlUfLn7N+Yf
         NhVA==
X-Forwarded-Encrypted: i=1; AJvYcCUtkWujujZNs8yrA59Pb8ENrT5pqayq3xqwkkPSgE3QoHclFWBYAtyVD7j3PvJCUhL8OK8Gx28gZ/ki@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQbv+i5GX10yegqSNlUDHUPo3jNFOl6x31ea6XAqqs7OJYPR6
	S4EgQJZvbCiveAAlRezO9Bvu5Apky8HzPnlBtV9cOJ/1uAHhBSEuhkWQ
X-Gm-Gg: ASbGncvOv+qBY2i2mhF1r3DWscpgpP4uZw+CPXzBnl/53mn9iWagildTFmQkZZzvqie
	zSl5sOtC7oce0pzc25v2lFwns/O50ZEKYkpSFFCkpVfOkGclcK+6d8mOskFShJ56cOrUgdneLV/
	lSvsKpwts11GVfteQ2l3ZyVnqK4qov4lcWQZh7mVLj2ZRhPqvk4NjIpr8u3WCWpTQhyqk+nt9BL
	hIHGBicwBWbiNPDFjbrKV6d+906aEwW3iSEBEy6NCZ3inBrIsjiBtNHD/N2n/++goPh2ZnrkaXO
	SvAkwpbFNNb4njtMVO9wmyf7CTbv4nh0hkk1zds3cGCOt9jdX3fet2SNQ9B3s96ZsSfKShzVG5w
	S4fJm5/Y3Bnh27LFX1FOEwLtnk26qIDRMzMl7mt3SPqf9FA==
X-Google-Smtp-Source: AGHT+IEsSy/n/FGec1Fc0PuUqm7HoXy3h3RE0tFYu79dHrC8k3M2KnDAF3Ups6FNOKK6/oTuHwyBYA==
X-Received: by 2002:a05:600c:80c3:b0:456:f85:469b with SMTP id 5b1f17b1804b1-4562ee45c9cmr5599465e9.25.1752646866020;
        Tue, 15 Jul 2025 23:21:06 -0700 (PDT)
Received: from [10.80.16.197] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8b0934sm10406885e9.40.2025.07.15.23.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 23:21:04 -0700 (PDT)
Message-ID: <72f6c840-0469-461b-834b-2258a06c9cf3@gmail.com>
Date: Wed, 16 Jul 2025 09:21:01 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2025 23:20, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> gso_size is expected by the networking stack to be the size of the
> payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
> is the full sized frame (including the headers). Dividing cqe_bcnt by
> lro_num_seg will then give incorrect results.
> 
> For example, running a bpftrace higher up in the TCP-stack
> (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 even
> though in reality the payload was only 1448 bytes.
> 
> This can have unintended consequences:
> - In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
> will be 1448 (because tp->advmss is 1448). Thus, we will always
> recompute scaling_ratio each time an LRO-packet is received.
> - In tcp_gro_receive(), it will interfere with the decision whether or
> not to flush and thus potentially result in less gro'ed packets.
> 
> So, we need to discount the protocol headers from cqe_bcnt so we can
> actually divide the payload by lro_num_seg to get the real gso_size.
> 
> v2:
>   - Use "(unsigned char *)tcp + tcp->doff * 4 - skb->data)" to compute header-len
>     (Tariq Toukan <tariqt@nvidia.com>)
>   - Improve commit-message (Gal Pressman <gal@nvidia.com>)
> 
> Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 84b1ab8233b8107f0d954ea29c33601b279a2c27..7462514c7f3d1606339ede13a6207c1629ab65a3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1154,8 +1154,9 @@ static void mlx5e_lro_update_tcp_hdr(struct mlx5_cqe64 *cqe, struct tcphdr *tcp)
>   	}
>   }
>   
> -static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
> -				 u32 cqe_bcnt)
> +static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
> +					 struct mlx5_cqe64 *cqe,
> +					 u32 cqe_bcnt)
>   {
>   	struct ethhdr	*eth = (struct ethhdr *)(skb->data);
>   	struct tcphdr	*tcp;
> @@ -1205,6 +1206,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
>   		tcp->check = tcp_v6_check(payload_len, &ipv6->saddr,
>   					  &ipv6->daddr, check);
>   	}
> +
> +	return (unsigned int)((unsigned char *)tcp + tcp->doff * 4 - skb->data);
>   }
>   
>   static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
> @@ -1561,8 +1564,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
>   		mlx5e_macsec_offload_handle_rx_skb(netdev, skb, cqe);
>   
>   	if (lro_num_seg > 1) {
> -		mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
> -		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt, lro_num_seg);
> +		unsigned int hdrlen = mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);
> +
> +		skb_shinfo(skb)->gso_size = DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg);
>   		/* Subtract one since we already counted this as one
>   		 * "regular" packet in mlx5e_complete_rx_cqe()
>   		 */
> 
> ---
> base-commit: 0e9418961f897be59b1fab6e31ae1b09a0bae902
> change-id: 20250714-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-852b450a8dad
> 
> Best regards,

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

