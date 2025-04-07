Return-Path: <linux-rdma+bounces-9176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82ABA7D9B3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 11:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BB53AD31E
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541E22B8B0;
	Mon,  7 Apr 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIQERI21"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907B42A97;
	Mon,  7 Apr 2025 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018170; cv=none; b=lmnnBS7TKYFE41bOzG6ISnMOWPAqwYpgU7NMOHl764m40WKN3EBpiWmNAQrP3cF+bZ0MreoWuEb7pDXgSd+FTsGP+ycM+1WzrjzPFVTYjpvnOH1Nqvn8g64qu2ZGByJnDvEUNHwRcho2Jasex1rOI0eWpU/zwZWE8C2byx3y0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018170; c=relaxed/simple;
	bh=rHD1uqSjci+TtcrTXRPq07cH2uvgYPBnxO+ciNXB6R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpQvhOlmqdsvg6r+gCxkDteuQbX5kMlh+63THXsuEiRiV0azEI4S9MvdpNRGbCBEwEn9RfvWkEWHPJotZprkrQLwFCTPWK4YhfknGrNtjuRNk9Gl9VOyTMZZq1Kha1UKKjrl7elimgfHYwh5+deCGmlMk5z3ukKc2lhXZxLJwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIQERI21; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499659e669so4310416e87.3;
        Mon, 07 Apr 2025 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744018167; x=1744622967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pT9qPTRONy87iUjfoBKw47SxzMUIpI9ld9jYPqDiOs=;
        b=VIQERI21v1dlcZps7EuzduGEQc2yxuLgEm3HDOKFbOtkl4dRVjYFhmC26N5PJfdeLD
         AU8nyRAb52dbUm16f4nFrYHrXiL/Z269nVg+KAB8xkRY8vJZckpcK7felJvD4wi9euYn
         4N5+b6s/pJxbC0JWfhP5HuRruU79gHDzEOjz5pULjVRDNNZTQEr0sPe+SWSO0QfFvf6z
         qGACB1GOUQ6Sl3euKbJ/NUj9qkRPJBtbCNnOCtz4k23XtIVR6CN81RWF8kSf1N00/lTc
         E4eIA2PBu3563rr3s+Eyq752QIG8xMCk42atC1NzWWDyJRj9RVixvMMKSKAIqLWcHY05
         nIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018167; x=1744622967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pT9qPTRONy87iUjfoBKw47SxzMUIpI9ld9jYPqDiOs=;
        b=KCTfNOWtuBJGMotd5/huBYnIzGjfIvSYOSXv2D9uuNKE/mayeqAx5u+bZXbIdhru5O
         nfJ4IjTEqZKIBNRAcf6cLKeG9GFd3yipvOiOJxdCcmmRC1owThXhK22uJggUmMajcFWO
         O6rvUQJJw0gEZBn50Qhv5+KP2lbld/Nl833W0M7avFtoJB/iO4ACNDRDKpSX8xMNNoCC
         V6ZtutZYcaee8cqIOioTfay+TpOsUhcTOCqeUYz9kNS0IL3QQFqJEblotopkUeHs4JBl
         aZwdVi5gmF96qvyX74Pg1TDk3DMRecZle+8Cad4dnZQen8Zw12uHIIHlKkediFsstFlA
         0Ffg==
X-Forwarded-Encrypted: i=1; AJvYcCU16Re0Cu7WOJHA0TJ34vEnmYHUfgCR2x4p7j5rL8Jdw9TxkIXkX8bbdI4I5e88f18KfXEY0G4+HSovF3M=@vger.kernel.org, AJvYcCUKUIwJlMbSijonhxOwV4AkjimiymNx3jeHdt+kXXv2vfU9hRZqQyRIMvk39b/8XZymhCWVnt4J8iU8VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7h9eOHSqip63T58IFgNQkzWB/GIOfW5PXGrV2Sr0C7BBEta36
	ZQjJxLsE9oSEvcIfkBLqMRYVoAxlU4TFiVTi8E/QDWFLEc+j0gQF
X-Gm-Gg: ASbGncuJiQn78gftr8YiHxEHtS7KzdfUruaWThRBpBLFgURw6nEClVrW3iQ0m49gDjR
	Fz07apGQ3Fn1jsuEqoz9gwrwXb+GjmH8WGmuZBBC9DBoNcK2u3sAwd1k6mf5LRWvkIUB4GjfuTv
	NePpwYYjDhQ8XbGI8A4JCHmZl2oCz1WCQcaSP0K3dm3lGzdHwhnO7s6AI7rijRhtRhGnestUCce
	rbC7C0FoEsWcuB6P+Rjj1rzhZ2nDRvHTyqRfYjeirCMBfKBHafII1DT9ZhLA4JckMvcelY4dvEP
	L2bxKVU23BzS3f3PrHPBT5I+qMAnWMvtImSjQLvCeCnXQY+uQGl6ZlOtP6vKA4v6
X-Google-Smtp-Source: AGHT+IGevxOSETj/50TdherB8at+IXx/g8mMt/wv+Q4C4RedgnKKQM3QuJtVg24cql3ZX4dZtV+nrQ==
X-Received: by 2002:a05:6512:a90:b0:549:7d6e:fe84 with SMTP id 2adb3069b0e04-54c2280c8c8mr3043734e87.53.1744018166800;
        Mon, 07 Apr 2025 02:29:26 -0700 (PDT)
Received: from [172.27.62.62] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e635be1sm1231014e87.147.2025.04.07.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 02:29:26 -0700 (PDT)
Message-ID: <2bfd9684-7ef0-40b0-b35d-abb0a3453935@gmail.com>
Date: Mon, 7 Apr 2025 12:29:22 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net/mlx5e: fix potential null dereference in
 mlx5e_tc_nic_create_miss_table
To: Charles Han <hanchunchao@inspur.com>, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lariel@nvidia.com, paulb@nvidia.com, maord@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0e08292e-9280-4ef6-baf7-e9f642d33177@gmail.com>
 <20250407072032.5232-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250407072032.5232-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/04/2025 10:20, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
> 
> Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 9ba99609999f..c2f23ac95c3d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>   	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>   	ft_attr.prio = 0;
>   	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> +	if (!ns) {
> +		netdev_err(priv->mdev, "Failed to get flow namespace\n");
> +		return -EOPNOTSUPP;
> +	}
>   
>   	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>   	if (IS_ERR(*ft)) {

Same question here, did it fail for you, or just saw it while reading 
the code?

