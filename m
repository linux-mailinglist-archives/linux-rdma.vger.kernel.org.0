Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFEE4AC7
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410299AbfJYML1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 25 Oct 2019 08:11:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410291AbfJYML1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Oct 2019 08:11:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PC9ttY099423
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 08:11:26 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv0s6g4v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 25 Oct 2019 08:11:26 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 25 Oct 2019 12:11:25 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 25 Oct 2019 12:11:18 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019102512111770-396862 ;
          Fri, 25 Oct 2019 12:11:17 +0000 
In-Reply-To: <20191004174804.GF13988@ziepe.ca>
Subject: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Date:   Fri, 25 Oct 2019 12:11:16 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191004174804.GF13988@ziepe.ca>,<20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-LLNOutbound: False
X-Disclaimed: 45267
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19102512-8877-0000-0000-000001963128
X-IBM-SpamModules-Scores: BY=0.066268; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.002132
X-IBM-SpamModules-Versions: BY=3.00011995; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01280507; UDB=6.00678534; IPR=6.01062649;
 MB=3.00029235; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-25 12:11:24
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-25 08:16:42 - 6.00010570
x-cbparentid: 19102512-8878-0000-0000-0000565F3709
Message-Id: <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 10/04/2019 07:48PM
>Cc: "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org,
>bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
>bvanassche@acm.org
>Subject: [EXTERNAL] Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ
>drain logic
>
>On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
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
>> application. We might better use that. 
>
>No, the uobject pointer is not to be touched by drivers
>
Now what would be the appropriate way of remembering/
detecting user level nature of endpoint resources?
I see drivers _are_ doing 'if (!ibqp->uobject)' ... 

Other drivers keep it with the private state, like iw40,
but I learned we shall get rid of it.

We may export an inline query from RDMA core, or simply
#define is_usermode(ib_obj *) (ib_obj->uobject != NULL)
?

Thanks and best regards,
Bernard

