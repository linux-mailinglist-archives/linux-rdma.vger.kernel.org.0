Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45325AA8B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBLvY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 07:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBLvX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 07:51:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E79920758;
        Wed,  2 Sep 2020 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599047483;
        bh=42DT5BibUxkx8rDVjt0hGlFi5FWE22JnMnd7cERBBEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cvYMdpVNjC6oE0wjUh5QktMn3IAIUoBPifVMOXkGsRT622dzRsuORWlIQ1lC1685
         ilxoNiHBFTOLh51PPhpOI2vAbxF9z0VYW3yQOBzhjJlPqiOQmTorR7W3jRPQUfUrtE
         EJAnDu+v2TyE7Sd6QnUJldBQO4ADosdSsBir+YIo=
Date:   Wed, 2 Sep 2020 14:51:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned
 by ib_umem_find_best_pgsz()
Message-ID: <20200902115119.GH59010@unreal>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 09:43:30PM -0300, Jason Gunthorpe wrote:
> rdma_for_each_block() makes assumptions about how the SGL is constructed
> that don't work if the block size is below the page size used to to build
> the SGL.
>
> The rules for umem SGL construction require that the SG's all be PAGE_SIZE
> aligned and we don't encode the actual byte offset of the VA range inside
> the SGL using offset and length. So rdma_for_each_block() has no idea
> where the actual starting/ending point is to compute the first/last block
> boundary if the starting address should be within a SGL.
>
> Fixing the SGL construction turns out to be really hard, and will be the
> subject of other patches. For now block smaller pages.
>
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 120e98403c345d..7b5bc969e55630 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -151,6 +151,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  	dma_addr_t mask;
>  	int i;
>
> +	/* rdma_for_each_block() has a bug if the page size is smaller than the
> +	 * page size used to build the umem. For now prevent smaller page sizes
> +	 * from being returned.
> +	 */
> +	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
> +

Why do we care about such case? Why can't we leave this check forever?

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
