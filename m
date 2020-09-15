Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D813526A9B2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 18:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgIOQZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 12:25:21 -0400
Received: from verein.lst.de ([213.95.11.211]:48397 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbgIOQXn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 12:23:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABD1568AFE; Tue, 15 Sep 2020 18:23:39 +0200 (CEST)
Date:   Tue, 15 Sep 2020 18:23:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 3/4] lib/scatterlist: Add support in
 dynamic allocation of SG table from pages
Message-ID: <20200915162339.GC24320@lst.de>
References: <20200910134259.1304543-1-leon@kernel.org> <20200910134259.1304543-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910134259.1304543-4-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +#ifndef CONFIG_ARCH_NO_SG_CHAIN
> +struct scatterlist *sg_alloc_table_append(
> +	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
> +	unsigned int offset, unsigned long size, unsigned int max_segment,
> +	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages);
> +#endif

Odd indentation here, we either do two tabs (my preference) or aligned
to the opening brace (what you seem to be doing elsewhere in the series).

> +	/* Check if last entry should be keeped for chainning */
> +	next_sg = sg_next(prv);
> +	if (!sg_is_last(next_sg) || left_npages == 1)
> +		return next_sg;
> +
> +	ret = sg_alloc_next(table, next_sg,
> +			    min_t(unsigned long, left_npages,
> +				  SG_MAX_SINGLE_ALLOC),
> +			    SG_MAX_SINGLE_ALLOC, gfp_mask);

Do we even need the sg_alloc_next helper added in the last patch,
given that this fairly simple function is the only caller?

> +static struct scatterlist *alloc_from_pages_common(
> +	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
> +	unsigned int offset, unsigned long size, unsigned int max_segment,
> +	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages)

Same strange one tab indent as above.

> +#ifndef CONFIG_ARCH_NO_SG_CHAIN
> +/**
> + * sg_alloc_table_append - Allocate and initialize an sg table from
> + *                         an array of pages
> + * @sgt:	 The sg table header to use
> + * @pages:	 Pointer to an array of page pointers
> + * @n_pages:	 Number of pages in the pages array
> + * @offset:      Offset from start of the first page to the start of a buffer
> + * @size:        Number of valid bytes in the buffer (after offset)
> + * @max_segment: Maximum size of a scatterlist node in bytes (page aligned)
> + * @gfp_mask:	 GFP allocation mask
> + * @prv:	 Last populated sge in sgt
> + * @left_pages:  Left pages caller have to set after this call
> + *
> + *  Description:
> + *    If @prv is NULL, it allocates and initialize an sg table from a list of
> + *    pages. Contiguous ranges of the pages are squashed into a single
> + *    scatterlist node up to the maximum size specified in @max_segment. A user
> + *    may provide an offset at a start and a size of valid data in a buffer
> + *    specified by the page array. A user may provide @append to chain pages
> + *    to last entry in sgt. The returned sg table is released by sg_free_table.
> + *
> + * Returns:
> + *   Last SGE in sgt on success, negative error on failure.
> + *
> + * Notes:
> + *   If this function returns non-0 (eg failure), the caller must call
> + *   sg_free_table() to cleanup any leftover allocations.
> + */
> +struct scatterlist *sg_alloc_table_append(
> +	struct sg_table *sgt, struct page **pages, unsigned int n_pages,
> +	unsigned int offset, unsigned long size, unsigned int max_segment,
> +	gfp_t gfp_mask, struct scatterlist *prv, unsigned int left_pages)

One-tab indent again.

> +{
> +	return alloc_from_pages_common(sgt, pages, n_pages, offset, size,
> +				       max_segment, gfp_mask, prv, left_pages);
> +}
> +EXPORT_SYMBOL_GPL(sg_alloc_table_append);
> +#endif

So there reason I suggested to not provide sg_alloc_table_append
if CONFIG_ARCH_NO_SG_CHAIN was set was to avoid the extra
alloc_from_pages_common helper.  It might be better to move to your
run-time check and just make it conditіtional on a non-NULL prv pointer,
which would allow us to merge alloc_from_pages_common into
sg_alloc_table_append.  Sorry for leading you down this path.
