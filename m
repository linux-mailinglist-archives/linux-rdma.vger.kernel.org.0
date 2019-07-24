Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC673356
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 18:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGXQGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 12:06:39 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43632 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfGXQGj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 12:06:39 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqJmb-0005ZT-8c; Wed, 24 Jul 2019 10:06:26 -0600
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
 <20190722230859.5436-15-logang@deltatee.com> <20190724063235.GC1804@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <57e8fc1a-de70-fb65-5ef1-ffa2b95c73a6@deltatee.com>
Date:   Wed, 24 Jul 2019 10:06:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724063235.GC1804@lst.de>
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
Subject: Re: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index baf476039396..20c834cfd2d3 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
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
> 
> This does once again look very expensive for something called in the
> hot path.

Yes. This is the downside of dealing only with a phys_addr_t: we have to
look up against it. Unfortunately, I believe it's possible for different
BARs on a device to be in different windows, so something like this is
necessary unless we already know the BAR the phys_addr_t belongs to. It
might probably be sped up a bit by storing the offsets of each bar
instead of looping through all the bridge windows, but I don't think it
will get you *that* much.

As this is an example with no users, the answer here will really depend
on what the use-case is doing. If they can lookup, ahead of time, the
mapping type and offset then they don't have to do this work on the hot
path and it means that pci_p2pdma_map_resource() is simply not a
suitable API.

Logan

