Return-Path: <linux-rdma+bounces-12627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171E0B1DDAA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 21:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C17620074
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D82116E9;
	Thu,  7 Aug 2025 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd6i9/EN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252254A06;
	Thu,  7 Aug 2025 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596043; cv=none; b=cVS8kF3YKdBRcuZChqZHcV/kKDc2qfPoyZuLy/kfmGQn/fWu6AVqYe/EiG7UBAv759wsXmJrZoUoxGCLvVM/qEIwW0Ry5sH34HVt8OnD05M0oJCZE06J1xqBopWgMUh+r9EhDEPEXN3MFRqBVlI7fZkhUvF7/obc1yErHtUCKPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596043; c=relaxed/simple;
	bh=JFuIJpdm0AMR0xv4NMaojaLmRYEny8W2asXb8REMVRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSw6XayaA3d2qPKaYSwYBp234SklEz+7fKgWYTrcx2r1UKJ+LfYGqbLt5U8GNNWiXQKIqgfhm9UmiJGNn/KDQIKMtOQ+6MGC28kknVlpezMkF34U5glYsIvOW/xR4EPI30xQ0dkiQARtT42lkffkfzhIfp/NQi4E8ZipUBXtXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd6i9/EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74954C4CEEB;
	Thu,  7 Aug 2025 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596042;
	bh=JFuIJpdm0AMR0xv4NMaojaLmRYEny8W2asXb8REMVRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sd6i9/EN2gOj6JBJ+lYg3Tr0F8+7VpqW8Nc9nqDBmhtP5G7SpfHhJc3zXUznFwEzA
	 8eUo+1eTGYv0l4oXsC3yhuM+UCVjK4LN268n7r73jkDLwkuAk6uO6OnXIZgP3STcI1
	 52MTLTKkZcVFruYaQCFz/eTtuTfdamgOztb4WEb8cna0YeZRhBa0UclGOXJQwF3P+x
	 ZogM+fzJU6OvQZ911dM4hdx/1HOPjZVgsOntaf3PQT+b8xxfQFoH1zjv3PhXuXEj7s
	 ngCIy9aJTWtzte03OFhHzvcwFw2yYgpSHYl+8eXKxamxJGfDs89t/kOuac6zrh9Rx6
	 q7/PgvM6ttOZg==
Date: Thu, 7 Aug 2025 20:47:15 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 10/17] net/dibs: Define dibs_client_ops and
 dibs_dev_ops
Message-ID: <20250807194715.GP61519@horms.kernel.org>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-11-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806154122.3413330-11-wintera@linux.ibm.com>

On Wed, Aug 06, 2025 at 05:41:15PM +0200, Alexandra Winter wrote:

...

> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c

...

> -static void smcd_register_dev(struct ism_dev *ism)
> +static void smcd_register_dev(struct dibs_dev *dibs)
>  {
> -	const struct smcd_ops *ops = ism_get_smcd_ops();
>  	struct smcd_dev *smcd, *fentry;
> +	const struct smcd_ops *ops;
> +	struct smc_lo_dev *smc_lo;
> +	struct ism_dev *ism;
>  
> -	if (!ops)
> -		return;
> +	if (smc_ism_is_loopback(dibs)) {
> +		if (smc_loopback_init(&smc_lo))
> +			return;
> +	}
>  
> -	smcd = smcd_alloc_dev(&ism->pdev->dev, dev_name(&ism->pdev->dev), ops,
> -			      ISM_NR_DMBS);
> +	if (smc_ism_is_loopback(dibs)) {
> +		ops = smc_lo_get_smcd_ops();
> +		smcd = smcd_alloc_dev(dev_name(&smc_lo->dev), ops,
> +				      SMC_LO_MAX_DMBS);
> +	} else {
> +		ism = dibs->drv_priv;
> +		ops = ism_get_smcd_ops();
> +		smcd = smcd_alloc_dev(dev_name(&ism->pdev->dev), ops,
> +				      ISM_NR_DMBS);
> +	}

Hi Alexandra,

ism is initialised conditionally here.

But towards the end of this function the following dereferences
ism unconditionally. And it's not clear to me this won't occur
even if ism wasn't initialised above.

        if (smc_pnet_is_pnetid_set(smcd->pnetid))
                pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
                                    dev_name(&ism->dev), smcd->pnetid,
                                    smcd->pnetid_by_user ?
                                        " (user defined)" :
                                        "");
        else
                pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
                                    dev_name(&ism->dev));


>  	if (!smcd)
>  		return;
> -	smcd->priv = ism;
> +
> +	smcd->dibs = dibs;
> +	dibs_set_priv(dibs, &smc_dibs_client, smcd);
> +
> +	if (smc_ism_is_loopback(dibs)) {
> +		smcd->priv = smc_lo;
> +		smc_lo->smcd = smcd;
> +	} else {
> +		smcd->priv = ism;
> +		ism_set_priv(ism, &smc_ism_client, smcd);

This function is now compiled even if CONFIG_ISM is not enabled.
But smc_ism_client is only defined if CONFIG_ISM is enabled.

I think this code is removed by later patches. But nonetheless
I also think this leads to a build error and it's best
to avoid transient build errors as they break bisection.

> +		if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
> +			smc_pnetid_by_table_smcd(smcd);
> +	}
> +
>  	smcd->client = &smc_ism_client;

Ditto.

> -	ism_set_priv(ism, &smc_ism_client, smcd);
> -	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
> -		smc_pnetid_by_table_smcd(smcd);
>  
>  	if (smcd->ops->supports_v2())
>  		smc_ism_set_v2_capable();

...

