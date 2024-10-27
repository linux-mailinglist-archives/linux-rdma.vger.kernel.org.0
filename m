Return-Path: <linux-rdma+bounces-5561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D329B2040
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 21:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C25D281E47
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2024 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BE17B402;
	Sun, 27 Oct 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHc9HfOA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8217736;
	Sun, 27 Oct 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060343; cv=none; b=M0u8bqTLAIFQBjd4XL4EY7LWUJhvGrzUiS5ytwH+vbSmqZSr/1xLC0WeFGY/y25u2qLtF8ABuV6pUBmqkCGuaXTHvCZuij/xqnyPCmhFCoZYY4jJr57XO/cJP1xv87uHYx+Rr0C2ugIJ4WeKr7foOk8JwgY914fNogGIx6xAgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060343; c=relaxed/simple;
	bh=MUO/ObV4MO9h5PMiXt7X4ls+zqlb/vxayMS9rIw04FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP7JD141Stla6T+Ewwgcjl4OAmx+kP3QsM/kNtKtc0NHCzyXR2WwAoZNOuyPHOikUvS4kha7PM1EkCz58zj792SEQ7iUmIQacjGyvbC9fh3fVdMyEau+/orqfWmgPUQDDr8JaP5qSVXPRuaBRJ/VhgnZRUmc4c8BkrXt1J8f+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHc9HfOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEF7C4CEC3;
	Sun, 27 Oct 2024 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730060342;
	bh=MUO/ObV4MO9h5PMiXt7X4ls+zqlb/vxayMS9rIw04FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHc9HfOAbzHohd+W78RVfcfiLAdF9jZZtvBiypuB7RnczGdhZSdYk7JXxnAXumSmk
	 W8Zo/1rHxY1Q0l1tIQQ6sfk89k3+aAG5PjMPJKTOKs7X/61ixG5Yxrs/TLMF9oXTCO
	 bxyV+w/DXCS7EUFB4Ce2WpqBvGs6QILStquzQOqZS3CZFjrtJZ49ZQ8dLOC5IIL/Zl
	 aWpUA0APaGQIkY2oAXuQPhkXf4m0VBQRIz4pkeVFbijgjsstm3VyLkqelFJa2i2Px3
	 9kg6M3NGKsbIZkdEYeavNcD9HrI/YInTCsADI2rthGs6dGoR6/hz+QnKSuSfLWned2
	 qloyQTrw5dgIA==
Date: Sun, 27 Oct 2024 22:18:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241027201857.GA1615717@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>

On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:
> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. 

I would say that calls to ibdev ops from ULPs was never been right
thing to do. The ib_device_set_netdev() was introduced for the drivers.

So the whole commit message is not accurate and better to be rewritten.

> As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver.

It is not a correct statement too. All modern drivers (for last 5 years)
don't have that .get_netdev() ops, so it is not mlx5 specific, but another
justification to say that SMC-R was doing it wrong.

> Thus, using ib_device_set_netdev() now became mandatory.

ib_device_set_netdev() is mandatory for the drivers, it is nothing to do
with ULPs.

> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().

It is too late for me to do proper review for today, but I would say
that it is worth to pay attention to multiple dev_put() calls in the
functions around the ib_device_get_netdev().

> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")

It is not related to this change Fixes line.

> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  net/smc/smc_ib.c   | 8 ++------
>  net/smc/smc_pnet.c | 4 +---
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 9297dc20bfe2..9c563cdbea90 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
>  	struct ib_device *ibdev = smcibdev->ibdev;
>  	struct net_device *ndev;
>  
> -	if (!ibdev->ops.get_netdev)
> -		return;
> -	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
> +	ndev = ib_device_get_netdev(ibdev, port + 1);
>  	if (ndev) {
>  		smcibdev->ndev_ifidx[port] = ndev->ifindex;
>  		dev_put(ndev);
> @@ -921,9 +919,7 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
>  		port_cnt = smcibdev->ibdev->phys_port_cnt;
>  		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
>  			libdev = smcibdev->ibdev;
> -			if (!libdev->ops.get_netdev)
> -				continue;
> -			lndev = libdev->ops.get_netdev(libdev, i + 1);
> +			lndev = ib_device_get_netdev(libdev, i + 1);
>  			dev_put(lndev);
>  			if (lndev != ndev)
>  				continue;
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 1dd362326c0a..8566937c8903 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -1054,9 +1054,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
>  		for (i = 1; i <= SMC_MAX_PORTS; i++) {
>  			if (!rdma_is_port_valid(ibdev->ibdev, i))
>  				continue;
> -			if (!ibdev->ibdev->ops.get_netdev)
> -				continue;
> -			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
> +			ndev = ib_device_get_netdev(ibdev->ibdev, i);
>  			if (!ndev)
>  				continue;
>  			dev_put(ndev);
> -- 
> 2.43.0
> 
> 

