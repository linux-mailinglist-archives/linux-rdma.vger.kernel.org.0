Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0964228FEF9
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 09:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404369AbgJPHNu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 03:13:50 -0400
Received: from verein.lst.de ([213.95.11.211]:34531 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404342AbgJPHNu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 03:13:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A6CF868AFE; Fri, 16 Oct 2020 09:13:47 +0200 (CEST)
Date:   Fri, 16 Oct 2020 09:13:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201016071347.GA8001@lst.de>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com> <20201014225125.GC5316@nvidia.com> <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com> <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com> <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com> <20201016003127.GD6219@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016003127.GD6219@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 15, 2020 at 09:31:27PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 15, 2020 at 03:21:34PM +0300, Maor Gottlieb wrote:
> > 
> > On 10/15/2020 2:23 PM, Gal Pressman wrote:
> > > On 15/10/2020 10:44, Maor Gottlieb wrote:
> > > > On 10/15/2020 1:51 AM, Jason Gunthorpe wrote:
> > > > > On Tue, Oct 13, 2020 at 09:33:14AM -0500, Bob Pearson wrote:
> > > > > > Jason,
> > > > > > 
> > > > > > Just pulled for-next and now hit the following warning.
> > > > > > Register user space memory is not longer working.
> > > > > > I am trying to debug this but if you have any idea where to look let me know.
> > > > > The offset_in_page is wrong, but it is protecting some other logic..
> > > > > 
> > > > > Maor? Leon? Can you sort it out tomorrow?
> > > > Leon and I investigated it. This check existed before my series to protect the
> > > > alloc_table_from_pages logic. It's still relevant.
> > > > This patch that broke it:  54816d3e69d1 ("RDMA: Explicitly pass in the
> > > > dma_device to ib_register_device"), and according to below link it was
> > > > expected.  The safest approach is to set the max_segment_size back the 2GB in
> > > > all drivers. What do you think?
> > > > 
> > > > https://lore.kernel.org/linux-rdma/20200923072111.GA31828@infradead.org/
> > > FWIW, EFA is broken as well (same call trace) so it's not just software drivers.
> > 
> > This is true to all drivers that call to ib_umem_get and set UINT_MAX  as
> > max_segment_size.
> > Jason,  maybe instead of set UINT_MAX as max_segment_size, need to set
> > SCATTERLIST_MAX_SEGMENT which does the required alignment.
> 
> SCATTERLIST_MAX_SEGMENT is almost never used, however there are lots
> of places passing UINT_MAX or similar as the max_segsize for DMA.
> 
> The only place that does use it looks goofy to me:
> 
> 	dma_set_max_seg_size(dev->dev, min_t(unsigned int, U32_MAX & PAGE_MASK,
> 					     SCATTERLIST_MAX_SEGMENT));
> 
> The seg_size should reflect the HW capability, not be mixed in with
> knowledge about SGL internals. If the SGL can't build up to the HW
> limit then it is fine to internally silently reduce it.
> 
> So I think we need to fix the scatterlist code, like below, and
> just remove SCATTERLIST_MAX_SEGMENT completely.
> 
> It fixes things? Are you OK with this Christoph?
> 
> I need to get this fixed for the merge window PR I want to send on
> Friday.

This looks ok.  Not critical, but I think we should follow up and kill
off the confusing SCATTERLIST_MAX_SEGMENT as well soon
