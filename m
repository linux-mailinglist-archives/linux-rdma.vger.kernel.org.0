Return-Path: <linux-rdma+bounces-20848-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFumA1XQCWoOqwQAu9opvQ
	(envelope-from <linux-rdma+bounces-20848-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:27:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B9F561A7E
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDB9301BA47
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA2271A71;
	Sun, 17 May 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGZ9jpL7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB452F3C0A;
	Sun, 17 May 2026 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779028045; cv=none; b=SEKGlTa2anb054pG/D+OqiCOvTyU5JQb56hHdecS+jW4Dywbwur5XzqiML26pVvCBR9wQ+BPjqjUL1obiV/2KNAEgO+fiZfhO1blxo2JI1k56dSLWvRWZ/FmJh+Z50Ko9HDXJPFmoKsg+EtxcK6Wp5LYnd1Kp8FljbdVlnwqkkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779028045; c=relaxed/simple;
	bh=+MW7y0sv/dzfw2LK82fQmvdheX6RZsGwgtFJHU3PyBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTkhO/EnaIvqDyQcbk7vzP+kwoxWaV1miZMrrYaGd1xwVSAL8Twh0HsOfStu4AVt/SbkmBJUFEnk/m992mYI/yAjRQEilWDyihNwr4B29ouHV4TZS63D8NiRFPK4V3i1frf1jLsV7d4gGnbyvTvh2nvh+tcgEv04nnYUHOfSQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGZ9jpL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E3C2BCF6;
	Sun, 17 May 2026 14:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779028044;
	bh=+MW7y0sv/dzfw2LK82fQmvdheX6RZsGwgtFJHU3PyBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGZ9jpL7IeTf4ApESsbvYHMT8HjqPbj18Qk5rKojs1ZU95x+wXxKhOiNMBRJ6ccr+
	 YO9PfG3ODAvy0x/t1hSjkQwu/enXYWPvHc8XzMcQfy5KPAArRMOmkdcCIaFxR8Qm87
	 YSJqVwEX/BxhAWNh9AOjIxwqjLPejPZ166PgC9IFY2JYR+var+dsfN92kXMlAnEibJ
	 byEZDU2dABhT498IMgBRekuUie5ESnZAIDwnTUvAvpVLEvWGCGd0688H+F62NzKkb7
	 Oq+4EPdV592pT06DWLcmvwBV963HFklrsj5/slC9RP3yAiIFh2bgOP6Hxhn2mpidoF
	 +4fL4KZcNPKHA==
Date: Sun, 17 May 2026 17:27:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] IB/mlx4: Fix refcount leak in add_port() error path
Message-ID: <20260517142719.GH33515@unreal>
References: <20260514110139.864340-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514110139.864340-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: A1B9F561A7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20848-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 07:01:39PM +0800, Guangshuo Li wrote:
> After kobject_init_and_add(), the lifetime of the embedded struct
> kobject is expected to be managed through the kobject core reference
> counting.
> 
> In add_port(), several failure paths after kobject_init_and_add() free
> struct mlx4_port directly instead of releasing the embedded kobject with
> kobject_put(). This leaves the kobject reference count unbalanced and can
> lead to incorrect lifetime handling.
> 
> Allocate the pkey and gid attribute arrays before kobject_init_and_add(),
> so failures before kobject initialization can be handled by directly
> freeing the allocated memory. Once kobject_init_and_add() has been
> called, route failures through kobject_put(), and call kobject_del()
> before kobject_put() on later failure paths after the kobject has been
> successfully added.
> 
> Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v6:
>   - drop the Cc stable tag
>   - allocate pkey and gid attribute arrays before kobject_init_and_add()
>   - keep the release callback unchanged by ensuring the attribute arrays
>     are initialized before kobject_init_and_add()
> 
> v5:
>   - split the add_port() error paths after kobject_init_and_add()
>   - call kobject_del() before kobject_put() for failures after
>     kobject_init_and_add() succeeds
> 
> v4:
>   - route all add_port() failures after kobject_init_and_add() through
>     a single kobject_put() based error path
>   - remove duplicated attribute array frees from add_port()
>   - keep mlx4_port_release() tolerant of partially initialized objects
> 
> v3:
>   - make mlx4_port_release() tolerate NULL attribute arrays
>   - drop the parent kobject reference on the kobject_init_and_add()
>     failure path before putting the embedded kobject
> 
> v2:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
> 
>  drivers/infiniband/hw/mlx4/sysfs.c | 39 ++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> index b8fa4ecfc961..e4c822c96ee6 100644
> --- a/drivers/infiniband/hw/mlx4/sysfs.c
> +++ b/drivers/infiniband/hw/mlx4/sysfs.c
> @@ -636,12 +636,6 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  	p->port_num = port_num;
>  	p->slave = slave;
>  
> -	ret = kobject_init_and_add(&p->kobj, &port_type,
> -				   kobject_get(dev->dev_ports_parent[slave]),
> -				   "%d", port_num);
> -	if (ret)
> -		goto err_alloc;
> -
>  	p->pkey_group.name  = "pkey_idx";
>  	p->pkey_group.attrs =
>  		alloc_group_attrs(show_port_pkey,
> @@ -649,13 +643,9 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  				  dev->dev->caps.pkey_table_len[port_num]);
>  	if (!p->pkey_group.attrs) {
>  		ret = -ENOMEM;
> -		goto err_alloc;
> +		goto err_free_port;
>  	}
>  
> -	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
> -	if (ret)
> -		goto err_free_pkey;
> -
>  	p->gid_group.name  = "gid_idx";
>  	p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
>  	if (!p->gid_group.attrs) {
> @@ -663,28 +653,41 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  		goto err_free_pkey;
>  	}
>  
> +	ret = kobject_init_and_add(&p->kobj, &port_type,
> +				   kobject_get(dev->dev_ports_parent[slave]),
> +				   "%d", port_num);
> +	if (ret)
> +		goto err_put;
> +
> +	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
> +	if (ret)
> +		goto err_del;
> +
>  	ret = sysfs_create_group(&p->kobj, &p->gid_group);
>  	if (ret)
> -		goto err_free_gid;
> +		goto err_del;

You should call to sysfs_remove_group() too.

Thanks

>  
>  	ret = add_vf_smi_entries(p);
>  	if (ret)
> -		goto err_free_gid;
> +		goto err_del;
>  
>  	list_add_tail(&p->kobj.entry, &dev->pkeys.pkey_port_list[slave]);
>  	return 0;
>  
> -err_free_gid:
> -	kfree(p->gid_group.attrs[0]);
> -	kfree(p->gid_group.attrs);
> +err_del:
> +	kobject_del(&p->kobj);
> +
> +err_put:
> +	kobject_put(dev->dev_ports_parent[slave]);
> +	kobject_put(&p->kobj);
> +	return ret;
>  
>  err_free_pkey:
>  	for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
>  		kfree(p->pkey_group.attrs[i]);
>  	kfree(p->pkey_group.attrs);
>  
> -err_alloc:
> -	kobject_put(dev->dev_ports_parent[slave]);
> +err_free_port:
>  	kfree(p);
>  	return ret;
>  }
> -- 
> 2.43.0
> 

