Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2135B8FD7C
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 10:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHPIPw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 04:15:52 -0400
Received: from verein.lst.de ([213.95.11.211]:53426 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfHPIPv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 04:15:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65D7468B02; Fri, 16 Aug 2019 10:15:48 +0200 (CEST)
Date:   Fri, 16 Aug 2019 10:15:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v3 12/14] PCI/P2PDMA: dma_map() requests that traverse
 the host bridge
Message-ID: <20190816081548.GL9249@lst.de>
References: <20190812173048.9186-1-logang@deltatee.com> <20190812173048.9186-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173048.9186-13-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:46AM -0600, Logan Gunthorpe wrote:
> Any requests that traverse the host bridge will need to be mapped into the
> IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when appropriate.
> 
> Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-13-logang@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
