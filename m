Return-Path: <linux-rdma+bounces-4147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1A944974
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0FF2853D9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1950A170A37;
	Thu,  1 Aug 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX5h59JE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D553BBE5;
	Thu,  1 Aug 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508636; cv=none; b=t5Y7GPmpNLWHr6Qohm6H6k0Fhgh+NlUu2tb0xESB1xw6+2znLiBhAq4VnRZzEGXaVvyLT/OhitksL6Hic9d3DWp1Y0gvdzucpCR9yOygm8cwBPEOGX5xMLZ3BHNDDb/Uga4kfuuHHuTpTEg+dWYGGUBv455PQ6Oo757bEWZVDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508636; c=relaxed/simple;
	bh=UCt5jpURNEyg0oe9cMK8/kEXK1xMb37OAQuqoadAUrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKJpmhIv2mH3Q68FC8ugRhytGIWiWb7q3nXzHH8EQAk3+Xn6/52CZIX7M8QGex8nq2yjzJVT5DFbuz/bvwicvLEXkn4xM0BYqupXK9Wias0cdkOoWVA6W+CU/H4SFrL+D6NLhl0Nmov6r3p5Q03G8jZXo6Wni7SUXbeVZuQBBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX5h59JE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8C3C4AF09;
	Thu,  1 Aug 2024 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722508636;
	bh=UCt5jpURNEyg0oe9cMK8/kEXK1xMb37OAQuqoadAUrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sX5h59JEeqq2okR7Voc6Nr1JArW+mJQD0HbII9OWvj9X7zBNjWJYTs97sHWqdzx5E
	 JodiY+ggZzJShIq2DVeD2SjAw+B4w9PZIDzTSYg7zsohkVCwf4F2CdLpaRMbfBxiU3
	 D8Rp8OWfAho4u24WVcW4f2S0OgbM0LjKtDTm5fVnIR7lSfZvRMBQeFJ11Uk6gE1kHe
	 ZuYgaVAmru1p7Bo5yFPlqnp3vTLriXbzyr6ua7sZtzzMd+zi6XSnwcgxDCyozRTZuV
	 wW+7IvAefXj8Q9gJQYJHxGNgt0yPK9H5RJTBAkagu73zjLeWwLTY8SC/bh+wipoEJE
	 5abEzGBqyY6kQ==
Date: Thu, 1 Aug 2024 13:37:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, bvanassche@acm.org, nab@risingtidesystems.com,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Message-ID: <20240801103712.GG4209@unreal>
References: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>

On Thu, Aug 01, 2024 at 03:44:15PM +0800, Junxian Huang wrote:
> Currently cancel_work_sync() is not called when srpt_refresh_port()
> failed in srpt_add_one(). There is a probability that sdev has been
> freed while the previously initiated sport->work is still running,
> leading to a UAF as the log below:
> 
> [  T880] ib_srpt MAD registration failed for hns_1-1.
> [  T880] ib_srpt srpt_add_one(hns_1) failed.
> [  T376] Unable to handle kernel paging request at virtual address 0000000000010008
> ...
> [  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
> ...
> [  T376] Call trace:
> [  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
> [  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
> [  T376]  process_one_work+0x1d8/0x4cc
> [  T376]  worker_thread+0x158/0x410
> [  T376]  kthread+0x108/0x13c
> [  T376]  ret_from_fork+0x10/0x18
> 
> Add cancel_work_sync() to the exception branch to fix this UAF.
> 
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9632afbd727b..244e5c115bf7 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -3148,8 +3148,8 @@ static int srpt_add_one(struct ib_device *device)
>  {
>  	struct srpt_device *sdev;
>  	struct srpt_port *sport;
> +	u32 i, j;
>  	int ret;
> -	u32 i;
>  
>  	pr_debug("device = %p\n", device);
>  
> @@ -3226,7 +3226,6 @@ static int srpt_add_one(struct ib_device *device)
>  		if (ret) {
>  			pr_err("MAD registration failed for %s-%d.\n",
>  			       dev_name(&sdev->device->dev), i);
> -			i--;
>  			goto err_port;
>  		}
>  	}
> @@ -3241,6 +3240,8 @@ static int srpt_add_one(struct ib_device *device)
>  	return 0;
>  
>  err_port:
> +	for (j = i, i--; j > 0; j--)a
> +		cancel_work_sync(&sdev->port[j - 1].work);

There is no need in extra variable, the following code will do the same:

	while (i--)
		cancel_work_sync(&sdev->port[i].work);

>  	srpt_unregister_mad_agent(sdev, i);
>  err_cm:
>  	if (sdev->cm_id)
> -- 
> 2.33.0
> 

