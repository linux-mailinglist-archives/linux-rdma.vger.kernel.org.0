Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542BB8FD78
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfHPIO5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 04:14:57 -0400
Received: from verein.lst.de ([213.95.11.211]:53411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHPIO5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Aug 2019 04:14:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 392F368B02; Fri, 16 Aug 2019 10:14:54 +0200 (CEST)
Date:   Fri, 16 Aug 2019 10:14:54 +0200
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
Subject: Re: [PATCH v3 11/14] PCI/P2PDMA: Store mapping method in an xarray
Message-ID: <20190816081454.GK9249@lst.de>
References: <20190812173048.9186-1-logang@deltatee.com> <20190812173048.9186-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173048.9186-12-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 11:30:45AM -0600, Logan Gunthorpe wrote:
> When upstream_bridge_distance() is called, store the method required to map
> the DMA transfers in an xarray so it can be looked up efficiently on the
> hot path in pci_p2pdma_map_sg().
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-12-logang@deltatee.com
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
