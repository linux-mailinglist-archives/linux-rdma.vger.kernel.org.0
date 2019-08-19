Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0D94BDD
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 19:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfHSRjM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 13:39:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbfHSRjM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 13:39:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JHc4mA048222
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 13:39:11 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.104])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufwytdxu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 13:39:11 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 17:39:11 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.44) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 17:39:04 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019081917390429-682222 ;
          Mon, 19 Aug 2019 17:39:04 +0000 
In-Reply-To: <20190819163521.GK5058@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:39:04 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190819163521.GK5058@ziepe.ca>,<20190819150723.GH5058@ziepe.ca>
 <20190819141856.GG5058@ziepe.ca> <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
 <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
 <OFFE3BC87B.CF197FD5-ON0025845B.0059957B-0025845B.005A903D@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 0F37B635:09509188-0025845B:005BF4A4;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 16519
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081917-5525-0000-0000-00000099A0F5
X-IBM-SpamModules-Scores: BY=0.002691; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.052891
X-IBM-SpamModules-Versions: BY=3.00011618; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249150; UDB=6.00659401; IPR=6.01030686;
 MB=3.00028236; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 17:39:08
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 14:25:48 - 6.00010304
x-cbparentid: 19081917-5526-0000-0000-00000F47B5DF
Message-Id: <OF0F37B635.09509188-ON0025845B.005BF4A4-0025845B.0060F5F0@notes.na.collabserv.com>
Subject: RE: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due
 to u64/pointer abuse
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/19/2019 06:35PM
>Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix
>compiler warnings on 32-bit due to u64/pointer abuse
>
>On Mon, Aug 19, 2019 at 04:29:11PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 08/19/2019 06:05PM
>> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
>> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>> >linux-kernel@vger.kernel.org
>> >Subject: [EXTERNAL] Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler
>> >warnings on 32-bit due to u64/pointer abuse
>> >
>> >On Mon, Aug 19, 2019 at 03:54:56PM +0000, Bernard Metzler wrote:
>> >
>> >> Absolutely. But these addresses are conveyed through the
>> >> API as unsigned 64 during post_send(), and land in the siw
>> >> send queue as is. During send queue processing, these addresses
>> >> must be interpreted according to its context and transformed
>> >> (casted) back to the callers intention. I frankly do not
>> >> know what we can do differently... The representation of
>> >> all addresses as unsigned 64 is given. Sorry for the confusion.
>> >
>> >send work does not have pointers in it, so I'm confused what this
>is
>> >about. Does siw allow userspace to stick an ordinary pointer for
>the
>> >SG list?
>> 
>> Right a user references a buffer by address and local key it
>> got during reservation of that buffer. The user can provide any
>> VA between start of that buffer and registered length. 
>
>Oh gross, it overloads the IOVA in the WR with a kernel void * ??

Oh no. The user library writes the buffer address into
the 64bit address field of the WR. This is nothing siw
has invented.


>
>> >The code paths here must be totally different, so there should be
>> >different types and functions for each case.
>> 
>> Yes, there is a function to process application memory
>(siw_rx_umem),
>> to process a kernel PBL (siw_rx_pbl), and one to process kernel
>> addresses (siw_rx_kva). Before running that function, the API
>> representation of the current SGE gets translated into target
>> buffer representation.
>
>Why does siw_pbl_get_buffer not return a void *??
>

I think, in fact, it should be dma_addr_t, since this is
what PBL's are described with. Makes sense?


>Still looks like two types have been crammed together.
>
>The kernel can't ever store anything into the user WQE buffer, so I
>would think it would copy the buffer to kernel space, transform it
>properly and then refer to it as a kernel buffer. Kernel sourced
>buffers just skip the transofmration.

This is in fact what happens. siw just does not copy immediately
during post send, but maintains a mmapped shared send queue.
The kernel driver copies the current element from the send queue
and processes it. Only then the current element gets transformed
into the right buffer representation, since it is not being
accessed before.


Thanks
Bernard.
>
>JAson
>
>

