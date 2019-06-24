Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE05190F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 18:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfFXQxt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 12:53:49 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37724 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfFXQxs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 12:53:48 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hfSDs-0008FP-JW; Mon, 24 Jun 2019 10:53:41 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
Date:   Mon, 24 Jun 2019 10:53:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624135550.GB8268@ziepe.ca>
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



On 2019-06-24 7:55 a.m., Jason Gunthorpe wrote:
> On Mon, Jun 24, 2019 at 03:50:24PM +0200, Christoph Hellwig wrote:
>> On Mon, Jun 24, 2019 at 10:46:41AM -0300, Jason Gunthorpe wrote:
>>> BTW, it is not just offset right? It is possible that the IOMMU can
>>> generate unique dma_addr_t values for each device?? Simple offset is
>>> just something we saw in certain embedded cases, IIRC.
>>
>> Yes, it could.  If we are trying to do P2P between two devices on
>> different root ports and with the IOMMU enabled we'll generate
>> a new bus address for the BAR on the other side dynamically everytime
>> we map.
> 
> Even with the same root port if ACS is turned on could behave like this.

Yup.

> It is only a very narrow case where you can take shortcuts with
> dma_addr_t, and I don't think shortcuts like are are appropriate for
> the mainline kernel..

I don't think it's that narrow and it opens up a lot of avenues for
system design that people are wanting to go. If your high speed data
path can avoid the root complex and CPU, you can design a system which a
much smaller CPU and fewer lanes directed at the CPU.

Logan
