Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C1071D33
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbfGWQ6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 12:58:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50436 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbfGWQ6l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 12:58:41 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hpy7M-0003T7-TD; Tue, 23 Jul 2019 10:58:26 -0600
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-15-logang@deltatee.com>
 <d5e20223-04b9-dcb4-7c96-57d84eb010ae@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a6282247-b7a4-3eb9-4f87-4e73a0047f28@deltatee.com>
Date:   Tue, 23 Jul 2019 10:58:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d5e20223-04b9-dcb4-7c96-57d84eb010ae@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, jgg@mellanox.com, hch@lst.de, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Christian.Koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-23 10:28 a.m., Koenig, Christian wrote:
> Am 23.07.19 um 01:08 schrieb Logan Gunthorpe:
>> pci_p2pdma_[un]map_resource() can be used to map a resource given
>> it's physical address and the backing pci_dev. The functions will call
>> dma_[un]map_resource() when appropriate.
>>
>> This is for demonstration purposes only as there are no users of this
>> function at this time. Thus, this patch should not be merged at
>> this time.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Not sure if pci_p2pdma_phys_to_bus actually needs to be exported. But 
> apart from that looks fine to me.

Yes, oops, it certainly shouldn't be exported if it's static. I'll fix that.

> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Christian.
> 
>> ---
>>   drivers/pci/p2pdma.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index baf476039396..20c834cfd2d3 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>   
>> +static pci_bus_addr_t pci_p2pdma_phys_to_bus(struct pci_dev *dev,
>> +		phys_addr_t start, size_t size)
>> +{
>> +	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>> +	phys_addr_t end = start + size;
>> +	struct resource_entry *window;
>> +
>> +	resource_list_for_each_entry(window, &bridge->windows) {
>> +		if (window->res->start <= start && window->res->end >= end)
>> +			return start - window->offset;
>> +	}
>> +
>> +	return DMA_MAPPING_ERROR;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_phys_to_bus);
>> +
>> +/**
>> + * pci_p2pdma_map_resource - map a PCI peer-to-peer physical address for DMA
>> + * @provider: pci device that provides the memory backed by phys_addr
>> + * @dma_dev: device doing the DMA request
>> + * @phys_addr: physical address of the memory to map
>> + * @size: size of the memory to map
>> + * @dir: DMA direction
>> + * @attrs: dma attributes passed to dma_map_resource() (if called)
>> + *
>> + * Maps a BAR physical address for programming a DMA engine.
>> + *
>> + * Returns the dma_addr_t to map or DMA_MAPPING_ERROR on failure
>> + */
>> +dma_addr_t pci_p2pdma_map_resource(struct pci_dev *provider,
>> +		struct device *dma_dev, phys_addr_t phys_addr, size_t size,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dma_dev);
>> +	if (!client)
>> +		return DMA_MAPPING_ERROR;
>> +
>> +	dist = upstream_bridge_distance(provider, client, NULL);
>> +	if (dist & P2PDMA_NOT_SUPPORTED)
>> +		return DMA_MAPPING_ERROR;
>> +
>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>> +		return dma_map_resource(dma_dev, phys_addr, size, dir, attrs);
>> +	else
>> +		return pci_p2pdma_phys_to_bus(provider, phys_addr, size);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_map_resource);
>> +
>> +/**
>> + * pci_p2pdma_unmap_resource - unmap a resource mapped with
>> + *		pci_p2pdma_map_resource()
>> + * @provider: pci device that provides the memory backed by phys_addr
>> + * @dma_dev: device doing the DMA request
>> + * @addr: dma address returned by pci_p2pdma_unmap_resource()
>> + * @size: size of the memory to map
>> + * @dir: DMA direction
>> + * @attrs: dma attributes passed to dma_unmap_resource() (if called)
>> + *
>> + * Maps a BAR physical address for programming a DMA engine.
>> + *
>> + * Returns the dma_addr_t to map or DMA_MAPPING_ERROR on failure
>> + */
>> +void pci_p2pdma_unmap_resource(struct pci_dev *provider,
>> +		struct device *dma_dev, dma_addr_t addr, size_t size,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dma_dev);
>> +	if (!client)
>> +		return;
>> +
>> +	dist = upstream_bridge_distance(provider, client, NULL);
>> +	if (dist & P2PDMA_NOT_SUPPORTED)
>> +		return;
>> +
>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>> +		dma_unmap_resource(dma_dev, addr, size, dir, attrs);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_resource);
>> +
>>   /**
>>    * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
>>    *		to enable p2pdma
> 
