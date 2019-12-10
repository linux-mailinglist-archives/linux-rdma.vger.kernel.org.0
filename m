Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389D0118896
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 13:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJMgi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 10 Dec 2019 07:36:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbfLJMgi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Dec 2019 07:36:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBACW8uf089838
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 07:36:37 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3pa6ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 07:36:37 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 10 Dec 2019 12:36:36 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 10 Dec 2019 12:36:31 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019121012362978-418156 ;
          Tue, 10 Dec 2019 12:36:29 +0000 
In-Reply-To: <20191209182944.GE67461@unreal>
Subject: Re: Re: [PATCH for-next] RDMA/siw: Simplify QP representation.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        krishna2@chelsio.com
Date:   Tue, 10 Dec 2019 12:36:29 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191209182944.GE67461@unreal>,<20191209160701.GD3790@ziepe.ca>
 <20191129162509.26576-1-bmt@zurich.ibm.com>
 <OF3F5E9911.A6946CC7-ON002584CB.0059DED2-002584CB.005C8103@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-LLNOutbound: False
X-Disclaimed: 12083
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19121012-6875-0000-0000-0000013B2963
X-IBM-SpamModules-Scores: BY=0.003935; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.010283
X-IBM-SpamModules-Versions: BY=3.00012220; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01302305; UDB=6.00691607; IPR=6.01084593;
 MB=3.00029913; MTD=3.00000008; XFM=3.00000015; UTC=2019-12-10 12:36:34
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-12-10 08:16:49 - 6.00010749
x-cbparentid: 19121012-6876-0000-0000-000001ED2E06
Message-Id: <OFE6351536.F136EF28-ON002584CC.004506C5-002584CC.00454253@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_02:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----linux-rdma-owner@vger.kernel.org wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" 
>Sent by: linux-rdma-owner@vger.kernel.org
>Date: 12/09/2019 07:30PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
>krishna2@chelsio.com
>Subject: [EXTERNAL] Re: [PATCH for-next] RDMA/siw: Simplify QP
>representation.
>
>On Mon, Dec 09, 2019 at 04:50:23PM +0000, Bernard Metzler wrote:
>> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>>
>> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 12/09/2019 05:07PM
>> >Cc: linux-rdma@vger.kernel.org, krishna2@chelsio.com,
>leon@kernel.org
>> >Subject: [EXTERNAL] Re: [PATCH for-next] RDMA/siw: Simplify QP
>> >representation.
>> >
>> >On Fri, Nov 29, 2019 at 05:25:09PM +0100, Bernard Metzler wrote:
>> >> Change siw_qp to contain ib_qp. Use ib_qp's uobject pointer
>> >> to distinguish kernel level and user level applications.
>> >> Apply same mechanism for kerne/user level application
>> >> detection to shared receive queues and completion queues.
>> >
>> >Drivers should not touch the uobject. If I recall you can use
>> >restrack
>> >to tell if it is kernel or user created
>> >
>> 'bool res->user' would probably be it, but I stumbled
>> upon this comment (e.g. in struct ib_qp):
>>
>>         /*
>>          * Implementation details of the RDMA core, don't use in
>drivers:
>>          */
>>         struct rdma_restrack_entry     res;
>>
>>
>> So we shall not use restrack information in drivers..?
>> Shall restrack better export a query such as
>> 'rdma_restrack_is_user(resource)'?
>
>rdma_is_kernel_res() inside include/rdma/restrack.h
>

This is great, thanks for the pointer!

Let me restructure accordingly. 
Unfortunately, SRQ's don't have (yet?) restrack info
included. So I'll stay with a private flag there, until
SRQ's are getting restracked.

Many thanks!
Bernard.

