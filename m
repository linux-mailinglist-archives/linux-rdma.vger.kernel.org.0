Return-Path: <linux-rdma+bounces-5574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D150C9B2B29
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A401F228A5
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A3192D67;
	Mon, 28 Oct 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVbrfnQV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A68472;
	Mon, 28 Oct 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107103; cv=none; b=c3a9hNaYQCr+e5MVwY73L1zXFtc1+INNQcDPUCY0A8agOlAlULHRAPtxcYAZAqSfdHkMmhCOJ0+IB7wT4gGzYX4+RGoM3m/JnGYLyim1xS4/FgN9fx6IabpuIbyzCuu+voGK3QeD15R3a6D5hHHdodTGFtEWB2td+2M+pxWIRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107103; c=relaxed/simple;
	bh=z8WOqWBbOW+9pL7z8yuzVosl9bnujJ2AFbd/EoNuDrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDz0dtkO1wJbeWmACW5+VzGtR1aXRLzdrlAAQWR0YQFfcafOOaCnvZcK7msjXT1MOH6Cj9FHXUMd/3hy2JE/9+UxIXCZDCgIIBf2F4zoqpTCRmD4ksgkF5+LU9Eg4gjXiu7Ua/mKgLwd05IVoI1yxziaqLGnpM+9lnojVuF/mes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVbrfnQV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so42903795e9.1;
        Mon, 28 Oct 2024 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730107100; x=1730711900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8Ty/XQFTu5lZjWELFF7YIr+Xfpqpi30NyyBdHaA998=;
        b=CVbrfnQVi7RF3EXGW6qqQLWJtHGzxdg/PP5c5pGuvwEyYS1kJuJHtSjrJgmRQtN8Lw
         ksBoGHBD09iL3ce8DOqfg4ZFIvP6FiuTr/u18uTwVVFlh3I3PhRX0aBh3mMh6v8GduPk
         +3E/cd4v+DWInRZpWRurOtRr7+dQc7Blf/4I+xuulSeXaRcCo9mvmfN7GnNL+k7nGERF
         z6pGuWguWpdVzGnPXM3QnB1Of+zdeIifTcg2YbS7DStFfGSUMa43YVKMxeysZbYMJKQI
         3Km8v4GSz/DZzOVwkg4y0tRd9C1Tezutwhu1v9SJtSx1MfeG/9C77S+3nWiIvM4lFERB
         nMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107100; x=1730711900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8Ty/XQFTu5lZjWELFF7YIr+Xfpqpi30NyyBdHaA998=;
        b=DIZ8Il7LKQx23MXejmRIOvOO9CcLTQYezTbIXO5pTqMRYp8orsiRownzihQyE7kUFO
         5cd4UnsAfALK1cVsB1uf0G4cHmgvoy/ZthF+eEUHkiWrc1Dc8hpVfOjg9O9Lc1HqTHtw
         b17Se3Mp6dwKMKJGVa2fh7pzcwlaIEkZ7OyukqhWU/v8pmqaVhsGI2RLCb0axC2hNFAH
         QTSuDwjz2siegOYpWyj4GbBvTiqdsjDT5fwu4aWiI9fWMf0fU8TnSlucNge4SZRs/uzB
         f0pUZEaikt3l/Ygk4vI96TgvJ3F/kWCiFpat6Fvn0o3DAlF+5FOLESycC6k5y7qqDsVE
         gL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6m4pyRqARLdxk7JdI/lk3eBh13LUGijT1RjbSlIO0eqqC4Fuit8syWx2lFEosOij8xdqNzgx6DDxjF4E=@vger.kernel.org, AJvYcCXar3lwTyBFkd+u5gMvg+r3dwjpvzxgU0nlzKhh1Grqj3Wi1T/i8Tawo3YOa7eEAYZ9HWMX/HjtHbPS1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVXjITna8CuAtXo4XnQxNCxSsogyYUUk976KuUDCszC5o+0PcH
	9t9qCnypUFgPOFjJpMv4UWYYRWNsUOkwM9la1gz/HHSfib9tSFaF6+LgHw==
X-Google-Smtp-Source: AGHT+IFiFqxdFrpnUM0V06ADCi1t9UOIUzE5xORmCwdjVhj+PzW+WhkdBlbU810MpLF7a5NoPD1ieA==
X-Received: by 2002:a05:600c:4a88:b0:431:9397:9ac9 with SMTP id 5b1f17b1804b1-431aa292eb4mr18105935e9.15.1730107099414;
        Mon, 28 Oct 2024 02:18:19 -0700 (PDT)
Received: from [172.27.57.39] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f74f9sm104566645e9.31.2024.10.28.02.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 02:18:19 -0700 (PDT)
Message-ID: <ccea3237-b592-4248-b63a-796f4889204d@gmail.com>
Date: Mon, 28 Oct 2024 11:18:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx4: Fix build errors with gcc 10.3.1
To: Li Huafei <lihuafei1@huawei.com>, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gustavoars@kernel.org
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241026100221.2242565-1-lihuafei1@huawei.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241026100221.2242565-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/10/2024 13:02, Li Huafei wrote:
> When compiling the kernel in my environment (with gcc version gcc
> 10.3.1), I encountered the following compilation check error:
> 
>   In function ‘check_copy_size’,
>       inlined from ‘copy_to_user’ at ./include/linux/uaccess.h:210:7,
>       inlined from ‘mlx4_init_user_cqes’ at drivers/net/ethernet/mellanox/mlx4/cq.c:317:9:
>   ./include/linux/thread_info.h:244:4: error: call to ‘__bad_copy_from’ declared with attribute error: copy source size is too small
>     244 |    __bad_copy_from();
> 
> mlx4_init_user_cqes() checks the size of the buf before copying data,
> ensuring that there will be no out-of-bounds copying, so this should be
> a false positive. I searched the git commit history and found that the
> commit 75da0eba0a47 ("rapidio: avoid bogus __alloc_size warning") fixed
> a similar issue, where the compiler encountered an error when expanding
> the arguments of check_copy_size().  Saving the result of array_size()
> to a temporary variable and using this variable as the argument of
> copy_to_user() can avoid this gcc warning.
> 
> Additionally, I tested older (9.4.0) and newer (10.3.5) versions and did
> not encounter the same problem, so this should be a bug in a specific
> intermediate version.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/cq.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cq.c b/drivers/net/ethernet/mellanox/mlx4/cq.c
> index e130e7259275..5169c7a4097b 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cq.c
> @@ -293,6 +293,7 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>   	void *init_ents;
>   	int err = 0;
>   	int i;
> +	size_t size = array_size(entries, cqe_size);
>   
>   	init_ents = kmalloc(PAGE_SIZE, GFP_KERNEL);
>   	if (!init_ents)
> @@ -314,9 +315,7 @@ static int mlx4_init_user_cqes(void *buf, int entries, int cqe_size)
>   			buf += PAGE_SIZE;
>   		}
>   	} else {
> -		err = copy_to_user((void __user *)buf, init_ents,
> -				   array_size(entries, cqe_size)) ?
> -			-EFAULT : 0;
> +		err = copy_to_user((void __user *)buf, init_ents, size) ? -EFAULT : 0;
>   	}
>   
>   out:


As you mention, the bug is in the compiler, in a very specific 
intermediate version.
Why would you modify the driver then?


