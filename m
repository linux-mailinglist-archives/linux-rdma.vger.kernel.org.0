Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAF25F3FD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIGH3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 03:29:21 -0400
Received: from verein.lst.de ([213.95.11.211]:47990 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgIGH3S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 03:29:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB3DE68BFE; Mon,  7 Sep 2020 09:29:16 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:29:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/4] lib/scatterlist: Add support in
 dynamically allocation of SG entries
Message-ID: <20200907072916.GB19875@lst.de>
References: <20200903121853.1145976-1-leon@kernel.org> <20200903121853.1145976-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903121853.1145976-3-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> +static inline void _sg_chain(struct scatterlist *chain_sg,
> +			     struct scatterlist *sgl)
> +{
> +	/*
> +	 * offset and length are unused for chain entry. Clear them.
> +	 */
> +	chain_sg->offset = 0;
> +	chain_sg->length = 0;
> +
> +	/*
> +	 * Set lowest bit to indicate a link pointer, and make sure to clear
> +	 * the termination bit if it happens to be set.
> +	 */
> +	chain_sg->page_link = ((unsigned long) sgl | SG_CHAIN) & ~SG_END;
> +}

Please call this __sg_chain to stick with our normal kernel naming
convention.
