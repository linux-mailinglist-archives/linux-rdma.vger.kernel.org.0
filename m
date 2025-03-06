Return-Path: <linux-rdma+bounces-8433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7AA556ED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457E37A53C7
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D740F2702DB;
	Thu,  6 Mar 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is6E4Hs0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DE26FDB4;
	Thu,  6 Mar 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289916; cv=none; b=JubVqBT/E9K2Tu58hKX38vSxBS51HCpw/flQDErnMma7zwkm9VF5InyKEwC8mPCnk6GnQagWPXXB2QlCg1FO3R/53iWP3QF+6EXOdf/fXsvEyvxCJEuhZyGQ+oPfl0Z4+/f+a3S1GQuWAuojGkEUzy97PslReXVyASLTSqqk+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289916; c=relaxed/simple;
	bh=nOtK01glKrGG8fuEMZiCN8DLp0nf98FDqZ183uM/Bss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+A8F4EFnP1Q6TMyP7dYa4jslcxuCuxHB4Twt6Flj2UQVOcXc/NDI36DyG4PUs9cdvtEtLS4pSsM4DGhXNyXDyzYGZJWVNqp4M1IOgiShFf1Me48rFqA0lISSAZr/4xB6BcUeKQa7pCEeM6JOknWuZlx8P91GTUzpLSiR7nyOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is6E4Hs0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948021a45so9571795e9.1;
        Thu, 06 Mar 2025 11:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289912; x=1741894712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGMiB37BFnD1cTo/Z8BxHm2wPrhG5rwdIKGIZoCVwxw=;
        b=Is6E4Hs0Y9kqEd+7kzu9BaCSmiUQ49H8qgs4k7XOyKCsr7V8ZwNgXypVnspqr27PTa
         OOSOI6oZcByZ9bjUsazxA5/FwWdVtHIPAEKTbSdQDP9ON9O81ti/B7YgT3BmMHZdZ3cg
         Oya67Kfckm6vyufeSKVRs3mA8uOFpDI1Usp2wcVGWkOsxomjqnAxaYB0p6ZU1TrdzTeT
         IR4HTn0XkcBkh2pOkQGAV7QZAh+tG/S+uDujA/4bPVOj6SOnY1ITdILRiFBqtijb4Bt7
         VbvLRCGkL/+R/CKeHbnIqiKp91GwtbzeJul4dN3fnhNq1D+JmvxGr5YVfywP3i2UHA6C
         Mqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289912; x=1741894712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGMiB37BFnD1cTo/Z8BxHm2wPrhG5rwdIKGIZoCVwxw=;
        b=ogiFFIOq7yZ4md/RCsLYtr3v8cO+h8SOaqc5Ar5f2YTetba8lPqUco68hUPbFSttzL
         OxlbR0Wmf6iZ8Ww1a/f9+siutVIAIUTOLltjW0Iy0ZozDZGkarjxqAmNkn4NXdJ3y3AK
         09mw+qxHb3JPYTRBFHd8eBDJEeC2M873oWNHg1LuYtk81imFsTkqyp9TNLZBQ+96t5SZ
         WICuZ4GngB9bTG/70DyORHMv9bqBJJP0jApgxUTmhik7wpJyY1CCj/Rs3iFbDYNXn7Qt
         ao4VK4CiW8m/QSU1dYfrHIgENmAOlYm4mWi2ewP+fbLSHw5q6CPOjQ0b6bA6+Li2/QPs
         4e4A==
X-Forwarded-Encrypted: i=1; AJvYcCUD5Jhq6tTgh2rLW8fMd/yenhNUUDnny2BJIxMug/t6mLH1rZ2HRJB7J49nCVg9T70RsJSAql8YjZNWWh0=@vger.kernel.org, AJvYcCUqLnB9s7ztpsdJgK8oHE8ubnc6PCo7mcAbRiP6TVE44BAWSg1yL3V+mixo8F+82AZ4k0mjaTXmd+X6sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHtZMktk2WKsWswwcmXepJ1wRY6ftgbfg93XGD2b9unbl9tLL
	HMoJYQEg5IhmTz1XlVlTWji+grWa9TivQs5lCZj65f74ZrUBZA3b
X-Gm-Gg: ASbGncsx7Oi2OZ1CDvpI0x2ardZfq4eHtMDrCo4dG8W+yYuAcMn0n90yAU5v+hXbYzL
	85hnpjXK+YZC/YAwsA9dYWOGlemqFV6PSGF4ibJTZ/98hLgh5HD1LdosQdFfh3tpsIEv0RNcDQA
	+NvDYXaQJGaugukIBAfk/U3crNVCR501hGoVmUa1hmN5PCsBcryIbMxiV9z+d83WDko23RjSzXx
	rQk0hHp9kGvKEvtxcA/z6vgh3UB6NuUaRxkfJu+sPP6sQzFTKBRjP4xZ0uNPDHU4B/L+m5wLvXD
	cx9QyoBmFRFaX9mkvuPMfOCbvGiPDESueP7buKSU9GC78bDVfKx2rGLW2+h591W/nA==
X-Google-Smtp-Source: AGHT+IGD/0SyHrWKAspEG39gZ6q7sFCG09cAYiqP92WJT//Fk9Phl43SI1M/Va8OZeVnbOyMgmj6uQ==
X-Received: by 2002:a05:600c:3553:b0:439:8bc3:a698 with SMTP id 5b1f17b1804b1-43c601cdc45mr6119185e9.6.1741289911674;
        Thu, 06 Mar 2025 11:38:31 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c3d3esm28587725e9.16.2025.03.06.11.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:38:31 -0800 (PST)
Message-ID: <a1e7b180-a3f8-4faf-8815-4b9a76fe2e4f@gmail.com>
Date: Thu, 6 Mar 2025 21:38:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: handle errors in mlx5_chains_create_table()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306104337.2581-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306104337.2581-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/03/2025 12:43, Wentao Liang wrote:
> In mlx5_chains_create_table(), the return value of mlx5_get_fdb_sub_ns()
> and mlx5_get_flow_namespace() must be checked to prevent NULL pointer
> dereferences. If either function fails, the function should log error
> message with mlx5_core_warn() and return error pointer.
> 
> Fixes: 39ac237ce009 ("net/mlx5: E-Switch, Refactor chains and priorities")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 

You totally dropped the change log, and the branch target.
Other than that, the patch itself LGTM.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> index a80ecb672f33..711d14dea248 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> @@ -196,6 +196,11 @@ mlx5_chains_create_table(struct mlx5_fs_chains *chains,
>   		ns = mlx5_get_flow_namespace(chains->dev, chains->ns);
>   	}
>   
> +	if (!ns) {
> +		mlx5_core_warn(chains->dev, "Failed to get flow namespace\n");
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
> +
>   	ft_attr.autogroup.num_reserved_entries = 2;
>   	ft_attr.autogroup.max_num_groups = chains->group_num;
>   	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);


