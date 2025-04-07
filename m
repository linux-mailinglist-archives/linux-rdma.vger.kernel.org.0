Return-Path: <linux-rdma+bounces-9175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3989FA7D9B0
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4963F3A80DC
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282222A4DA;
	Mon,  7 Apr 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIpFGLWj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE010224B1F;
	Mon,  7 Apr 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018111; cv=none; b=P4nnDFK59GHtLjVHfbzHY3JMQqv6SpyGpWDON3WDSBZjpv2wuUdDgsRu1S3cMCdmgC9bnt7+vbJfLHC4h2reX7g+0OKeB6GNbzq+zVKXLUnKwaOvB5+IOvvTgTFwD9NdU8P1nJEcnbpGnqOuPEZ4JTIPYRUxVWMrCQ+aCvUmlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018111; c=relaxed/simple;
	bh=5GLkWUU4HDbXf9mz/0G1nBuzNh9oGrdKydSzBbJ14ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVqX8lIojcOUYTE8rHfNvgntInYZnReI6Z6UGY/ggFftP+d2sVOcVQcnCc4S6FXBIYRnSE7wNlVPG/TW0rL237gSJgn8GWanyPegtyxKb/3p4G1MZ5PTGOnNAyGkebFZe2o4ht2cpxALKPJfcyYoqQRvOnXDTMl7p+AH1/yW+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIpFGLWj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso28734165e9.2;
        Mon, 07 Apr 2025 02:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744018108; x=1744622908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkRslAAvG9P4+0xS+/oRiocy/WE/r/KfeNp0E0RBHAk=;
        b=HIpFGLWjsPYzDsXwVLDKnWkSQ9mk1E00/KjxX60PElA1GoLc5gHqsA4QNBZ6jN0Geg
         F8iAR7hjQoMebdtaeT/M99GERQ1WwtmyLUkIdpwuqdW/r9LQHa1AMTcD/0K9FzRcoghX
         GiBHJgFa0eWL9HKujgxNvCJOdSb5lR33AEmMOb+C3pxQ0Smuy+byrqK8noIZFHNzJs4q
         cl4E7v8Bjaya9mEQ99zRaEr1sCK7licaDe8NnU2/00rRr1vJNYosc9pOrQJ9P7twIQpZ
         yb6kELKcB/NBOpkz2Q1l8bpFbSaaMjxpyUSF5PgMUkvYwBf1A1DYqhX494pA7J8o3v91
         WigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018108; x=1744622908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkRslAAvG9P4+0xS+/oRiocy/WE/r/KfeNp0E0RBHAk=;
        b=swZvCaGTW+P5KeuUPZ7ucnnxQum2j819Fjx2Wyn5N+PS6HK8SEowdwij6rHA7fpZ5q
         eVP0Uim2zoG1VcXaGFqpLTFcYKDigediNCFOnTBTuJf9UWUN8ldqx3n01etiDAsVsKBw
         +Y8sYJdgqLijBfYYqmrKSgenWL0FdvBkXXOyEJ5V9U6P2USbCFlng/78daOq5c0KwJRm
         55TYmkCf+OBeD1DGjYj9qdj9eynJONUPic/mIMzzln5Dx/xCTP9+cuRtSSiJY2BCmv6K
         8/7lSRXcdCXtJkaZI35sYegKgwOVWUjVbjUksDimDnG6praZNYl+9abChRjusb/9a5ss
         RKFw==
X-Forwarded-Encrypted: i=1; AJvYcCU6AZmFJwCH9tAGj8t15xRxNLEdtBP7el7oBswOh1XNKHQmlSTbLgkUU2qBs1VdyD+OpJip1FBPlRppAno=@vger.kernel.org, AJvYcCUcREjEwp6ceplXkEppBSKu1gKlgwtGha8lqVqJBbhV1KbTFahPpnvsvC0dBSjqaIo3Gw/fJO4GH1Hoyw==@vger.kernel.org, AJvYcCX4bia6hFTNTSsCWPf67MInmbX2yN5ySNlJzekFwopymmYCTfjUhKa1d0TXiVfihgzTeGZ+bpLK@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQvxFqVc1acchOgLrlgfPrJ9eyRfxpf2aP6p2n8TbIlsCv+jF
	ot4eSajJYOM1orwYWl8aZ0O89PXMTHOkBWmvyF3/wVog77GXF8HV
X-Gm-Gg: ASbGncvtiZsyAreLII7dKKCdHnqiyTog1aMn8SqdfNkj/xh58H/3sscjf7mEA0CG0vZ
	Gpwkaeru/y7lWzRLPaq95C5OjAaBnsBbNd16pgZPmlxS576pDxG4eBF7AA6iWFtWRgSogcXwdT0
	8dUzXZLQnyU/isyafYlxzwaIsl7bgbr+5h58IXAXBkbNJKkTxqX7cvoRu9GRTcxskVkwk2NWPfL
	zqSeTL8X4QZ3Z6SXRjiMC8VPd5GBLLhsHcj3/ibxfKVvbOTpuwXZA36qiy/yqjczOIkdjzk95gN
	1xi2DRBdv6/mjOfM3fPezelefcrHx4bKQS6ftM/OG0ITAiKuAd2nrsbVVgx1jbXh
X-Google-Smtp-Source: AGHT+IGp5fi6++8zXAQAnNdvPkYkktsVXcWZSC0lAKQPT2CJ7VZSVR9OC8AwHYLSZ1Ly3G10Opjmtw==
X-Received: by 2002:a05:600c:5494:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-43ecfa070f1mr86031345e9.32.1744018107650;
        Mon, 07 Apr 2025 02:28:27 -0700 (PDT)
Received: from [172.27.62.62] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226f2bsm11625235f8f.96.2025.04.07.02.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 02:28:27 -0700 (PDT)
Message-ID: <73ec97a8-2ef8-468f-86fc-4de9e5e74b5e@gmail.com>
Date: Mon, 7 Apr 2025 12:28:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net/mlx5: fix potential null dereference when enable
 shared FDB
To: Charles Han <hanchunchao@inspur.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, markzhang@nvidia.com, mbloch@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com
References: <d78fa6dc-5820-46b6-9b7d-0986f9a70da2@gmail.com>
 <20250407064757.4266-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250407064757.4266-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/04/2025 9:47, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
> 
> Fixes: db202995f503 ("net/mlx5: E-Switch, add logic to enable shared FDB")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 10 ++++++++++
>   drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c       |  5 +++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index a6a8eea5980c..5405134e74b6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -2667,6 +2667,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	if (master) {
>   		ns = mlx5_get_flow_namespace(master,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			esw_warn(master, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root = find_root(&ns->node);
>   		mutex_lock(&root->chain_lock);
>   		MLX5_SET(set_flow_table_root_in, in,
> @@ -2679,6 +2684,11 @@ static int esw_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	} else {
>   		ns = mlx5_get_flow_namespace(slave,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			esw_warn(slave, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root = find_root(&ns->node);
>   		mutex_lock(&root->chain_lock);
>   		MLX5_SET(set_flow_table_root_in, in, table_id,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> index a47c29571f64..18e59f6a0f2d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
> @@ -186,6 +186,11 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
>   	} else {
>   		ns = mlx5_get_flow_namespace(slave,
>   					     MLX5_FLOW_NAMESPACE_FDB);
> +		if (!ns) {
> +			mlx5_core_warn(slave, "Failed to get flow namespace\n");
> +			return -EOPNOTSUPP;
> +		}
> +
>   		root = find_root(&ns->node);
>   		MLX5_SET(set_flow_table_root_in, in, table_id,
>   			 root->root_ft->id);

Thanks for your patch.

I wonder, did you fail on any of these, or just caught them while 
reading the code?

