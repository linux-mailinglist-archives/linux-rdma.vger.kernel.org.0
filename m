Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08F4C51A83
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 20:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfFXS2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 14:28:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40200 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfFXS2r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 14:28:47 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hfThm-0001JO-NG; Mon, 24 Jun 2019 12:28:39 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca> <20190624073126.GB3954@lst.de>
 <20190624134641.GA8268@ziepe.ca> <20190624135024.GA11248@lst.de>
 <20190624135550.GB8268@ziepe.ca>
 <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
 <20190624181632.GC8268@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bbd81ef9-b4f7-3ba7-7f93-85f602495e19@deltatee.com>
Date:   Mon, 24 Jun 2019 12:28:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624181632.GC8268@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, kbusch@kernel.org, sagi@grimberg.me, bhelgaas@google.com, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, hch@lst.de, jgg@ziepe.ca
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



On 2019-06-24 12:16 p.m., Jason Gunthorpe wrote:
> On Mon, Jun 24, 2019 at 10:53:38AM -0600, Logan Gunthorpe wrote:
>>> It is only a very narrow case where you can take shortcuts with
>>> dma_addr_t, and I don't think shortcuts like are are appropriate for
>>> the mainline kernel..
>>
>> I don't think it's that narrow and it opens up a lot of avenues for
>> system design that people are wanting to go. If your high speed data
>> path can avoid the root complex and CPU, you can design a system which a
>> much smaller CPU and fewer lanes directed at the CPU.
> 
> I mean the shortcut that something generates dma_addr_t for Device A
> and then passes it to Device B - that is too hacky for mainline.

Oh, that's not a shortcut. It's completely invalid and not likely to
work in any case. If you're mapping something you have to pass the
device that the dma_addr_t is being programmed into.

> Sounded like this series does generate the dma_addr for the correct
> device..

This series doesn't generate any DMA addresses with dma_map(). The
current p2pdma code ensures everything is behind the same root port and
only uses the pci bus address. This is valid and correct, but yes it's
something to expand upon.

I'll be doing some work shortly to add transactions that go through the
IOMMU and calls dma_map_* when appropriate.

Logan
