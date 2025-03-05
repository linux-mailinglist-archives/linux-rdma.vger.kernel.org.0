Return-Path: <linux-rdma+bounces-8378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699CA50BC3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F7717445C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5E25484E;
	Wed,  5 Mar 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkx1yP4/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2C253F3A;
	Wed,  5 Mar 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203871; cv=none; b=UMosFOidbLS7bm/cf3B9E3kZEURFda5Ts1CB8G4Wx2gXJSBr8ytSrzGZdl3v4dS0irNMi84g4qlhnTArtHfpSK5qCRryBrP3XmpGaCtu2XQ16PgwskAxJY1/aDVNL7ZZFzmWe12rQd1UK3Aee8vEKnBCQpvAUEytCrn+DosJRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203871; c=relaxed/simple;
	bh=NSAa0OvXuYY0iRXVMiRtaNgJP4V7tsYLlILgyFyiicM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rijq4ifSpSeS4QkxNUc2EtjPnH/QWuz+NUTPZ7Vc4ueEni5g9BpqPFTfLnd1H7NAmuz4msdXSxxhWCaSMjTEacHKjaZeMi1Sz2rhIC1ybKSEKOMY9itfeta1xArT+cvuJNgE1Sv46hten2svph/ozjyZSnvlCT21xyzbfKklH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkx1yP4/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30795988ebeso76903401fa.3;
        Wed, 05 Mar 2025 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203868; x=1741808668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8wPJTp/GxCjpf5txsY0GF/pIM4aOcDfnKQydlTU5gI=;
        b=lkx1yP4/CC6v/BZAQqgikt3O1pJUkbzm4cKUbmC4LXzVdKGjz44ppidaF4gZfpCQP0
         k05vILWM3VBv2+3GES0zYff/JKxAb19GIcE5L4+ReUj0Io7206yEoXb54s3dUo4NR31r
         rAOVxGrwldsGsg4a8uWIN6OqXfkWc8uVOUYht0A7NKP5Sk2DmeUpV6K+rAwN7cOVeZaD
         dIoTa4VbszxA//anY88lc1PHhzQRPDNnKL8EuXcCJRoDcz4Ao2xxHX2P8v0kbugbGitT
         GUXtSNfc6/ln1OyuMPaiEvmJye1/nbd7UFKNjqi1N3LEmzZ4OECpEXc6OD21Ixv00GLe
         n8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203868; x=1741808668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8wPJTp/GxCjpf5txsY0GF/pIM4aOcDfnKQydlTU5gI=;
        b=Z1Dy82lGlpcZ986pdLGVl1K6GBvPy1nr9yEFBF000jl8uvfohKx9wOhBaXiDYDpNtr
         7YoMK3N9KxlHz1LrMxEoeqUfOj0j3WFa0Zb9v32asFaEAvoowqqwAFLtsKtKAbxobiEI
         nJLPfEsh9nkrn+LjCBvxDs0pWCFxRH33LZmYIyIKFWLvbIbPG6oaKZWhMp5p3qRghFt+
         0KgzvtwIwlmSaewIUaQ2ZYvOweUikUrOEfuYutuX8/GgTJu14PALRTfaba2JpXGM0tVO
         h0F8HTP/K86r5pG6ScfgLKMHh/L2x9CG68I7Dw1Wx92dYdgg10G34vTR1S/D/y7bEyMR
         oRSg==
X-Forwarded-Encrypted: i=1; AJvYcCV+BwZ4GEbzFNiMCl9OV+i/vWzdWM1epnklraNd/IMYAgk5ZnDjXUYYz2aXrtViznwlXcoxJDJmDzkE@vger.kernel.org, AJvYcCWIgT8evaUlvZpflVFft/R6ClXLEO4Ppo1hGwqJe5gJ6ZsI++k8MZTCC/SBbIsvm46Q68pKQp87@vger.kernel.org
X-Gm-Message-State: AOJu0YyBQU3RqxUfLsI44sYNg6fD1lxO1FlmrmrRH0ZyVkyM9jFyo9b2
	bixsNgVxVMl1bv31Y1PlCC/cQLsfuZ5/F0JEbepyAYZItC4dnYFOB0y2YA==
X-Gm-Gg: ASbGnctRLsjaAb4AYq//KAhXbR0NVAi2H1HvSMEbnGFSTkzqM8/CQpVwJ2Qti7ZCIzb
	ve17JBT1DGQxiw7fISLwBIvNi7MjawRS4+a2LPl3sZmIsZEeygwcEp8UDLALd/oxjl/MqtaS3qW
	lo+zc1dg62tMPMbgHp7Z9d9I0u/DGu0fSBHrJq1d5CpfFxs2nkKUSGniD8Slk3+uZg57o8vI5Ww
	fkyEVTul5WTLy95HrxOKuRrQJSffL2wj+QDhYgkB+e4zv+000lCwsNPsFUJtj/iqSdX34UKQaae
	AoaV0bAAt4GTvEti6lonoOYhqU+g18m44I2i0dPltcke1bODn/rsg6Vv/89JhhBUVQ==
X-Google-Smtp-Source: AGHT+IFHKHhjS/XltCEtKH6k9XakU7CyTp3mAOmbhWpdWlpzTiP8AVhh7/qC+8V8Td9l0tePUxXoRQ==
X-Received: by 2002:a2e:bc23:0:b0:30b:c9cb:47e5 with SMTP id 38308e7fff4ca-30bd7a19b37mr15673211fa.8.1741203867140;
        Wed, 05 Mar 2025 11:44:27 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8c85f5f5sm19489991fa.104.2025.03.05.11.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:44:26 -0800 (PST)
Message-ID: <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
Date: Wed, 5 Mar 2025 21:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250305121420.kFO617zQ@linutronix.de>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250305121420.kFO617zQ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 14:14, Sebastian Andrzej Siewior wrote:
> The statistics gathering code for page_pool statistics has multiple
> steps:
> - gather statistics from a channel via page_pool_get_stats() to an
>    on-stack structure.
> - copy this data to dedicated rq_stats.
> - copy the data from rq_stats global mlx5e_sw_stats structure, and merge
>    per-queue statistics into one counter.
> - Finally copy the data the specific order for the ethtool query.
> 
> The downside here is that the individual counter types are expected to
> be u64 and if something changes, the code breaks. Also if additional
> counter are added to struct page_pool_stats then they are not
> automtically picked up by the driver but need to be manually added in
> all four spots.
> 
> Remove the page_pool_stats fields from rq_stats_desc and use instead
> page_pool_ethtool_stats_get_count() for the number of files and
> page_pool_ethtool_stats_get_strings() for the strings which are added at
> the end.
> Remove page_pool_stats members from all structs and add the struct to
> mlx5e_sw_stats where the data is gathered directly for all channels.
> At the end, use page_pool_ethtool_stats_get() to copy the data to the
> output buffer.
> 
> Suggested-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 

Hi,

Thanks for your patch.

IIUC you remove here the per-ring page_pool stats, and keep only the 
summed stats.

I guess the reason for this is that the page_pool strings have no 
per-ring variants.

   59 static const char pp_stats[][ETH_GSTRING_LEN] = {
   60         "rx_pp_alloc_fast",
   61         "rx_pp_alloc_slow",
   62         "rx_pp_alloc_slow_ho",
   63         "rx_pp_alloc_empty",
   64         "rx_pp_alloc_refill",
   65         "rx_pp_alloc_waive",
   66         "rx_pp_recycle_cached",
   67         "rx_pp_recycle_cache_full",
   68         "rx_pp_recycle_ring",
   69         "rx_pp_recycle_ring_full",
   70         "rx_pp_recycle_released_ref",
   71 };

Is this the only reason?

I like the direction of this patch, but we won't give up the per-ring 
counters. Please keep them.

I can think of a new "customized page_pool counters strings" API, where 
the strings prefix is provided by the driver, and used to generate the 
per-pool strings.

Example: Driver provides "rx5", and gets the strings:

"rx5_pp_alloc_fast",
"rx5_pp_alloc_slow",
"rx5_pp_alloc_slow_ho",
"rx5_pp_alloc_empty",
"rx5_pp_alloc_refill",
"rx5_pp_alloc_waive",
"rx5_pp_recycle_cached",
"rx5_pp_recycle_cache_full",
"rx5_pp_recycle_ring",
"rx5_pp_recycle_ring_full",
"rx5_pp_recycle_released_ref",

Alternatively, page_pool component provides the counters number and the 
"stripped" strings, and the driver takes it from there...

"stripped" strings would be:
"pp_alloc_fast",
"pp_alloc_slow",
"pp_alloc_slow_ho",
"pp_alloc_empty",
"pp_alloc_refill",
"pp_alloc_waive",
"pp_recycle_cached",
"pp_recycle_cache_full",
"pp_recycle_ring",
"pp_recycle_ring_full",
"pp_recycle_released_ref",


or maybe even shorter:
"alloc_fast",
"alloc_slow",
"alloc_slow_ho",
"alloc_empty",
"alloc_refill",
"alloc_waive",
"recycle_cached",
"recycle_cache_full",
"recycle_ring",
"recycle_ring_full",
"recycle_released_ref",

Thanks,
Tariq



