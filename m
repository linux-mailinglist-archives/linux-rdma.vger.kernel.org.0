Return-Path: <linux-rdma+bounces-8677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7EEA5F8A8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22C117B64E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF10267F53;
	Thu, 13 Mar 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYT+mDT2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C0268685
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876852; cv=none; b=FJLwHX/oqriHMj81UArBrM9CxgESHPBktbl1jeoql+b2w88vLJ/GElmrqjrC2txlMjt1HfL35lP6KbH1RPCkH6BIJE0XcsPghkOk+e4PP178OWNaX299NeWGywyZiHGxHBYZftSEqdBg38sFlpy79Q/SezcUz0Pyyz04vqU/Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876852; c=relaxed/simple;
	bh=pAoE5946s5Gk2fA2kebJUB9HXCq9xcYQxsMTNtXL9/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqHl2ICok7EakaKyuWoZvUtanTzjS//hT2vWIfjR3l1wj8Xu9CgmRBSQ6Hj9aQhV6PKaJkV3/K6QKFf+MkYpZtrsZdpvxz86NtsbdhLu4FDgiCws+XXvjiPecjDkxssY/fJ5aWdYZCEvY0e0FutfwPWDTiE2QMnzdPShmQGGscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BYT+mDT2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6f77b9e0a34so9478117b3.2
        for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741876848; x=1742481648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L2Bl2Su+/gwfetUP/jaKlf54gtF49C473VvvFpM5g6I=;
        b=BYT+mDT2kM0vrNE2fkq6+ShFAVwkdJoGdGUgXCBZzhqKvj3E02EDqW6qezZa2uWxzn
         4xO02ckXDWRQWYLtxMbsvhBvycWhphRwu1AxsdNljMpeGyYtcz7viSANGbTG+klVcMk4
         9m/aIhrlzfbALvNMYOw21IcbxlaNTl2NAeRRoZc+bYzMyGENxynCpBw9qoXFjARwE0nd
         6aalNDqqWHLROvuuX5AHKWVWVstUYZSZt5eUJ8R8H+skyqijNPmkklOZTV53y75Takvr
         lh056z9kUQLWD3AHRYIkBbwacLm62F20ZozW62r6P8SzzMZSoGirLkxeM/nELo2MkAiy
         ln3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876848; x=1742481648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2Bl2Su+/gwfetUP/jaKlf54gtF49C473VvvFpM5g6I=;
        b=QHzVzh/HmHWy6gwwcPwSk3NPe4frO0QlB09qP04oO6VkzprjPo/uJoMUtyfIt/DcHe
         /whQ5TmwQgLVZxXNXPlTnO+/vLSG12obgnUnaCJnbe7Me5veYauD0qRpvQmf7w01eGjX
         nzQeFwNxyUr2cPZfI4dSJg643sBgV/qSxZx6z7Pb9oEDiMqZNov/eiu1LHRK2PWabRF5
         J/bltmeq+eO5dwOCNfgmCVprYlAPbEGOxSPc/Hxt02kVrA3+bwDHWdxEr4WdIwPjVgki
         bxFzQopIXFbQguijuRDI/uccCLLCR95Q1ucKGpaSm2wEMeh5k1lKz4Jo824LrOxvz6Xd
         SX0Q==
X-Gm-Message-State: AOJu0YxWgil6ZNgtnY1MjuGkVewskuV+VHcFj18YEuBT/16+hm5Z3zrc
	GBE2U0Y1SxOSizftnWS0wGKJXSpMiEGdyNfyCl5GpUy+SSafyFZiYQ22pOlY4gVlrzzTjf/W+ZA
	z9Jcbd+/wxyRRUMbKpsXGlpCSqD3ztNT817yZ+A==
X-Gm-Gg: ASbGncvunaEg0bl2OHK3sWCacZMPZKw7T0VpqP+M7wSxKg3pUpO77Wc9sWNzxVHKw5b
	vc5l2ra26P13wfIfm6+EwlWvjYG+lTAfU3uL+lFrKAg4nsodr50FLnWuum7tKxwd8Xq88KIaZhr
	GLfpRlC+gIDkIfhrWYO92YtCrk6GLFQO/SsnkxqA==
X-Google-Smtp-Source: AGHT+IHlqbCdi6b5AuWlv4WACVSDWJUjfnZagh7rV54UbyilpuB2Jl+yS7qcFAXsJdEa4V8w8Yh8A2r8jqbwYn6VwMQ=
X-Received: by 2002:a05:6902:2789:b0:e63:3e41:6579 with SMTP id
 3f1490d57ef6-e635c20370dmr33596240276.47.1741876848515; Thu, 13 Mar 2025
 07:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307115722.705311-1-bigeasy@linutronix.de> <20250307115722.705311-2-bigeasy@linutronix.de>
In-Reply-To: <20250307115722.705311-2-bigeasy@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 13 Mar 2025 16:40:12 +0200
X-Gm-Features: AQ5f1JomfK90BpA2TiJM9KAdy8VzKdj-rmW-tkbD-mIZWe61aNgjc9raPakx7eg
Message-ID: <CAC_iWjJYGdZNWhYfLwBiDjo4R+gGcujDKpEbOdgaA0mTa9Vj3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/5] page_pool: Provide an empty
 page_pool_stats for disabled stats.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Joe Damato <jdamato@fastly.com>, Leon Romanovsky <leon@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian

[...]

> @@ -81,6 +81,12 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
>  {
>         return data;
>  }
> +
> +static inline bool page_pool_get_stats(const struct page_pool *pool,
> +                                      struct page_pool_stats *stats)
> +{
> +       return false;
> +}

[...]

That looks reasonable. Unfortunately, we have some drivers that don't
check the result of this function, but I guess that is a driver-only
problem...

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

