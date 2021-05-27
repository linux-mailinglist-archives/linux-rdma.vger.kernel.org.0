Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0C392943
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhE0IMy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 27 May 2021 04:12:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:35279 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235251AbhE0IMx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 May 2021 04:12:53 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-279-KkwZFJaGNEGUEK60W_pQZA-1; Thu, 27 May 2021 09:11:15 +0100
X-MC-Unique: KkwZFJaGNEGUEK60W_pQZA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 09:11:14 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Thu, 27 May 2021 09:11:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jason Gunthorpe' <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Thread-Topic: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Thread-Index: AQHXUmWU6o4h3uGgPUqVoazWtMs6IKr2+KAA
Date:   Thu, 27 May 2021 08:11:14 +0000
Message-ID: <5ae77009a18a4ea2b309f3ca4e4095f9@AcuMS.aculab.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <20210526193021.GA3644646@nvidia.com>
In-Reply-To: <20210526193021.GA3644646@nvidia.com>
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
> Sent: 26 May 2021 20:30
> 
> On Thu, May 20, 2021 at 01:13:34PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Changelog:
> > v1:
> >  * Enabled by default RO in IB/core instead of changing all users
> > v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
> >
> > >From Avihai,
> >
> > Relaxed Ordering is a PCIe mechanism that relaxes the strict ordering
> > imposed on PCI transactions, and thus, can improve performance for
> > applications that can handle this lack of strict ordering.
> >
> > Currently, relaxed ordering can be set only by user space applications
> > for user MRs. Not all user space applications support relaxed ordering
> > and for this reason it was added as an optional capability that is
> > disabled by default. This behavior is not changed as part of this series,
> > and relaxed ordering remains disabled by default for user space.
> >
> > On the other hand, kernel users should universally support relaxed
> > ordering, as they are designed to read data only after observing the CQE
> > and use the DMA API correctly. There are a few platforms with broken
> > relaxed ordering implementation, but for them relaxed ordering is expected
> > to be turned off globally in the PCI level. In addition, note that this is
> > not the first use of relaxed ordering. Relaxed ordering has been enabled
> > by default in mlx5 ethernet driver, and user space apps use it as well for
> > quite a while.
> >
> > Hence, this series enabled relaxed ordering by default for kernel users so
> > they can benefit as well from the performance improvements.
> >
> > The following test results show the performance improvement achieved
> > with relaxed ordering. The test was performed by running FIO traffic
> > between a NVIDIA DGX A100 (ConnectX-6 NICs and AMD CPUs) and a NVMe
> > storage fabric, using NFSoRDMA:
> >
> > Without Relaxed Ordering:
> > READ: bw=16.5GiB/s (17.7GB/s), 16.5GiB/s-16.5GiB/s (17.7GB/s-17.7GB/s),
> > io=1987GiB (2133GB), run=120422-120422msec
> >
> > With relaxed ordering:
> > READ: bw=72.9GiB/s (78.2GB/s), 72.9GiB/s-72.9GiB/s (78.2GB/s-78.2GB/s),
> > io=2367GiB (2542GB), run=32492-32492msec
> >
> > The series has been tested over NVMe, iSER, SRP and NFS with ConnectX-6
> > NIC. The tests included FIO verify and stress tests, and various
> > resiliency tests (shutting down NIC port in the middle of traffic,
> > rebooting the target in the middle of traffic etc.).
> 
> There was such a big discussion on the last version I wondered why
> this was so quiet. I guess because the cc list isn't very big..
> 
> Adding the people from the original thread, here is the patches:
> 
> https://lore.kernel.org/linux-rdma/cover.1621505111.git.leonro@nvidia.com/
> 
> I think this is the general approach that was asked for, to special case
> uverbs and turn it on in kernel universally

I'm still not sure which PCIe transactions you are enabling relaxed
ordering for.
Nothing has ever said that in layman's terms.

IIRC PCIe targets (like ethernet chips) can use relaxed ordered
writes for frame contents but must use strongly ordered writes
for the corresponding ring (control structure) updates.

If the kernel is issuing relaxed ordered writes then the same
conditions would need to be satisfied.
CPU barrier instructions are unlikely to affect what happens
once a (posted) write is issued - but the re-ordering happens
at the PCIe bridges or actual targets.
So barrier instructions are unlikely to help.

I'm not sure what a 'MR' is in this context.
But if you are changing the something that is part of the
virtual to physical address mapping then such a global
change is actually likely to break anything that cares.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

