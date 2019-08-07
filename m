Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B701085075
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbfHGP6j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 11:58:39 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34966 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfHGP6i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 11:58:38 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hvOKK-0002XL-O8; Wed, 07 Aug 2019 09:58:13 -0600
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
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-4-logang@deltatee.com> <20190807055455.GA6627@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>
Date:   Wed, 7 Aug 2019 09:58:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807055455.GA6627@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, jgg@mellanox.com, Christian.Koenig@amd.com, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-08-06 11:54 p.m., Christoph Hellwig wrote:
> On Tue, Jul 30, 2019 at 10:35:34AM -0600, Logan Gunthorpe wrote:
>> Add constant flags to indicate two devices are not supported or whether
>> the data path goes through the host bridge instead of using the negative
>> values -1 and -2.
>>
>> This helps annotate the code better, but the main reason is so we
>> can use the information to store the required mapping method in an
>> xarray.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Is there really no way to keep the distance separate from the type of
> the connection as I requested?  I think that would avoid a lot of
> confusion down the road.

Well I separated it in the xarray and the interface. It only stores the
type of mapping, not the distance and uses pci_p2pdma_map_type() to
retrieve it.

We only calculate it at the same time as we calculate the distance. This
is necessary because, to calculate the type, we have to walk the tree
and check the ACS bits. If we separated it, we'd have to walk the tree
twice in a very similar way just to determine both the distance and the
mapping type.

I'll apply your other feedback to a v3 next week.

Logan
