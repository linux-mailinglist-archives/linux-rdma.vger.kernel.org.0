Return-Path: <linux-rdma+bounces-14052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95214C0A850
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 13:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5823AFD90
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966932DF130;
	Sun, 26 Oct 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7vztKOR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC924A074
	for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483238; cv=none; b=HrTUmHLsbe4xcnsUvXO5K7cHBEhJaOSdKd3DxeJfDxbG+BWylmND3GkvhM2jAUkcyURgRdUSKuwSqH2XBZki5Icm7TLhW198TMzUQOHSou5kvbbzZbW7zRwTqntwOzSbWqDJ5UNjNg7b+OpApktmCQ5LZ7hEPQaCTqIubhNMriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483238; c=relaxed/simple;
	bh=CyL6U2fX8FZXu00nUcb3mHVole2/hj1X1E6kj7nMlt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMp/t2Mo1NOhScgOe1tbvtDYqSuCXy8WELaa5L8Poa10FZm8gy52zjoW9HUkB9Tz7onnG16i1+uNxotFYxy6uoKjZlevtAbt221cDKWhanZO6dxngwgxq+TfdVCx1LnqqAKpIbIVqI2DA1KDXJ0rHCoqhm6QzuKTr6cnoyYBMeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7vztKOR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4711b95226dso43795695e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 26 Oct 2025 05:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761483235; x=1762088035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i26CRJcrGe4BdHM3xxFhCLRVQ9kLMqkWcqoTK+HJaKU=;
        b=C7vztKORaQfMOw3YlBAyiSUSui+Is6YuWLwmV7o3aZD5ez71EqJADvXa3VkU+M7IoC
         PyeUQSnaWqt5V0F7JUhs4bNYgKh6nmmXgRUqrpHyE/s0AFW8eOMNwyMIMPm6sxeNWrLl
         kQwZ7wb+tVTrkiY+0O21GgiMgGmSOzTV0rJ4btR/ni5oqk98MxN/Z2PVqjfsdYt0QnQ2
         p6WHfA8OFp8ueWdvycKvxrxRxnQS+MpbuR6Z1Fj4zEjiJfLnREpKLPICzKmj3wcM4/SN
         1aWq+vyM/lK48/uIFVSjDnDxNC8oobSAsN196vekgWP1FmZAzlMw+POumGL0ALyAtvbA
         tZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761483235; x=1762088035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i26CRJcrGe4BdHM3xxFhCLRVQ9kLMqkWcqoTK+HJaKU=;
        b=ghXwLgjnZNp0i0Z04mKjDY5NMEgNZosrTmE8OAzvXIxFHR8jGeUKn23paIicx8udwc
         bLTNgyPVOz3xd074TmW1PYSGvlIAlrGkqQfvVH5+YtF0vDeKMqiJoh1LtkIXOUYHJsOP
         9Vf9QixXv9b3euSw8s0RMeBal0fEjAxfTfpMsWxRB2sYBGxhOngTf49hAiq30zbKjUik
         NaUNkFT+XwaGvHKPnyk2qWO8ljtkSR3HFmkgbfTnfSZZuNVhc9VUG3r2C5uDVLZTDbwS
         YRdmC+dYZMDXTCr/a56pqpBFiT4sXirjVo/wgZ73c89LmO6uBE5od20VuC+FIbrR6s5K
         ciyw==
X-Forwarded-Encrypted: i=1; AJvYcCX+kNF7LDxPSePvrAqz4XC/6plUFiAQFOaszF/tr1TjwAaMUoTfmL11m8+ZB32e8yY5vQQmGa615NJm@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHVKt4FEQB3PQlXcq7iQkn9z4jvhzFk+q+Blj8IRlq4UQm7I3
	vX5wgmnYV3qPZEcM10eUbDXzoKeRi6jb+pxxb2nrJSrlCxxduPjtzodd
X-Gm-Gg: ASbGncuyqCfTK2h8aeDvfrcovlD1BC3JC0n3YpcKpzxcKrhvMzyICxlddCoC3j24eKz
	f/uCAp7ECHo7Xc2qMoH1FbRI3myR+yAT6lqWxIEwUtcaz4y0PmFsmZlI+kFeq/UWAmNL27uqaMR
	drJrke06tODP+nAzhjFrsrWgTiuzLLPYub24RWeq0c2tIxBPD5hoEe7qV3oZkpWjiLTawNa641X
	DYISdRpEmvu7k+5NK5ARajxGwIBZYWtfDis9pXCNhiaCUYwc1ll2gKNFmkM6mXB+HIqrjpCHflU
	kKb9xxkXaDWUvqQ2W91P9697KxvpDwtagob0maWEHUSLnseGQ9BRpbzerWWkX9ak3Ws9oujEsNj
	OHPD1HvMakKORT4vKl59Xx5n55aAsg/2yC3uxjpn056bbpjAKqElkJebh15Nxcb120q0b8QHXI3
	EfF8kARGItz3C+6tJ/CBo8vQg=
X-Google-Smtp-Source: AGHT+IFJUSS1Q8cwzkZUDDbdeQa6stYxe8rs4Tv4IO8zl8FPI2XfyzYE3FyOP61Il7yGxBXwHY0cSQ==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr281885455e9.6.1761483234846;
        Sun, 26 Oct 2025 05:53:54 -0700 (PDT)
Received: from [10.221.206.54] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc16sm8399094f8f.15.2025.10.26.05.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 05:53:53 -0700 (PDT)
Message-ID: <2f84a4ee-8e45-460a-8e62-3f9a48da892a@gmail.com>
Date: Sun, 26 Oct 2025 14:53:51 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net/mlx5: Add balance ID support for LAG
 multiplane groups
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
 <328ebb4f-b1ce-4645-9cea-5fe81d3483e0@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <328ebb4f-b1ce-4645-9cea-5fe81d3483e0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/10/2025 1:59, Zhu Yanjun wrote:
> 在 2025/10/23 2:16, Tariq Toukan 写道:
>> Hi,
>>
>> This series adds balance ID support for MLX5 LAG in multiplane
>> configurations.
>>
>> See detailed description by Mark below [1].
>>
>> Regards,
>> Tariq
>>
>>
>> [1]
>> The problem: In complex multiplane LAG setups, we need finer control 
>> over LAG
>> groups. Currently, devices with the same system image GUID are treated
>> identically, but hardware now supports per-multiplane-group balance 
>> IDs that
>> let us differentiate between them. On such systems image system guid
>> isn't enough to decide which devices should be part of which LAG.
>>
>> The solution: Extend the system image GUID with a balance ID byte when 
>> the
>> hardware supports it. This gives us the granularity we need without 
>> breaking
>> existing deployments.
>>
>> What this series does:
>>
>> 1. Add the hardware interface bits (load_balance_id and lag_per_mp_group)
>> 2. Clean up some duplicate code while we're here
>> 3. Rework the system image GUID infrastructure to handle variable lengths
>> 4. Update PTP clock pairing to use the new approach
>> 5. Restructure capability setting to make room for the new feature
>> 6. Actually implement the balance ID support
>>
>> The key insight is in patch 6: we only append the balance ID when both
> 
> In the above, patch 6 is the following patch? It should be patch 5?
> 
> [PATCH net-next 5/5] net/mlx5: Add balance ID support for LAG multiplane 
> groups
> 
> Yanjun.Zhu
> 

Right.

Indices shifted because we sent the preparation IFC patch a priori:
137d1a635513 net/mlx5: IFC add balance ID and LAG per MP group bits

>> capabilities are present, so older hardware and software continue to work
>> exactly as before. For newer setups, you get the extra byte that enables
>> per-multiplane-group load balancing.
>>
>> This has been tested with both old and new hardware configurations.
>>
>>
>> Mark Bloch (5):
>>    net/mlx5: Use common mlx5_same_hw_devs function
>>    net/mlx5: Add software system image GUID infrastructure
>>    net/mlx5: Refactor PTP clock devcom pairing
>>    net/mlx5: Refactor HCA cap 2 setting
>>    net/mlx5: Add balance ID support for LAG multiplane groups
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/dev.c | 12 ++++---
>>   .../ethernet/mellanox/mlx5/core/en/devlink.c  |  7 ++--
>>   .../ethernet/mellanox/mlx5/core/en/mapping.c  | 13 +++++---
>>   .../ethernet/mellanox/mlx5/core/en/mapping.h  |  3 +-
>>   .../mellanox/mlx5/core/en/rep/bridge.c        |  6 +---
>>   .../mellanox/mlx5/core/en/tc/int_port.c       |  8 +++--
>>   .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 11 ++++---
>>   .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 32 ++++++++++---------
>>   .../mellanox/mlx5/core/esw/devlink_port.c     |  6 +---
>>   .../mellanox/mlx5/core/eswitch_offloads.c     |  8 +++--
>>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 ++-
>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 ++++++-----
>>   .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  2 ++
>>   .../net/ethernet/mellanox/mlx5/core/main.c    | 23 +++++++++----
>>   .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
>>   .../net/ethernet/mellanox/mlx5/core/vport.c   | 19 +++++++++++
>>   include/linux/mlx5/driver.h                   |  3 ++
>>   17 files changed, 112 insertions(+), 66 deletions(-)
>>
>>
>> base-commit: d550d63d0082268a31e93a10c64cbc2476b98b24
> 
> 


