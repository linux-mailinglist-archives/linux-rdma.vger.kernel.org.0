Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7373310
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfGXPu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jul 2019 11:50:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:43356 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfGXPu3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jul 2019 11:50:29 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqJWv-00057X-JI; Wed, 24 Jul 2019 09:50:14 -0600
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
 <20190722230859.5436-8-logang@deltatee.com> <20190724063229.GA1804@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <818e465d-3e57-b425-2431-e330a43fe7bd@deltatee.com>
Date:   Wed, 24 Jul 2019 09:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724063229.GA1804@lst.de>
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
Subject: Re: [PATCH 07/14] PCI/P2PDMA: Add the provider's pci_dev to the
 dev_pgmap struct
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-24 12:32 a.m., Christoph Hellwig wrote:
> On Mon, Jul 22, 2019 at 05:08:52PM -0600, Logan Gunthorpe wrote:
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 143e11d2a5c3..70c262b7c731 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -168,6 +168,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>>  	pgmap->res.end = pgmap->res.start + size - 1;
>>  	pgmap->res.flags = pci_resource_flags(pdev, bar);
>>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>> +	pgmap->pci_p2pdma_provider = pdev;
>>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>>  		pci_resource_start(pdev, bar);
> 
> I think we need to bite the bullet and move the PCIe P2P specific
> information out of struct dev_pagemap and into a pci-specific structure
> that embedds struct dev_pagemap.

OK, I was going to do that, but you just removed the p2p specific page
map. ;)

I'll change this for a v2.

Logan

