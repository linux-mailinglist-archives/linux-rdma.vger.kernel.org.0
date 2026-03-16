Return-Path: <linux-rdma+bounces-18188-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOvbAusvuGmvaAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18188-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:29:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEA29D656
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 605F13014A19
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2433986D;
	Mon, 16 Mar 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB1aWblS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FB324B1E;
	Mon, 16 Mar 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678555; cv=none; b=WDW6kNv+w2VxxmEEW2pZ0rhcgyzH4mRkrcUMnniGjjfc11YU8JMWySfUyCBimswTcMTcZujOx3r/92rNS+y9/8zUJr4ahZZIgju/2nau64plkPB5ElLDEflhh4YgyGCBFUi4YptZWnMj8HRGwJeTSQot6u96mlRpaE8bTCQ1Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678555; c=relaxed/simple;
	bh=Rmg15hCCHZS43GwzcGSrLfteJf12na0B9zF/Jtahl2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSx4NbxsIYh6N/Y2MXL/d7DmnDejWzaarl/p+NxmdV3t/qiJL7DDjoHkpBC3zAC2F7o2abFX18cyAJej5QIT4mKT/YipFqkoT2DMEozcfhvcRISLRL/z1Oo6SUbFclEPEfLuTyhCHqJ7trhWqZ3G+CoiWjw56pJ8CygTmX+XMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB1aWblS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17816C19421;
	Mon, 16 Mar 2026 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773678555;
	bh=Rmg15hCCHZS43GwzcGSrLfteJf12na0B9zF/Jtahl2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PB1aWblS4HYzJ/IcBWxbCQJwvb3uZqn9Jfj8jz0mHZwPgWLd1wfB1x8fS8CCXA1MH
	 RkI+161R7bIGQTeBOqOiWRuUFbpMaCN8t3JdsNabKLRH2i3qgYbXbZt4nJUV7FyN0h
	 zmLKsLdTUQ7lzFrrPNclJ7cC7oBsiY5V5a811WHWe5m6OMSfY15IHrN6YdpwHFuF4v
	 AN9uZzuqk08gHFsrVbmILccFcfLEN93pSjmw6mTXEq2FUZ0QStfuYOEEW3ZVDbFyoZ
	 L31h+0yU2C/IWKDaok0aZs04rGYjIFG5zIz4VQeEtHkasPFyX5iokxWjmGgbi950C8
	 u2+CGVzc4l3qA==
Date: Mon, 16 Mar 2026 18:29:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jianzhou Zhao <luckd0g@163.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mark Bloch <mbloch@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>, Kees Cook <kees@kernel.org>,
	Jang Ingyu <ingyujang25@korea.ac.kr>,
	Moni Shoua <monis@mellanox.com>, Doug Ledford <dledford@redhat.com>,
	Christian Benvenuti <benve@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yuval Shaia <yuval.shaia@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] IB/core: Fix use-after-free of ipvlan phy_dev in
 ib_get_eth_speed
Message-ID: <20260316162909.GG61385@unreal>
References: <20260311100313.284589-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311100313.284589-1-jiayuan.chen@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18188-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,163.com,ziepe.ca,nvidia.com,broadcom.com,kernel.org,korea.ac.kr,mellanox.com,redhat.com,cisco.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 0EEEA29D656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 06:03:08PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Jianzhou Zhao reported a NULL pointer dereference in
> __ethtool_get_link_ksettings [1]. The root cause is a use-after-free
> of ipvlan->phy_dev.
> 
> In ib_get_eth_speed(), ib_device_get_netdev() obtains a reference to the
> ipvlan device outside of rtnl_lock(). This creates a race window: between
> ib_device_get_netdev() and rtnl_lock(), the underlying phy_dev (e.g. a
> dummy device) can be unregistered and freed by another thread.

If ib_device_get_netdev() worked as it was supposed to work, it can't.
That function grabs reference on netdev and returns or netdev with elevated
reference counter which can't be freed or returns NULL.

Thanks

> When the ethtool call later recurses through ipvlan_ethtool_get_link_ksettings()
> into the freed phy_dev, it dereferences freed memory whose ethtool_ops
> reads as NULL, causing the crash at offset 0x1f8.
> 
> Fix this by moving ib_device_get_netdev() inside the rtnl_lock() section
> so that netdev lookup and the ethtool call are atomic with respect to
> device unregistration. Under RTNL, if the phy_dev has been deleted, the
> ipvlan device is also unregistered and ib_device_get_netdev() returns NULL
> safely.
> 
> None of the existing callers of ib_get_eth_speed() hold rtnl_lock, so this
> change does not introduce any deadlock.
> 
> [1] https://lore.kernel.org/netdev/94089b74-def5-4dd0-9143-1cfbc722fe73@linux.dev/T/#t
> 
> Fixes: d41861942fc5 ("IB/core: Add generic function to extract IB speed from netdev")
> Reported-by: Jianzhou Zhao <luckd0g@163.com>
> Closes: https://lore.kernel.org/netdev/94089b74-def5-4dd0-9143-1cfbc722fe73@linux.dev/T/#t
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  drivers/infiniband/core/verbs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 575b4a4b200b..f16d11e7c2e3 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2046,11 +2046,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>  		return -EINVAL;
>  
> +	rtnl_lock();
>  	netdev = ib_device_get_netdev(dev, port_num);
> -	if (!netdev)
> +	if (!netdev) {
> +		rtnl_unlock();
>  		return -ENODEV;
> +	}
>  
> -	rtnl_lock();
>  	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>  	rtnl_unlock();
>  
> -- 
> 2.43.0
> 
> 

