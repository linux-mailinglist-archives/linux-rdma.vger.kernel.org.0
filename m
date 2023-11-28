Return-Path: <linux-rdma+bounces-109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F237FB502
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 09:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D0CB216EC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B62E3F2;
	Tue, 28 Nov 2023 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMZ0Vrsl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C73F4;
	Tue, 28 Nov 2023 00:58:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54a945861c6so7133404a12.3;
        Tue, 28 Nov 2023 00:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161893; x=1701766693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eThDWl/p719tUnMNV7tBdoRpTLwA6GR+r/kwIo8Uvw=;
        b=QMZ0VrslsocHnaDUxbJ9hJ1Mi8HVpLisOjj7iB+jmbmTLVo9/9BOTF/ZSm4MzXmDPv
         t/6bqlWbqVULF5K1CB3KX8xUlFju9Holt0MDX05h8JoyKvZ98jtS7CS9GmzWo1o8El5z
         8MmZRmAyLaxX6TPb2crEVMXVCKiKav6xD/9VK5b/NvlLVMyRVbr4+ooc2+NkG+1plGvr
         6w6Hy2GPzieTzIX2yyXq9cU6TR2/N3GqUfKBNc731s+iKrDEqpYh9o5T9fvdFe65zijt
         BHpWV5uuJpNkKSBIYdzkKilP+Oi4G3yx2SOsKDKX4RGPsbzmpto1gl+LSsZxIfgqfHec
         FcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161893; x=1701766693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eThDWl/p719tUnMNV7tBdoRpTLwA6GR+r/kwIo8Uvw=;
        b=veuMsuEFbbdIjaB+Pq7BcSJxLXAGLqKIEIMTr8qgFZzLkdr1t2Tu0xQB1wDy1wb2Na
         k9gGu9k1VV/4pBb9rKvz3J3vdzQftMHxe+sLhnXukjr78JWBYHjWGyBwyeSDSKN6sKDO
         LA1OTP0bVcHgW6jcegAJ+HY9PRUGIf4kPoa92XWiCV/GpHDjbFOnUJJ+CCgPc2ageVuU
         mwkVM/tuMsEIHeF4UuRp2bAgBr80WOMa+jX18HKz75YXFLeVjVpteYCZknRXFqgdus61
         uZO2Yg1QME4plStx8aByiJYnpljixJ1oIltMxXnb0+K4XuKdcxMJYO5QZnSjhkT8PQ3I
         9C1w==
X-Gm-Message-State: AOJu0Yz5ARoskIiZn3+GWKOHd49Epzvjp2Dh653yx9mYcDfQPNaJodHR
	RxL9J5I8cu2VqFT1Q+xvF+U=
X-Google-Smtp-Source: AGHT+IFR5RnA5vAR+1Mvjlycnu2h0GtN0a4lFsYU5ANWlySGynJdKlWATFHR8EF2K/rPwT6dWGJYig==
X-Received: by 2002:a05:6402:290b:b0:54b:9817:bf91 with SMTP id ee11-20020a056402290b00b0054b9817bf91mr1811570edb.7.1701161892405;
        Tue, 28 Nov 2023 00:58:12 -0800 (PST)
Received: from [172.27.56.182] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm6058243edu.63.2023.11.28.00.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:58:12 -0800 (PST)
Message-ID: <3d3b6a1f-40b6-45b5-a899-d01acb91213d@gmail.com>
Date: Tue, 28 Nov 2023 10:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: fix a potential double-free in
 fs_any_create_groups
Content-Language: en-US
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Zhengchao Shao <shaozhengchao@huawei.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Aya Levin <ayal@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231128082812.24483-1-dinghao.liu@zju.edu.cn>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231128082812.24483-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/11/2023 10:28, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_any_create_groups() will free ft->g. However, its caller
> fs_any_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by removing the kfree(ft->g) in fs_any_create_groups().
> 
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index be83ad9db82a..b222d23bfb9a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -434,7 +434,6 @@ static int fs_any_create_groups(struct mlx5e_flow_table *ft)
>   	ft->g = kcalloc(MLX5E_FS_UDP_NUM_GROUPS, sizeof(*ft->g), GFP_KERNEL);
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if  (!in || !ft->g) {
> -		kfree(ft->g);
>   		kvfree(in);
>   		return -ENOMEM;
>   	}

Function fs_any_create_groups should not return failure without cleaning 
itself up. This is not the right fix.
Freeing ft->g and setting it to NULL will do it, and will avoid the 
double free.

