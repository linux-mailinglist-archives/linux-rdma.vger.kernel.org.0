Return-Path: <linux-rdma+bounces-114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D07FB664
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88A01C210DF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C34B5DC;
	Tue, 28 Nov 2023 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk536cTw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899BA8;
	Tue, 28 Nov 2023 01:55:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b4a8db331so5910335e9.3;
        Tue, 28 Nov 2023 01:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701165311; x=1701770111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNtK1TPISezcj213wu4/hg3WdfzJ6KpGq/90DAKkCkQ=;
        b=lk536cTwukYfEqlMjAgQH6keBmEZ0B2hnV6sFD7UGXt6qkswf/WOPlOqj+ZHtCPrNj
         uJumn1+Aq3oL36orwKZkFs4z4nYKFYnhfuG8HhXEsDs3gMcPrFhEghUHU+X6Lvlfb7ji
         h450oOQjxqAqGQBoQed2yEE0jd2Ict+RGdjsX8tMg5npgJt5i/g7ysTmp/uqu3bT3bAJ
         UNsXI2ksBCH0Rb6ajhB4PXymr4RMlJV5/2O+GHa4HcBMPrlGgLOpnDQRd6T7FuVlim06
         3eiZ5ycdeYKa85PTSFwK5lURIfpMHPQ5VMBkblkPH/CBSw7iLXdgo2vTQKpOLCQjgJcA
         6/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165311; x=1701770111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNtK1TPISezcj213wu4/hg3WdfzJ6KpGq/90DAKkCkQ=;
        b=NBLqhE9u0x37B15GtEgnUr/YkXyFsEolyR/CrtXFJBtG2oMv9m3/pF9zkrqNT/Qmrf
         Zmu2tQZu9bAV+s0B3PrRZsaFx3LOQG3Oh8HiRFYT95CtUxP6SBHV7S5B/3o1JPtfVnJ+
         pgnUAbrDi17R9nTuUrZDsZMb+jWjsndci+3E9XImxxsGvv+abkS8zFvc2AXagV4eKX1K
         78gq9VVViryZJbjrlBEmlHnB2NVZ8HTC08481V4ZZRHdqWMWpG5dtFSGDW2QArCyeHMM
         NyCeKrlaHOX85pNX4c3G79mrLp+OmQACttdLO6yU55sa+hQmvAm8latuxJEfgSax/hvQ
         3rLQ==
X-Gm-Message-State: AOJu0YznIF0hP5l19BqK+8IC+bzGX1azv7LqFwkZWHLAL084w210nWCy
	ANpOyo63fUYOPsc8JkMkPMk=
X-Google-Smtp-Source: AGHT+IEESw4Dcx8wGaG7me+4i6Y2E1BWo5BBLayfLNo/Pid/KFDP8lnXULskXK5rzZYBU8BsjCBJeg==
X-Received: by 2002:a05:600c:474d:b0:40b:3802:6ef8 with SMTP id w13-20020a05600c474d00b0040b38026ef8mr10185277wmo.34.1701165310650;
        Tue, 28 Nov 2023 01:55:10 -0800 (PST)
Received: from [172.27.56.182] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p3-20020a1c7403000000b003feea62440bsm16482424wmc.43.2023.11.28.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:55:10 -0800 (PST)
Message-ID: <89b8f461-84f9-4f43-bf16-308a72daa9f1@gmail.com>
Date: Tue, 28 Nov 2023 11:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Content-Language: en-US
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Zhengchao Shao <shaozhengchao@huawei.com>, Simon Horman <horms@kernel.org>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Aya Levin <ayal@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231128094055.5561-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/11/2023 11:40, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_udp_create_groups() will free ft->g. However, its caller
> fs_udp_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by setting ft->g to NULL in fs_udp_create_groups().
> 
> Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: Setting ft->g to NULL instead of removing the kfree().
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index be83ad9db82a..e1283531e0b8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -154,6 +154,7 @@ static int fs_udp_create_groups(struct mlx5e_flow_table *ft, enum fs_udp_type ty
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if  (!in || !ft->g) {
>   		kfree(ft->g);
> +		ft->g = NULL;
>   		kvfree(in);
>   		return -ENOMEM;
>   	}


Thanks for your patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

