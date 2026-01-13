Return-Path: <linux-rdma+bounces-15489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D90D16E1B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 07:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99458303419F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6873C366DDF;
	Tue, 13 Jan 2026 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlqznh0K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9E217722
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286627; cv=none; b=puoQ1vVEl4WMfLICmVF4LxOdv2CxzCgvyEyy/QVso3eK7luvlE9Qf+Q2aKPpPPXhYyjZpfc6WOAVP06I5NcnBIDDCyLtqLhEy6+vO4TZI7YwTMM3yymf/FNt+dB7vxRV/lPFLfkanGail+gMtEUjxkPWDwyOPJRfS6jhvRpSryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286627; c=relaxed/simple;
	bh=4xRp9EmzMV7UevZ0sWEkDBOodR/UA5X1qgUIvoNC9pQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kv19tc5EkYLXWooawWrJWQv5m3cxBDhhx9BCtFNheiRJNuMIfRkpeapO+12+y7hFNeAsA+Ckqoa6vx+fxVkSok6n7dCbuQhGQ97CeLehPTOv8lrYA1W3JZNoOqnYvGsGj17q1St2iJFXAxPmZq+rkf470EVm8k+eB4peGzn+ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlqznh0K; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so41102905e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 22:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768286624; x=1768891424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ghDCM8N9hxvDdm5XEm74/ukNIOPEjRNuq6UPBRaEC88=;
        b=mlqznh0KAmc2HekvQQUM75RbUjXLgwKRtqyFu60L1W1iK2cI1m6WdjgRE8NbDcuOux
         GAbpmKYMDi0zOzCFH/oEkvMEml9+A3iG9nMffG6b/3fVhNJN7JazjMtHO31i0MQLGnfQ
         /2nemnnh7Qa+Cs/3rciDVlP5tw0kW6IYXNmNs9Y9ZSIZy1iur3JVIgzuwCjj1OYLc9ob
         6B2WGt78puBqtMzzEfEKWHyzHfbN6mo1UDTLQ3RxCJaW9ZZTxGe7pfukIL9+hvY1wn1M
         2s8Em6Ux8utqmH6jZvMPciWRjmEKqp4H0JxORveQ3mzcD90XG5hdCbLFaDjgIHXvYlos
         IMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768286624; x=1768891424;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghDCM8N9hxvDdm5XEm74/ukNIOPEjRNuq6UPBRaEC88=;
        b=KyGK0pxS6VH80Wmo0AbWWkLzcQgqXSNAz4yxVwlpyAvqHdiioZn/2IgdeLjPJlXeMA
         kbpqX6BhxwVHdTzTE8NGeK/t9dFdNnfF/TephTcaDjKQoTX9DVFoMLiVIG/drwRY4d/C
         5j+9zQHgNIQXwkTaSJ03xGtKEKJAhgcJv1g5MzJzl4ao1aimoX1ktewPU/rMdF/oSZpJ
         7VmMkhkTc0CDrTK/7L8yFzy9iPzvThDFeUorccXtHrerEOQLfLM+d+kLdWTevtbaHRz3
         TFRh257kAOiLbPFS5XHGQ8KDXslFVRwy4e+OApS2TbRLUByLx+GuyJ2ffGX6xIaEvRLB
         h/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUd3GwEuTA8DbYDxyIo/tbLdtCGh1KFLZHnd9VbBMhmUzULaQ4/6EIgOqfwcdB4UcQL7n4/I0Bk3AXA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1cyNIzgT4fHzbXUHuFj8q1soMY4nqLlilOp/ZG9oSPrBo782
	scEGY6zPPL5kmVrCcDiZ2tcwD9pHSGx/e5FLh9psyyoV+8EkreT9B/Rg
X-Gm-Gg: AY/fxX5wp2NWBiVw21BD+Mebyibk7rO5zmMtjd09OsDXsOmshmsB/XrY5vifGeYx8Em
	yUelHrj3QlNi50ToCio7Co7L6QVDjWdb1bj9hIIvvS1ExZNOkpLbtSnQdQxWpSmm3h/2/tfSIaP
	3ODuKFtDTj+OqUbjot0bZALLBfJ3sQkAj5Ni/tAZmr+JSE8IjILV+fgcz6r5+Y9BOJxoesH1/tf
	+Pk1R1bwetHYypy9J1iSqICpyykg7SyPx3ECjgSPQCRF7W8xmeT+caguqkoUaqkOa+aCKX+Vc6G
	HO4opWKnXOMiH1SmvVThUrymH+Q6bxLqhrodFX984fv4qES1TOkFc+hmow/Z9NbxunFmD1rwpMz
	7PHTf3xxq1aXYntHO5ILrepKTZpadShsbJkacLbdzRfSs26B4WNEKapA/VpFSyU6Y6lFjyEKrpA
	Ej8/3zZf9MzWO6qS7gGyXE/GnCNNZn3UPxYW4=
X-Google-Smtp-Source: AGHT+IG5Hg9+17m7J4fNxlH62AWH3o6AAFlmU1pJNtsSLShz7avFHksvTJHxAOMxOVStty2IwBs58g==
X-Received: by 2002:a05:6000:178a:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-432c37644b4mr25992646f8f.46.1768286623960;
        Mon, 12 Jan 2026 22:43:43 -0800 (PST)
Received: from [10.221.200.118] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df90dsm42594086f8f.20.2026.01.12.22.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:43:43 -0800 (PST)
Message-ID: <e22a37a6-d15c-4abe-becd-4c538d99ad30@gmail.com>
Date: Tue, 13 Jan 2026 08:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mlx5-next 0/1] net/mlx5e: Expose physical received
 bits counters to ethtool
From: Tariq Toukan <ttoukan.linux@gmail.com>
To: Kenta Akagi <k@mgml.me>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260112070324.38819-1-k@mgml.me>
 <0ac69f6a-d587-45a7-be30-6ad4429ef8d2@gmail.com>
Content-Language: en-US
In-Reply-To: <0ac69f6a-d587-45a7-be30-6ad4429ef8d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/01/2026 8:31, Tariq Toukan wrote:
> 
> 
> On 12/01/2026 9:03, Kenta Akagi wrote:
>> Hi,
>>
>> I would like to measure the cable BER on ConnectX.
>>
>> According to the documentation[1][2], there are counters that can be used
>> for this purpose: rx_corrected_bits_phy, rx_pcs_symbol_err_phy and
>> rx_bits_phy. However, rx_bits_phy does not show up in ethtool
>> statistics.
>>
>> This patch exposes the PPCNT phy_received_bits as rx_bits_phy.
>>
>>
>> On a ConnectX-5 with 25Gbase connection, it works as expected.
>>
>> On the other hand, although I have not verified it, in an 800Gbps
>> environment rx_bits_phy would likely overflow after about 124 days.
>> Since I cannot judge whether this is acceptable, I am posting this as an
>> RFC first.
>>
> 
> Hi,
> 
> This is a 64-bits counter so no overflow is expected.
> 

Sorry, ignore my comment, your numbers make sense.
Maybe it's ~248 days, but same idea.

>>
>> [1] commit 8ce3b586faa4 ("net/mlx5: Add counter information to mlx5
>>      driver documentation")
>> [2] https://docs.kernel.org/networking/device_drivers/ethernet/ 
>> mellanox/mlx5/counters.html
>>
>> Kenta Akagi (1):
>>    net/mlx5e: Expose physical received bits counters to ethtool
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 


