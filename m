Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BAB8525C
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfHGRu5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 7 Aug 2019 13:50:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388323AbfHGRu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 13:50:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77HVsoe120911
        for <linux-rdma@vger.kernel.org>; Wed, 7 Aug 2019 13:50:56 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u834hrr4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 13:50:56 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 7 Aug 2019 17:50:55 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 7 Aug 2019 17:49:48 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019080717494743-804207 ;
          Wed, 7 Aug 2019 17:49:47 +0000 
In-Reply-To: <20190806173526.GJ11627@ziepe.ca>
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size to
 remove 64 bit architecture dependency of siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 7 Aug 2019 17:49:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190806173526.GJ11627@ziepe.ca>,<20190806163901.GI11627@ziepe.ca>
 <20190806153105.GG11627@ziepe.ca> <20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
 <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
 <OF3F75D9B9.20A30B62-ON0025844E.005D311D-0025844E.005D8CF2@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 57079
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080717-7279-0000-0000-000000252366
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000026
X-IBM-SpamModules-Versions: BY=3.00011566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01243473; UDB=6.00655962; IPR=6.01024942;
 MB=3.00028082; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-07 17:50:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-07 16:46:04 - 6.00010257
x-cbparentid: 19080717-7280-0000-0000-0000003859BD
Message-Id: <OF3FCBE885.788F61B5-ON0025844F.002DF52F-0025844F.0061F0FB@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

fg-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/06/2019 07:35PM
>Cc: linux-rdma@vger.kernel.org
>Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field
>32 bit size to remove 64 bit architecture dependency of siw.
>
>On Tue, Aug 06, 2019 at 05:01:49PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 08/06/2019 06:39PM
>> >Cc: linux-rdma@vger.kernel.org
>> >Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags
>field
>> >32 bit size to remove 64 bit architecture dependency of siw.
>> >
>> >On Tue, Aug 06, 2019 at 04:36:26PM +0000, Bernard Metzler wrote:
>> >> 
>> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >> >Date: 08/06/2019 05:31PM
>> >> >Cc: linux-rdma@vger.kernel.org
>> >> >Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags
>> >field
>> >> >32 bit size to remove 64 bit architecture dependency of siw.
>> >> >
>> >> >On Tue, Aug 06, 2019 at 02:53:49PM +0000, Bernard Metzler
>wrote:
>> >> >
>> >> >> >> index 7de68f1dc707..af735f55b291 100644
>> >> >> >> +++ b/include/uapi/rdma/siw-abi.h
>> >> >> >> @@ -180,6 +180,7 @@ struct siw_cqe {
>> >> >> >>   * to control CQ arming.
>> >> >> >>   */
>> >> >> >>  struct siw_cq_ctrl {
>> >> >> >> -	__aligned_u64 notify;
>> >> >> >> +	__u32 flags;
>> >> >> >> +	__u32 pad;
>> >> >> >
>> >> >> >The commit message needs to explain why this is compatible
>with
>> >> >> >existing user space, if it is even is safe..
>> >> >> >
>> >> >> Old libsiw would remain compatible with the new layout, since
>it
>> >> >> simply reads the 32bit 'flags' and zeroed 32bit 'pad' into a
>> >64bit
>> >> >> 'notify', ending with reading the same bits.
>> >> >
>> >> >Even on big endian?
>> >> >
>> >> Well I do not have access to a BE system right now to verify.
>> >> But on a BE system, the lowest 3 bits (which are in use) of the
>> >first
>> >> 32bit variable 'flags' shall be the lowest (leftmost) 3 bits of
>an
>> >> 'overlayed' 64bit variable 'notify' as well...
>> >
>> >One of LE or BE won't work with this scheme, it can't, the flag
>bit
>> >will end up in the pad.
>> >
>> Sitting here on a x86 (LE), and it works. On a 64bits machine,
>> two consecutive 32bits are obviously reordered in memory. Leaves
>> 32bit LE broken, which is currently not supported.
>
>? I still think 64 bit BE will be broken as the low two bits will
>overlap the pad, not the new flags.
>

It hurts, but I did finally setup qemu with a ppc image to check,
and so you are right!

...

#ifdef __BIG_ENDIAN__

seem to be available in both kernel and user land...

But, general question: siw in its current shape isn't out
for long, older versions from github are already broken with
the abi. So, silently changing the abi at this stage of siw
deployment is no option? It's a hassle to see an old mistake
carried along forever with that #ifdef statement...no?


Many thanks,
Bernard.

>> Anyway, what would you suggest as the best path forward? A new ABI
>> version? If we move to test_and_clear_bit(), 'flags' size would
>> become architecture dependent...and we would break the ABI as well,
>> no?
>
>Maybe a #ifdef __big_endian__ and swap the order of the pad/flags ?
>
>Jason
>
>

