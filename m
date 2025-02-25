Return-Path: <linux-rdma+bounces-8069-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33AA43D85
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 12:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB16717168A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447A2676F2;
	Tue, 25 Feb 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlqUoG1z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A7266190
	for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482844; cv=none; b=XANFbyf/oT8okJ+1qmAK/jqhQkF/dW3WqjsFY4Kbh6nzHmFdxsksgf1FEMgvURDuAnS7YlieZFzge+3Mj/R/DOY3wdEJ+tn4NwaApix1owf6EXNzOpHk/5V0uXg+RkVYlI7QRirQWLfNAm7ugSUWXNPdvdxNYFok30UlWW8prXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482844; c=relaxed/simple;
	bh=ZvKEr+Aw1O2CbH02aH/ycXTvVAHfA9G/U7K7FEuLTx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bepw4L6b8IDrAujG5ABDHXx4ONMZt+rVvRUgb6XLyCmACMUYSzB5l9HZDOJXLdt/4WznfxeCb1uLgy77PmGAaF7aCr/8GpcbdyEUmYLH3JYuhG5iX6ZbCPONRx8KQaJLo6X2pLuFPs+LuiCDfcT2t3rMVLbzRZ1FyFmAfhH+ZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlqUoG1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740482841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAaucFBe+ebr/B+zt928Rm3uzKsRzpw3qm5/ycLEbwI=;
	b=OlqUoG1z0clzmaOFmJPv5MNBBqBNfZTFw/lOMr18W13InFIpF8Llgh4o7CnIoZ4TwoasRO
	KxOe68n8IVFhHZ74BWBjms3dsmQjQuMc1pTtJXqxX/ldBFfkom1YVet+xREHXtmtTsEssg
	rMHWCPybHtft/XcKl600dkgIO+SmvGQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-U4HeeLeFMlWa0aqoK1qCEQ-1; Tue, 25 Feb 2025 06:27:19 -0500
X-MC-Unique: U4HeeLeFMlWa0aqoK1qCEQ-1
X-Mimecast-MFC-AGG-ID: U4HeeLeFMlWa0aqoK1qCEQ_1740482839
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f28a4647eso2309268f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2025 03:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482839; x=1741087639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAaucFBe+ebr/B+zt928Rm3uzKsRzpw3qm5/ycLEbwI=;
        b=hKuoX1Kd8ROW/kDllU+vvRIRh+czcNjODFrhNUbVmMtQ7RPranXOoUAjvRomTuWS/B
         LT8FZ5uSp5WToxOJ5+OOfzZd1oGh+VVWi+wbpw8NUA5eixGM7fHcbKUHPOTjI/bq2NNK
         sRBLmUxzaUJC/pFIfwOzy2dNRPwpZG+mnBJkJeES2V5VWIukffRxF3J4DGpnKcAvDWIK
         CMLHvxECtXgM0orEXj2QnTLDNdmUg7+Uxa3SE9DJ90QkCqPwOJ8iQM79IKFsCVz2VNBp
         WyZhKDODS6liS3Vk9YyBCSuJKxMY7WomhLvLs8d7J0uNyQXvRiOjeWyc/lPcA3JfCsNe
         IiwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsIHr9fqBNPyQXq5wCqH13EN9xcy+tEalJprXdUiyGIxIE/RecC5Mfmda1u9Jsl+B7UW+qKOiXGMiP@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUvqKgWVPu0n9J99WfJpQ+Is7TnPH6JBw9O6awmA3dqQdzWF+
	cTvO3+16ybtzp7Ux+l7elQIeq8vV4Ixlhk15Ge4z7U0uVUQwDl92tkXurLTwxZmTh/Y6IK55wpu
	k8yk/QjjrrRHtxVtol1Ar9Schud0aN0RUot7asa4j/RNdsigAAAUnzeEoMYw=
X-Gm-Gg: ASbGnctergOpztU1cpzxfqRs0rE7LDB0bVEfY+uTr6UH7Wb5MuQQUrD78lObVmljAsm
	bcwZA7ZkugAtGcSVBq7xMUIXkem05VxVGPcLMdgv3xR0Wl58xENgQ2mU/y4GcmZW4eDwGX7zs5B
	KKNNnr+AwJ4wseJkPuWvc2yE5aNZ5viNg1RT1xWEaHlmD42NESOnmbCxGuivlxh4kwdUYdmKMez
	/eiNaDmr0gfOr8zvvvbDNY8uT/5DNQ1O6XUiHrm7m5hPUcqa0XLIiT+w0UmU8uJIvlTr1qaLYjx
	cjQPThxfEHfUGJThQgGACvP2Je1Qfve42n0YrefS2Zc=
X-Received: by 2002:a5d:51cb:0:b0:38d:b448:65c4 with SMTP id ffacd0b85a97d-390cc638cd4mr1875725f8f.55.1740482838805;
        Tue, 25 Feb 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPzqy54v/RMp3QrDoyBvRf98A5tIuWSfb0O0Warb75DMVJ/awMvqU2rf0J0ObFwzsjOs/7cA==
X-Received: by 2002:a5d:51cb:0:b0:38d:b448:65c4 with SMTP id ffacd0b85a97d-390cc638cd4mr1875683f8f.55.1740482837727;
        Tue, 25 Feb 2025 03:27:17 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155eb77sm22675765e9.32.2025.02.25.03.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:27:17 -0800 (PST)
Message-ID: <50019760-440b-4b0c-816f-d262f747a555@redhat.com>
Date: Tue, 25 Feb 2025 12:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] page_pool: Convert page_pool_recycle_stats
 to u64_stats_t.
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-2-bigeasy@linutronix.de>
 <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 9:13 AM, Yunsheng Lin wrote:
> On 2025/2/21 19:52, Sebastian Andrzej Siewior wrote:
>> @@ -99,11 +106,19 @@ bool page_pool_get_stats(const struct page_pool *pool,
>>  		const struct page_pool_recycle_stats *pcpu =
>>  			per_cpu_ptr(pool->recycle_stats, cpu);
>>  
>> -		stats->recycle_stats.cached += pcpu->cached;
>> -		stats->recycle_stats.cache_full += pcpu->cache_full;
>> -		stats->recycle_stats.ring += pcpu->ring;
>> -		stats->recycle_stats.ring_full += pcpu->ring_full;
>> -		stats->recycle_stats.released_refcnt += pcpu->released_refcnt;
>> +		do {
>> +			start = u64_stats_fetch_begin(&pcpu->syncp);
>> +			u64_stats_add(&stats->recycle_stats.cached,
>> +				      u64_stats_read(&pcpu->cached));
>> +			u64_stats_add(&stats->recycle_stats.cache_full,
>> +				      u64_stats_read(&pcpu->cache_full));
>> +			u64_stats_add(&stats->recycle_stats.ring,
>> +				      u64_stats_read(&pcpu->ring));
>> +			u64_stats_add(&stats->recycle_stats.ring_full,
>> +				      u64_stats_read(&pcpu->ring_full));
>> +			u64_stats_add(&stats->recycle_stats.released_refcnt,
>> +				      u64_stats_read(&pcpu->released_refcnt));
> 
> It seems the above u64_stats_add() may be called more than one time
> if the below u64_stats_fetch_retry() returns true, which might mean
> the stats is added more than it is needed.
> 
> It seems more correct to me that pool->alloc_stats is read into a
> local varible in the while loop and then do the addition outside
> the while loop?

I also think the above code is incorrect, and local variables to store
the read stats are needed.

/P


