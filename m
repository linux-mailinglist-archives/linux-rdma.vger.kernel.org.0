Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD21396962
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEaVrc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 31 May 2021 17:47:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:45448 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhEaVrb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 May 2021 17:47:31 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-218-QcibLrlaM6yjUOYyIZz7xA-1; Mon, 31 May 2021 22:45:48 +0100
X-MC-Unique: QcibLrlaM6yjUOYyIZz7xA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.18; Mon, 31 May 2021 22:45:47 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.018; Mon, 31 May 2021 22:45:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "Chuck Lever III" <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        "Honggang LI" <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Thread-Topic: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Thread-Index: AQHXUmWU6o4h3uGgPUqVoazWtMs6IKr2+KAAgAbjPQCAAEmEoA==
Date:   Mon, 31 May 2021 21:45:47 +0000
Message-ID: <2fe802bdebbd44619447c83ed7e30a74@AcuMS.aculab.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <20210526193021.GA3644646@nvidia.com>
 <5ae77009a18a4ea2b309f3ca4e4095f9@AcuMS.aculab.com>
 <20210531181352.GZ1002214@nvidia.com>
In-Reply-To: <20210531181352.GZ1002214@nvidia.com>
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
> Sent: 31 May 2021 19:14
> 
> On Thu, May 27, 2021 at 08:11:14AM +0000, David Laight wrote:
> > > There was such a big discussion on the last version I wondered why
> > > this was so quiet. I guess because the cc list isn't very big..
> > >
> > > Adding the people from the original thread, here is the patches:
> > >
> > > https://lore.kernel.org/linux-rdma/cover.1621505111.git.leonro@nvidia.com/
> > >
> > > I think this is the general approach that was asked for, to special case
> > > uverbs and turn it on in kernel universally
> >
> > I'm still not sure which PCIe transactions you are enabling relaxed
> > ordering for.  Nothing has ever said that in layman's terms.
> >
> > IIRC PCIe targets (like ethernet chips) can use relaxed ordered
> > writes for frame contents but must use strongly ordered writes
> > for the corresponding ring (control structure) updates.
> 
> Right, it is exactly like this, just not expressed in ethernet
> specific terms.
> 
> Data transfer TLPs are relaxed ordered and control structure TLPs are
> normal ordered.

So exactly what is this patch doing?

'Enabling relaxed ordering' sounds like something that is setting
the 'relaxed ordering' bit in TLP.
Doing that in any global fashion is clearly broken.

OTOH if it is (effectively) stopping the clearing of the 'relaxed ordering'
bit by one of the PCIe bridges (or the root complex) then it is rather
different.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

