Return-Path: <linux-rdma+bounces-8370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A3A50481
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 17:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79353A4A9E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99618A6D2;
	Wed,  5 Mar 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kLrzMw47"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998018950A;
	Wed,  5 Mar 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191728; cv=none; b=RuRQml5a0ZWd0t1FuBekOzxs0zBGC/UABZRBeOAQZVi4g4KosG4gZf3HnVv9EdgEV4wqjfFPg72wVIgEVcaZgp3ZqRDL2TXWp8tYFdaZbfpLTtU2V75wfDd4ZAo5e3iyGUxfyVOWghGUtyxuaHmPtukTVI2sDpBXmMCTazo4ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191728; c=relaxed/simple;
	bh=Qs4bSXN1UPqNPJQ+b6FCbgfxP2rWdiFKIvuB25gCHgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXfDgSQyWcBiGEmkuGcyWCvgihmcp2eZgxaEgYBKzAQRWw+0whNlOb+DxZDGM7qFRfHqHX26Ih6nBxnJgX+k+CqERjNZ9DfbdzJJTiGKpaASmWCd7JTpNfXrPv5BqQDjZ2G8djw1E4nP7x+Wxo/WkOaRxj3Nk0GOgXQc3jDsl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kLrzMw47; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qwwhvo6qIhLMIZObZNe6citjrsx8zsjSWUsM8d8hyyQ=; b=kLrzMw47RHaAzfyma+fejtNfff
	5hP1QWsxgsIOmeGN9QBjDHU+ZnfL3CQOaEjW1GJSLo5cDm68JMH1iYdcc0c5qUH6udtNNifjza+aZ
	guHyowgMypKxx8jC5lCVxlUTimgDJ5nxJjEDcJP9dDOtOh5GFhSDQTu4okxaJjvx2BXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tprVM-002Ws0-6P; Wed, 05 Mar 2025 17:21:56 +0100
Date: Wed, 5 Mar 2025 17:21:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>,
	Leon Romanovsky <leon@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net/mlnx5: Use generic code for page_pool
 statistics.
Message-ID: <433b43b1-0a42-4606-b919-3429c36aa934@lunn.ch>
References: <20250305121420.kFO617zQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305121420.kFO617zQ@linutronix.de>

> @@ -276,6 +263,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(sw)
>  		mlx5e_ethtool_put_stat(data,
>  				       MLX5E_READ_CTR64_CPU(&priv->stats.sw,
>  							    sw_stats_desc, i));
> +#ifdef CONFIG_PAGE_POOL_STATS
> +	*data = page_pool_ethtool_stats_get(*data, &priv->stats.sw.page_pool_stats);
> +#endif
>  }

Are these #ifdef required? include/net/page_pool/helpers.h:

static inline u64 *page_pool_ethtool_stats_get(u64 *data, const void *stats)
{
	return data;
}

Seems silly to have a stub if it cannot be used.

	Andrew

