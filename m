Return-Path: <linux-rdma+bounces-12110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0986AB03762
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 08:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607A43B95FC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66312236E3;
	Mon, 14 Jul 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuQ/BNGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56741F4CAF;
	Mon, 14 Jul 2025 06:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475780; cv=none; b=XWDeoxJBIHFWn+3K+kKv6c3JX5Nq6Vk6yM/bvvfuwq6pRjiiJrN33+4nu1WK1FMfk9x3jMajvXQILk7d8ujd+82rM8sRHA9MPoXS66I+Jj0hP0WFYTs8WtGZ/VDLa+eQhZ6YoTMq51wj6Ia/L18Fnpk8H2olphyRACiksUYNLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475780; c=relaxed/simple;
	bh=tqelfQ0aKfMeFliO7yH+SiykG4RBC1jevf+cNu7O+Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfOYfcIOsaVFiUM8wAN4ymHamMx6raJnnd0jv470kl8lJxzzET4WstCmwN4K0chYNA6rF0vT0JA/0GyZk39zvkKviAv09mxbgorH89jvgDAEpWigiZ01vDgRv9kARX1VJkBeVQvTwHsD1tkJyVHcK7Nz8vXHpuyBDaOz/uquR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuQ/BNGg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d3f72391so38916915e9.3;
        Sun, 13 Jul 2025 23:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752475775; x=1753080575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkz96+eSsUIjkSI7v0AcOlzeY5SQS6k70W5WLc6IPp4=;
        b=fuQ/BNGgQDnzIqCDo4DZeFyt4JRNMeHb5q7uBeiBiDyCTSM9PzqT1tfYVoVUF3IGX6
         sKOa0cBENdEP4z5ZKs9nh53lGIXccgZKVAQYsHhRBCRmDyO4plj1uHQ/jPILSu/cBmpe
         z2Kbr7Wv/a+yfqD07QJDquJQQu7fBaBtJxc5C7/ZB7gvDWvvx5VEzkcai+7TP0KU38W9
         7eHfbEcqbzarjUDjN4EmheLXiBI04WuqvxF8+cFUG67KKHKUI9BBI8YnF+A0uFplcd+u
         2LDl8RLuZR6ApO5uz3BNIT4h4W3/47U/5NOewwo6wY8XKDPZIkg2sfuIg78v0oIgA78H
         YlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752475775; x=1753080575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkz96+eSsUIjkSI7v0AcOlzeY5SQS6k70W5WLc6IPp4=;
        b=t+dhqfA7xoJ6/fKWMYdlFotxRkXmR5MFje0eOQINcx02ZN0rKTuGg+5Zf/Jc5jlwgl
         asaoWtcFfAVGbWZPd0HaOC//gU7ak1hA9GFaRLWRDswjebBqa1qilMKsi5rlepZGDucm
         GuvXlv24roxX71DA1TDkqkgNVGrJPp8rK5TzTwd7rTRRGxCwpi6Cz0wgHIENulh3Jkc2
         WS+bAqEIBeegiDGr1R/f5gCZXeCKM2rksQ6k5HGeiNapYJDtkYBBeiXuNhLsi8TQuWZC
         1KGk2z6UNfFLR3xu5I20gGUg8TpS7vrLt+KewCFdxA0uxwCdsSkvt4lLlibbyPnzFWZF
         sOng==
X-Forwarded-Encrypted: i=1; AJvYcCXXYW7eqLw7YOickcK9zMVBCCO3MHoW/bJenkDnQnx5GOitPbzSP8/82aMWh0WKWq4D+z+PrAu+VDa+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0wRw4UCMg2E58mMXSv1Gkk1659ziqZGbIsJzkN06UH4D+xYf
	blm0E3zB3/X2gGuHnUc8FX6IyAmQR7T9/PKtlSY0H0/5ju7lmh1Vchy5
X-Gm-Gg: ASbGncti/E+5wn9rTJAKHZ/BIeh8Y1Dv5M/K8Sj4PonafvSBjk7ry66FjKGmaofEzTm
	HYoiiSHIKRZ+N3JlikGyR4qJwX8FhBwYQGGsgysU0egZ0/sqxfa1TDNp5uGn4MAFjDZxOFJUih+
	ZFAtJ3iFu2jpTMEXNeY/UvQ+woA8CQ6lfVEjURE2CqmpiIbJXUq9MNd70ulo5brdqz3dZ2tl7hQ
	R/oZ+JKc5eE/JJlwnmB4SEKr/UFTHCbWYNhP3HtBDOfxlVaxSftV09eBnK2LlkmDEaWAH/4aN3r
	uuNLwzJ3Sas8+u1mMSfNfyuIbCPAb2uRG9YYbXgn4wxb7BrwBVsszfYT3ba5iCfDma3KEpa9LjP
	OYObfwX5HyPFSxwxxR+5jjpg5RCqa4swVgqjGnL8B1vHs1LikEAGxx/jE
X-Google-Smtp-Source: AGHT+IG5cglXsrwLL7ooaUeiJgW/U4pKvLfN8/Snm2GkSAJzF9dPhxNeFjhFdhNTnRpo3ZLip8zh3A==
X-Received: by 2002:a05:600c:138d:b0:453:dbe:7574 with SMTP id 5b1f17b1804b1-454ec15f7bcmr115478015e9.12.1752475774526;
        Sun, 13 Jul 2025 23:49:34 -0700 (PDT)
Received: from [10.80.19.106] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd18a2sm11452412f8f.20.2025.07.13.23.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 23:49:34 -0700 (PDT)
Message-ID: <ea4ce9e9-9070-4733-8c96-41394035f046@gmail.com>
Date: Mon, 14 Jul 2025 09:49:22 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_size when LRO is used
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Amir Vadai <amirv@mellanox.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250710182629.78456-2-cpaasch@openai.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250710182629.78456-2-cpaasch@openai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/07/2025 21:26, christoph.paasch@gmail.com wrote:
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
> So, we need to discount the protocol headers from cqe_bcnt so we can
> actually divide the payload by lro_num_seg to get the real gso_size.
> 
> Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 20 +++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 84b1ab8233b8..e23bb80b0e0d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1154,12 +1154,14 @@ static void mlx5e_lro_update_tcp_hdr(struct mlx5_cqe64 *cqe, struct tcphdr *tcp)
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
>   	int network_depth = 0;
> +	unsigned int hdrlen;
>   	__wsum check;
>   	__be16 proto;
>   	u16 tot_len;
> @@ -1169,11 +1171,14 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
>   
>   	tot_len = cqe_bcnt - network_depth;
>   	ip_p = skb->data + network_depth;
> +	hdrlen = network_depth;
>   
>   	if (proto == htons(ETH_P_IP)) {
>   		struct iphdr *ipv4 = ip_p;
>   
>   		tcp = ip_p + sizeof(struct iphdr);
> +		hdrlen += sizeof(struct iphdr);
> +
>   		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
>   
>   		ipv4->ttl               = cqe->lro.min_ttl;
> @@ -1193,6 +1198,8 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
>   		struct ipv6hdr *ipv6 = ip_p;
>   
>   		tcp = ip_p + sizeof(struct ipv6hdr);
> +		hdrlen += sizeof(struct ipv6hdr);
> +
>   		skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
>   
>   		ipv6->hop_limit         = cqe->lro.min_ttl;
> @@ -1205,6 +1212,10 @@ static void mlx5e_lro_update_hdr(struct sk_buff *skb, struct mlx5_cqe64 *cqe,
>   		tcp->check = tcp_v6_check(payload_len, &ipv6->saddr,
>   					  &ipv6->daddr, check);
>   	}
> +
> +	hdrlen += tcp->doff * 4;
> +


Thanks for your patch!

Calculations seem correct.
Wouldn't it be simpler to just return the below?

(void *)tcp + tcp->doff * 4 - skb->data

> +	return hdrlen;
>   }
>   
>   static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
> @@ -1561,8 +1572,9 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
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



