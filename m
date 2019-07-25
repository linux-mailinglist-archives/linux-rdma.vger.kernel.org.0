Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD4757A4
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfGYTPA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 15:15:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42188 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfGYTPA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jul 2019 15:15:00 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqjCQ-0003h1-UD; Thu, 25 Jul 2019 13:14:47 -0600
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-7-logang@deltatee.com>
 <20190725185230.GG7450@mellanox.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dc151716-d584-35df-0de6-d25c1267be6c@deltatee.com>
Date:   Thu, 25 Jul 2019 13:14:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725185230.GG7450@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, Christian.Koenig@amd.com, hch@lst.de, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jgg@mellanox.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 06/14] PCI/P2PDMA: Add whitelist support for Intel Host
 Bridges
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-07-25 12:52 p.m., Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 05:08:51PM -0600, Logan Gunthorpe wrote:
>> Intel devices do not have good support for P2P requests that span
>> different host bridges as the transactions will cross the QPI/UPI bus
>> and this does not perform well.
>>
>> Therefore, enable support for these devices only if the host bridges
>> match.
>>
>> Adds the Intel device's that have been tested to work. There are
>> likely many others out there that will need to be tested and added.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/pci/p2pdma.c | 36 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index dfb802afc8ca..143e11d2a5c3 100644
>> +++ b/drivers/pci/p2pdma.c
>> @@ -250,9 +250,28 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>>  }
>>  
>> -static bool __host_bridge_whitelist(struct pci_host_bridge *host)
>> +static const struct pci_p2pdma_whitelist_entry {
>> +	unsigned short vendor;
>> +	unsigned short device;
>> +	bool req_same_host_bridge;
> 
> This would be more readable in the initializer as a flags not a bool

Ok, will change for v2.

Logan
