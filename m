Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2E864E3BD
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLOWVD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 15 Dec 2022 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLOWVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 17:21:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8926140D2
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 14:21:00 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-GnYbIbJHMruV7_PN1JoaEQ-1; Thu, 15 Dec 2022 22:20:57 +0000
X-MC-Unique: GnYbIbJHMruV7_PN1JoaEQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 15 Dec
 2022 22:20:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Thu, 15 Dec 2022 22:20:55 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Topic: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Index: AQHZEKfEZmHYt+KmU0GxS8VCrAg8Pq5vhR6A
Date:   Thu, 15 Dec 2022 22:20:55 +0000
Message-ID: <1bba42a31e0a487bbbf67955b674583e@AcuMS.aculab.com>
References: <20221215170347.2612403-1-arnd@kernel.org>
In-Reply-To: <20221215170347.2612403-1-arnd@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann
> Sent: 15 December 2022 17:04
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous build fix left a remaining issue in configurations
> with 64-bit dma_addr_t on 32-bit architectures:
> 
> drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_get_pblpage':
> drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: error: cast to pointer from integer of different size [-
> Werror=int-to-pointer-cast]
>    32 |                 return virt_to_page((void *)paddr);
>       |                                     ^
> 
> Use the same double cast here that the driver uses elsewhere
> to convert between dma_addr_t and void*.
> 
> It took me a while to figure out why this driver does it
> like this, as there is no hardware access and it just stores
> kernel pointers in place of device addresses when communicating
> with the rdma core and with user space.

I hope that doesn't mean it is relying on user space only
giving it back valid values?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

