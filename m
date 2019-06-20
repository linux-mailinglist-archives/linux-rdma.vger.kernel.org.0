Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976594D985
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfFTSib (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 14:38:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33806 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfFTSib (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 14:38:31 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1he1ws-000641-Jx; Thu, 20 Jun 2019 12:38:15 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190620161240.22738-5-logang@deltatee.com>
 <20190620172347.GE19891@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6e4caa21-a148-00d1-a46f-18517fb744d6@deltatee.com>
Date:   Thu, 20 Jun 2019 12:38:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620172347.GE19891@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, kbusch@kernel.org, sagi@grimberg.me, dan.j.williams@intel.com, bhelgaas@google.com, hch@lst.de, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 04/28] block: Never bounce dma-direct bios
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-06-20 11:23 a.m., Jason Gunthorpe wrote:
> On Thu, Jun 20, 2019 at 10:12:16AM -0600, Logan Gunthorpe wrote:
>> It is expected the creator of the dma-direct bio will ensure the
>> target device can access the DMA address it's creating bios for.
>> It's also not possible to bounce a dma-direct bio seeing the block
>> layer doesn't have any way to access the underlying data behind
>> the DMA address.
>>
>> Thus, never bounce dma-direct bios.
> 
> I wonder how feasible it would be to implement a 'dma vec' copy
> from/to? 

> That is about the only operation you could safely do on P2P BAR
> memory. 
> 
> I wonder if a copy implementation could somehow query the iommu layer
> to get a kmap of the memory pointed at by the dma address so we don't
> need to carry struct page around?

That sounds a bit nasty. First we'd have to determine what the
dma_addr_t points to; and with P2P it may be a bus address or it may be
an IOVA address and it would probably have to be based on whether the
IOVA is reserved or not (PCI bus addresses should all be reserved).
Second, if it is an IOVA then the we'd have to get the physical address
back from the IOMMU tables and hope we can then get it back to a
sensible kernel mapping -- and if it points to a PCI bus address we'd
then have to somehow get back to the kernel mapping which could be
anywhere in the VMALLOC region as we no longer have the linear mapping
that struct page provides.

I think if we need access to the memory, then this is the wrong approach
and we should keep struct page or try pfn_t so we can map the memory in
a way that would perform better.

In theory, I could relatively easily do the same thing I did for dma_vec
but with a pfn_t_vec. Though we'd still have the problem of determining
virtual address from physical address for memory that isn't linearly
mapped. We'd probably have to introduce some arch-specific thing to
linearly map an io region or something which may be possible on some
arches on not on others (same problems we have with struct page).

Logan
