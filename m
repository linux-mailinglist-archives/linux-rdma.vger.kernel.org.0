Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C783719
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfHFQge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Aug 2019 12:36:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfHFQge (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 12:36:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76GXXLv086673
        for <linux-rdma@vger.kernel.org>; Tue, 6 Aug 2019 12:36:33 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u7aas0aey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 12:36:32 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 6 Aug 2019 16:36:31 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 6 Aug 2019 16:36:28 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019080616362742-727298 ;
          Tue, 6 Aug 2019 16:36:27 +0000 
In-Reply-To: <20190806153105.GG11627@ziepe.ca>
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size to
 remove 64 bit architecture dependency of siw.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 6 Aug 2019 16:36:26 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190806153105.GG11627@ziepe.ca>,<20190806121006.GC11627@ziepe.ca>
 <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
 <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 8985846C:2F1A4852-0025844E:005AADBA;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 14051
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080616-4615-0000-0000-00000030C6E2
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01242974; UDB=6.00655662; IPR=6.01024438;
 MB=3.00028068; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-06 16:36:30
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-06 07:26:15 - 6.00010253
x-cbparentid: 19080616-4616-0000-0000-00000050DC9A
Message-Id: <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/06/2019 05:31PM
>Cc: linux-rdma@vger.kernel.org
>Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field
>32 bit size to remove 64 bit architecture dependency of siw.
>
>On Tue, Aug 06, 2019 at 02:53:49PM +0000, Bernard Metzler wrote:
>
>> >> index 7de68f1dc707..af735f55b291 100644
>> >> +++ b/include/uapi/rdma/siw-abi.h
>> >> @@ -180,6 +180,7 @@ struct siw_cqe {
>> >>   * to control CQ arming.
>> >>   */
>> >>  struct siw_cq_ctrl {
>> >> -	__aligned_u64 notify;
>> >> +	__u32 flags;
>> >> +	__u32 pad;
>> >
>> >The commit message needs to explain why this is compatible with
>> >existing user space, if it is even is safe..
>> >
>> Old libsiw would remain compatible with the new layout, since it
>> simply reads the 32bit 'flags' and zeroed 32bit 'pad' into a 64bit
>> 'notify', ending with reading the same bits.
>
>Even on big endian?
>
Well I do not have access to a BE system right now to verify.
But on a BE system, the lowest 3 bits (which are in use) of the first
32bit variable 'flags' shall be the lowest (leftmost) 3 bits of an
'overlayed' 64bit variable 'notify' as well...

