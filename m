Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC80E72848
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 08:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfGXGcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 02:32:36 -0400
Received: from verein.lst.de ([213.95.11.211]:48034 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXGcf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 02:32:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3292A68BFE; Wed, 24 Jul 2019 08:32:33 +0200 (CEST)
Date:   Wed, 24 Jul 2019 08:32:32 +0200
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
Subject: Re: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
Message-ID: <20190724063232.GB1804@lst.de>
References: <20190722230859.5436-1-logang@deltatee.com> <20190722230859.5436-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722230859.5436-12-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
> +	struct pci_dev *client;
> +	int dist;
> +
> +	client = find_parent_pci_dev(dev);
> +	if (WARN_ON_ONCE(!client))
> +		return 0;
>  
> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> +					client, NULL);

Doing this on every mapping call sounds expensive..

> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
> +		return 0;
> +
> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> +	else
> +		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);

Can't we organize the values so that we can switch on the return
value instead of doing flag checks?

>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>  
> @@ -847,6 +861,21 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
>  void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
> +	struct pci_dev *client;
> +	int dist;
> +
> +	client = find_parent_pci_dev(dev);
> +	if (!client)
> +		return;
> +
> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> +					client, NULL);

And then we do it for every unmap again..
