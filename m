Return-Path: <linux-rdma+bounces-14601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468FBC69E70
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2A9CC2B935
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Nov 2025 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14B3590D7;
	Tue, 18 Nov 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rZSevX56"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4D350A1E;
	Tue, 18 Nov 2025 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475388; cv=none; b=ZzWIYqH9l3itCKsaQovBvFpukQ1XnXJqjAi8jARzwiD0XnMxpceDPvU/KKB/yUGL1Ce1Jm+F/Msztb9ltR4JX632jrxxWQLjEUjB6KvhBU4WZuwrNXX5xTm0YE1yxPKeaGZ9mhzMgu/P/C3T1N8RQ1P7MCEty23fUdZ1Y8AoHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475388; c=relaxed/simple;
	bh=aKCh9z64HInFJ4FpiEKmHPF4xCGLRzCqTWSvJCeZsYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltCQhCrw1UZT/4rxP61QdDBK4ig9D76J6HSEly6rO+ap3b4ri7eZSwgp/BP16ltK0Lq4DjaUOBGlC2dsIjHcO7D93GxyWJ+vw/o3XU2irrziOvqos6VpDnay21Fc67xeh6uZwH0mEhCPDdPM8I4eU8K91XMe/9JatGCl3sr403Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rZSevX56; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AC7E14E41762;
	Tue, 18 Nov 2025 14:16:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B29C606FE;
	Tue, 18 Nov 2025 14:16:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5643D10371867;
	Tue, 18 Nov 2025 15:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763475383; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Y7S1oWvyJulQPsg6AFtZsd2ot0WojieRgVnRZ3VWiIo=;
	b=rZSevX56KQ94GD1E4LqTOWK4HAJcBR+vvc3VkWQDNuFvhKrroWYTXKNEVXsdJO7P8Eo49z
	GWJTzkUsH2ABGaA5k5dl1Jb/oEGKd02489rB/kVbzjnC9p5j1Sv6cAN6Kte/gAh0f1cjhm
	IEPKqEFWnXJCtvOE3Qq9sYwh9aAnFKsVoMTTc11mgUwPB+q0mkObE2Jht6pTeZ2wb5fux/
	DM8aWmUTkS4199dS04Qe6SxFQ5bzzlpXJXPIFwLnG+qmuEz5PE5TlcOi4nEoZPvdTZss4D
	pS2Q3DVBrD/UsT8FJctUT8ybc8KF9F1pTOoa+R4dBWJFaE1BIffeJf3yf1Zmdw==
Message-ID: <7ad06091-dd5d-4084-81da-e148bd4aea63@bootlin.com>
Date: Tue, 18 Nov 2025 15:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: ethtool: Add support for 1600Gbps speed
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla <ychemla@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1763414340-1236872-1-git-send-email-tariqt@nvidia.com>
 <1763414340-1236872-2-git-send-email-tariqt@nvidia.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <1763414340-1236872-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 17/11/2025 22:18, Tariq Toukan wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Add support for 1600Gbps link modes based on 200Gbps per lane [1].
> This includes the adopted IEEE 802.3dj copper and optical PMDs that use
> 200G/lane signaling [2].
> 
> Add the following PMD types:
> - KR8 (backplane)
> - CR8 (copper cable)
> - DR8 (SMF 500m)
> - DR8-2 (SMF 2km)
> 
> These modes are defined in the 802.3dj specifications.
> References:
> [1] https://www.ieee802.org/3/dj/public/23_03/opsasnick_3dj_01a_2303.pdf
> [2] https://www.ieee802.org/3/dj/projdoc/objectives_P802d3dj_240314.pdf
> 
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/phy/phy-core.c   | 4 +++-
>  include/uapi/linux/ethtool.h | 5 +++++
>  net/ethtool/common.c         | 8 ++++++++

Can you please also update drivers/net/phy/phy_caps.c :

 -> the link_capabilities array
 -> the speed_duplex_to_capa function

Without this update, phylib will fail to load entirely (by design), cf 
phy_caps_init(). A check was added specifically to catch when new speeds
are added without updating phylib alongside :)

Thanks,

Maxime


