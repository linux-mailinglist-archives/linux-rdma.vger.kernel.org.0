Return-Path: <linux-rdma+bounces-10434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E90ABD680
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 13:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299FA8A4D5F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EBB27AC47;
	Tue, 20 May 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fegJRffV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243C27A134;
	Tue, 20 May 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739662; cv=none; b=K2jLbjw/6nv8kC8YrLLS0U6RZVqyA97zDmf1Ts+iGW/DPxBQHc75+Sr3CCwkURZIGye/bXfBl+aM87iYpVt6CeOBfi/p07wqtZ9sxE2LVzRD2uS21AuglkD3adfQmYiE/IkIHDWPH6YOsA0Sz6HMc4Lweuh8ikhAnrVOv6d5oxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739662; c=relaxed/simple;
	bh=hTmDbzGjkTf1u4M5RQ2E+86aebdsDLMJC7lq52z5LeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8DAss9RZVkxqLcjuv7nc6JjurKbdAoicoH4orHtzGuaE8pls61hK3UIHp4ZI25zw7NFmovz+hMBLICMSVXE+L5YMpB0zIeVo9cCkeiNJ4XWS9ink06kcDwNwEhZnA08WMMF3JhDe+tvH2qJJSjmqwP0ua2oTgi8OOORtB8t2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fegJRffV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a375888197so971244f8f.0;
        Tue, 20 May 2025 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747739659; x=1748344459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMFIgHV/DDnEoy8DO8FdBRJET+N+6zimNw/ag57P1gM=;
        b=fegJRffVCeA5YTIHT065ypcqr33AWDdeO8MT/fx8KchNYjnWqmOm82EyL9ye+xmpRR
         3k4gyjT5O20CQisBLwfCpdtY/NjKaEbbm+MKqvvi7FS2lKDKwiKEzHb0QZKzFVWfJmDx
         ogN/O2Nc5bGJWSH10AZqmp699dxXAe7U897Sq+TyVfFXQYSXNZjMz8s5QHBQXfuH8zSa
         fg0wsylIx4AXB2xWbogQzgDPlVpEycTmpkcYPs9OPO8LBOVVt7Y1+kkjEW4k+rO/9rZE
         6fc+58j2X8UDXAUAJJqiQHIj1nKBZubuEmOyXKCYxM7cpM43KirxuNJuJa4WvQo8TSu+
         ZJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747739659; x=1748344459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMFIgHV/DDnEoy8DO8FdBRJET+N+6zimNw/ag57P1gM=;
        b=FNECpTYboEf9mxOqK6K1cfTUXaRo71NEbigB4ZwYKRkKRxZvm+JZBdmHb/xhFIVavV
         mffnOOL4nebkRRuooY2eBGQmn0l/+eSqkxbTcMZc6ST89DgyE56KMpYjVsGZACrDNp91
         3V+Z1Jz6S5eKuZAIe9v5fjJP2XPLtQ5w0hY/kwuOOvH8k0aSo6j5Q5nVRZe32q5buh+v
         QGpz8T4bOYkMc31MRPYVkI/T52J73L/bKIrk+NjW49luUvd8FtUy4+PvzrTKWXPEiqqw
         i6pSmFBymy6877lqft/ZM9pc0DnjFKJSNyObO5lRuQ67UzrvfpnNYLS2a4A4zIeQrkdy
         PxWA==
X-Forwarded-Encrypted: i=1; AJvYcCVgg9dgcgFTiRvF5H+mOPyZDRoDEtbUGM41ULqcplJoAjjEdGeg2Hn0ERqUluNBgu26XLG2fqLp9Pe94KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2jybzX88nU3p0ZB+EEdbvyAfef8Sf3+lUksKSowqWMSmCN1yl
	Pm70+s8RGXcFZXYBR/eBEtz6V06IvrcDwe23ZOshenCwxQ99D9gdXnek
X-Gm-Gg: ASbGncur1jEOvpX1n+20KjlZ0kFyrohqVS/K4nSW7Tf7Xdlp9aayFv4Tm4Lg2DTTI8k
	gzNawtGXqAdtgze9Qfugfj7J/fjlBDE2wsVZAljX/6YFPihgOCF/mlz0XhcR4GzyE8c+scR8dBJ
	9rPg80nSrqFR0LkaK8K423BlBw2Fkuwj/830xBoUr4YRfBQRSqLaRhWWlsOjMZ6mf2x4Y59eEaM
	ZkPogRbMacIyJn02yp4f+yJmua2BDWlY3gizi33KwMQXwJ1fpuOnio9tw3RHtMP6gmqoA9uPUWN
	T5GmZBkyyP4/sFNKoqbItFqsxmvZj+UBZNq9nyKAHiXcYepNeZ459JX28d6AMIkWGM7wktpI
X-Google-Smtp-Source: AGHT+IHktmC1blKXqb6+gnZX6C4BOIsGW5VLDisrVqZT6WC3fqwmlC1I6EFXUp3KW08Vmy/I6paZNg==
X-Received: by 2002:adf:fe03:0:b0:39e:f9ca:4359 with SMTP id ffacd0b85a97d-3a35c84444fmr10584757f8f.30.1747739658590;
        Tue, 20 May 2025 04:14:18 -0700 (PDT)
Received: from [172.27.21.230] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3674fed67sm11883415f8f.89.2025.05.20.04.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 04:14:18 -0700 (PDT)
Message-ID: <bb12f21b-8b36-4fd8-80a7-4a25221f6d18@gmail.com>
Date: Tue, 20 May 2025 14:14:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Add NULL check in
 mlx5e_tc_nic_create_miss_table
To: Charles Han <hanchunchao@inspur.com>, saeedm@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, roid@nvidia.com, jianbol@nvidia.com
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250519112747.12365-1-hanchunchao@inspur.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250519112747.12365-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


For EN driver changes, please use net/mlx5e prefix.

On 19/05/2025 14:27, Charles Han wrote:
> The mlx5e_tc_nic_create_miss_table() function did not check the
> return value of mlx5_get_flow_namespace(). This could lead to
> subsequent code using an invalid flow namespace pointer,
> potentially causing crashes or undefined behavior.
> 
> Fixes: 794131c40850 ("net/mlx5: E-Switch, Return EBUSY if can't get mode lock")

Tagged commit doesn't seem related.

> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---

Explicitly mention target branch, and add the netdev mailing list.

>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index f1d908f61134..81f0db29a2bb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5213,6 +5213,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>   	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>   	ft_attr.prio = 0;
>   	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
> +	if (!ns) {
> +		mlx5_core_err(priv->mdev, "Failed to get flow namespace\n");
> +		return -EOPNOTSUPP;
> +	}
>   
>   	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>   	if (IS_ERR(*ft)) {


