Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98372847
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfGXGcj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 02:32:39 -0400
Received: from verein.lst.de ([213.95.11.211]:48050 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXGci (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 02:32:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40A0E68C65; Wed, 24 Jul 2019 08:32:36 +0200 (CEST)
Date:   Wed, 24 Jul 2019 08:32:36 +0200
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
Subject: Re: [PATCH 14/14] PCI/P2PDMA: Introduce
 pci_p2pdma_[un]map_resource()
Message-ID: <20190724063235.GC1804@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com> <20190722230859.5436-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722230859.5436-15-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index baf476039396..20c834cfd2d3 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +static pci_bus_addr_t pci_p2pdma_phys_to_bus(struct pci_dev *dev,
> +		phys_addr_t start, size_t size)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	phys_addr_t end = start + size;
> +	struct resource_entry *window;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		if (window->res->start <= start && window->res->end >= end)
> +			return start - window->offset;
> +	}
> +
> +	return DMA_MAPPING_ERROR;

This does once again look very expensive for something called in the
hot path.
