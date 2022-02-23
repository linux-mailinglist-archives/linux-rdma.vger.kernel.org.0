Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86E4C1F19
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 23:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiBWWuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 23 Feb 2022 17:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiBWWuv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 17:50:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B4204F9E5
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 14:50:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-CJOJkAA1OIaRjB3SuCR2iQ-1; Wed, 23 Feb 2022 22:50:20 +0000
X-MC-Unique: CJOJkAA1OIaRjB3SuCR2iQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 23 Feb 2022 22:50:19 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 23 Feb 2022 22:50:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: RE: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Thread-Topic: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Thread-Index: AQHYKOavPScLVMZqEkOT//Q3noWC2qyhqG0wgAAPkwCAAAGzUA==
Date:   Wed, 23 Feb 2022 22:50:19 +0000
Message-ID: <efb8c82c626a4c7d8a9f781d63289343@AcuMS.aculab.com>
References: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
 <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
 <Yha1bIYZpCWZIowl@smile.fi.intel.com>
In-Reply-To: <Yha1bIYZpCWZIowl@smile.fi.intel.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: 'Andy Shevchenko'
> Sent: 23 February 2022 22:30
> 
> On Wed, Feb 23, 2022 at 09:44:32PM +0000, David Laight wrote:
> > From: Andy Shevchenko
> > > Sent: 23 February 2022 18:54
> > >
> > > While in this particular case it would not be a (critical) issue,
> > > the pattern itself is bad and error prone in case somebody blindly
> > > copies to their code.
> >
> > It is horribly wrong on BE systems.
> 
> You mean the pattern? Yes, it has three issues regarding to endianess and
> potential out of boundary access.

Never mind the misaligned page-boundary-crossing locked access.

> ...
> 
> > > -	return handled;
> > > +	return IRQ_RETVAL(!bitmap_empty(pending, CCE_NUM_INT_CSRS * 64));
> 
> > You really don't want to scan the bitmap again.
> 
> Either way it wastes cycles, the outcome depends on the actual distribution of
> the interrupts across the bitmap. If it gathered closer to the beginning of the
> bitmap, my code wins, otherwise the original ones.

The loop in bitmap_empty() will kill you - even if the first word in non-zero.

Or just 'or' together the 'value' written to clear the pending interrupts
in the first loop.

Or just return IRQ_HANDLED ;-)
Depending on exactly how the interrupt system works on you hardware
it is perfectly possible to get another ISR entry for an IRQ bit
you just cleared.
Which can generate a 'spurious interrupt' message when IRQ_HANDLED
isn't returned (maybe not in Linux...)

It is easiest to see how that can happen with a level sensitive interrupt
request.
The write to clear the pending register can get delayed (posted bus write)
long enough for the cpu to have actually exited the ISR.
So the IRQ line is still set and the ISR re-entered.
But no pending bits are now set.

Put enough PCIe bridges in a system and overload PCIe links and you
might get the same to happen for MSI-X.
Especially since there will be additional delays on the device itself
converting the internal IRQ into the required PCIe write.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

