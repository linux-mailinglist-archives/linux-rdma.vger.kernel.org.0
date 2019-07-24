Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3FD7284B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfGXGcc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 02:32:32 -0400
Received: from verein.lst.de ([213.95.11.211]:48024 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXGcc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 02:32:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5363368B02; Wed, 24 Jul 2019 08:32:29 +0200 (CEST)
Date:   Wed, 24 Jul 2019 08:32:29 +0200
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
Subject: Re: [PATCH 07/14] PCI/P2PDMA: Add the provider's pci_dev to the
 dev_pgmap struct
Message-ID: <20190724063229.GA1804@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com> <20190722230859.5436-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722230859.5436-8-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 05:08:52PM -0600, Logan Gunthorpe wrote:
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 143e11d2a5c3..70c262b7c731 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -168,6 +168,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	pgmap->res.end = pgmap->res.start + size - 1;
>  	pgmap->res.flags = pci_resource_flags(pdev, bar);
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
> +	pgmap->pci_p2pdma_provider = pdev;
>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>  		pci_resource_start(pdev, bar);

I think we need to bite the bullet and move the PCIe P2P specific
information out of struct dev_pagemap and into a pci-specific structure
that embedds struct dev_pagemap.
