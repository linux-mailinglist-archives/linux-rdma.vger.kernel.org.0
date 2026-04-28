Return-Path: <linux-rdma+bounces-19662-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N5kFIjf8GmaagEAu9opvQ
	(envelope-from <linux-rdma+bounces-19662-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:25:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB67488D4C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F45831664AE
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A5547D94F;
	Tue, 28 Apr 2026 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NwnZN8cS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7044B694
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392385; cv=none; b=A6xoZ/KebmL96OiQeeQNByNyCSqxQPJUo02jhuX9DSVwrNpQSwJel3bxG6wYzXS0gONmgy6GVvJcHnYBnTGorvTg+LiByiueWVJNH+xJMfX5+LdNxyDAWASDmELpBqcH0VfE8Dt5bqEM9QL/+uu8DVvG0fc+MinDFN+xuJI7PGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392385; c=relaxed/simple;
	bh=6DKe+rDUv8PNTmDtNK0+PcDeStcbUVZSpaSAcNp6gCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHjQp2QxW5JHQHjkfT2oXi0zJ3wB9qfI/+JFqmdal+40rk9VDAb/smt3SGfHIiO2VGcV6nf6Bz9mLLqoWRtU+FKMYFAtAdyHoDjRO7LqIzCqwAqU1SLyvKwI6KhxrPW3Asqq5q1094SXyqNK6ZMCFEHro0Y6BBDOWNen19GlH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NwnZN8cS; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47c35be02fdso217709b6e.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777392381; x=1777997181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qpi+ZEPIeo8vz/y7CHMSuNMgCTG3NtxefpttRhwmn6o=;
        b=NwnZN8cS+ZjXgO+6qaFuzSrGk58B9ynTEnFf7gSx6266VpKbt1JQziREs5MXyFW9f4
         1+KRLhTj8gVnp6SBschgUB/RXy3QcZLXdM93+EbBMcSv0zreyisXb6NXOeSa+MMsEThI
         J0hnTqDKRXW9cAu0ejcgzLHf1wObBaV3N/vXXiKinc5RqakG5IS9crC8JkyeUV7CZHqw
         s9skfTf9+ck88I49J4oShf6BplUj3Us+RvqgdpMOAsUxuErOZOqjl5D7tutyHUpLJ/es
         3bk1OAeYUJaxQSzJv5WgRIjWoMhK93PSKPiD1egeR1qxO8YzGAtlTxXI2Ww1JJFLsZ/F
         +J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392381; x=1777997181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qpi+ZEPIeo8vz/y7CHMSuNMgCTG3NtxefpttRhwmn6o=;
        b=HkJyf4cjVynT6s5T++gq7xP1RL9bKAuHlVSI3E/Gs6x/j4dmBm1/YEuAHxhcpRqVIf
         iFh1FIYZyW+5Z0Gg7OkfVwQP5o5jUIifq7dtUw50zhkZjLNQskefaLfHwptp+je63w6X
         TGnvRQYFyGsPL24gOkr6BnJB70bt7TJbQcyEBdYyC97e2caZ8c2CD7AlrvQJQ8LIvDEa
         7nvsoL2suPkItLX2sHWTh00SxsK5Ws2xoXZvr1anQBFjgo4rYwriPSkZrGMTMPz96FMy
         o8wZvbF5srFNDKj5aQBEpxoYCyiV58d9bFHqWqFncr05ftvix/iqqy0X1g/8dCZHa+6N
         6Afw==
X-Forwarded-Encrypted: i=1; AFNElJ8Mhry7NIjmZeSilV+XZbjSTesrlDEp50vFXAnhYAUi3cc2KqHqmdidXY72FZbFVHYJl0zG6Xp9ehdm@vger.kernel.org
X-Gm-Message-State: AOJu0YzWalA1h2GwnHImkf2sNgL037XJDfO9+cnyf8MmRdNwhsaP44sx
	y6v4lVoUJYOreZP5blqy/xzfY6gKQ2M/rvsNq5GCQnRs7YWqI6+sSTMZWl4rvBBeqAA=
X-Gm-Gg: AeBDiesWG8J6WXxHrFDPPjBqnQEOTeqaqDrIGBjiBsq8cwarFxYWDZHcpcTQ8JUpx4b
	AmFvMMItowwuvi+RZ/0aKNieui/GYMS2Fr+uY6gmNy2LMHJqGSshrvvLDzwoS421EF5PTpLuujq
	D074qIW2WFdNAGr/S3TZOp+B+NVFh7lwiqmvjLCpEKMjY2n9p/WsH++dbsqyhOjvLIrWAxn3ry+
	MT18UAygsA3aTJy7bbVavp7BVz/gEOEmeOgY6R4+E5uQenJ/hLQJ7pa7tVl4yoXm+3C9bEfXiwq
	C7Xfpd8kPQLU+IB0D48w7Bw4aHlDNpNbS30ddMK6980a7HX7gEwIoUkf335J1LYxovanz66qjhI
	0tBlqbXwgfnj3yQGEyTGR4xVaRZZF4/rBeFgQZlDKflpmxs328lzh9k6TGtoCEGttb5V1FrDPxE
	+Q9MF2yqDAcnd3ay1/qxyKv7QxXzmNDn+Owi6g2v+uGrVbi4MhfOy553e8GfO5KiAQeZIYsB279
	BxWAf+NMGrg6D/b
X-Received: by 2002:a05:6808:181d:b0:464:5f3:ed1 with SMTP id 5614622812f47-47c28fc8fbdmr1928457b6e.26.1777392381147;
        Tue, 28 Apr 2026 09:06:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c7cd2c97sm212640085a.23.2026.04.28.09.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:06:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHkx1-0000000Bgu8-31g1;
	Tue, 28 Apr 2026 13:06:19 -0300
Date: Tue, 28 Apr 2026 13:06:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] IB/mlx4: Fix refcount leak in add_port() error path
Message-ID: <20260428160619.GJ849557@ziepe.ca>
References: <20260428154716.375069-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428154716.375069-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: BCB67488D4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-19662-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]

On Tue, Apr 28, 2026 at 11:47:16PM +0800, Guangshuo Li wrote:
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
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fix this by using kobject_put(&p->kobj) in the kobject_init_and_add()
> failure path.
> 
> Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - make mlx4_port_release() tolerate NULL attribute arrays
>   - drop the parent kobject reference on the kobject_init_and_add()
>     failure path before putting the embedded kobject
> 
> v2:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
> 
>  drivers/infiniband/hw/mlx4/sysfs.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
> index b8fa4ecfc961..38c64b5fb23a 100644
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
>  	kfree(p);
>  }
>  
> @@ -640,7 +645,7 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  				   kobject_get(dev->dev_ports_parent[slave]),
>  				   "%d", port_num);
>  	if (ret)
> -		goto err_alloc;
> +		goto err_kobj;
>  
>  	p->pkey_group.name  = "pkey_idx";
>  	p->pkey_group.attrs =
> @@ -687,6 +692,12 @@ static int add_port(struct mlx4_ib_dev *dev, int port_num, int slave)
>  	kobject_put(dev->dev_ports_parent[slave]);
>  	kfree(p);
>  	return ret;
> +
> +err_kobj:
> +	kobject_put(dev->dev_ports_parent[slave]);
> +	kobject_put(&p->kobj);
> +	return ret;
> +

Do not put double returns in goto-unwinds..

This should be fixed to open code the kobject_init() immediately after
the memory allocation so we never switch between kfree and put, and fix
all the release functions to tolerate half initialized objects.

Then you can remove the mess of kfrees which are all duplicated in the
release function.

Jason

