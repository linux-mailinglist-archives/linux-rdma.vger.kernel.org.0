Return-Path: <linux-rdma+bounces-19291-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNGvDIAA3Wk3YwkAu9opvQ
	(envelope-from <linux-rdma+bounces-19291-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:41:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C605B3ED658
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 16:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAFC3083575
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B183DE44D;
	Mon, 13 Apr 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moIe5J/N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE773CD8AB;
	Mon, 13 Apr 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090619; cv=none; b=DgMxmkfXfNAaKR+XvaQ46OzDGBwyHWJAEgstDXlJWhPvkMXYVheN3DdiXfebRn9/vKo7RLpl8NYy8VL6Qg/ejHFK620HOsOoP5t2LFxDPIS0QM7nqWnGWUVw5Ylvj4Q2hKWbkqnDpiA9QDNWYskci99ZhKezDcyNRGQNrS++EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090619; c=relaxed/simple;
	bh=wVyc4p5BmfcPo6mXW+i0uQbURUVCalHakg2O4vAcgjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz0/81fo9ffExGZ5tY3PilhQ7Vpe5lABKIHmJNFy+gs04o8VUAY9ktv7f6nSFYXitFqJt37UgytQ6coiULC33YeGjwscrGJPCjqBibGgwQThlADyoZjmS5AV0dAZrB+837/Vw/dbkiGS8XhyLssxYMmWPhZVfgQDWyx3LrPB+FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moIe5J/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC44AC2BCAF;
	Mon, 13 Apr 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776090618;
	bh=wVyc4p5BmfcPo6mXW+i0uQbURUVCalHakg2O4vAcgjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moIe5J/N1VyvpOz+TA9v44wlA8d1AOZdkX9MLS7ya4G65+U+wcqsu7oIUB0ctsEL2
	 GDre3iE8Z5+UtcN9nJg+Uf8KUDQBdkmwa6gsxhcXPEiueqlwCDirsDxsYS4s8cbq3G
	 yPan54p+dNiIkXmmESESOQcv5K3Vo0AzhlkTGO/cr4AlHQSSLycA+kuBHqBvSC4DPF
	 p0UiXIcMs1mRJL0u9Gilaw0jgEgpvr7bzoEuYF0gsAxASnEspdcHrOjnQEwopf8bDh
	 LgXcDRhs68neCVimJSgbBXWAbVPHcZG3TWY3q5hbzRYW39qOt6jSCY3vhBAWYqnN5o
	 piQqNrCOFH+NQ==
Date: Mon, 13 Apr 2026 17:30:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Fix refcount leak in add_port() error path
Message-ID: <20260413143012.GH21470@unreal>
References: <20260411091626.2141130-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260411091626.2141130-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19291-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C605B3ED658
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 05:16:26PM +0800, Guangshuo Li wrote:
> After kobject_init_and_add(), the lifetime of the embedded struct
> kobject is expected to be managed through the kobject core reference
> counting.
> 
> In add_port(), if kobject_init_and_add() fails, the error path frees p
> directly instead of releasing the kobject reference with kobject_put().
> This may leave the reference count of the embedded struct kobject
> unbalanced, resulting in a refcount leak and potentially leading to a
> use-after-free.
> 
> Fix this by using kobject_put(&p->kobj) in the kobject_init_and_add()
> failure path.

The analysis is correct, the implementation is wrong.

> 
> Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/infiniband/hw/mlx4/sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> index 88f534cf690e..15b36b9e4bd6 100644
> --- a/drivers/infiniband/hw/mlx4/sysfs.c
> +++ b/drivers/infiniband/hw/mlx4/sysfs.c
> @@ -642,7 +642,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  				   kobject_get(dev->dev_ports_parent[slave]),
>  				   "%d", port_num);
>  	if (ret)
> -		goto err_alloc;
> +		goto err_kobj;
>  
>  	p->pkey_group.name  = "pkey_idx";
>  	p->pkey_group.attrs =
> @@ -689,6 +689,11 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  	kobject_put(dev->dev_ports_parent[slave]);
>  	kfree(p);

This needs to be changed to: “kobject_put(&p->kobj);”.

>  	return ret;
> +
> +err_kobj:
> +	kobject_put(&p->kobj);

I’m also wondering why we don’t call kobject_put() in the port deletion
path as well.

Thanks

> +	return ret;
> +
>  }
>  
>  static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
> -- 
> 2.43.0
> 

