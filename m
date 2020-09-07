Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8243B25F3F6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 09:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgIGH3a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 03:29:30 -0400
Received: from verein.lst.de ([213.95.11.211]:47992 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgIGH3Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 03:29:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B78F68BEB; Mon,  7 Sep 2020 09:29:22 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:29:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/4] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
Message-ID: <20200907072921.GC19875@lst.de>
References: <20200903121853.1145976-1-leon@kernel.org> <20200903121853.1145976-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903121853.1145976-4-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 03:18:52PM +0300, Leon Romanovsky wrote:
> +struct sg_append {
> +	struct scatterlist *prv; /* Previous entry to append */
> +	unsigned int left_pages; /* Left pages to add to table */
> +};

I don't really see the point in this structure.   Either pass it as
two separate arguments, or switch sg_alloc_table_append and the
internal helper to pass all arguments as a struct.

> + *    A user may provide an offset at a start and a size of valid data in a buffer
> + *    specified by the page array. A user may provide @append to chain pages to

This adds a few pointles > 80 char lines.

> +struct scatterlist *
> +sg_alloc_table_append(struct sg_table *sgt, struct page **pages,
> +		      unsigned int n_pages, unsigned int offset,
> +		      unsigned long size, unsigned int max_segment,
> +		      gfp_t gfp_mask, struct sg_append *append)
> +{
> +#ifdef CONFIG_ARCH_NO_SG_CHAIN
> +	if (append->left_pages)
> +		return ERR_PTR(-EOPNOTSUPP);
> +#endif

Which makes this API entirely useless for !CONFIG_ARCH_NO_SG_CHAIN,
doesn't it?  Wouldn't it make more sense to not provide it for that
case and add an explicitl dependency in the callers?

> +	return alloc_from_pages_common(sgt, pages, n_pages, offset, size,
> +				       max_segment, gfp_mask, append);

And if we somehow manage to sort that out we can merge
sg_alloc_table_append and alloc_from_pages_common, reducing the amount
of wrappers that just make it too hard to follow the code.

> +EXPORT_SYMBOL(sg_alloc_table_append);

EXPORT_SYMBOL_GPL, please.
