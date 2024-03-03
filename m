Return-Path: <linux-rdma+bounces-1192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F4386F4E8
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 13:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29911F21CB7
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Mar 2024 12:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27DBE6B;
	Sun,  3 Mar 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMXJ7i86"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4928E7;
	Sun,  3 Mar 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470662; cv=none; b=iLBtp7RMjpqghrAk3krp2cq2Heouf76oBSkOTXhic8ewToxHfWBtvhp5gVa4zEYs5vQdq+5MLLmEAnwijqedKhWH/srOpksuWvGwwFvZ5sJwPj5Ccb2WMAAkp2p5Ik0m3dM5OW3DKqL3HAlRb4sF3nfxfID/gGBFWj00D+sdTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470662; c=relaxed/simple;
	bh=4ch5aMF3KIky3EvroYwtOum5t1jE63gLQZEJ509AYzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daHiCzEileCc0MEA5lsxyAP9LYtzC9Lvud2pgVLnvlNVF4JfOBe7xNH1uqb4DkznXOAyTkZPQ19H8vbKqUz8DMur4LSqpdoppnKapXrhCKXE1UQFwoFUi+C9NhmKfmTT+LCwXH/AhHx2EtDy5G0K8kfAOvwoEQYlOQNPCJk96uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMXJ7i86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A27C433C7;
	Sun,  3 Mar 2024 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709470662;
	bh=4ch5aMF3KIky3EvroYwtOum5t1jE63gLQZEJ509AYzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMXJ7i86uTVPjCDa/06YKBiPyBc+9L0b2PktC0RdAo1btyVBO7MHBEQzlxSPKALNc
	 OIT+9gcE//pT/oH2FTm2l42YUA+J2/t4L6v0XhnBWeJIpKB0mp47bcv1+SuE7PWP+/
	 3PPDBqyrZQiIbA/c83B33EAHdJUzQ7MWoIrh8QADscA3+VpyV84ojV2xYTEq4mGn0b
	 cMhEdOiih1QScHPg/TOXuxK60EYbhJRVO0s7/k4pKNlWhmvRBJqxskrnQtnd3YDzGs
	 gzIfOtBiAHSsLLmNneEuvEkKuFBF+MBf3sA/yALf3mCXn4jlMSG/eSqRV861dtyTp7
	 PqsF+LDKcsAkg==
Date: Sun, 3 Mar 2024 14:57:37 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Fix potential invalid address access
Message-ID: <20240303125737.GB112581@unreal>
References: <20240301095514.3598280-1-haowenchao2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301095514.3598280-1-haowenchao2@huawei.com>

On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
> struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
> in ib_create_cq(), while if the module exited but forgot del this
> rdma_restrack_entry, it would cause a invalid address access in
> rdma_restrack_clean() when print the owner of this rdma_restrack_entry.

How is it possible to exit owner module without cleaning the resources?

Thanks

> 
> Fix this issue by using kstrdup() to set rdma_restrack_entry's
> kern_name.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  drivers/infiniband/core/restrack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 01a499a8b88d..6605011c4edc 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -177,7 +177,8 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
>  void rdma_restrack_set_name(struct rdma_restrack_entry *res, const char *caller)
>  {
>  	if (caller) {
> -		res->kern_name = caller;
> +		kfree(res->kern_name);
> +		res->kern_name = kstrdup(caller, GFP_KERNEL);
>  		return;
>  	}
>  
> @@ -195,7 +196,7 @@ void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
>  			       const struct rdma_restrack_entry *parent)
>  {
>  	if (rdma_is_kernel_res(parent))
> -		dst->kern_name = parent->kern_name;
> +		dst->kern_name = kstrdup(parent->kern_name, GFP_KERNEL);
>  	else
>  		rdma_restrack_attach_task(dst, parent->task);
>  }
> @@ -306,6 +307,7 @@ static void restrack_release(struct kref *kref)
>  		put_task_struct(res->task);
>  		res->task = NULL;
>  	}
> +	kfree(res->kern_name);
>  	complete(&res->comp);
>  }
>  
> -- 
> 2.32.0
> 

