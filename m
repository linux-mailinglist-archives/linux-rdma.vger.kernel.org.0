Return-Path: <linux-rdma+bounces-4359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7E9515D2
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 09:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E9428A9BA
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696913D24D;
	Wed, 14 Aug 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9iKN+Q7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941980631;
	Wed, 14 Aug 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621728; cv=none; b=Im7RlZ32bo49pI06WLBSves522Wjmil7AtrHEHFeWk8UvkLqGHQ5Qb/XSYKsorRJmvA129OmU9VbdYtPTDm/YkTI95uW0ukdWUrK97WzUSnKyzZ7EMgxZgNhjFm1D/NLkkjE0sJW5u3+gs0+OXvckwaIOjsR07iUROCOS+IwOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621728; c=relaxed/simple;
	bh=iJuDt/e7gDTb1RnY7IiC+ni6rH+Nm1TYE3T9Gv+XET8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbH8GBwrFqov0/hHeM1bB8UlJx5SlpGFVY5zBRY620JM2GfXqLSd+nMj7T9dYX1RTteAfY06r7eTlZUagir33mGMdWwROZykBNxAzwxsS130RO/NLiCeAtprD64zNc6ZD3KSlagev1aKdgenfXjrnlZg+zeJp2FQHDLKZgMmWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9iKN+Q7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-530e2287825so5906819e87.1;
        Wed, 14 Aug 2024 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723621725; x=1724226525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTBG7pWOTTy/Oj13XKoVBOb8eh5xKMwFm4QHE+CcG2c=;
        b=S9iKN+Q78IJnjFUbolkyUp/hAiv+bIGt5NKA0KKYwEidUiRt7ULBHXJ59VfS7d7wyv
         wd31fr0AOjSNecmACGG0d2TK94RzWTf+GLR1wVaYcIr6onCJt+U6gyf4xyMtHFZEeHDf
         PqHLnItWBojilSKfOwHVTLC5gGEcuef9HYKHYWETM7AsCdfWRWuGAYf61Dg00GKNyD6U
         U34aPuBoS0fpTVnRrpOhTnCOyn+O18GASsPrg43MVOKt7kjHHGdR978M/1WpjjdS5ku7
         ikLnc+vUPFQkP3y/77FcmIzBl+QEyFQRlfERK+AuMOZoxolwjyjzqD4IvaUnXlWO57Sd
         pE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621725; x=1724226525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTBG7pWOTTy/Oj13XKoVBOb8eh5xKMwFm4QHE+CcG2c=;
        b=G2dggkFb9ysI141/FZJhn8nPy+27yeRNH9RlnwIfn+ob7KkgEtlcc6Cl0MgA4nnL41
         3v3OIbJwq6b+J+eq4dz0rcR6tYIcNFenabgo/yC0Aki/lGP9mHbkGNTHVl6ecFTDnNcx
         kvXJiQg6Zk5xmjw94jHQ7+i/DkiciFcb9/VGIL18jNdm5ClJyFlu07rab83FeYCJv1rZ
         0aHh/jPanJQLOVZYaeFStHd6+Vydao39kABHSTq8rUZoYMibxl2mL/pcb1rmTE/nJBVK
         3dSyFuNKZjyjbfBOuPfFB+HdiIAR58qCuztSlDzE59Er30flwgd1XGpmv9oKGU8DhWJk
         ENrw==
X-Forwarded-Encrypted: i=1; AJvYcCVDuea951fMeko2lNQ6MzzCn4EW+cBWYjnskxbiW77SeHdytOGWWh77O1BTO78qpGRTvaD5Q6uFIyId2w==@vger.kernel.org, AJvYcCVMT6AHSoSrftZifN5NmLp8+WaZq5ckrqEH/wwfwafHXzRNKeG32i4k6pAUH+miTEJtecyGO9cxgCoeJwg=@vger.kernel.org, AJvYcCXjA6qLlIiN91fNj7CX9KoXTH+cpKFuCSAVUxlDMc8Es1Odbq1cuENjzDOwLSsRUoPoNesF7soA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54OzsHWTCGRcyXMBFpwpa6zr7kyipw9sCwHTHedRWjG3yjRiy
	2mCTNGvNIfI8BPPthJ/CwJtEqB0YHwg836AnlXLitvuoYfzhJejgGmQ5iA==
X-Google-Smtp-Source: AGHT+IEhSt8fr4BCSjgK03Wnbcx/EW5SSSEcfQBJWk/kQFKB8jP+uHpUayMCIn+lgzoF7G4h1xrhsw==
X-Received: by 2002:a05:6512:ac5:b0:52e:9382:a36 with SMTP id 2adb3069b0e04-532eda83a37mr1065725e87.30.1723621724241;
        Wed, 14 Aug 2024 00:48:44 -0700 (PDT)
Received: from [172.27.34.242] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7c93esm11636355e9.41.2024.08.14.00.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:48:43 -0700 (PDT)
Message-ID: <3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>
Date: Wed, 14 Aug 2024 10:48:40 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom
 code
To: Erwan Velu <erwanaliasr1@gmail.com>, Yury Norov <yury.norov@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240812082244.22810-1-e.velu@criteo.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240812082244.22810-1-e.velu@criteo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/08/2024 11:22, Erwan Velu wrote:
> Commit 2acda57736de ("net/mlx5e: Improve remote NUMA preferences used for the IRQ affinity hints")
> removed the usage of cpumask_local_spread().
> 
> The issue explained in this commit was fixed by
> commit 406d394abfcd ("cpumask: improve on cpumask_local_spread() locality").
> 
> Since this commit, mlx5_cpumask_default_spread() is having the same
> behavior as cpumask_local_spread().
> 

Adding Yuri.

One patch led to the other, finally they were all submitted within the 
same patchset.

cpumask_local_spread() indeed improved, and AFAIU is functionally 
equivalent to existing logic.
According to [1] the current code is faster.
However, this alone is not a relevant enough argument, as we're talking 
about slowpath here.

Yuri, is that accurate? Is this the only difference?

If so, I am fine with this change, preferring simplicity.

[1] https://elixir.bootlin.com/linux/v6.11-rc3/source/lib/cpumask.c#L122

> This commit is about :
> - removing the specific logic and use cpumask_local_spread() instead
> - passing mlx5_core_dev as argument to more flexibility
> 
> mlx5_cpumask_default_spread() is kept as it could be useful for some
> future specific quirks.
> 
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c | 27 +++-----------------
>   1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index cb7e7e4104af..f15ecaef1331 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -835,28 +835,9 @@ static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
>   	mlx5_irq_release_vector(irq);
>   }
>   
> -static int mlx5_cpumask_default_spread(int numa_node, int index)
> +static int mlx5_cpumask_default_spread(struct mlx5_core_dev *dev, int index)
>   {
> -	const struct cpumask *prev = cpu_none_mask;
> -	const struct cpumask *mask;
> -	int found_cpu = 0;
> -	int i = 0;
> -	int cpu;
> -
> -	rcu_read_lock();
> -	for_each_numa_hop_mask(mask, numa_node) {
> -		for_each_cpu_andnot(cpu, mask, prev) {
> -			if (i++ == index) {
> -				found_cpu = cpu;
> -				goto spread_done;
> -			}
> -		}
> -		prev = mask;
> -	}
> -
> -spread_done:
> -	rcu_read_unlock();
> -	return found_cpu;
> +	return cpumask_local_spread(index, dev->priv.numa_node);
>   }
>   
>   static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *dev)
> @@ -880,7 +861,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
>   	int cpu;
>   
>   	rmap = mlx5_eq_table_get_pci_rmap(dev);
> -	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
> +	cpu = mlx5_cpumask_default_spread(dev, vecidx);
>   	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
>   	if (IS_ERR(irq))
>   		return PTR_ERR(irq);
> @@ -1145,7 +1126,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector)
>   	if (mask)
>   		cpu = cpumask_first(mask);
>   	else
> -		cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
> +		cpu = mlx5_cpumask_default_spread(dev, vector);
>   
>   	return cpu;
>   }

