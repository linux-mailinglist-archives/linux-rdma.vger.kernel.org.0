Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9D3A1A1C
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhFIPu1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 9 Jun 2021 11:50:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:38061 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236225AbhFIPu0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 11:50:26 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-GQipw093PZmHTRm0NPY0xg-1; Wed, 09 Jun 2021 16:48:28 +0100
X-MC-Unique: GQipw093PZmHTRm0NPY0xg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Wed, 9 Jun 2021 16:48:27 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 9 Jun 2021 16:48:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     'Chuck Lever III' <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Topic: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Index: AQHXXS5Xb0qnCJaKiUGWJCqTq1wvwKsLs9tw///62wCAABWUYP//83AAgAAWdEA=
Date:   Wed, 9 Jun 2021 15:48:27 +0000
Message-ID: <1a3512e2891642a193004ee4450a11dd@AcuMS.aculab.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
 <6b370a8fde1e406192d37c748b79ad01@AcuMS.aculab.com>
 <ACCBE9AD-9A59-4300-A872-69EDBB4D4203@oracle.com>
 <25c32f2a147a4dff8b7d6577286d7954@AcuMS.aculab.com>
 <20210609150922.GA1109697@nvidia.com>
In-Reply-To: <20210609150922.GA1109697@nvidia.com>
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

From: Jason Gunthorpe
> Sent: 09 June 2021 16:09
> 
> On Wed, Jun 09, 2021 at 03:05:52PM +0000, David Laight wrote:
> 
> > In principle some writel() could generate PCIe write TLP (going
> > to the target) that have the 'relaxed ordering' bit set.
> 
> In Linux we call this writel_relaxed(), though I know of no
> implementation that sets the RO bit in the TLP based on this, it would
> be semantically correct to do so.
> 
> writel() has strong order requirements and must not generate a RO TLP.

Somewhere I'd forgotten about that :-(
It usually just allows the compiler and cpu hardware re-sequence
the bus cycles.

OTOH I doubt any/many PCIe targets have 'memory' areas that would
benefit from RO write TLP.
Especially since everything is organised to use target issued buffer
copies.

I'm guessing that the benefits from RO are when the writes hit memory
that is on a NUMA node or 'differently cached'.
So writes to once cache line can proceed while earlier writes are
still waiting for the cache-coherency protocol.

From what I've seen writel() aren't too bad - they are async.
The real problem is readl().
The x86 cpu I have use a separate TLP id (I've forgotten the correct
term) for each cpu core.
So while multiple cpu can (and do) issue concurrent reads, reads from
a single cpu happen one TLP at a time - even though it would be legitimate
for the out-of-order execution unit to issue additional read TLP.
There are times when you really do have to do PIO buffer reads :-(

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

