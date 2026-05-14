Return-Path: <linux-rdma+bounces-20664-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C2gHnp1BWrAXQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20664-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:10:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7A53EBF8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5066D301CCDB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 07:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820953D75BF;
	Thu, 14 May 2026 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thUzSv0l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454B3B8409;
	Thu, 14 May 2026 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742644; cv=none; b=AK947ekrmLcCOyociAzPyhUqUtXwV5qoTAj6vi1a1B4wIuNsPmeg5t/1evVF9Z4rmlD20REjdaKVysG6a08WOgcKNFlakwSpW7/uAeqVyDtMoA87bCwCO1PYsaBuS/Xi25FhBOj4WalYbSvMa0zA8Y26nudGqI4EBhYixKjXy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742644; c=relaxed/simple;
	bh=/onyqhZTwWhweuH0OcNfpgtMkchH6RqfxHmPE0o+ZBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucUddFACYADhtg3R9rjQtrdEh6izeFIRPNzX4TuDqIFd+987JVdpj3BMo1kDCed5BH2LvMD/dRyJ1ZeAnqs28HcHeTQNlCdWxPi9oBtW63bCUw7JSb3gKGuauQW33Kb5Ae/KFlqGtHvW0KLPHxVJDhrRLp7HFQz8WMWZMLPRA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thUzSv0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28737C2BCC6;
	Thu, 14 May 2026 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742644;
	bh=/onyqhZTwWhweuH0OcNfpgtMkchH6RqfxHmPE0o+ZBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thUzSv0li2+mKPpcm7ww64BZRfN9Tf3YEeuRT5nGmj90QfVq983Soln2WL3BN3bhN
	 Yz4bJRCOw9dM6jdn2OVLzgZ4sJU9ibusJabcWsZ6MhS2k7xY7ccYhBlMTg5p7pAvyC
	 AnCVK4tajK4xF66pBzpMRNjobcj4a2V0joBCdYYL7CGBfQcFGVBNqHoyJaDTzNcKu9
	 c/I7bccjm/DZXFTGzws68200l8NQCSm7QaMvULIEVez+l/8AYEWluceOzM13VaZjfD
	 R9N7h8q7/aTNRXkh3T/8cZWZq+lujdTW2s95pRMNhJvq2awDvc+yApun3xePfPyzAz
	 twRixZUQ7vrGQ==
Date: Thu, 14 May 2026 10:10:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Roland Dreier <roland@purestorage.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] IB/mlx4: Fix refcount leak in add_port() error path
Message-ID: <20260514071038.GM15586@unreal>
References: <20260511121649.770529-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511121649.770529-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: 20E7A53EBF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20664-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 08:16:49PM +0800, Guangshuo Li wrote:
> After kobject_init_and_add(), the lifetime of the embedded struct
> kobject is expected to be managed through the kobject core reference
> counting.
> 
> In add_port(), several failure paths after kobject_init_and_add() free
> struct mlx4_port directly instead of releasing the embedded kobject with
> kobject_put(). This leaves the kobject reference count unbalanced and can
> lead to incorrect lifetime handling.
> 
> Fix this by routing the kobject_init_and_add() failure path through
> kobject_put(), and by calling kobject_del() before kobject_put() on
> later failure paths after the kobject has been successfully added. Since
> the release callback may now be called for partially initialized
> mlx4_port objects, make mlx4_port_release() tolerate NULL attribute
> arrays.
> 
> The duplicated attribute array frees in add_port() are removed, as the
> release callback now handles them.
> 
> Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> Cc: stable@vger.kernel.org

This line is not needed.

> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
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
>  drivers/infiniband/hw/mlx4/sysfs.c | 44 ++++++++++++++----------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> index b8fa4ecfc961..224a6a1c289d 100644
> --- a/drivers/infiniband/hw/mlx4/sysfs.c
> +++ b/drivers/infiniband/hw/mlx4/sysfs.c
> @@ -380,12 +380,17 @@ static void mlx4_port_release(struct kobject *kobj)
>  	struct attribute *a;
>  	int i;
>  
> -	for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
> -		kfree(a);
> -	kfree(p->pkey_group.attrs);
> -	for (i = 0; (a = p->gid_group.attrs[i]); ++i)
> -		kfree(a);
> -	kfree(p->gid_group.attrs);
> +	if (p->pkey_group.attrs) {
> +		for (i = 0; (a = p->pkey_group.attrs[i]); ++i)
> +			kfree(a);
> +		kfree(p->pkey_group.attrs);
> +	}
> +
> +	if (p->gid_group.attrs) {
> +		for (i = 0; (a = p->gid_group.attrs[i]); ++i)
> +			kfree(a);
> +		kfree(p->gid_group.attrs);
> +	}

You should reorder the add_port() function to make sure that
kobject_init_and_add() is called after alloc_group_attrs().

Thanks

>  	kfree(p);
>  }
>  
> @@ -623,7 +628,6 @@ static void remove_vf_smi_entries(struct mlx4_port *p)
>  static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  {
>  	struct mlx4_port *p;
> -	int i;
>  	int ret;
>  	int is_eth = rdma_port_get_link_layer(&dev->ib_dev, port_num) ==
>  			IB_LINK_LAYER_ETHERNET;
> @@ -640,7 +644,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  				   kobject_get(dev->dev_ports_parent[slave]),
>  				   "%d", port_num);
>  	if (ret)
> -		goto err_alloc;
> +		goto err_put;
>  
>  	p->pkey_group.name  = "pkey_idx";
>  	p->pkey_group.attrs =
> @@ -649,43 +653,37 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  				  dev->dev->caps.pkey_table_len[port_num]);
>  	if (!p->pkey_group.attrs) {
>  		ret = -ENOMEM;
> -		goto err_alloc;
> +		goto err_del;
>  	}
>  
>  	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
>  	if (ret)
> -		goto err_free_pkey;
> +		goto err_del;
>  
>  	p->gid_group.name  = "gid_idx";
>  	p->gid_group.attrs = alloc_group_attrs(show_port_gid_idx, NULL, 1);
>  	if (!p->gid_group.attrs) {
>  		ret = -ENOMEM;
> -		goto err_free_pkey;
> +		goto err_del;
>  	}
>  
>  	ret = sysfs_create_group(&p->kobj, &p->gid_group);
>  	if (ret)
> -		goto err_free_gid;
> +		goto err_del;
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
> -
> -err_free_pkey:
> -	for (i = 0; i < dev->dev->caps.pkey_table_len[port_num]; ++i)
> -		kfree(p->pkey_group.attrs[i]);
> -	kfree(p->pkey_group.attrs);
> +err_del:
> +	kobject_del(&p->kobj);
>  
> -err_alloc:
> +err_put:
>  	kobject_put(dev->dev_ports_parent[slave]);
> -	kfree(p);
> +	kobject_put(&p->kobj);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 

