Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0175554
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfGYRW6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:22:58 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39540 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfGYRW6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 13:22:58 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqhRz-0001I0-Mk; Thu, 25 Jul 2019 11:22:44 -0600
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com> <20190724063232.GB1804@lst.de>
 <7173a4dd-0c9c-48de-98cd-93513313fd8d@deltatee.com>
 <20190725061005.GB24875@lst.de>
 <fb39485a-2914-bac4-b249-e1f4ecc8d2be@deltatee.com>
 <20190725163438.GF7450@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <486e2a25-f6e6-75d4-a8b7-6a38fff8546a@deltatee.com>
Date:   Thu, 25 Jul 2019 11:22:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725163438.GF7450@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, Christian.Koenig@amd.com, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, jgg@mellanox.com
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



On 2019-07-25 10:34 a.m., Jason Gunthorpe wrote:
> On Thu, Jul 25, 2019 at 10:00:25AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-07-25 12:10 a.m., Christoph Hellwig wrote:
>>> On Wed, Jul 24, 2019 at 09:58:59AM -0600, Logan Gunthorpe wrote:
>>>>
>>>>
>>>> On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
>>>>>>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
>>>>>> +	struct pci_dev *client;
>>>>>> +	int dist;
>>>>>> +
>>>>>> +	client = find_parent_pci_dev(dev);
>>>>>> +	if (WARN_ON_ONCE(!client))
>>>>>> +		return 0;
>>>>>>  
>>>>>> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
>>>>>> +					client, NULL);
>>>>>
>>>>> Doing this on every mapping call sounds expensive..
>>>>
>>>> The result of this function is cached in an xarray (per patch 4) so, on
>>>> the hot path, it should just be a single xa_load() which should be a
>>>> relatively fast lookup which is similarly used for other hot path
>>>> operations.
>>>
>>> We don't cache find_parent_pci_dev, though.  So we should probably
>>> export find_parent_pci_dev with a proper namespaces name and cache
>>> that in the caler.
>>
>> Oh, yes, I'll take a look at this. Of the two callers: NVMe should be
>> easy we could just pass the PCI device instead of the struct device.
>> RDMA is significantly more unclear: would you add a pci_dev to struct
>> ib_device? Or maybe we should be able to simply rely on the fact that
>> the DMA device *must* be a PCI device and just use to_pci_dev() directly?
> 
> AFAIK you need to use the ib_device->dma_device and add some kind of
> is_pci_dev to make it safe

Yes, that's my thinking. The dma_device *should* be a PCI device. We can
just be sure by doing is_pci_dev() and failing the mapping if it is not.

So I *think* we should be able to simply replace the
find_parent_pci_dev() with:

if (!dev_is_pci(dev))
     return 0;

client = to_pci_dev(dev);

Which should be fast and reliable.

The alternative is to push this out into the caller which may have a bit
more information (like the nvme driver does).

Logan
