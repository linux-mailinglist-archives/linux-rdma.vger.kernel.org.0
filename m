Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 805CC7536C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbfGYQAq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 12:00:46 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38154 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387874AbfGYQAq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 12:00:46 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqgAQ-00081J-CN; Thu, 25 Jul 2019 10:00:31 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com> <20190724063232.GB1804@lst.de>
 <7173a4dd-0c9c-48de-98cd-93513313fd8d@deltatee.com>
 <20190725061005.GB24875@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fb39485a-2914-bac4-b249-e1f4ecc8d2be@deltatee.com>
Date:   Thu, 25 Jul 2019 10:00:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725061005.GB24875@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, jgg@mellanox.com, Christian.Koenig@amd.com, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
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



On 2019-07-25 12:10 a.m., Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 09:58:59AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
>>>>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
>>>> +	struct pci_dev *client;
>>>> +	int dist;
>>>> +
>>>> +	client = find_parent_pci_dev(dev);
>>>> +	if (WARN_ON_ONCE(!client))
>>>> +		return 0;
>>>>  
>>>> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
>>>> +					client, NULL);
>>>
>>> Doing this on every mapping call sounds expensive..
>>
>> The result of this function is cached in an xarray (per patch 4) so, on
>> the hot path, it should just be a single xa_load() which should be a
>> relatively fast lookup which is similarly used for other hot path
>> operations.
> 
> We don't cache find_parent_pci_dev, though.  So we should probably
> export find_parent_pci_dev with a proper namespaces name and cache
> that in the caler.

Oh, yes, I'll take a look at this. Of the two callers: NVMe should be
easy we could just pass the PCI device instead of the struct device.
RDMA is significantly more unclear: would you add a pci_dev to struct
ib_device? Or maybe we should be able to simply rely on the fact that
the DMA device *must* be a PCI device and just use to_pci_dev() directly?

>>>
>>>> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
>>>> +		return 0;
>>>> +
>>>> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
>>>> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>>>> +	else
>>>> +		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
>>>
>>> Can't we organize the values so that we can switch on the return
>>> value instead of doing flag checks?
>>
>> Sorry, I don't follow what you are saying here. If you mean for
>> upstream_bridge_distance() to just return how to map and not the
>> distance that would interfere with other uses of that function.
> 
> The point is that in the map path we don't even care about the
> distance.  I think we should just have a function that returns the
> P2PDMA_ values from the xarray (maybe also store it there as two
> values, but that isn't quite as important), and get rid of even
> the concept of distance in the map path. e.g.:
> 
> 	switch (pci_p2pdma_supported(pgmap->pci_p2pdma_provider, client))) {
> 	case P2PDMA_HOST_BRIDGE:
> 		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> 	case P2PDMA_SWITCH:
> 		return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
> 	default:
> 		WARN_ON_ONCE(1);
> 		return 0;
> 	}

Ok, will change for v2.

Thanks,

Logan

