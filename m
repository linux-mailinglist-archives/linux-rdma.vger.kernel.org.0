Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF394BAA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHSR1F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 13:27:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727459AbfHSR1F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 13:27:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JHOmMA068927
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 13:27:02 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufx6mn0ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 13:27:02 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 17:27:01 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 17:26:55 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019081917265382-695667 ;
          Mon, 19 Aug 2019 17:26:53 +0000 
In-Reply-To: <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
Subject: Re:  Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to u64/pointer
 abuse
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Joe Perches" <joe@perches.com>,
        "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Aug 2019 17:26:53 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>,<20190819100526.13788-1-geert@linux-m68k.org>
 <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 7DF1711D:F2EB24AC-0025845B:005FD8A6;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 51339
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081917-7691-0000-0000-0000003C8DED
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.411265; ST=0; TS=0; UL=0; ISC=; MB=0.046017
X-IBM-SpamModules-Versions: BY=3.00011618; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249147; UDB=6.00659399; IPR=6.01030681;
 MB=3.00028236; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 17:26:59
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 14:28:44 - 6.00010304
x-cbparentid: 19081917-7692-0000-0000-00000061A795
Message-Id: <OF7DF1711D.F2EB24AC-ON0025845B.005FD8A6-0025845B.005FD8AD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



---
Bernard Metzler, PhD
Tech. Leader High Performance I/O, Principal Research Staff
IBM Zurich Research Laboratory
Saeumerstrasse 4
CH-8803 Rueschlikon, Switzerland
+41 44 724 8605

-----"Geert Uytterhoeven" <geert@linux-m68k.org> wrote: -----

>To: "Joe Perches" <joe@perches.com>
>From: "Geert Uytterhoeven" <geert@linux-m68k.org>
>Date: 08/19/2019 07:15PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "linux-rdma"
><linux-rdma@vger.kernel.org>, "Linux Kernel Mailing List"
><linux-kernel@vger.kernel.org>
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix compiler warnings on
>32-bit due to u64/pointer abuse
>
>Hi Joe,
>
>On Mon, Aug 19, 2019 at 6:56 PM Joe Perches <joe@perches.com> wrote:
>> On Mon, 2019-08-19 at 12:05 +0200, Geert Uytterhoeven wrote:
>> > When compiling on 32-bit:
>> >
>> >     drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to
>pointer from integer of different size [-Wint-to-pointer-cast]
>> >     drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from
>pointer to integer of different size [-Wpointer-to-int-cast]
>> []
>> > Fix this by applying the following rules:
>> >   1. When printing a u64, the %llx format specififer should be
>used,
>> >      instead of casting to a pointer, and printing the latter.
>> >   2. When assigning a pointer to a u64, the pointer should be
>cast to
>> >      uintptr_t, not u64,
>> >   3. When casting from u64 to pointer, an intermediate cast to
>uintptr_t
>> >      should be added,
>>
>> I think a cast to unsigned long is rather more common.
>>
>> uintptr_t is used ~1300 times in the kernel.
>> I believe a cast to unsigned long is much more common.
>
>That is true, as uintptr_t was introduced in C99.
>Similarly, unsigned long was used before size_t became common.
>
>However, nowadays size_t and uintptr_t are preferred.
>
>> It might be useful to add something to the Documentation
>> for this style.  Documentation/process/coding-style.rst
>>
>> And trivia:
>>
>> > > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>> []
>> > @@ -842,8 +842,8 @@ int siw_post_send(struct ib_qp *base_qp,
>const struct ib_send_wr *wr,
>> >                       rv = -EINVAL;
>> >                       break;
>> >               }
>> > -             siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id
>0x%p\n",
>> > -                        sqe->opcode, sqe->flags, (void
>*)sqe->id);
>> > +             siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id
>0x%llx\n",
>> > +                        sqe->opcode, sqe->flags, sqe->id);
>>
>> Printing possible pointers as %llx is generally not a good idea
>> given the desire for %p obfuscation.
>
>Are they pointers? Difficult to know with all the casting...
>

You are right. This one is not a pointer. It is an application
assigned unsigned 64bit. Just something (typically a pointer or
array index) assigned by the application to match work completions
with original work requests. So %llx would more correct here,
and the cast is not needed then.

Only problem that a kernel application typically puts a pointer
into here (a pointer to a local context etc.). With the aim
to support obfuscating the pointer for printout, we would be
back to the cast plus %p formatting....?



>Gr{oetje,eeting}s,
>
>                        Geert
>
>-- 
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
>hacker. But
>when I'm talking to journalists I just say "programmer" or something
>like that.
>                                -- Linus Torvalds
>
>

