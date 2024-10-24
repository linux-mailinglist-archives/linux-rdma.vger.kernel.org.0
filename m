Return-Path: <linux-rdma+bounces-5508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A29AEC83
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 18:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731C01F2474B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 16:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC41F709C;
	Thu, 24 Oct 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Cal0Ap"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184E1F4724;
	Thu, 24 Oct 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788487; cv=none; b=L2fWDzn4p2ZuGOb6PmfaoWJ0AEuic2c8QkqWnLMNFd5CiFuf2MtmcA8xw0c0O0HT7Ddb13LbX2I91qbImJMGfH2IV48FSmUZ7K8aZv3E+j12fGBK+7ZpW2zgWbhcd8svX9YuaF8ZLrzQkdcsPhIjIDEbuWT51FPNkpM+dax0Hb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788487; c=relaxed/simple;
	bh=Xd3zCQJSFluPLr68+g0FTOhdgAUJKcVEhtol9bIe3uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f27gWP0Et7AgKikZLrvY7LxDGvxjZ3XUUasaql/m9n3+Uhcm7j09TSxdBeeoz3cuKODEiQphNfuomKu29fT4uHdMBc9nyiicSzSDHhBgT1NaV5TF4DAlvlu0uMo3x3k13Ao00CyeZVaIR2K7eqCkujRW0lUn8DVK0oD+2iqHgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Cal0Ap; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d3ecad390so1671890f8f.1;
        Thu, 24 Oct 2024 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788483; x=1730393283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/QXTPupZszyGbqY5pviify12KAi6ghznoufyE83p4g=;
        b=T3Cal0ApOWP0WVDJWjOfA4loW0BPedT2DilTFqkVH0/XkQWRb/0XEwosiIe5DMf2ZK
         ifvGGaWPJlEJuJKQvl7J9VHAwvjs7du4OxFnwCluRvPiyNHavIIJsrrlLsuCte6swCrL
         nZy+mB/WViSgqZklLNh2d+FMGKP/Jl9hcP/zzDCN2ej+0SEuASAIPxoccXg1XIbPcWu6
         rb/fvm0I66Ho5iD7mYmms3A+OFBVSBEGwr1q6X5qrUZiXlibGHI0YStkqDdAvRaRApps
         D0BBVMa7Zwria8cnX0mmqIkLW8tx2n/La+dOA7PxZhrNbZIa2GPJSYDRYR9EwvmUbLwv
         2PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788483; x=1730393283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/QXTPupZszyGbqY5pviify12KAi6ghznoufyE83p4g=;
        b=NxnR2f20tm8c1+KoTL8x6+yMc8+SY5I38vQzZGYK1EeNGmG1CeZrT+enuG/J4Ihika
         OS3wPj5tqO64sSS9jWblV4Lo3LqgCzZYtDhe10Xh3PnKoRJwP1pRS9JZP7shWa6gxOmv
         782eQNAR0DGdPkNYCpvr2h9LMvpKgiHM+xl6+GXvbR83N83EYqd7y5xKVhJQYXRQ05kr
         6MYfZh9Cz5JjqizwztYmnfl9C1tO34viG/3SWkyzVmTO+QWBK3n3KjSu7wQC0SitzWnO
         jqSOvWTbZ6sPEJF58nKpbDQhYexkl7n8pqFA7Ckn3xF8zzmcWl/zQ5rLHMAS6NTMiB1B
         EQCw==
X-Forwarded-Encrypted: i=1; AJvYcCUpsyb88MhnrH2wA81pkyp2436rpd5QCwGHpPhHPKT6MTLGD6cMHr3l7u+7mNt/flIhzFpW+sf8@vger.kernel.org, AJvYcCV/TfMy5kmllHKbvkUtaZmYH3drFcZZfaZmq2RxE4a3fjum1s0xhtdyrRt4nqNHpqIxgMQbbdeRAR6TTzI=@vger.kernel.org, AJvYcCVmjRyfOSlAVf/3b/HUSmQmMrEY6mwS/mrOCjAo+EtJZXyQ/qYgxu/zbBuLqZNCnKsY/d94KThql2TWKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDYWB7fDiv+3kV8DWZv03ngu8nUw26TDQtk6j6ZWlTCg8eUMC
	HLetGIZkHJiURjVpREFbWRa+LEyDOXim8Mel47/WlZ+pzftBzWY/HuP6lQ==
X-Google-Smtp-Source: AGHT+IECqRZ6Q/nyl6/XwIc1sJkxWZUlLZwLcHVdEwkx/anPOckDX+XnYpJxIl0h+hzyf4SZFMPUfg==
X-Received: by 2002:a5d:4248:0:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-3803abc523bmr2013545f8f.1.1729788482907;
        Thu, 24 Oct 2024 09:48:02 -0700 (PDT)
Received: from [172.27.21.144] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f39fsm23045525e9.12.2024.10.24.09.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:48:02 -0700 (PDT)
Message-ID: <4e3fbf05-3a88-43be-826c-a16a6718217f@gmail.com>
Date: Thu, 24 Oct 2024 19:47:54 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] net/mlx5: unique names for per device caches
To: Sebastian Ott <sebott@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Parav Pandit <parav@nvidia.com>,
 Breno Leitao <leitao@debian.org>
References: <20240920181129.37156-1-sebott@redhat.com>
 <20241023134146.28448-1-sebott@redhat.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241023134146.28448-1-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2024 16:41, Sebastian Ott wrote:
> Add the device name to the per device kmem_cache names to
> ensure their uniqueness. This fixes warnings like this:
> "kmem_cache of name 'mlx5_fs_fgs' already exists".
> 
> Reviwed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index 8505d5e241e1..c2db0a1c132b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -3689,6 +3689,7 @@ void mlx5_fs_core_free(struct mlx5_core_dev *dev)
>   int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_flow_steering *steering;
> +	char name[80];
>   	int err = 0;
>   
>   	err = mlx5_init_fc_stats(dev);
> @@ -3713,10 +3714,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
>   	else
>   		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
>   
> -	steering->fgs_cache = kmem_cache_create("mlx5_fs_fgs",
> +	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", dev_name(dev->device));
> +	steering->fgs_cache = kmem_cache_create(name,
>   						sizeof(struct mlx5_flow_group), 0,
>   						0, NULL);
> -	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
> +	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", dev_name(dev->device));
> +	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
>   						 0, NULL);
>   	if (!steering->ftes_cache || !steering->fgs_cache) {
>   		err = -ENOMEM;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

