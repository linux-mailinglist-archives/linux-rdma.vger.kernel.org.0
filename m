Return-Path: <linux-rdma+bounces-9143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCFEA7A95C
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 20:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5797A65D0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC8252901;
	Thu,  3 Apr 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZwuFLae"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2435C8E0;
	Thu,  3 Apr 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704945; cv=none; b=OkYjhuAzm+hPC1fbKgYilk8TpNbQISpO7laqJt3+KlOGomJyjqSQf99k9Xuifu77CySmX18T1+NLOMr8U3PpC/qwHI9V7lHG39zmo+CfcIhk0Fdu8b1A5RW+TXv2Mq6FdyGYrav5+Qd3QrWdpvh5MxE6pJQwcYlcuRpIV4G1rA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704945; c=relaxed/simple;
	bh=BJ6MF4X3xZZJF9aGkDdtTPJx0QtX8gqmfIDuSD47caI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aS45SHz7fUwTFeeZkB2HaHVNan3NwMqbfO9euXKoxv9EUpF9MTjzFMdaHqYdHEHghu5f7mcNXayo+69yXAT/p3Q52yEzk/SW8Xa+y4EFcmFyevmpFFzMUa7Z+vdKPiQVAaDw1RDYfHA9X3PlTKlgabTJr4VjY9ybYAmE+YOtihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZwuFLae; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so8564445e9.1;
        Thu, 03 Apr 2025 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704942; x=1744309742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0xXXnmcQUMSAV1rDZydtKV9m1RhcaPoKdR17ygBDjk=;
        b=mZwuFLaeOj4GM/hourMDy7pI6zSktu+gkXmQoiNqfIfx5LWsUZeQvcf3hXGrXrj9J+
         oH7jktlNOnZ6SVzNX+8kQE+5ndql7PiY9ymIpyKX3qB0l7wzOKSDywTjS70gwvCBAczi
         2Kt0PhY+zwTNXEyaScRvSwkcJdCfI61jHEkVIZaVG/TFFI2Wp9/vyJ4mUiSezqS9rwJm
         pmCDGKMeEi30yzJ5Iox4FITjB4rG1Nz0/91VdPbl/dB5o/rEv6UECmhGDWnQFBp+ZzUe
         JR1p0/KRff3xAVNJWWktDDYumldQxWW4lnyylr7sRVEagFXijmfweBB8VcgHB+37/Ptd
         Fm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704942; x=1744309742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0xXXnmcQUMSAV1rDZydtKV9m1RhcaPoKdR17ygBDjk=;
        b=VtWixn7J6nNvCHs7IaZwPywR5fWrkIMUtlPHeDo8kvS0ENJ6F0cmvMpXF6RTEkf+8E
         FB7S2SF98IaP+yA2WDBW7yIyFHnML16E1GzLfMvghvmMYMP5gQj4pLy6JJpe5zbqG2Nl
         +KoA/8xZtvYDJUSgHyArH+TptkZOKKub/i0V06rZ/J4KMo/PHHE7+4N26s+FgfbVRD4p
         i9o9PanI3HuEerHt3UEux7TiqhawFuBEO4/LUKLGWzFFm2pskoED78XqoRI/yY2pXLNZ
         zU/EughUHpHnkxmMCF4nY+FAYg5UDJluj44g+P1m6Qg2bZUX53CRoMVKr/3NawESHsUx
         MaJA==
X-Forwarded-Encrypted: i=1; AJvYcCUQad/ERMSetDgZqJXlLbNVtNWzPSv9x1V3VrpOiCUVRyw3TbCrzBPlC1nEKS+7KLSpKLETQREt+/PH3A==@vger.kernel.org, AJvYcCXuUEZ8Bdoqiudv2f9zT4ibhJdib7ZH57pm3iH+j5JfJF7WB7Q1d4tl10eLR/yBW2iwjzrfhRZ+SfwRRWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+K4zerJAb0/lhlzd3gqzpIYDW+3yHmvzHaz0DoiMJFveaU34
	jg6AuTO6kOgb3gVhXyOJsVCEqSO4JwZbS5ybyEWaY9j+IX/qnjSb
X-Gm-Gg: ASbGnct/36rqeHY8P6PVVXCnvQR1B87XR1avffVlVz/ommIYnvxC9Ju/1mNl5/5mw6e
	G+Pel9aJ+pCWHD1dJjfsJsj/sPgwjlWTJN5I995X12hVNdH6THoOrJQP0JC8bVBWtBQ9ab/SQgJ
	Mc5F1c7b9ofaNBlxT89Sy0YO+9ERAo9HSC70tSKiAbSQwF+GtJ9BB3j3MW9xk0R7/gLuRFm788D
	KEwX00xdRyZDwQ8EoIAiXSKbcXnrUlXQL+OJCWF4gEfC+ygtytQAEb65UfRiezczdVSMqDsrnAE
	4tWGDDPdvj8zHUNxofgkuDMeuQ42fUwu/vzukJ6XGys0TxfUMMPQZ5JcsqOgW0r5Qg==
X-Google-Smtp-Source: AGHT+IH7ukEB039raJgrsIcDoJubZVtxahaG0Ai1QHumd2mPTT/OvQNVxuZUvzclFKZ2rMvZDmDwnw==
X-Received: by 2002:a05:600c:46ca:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-43ecfa45a81mr1044925e9.18.1743704941876;
        Thu, 03 Apr 2025 11:29:01 -0700 (PDT)
Received: from [172.27.62.155] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d943sm2459508f8f.74.2025.04.03.11.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 11:29:01 -0700 (PDT)
Message-ID: <0e08292e-9280-4ef6-baf7-e9f642d33177@gmail.com>
Date: Thu, 3 Apr 2025 21:28:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5e: fix potential null dereference in
 mlx5e_tc_nic_create_miss_table
To: Charles Han <hanchunchao@inspur.com>, saeedm@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maord@nvidia.com, lariel@nvidia.com,
 paulb@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20250402093221.3253-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250402093221.3253-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/04/2025 12:32, Charles Han wrote:
> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for ns.
> 
> Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 9ba99609999f..9c524d8c0e5a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>   	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>   	ft_attr.prio = 0;
>   	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> +	if (!ns) {
> +		mlx5_core_warn(priv->mdev, "Failed to get flow namespace\n");

In this function netdev_err API is being used for error prints.

> +		return -EOPNOTSUPP;
> +	}
>   
>   	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>   	if (IS_ERR(*ft)) {


