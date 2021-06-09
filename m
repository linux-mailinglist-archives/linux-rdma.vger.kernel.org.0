Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E47E3A1887
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhFIPI2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 9 Jun 2021 11:08:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:32894 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238904AbhFIPHw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Jun 2021 11:07:52 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-22-nQAdNe3mNZiykotJYw6mLA-1; Wed, 09 Jun 2021 16:05:53 +0100
X-MC-Unique: nQAdNe3mNZiykotJYw6mLA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Wed, 9 Jun 2021 16:05:52 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Wed, 9 Jun 2021 16:05:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chuck Lever III' <chuck.lever@oracle.com>
CC:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Tom Talpey" <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Topic: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Thread-Index: AQHXXS5Xb0qnCJaKiUGWJCqTq1wvwKsLs9tw///62wCAABWUYA==
Date:   Wed, 9 Jun 2021 15:05:52 +0000
Message-ID: <25c32f2a147a4dff8b7d6577286d7954@AcuMS.aculab.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <20210609125241.GA1347@lst.de>
 <6b370a8fde1e406192d37c748b79ad01@AcuMS.aculab.com>
 <ACCBE9AD-9A59-4300-A872-69EDBB4D4203@oracle.com>
In-Reply-To: <ACCBE9AD-9A59-4300-A872-69EDBB4D4203@oracle.com>
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

From: Chuck Lever III
> Sent: 09 June 2021 15:37
> 
> Hi David-
> 
> > On Jun 9, 2021, at 10:10 AM, David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > And I still don't know what a ULP is.
> 
> Upper Layer Protocol.
> 
> That's a generic term for an RDMA verbs consumer, like NVMe or
> RPC-over-RDMA.

No wonder I don't spot what it meant.
I'm guessing you have something specific in mind for RDMA as well.

Don't assume that everyone has read all the high level protocol
specs (and remembers the all the TLA (and ETLA)) when talking
about very low level hardware features.

Especially when you are also referring to how the 'relaxed ordering'
bit of a PCIe write TLP is processed.

This all makes your commit message even less meaningful.

In principle some writel() could generate PCIe write TLP (going
to the target) that have the 'relaxed ordering' bit set.
So a ULP that supports relaxed ordering could actually expect
to generate them - even though there is probably no method
of setting the bit.
Although, in principle, I guess that areas that are 'prefetchable'
(for reads) could be deemed suitable for relaxed writes.
(That way probably lies madness and a load of impossible to fix
timing bugs!)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

