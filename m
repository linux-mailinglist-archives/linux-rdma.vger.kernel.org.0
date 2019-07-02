Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE15D9D9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 02:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGCAy7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 20:54:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48638 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbfGCAy6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Jul 2019 20:54:58 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hiRdk-0001o8-HO; Tue, 02 Jul 2019 16:52:46 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
References: <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
 <20190628045705.GD3705@ziepe.ca>
 <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
 <20190628172926.GA3877@ziepe.ca>
 <25a87c72-630b-e1f1-c858-9c8b417506fc@deltatee.com>
 <20190628190931.GC3877@ziepe.ca>
 <cb680437-9615-da42-ebc5-4751e024a45f@deltatee.com>
 <20190702224530.GD11860@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <49c7f848-3cd5-7225-0821-b19fb4547ad9@deltatee.com>
Date:   Tue, 2 Jul 2019 16:52:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702224530.GD11860@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, kbusch@kernel.org, sagi@grimberg.me, dan.j.williams@intel.com, bhelgaas@google.com, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, jgg@ziepe.ca
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



On 2019-07-02 4:45 p.m., Jason Gunthorpe wrote:
> On Fri, Jun 28, 2019 at 01:35:42PM -0600, Logan Gunthorpe wrote:
> 
>>> However, I'd feel more comfortable about that assumption if we had
>>> code to support the IOMMU case, and know for sure it doesn't require
>>> more info :(
>>
>> The example I posted *does* support the IOMMU case. That was case (b1)
>> in the description. The idea is that pci_p2pdma_dist() returns a
>> distance with a high bit set (PCI_P2PDMA_THRU_HOST_BRIDGE) when an IOMMU
>> mapping is required and the appropriate flag tells it to call
>> dma_map_resource(). This way, it supports both same-segment and
>> different-segments without needing any look ups in the map step.
> 
> I mean we actually have some iommu drivers that can setup P2P in real
> HW. I'm worried that real IOMMUs will need to have the BDF of the
> completer to route completions back to the requester - which we can't
> trivially get through this scheme.

I've never seen such an IOMMU but I guess, in theory, it could exist.
The IOMMUs that setup P2P-like transactions in real hardware make use of
dma_map_resource(). There aren't a lot of users of this function (it's
actually been broken with the Intel IOMMU until I fixed it recently and
I'd expect there are other broken implementations); but, to my
knowledge, none of them have needed the BDF of the provider to date.

> However, maybe that is just a future problem, and certainly we can see
> that with an interval tree or otherwise such a IOMMU could get the
> information it needs.

Yup, the rule of thumb is to design for the needs we have today not
imagined future problems.

Logan
