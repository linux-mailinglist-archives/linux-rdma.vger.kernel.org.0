Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAB83E5B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 02:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfHGAb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 20:31:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50098 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfHGAb3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 20:31:29 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hv9rD-0003gV-OL; Tue, 06 Aug 2019 18:31:12 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190806234439.GW151852@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e31f13f8-5afd-6f38-a206-163e9f77c91a@deltatee.com>
Date:   Tue, 6 Aug 2019 18:31:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806234439.GW151852@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, epilmore@gigaio.com, dan.j.williams@intel.com, sbates@raithlin.com, jgg@mellanox.com, kbusch@kernel.org, axboe@fb.com, Christian.Koenig@amd.com, sagi@grimberg.me, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 00/14] PCI/P2PDMA: Support transactions that hit the
 host bridge
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-08-06 5:44 p.m., Bjorn Helgaas wrote:
> On Tue, Jul 30, 2019 at 10:35:31AM -0600, Logan Gunthorpe wrote:
>> Here's v2 of the patchset. It doesn't sound like there's anything
>> terribly controversial here so this version is mostly just some
>> cleanup changes for clarity.
>>
>> Changes in v2:
>>  * Rebase on v5.3-rc2 (No changes)
>>  * Re-introduce the private pagemap structure and move the p2p-specific
>>    elements out of the commond dev_pagemap (per Christoph)
>>  * Use flags instead of bool in the whitelist (per Jason)
>>  * Only store the mapping type in the xarray (instead of the distance
>>    with flags) such that a function can return the mapping method
>>    with a switch statement to decide how to map. (per Christoph)
>>  * Drop find_parent_pci_dev() on the fast path and rely on the fact
>>    that the struct device passed to the mapping functions *must* be
>>    a PCI device and convert it directly. (per suggestions from
>>    Christoph and Jason)
>>  * Collected Christian's Reviewed-by's
>> --
>>
>> As discussed on the list previously, in order to fully support the
>> whitelist Christian added with the IOMMU, we must ensure that we
>> map any buffer going through the IOMMU with an aprropriate dma_map
>> call. This patchset accomplishes this by cleaning up the output of
>> upstream_bridge_distance() to better indicate the mapping requirements,
>> caching these requirements in an xarray, then looking them up at map
>> time and applying the appropriate mapping method.
>>
>> After this patchset, it's possible to use the NVMe-of P2P support to
>> transfer between devices without a switch on the whitelisted root
>> complexes. A couple Intel device I have tested this on have also
>> been added to the white list.
>>
>> Most of the changes are contained within the p2pdma.c, but there are
>> a few minor touches to other subsystems, mostly to add support
>> to call an unmap function.
>>
>> The final patch in this series demonstrates a possible
>> pci_p2pdma_map_resource() function that I expect Christian will need
>> but does not have any users at this time so I don't intend for it to be
>> considered for merging.
> 
> I don't see pci_p2pdma_map_resource() in any of these patches.

Oh, sorry, I removed that in v2 seeing there was some confusion over it.
I guess I forgot to remove the reference in the cover letter.

> I tentatively applied these to pci/p2pdma with minor typographical
> updates (below), but I'll update the branch if necessary.

Great, thanks! The typographical changes look good.

I already have one very minor change queued up for these. Should I just
send you a small patch against your branch for you to squash?

Logan

