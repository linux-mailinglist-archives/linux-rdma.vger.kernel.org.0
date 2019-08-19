Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEBA94FFB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 23:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHSVkS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 17:40:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbfHSVkS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 17:40:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JLbALW145140
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 17:40:17 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufyyvrw22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 17:40:16 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 21:40:16 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 21:40:11 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2019081921401079-999766 ;
          Mon, 19 Aug 2019 21:40:10 +0000 
In-Reply-To: <20190819180004.GL5058@ziepe.ca>
Subject: Re: Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit
 due to u64/pointer abuse
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 21:40:10 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190819180004.GL5058@ziepe.ca>,<20190819141856.GG5058@ziepe.ca>
 <20190819135213.GF5058@ziepe.ca> <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
 <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
 <OFFE3BC87B.CF197FD5-ON0025845B.0059957B-0025845B.005A903D@notes.na.collabserv.com>
 <OF0F37B635.09509188-ON0025845B.005BF4A4-0025845B.0060F5F0@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 9831
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081921-3067-0000-0000-0000006B8069
X-IBM-SpamModules-Scores: BY=0.276324; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.425523; ST=0; TS=0; UL=0; ISC=; MB=0.373937
X-IBM-SpamModules-Versions: BY=3.00011620; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249231; UDB=6.00659450; IPR=6.01030766;
 MB=3.00028239; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 21:40:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 19:41:45 - 6.00010305
x-cbparentid: 19081921-3068-0000-0000-00001162BF2E
Message-Id: <OF399EF474.834C3102-ON0025845B.006D75AA-0025845B.007708F2@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/19/2019 08:00PM
>Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix
>compiler warnings on 32-bit due to u64/pointer abuse
>
>On Mon, Aug 19, 2019 at 05:39:04PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 08/19/2019 06:35PM
>> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
>> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>> >linux-kernel@vger.kernel.org
>> >Subject: [EXTERNAL] Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix
>> >compiler warnings on 32-bit due to u64/pointer abuse
>> >
>> >On Mon, Aug 19, 2019 at 04:29:11PM +0000, Bernard Metzler wrote:
>> >> 
>> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >> >Date: 08/19/2019 06:05PM
>> >> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
>> >> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>> >> >linux-kernel@vger.kernel.org
>> >> >Subject: [EXTERNAL] Re: Re: Re: Re: [PATCH] RDMA/siw: Fix
>compiler
>> >> >warnings on 32-bit due to u64/pointer abuse
>> >> >
>> >> >On Mon, Aug 19, 2019 at 03:54:56PM +0000, Bernard Metzler
>wrote:
>> >> >
>> >> >> Absolutely. But these addresses are conveyed through the
>> >> >> API as unsigned 64 during post_send(), and land in the siw
>> >> >> send queue as is. During send queue processing, these
>addresses
>> >> >> must be interpreted according to its context and transformed
>> >> >> (casted) back to the callers intention. I frankly do not
>> >> >> know what we can do differently... The representation of
>> >> >> all addresses as unsigned 64 is given. Sorry for the
>confusion.
>> >> >
>> >> >send work does not have pointers in it, so I'm confused what
>this
>> >is
>> >> >about. Does siw allow userspace to stick an ordinary pointer
>for
>> >the
>> >> >SG list?
>> >> 
>> >> Right a user references a buffer by address and local key it
>> >> got during reservation of that buffer. The user can provide any
>> >> VA between start of that buffer and registered length. 
>> >
>> >Oh gross, it overloads the IOVA in the WR with a kernel void * ??
>> 
>> Oh no. The user library writes the buffer address into
>> the 64bit address field of the WR. This is nothing siw
>> has invented.
>
>No HW provider sticks pointers into the WR ring.

Now siw is a SW only provider. It sits on top of TCP
kernel sockets. siw translates any local application buffer
reference it gets back into a kvec or page pointer (transmit
from), or a virtual address (receive into). This is what the 
TCP interface wants.

In fact, siw cares about physical addresses only since the RDMA
(kernel level) user may care about it. It translates those back
into something the TCP interface can consume. 
>
>It is either an iova & lkey pair, or SGE information is inlined into
>the WR ring.
>
In siw, the reference to any type of memory is kept uninterpreted
in the send/receive queue until it gets accessed by a data
transfer. The information on what type of memory is being referenced
is deducted from the local memory key. As said, this step is
being executed only when the actual buffer is to be touched.
All it needs before that translation is to keep the 32bit key +
length and the up to 64bit address in a work queue element within
the send queue.
lkey lookup and memory translation + access validation happens
after the work queue element left the send/receive queue and a
local copy of it is being processed by the kernel driver
during RX or TX operations.

Inline data is implemented similar to how HW providers do
it - user data are copied immediately into the WR array.

>Never, ever, a user or kernel pointer.
>
>The closest we get to a kernel pointer is with the local dma lkey &
>iova == physical memory address.
>
>> >Why does siw_pbl_get_buffer not return a void *??
>>
>> 
>> I think, in fact, it should be dma_addr_t, since this is
>> what PBL's are described with. Makes sense?
>
>You mean because siw uses dma_virt_ops and can translate a dma_addr_t
>back to a pfn? Yes, that would make alot more sense.
>
>If all conversions went explicitly from a iova & lkey -> dma_addr_t
>-> void * in
>the kmap then I'd be a lot happier
>
>Jason
>
>

