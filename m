Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFE26B189
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 00:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgIOWbr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 18:31:47 -0400
Received: from verein.lst.de ([213.95.11.211]:48377 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgIOQRS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 12:17:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26A0868BEB; Tue, 15 Sep 2020 18:16:44 +0200 (CEST)
Date:   Tue, 15 Sep 2020 18:16:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 1/4] lib/scatterlist: Refactor
 sg_alloc_table_from_pages
Message-ID: <20200915161643.GA24320@lst.de>
References: <20200910134259.1304543-1-leon@kernel.org> <20200910134259.1304543-2-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910134259.1304543-2-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 04:42:56PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Currently, sg_alloc_table_from_pages doesn't support dynamic chaining of
> SG entries. Therefore it requires from user to allocate all the pages in
> advance and hold them in a large buffer. Such a buffer consumes a lot of
> temporary memory in HPC systems which do a very large memory registration.
> 
> The next patches introduce API for dynamically allocation from pages and
> it requires us to do the following:
>  * Extract the code to alloc_from_pages_common.
>  * Change the build of the table to iterate on the chunks and not on the
>    SGEs. It will allow dynamic allocation of more SGEs.
> 
> Since sg_alloc_table_from_pages allocate exactly the number of chunks,
> therefore chunks are equal to the number of SG entries.
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

I really don't think this refactoring on its own adds any value,
it just makes reading the rest of the series harder.

(functionally it looks correct, though)
