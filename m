Return-Path: <linux-rdma+bounces-7982-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2ACA3FD8D
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944C03A2F0E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73A2505A8;
	Fri, 21 Feb 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JcgWjflw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179E91E5B9F
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159017; cv=none; b=jY61SYMWlYl9spAQvV6+KS2OlCHd55U279Ivt5OByFq+xp4ol9pwT1KZ/njCwwTbbcSUHdsSMh2gvkfncjzt/JsMUlpuQKX1sroKq0UdcZECHXjBX3FQNlahyqAsEaZR2QkJTnDlKeXMMnFKt0CgtCHedaYmxWPqzkSvBZQd/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159017; c=relaxed/simple;
	bh=n4K5LgedBielf0hnAQFklcvng586MuWobBxW2N0slT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN1g9gBNmd/wTaIJoa4t+3cdb+rrYT2vf9UsAtQSFGGJK62pT//8tn+9kcxBYs+PwvQs957fyikZAG2KvKhdtg2fbN4qh6GsfXetiGoKP79Qx1mFOyhayi2b+IlY2i26QXe6cjbqom63LcfUjP18+rCaKqAecNdb+aK8/b0MVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JcgWjflw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0b9f35dc7so309627685a.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 09:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740159015; x=1740763815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWytvIz7GiExTCjjd9cGzglj4b7zNOEtPFoWbv49aGw=;
        b=JcgWjflwZWu3CnTzP4phOCpYw9OZDqewd20L7IPaHEMaFZgEQEawXhmjgjU0GpJMWF
         V3eLqvR/paQwC1iPVRpAolTOeA0/IYFhBa5zfqZGfzgJiRvGssmfoFgbJjDdyj4ebtAm
         FDEnCZl2KJdzPuBdfojXlOlROQiDbctY+hE/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159015; x=1740763815;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWytvIz7GiExTCjjd9cGzglj4b7zNOEtPFoWbv49aGw=;
        b=MwC33DPoCnl2tggtsf6RgdVx/1MDLIaCSwlh8TXHTZGzKoDXNsCfW3V6OrP5XmaJ68
         Apvg2hKILgS0PXkobsLXFccX7b+Y0qu1x502/C6prpcEBrTUCdapAvLmTKClSGiwlI8E
         hiGJwJVWtdrJMdxp5Ah0k44CWHc+J4C9nESNwwxyVA9B27CCoK+U1cIC9zNTaE4grQZs
         xVyv0l48yuS95b01I5qJEFpLFH/pDSj4Yu833MImYzyHFljy4nayDJCdCakQ5ICxfaIw
         +X/26Hu1FMFWv9/MFWe0x+6uxvH+btGBz8ZUjNOMBvModXm0XOzGw4G81YYPQNwmjry0
         8JCg==
X-Gm-Message-State: AOJu0Yx0E+L1Uolak5Mdyl7YLqvIDHOyanVpRbu7GjvkDW19fxcvQs6y
	7uEHMlaxcINJ3z8T0JZZE3VTxXvbROPmeRWt+HgY9MjLLwy4JG94y8ujP9XVx9iQbyCLteg9jqe
	B
X-Gm-Gg: ASbGncvKoQIoL2/cFdGNsZv1dT2KTkUY32ITkal+lM8rL+iQY0k0E5oS+jDA3FJaGda
	SkKavs75USCPRRLlFtwisa17O9Gw0/T4R7/9FKC9+Cc2j+P584hGNMNRHsSlKkUU8dbgQDhkd/T
	kBHjEOS5uBfZBMiU94PVgeffkaBKB1a0bLDolBNVtvC5HTIzzf10iIMYHHfJLXfECqfwUcZB2iQ
	CVX1YWXDuRMqkiEka6oKGFLR97tuig5TUnk9Emc5Va3J6thQocAXrslaNQVt+QounViqQuygx5V
	BQpyaunYhL1BgovNFYjoMp4o2YV/RuZCPX2gJv2oHTBhVuGW42VvYj+8nkcw3CU5
X-Google-Smtp-Source: AGHT+IGNZ5nbYE8Fd43w25borAE5oWxLp3BVFgZoQNiZy6uuhPEBq3Mtxfb/dWKAaOhrBCafk/Tx3Q==
X-Received: by 2002:a05:620a:4492:b0:7c0:b1aa:ba5a with SMTP id af79cd13be357-7c0cef1721cmr471596585a.33.1740159014946;
        Fri, 21 Feb 2025 09:30:14 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0c4bd042dsm213181085a.61.2025.02.21.09.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:30:14 -0800 (PST)
Date: Fri, 21 Feb 2025 12:30:12 -0500
From: Joe Damato <jdamato@fastly.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 2/2] page_pool: Convert page_pool_alloc_stats to
 u64_stats_t.
Message-ID: <Z7i4JPCZHbbP0OLS@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221115221.291006-3-bigeasy@linutronix.de>

On Fri, Feb 21, 2025 at 12:52:21PM +0100, Sebastian Andrzej Siewior wrote:
> Using u64 for statistics can lead to inconsistency on 32bit because an
> update and a read requires to access two 32bit values.
> This can be avoided by using u64_stats_t for the counters and
> u64_stats_sync for the required synchronisation on 32bit platforms. The
> synchronisation is a NOP on 64bit architectures.

Same as in previous messages: I'd want to see clearly that this is
indeed an issue on 32bit systems showing before/after assembly.
 
> Use u64_stats_t for the counters in page_pool_recycle_stats.

Commit message says page_pool_recycle_stats, but code below is for
alloc stats.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 12 ++---
>  include/net/page_pool/types.h                 | 14 +++---
>  net/core/page_pool.c                          | 45 +++++++++++++------
>  net/core/page_pool_user.c                     | 12 ++---
>  4 files changed, 52 insertions(+), 31 deletions(-)

[...]

> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -96,6 +96,7 @@ struct page_pool_params {
>  #ifdef CONFIG_PAGE_POOL_STATS
>  /**
>   * struct page_pool_alloc_stats - allocation statistics
> + * @syncp:	synchronisations point for updates.
>   * @fast:	successful fast path allocations
>   * @slow:	slow path order-0 allocations
>   * @slow_high_order: slow path high order allocations
> @@ -105,12 +106,13 @@ struct page_pool_params {
>   *		the cache due to a NUMA mismatch
>   */
>  struct page_pool_alloc_stats {
> -	u64 fast;
> -	u64 slow;
> -	u64 slow_high_order;
> -	u64 empty;
> -	u64 refill;
> -	u64 waive;
> +	struct u64_stats_sync syncp;
> +	u64_stats_t fast;
> +	u64_stats_t slow;
> +	u64_stats_t slow_high_order;
> +	u64_stats_t empty;
> +	u64_stats_t refill;
> +	u64_stats_t waive;
>  };

When I tried to get this in initially, Jesper had feelings about the
cacheline placement of the counters. I have no idea if that is still
the case or not.

My suggestion to you (assuming that your initial assertion is
correct that this_cpu_inc isn't safe on 32bit x86) would be to:

  - include pahole output showing the placement of these counters
  - include the same benchmarks I included in the original series
    [1] that Jesper requested from me. I believe the code for the
    benchmarks can be found here:
       https://github.com/netoptimizer/prototype-kernel/tree/master/kernel/lib

That would probably make it easier for the page pool people to
review / ack and would likely result in fewer revisions.

[1]: https://lore.kernel.org/all/1646172610-129397-1-git-send-email-jdamato@fastly.com/

