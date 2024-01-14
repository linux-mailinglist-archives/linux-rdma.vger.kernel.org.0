Return-Path: <linux-rdma+bounces-628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2982D015
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jan 2024 10:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B312B21572
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jan 2024 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CED1C17;
	Sun, 14 Jan 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7EWKLgM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33F1877;
	Sun, 14 Jan 2024 09:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B730C433C7;
	Sun, 14 Jan 2024 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705223078;
	bh=w8Q0P/nO1Ttc/jNJcZgeZODT8KyoJPF9QBejXOikut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7EWKLgMbXgzxklZqkuzw+TeEMRjd+A+JEH8lP/fUD3uhLULsjEiDTEkGfnBZBNFI
	 GSmcjhP+L1Im8eVvyQJf15TDwRvYKCYpC88LV9AwimlyreoeAH2EDCcHs/wSL015FZ
	 uwOhTVckNmqz+MxIYpKj5GhVeHBE6h+4AjpuAPcKXUG8w6YGFjW6372qjp/EtoPRZU
	 giMFwbFzgmh7zxzITNIFzXv9gh59ZuIr2EB1UiDEKE6e87bnw0HwWJ1JgoOZHPD78R
	 x0gx2B81yDhqTh6R6N/gdHYNA/odqGQD9+L2bwyjgeKAKeSGNgH8ZIy8g6JbPW9hTl
	 iy+FJ1ly1I8kA==
Date: Sun, 14 Jan 2024 11:04:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jubin John <jubin.john@intel.com>,
	Mitko Haralanov <mitko.haralanov@intel.com>,
	Ravi Krishnaswamy <ravi.krishnaswamy@intel.com>,
	Harish Chegondi <harish.chegondi@intel.com>,
	Brendan Cunningham <brendan.cunningham@intel.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: fix a memleak in init_credit_return
Message-ID: <20240114090434.GD6404@unreal>
References: <20240112085523.3731720-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112085523.3731720-1-alexious@zju.edu.cn>

On Fri, Jan 12, 2024 at 04:55:23PM +0800, Zhipeng Lu wrote:
> When dma_alloc_coherent fails to allocate dd->cr_base[i].va,
> init_credit_return should deallocate dd->cr_base and
> dd->cr_base[i] that allocated before. Or those resources
> would be never freed and a memleak is triggered.
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/infiniband/hw/hfi1/pio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
> index 68c621ff59d0..5a91cbda4aee 100644
> --- a/drivers/infiniband/hw/hfi1/pio.c
> +++ b/drivers/infiniband/hw/hfi1/pio.c
> @@ -2086,7 +2086,7 @@ int init_credit_return(struct hfi1_devdata *dd)
>  				   "Unable to allocate credit return DMA range for NUMA %d\n",
>  				   i);
>  			ret = -ENOMEM;
> -			goto done;
> +			goto free_cr_base;
>  		}
>  	}
>  	set_dev_node(&dd->pcidev->dev, dd->node);
> @@ -2094,6 +2094,10 @@ int init_credit_return(struct hfi1_devdata *dd)
>  	ret = 0;
>  done:
>  	return ret;
> +
> +free_cr_base:
> +	free_credit_return(dd);

Dennis,

The idea of this patch is right, but it made me wonder, if
free_credit_return() is correct.

init_credit_return() iterates with help of for_each_node_with_cpus():

  2062 int init_credit_return(struct hfi1_devdata *dd)
  2063 {
...
  2075         for_each_node_with_cpus(i) {
  2076                 int bytes = TXE_NUM_CONTEXTS * sizeof(struct credit_return);
  2077

But free_credit_return uses something else:
  2099 void free_credit_return(struct hfi1_devdata *dd)
  2100 {
...
  2105         for (i = 0; i < node_affinity.num_possible_nodes; i++) {
  2106                 if (dd->cr_base[i].va) {

Thanks

> +	goto done;
>  }
>  
>  void free_credit_return(struct hfi1_devdata *dd)
> -- 
> 2.34.1
> 

