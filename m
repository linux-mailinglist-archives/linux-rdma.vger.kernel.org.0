Return-Path: <linux-rdma+bounces-5789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5DA9BE343
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 10:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74E4284BF9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F81DB92C;
	Wed,  6 Nov 2024 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjDNpPeo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBD188CAE;
	Wed,  6 Nov 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886994; cv=none; b=s4ramVTZsCjLUlbclcmqxf2umxsUVyC9BoyodHk3R8OuSG9iAMeSIXcmjXQehPdE4zTprBKfrCLLpJS0xxlwI1SKj/ZnF9WnZmLG+TDS3AvLhTvpdDyMhn1xa7GTnrs4x+sWvAInuSFAxxB2EN13Q7SphWAGZJ/6OehNvVcyvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886994; c=relaxed/simple;
	bh=HkVhGI4V+9ZYnzFk4gRhjN2tqhW0tCVvOg40yK2mBv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxfvFobgdAN7vNCfaPyYeT+0O1rmqpWQZT+c5VBEOiw500nBncXHfq97wUUx2/xw0v7RgaEvU8VKvMkrQUl6dLPOtvpSa3XsniG/FDTXKAFYRZss6fcQ9kJOaKxHSsJCMsKrSKafNOAcTxAofs9UvlfrX8mJpkmKACKMypJeh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjDNpPeo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d50fad249so4717377f8f.1;
        Wed, 06 Nov 2024 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730886990; x=1731491790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNeN9v8gxmrlphcLSsXaboQE4lTekxQXl96Uo8SWbLY=;
        b=jjDNpPeooPwiwhnvt9XNunGUVTBB3MsQg9NDs+VJ8k4BcTWrGqjS2qWTiLxCm6foDC
         CYlVLdT+bhx9NE+SXbZb/Ie21IhyemYLYmUK/9DQxbC/WrSB5VNYl2W3gTLBF58iFXev
         j4T2W6g5pS9pv/OLN3Y2Ft9F0NLDafA9OJn1Vh7CkvvbM7SiHkndc0gSra0E6Kta3ty8
         AYyaqORGTt3aey2+McONCs/ff0SRIEvIo2zFwt6e3R8cXVqj5iYR7w8k+aUiCmO/O2LO
         tEeSMUaqu0tM5T7mCn4f0Pr3lC7eO9xAsjDk2hrxNpFWPWtHtgNHS0npB4wEq5wvYN3h
         vBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886990; x=1731491790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNeN9v8gxmrlphcLSsXaboQE4lTekxQXl96Uo8SWbLY=;
        b=E0XUaYuZ9vDaPpQhvOlNtt9pNBaFGBgInDtSa5KbmGq5BTWjg9WbwZS83aEYfJIeiY
         TYhgSdmixpqlt3I6YfH5pslizZTCIVIxSN/cPJWSdU1jseH+5w2Mva+n5AjVyWoSGLqA
         T+bUUpicDWBSnN3uOx+ZTvFc/zDBLY7vZ/Fwng0puRGIylUkMonk28Nucu5lzQyXbD55
         2nNrj2u83lKNK0EX1Z6z3AFbwnq6aBSaSHS9SvzbhiK37W7BEj8Gu/yKdUrTD26RJiI0
         xmKdVWoBLZDNZpuftkIFqQ90Nnndx9+y3xCARC2ohFA0AtAR+09KEru+vMNowqL8j5mD
         OsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYeMWt9oKVKFfUcH5BGV3bP1I+mK95c/34kiZDhZcwtoG59lpLJXiEhrxwAypp9sWgcNI78FNZb5Rg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PACgmFZDZ3OZgGsMI0myQg9/RWx42Kbbvb8URZvW3rkjyXGu
	HpNOZp3ON6Tl3rCrWBomAooQHYfF9PSjH97os4n9GPluSsKMND0R
X-Google-Smtp-Source: AGHT+IGt4XIRJwi34wWyvZSpwtb0nT5zhPZsrRvgknnXzczX6WckHHcW037tfIzcV7RzQ9xstwj6qQ==
X-Received: by 2002:a05:6000:e88:b0:374:c847:852 with SMTP id ffacd0b85a97d-3806115ac8fmr29281013f8f.29.1730886990174;
        Wed, 06 Nov 2024 01:56:30 -0800 (PST)
Received: from [172.27.60.131] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e1bsm18792787f8f.1.2024.11.06.01.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:56:29 -0800 (PST)
Message-ID: <b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
Date: Wed, 6 Nov 2024 11:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
To: Yafang Shao <laoar.shao@gmail.com>, saeedm@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241106064015.4118-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241106064015.4118-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/11/2024 8:40, Yafang Shao wrote:
> We observed a high number of rx_discards_phy events on some servers when
> running `ethtool -S`. However, this important counter is not currently
> reflected in the /proc/net/dev statistics file, making it challenging to
> monitor effectively.
> 
> Since rx_missed_errors represents packets dropped due to buffer exhaustion,
> it makes sense to include rx_discards_phy in this counter to enhance
> monitoring visibility. This change will help administrators track these
> events more effectively through standard interfaces.
> 

Hi,

Thanks for your patch.

It's a matter of interpretation...
The documentation in 
Documentation/ABI/testing/sysfs-class-net-statistics refers to the 
driver for the exact meaning.

rx_discards_phy counts packet drops due to exhaustion of the physical 
port memory (not in the host), this happen way before steering the 
packet to any receive queue.
Today, rx_missed_errors counts SW/host memory buffer exhaustion of the 
receive queues.
I don't think that rx_missed_errors should mix both.

Maybe some other counter can be used for rx_discards_phy, like 
rx_fifo_errors?


> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 6f686fabed44..42c1b791a74c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3903,7 +3903,8 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
>   		mlx5e_fold_sw_stats64(priv, stats);
>   	}
>   
> -	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
> +	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer +
> +				  PPORT_2863_GET(pstats, if_in_discards);
>   
>   	stats->rx_length_errors =
>   		PPORT_802_3_GET(pstats, a_in_range_length_errors) +


