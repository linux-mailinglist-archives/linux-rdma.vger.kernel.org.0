Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26883A16AB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 16:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhFIOMr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 9 Jun 2021 10:12:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:23069 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233973AbhFIOMr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 10:12:47 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-135-KqF7Lqu8Nku1OHO-uhUTIA-1; Wed, 09 Jun 2021 15:10:44 +0100
X-MC-Unique: KqF7Lqu8Nku1OHO-uhUTIA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Wed, 9 Jun 2021 15:10:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 9 Jun 2021 15:10:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Tom Talpey" <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Topic: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Index: AQHXXS5Xb0qnCJaKiUGWJCqTq1wvwKsLs9tw
Date:   Wed, 9 Jun 2021 14:10:43 +0000
Message-ID: <6b370a8fde1e406192d37c748b79ad01@AcuMS.aculab.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
In-Reply-To: <20210609125241.GA1347@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Christoph Hellwig
> Sent: 09 June 2021 13:53
> 
> On Wed, Jun 09, 2021 at 02:05:03PM +0300, Leon Romanovsky wrote:
> > From: Avihai Horon <avihaih@nvidia.com>
> >
> > Relaxed Ordering is a capability that can only benefit users that support
> > it. All kernel ULPs should support Relaxed Ordering, as they are designed
> > to read data only after observing the CQE and use the DMA API correctly.
> >
> > Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
> >
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Changelog:
> > v2:
> >  * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
> >    eth side of mlx5 driver.
> 
> This looks great in terms of code changes.  But can we please also add a
> patch to document that PCIe relaxed ordering is fine for kernel ULP usage
> somewhere?

Several things need to happen to use relaxed ordering:
1) The pcie target has to be able to use RO for buffer writes
   and non-RO for control writes.
2) The Linux driver has to enable (1).
3) The generic Linux kernel has to 'not mask' RO on all the PCIe
   bridges and root.
4) The hardware memory system has to 'not break' when passes a RO write.

The comments about the DMA API are almost pointless.
They'd only be relevant if the driver has looking for the last
byte of a buffer to change - and then assuming the rest is valid.

This patch looks like a driver patch - so is changing (2) above.

I've seen another patch that (I think) is enabling (3).
Although some X86 cpu are known to be broken (aka 4).

And I still don't know what a ULP is.

I actually know a bit about TLP.
I found (and fixed) a bug in the Altera/Intel fpga logic
where it didn't like receiving two data TLP in response
to a single read TLP.
We've also (now) got logic in the fpga that traces all received
and sent TLP to an internal memory block.
So I can see what the cpus we have actually generate.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

