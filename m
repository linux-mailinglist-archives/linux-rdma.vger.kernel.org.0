Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A19FB498
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfKMQDr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 11:03:47 -0500
Received: from verein.lst.de ([213.95.11.211]:34866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbfKMQDq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 11:03:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 830D068AFE; Wed, 13 Nov 2019 17:03:44 +0100 (CET)
Date:   Wed, 13 Nov 2019 17:03:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: remove DMA_ATTR_WRITE_BARRIER
Message-ID: <20191113160344.GA12853@lst.de>
References: <20191113073214.9514-1-hch@lst.de> <20191113154712.GF21728@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113154712.GF21728@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 13, 2019 at 03:47:18PM +0000, Jason Gunthorpe wrote:
> On Wed, Nov 13, 2019 at 08:32:12AM +0100, Christoph Hellwig wrote:
> > There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
> > now that the ia64 sn2 code has been removed.  Drop the flag and
> > the calling convention to set it in the RDMA code.
> 
> This looks OK, do you want it to go through the RDMA tree?

Either the dma-mapping or rdma tree is fine with me.  I guess
there are more potential conflicts with rdma changes, so tht might
be the better choice.
