Return-Path: <linux-rdma+bounces-8400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64188A54316
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 07:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD411893FAC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E51A238E;
	Thu,  6 Mar 2025 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtm5cz4P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B3236D;
	Thu,  6 Mar 2025 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243802; cv=none; b=m+vE8BPlXguBX7JulDOPnfQ0ppIXAv3wPzywjk9rO+o0tVcuL8BuoWvDSPslWL0ayhgQbsV/MMbGHKBL8D2gEw3195T+pyKePIp0u319he1WKlXdbvshkS1aL2MpF/whY3iS/wTKY1Rtt0i+rQ7e2/eMFJd1fsoSyDuv7Yn1c7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243802; c=relaxed/simple;
	bh=DNyhLOFCR0nOb4YtJNu7m7m7eynTT/M43+g30DXMdQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1l2vTMh8v5E6KN1eD9mR/rPF9tRnXWMO2uW9RsRnaHuwKvjsDpAtoaDHFWkbLOFnBPPHo+uCyqymSAiA76okz37bJnt1xBCE2c8IMf6Iit/njzBduHppj46FM0xy8XelEGW4pI8CAXFNIYBeQ6ZPacJgupAVjdKHtqxHWzojrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtm5cz4P; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948021a45so2128685e9.1;
        Wed, 05 Mar 2025 22:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741243799; x=1741848599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJM8Wqvc3FFacyQPJ9/a7tZRu0GBZ9xmP0ZyEVFzhhA=;
        b=mtm5cz4P3rTV6ZmzGnM56z9MU8zic3Dw1574SswvPPeZ6eWcXuODfD7Zlfyt+azyIt
         sBLLluxLYKU8942gfvVVV2tSX5uklRHSwlk1WyxVaj/8e55bup6mGc2KaDwoICxZK5rq
         n74JMM6TmtFSkM/SpyX7fpl9h4FF6a4d9K3DeTO7tw6YOJomPCM+P3pDGv2IwSp9nl+R
         XaBjFDrXGwCuUi2lff8Y6HNWHxr27pRkEeLdB8UHv8GEsC3mN5e+yxinynvOZqKXjh9C
         uyS65YGtXXWl3c41w6GmFyXMlKktRiqOWndORshHZzNpftS4e9VVhEBK+RjdLg3rMfvM
         z22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741243799; x=1741848599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJM8Wqvc3FFacyQPJ9/a7tZRu0GBZ9xmP0ZyEVFzhhA=;
        b=mbf9NX+zelmNkwM4db/e0792qX9GwLaraAOwJOyLcWPJBiJ7lZ3WtGldd/AFcY3R9X
         Eg9imOauDD9dW+tAqfVYSFbP0NS4/OeniH1XeLIJG47zil8ibLB8WdUV2J8s0Y07YJdX
         2i5t4Oakww/7TUsvHH/DVi8+K1yfJGuynbiwm9tdZ5rYNyqnrqwXMiAByDgL8cIBb5BZ
         M+rObHVLXSyOnxFIICanHH0A2Xp3d8em8Z53TFdjHYzRk/pJ7X6H5gHL9HMylmIa8PSA
         sltGXEEtMsC5WOFHhw8rL/XuWwg06j16frU/fFe4++Nxu/IcAiPKe8uK8b0opARBS/8k
         eQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCVABKtPHBDsFK4U5gHkYHNbxYq7BxJXoPWd/rAtne0MmDRw7cPkYu2CtlG7kfaEy6niBmpSEus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmObjMT0dg/2fxNLfb5PFMXP6SHNEna7aXjJ/FKkCCq1gJ0WAq
	H5oRXe86qU9gDAQ+D6XfNGUE2+lpfqW1KCJW7pu1kHima8gmCp4T
X-Gm-Gg: ASbGncupL+OM32xGTP1s/u/MIwPNaZo4SMzPUphjHMmcr8V12FPPQFj9MHk0PPhEY0K
	IXfjkRyMa6MKtm3tVPu23y0beZqWBQThN7BR+zDtOboydSVKepSHOejok6bWUUAc7yiHhPIgRcN
	1jqKCb6kRLkuF9ORq11hzNQAGnftPjUVmu/aZye+ek/FftOsgdatJaFM+pAlfLkhlU0mLc4T2ns
	iWHFgFAeWGI9zFDTzm/BxG/mlwE9m6E7YDz8ZjEzbsMC9+KNbpzQiegBhib1kCs+H3pHdbxeLGV
	swcVCOdOB4OWpH98+UZaDermwh5WP4sOzQi5hHeggwDsCVCBFtFz2cz5DUEhK6Cdyg==
X-Google-Smtp-Source: AGHT+IGuIoMtFEaomgnriGTy1PbBYViKYMAZJEpjVNEbd4cVLUlDcOtUeIrwEc/GAZSfDJX4U73Bow==
X-Received: by 2002:a05:6000:1f82:b0:38f:231a:635e with SMTP id ffacd0b85a97d-3911f746668mr4565424f8f.25.1741243798781;
        Wed, 05 Mar 2025 22:49:58 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e1476sm971790f8f.70.2025.03.05.22.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 22:49:58 -0800 (PST)
Message-ID: <42892aa7-f7a9-4227-9f3f-24a0f1c96992@gmail.com>
Date: Thu, 6 Mar 2025 08:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250305121420.kFO617zQ@linutronix.de>
 <8168a8ee-ad2f-46c5-b48e-488a23243b3d@gmail.com>
 <20250305202055.MHFrfQRO@linutronix.de>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250305202055.MHFrfQRO@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/03/2025 22:20, Sebastian Andrzej Siewior wrote:
> On 2025-03-05 21:44:23 [+0200], Tariq Toukan wrote:
>> Hi,
> 
> Hi,
> 
>> Thanks for your patch.
>>
>> IIUC you remove here the per-ring page_pool stats, and keep only the summed
>> stats.
>>
>> I guess the reason for this is that the page_pool strings have no per-ring
>> variants.
>>
>>    59 static const char pp_stats[][ETH_GSTRING_LEN] = {
>>    60         "rx_pp_alloc_fast",
>>    61         "rx_pp_alloc_slow",
>>    62         "rx_pp_alloc_slow_ho",
>>    63         "rx_pp_alloc_empty",
>>    64         "rx_pp_alloc_refill",
>>    65         "rx_pp_alloc_waive",
>>    66         "rx_pp_recycle_cached",
>>    67         "rx_pp_recycle_cache_full",
>>    68         "rx_pp_recycle_ring",
>>    69         "rx_pp_recycle_ring_full",
>>    70         "rx_pp_recycle_released_ref",
>>    71 };
>>
>> Is this the only reason?
> 
> Yes. I haven't seen any reason to keep it. It is only copied around.
> 
>> I like the direction of this patch, but we won't give up the per-ring
>> counters. Please keep them.
> 
> Hmm. Okay. I guess I could stuff a struct there. But it really looks
> like waste since it is not used.
> 

Of course they are used.
Per-ring (per-pool) counters are exposed via ethtool -S.


