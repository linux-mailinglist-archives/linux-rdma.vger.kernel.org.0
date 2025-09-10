Return-Path: <linux-rdma+bounces-13215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F62B50A30
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 03:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387454483D7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D41F3BBB;
	Wed, 10 Sep 2025 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tExNPPiF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A611EF36E;
	Wed, 10 Sep 2025 01:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467432; cv=none; b=YKNMuh6q0U9/DxcD15lZkFyEyFJbI8IS4VqQlJUIgKh1YSZDc+T0xbWrVmEXoqrDIPXS+ldOCBOn/yUrSNaMG6vpExgd0lfm6i/H1VIBQPmvcrx2hCijZtCKQ8JTVfDYhEFwdUoOER6a9zeMgIrasMfPwVNNmo6PZEPOWxuXqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467432; c=relaxed/simple;
	bh=8Tph3Mdng0klOn3Y7UpTZVK/JtvnHHum+iG72VMnspM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCpsBFZi+DxgO4REF0JXyrjlAuK6bv+2DimSWnAiOJqp2RrcZ12Ksgi7+FEqAmU6+UDxC9rkidiGgyUA+h26m8eaeo2AuQQbn+xF4Hnm6UGauWn5CB31OKrh/TvMqySyEv1+6s2qsGaJAhRYgbkM/GJvRX4QwiZNod9BjUZcUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tExNPPiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D14CC4CEF4;
	Wed, 10 Sep 2025 01:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757467431;
	bh=8Tph3Mdng0klOn3Y7UpTZVK/JtvnHHum+iG72VMnspM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tExNPPiFHMwuxddzWPTWgm651z4v/NJZkD/AAtjg4KxZOKoIdT015ARZcACsVcngk
	 7hFeRdrFeu8uq6v+oRRnJzElaCO8fupkYokVkj8phVf9sNwpxLEcvoeMzdckYLKodU
	 aDbcLvbAiOWkl7r7QULUbhzuO0DKxdBADGglN7CM0Nzj+icV6Rxn5z2Jd9+MI1hMlh
	 b46r+8bWhUdZ+ONBBIAAxoAtSHQG7fczIpvuqj7Eukw3I91zFzc5uHqTP5woqYEzer
	 DlKGL714K9dp3CukOWspPbF9aAdIr18w/CXvBtolTbrTAhyzgXDU/tOTkn5HRremzk
	 LdGUD+YgihIvQ==
Date: Tue, 9 Sep 2025 18:23:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>
Subject: Re: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against
 device unbind
Message-ID: <20250909182350.3ab98b64@kernel.org>
In-Reply-To: <1757326026-536849-2-git-send-email-tariqt@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
	<1757326026-536849-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 13:07:04 +0300 Tariq Toukan wrote:
> +	struct net_device *netdev = mlx5_uplink_netdev_get(dev);
> +	struct mlx5e_priv *priv;
> +	int err;
> +
> +	if (!netdev)
> +		return 0;

Please don't call in variable init functions which require cleanup 
or error checking.

