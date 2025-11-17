Return-Path: <linux-rdma+bounces-14534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE8C6411B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 13:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 616F228B70
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535832E6A2;
	Mon, 17 Nov 2025 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cObxshb/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450C329C58
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382672; cv=none; b=on8sEzzrf3sJSnPorraXWm7980hg0CU7tjv+7L4D8copAHbaiVHTy/6Bu0zRv1PSQyXqB7B94Opfw6Y6RHoK9A1dLWPAhM7qmc1baCu8zOwRK/8V35zDjPHnGHivK1LJT02WyzeivgSg9eOl18lFT6r2oO2inr6INTlZ+lcFn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382672; c=relaxed/simple;
	bh=eZX3VY/wwOhnBkRxrXkAj4ZYfjPMZWso2jVLNleXNjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX2zOi5rJLF21rjb1YC59cssqQV2XULet35ecdHpLHkwYeJpfIgt8N2EG+qlFOsIA31okRcik2TA7QYm2yV9WnU6WN7e9fkSFMSF8n/Ikwb4dbOAA4bCk9D8jimn2QJbf+j2G0+6bXa3NATr6v0OVfjQurK9IHOuQQ067DhCOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cObxshb/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a1c28778so12711975e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 04:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763382668; x=1763987468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9tE4VHTomLTpQ4uC8z4QSbQwAJDgksbr7MPRCjOv8s=;
        b=cObxshb/zWlrC7l8qsdGgV++Gyux2J/uT6WyodKUG/P2G4tL0AtwV+GBJvf6MG6T1e
         wh8jvF4e/ffR1ONVDti0GTOCO9IjS2F8jfBpCUXmqZq3/RT7WECFIZgDsw5dgpSv1gJt
         UGnrvRMERUAjVLg2pIszT4op+stHOTNl9FKBb3RL18SJl/6Yj0V2wdCNT8bIcmS+FQul
         3vnsDIgDsouneyjqNOx4f6TqRWerck8RTCy7u94Dm2ejIghYatjQ6lI3tLuuG4UnFkEI
         YwYCbbB8g0m7j/P9g8efT81S7HJyJEF7Lk98gfml9rgpNw8bt+/xqFxQ/XdtrIi/KQP3
         VYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763382668; x=1763987468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9tE4VHTomLTpQ4uC8z4QSbQwAJDgksbr7MPRCjOv8s=;
        b=BzpqyqdNx/FdLCzKjV1O4zY/wOJFZJXaoVTP8R++T+kPb0CHhqUF2pP20jtN+pNPj2
         UhIbWeAraxPVYv8vdt7xUXD9CdpKgNMcyQsLVgT+C1aQ4JQGximnnFE2NU+DgBPoJ4lT
         qmW+YIdIF1c52IdEQ/cLGSsEAnMp6VpVUHrhIZD/RrgyMI9613dHnYX8jPS/4qK8KFg3
         yUmiUvbz/ajDIhWhD7iHXTbFTLm/VcX6vWpH4GktUEoyzUauN/Wajv4smyE2eeWbj8tM
         mpAyrMs5FgP92YMO4enbLa241eaXk52QnceohGDU5EggXfH+6Jgt0Yh+HU6iHIwkFPPN
         roVg==
X-Forwarded-Encrypted: i=1; AJvYcCVl80NpB27C8nAUwNLqGOVEZC9YIRQwAHkX8M5j8JWtjtTuWK9Ox1y4MxR+IDwwlQTHpM7DsD/ph+zU@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgfyrgr+innVXat1On8GWFC5ld2rCfLXLpM37SItWtlgbafvc
	QAE6sQQx4Jbu8N8J/r7MIFrvt6ocBh9E2Q1Tp2ZbtSU0rY92fte18j9c
X-Gm-Gg: ASbGncvwiPrJbb0Y93ilfVaz2LcuUJCFmjUnfjV2t5uUjGdeIpghbaVKu+xh0re5RWi
	bXQnq780LGuQ5tDjSMm/S7mpSm4ulZDx01ZY+hKRcUkyGd3HY95lvvsj+53IyjwrkP2CfmXh4IF
	tZvGb0AekwZ828nT1X7ep1DY2jjQ+pqKQ4Gz6jUVfbPnDNBsbmCo4HFrMg/dVuQc3Si+DVpcQ65
	FwogIqbc+5t7vWDqkHO7Cl+D23gnv6lEsQ9BWOYBYl2zl8U8BSYKZgbaDE5ZBanLoOitYaubu1P
	+iaIWl5XkvVWUZ2Gm77Guzi175kGr98oq3guYtaiktnycjdKFuAjvf2WsC6aKUdtRP/upvVq9UP
	CBiRb2RAro9KI6IpjJV4Gck9+DUzZgimj+3r9HAnSzn9zDrsO6Is92Tllbl/XhW+RucnMgHE/Xb
	1+MIdl5j5ld9NCdzD4
X-Google-Smtp-Source: AGHT+IG2sWHMA6qjXeWEG8ifkX2qxcH6n9I6A++NPco79OGgUlbMCsxhZ0kNtfCAgnQ8jL7yVBKhIQ==
X-Received: by 2002:a05:600c:45d5:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4778fe59054mr117495935e9.14.1763382667815;
        Mon, 17 Nov 2025 04:31:07 -0800 (PST)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6acsm316428125e9.9.2025.11.17.04.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 04:31:06 -0800 (PST)
Message-ID: <56b75450-6c51-44f1-ba7b-92688386c4d5@gmail.com>
Date: Mon, 17 Nov 2025 14:31:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mlx4: extract GRXRINGS from .get_rxnfc
To: Breno Leitao <leitao@debian.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251113-mlx_grxrings-v1-0-0017f2af7dd0@debian.org>
 <20251113-mlx_grxrings-v1-1-0017f2af7dd0@debian.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251113-mlx_grxrings-v1-1-0017f2af7dd0@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/11/2025 18:46, Breno Leitao wrote:
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
> 
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
> 
> This simplifies the RX ring count retrieval and aligns mlx4 with the new
> ethtool API for querying RX ring parameters. This is compiled tested
> only.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> index a68cd3f0304c..ad6298456639 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
> @@ -1727,6 +1727,13 @@ static int mlx4_en_get_num_flows(struct mlx4_en_priv *priv)
>   
>   }
>   
> +static u32 mlx4_en_get_rx_ring_count(struct net_device *dev)
> +{
> +	struct mlx4_en_priv *priv = netdev_priv(dev);
> +
> +	return priv->rx_ring_num;
> +}
> +
>   static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>   			     u32 *rule_locs)
>   {
> @@ -1743,9 +1750,6 @@ static int mlx4_en_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>   		return -EINVAL;
>   
>   	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = priv->rx_ring_num;
> -		break;
>   	case ETHTOOL_GRXCLSRLCNT:
>   		cmd->rule_cnt = mlx4_en_get_num_flows(priv);
>   		break;
> @@ -2154,6 +2158,7 @@ const struct ethtool_ops mlx4_en_ethtool_ops = {
>   	.set_ringparam = mlx4_en_set_ringparam,
>   	.get_rxnfc = mlx4_en_get_rxnfc,
>   	.set_rxnfc = mlx4_en_set_rxnfc,
> +	.get_rx_ring_count = mlx4_en_get_rx_ring_count,
>   	.get_rxfh_indir_size = mlx4_en_get_rxfh_indir_size,
>   	.get_rxfh_key_size = mlx4_en_get_rxfh_key_size,
>   	.get_rxfh = mlx4_en_get_rxfh,
> 

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

