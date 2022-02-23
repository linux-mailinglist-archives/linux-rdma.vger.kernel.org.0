Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA15F4C1DE4
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 22:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiBWVpG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 23 Feb 2022 16:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiBWVpF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 16:45:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 210424F464
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 13:44:36 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-27-hCb7lGpjNMCFd8pZEvh5ow-1; Wed, 23 Feb 2022 21:44:34 +0000
X-MC-Unique: hCb7lGpjNMCFd8pZEvh5ow-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 23 Feb 2022 21:44:32 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 23 Feb 2022 21:44:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>
Subject: RE: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Thread-Topic: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Thread-Index: AQHYKOavPScLVMZqEkOT//Q3noWC2qyhqG0w
Date:   Wed, 23 Feb 2022 21:44:32 +0000
Message-ID: <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
References: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko
> Sent: 23 February 2022 18:54
> 
> While in this particular case it would not be a (critical) issue,
> the pattern itself is bad and error prone in case somebody blindly
> copies to their code.

It is horribly wrong on BE systems.

> Don't cast parameter to unsigned long pointer in the bit operations.
> Instead copy to a local variable on stack of a proper type and use.
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
> index f1245c94ae26..100274b926d3 100644
> --- a/drivers/infiniband/hw/hfi1/chip.c
> +++ b/drivers/infiniband/hw/hfi1/chip.c
> @@ -8286,34 +8286,33 @@ static void is_interrupt(struct hfi1_devdata *dd, unsigned int source)
>  irqreturn_t general_interrupt(int irq, void *data)
>  {
>  	struct hfi1_devdata *dd = data;
> -	u64 regs[CCE_NUM_INT_CSRS];
> +	DECLARE_BITMAP(pending, CCE_NUM_INT_CSRS * 64);
> +	u64 value;
>  	u32 bit;
>  	int i;
> -	irqreturn_t handled = IRQ_NONE;
> 
>  	this_cpu_inc(*dd->int_counter);
> 
>  	/* phase 1: scan and clear all handled interrupts */
>  	for (i = 0; i < CCE_NUM_INT_CSRS; i++) {
> -		if (dd->gi_mask[i] == 0) {
> -			regs[i] = 0;	/* used later */
> -			continue;
> -		}
> -		regs[i] = read_csr(dd, CCE_INT_STATUS + (8 * i)) &
> -				dd->gi_mask[i];
> +		if (dd->gi_mask[i] == 0)
> +			value = 0;	/* used later */
> +		else
> +			value = read_csr(dd, CCE_INT_STATUS + (8 * i)) & dd->gi_mask[i];
> +
> +		/* save for further use */
> +		bitmap_from_u64(&pending[BITS_TO_LONGS(i * 64)], value);
> +
>  		/* only clear if anything is set */
> -		if (regs[i])
> -			write_csr(dd, CCE_INT_CLEAR + (8 * i), regs[i]);
> +		if (value)
> +			write_csr(dd, CCE_INT_CLEAR + (8 * i), value);
>  	}

I think I'd leave all that alone.

>  	/* phase 2: call the appropriate handler */
> -	for_each_set_bit(bit, (unsigned long *)&regs[0],
> -			 CCE_NUM_INT_CSRS * 64) {
> +	for_each_set_bit(bit, pending, CCE_NUM_INT_CSRS * 64)

And do something else for that loop instead.

>  		is_interrupt(dd, bit);
> -		handled = IRQ_HANDLED;
> -	}
> 
> -	return handled;
> +	return IRQ_RETVAL(!bitmap_empty(pending, CCE_NUM_INT_CSRS * 64));

You really don't want to scan the bitmap again.

Actually, of the face of it, you could merge the two loops.
Provided you clear the status bit before calling the relevant
handler I expect it will all work.

	David

>  }
> 
>  irqreturn_t sdma_interrupt(int irq, void *data)
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

