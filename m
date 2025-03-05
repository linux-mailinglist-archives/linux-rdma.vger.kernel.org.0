Return-Path: <linux-rdma+bounces-8377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFFA50B2B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791AD1885D47
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A51E5B91;
	Wed,  5 Mar 2025 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6skyESF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5F16426;
	Wed,  5 Mar 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201949; cv=none; b=Jvr8NOuhCUwzEWZupTacP9Fvui3QEa81HAY+Ie3GYMF/NxKKdEiGl8c7m/p9nWvB22rxrYcppWIrP7Z9KKz+OcKgc1FiCj5z5HuKdGWKMpLaDITq3Ej5PUFMq+hbypMZI9FnSH+5fPmvOpV7h2+glMUSapI0IdueOO2ub03ZXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201949; c=relaxed/simple;
	bh=OQIS71VY7d37k6PpXEg25jjEYN9BsKp+QOVUVeBB7os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoKnkkYoUDojmVN8vJX6kkX7HtnBQvLtCY0sp4PA2F1ATixaitoylRCyQQllNUFlYcaDlO9D12LujphR5E8uEWTCrS6QlssquqMen37+5cmGGZZhXetO9XX5zTEqGEO1+Tj38k59BesCKEGm4kXLTxjE4JK9B7YOwfQHiic4oKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6skyESF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3910f525165so2859811f8f.1;
        Wed, 05 Mar 2025 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741201946; x=1741806746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UAtTDNi9A6LaL+tM+1TUxbX2g8gujKdVZLYK4r9TuM=;
        b=A6skyESFXR8PPJugQcUEcQ+qY6rbbW6fWETITaQ0eyyshwcezqFkBIQwR1bFhoRxTl
         m7U2Vg+s0zp8llRDdb5eFRA1OwjYaFe2oa1uxJqCDR5FposIE5l2zHW3evYH9+ncM/rl
         Siz5Ydr2iFW0ETjTvWN6NR9spxSd1iih8pagKxt+qIjERlfBPf+NDbsXaImRmum/hazj
         2jRW11Vol6h72QaDOIv57szM7VE89pIgwMAQdmkIsvb0bRTE4uJjqDqj1aB6pIJNZ859
         bYk5j5Up92UFhRnjS7QBG0hnlwvEzwWGdFLPlqsK/76dc76uO9i5q4JTp34o6GWzB9KJ
         4vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201946; x=1741806746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UAtTDNi9A6LaL+tM+1TUxbX2g8gujKdVZLYK4r9TuM=;
        b=EGiK9dgEVR/4/lEJR/t8lgG6e1Wkw3G1ZbdDtqyel3w4jkWgvGgebVz4e9ZRRaYBUi
         D26u86cA4OZnGJ/7B158hWqV1l2IN0o6wGdj6EL2vTZPtW6ApQeh/7RmJcjVVhhZxVf2
         i0p9c6cG+oPJEKmh7xjl70Fk4MvWCiD7sxta5/6QYk1XF9k+du2dNGEpQ/ud4+Jo3TRR
         uMbY7mLIjqbHnMUqMgkkOoL0Ztys+HGinCyIcaD55i30Ho8KG/rOT14plSULGj2tHJGs
         Pr+dQzSYVyoU1MX4xjdcjaWM4ROewFMHiXMoLlkC5RZ7h6FeJYdFp7tbzqRAJGrEq66G
         1JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU88r3r6+43GtLVuXItqOk7b2aZK72d4Ly/76Yx1i2QpIwDX63XP3POEi4Awm6q8AVdX7fWBCCpUq+6sjU=@vger.kernel.org, AJvYcCXFWhY7FvfZAFLRQpZPoY542X+P5fdZ2h7K4L/LWzl4iLSv05FttQ/bhkUfe2jWsIx2ZhjfU1SqhPHFGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbyjhY8FlePMNYEkKzuZmpYjBUduUvMu8LfTXJuXXnOJ3X/VT
	2y04YNqmLDWbnQgu9rSO8OjLoGxdXlQdDMhPPyTH7iKInx47wHx5
X-Gm-Gg: ASbGncvVAe9JacLvy6wAotjMmxjX1JMCcJxLEztUOawN+SydPPLiTZ/PJKOZZqxfBjr
	qx8wKMHUrQog+dYA7YVxmBHkcbeYiPo2LZhbr+v06bNsGcP4MAZN+tpTSNV5TXuiP5oDBM6Ny+D
	Mt9jp1kIdJFINvpslTx/QzYvroRYlxLMEfUcq6u/k2RKCcP9PEzX5Pl24/8S8GM918zscXh1EyN
	BV4Kf5KNq5trYrV7aQdAXj5jXczhodF/lHxwzjzsxxDht1bFPHB/JR79P4KHZ97sEM3IDGXapiU
	iuG1tWdx42izBqd/CC1iexXG3mEwaTeOYojW4zECbpBhs55VxNQMbunsL3nUvd8QDg==
X-Google-Smtp-Source: AGHT+IE9Jfcw1QTaD71UiMWcIV4F62fCIiDaj/lP77sDS7GkTItX4uePhMNdB6mev257s1kfrn+nAw==
X-Received: by 2002:a05:6000:4025:b0:390:f6aa:4e6f with SMTP id ffacd0b85a97d-3911f714de9mr4298289f8f.10.1741201945611;
        Wed, 05 Mar 2025 11:12:25 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a38sm22061124f8f.75.2025.03.05.11.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:12:25 -0800 (PST)
Message-ID: <49df4e60-695a-4562-aa27-f946e7acd485@gmail.com>
Date: Wed, 5 Mar 2025 21:12:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: handle errors in mlx5_chains_create_table()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250304080323.2237-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250304080323.2237-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/03/2025 10:03, Wentao Liang wrote:
> Add error handling for mlx5_get_fdb_sub_ns() and
> mlx5_get_flow_namespace() failures in mlx5_chains_create_table().
> Log error message with  mlx5_core_warn() to prevent silent failures

nit: double spaces before mlx5_core_warn.

> and return immediately to prevent null pointer dereference of ns.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Please add Fixes tag and target the patch to net.

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> index a80ecb672f33..e808531cc6f5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> @@ -196,6 +196,11 @@ mlx5_chains_create_table(struct mlx5_fs_chains *chains,
>   		ns = mlx5_get_flow_namespace(chains->dev, chains->ns);
>   	}
>   
> +	if (!ns) {
> +		mlx5_core_warn(chains->dev, "Failed to get flow namespace\n");
> +		return NULL;

Callers expect error, not NULL.

> +	}
> +
>   	ft_attr.autogroup.num_reserved_entries = 2;
>   	ft_attr.autogroup.max_num_groups = chains->group_num;
>   	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);


