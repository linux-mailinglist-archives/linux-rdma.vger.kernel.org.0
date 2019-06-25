Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585B7553D5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 17:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfFYP6S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 11:58:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35340 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfFYP6R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 11:58:17 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hfnpU-00047F-3d; Tue, 25 Jun 2019 09:57:57 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
Date:   Tue, 25 Jun 2019 09:57:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625072008.GB30350@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, jgg@ziepe.ca, kbusch@kernel.org, sagi@grimberg.me, dan.j.williams@intel.com, bhelgaas@google.com, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-06-25 1:20 a.m., Christoph Hellwig wrote:
> On Mon, Jun 24, 2019 at 10:07:56AM -0600, Logan Gunthorpe wrote:
>>> For one passing a dma_addr_t through the block layer is a layering
>>> violation, and one that I think will also bite us in practice.
>>> The host physical to PCIe bus address mapping can have offsets, and
>>> those offsets absolutely can be different for differnet root ports.
>>> So with your caller generated dma_addr_t everything works fine with
>>> a switched setup as the one you are probably testing on, but on a
>>> sufficiently complicated setup with multiple root ports it can break.
>>
>> I don't follow this argument. Yes, I understand PCI Bus offsets and yes
>> I understand that they only apply beyond the bus they're working with.
>> But this isn't *that* complicated and it should be the responsibility of
>> the P2PDMA code to sort out and provide a dma_addr_t for. The dma_addr_t
>> that's passed through the block layer could be a bus address or it could
>> be the result of a dma_map_* request (if the transaction is found to go
>> through an RC) depending on the requirements of the devices being used.
> 
> You assume all addressing is done by the PCI bus address.  If a device
> is addressing its own BAR there is no reason to use the PCI bus address,
> as it might have much more intelligent schemes (usually bar + offset).

Yes, that will be a bit tricky regardless of what we do.

>>> Also duplicating the whole block I/O stack, including hooks all over
>>> the fast path is pretty much a no-go.
>>
>> There was very little duplicate code in the patch set. (Really just the
>> mapping code). There are a few hooks, but in practice not that many if
>> we ignore the WARN_ONs. We might be able to work to reduce this further.
>> The main hooks are: when we skip bouncing, when we skip integrity prep,
>> when we split, and when we map. And the patchset drops the PCI_P2PDMA
>> hook when we map. So we're talking about maybe three or four extra ifs
>> that would likely normally be fast due to the branch predictor.
> 
> And all of those add code to the block layer fast path.

If we can't add any ifs to the block layer, there's really nothing we
can do.

So then we're committed to using struct page for P2P?

Logan
