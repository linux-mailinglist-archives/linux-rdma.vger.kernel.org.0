Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D19FCE6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 10:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfH1I1v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 28 Aug 2019 04:27:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29109 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbfH1I1v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 04:27:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-44-7Eyd5yFUMV6GmCf8-LeV7A-1; Wed, 28 Aug 2019 09:27:48 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 28 Aug 2019 09:27:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 28 Aug 2019 09:27:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Thread-Topic: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Thread-Index: AQHVXQXl4BhhBlFhpEW57H2RBHAQPacQOptA
Date:   Wed, 28 Aug 2019 08:27:45 +0000
Message-ID: <ab04933a7dea42049d20597cb65d84f1@AcuMS.aculab.com>
References: <20190819100526.13788-1-geert@linux-m68k.org>
         <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
         <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
         <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com>
         <CAMuHMdWHGTMwK+PO_BgsNZMpqRat1SHE-_CP0UqxEALA_OJeNg@mail.gmail.com>
         <20190827174639.GT1131@ZenIV.linux.org.uk>
         <CAMuHMdW0jEpE3YrA5Znq8O9e4eswARwYYerEhRLSLWxeXMbsEQ@mail.gmail.com>
 <b0fe444622e32af6c34f3326e5dce3513adf5113.camel@perches.com>
In-Reply-To: <b0fe444622e32af6c34f3326e5dce3513adf5113.camel@perches.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 7Eyd5yFUMV6GmCf8-LeV7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Joe Perches
> Sent: 27 August 2019 19:33
> On Tue, 2019-08-27 at 19:59 +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 27, 2019 at 7:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Tue, Aug 27, 2019 at 07:29:52PM +0200, Geert Uytterhoeven wrote:
> > > > On Tue, Aug 27, 2019 at 4:17 PM David Laight <David.Laight@aculab.com> wrote:
> > > > > From: Geert Uytterhoeven
> > > > > > Sent: 19 August 2019 18:15
> > > > > ...
> > > > > > > I think a cast to unsigned long is rather more common.
> > > > > > >
> > > > > > > uintptr_t is used ~1300 times in the kernel.
> > > > > > > I believe a cast to unsigned long is much more common.
> 
> btw: apparently that's not true.
> 
> This grep may be incomplete but it seems there are fewer
> kernel uses of a cast to unsigned long then pointer:
> 
> $ git grep -P '\(\s*\w+(\s+\w+){0,3}(\s*\*)+\s*\)\s*\(\s*unsigned\s+long\s*\)'|wc -l
> 423
> 
> Maybe add a cast_to_ptr macro like
> 
> #define cast_to_ptr(type, val)	((type)(uintptr_t)(val))
> 
> though that may not save any horizontal space

And it is another bit of pointless obfuscation....

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

