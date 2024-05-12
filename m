Return-Path: <linux-rdma+bounces-2425-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2425F8C3576
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942EA281885
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C1175AA;
	Sun, 12 May 2024 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4fZLsuq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D183D6A;
	Sun, 12 May 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715501836; cv=none; b=bJY6URcaAGlWNXSBYh3nALVOeG4uihpDl6LJAFTYzZ2SHWmtk/JdqAGq6z/SNjX5WEBIAtJUWoqwiq5WME2zKrgxiyuSdZ0Gmuh7O5pY7SJnLhs4o3UfSK1l10Q0lhUCIe+aOcM+ClN235aXokrIMfUEGjxbAI9GkiN+z7ME7Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715501836; c=relaxed/simple;
	bh=SxRgOz9FrW2nOJVIYf9MsvTis9bo2V8NngiZT8z0rTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUArncCdoX82+ACqCSPuxDIOSmKy1kB1y8822Q8noci8rhlegrbMFA1WvrplaSS6ObcocYbkNi7TR+a6JXPkY8x4ILH1ts8zsJepWRvuFiyrOmwxBD8/tdc08W5bi5JSmvG9z48f2x94mSCXcixummPerBylNjMCgcWaZEKXQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4fZLsuq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so19753155e9.1;
        Sun, 12 May 2024 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715501833; x=1716106633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXlhXUYBz2j7T8no4wkelMyXb8COeQGHIUfPVvUbzMs=;
        b=h4fZLsuqvgItmXZzEhyMv3Zu2i8hPCgebsBP7OEHB6rqRwlJuyp4tgBCf5TxUqD0cO
         dbYLvtLpSUCVU5auEW+Mnuew6ewuy73/1ISp8GmI2EE0C4tAcdl67CVoNmEl6ulJEdL9
         55GCQIvxG35iEiC/fvRM4XhObASXNkFlgqtCbzciWfRsAqMPYCoaayThGY+V4pyG9JhI
         OGyRB7tHZEoMzVIconxZgaPh3g7spxoOZGcnrhpxsBB4caHUHZRnnfXAvu1ooWNKUfis
         WO7Q1R2xq6TZVARXSd850XIaQB5kGmwNVQnzyHxCxupEX/cwJygSNLsU+9TWNSi+WQhG
         /Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715501833; x=1716106633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXlhXUYBz2j7T8no4wkelMyXb8COeQGHIUfPVvUbzMs=;
        b=qnQSE6ahOl10+UDuwlA6dHAeBg81MCWLeu+w4Gbh1PfTjz2pqI56Yokr4Dz5qtKmsg
         I6NlYn2dQNsdkHRlvLblZbSYBk5UvPgZ/VJwdS2QFB8/BFSj5rcDpwwwQLX34YZfdAs0
         FKyTa5HmoYI3lpQPpwikro69qQzRddr57plEDiQmknShjoURFMhsyv3V5sRJTr3z+2WT
         ZeEXyoxw3fd3IFZOIw1uMOCVHynJskY5PP26KgoyVbuPebFCSlbflZRorCPOGv7Eyv0u
         JM2wMcRVFOYj8G1J/sBhJChISfw3Jntz1VbZIfXDYSMNlLtNMOGhKiMtFp/aRxHH1Cvg
         4R6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2JF30/84kyraR9Rq4mNU+7BuqL+Xq3rtO3KQaB6HqaSBJrmATVaorlSMrCfhmBG9QYYVTrAM1o879BYNdr4DBy7H+zlNXKwYf/R0f1Af2AP6ALKVNv+ZY5p37Je4tNcuoF6gORpWWWRjoX8jHgCjz5Ac0C1oIlc8F7mWzkpLrvA==
X-Gm-Message-State: AOJu0Yw9gLj6/HLZeMFtLd3HE6+OCeNMSY2Zwtny/jcuU1ncemc0OVqP
	lRmfec3BHYwv2SWWupY6KjL1WizhQn4Vl/8LCUT8+LTuQEWts6oL
X-Google-Smtp-Source: AGHT+IEOalB+778r4CqlSVXIAWe1JPzos5Do/QR+Dve78YpSIk5eyo9JJnTF5MDxO8/0sqUEO1y2aQ==
X-Received: by 2002:a05:600c:3582:b0:418:29d4:1964 with SMTP id 5b1f17b1804b1-41fea539b5amr50417525e9.0.1715501833128;
        Sun, 12 May 2024 01:17:13 -0700 (PDT)
Received: from [172.27.21.17] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25casm120049505e9.20.2024.05.12.01.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 01:17:12 -0700 (PDT)
Message-ID: <a4efd162-5dc0-4ed1-b875-de12521a6618@gmail.com>
Date: Sun, 12 May 2024 11:17:09 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] net/mlx4: Track RX allocation failures in
 a stat
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, nalramli@fastly.com,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20240509205057.246191-1-jdamato@fastly.com>
 <20240509205057.246191-2-jdamato@fastly.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240509205057.246191-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/2024 23:50, Joe Damato wrote:
> mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> fails but does not increment a stat field when this occurs.
> 
> A new field called alloc_fail has been added to struct mlx4_en_rx_ring
> which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 8328df8645d5..15c57e9517e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
>   
>   	for (i = 0; i < priv->num_frags; i++, frags++) {
>   		if (!frags->page) {
> -			if (mlx4_alloc_page(priv, frags, gfp))
> +			if (mlx4_alloc_page(priv, frags, gfp)) {
> +				ring->alloc_fail++;
>   				return -ENOMEM;
> +			}
>   			ring->rx_alloc_pages++;
>   		}
>   		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> index efe3f97b874f..cd70df22724b 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
> @@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
>   	unsigned long xdp_tx;
>   	unsigned long xdp_tx_full;
>   	unsigned long dropped;
> +	unsigned long alloc_fail;
>   	int hwtstamp_rx_filter;
>   	cpumask_var_t affinity_mask;
>   	struct xdp_rxq_info xdp_rxq;

Counter should be reset in mlx4_en_clear_stats().

BTW, there are existing counters that are missing there already.
We should add them as well, not related to your series though...

