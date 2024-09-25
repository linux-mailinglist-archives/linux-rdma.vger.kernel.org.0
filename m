Return-Path: <linux-rdma+bounces-5080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E998529A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 07:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA071C20ED6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2024 05:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7ED14F9E9;
	Wed, 25 Sep 2024 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHTD8rSN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1E41C94;
	Wed, 25 Sep 2024 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243356; cv=none; b=l3Fwq2HHqqUtGGcDd6jJrnWkJhhm939rlJdWYEvJvwngggchWD34Yk4mP+F9PkCHgQe+4VYGeFgyWsbOjQYVZom/S+2zhejIMl39s1G5R6jj63Tvf7ywG733V8dtXBWyNPYMtlm3AWL1HUMbS9NWu0qXaMYOzb9Qfgtukwxq3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243356; c=relaxed/simple;
	bh=EaiuHR4nXAoTitp1GKRwPzR0M+jcOIeQkOdjb3HGMMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcNuR0I7NewH636d5KNbbt6qA0C1xF7sWXjDWAH0DAMhqLnDlzBtMR/gyX0B7GhYamQWWRfikR2RmYgcahXhfQMZ9OGLKucUgNuKwdxYL6YxHe8Bt1/v028uOsCu2r1THOuwSpK07SAcBm1DPDMAV52JP5rEaMBjVib3WvqjWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHTD8rSN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a90188ae58eso791288266b.1;
        Tue, 24 Sep 2024 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727243352; x=1727848152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gEgBm9IAsXl7nLB/B+Ejmtp5pyqjG0bV7kGihLC4Ko0=;
        b=ZHTD8rSNLtlwXNCsF6j66DkkrWI5DYygSGdcV0e6OXkpH+9IDUe1IpVeC4ZwNQujlx
         gOZW9Uu7Ao15mwjTa25XlKNaVEPhE6l4YRsnYkJ2ih+Elz++XWeeQNus0KNSexUFiqtQ
         vsL9RSFl0R0NAw77MHrQiE5QLqqCkPbML2Rm0kvCmC+13XVwJIlLNWU21oR1tlW53taz
         My3hL61Rng9rMKw+jQbT4KNYsF6hGOOqTNDPwoHqUh/zQd4dZAcjEDn9wiLXz722rDhY
         rHxnYe+qICaL00cTjp/rdL+NID217ST3bBgpu2iKDxOii9aE6cmfbXtZry4Ul60iXewH
         N2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727243352; x=1727848152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEgBm9IAsXl7nLB/B+Ejmtp5pyqjG0bV7kGihLC4Ko0=;
        b=R1/ZPyYKOUR3hBffSk69EZz7NTNjQWNd/z3BxpgDqaaSqomGEKY5hMzIfvA8AMJpIp
         U4ur9Et6ug1J8d3K5Q5JEPvs7VAo/ATBOjLxqdkRVN9EsZO3U8M04WNlzRy5ADKjuVTV
         OLA2QFbWPjY3OuR2B6ajiCPFB025eg0/khoUcalVrrWkr5ftavrqjD5jaPKdGP+zoF7Q
         icoxVU6+o6t/J4d6CWKOFsRms4ZD9OpvFhN7SzZlvcBK2Gt2gi+8bhZxG0b7W1XRAj5h
         CY+mT4aOh/f5rWUpvjYdKbwkYOObxlKf0koZPfCgMeSogYoGSb2uoxJzg0ZgFqjqKKrA
         wMyA==
X-Forwarded-Encrypted: i=1; AJvYcCU18rBoCXsbOGx5/i9vK0XJMwxt2+woLLXnYhyzCMx02mBX7PlCqYNGKZjbIB8rDCJhBj1ISK6043DPtQ==@vger.kernel.org, AJvYcCUEVORMQpHR3njRtU/Z8f1sgnG9cTHlopaEk4i9hVTxOiSQR5IyopQ1SqunYO8Nkzn7WYgXroWXNt7sy7U=@vger.kernel.org, AJvYcCVsQ540EZo2hkkKERc1w0VPhmoCsnHseFHHKiQ/GqLqNX6JpFqkdo66Bge08nfa/AXy8UhbcO7P@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGd4kkg/bUb/TJ3IL2VGlgqXxlDRtcnHKciMu46OxQqnV9j8W
	p87/gZ8Hn7EM6+jnajRkdayIcqrDezQCIq+9GTUcurnXuCY8Vc0l
X-Google-Smtp-Source: AGHT+IGo5B6L2X40o/cBhBGBxGr8K8zvPiaZOe+WSV+8oaJgevY4q0tCbZHrE3QDGUXrGI7h8K66cA==
X-Received: by 2002:a17:907:e210:b0:a8e:a578:29df with SMTP id a640c23a62f3a-a93a03200admr111699166b.6.1727243352030;
        Tue, 24 Sep 2024 22:49:12 -0700 (PDT)
Received: from [172.27.51.115] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f8440sm170081166b.182.2024.09.24.22.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 22:49:11 -0700 (PDT)
Message-ID: <17f3baee-c654-4e6f-a5d4-ba0899fe2385@gmail.com>
Date: Wed, 25 Sep 2024 08:49:11 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5e: Fix NULL deref in
 mlx5e_tir_builder_alloc()
To: Elena Salomatkina <esalomatkina@ispras.ru>,
 Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxim Mikityanskiy <maximmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Maor Dickman <maord@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924160018.29049-1-esalomatkina@ispras.ru>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240924160018.29049-1-esalomatkina@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/09/2024 19:00, Elena Salomatkina wrote:
> In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
> which is dereferenced on the next line in a reference
> to the modify field.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
> Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
> ---
> v2: Fix tab, add blank line
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en/tir.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> index d4239e3b3c88..11f724ad90db 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
> @@ -23,6 +23,9 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
>   	struct mlx5e_tir_builder *builder;
>   
>   	builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
> +	if (!builder)
> +		return NULL;
> +
>   	builder->modify = modify;
>   
>   	return builder;

Thanks for your patch.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

