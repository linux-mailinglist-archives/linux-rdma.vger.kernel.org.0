Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BA25F3FC
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIGH3i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 03:29:38 -0400
Received: from verein.lst.de ([213.95.11.211]:47999 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgIGH33 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 03:29:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7252A68BFE; Mon,  7 Sep 2020 09:29:26 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:29:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] RDMA/umem: Move to allocate SG table
 from pages
Message-ID: <20200907072926.GD19875@lst.de>
References: <20200903121853.1145976-1-leon@kernel.org> <20200903121853.1145976-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903121853.1145976-5-leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 03:18:53PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Remove the implementation of ib_umem_add_sg_table and instead
> call to sg_alloc_table_append which already has the logic to
> merge contiguous pages.
> 
> Besides that it removes duplicated functionality, it reduces the
> memory consumption of the SG table significantly. Prior to this
> patch, the SG table was allocated in advance regardless consideration
> of contiguous pages.
> 
> In huge pages system of 2MB page size, without this change, the SG table
> would contain x512 SG entries.
> E.g. for 100GB memory registration:
> 
> 	 Number of entries	Size
> Before 	      26214400          600.0MB
> After            51200		  1.2MB
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Looks sensible for now, but the real fix is of course to avoid
the scatterlist here entirely, and provide a bvec based
pin_user_pages_fast.  I'll need to finally get that done..
