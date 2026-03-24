Return-Path: <linux-rdma+bounces-18583-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDhtOMK7wmlilAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18583-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 17:28:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8B31906A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 17:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3AA304D97A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0243EFD15;
	Tue, 24 Mar 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uadL7XUV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C839DBE1;
	Tue, 24 Mar 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369274; cv=none; b=ebhm7+mZJFwuq7Ic6qT8zuZyFvy+DsEUuA2kY3qWIcscx0YuVcL4mrytwQq1nCM0X6GNhUcbTDLxACi3JQUtIUbBO7zWz0c3eqmbcGG62oUFYb/tawnA04j+R/hjUeWrPafdre8te2kOXL0FcTbqdQ/HdfoxC5TRx2cIdOMcOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369274; c=relaxed/simple;
	bh=Y4P//gKJYKBIeGmA/ifT11Z9G31elTHHmiAnZwYb05k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvJc3CMTeHklYdGHOR7eKzYYvLE4B4DqWmPH/MXmXOwtr/mfHFcS6WF1njVYsB/arxGb3O1R9y2Qe7rjnARrUYClTCRVh0y8+8g4oEKuqRhkJKeHJDP4+xiyLohnQrKUgn6Q5lDWdtv9+MMQKpDvZ8FyTXV7ta9CUrfn4X4B9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uadL7XUV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=O+y3BMZYyzHjKrmL9DS2rHlhBb3QhE653K/I70G3pUQ=; b=uadL7XUVZK+dbOIKqMAMptDHQU
	89zCJP5YQcqMFt6jxthcE4yHkQ0TAuTt3IA5ljOYi7NWlwzJkTBN/y2LyQygv08aYqG3RlDpvjwp+
	cQnLYHfUyeENMcUmrcSs1KGR+POSle/p91Tt1VEauUVpUmKaczpvAcjJ0G+6DTf6CQ9b46amhSICO
	yZ8ga2zcufkYWUl/WXzNZVBobJYKUrD1jKtX1svTVG+E41hHCwuChKpWSZli5lhbBxN8oD+OxCMk3
	NjP20VPKiOjCWgbMSQ4edLaDn/3sFogfgQkpX7fZQE73eBWvoOroleEjao5HOi12rPHS6eDSlSmxl
	VVcxHzEQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w54V9-00000001sqT-1vlm;
	Tue, 24 Mar 2026 16:21:07 +0000
Message-ID: <d2600bc9-9dfd-4268-ad57-21992c3a10ac@infradead.org>
Date: Tue, 24 Mar 2026 09:21:06 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] docs/mlx5: Fix typo subfuction
To: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>, rrameshbabu@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, joe@dama.to
References: <20260324053416.70166-1-ryohei.kinugawa@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260324053416.70166-1-ryohei.kinugawa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18583-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: 42D8B31906A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 10:34 PM, Ryohei Kinugawa wrote:
> Fix two typos:
>  - 'Subfunctons' -> 'Subfunctions'
>  - 'subfuction' -> 'subfunction'
> 
> Reviewed-by: Joe Damato <joe@dama.to>
> Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

> ---
>  .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> index 34e911480108..b45d6871492c 100644
> --- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> +++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
> @@ -114,13 +114,13 @@ Enabling the driver and kconfig options
>  **CONFIG_MLX5_SF=(y/n)**
>  
>  |    Build support for subfunction.
> -|    Subfunctons are more light weight than PCI SRIOV VFs. Choosing this option
> +|    Subfunctions are more light weight than PCI SRIOV VFs. Choosing this option
>  |    will enable support for creating subfunction devices.
>  
>  
>  **CONFIG_MLX5_SF_MANAGER=(y/n)**
>  
> -|    Build support for subfuction port in the NIC. A Mellanox subfunction
> +|    Build support for subfunction port in the NIC. A Mellanox subfunction
>  |    port is managed through devlink.  A subfunction supports RDMA, netdevice
>  |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
>  |    SRIOV support.

-- 
~Randy

