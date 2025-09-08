Return-Path: <linux-rdma+bounces-13149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214ECB48533
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 09:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1DB7A3BCF
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA62E7F0D;
	Mon,  8 Sep 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY/ME0sU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308662E4252;
	Mon,  8 Sep 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316491; cv=none; b=sgRVtEZp2zWQnMK0gt+viUB0VQaUTjcnArr4Lh05Me4Vv+5Ns4cAsDInMcEANi1I8cfVlwM89wITSgEqR9AXq41KasTVfr0MQKhX3NEV5jCvzO8RsHhD4+MIEWRswu1FtBx3kuk8XSVowlM64R+/QIK/R4JBZH06nPbcpQkWBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316491; c=relaxed/simple;
	bh=noZjvmTYdYAUmEnWb2zCisPLba1kMmtLcjm0cOVLdpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmjEK3cDff0seus1EXSe+r35vhGyIPdjvCV3FDZSxP4P8tt1nQT4rYDWJXcWIrJhLLJ9xAFHlIVPcoSW8Yuc93zRJIF6IVVhFgOYJMZE1BAMGmEQWxRG0N+g16D7k61c9VQA1xZEWLjWjine53HGYD1WGST+jP6IY6ys1CEwPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY/ME0sU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so9893625e9.3;
        Mon, 08 Sep 2025 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757316488; x=1757921288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooppLaNI3Qv/svDD0YcDheaWIumHyhFQeMcAO6Dj8J8=;
        b=nY/ME0sUO3jPSs0+Hq5yzgPaTQPivecwv1D+GfrYz1m6FHhTZ1Vu0+vKQ0u17QdMXK
         JF2TZ9T5t63Ix5dhuNVIn+bnyU2ytkee3AXbc9xPMxRzrEiWYCnbYMAU/VWutbKEJdBi
         f+HVCH0yXkdBPmT2vLWi9zai23CYTVmMWQtu48U3modB66jINn/6E6kl0/uh9aapXn+9
         WBYQgrMu4l/LhpzDoPwU72PegHuZOKOo0BafUml4ZPMz1ghd1vLA5W51O4GMBXo4P0vW
         bX+giYVJkqKnbxJXcQUeqESEwfn1/kH6CZTbaG0qnh9WKA9pA5dk3N6MeChENBPVeQkJ
         BtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316488; x=1757921288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooppLaNI3Qv/svDD0YcDheaWIumHyhFQeMcAO6Dj8J8=;
        b=C8LHKNo7+T2iY74h+2fIhveIfQK8i27yWJo6FkkMLdEFGtGkfSSJ2RaGsTXFVb2MDN
         V9LSCW00bC9CWQ6DvFqURjK1lEMlHDJuAMXqiU0sZnZjQwzBMM2Em3OyLerWNR/yI3sl
         MePUUlR9ALuhymbH/X6h5Mcy9Esn0XdosIeA7NnizQRoE4eoEHj4LaTUJ4TxAQ3/fsvI
         PN4jClTDiTgtM+SuGcY22dJ8m3UPgyvVBXiOXVH+BSJonPFD7O4EJONoHGx/25uRkPcM
         D/KDvHkxc9B2pIKfu/rvaKLOJs25tZMvYdlyLHGGjcJsOWMube9SsXsDddmi6k7Hjisg
         iorQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaPJM/1BnwSH4XDmNj1vKG3U0MGFCZNk96j64yBNWg3i+5kY/KSH7ej3kk59WJlUJJ7h/9wQvZ54JxqRg=@vger.kernel.org, AJvYcCW1mo9c6zIaSUTtzoVugnqsloohuFDs4DC8sdXYvwHwK9lBNBqZKXduiWE6nutUHEwM2YItsT/jckvipg==@vger.kernel.org, AJvYcCWZemXo2J4GhKEwFhdzAA7B4RHhyh2s1BE8OyGzUQQ9dDKVbaKHC8XodaNu8pRDGIxFHsvJkhvH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvj/fRxKGaQ0juicNDUDwSHyqSblOpyr3RIzwTvMHK79zeXu1y
	5rNhtoEVVdcvqWDiJLhuDxm6kThUlFPEnz7KJm7n/03/Zq9szeFEOkLZ
X-Gm-Gg: ASbGnctgXqTcJ4nQUP0/n5T3q4vecFKtFpYqlgLNE5g3g3WkeqGZxgP83rfoFHPme+S
	2yZJIcksE0GsXsS/Aw+Yt2yDMDPGqDHXfUa8GLva9moogPUBpAOPx0kD5v/0l23b52l7MV8eDfh
	99rTpiHHW7xO7YsWXOlIOhE/tQIh95GmOCEUyx3+cUSLMzCujuPxAXgD9sToA5NcRmKe4uJHv5u
	ZnjQC2gSBtI9Bo+3AEgIykSmAgaTo+1KkHE1z6SU7jIPjSqpw7zR/a84ff/vwZKZicZCXOliR1O
	OcdHOSFMAoCZWLdL/gTWziUwpPJOGte8I+i9CV4wLO7cHRV3CE8lr+zRX/dj0/tyOhgUk1F2774
	0z8L7MEpIayEWQ/POaE3znlBpC462s0ThduuUXOJvxjc=
X-Google-Smtp-Source: AGHT+IGNwsoDc9qSEbYggJ+kfYcDeF4FL1ewm5JaYetSfi5grV0bicWUnv+3Xrds26tI6iMZbJ2TPg==
X-Received: by 2002:a05:600c:4589:b0:45b:8795:4caa with SMTP id 5b1f17b1804b1-45dddeedbb4mr63465645e9.36.1757316488070;
        Mon, 08 Sep 2025 00:28:08 -0700 (PDT)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e740369f1esm6690434f8f.11.2025.09.08.00.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:28:07 -0700 (PDT)
Message-ID: <7f9695f0-8753-472a-9e92-585389a6d21e@gmail.com>
Date: Mon, 8 Sep 2025 10:28:07 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] eth: mlx5: fix double free of flow_table groups on
 allocation failure
To: Makar Semyonov <m.semenov@tssltd.ru>, Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904140858.1690639-1-m.semenov@tssltd.ru>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250904140858.1690639-1-m.semenov@tssltd.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2025 17:08, Makar Semyonov wrote:
> In macsec_fs_rx_create_crypto_table_groups(), when memory allocation for
> 'in' fails, 'ft->g' is cleared once. However, the function returns
> a non-zero error which causes macsec_fs_rx_destroy to be called.
> Inside it, macsec_fs_destroy_flow_table is invoked, which attempts
> to clear 'ft->g' again, leading to a double free.
> 
> This commit fixes the issue by setting 'ft->g' to NULL immediately
> after the first clearance in macsec_fs_rx_create_crypto_table_groups()
> to prevent a double free when macsec_fs_destroy_flow_table attempts to
> free it again.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Makar Semyonov <m.semenov@tssltd.ru>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> index 4a078113e292..5e86c277f33a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> @@ -1066,6 +1066,7 @@ static int macsec_fs_rx_create_crypto_table_groups(struct mlx5_macsec_flow_table
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if (!in) {
>   		kfree(ft->g);
> +		ft->g = NULL;
>   		return -ENOMEM;
>   	}
>   

Code and commit message are fine.
Use "net/mlx5" prefix.
Please address comments from Markus Elfring.

