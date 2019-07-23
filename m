Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC8E71D35
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfGWQ64 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 12:58:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50466 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbfGWQ64 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 12:58:56 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hpy7e-0003Tj-UQ; Tue, 23 Jul 2019 10:58:43 -0600
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <d7c7011e-e9b7-89f8-99ba-b674d45821c6@amd.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <deaa0992-24c8-be93-f623-a5b2b442e4d0@deltatee.com>
Date:   Tue, 23 Jul 2019 10:58:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7c7011e-e9b7-89f8-99ba-b674d45821c6@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, jgg@mellanox.com, hch@lst.de, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Christian.Koenig@amd.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 00/14] PCI/P2PDMA: Support transactions that hit the host
 bridge
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-23 10:30 a.m., Koenig, Christian wrote:
> Am 23.07.19 um 01:08 schrieb Logan Gunthorpe:
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
>>
>> This patchset is based on 5.3-rc1 and a git branch is available here:
>>
>> https://github.com/sbates130272/linux-p2pmem/ p2pdma_rc_map_v1
> 
> I reviewed patches #1-#3 and #14.
> 
> Feel free to stick an Acked-by: Christian König 
> <christian.koenig@amd.com> to the rest, but I'm not really deep into the 
> NVMe P2P handling here.

Thanks!

Logan
