Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5608665C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbfHHP7S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 11:59:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55280 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390115AbfHHP7R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 11:59:17 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hvkoc-00029F-KI; Thu, 08 Aug 2019 09:58:59 -0600
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
 <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>
 <20190808073109.GC29852@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ae77f630-81dc-62e8-727c-add3578ca002@deltatee.com>
Date:   Thu, 8 Aug 2019 09:58:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808073109.GC29852@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, epilmore@gigaio.com, dan.j.williams@intel.com, axboe@fb.com, kbusch@kernel.org, sagi@grimberg.me, jgg@mellanox.com, Christian.Koenig@amd.com, bhelgaas@google.com, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-08-08 1:31 a.m., Christoph Hellwig wrote:
> On Wed, Aug 07, 2019 at 09:58:06AM -0600, Logan Gunthorpe wrote:
>> We only calculate it at the same time as we calculate the distance. This
>> is necessary because, to calculate the type, we have to walk the tree
>> and check the ACS bits. If we separated it, we'd have to walk the tree
>> twice in a very similar way just to determine both the distance and the
>> mapping type.
> 
> Calculating it together makes perfect sense.  What I find odd is the
> overloading of a single return value.  Why not return the map type as
> the return value, and the distance as a by reference argument to keep
> them properly separated?

Ok, understood. I'll make that change and send some incremental patches
to Bjorn tomorrow.

Logan
