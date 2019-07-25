Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96C47536D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbfGYQBJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 12:01:09 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38186 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387874AbfGYQBI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 12:01:08 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqgAp-00081n-6V; Thu, 25 Jul 2019 10:00:56 -0600
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
 <20190722230859.5436-15-logang@deltatee.com> <20190724063235.GC1804@lst.de>
 <57e8fc1a-de70-fb65-5ef1-ffa2b95c73a6@deltatee.com>
 <20190725115038.GC31065@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3d5400df-f109-9ffa-3e79-8f6bb8d7de34@deltatee.com>
Date:   Thu, 25 Jul 2019 10:00:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725115038.GC31065@lst.de>
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
Subject: Re: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-25 5:50 a.m., Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 10:06:22AM -0600, Logan Gunthorpe wrote:
>> Yes. This is the downside of dealing only with a phys_addr_t: we have to
>> look up against it. Unfortunately, I believe it's possible for different
>> BARs on a device to be in different windows, so something like this is
>> necessary unless we already know the BAR the phys_addr_t belongs to. It
>> might probably be sped up a bit by storing the offsets of each bar
>> instead of looping through all the bridge windows, but I don't think it
>> will get you *that* much.
>>
>> As this is an example with no users, the answer here will really depend
>> on what the use-case is doing. If they can lookup, ahead of time, the
>> mapping type and offset then they don't have to do this work on the hot
>> path and it means that pci_p2pdma_map_resource() is simply not a
>> suitable API.
> 
> Ok.  So lets just keep this out as an RFC and don't merge it until an
> actual concrete user shows up.


Yup, that was my intention and I mentioned that in the commit message.

Logan
