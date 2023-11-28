Return-Path: <linux-rdma+bounces-111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9027FB5C5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1041C210BA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B97E46555;
	Tue, 28 Nov 2023 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Hvk3oC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C331CC;
	Tue, 28 Nov 2023 01:28:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a002562bd8bso988439566b.0;
        Tue, 28 Nov 2023 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701163716; x=1701768516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/I37Hy+CPxtqaGJSStMJzaZK7V1cChne6wXUX2MFad4=;
        b=A9Hvk3oCbZRaVXIKKfGepnGcLcNvJfFCshHrc13RyRUH4xZzCclsJbK5TuMAS61+YH
         fBww3etSsCPpi0ioVhKBE3z9ExuQZNx/F63KsnrN1G6+mfocW4bbccUZv9X9sJJRcMBS
         XTUkJdjGB7OhMNzI6eP6odf5EDpBVWjvduh+gdVAUH85Vdc9pwDa156EwdZpA3EVudiW
         qMrvUfJZ2oCcmwjMHJcVO66SgV5okuC81SDxxb0cMBFW4EZ6v/naLrHC5RJ4MTJAdLWc
         f2so1dD6X/WGRMP7b0gSnqLGbz9Xlf41FuSL5i8fPfKu1vhZm3tDiymEKlz+WlTj818p
         tb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163716; x=1701768516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/I37Hy+CPxtqaGJSStMJzaZK7V1cChne6wXUX2MFad4=;
        b=NH46r8Ybst3dl5fpuIRPSfouA6n0meHoQyhRG3VLdLZg5N0W4ufMrSD9ZIu2tdl/rG
         kLtzL7eyWFVlgda7dlft+jdcqkADPYdFbqMZQq9PJwC1PkCDpWIcfoYXL/Qjt3Kf5gWP
         L8huybxVrcyplHIzHH5WjhM+gpmpip+uOId/5ahDo4psj+TI7MMgneu9wRfj4+dAIkwR
         XeGVTOnrMaYqFvIRWD2g6a6FAeZVAWEoV4nCMF1HxZGx3QWTiGRN9sbL9b2wzhd9U6AS
         hex97ThU9Cf5ypuCUVf7KAk3j4b/6sI9YjMCS6cfyuy7GIc7rI5k6bHyOokgP+JKDt5o
         domQ==
X-Gm-Message-State: AOJu0Yx3qcu/gMnAtsNLMzZHM7kQ6/Hin0XpIQS+v63ONQC99KAwJhE7
	VGy98vtp1xBbIWnNOppSHGPdkYzM6yU=
X-Google-Smtp-Source: AGHT+IFEH4EFXz1SkAIQ0bi87cfTz2YfZJMxHuimsbsOY121G4/9iPjVSo4FUzJwYEYUkxZgVW3udg==
X-Received: by 2002:a17:906:c791:b0:9ad:8a96:ad55 with SMTP id cw17-20020a170906c79100b009ad8a96ad55mr16418289ejb.14.1701163715664;
        Tue, 28 Nov 2023 01:28:35 -0800 (PST)
Received: from [172.27.56.182] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906319400b00a097c5162b0sm5140142ejy.87.2023.11.28.01.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:28:35 -0800 (PST)
Message-ID: <4092804e-6266-47ae-a0f2-9658231fde40@gmail.com>
Date: Tue, 28 Nov 2023 11:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: fix a potential double-free in
 fs_udp_create_groups
Content-Language: en-US
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Zhengchao Shao <shaozhengchao@huawei.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Aya Levin <ayal@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20231128084303.27227-1-dinghao.liu@zju.edu.cn>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231128084303.27227-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/11/2023 10:43, Dinghao Liu wrote:
> When kcalloc() for ft->g succeeds but kvzalloc() for in fails,
> fs_udp_create_groups() will free ft->g. However, its caller
> fs_udp_create_table() will free ft->g again through calling
> mlx5e_destroy_flow_table(), which will lead to a double-free.
> Fix this by removing the kfree(ft->g) in fs_udp_create_groups().
> 
> Fixes: 1c80bd684388 ("net/mlx5e: Introduce Flow Steering UDP API")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index be83ad9db82a..806a5093ff63 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -153,7 +153,6 @@ static int fs_udp_create_groups(struct mlx5e_flow_table *ft, enum fs_udp_type ty
>   	ft->g = kcalloc(MLX5E_FS_UDP_NUM_GROUPS, sizeof(*ft->g), GFP_KERNEL);
>   	in = kvzalloc(inlen, GFP_KERNEL);
>   	if  (!in || !ft->g) {
> -		kfree(ft->g);
>   		kvfree(in);
>   		return -ENOMEM;
>   	}

Same comment applies here. See the other mail thread.

