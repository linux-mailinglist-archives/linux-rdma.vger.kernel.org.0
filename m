Return-Path: <linux-rdma+bounces-1478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229887E93A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 13:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFCE7B2266F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA0381A1;
	Mon, 18 Mar 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLD8w+AY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B733438385;
	Mon, 18 Mar 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764420; cv=none; b=p2sGUj2XUHrhc+ydSuLEFzxxyUk06rXo93px9eYRqzzCk43uCbXK+QOsnYwKV5UK9HdXhTnDAn0cPlvooLAQifAc1fkglHtB4eesxcJ+qJlemqCGO36ZXJeiOMIIPnmlXd9GPOaIk+sqXGVBbWqYFWkPtAlpSDY0xfuXYpKfZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764420; c=relaxed/simple;
	bh=dTwJg1UGqWh+77kQ3HiGt4CvIU6WqC055dKN/Mu7uKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOVO9Rg+Bc08iYNhbv9NzyVXbfmggt85uZ0gJ6D2aiiwO+mzM9sBUZmaSDEAbzk2Dcz9mSL1larV4D3Vb7s7I9JLdk3kih4Lma+bbfKPTDvV5xidkuehS8bVx9WS5Ps35h5HV73lgh9hI15paCH7AV89EDJeeogJUjjemhzt49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLD8w+AY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7059C433F1;
	Mon, 18 Mar 2024 12:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764420;
	bh=dTwJg1UGqWh+77kQ3HiGt4CvIU6WqC055dKN/Mu7uKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLD8w+AY7j9y1TNGzT3oF5CpiUu5Z81E/VX1E2uVP5cOqDq/m8h8jFSLNYZ+kVAmN
	 0JSIPM7B5dpGr/KKMUlrLJdfOQjrI6ZRJYae3hCPoYuvLBrT+cFGa32ysvGFjKPiKt
	 ds0550JFsGq5VEGor5Pe387SEIx2etrxdG3MG08KJvJuTpwfBMHsTYWy3oZPfG0kMr
	 5tgQxKxmehF6G0eNNRM1smTm3ZhdV1hq4vEp0SMUFPT6WUNfsaa5asNHJm2oeq9QxJ
	 cARHMo1aJhabfSx6uhDhBzNNKRtCFzRDP6+oVBHiKnH0MeHQQbLfB5BSkNiaLYC7lL
	 wD9Y9nG0pXDPQ==
Date: Mon, 18 Mar 2024 14:20:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240318122016.GA4341@unreal>
References: <20240318100858.3696961-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318100858.3696961-1-leitao@debian.org>

On Mon, Mar 18, 2024 at 03:08:57AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct hfi1_netdev_rx by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at hfi1_alloc_rx().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> v2:
> 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
> 	* Pass zero as the private size for alloc_netdev().
> 	* Remove wrong reference for iwl in the comments
> 
> v3:
> 	* Re-worded the comment, by removing the first paragraph.

Please put changelog below "---" marker.
It doesn't belong to commit message.

Thanks

> ---
>  drivers/infiniband/hw/hfi1/netdev.h    |  2 +-
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
> index 8aa074670a9c..07c8f77c9181 100644
> --- a/drivers/infiniband/hw/hfi1/netdev.h
> +++ b/drivers/infiniband/hw/hfi1/netdev.h
> @@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
>   *		When 0 receive queues will be freed.
>   */
>  struct hfi1_netdev_rx {
> -	struct net_device rx_napi;
> +	struct net_device *rx_napi;
>  	struct hfi1_devdata *dd;
>  	struct hfi1_netdev_rxq *rxq;
>  	int num_rx_q;
> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> index 720d4c85c9c9..cd6e78e257ef 100644
> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> @@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
>  	int i;
>  	int rc;
>  	struct hfi1_devdata *dd = rx->dd;
> -	struct net_device *dev = &rx->rx_napi;
> +	struct net_device *dev = rx->rx_napi;
>  
>  	rx->num_rx_q = dd->num_netdev_contexts;
>  	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
> @@ -360,7 +360,12 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
>  	if (!rx)
>  		return -ENOMEM;
>  	rx->dd = dd;
> -	init_dummy_netdev(&rx->rx_napi);
> +	rx->rx_napi = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
> +				   init_dummy_netdev);
> +	if (!rx->rx_napi) {
> +		kfree(rx);
> +		return -ENOMEM;
> +	}
>  
>  	xa_init(&rx->dev_tbl);
>  	atomic_set(&rx->enabled, 0);
> @@ -374,6 +379,7 @@ void hfi1_free_rx(struct hfi1_devdata *dd)
>  {
>  	if (dd->netdev_rx) {
>  		dd_dev_info(dd, "hfi1 rx freed\n");
> +		free_netdev(dd->netdev_rx->rx_napi);
>  		kfree(dd->netdev_rx);
>  		dd->netdev_rx = NULL;
>  	}
> -- 
> 2.43.0
> 

