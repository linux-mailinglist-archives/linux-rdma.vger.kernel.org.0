Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39432DC67B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405754AbfJRNuc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Oct 2019 09:50:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731183AbfJRNub (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 09:50:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IDm34D083917
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 09:50:30 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vqddk37hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 09:50:30 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 18 Oct 2019 13:50:29 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 18 Oct 2019 13:50:23 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2019101813502329-515140 ;
          Fri, 18 Oct 2019 13:50:23 +0000 
In-Reply-To: <20191005082629.GS5855@unreal>
Subject: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com, jgg@ziepe.ca,
        nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org
Date:   Fri, 18 Oct 2019 13:50:22 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191005082629.GS5855@unreal>,<20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-LLNOutbound: False
X-Disclaimed: 44523
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19101813-7279-0000-0000-000000E46B10
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000002
X-IBM-SpamModules-Versions: BY=3.00011959; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01277220; UDB=6.00676565; IPR=6.01059339;
 MB=3.00029142; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-18 13:50:28
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-18 08:51:33 - 6.00010540
x-cbparentid: 19101813-7280-0000-0000-0000015175E3
Message-Id: <OFDD08DC35.6F2BAA59-ON00258497.004A2745-00258497.004C060F@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 10/05/2019 10:26AM
>Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com, jgg@ziepe.ca,
>nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org
>Subject: [EXTERNAL] Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ
>drain logic
>
>On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
>> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>> <...>
>>
>> >>   *
>> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp,
>const
>> >struct ib_send_wr *wr,
>> >>  	unsigned long flags;
>> >>  	int rv = 0;
>> >>
>> >> +	if (wr && !qp->kernel_verbs) {
>> >
>> >It is not related to this specific patch, but all siw
>"kernel_verbs"
>> >should go, we have standard way to distinguish between kernel and
>> >user
>> >verbs.
>> >
>> >Thanks
>> >
>> Understood. I think we touched on that already.
>> rdma core objects have a uobject pointer which
>> is valid only if it belongs to a user land
>> application. We might better use that. Let me
>> see if I can compact QP objects to contain the
>> ib_qp. I'd like to avoid following pointers
>> potentially causing cache misses on the
>> fast path. This is why I still have that
>> little boolean within the siw private
>> structure.
>
>You have this variable in CQ and SRQ too.
>
>I have serious doubts that this value gives any performance
>advantages.
>In both flows, you will need to fetch ib_qp pointer, so you don't
>save
>here anything by looking on kernel_verbs value.
>

Yes, I see you are right for both CQ and SRQ.

For the CQ, we have a nested structure where
siw_cq contains ib_cq. So it is not far away.

For SRQ it is the same.

For QP's we have a split between siw_qp and ib_qp. 
I will look into how to get that one solved.

I will prepare an extra patch for that whole
kernel_verbs thing, but let's not have it gating
acceptance of this unrelated patch.

Thanks very much,
Bernard.

