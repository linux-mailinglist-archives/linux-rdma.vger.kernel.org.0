Return-Path: <linux-rdma+bounces-7981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB1A3FD4F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FD47A2238
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0A24FC1A;
	Fri, 21 Feb 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LAXfqUnP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8951C5D76
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158506; cv=none; b=dhJwS3F096qK2TT/b6YBuPz/Q4KfYo5fmIdGs8Sm2FYRHI3KUWkYuO92seepxj4PpFkootVg0GccLH+ZKoBS4RJyinsh3l9Oms8VRXJPtojG00SEnJ0yz364ZAXEeBWWm+mUfXgk3jm00IUUVmfgMjgHCwabYzTxls3ryU9mo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158506; c=relaxed/simple;
	bh=0Hht/jYaEq1V8iN+xgQCAvSA0pIDp8nvaC/arD4DlrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCSrT0CoZoqiZ6CpCScvGBQLxSg3GkPzpK3d6E5eiSQVl9AmTWGjPf78T1Stpzd3Ftx0oJdCvQr9Sv986pPAYblnVwu17BYf9ydyToM6LaMZDly/2DbC6cpQtSTRi51OgjlC0TEf4tT+VuEKBquC2y5z8fCpLSkMSwe1XvgrgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LAXfqUnP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0a159ded2so223679785a.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740158503; x=1740763303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Znmx94mCfsGvvpL2DgWVIQn2SIQ9TykkZQScUK21z0=;
        b=LAXfqUnPP4SciW5tWH6wau7VX8MEpjhJaR+lFYbNhUY/W2Jm7z/EXglv4dKQc5EcSm
         hfeH78weamMs75MDrx8ez10xf0PeIg2KJo3OVpva2/xISuEDu2+ov3fK1g7Svx8xEepk
         IQ4HPSIB8knAB9lL/dJpBtMSrvyz7XkT0ZQFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158503; x=1740763303;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Znmx94mCfsGvvpL2DgWVIQn2SIQ9TykkZQScUK21z0=;
        b=Q8XKuMYrh+yiwBYazGy98SKetG/nPXyyboJCRysKwO/wOGAVyGRWBxtqC5/al8dRXa
         bO1ebyKEGzvc53Qrw2H2Z+Y/rGGMIectvNZb5ig8AF4VhYWaxOYJfPvWT/1AxCJ5ztRu
         pCfiblcSxUtfwGsX7hcj1fV/uBQkbZwWHBO7QZefATA7oHvL8g9qytDpg8er/QN4a60H
         TLqABtemBdEU8tmwceAGbPPO1zptnOcOvp9q0FW3wg0lwM4WT0RQYkp+g+hvKHzLky/v
         T8PeJPzNLCwnD4MJHPml50KdPvFQhiUYcyww5DFKpxqjqgQjcNB6cvuXVszeslrs9NLU
         1uFg==
X-Gm-Message-State: AOJu0Yy8iZaljmYywXKiP/P3ODXX7fIcDlOCKx8Z/arWRXpKGgPxJsfA
	LkAVBQd4geQ+tzJwcMCvn3Ad/WgWSKUcFxfcbb4ozAkPBd5y+gbPFZ1Yiym9KpI=
X-Gm-Gg: ASbGnctXAqdWTXnibdAiveXcR9hpZTVBS6heSvh9vgLC7VA7Txi3YAvqyFAvi7vDgCM
	U6aOs3T1prVToDrdStwybfypURy2kfBGju1nWW8vyMfSef3xh8SFh9LOkIYNs+U4BSxDUTKBb4s
	HXbpAwuetFdaoPJqkWTL+kjSIqr4sxKgCuACcKEboFmO3CikVhCkwQz0ELoG9QGgbFg+M55p/yk
	MI92i/JiKFc4+8rjwno6qmeIC01vpqZO/FKdOamqpcIcNQJhbX3gNSYmbnzhl294Yyi2/yTQpUn
	Y+4XieO63E8BiRmgkU81rEIJHD5AKq+DHMzS2ksosXT03PoYhUs/CgAn2+B2JIuk
X-Google-Smtp-Source: AGHT+IHo/d78nx0q8o83gfhXEWNKkI1eKr24evaOrGuWvpwqOUkM+xFI9To4CNDvCQ8NQyKa3feC1Q==
X-Received: by 2002:a05:620a:488c:b0:7c0:a0ba:2029 with SMTP id af79cd13be357-7c0cef535b2mr650712185a.40.1740158503521;
        Fri, 21 Feb 2025 09:21:43 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b368d200sm398593785a.99.2025.02.21.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:21:42 -0800 (PST)
Date: Fri, 21 Feb 2025 12:21:40 -0500
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
Subject: Re: [PATCH net-next 1/2] page_pool: Convert page_pool_recycle_stats
 to u64_stats_t.
Message-ID: <Z7i2JHiKX6rggsUz@LQ3V64L9R2>
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
 <20250221115221.291006-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221115221.291006-2-bigeasy@linutronix.de>

On Fri, Feb 21, 2025 at 12:52:20PM +0100, Sebastian Andrzej Siewior wrote:
> Using u64 for statistics can lead to inconsistency on 32bit because an
> update and a read requires to access two 32bit values.
> This can be avoided by using u64_stats_t for the counters and
> u64_stats_sync for the required synchronisation on 32bit platforms. The
> synchronisation is a NOP on 64bit architectures.

As mentioned in my response to the cover letter, I'd want to see
before/after 32bit assembly to ensure that this assertion is
correct.

[...]

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> index 611ec4b6f3709..baff961970f25 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
> @@ -501,7 +501,7 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
>  {
>  	struct mlx5e_rq_stats *rq_stats = c->rq.stats;
>  	struct page_pool *pool = c->rq.page_pool;
> -	struct page_pool_stats stats = { 0 };
> +	struct page_pool_stats stats = { };
>  
>  	if (!page_pool_get_stats(pool, &stats))
>  		return;
> @@ -513,11 +513,11 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
>  	rq_stats->pp_alloc_waive = stats.alloc_stats.waive;
>  	rq_stats->pp_alloc_refill = stats.alloc_stats.refill;
>  
> -	rq_stats->pp_recycle_cached = stats.recycle_stats.cached;
> -	rq_stats->pp_recycle_cache_full = stats.recycle_stats.cache_full;
> -	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
> -	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
> -	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
> +	rq_stats->pp_recycle_cached = u64_stats_read(&stats.recycle_stats.cached);
> +	rq_stats->pp_recycle_cache_full = u64_stats_read(&stats.recycle_stats.cache_full);
> +	rq_stats->pp_recycle_ring = u64_stats_read(&stats.recycle_stats.ring);
> +	rq_stats->pp_recycle_ring_full = u64_stats_read(&stats.recycle_stats.ring_full);
> +	rq_stats->pp_recycle_released_ref = u64_stats_read(&stats.recycle_stats.released_refcnt);
>  }
>  #else
>  static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)

It might be better to convert mlx5 to
page_pool_ethtool_stats_get_strings and
page_pool_ethtool_stats_get_count instead ?

