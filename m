Return-Path: <linux-rdma+bounces-8508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91DFA583D9
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700DC1895619
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FF1C4A13;
	Sun,  9 Mar 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kukRWH4K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468FD137E;
	Sun,  9 Mar 2025 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741520786; cv=none; b=h6DpZSVWsrcYhm+qR1Kgwi4LjR7PRCD3dX9j9V8KzBwUWEdWmaQBLhqu6xBb+y6BT9kQn/LfHFQ/19ir50p7rutgtcTJMJfOsDnqJT5VHYvH1hcfC7Zz8lCwW3TWkCAZK+jekUoM8trbQZFFlMmYMnHIJqGz9NXnM1GjckLZ2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741520786; c=relaxed/simple;
	bh=bSXg2zabw7qKisgsVgjD6bCGbNw/2WZDn8ufJFEDH14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijaO1+FKlFHvXHcuIoWGwaSUjejSOapWQDGzVL5RtfSGx0KQwkNDSmxAMh6aoAAPSMFA3tuBzD+jnEb4zLmKiaUDufA6LWg7fIGs9y93P5jwNu1ErCBFF07lVmJHvI+rTQJpmQYwO0m4QFrk2+IO2fsWqPkufcdn692JG31hIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kukRWH4K; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso678014766b.3;
        Sun, 09 Mar 2025 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741520782; x=1742125582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCu0vN4H8XwwS+13HQgSYHgbkhWHfbQF4cgbHHPiSUw=;
        b=kukRWH4KyzJD+fXLrWzXaXd2VSXRq9GVPDAtL9DxEbdqN10bMsDYhj0ufcNnDyjbmm
         UiaMjC6t8OEEdB/j6wcVydjBk5QFARfsWBb3Ugpap3P/IG79galfFSanHa7jin1X9hQV
         tGH5nJltMJkgcNGNZ6zM6C2Hlj0JoWJyj7W1h4cgr5XxnFGY89j2jW1iLFbmtAAXQCGx
         cV8bDCdoJH7n2w57WGRBzvMVCovPk/cg/OBJlrtHIeI0hlNnpycmVvqJAxF9Z+st15GU
         DbbvpT+0lOJQ5ziQTqwPdp5k8tgReP7blmhv0IECVEHNkQN5RTclLWspQHcr6m/QYhGH
         DVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741520782; x=1742125582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCu0vN4H8XwwS+13HQgSYHgbkhWHfbQF4cgbHHPiSUw=;
        b=GOU6t1+Dc13+y5ydrY1hKqiW5WDN7PWaWbS8Mnc5aDQ9v8n1PhleaJIcIw7VGiQ/ho
         UVEYPy0Ulj627EDd4e6SuHJNGDlZlTE5JxKaoz4YVJutUgdZXt50dU+MugaRgbloPrkv
         xRc6OVckUdduitQWtRMeK7lh7ys5JQUUMPcwWt8mSqxtjRJy1t7oqucQO8ZwW2mHS8rK
         Ftm4QvhZUK7oymWyGPToAL+BeW9M6IcOkj70dMCG9ICAM923HD3sr8rGgThVxM4lJ122
         MPsfBDQ5VXVjhqtPQ/ZsV44kC8WDCATbmxOxzYV5Wsv/rp0womQ6cEn9bZTS8/V1On10
         nZJw==
X-Forwarded-Encrypted: i=1; AJvYcCWS8xO9aVQ95zP3afwOZ7kDQlZ5d+plCd5Rf/VFbfl03FVL+Qc8O77sJiZRl4H1yYusgO4+/ltmxC2Ezw==@vger.kernel.org, AJvYcCXMWzDxj2CNZG+nraP4yezf7QtSlvOC8XdHg1We0nntR6nY8A4cQi+09jqHTOAzk1OAeqJ71yuuxBnUIyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSohCrImdlDPLRdhR7TbtnHrLMOp7/vpMJHM6uw/bgjhslJLcN
	xsMdbeygDiRyKn65wP8WiWnFWKUsdcEKgYlg6bZr66OWyrub+mAb
X-Gm-Gg: ASbGnctKOgE8gP5xalYcuBGK0uot119Y44rB5GF/Pi89E9c9TN8RyfFZUAAkG1ZCMML
	QVsmcNrBrrEbfICr2aTzkyT9P87CylQ8Aw9ifG0xreLEFyPvBoJO9/ok2wKTNo32ee9KJERraTH
	n4rufX8jrYoBtXKSc8cAvuHlHC9PM/cdrBL6trX9+pau+/aHeGMrPLYQv2P9HbAoOKl24ddL61+
	ZuJ5j16Fe/0hEAMcKaHz4HSqI84L/XdlXjY2SZEngS5Im5F2p8mjEt/Bn0mAOeiKF1nQHZQRQ2g
	fwnd2PET7awYGJERN0OoVGgyevqJNR+0ylC4Xw8U2g7GgEqoLRn4yQDNKPav3Z5gvg==
X-Google-Smtp-Source: AGHT+IFbrSPJmJebinSVh5WJ3B/eEqdgNq4/X/xaPiP+Hd/vZ5pL3AqNBcKkELkot7YrNNw06xoQaA==
X-Received: by 2002:a17:907:3f2a:b0:abf:7a26:c47e with SMTP id a640c23a62f3a-ac252e9e7cfmr1088030666b.43.1741520782067;
        Sun, 09 Mar 2025 04:46:22 -0700 (PDT)
Received: from [172.27.60.223] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2811e5b32sm187067666b.159.2025.03.09.04.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 04:46:21 -0700 (PDT)
Message-ID: <d415dada-f1cb-486d-b018-171777bfaab6@gmail.com>
Date: Sun, 9 Mar 2025 13:46:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/mlx5: handle errors in
 mlx5_chains_create_table()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20250307021820.2646-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250307021820.2646-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2025 4:18, Wentao Liang wrote:
> In mlx5_chains_create_table(), the return value of mlx5_get_fdb_sub_ns()
> and mlx5_get_flow_namespace() must be checked to prevent NULL pointer
> dereferences. If either function fails, the function should log error
> message with mlx5_core_warn() and return error pointer.
> 
> Fixes: 39ac237ce009 ("net/mlx5: E-Switch, Refactor chains and priorities")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> [v1]->[v2]: Add Fixes tag and branch target. Change return value.
> [v2]->[v3]: Change Fixes tag. Move change history.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
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

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

