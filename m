Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2369C757B0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 21:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfGYTRR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 15:17:17 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42248 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfGYTRR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 15:17:17 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqjEe-0003mV-J9; Thu, 25 Jul 2019 13:17:05 -0600
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com>
 <20190725185830.GH7450@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cf61d237-8a8a-e3ac-a9df-466f20b63020@deltatee.com>
Date:   Thu, 25 Jul 2019 13:17:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725185830.GH7450@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, Christian.Koenig@amd.com, hch@lst.de, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jgg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-25 12:58 p.m., Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 05:08:56PM -0600, Logan Gunthorpe wrote:
>> Any requests that traverse the host bridge will need to be mapped into
>> the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
>> appropriate.
>>
>> Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 5f43f92f9336..76f51678342c 100644
>> +++ b/drivers/pci/p2pdma.c
>> @@ -830,8 +830,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>>  {
>>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
>> +	struct pci_dev *client;
>> +	int dist;
>> +
>> +	client = find_parent_pci_dev(dev);
>> +	if (WARN_ON_ONCE(!client))
>> +		return 0;
>>  
>> -	return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
>> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
>> +					client, NULL);
>> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
>> +		return 0;
>> +
>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> 
> IIRC at this point the SG will have struct page references to the BAR
> memory - so (all?) the IOMMU drivers are able to handle P2P setup in
> this case?

Yes. The IOMMU drivers refer to the physical address for BAR which they
can get from the struct page. And this works fine today.

> Didn't you also have a patch to remove the struct page's for the BAR
> memory?  

Well that was an RFC that's not going anywhere in it's current form. I'd
still like to remove struct pages but that's going to take a while and
when that happens, this will have to be reworked. Probably to use
dma_map_resource() instead but will depend on the form the removal takes.

Logan
