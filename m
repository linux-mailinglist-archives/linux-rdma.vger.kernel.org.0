Return-Path: <linux-rdma+bounces-4631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4239641E2
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 12:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652E91F22877
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED841917F4;
	Thu, 29 Aug 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT0MBt47"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCF18C002;
	Thu, 29 Aug 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927070; cv=none; b=pKI+plfyQq3hdU79XlNVr1eX9J+FNVl0hD+0+DcEIgYfgxvWTq6pmelPEwZkD3B1EuN8Cp857rxs4V0Zac1WWzIIMlTy3KQ8UHwd0+BuNRqYl0WpiHvPtmeV2nqBUodkc//9Za6qSU57dF2i0/XgsAMpwfWzCGO3dFabpWAFTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927070; c=relaxed/simple;
	bh=KFzZ7tzLmYuzSz+hkkc2eI64IphWnGj6Q8jk+FPw+o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S76g1dsLuAZhja5uQSqRKPdIiCXWYiQPvz+q27Wf6ADENC1ePNEhwSTSNimyIyyEJlDyVWae7XcJGAAiGo+8NGTvVKMvXTC4zX7qJxx4UI9k7eU5jIeQufKTu2IQmLDNs46MLBjiwmEd+zEUG/4YAYKptYq6uY1khwTN6ORGhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT0MBt47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB496C4CEC1;
	Thu, 29 Aug 2024 10:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724927069;
	bh=KFzZ7tzLmYuzSz+hkkc2eI64IphWnGj6Q8jk+FPw+o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dT0MBt47DKts1mzBujAxSixJIsNsWkvGiWxMj8DYMx+4xwQqeks46qt3nztV9Ms16
	 RhFfKe4eJ/WVXwVrV3xb70fgUPw8gl+Hy3fNKe2om7CCpUjd4NkmvFveYI0XBiYTTI
	 M6+NLKndA27mXNbDs6KzbUZXb0ulq6sEHWGKFQfjGf7QilC1KJKzcrHJhG6GNeHQTn
	 xmsdsvYWfuINdOEH+6QsHFtid5ituC0dAXtuWROtc6nU+O+4lNT3RtFzsbh6poYbTS
	 m6mADEY7ZgzN1c8CtyLAPxtdZcYwSOo1lLKiJmDtG3fJ7T0DqhhiGVMG11LSuxAvL3
	 b4cjs2c65xx8w==
Date: Thu, 29 Aug 2024 13:24:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: longli@microsoft.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] RDMA/mana_ib: fix a bug in calculating the wrong
 page table index when 64kb page table is used
Message-ID: <20240829102425.GD26654@unreal>
References: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724875569-12912-1-git-send-email-longli@linuxonhyperv.com>

On Wed, Aug 28, 2024 at 01:06:08PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> MANA hardware uses 4k page size. When calculating the page table index,
> it should use the hardware page size, not the system page size.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

These two patches are RDMA ones, please fix the target tree, rephrase
the commit title to simplify it and resend.

Thanks

> 
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index d13abc954d2a..f68f54aea820 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -383,7 +383,7 @@ static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
>  
>  	create_req->length = umem->length;
>  	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
> -	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
> +	create_req->gdma_page_type = order_base_2(page_sz) - MANA_PAGE_SHIFT;
>  	create_req->page_count = num_pages_total;
>  
>  	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu num_pages_total %lu\n",
> -- 
> 2.17.1
> 

