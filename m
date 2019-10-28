Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64AE7186
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfJ1Mhu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 28 Oct 2019 08:37:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389093AbfJ1Mht (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 08:37:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9SCaSv2100967
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 08:37:48 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vwywdh7m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 08:37:48 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 28 Oct 2019 12:37:47 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 28 Oct 2019 12:37:39 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2019102812373834-380939 ;
          Mon, 28 Oct 2019 12:37:38 +0000 
In-Reply-To: <20191027052111.GW4853@unreal>
Subject: Re: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Date:   Mon, 28 Oct 2019 12:37:38 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191027052111.GW4853@unreal>,<20191004174804.GF13988@ziepe.ca>
 <20191002154728.GH5855@unreal> <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
 <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-LLNOutbound: False
X-Disclaimed: 25411
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19102812-8877-0000-0000-0000019C3BC6
X-IBM-SpamModules-Scores: BY=0.065721; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.058801
X-IBM-SpamModules-Versions: BY=3.00012009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01281925; UDB=6.00679383; IPR=6.01064072;
 MB=3.00029272; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-28 12:37:45
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-28 12:24:18 - 6.00010582
x-cbparentid: 19102812-8878-0000-0000-0000566A4194
Message-Id: <OF7628E460.D6869428-ON002584A1.003AE367-002584A1.00455D5D@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-28_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 10/27/2019 06:21AM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
>bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
>bvanassche@acm.org
>Subject: [EXTERNAL] Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix
>SQ/RQ drain logic
>
>On Fri, Oct 25, 2019 at 12:11:16PM +0000, Bernard Metzler wrote:
>> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>>
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 10/04/2019 07:48PM
>> >Cc: "Leon Romanovsky" <leon@kernel.org>,
>linux-rdma@vger.kernel.org,
>> >bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
>> >bvanassche@acm.org
>> >Subject: [EXTERNAL] Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix
>SQ/RQ
>> >drain logic
>> >
>> >On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler wrote:
>> >> <...>
>> >>
>> >> >>   *
>> >> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp *base_qp,
>> >const
>> >> >struct ib_send_wr *wr,
>> >> >>  	unsigned long flags;
>> >> >>  	int rv = 0;
>> >> >>
>> >> >> +	if (wr && !qp->kernel_verbs) {
>> >> >
>> >> >It is not related to this specific patch, but all siw
>> >"kernel_verbs"
>> >> >should go, we have standard way to distinguish between kernel
>and
>> >> >user
>> >> >verbs.
>> >> >
>> >> >Thanks
>> >> >
>> >> Understood. I think we touched on that already.
>> >> rdma core objects have a uobject pointer which
>> >> is valid only if it belongs to a user land
>> >> application. We might better use that.
>> >
>> >No, the uobject pointer is not to be touched by drivers
>> >
>> Now what would be the appropriate way of remembering/
>> detecting user level nature of endpoint resources?
>> I see drivers _are_ doing 'if (!ibqp->uobject)' ...
>
>IMHO, you should rely in "udata" to distinguish user/kernel objects.
>

right, we already do that at resource creation time, when
'udata' is available.  But there is no such parameter
around during resource access (post_send/post_recv/poll_cq/...),
when user land or kernel land application specific
code might be required.
That's why siw currently saves that info to a resource
(QP/CQ/SRQ) specific parameter 'kernel_verbs'. I agree
this parameter is redundant, if the rdma core object
provides that information as well. The only way I see
it provided is the validity of the uobject pointer of
all those resources.
Either (1) we use that uobject pointer as an indication
of application location, or (2) we remember it from
resource creation time when udata was available, or
(3) we have the rdma core exporting that information
explicitly.
siw, and other drivers, are currently implementing (2).
Some drivers implement (1). I'd be happy to change siw
to implement (1) - to get rid of 'kernel_verbs'.

Thanks and best regards,
Bernard.




>>
>> Other drivers keep it with the private state, like iw40,
>> but I learned we shall get rid of it.
>>
>> We may export an inline query from RDMA core, or simply
>> #define is_usermode(ib_obj *) (ib_obj->uobject != NULL)
>> ?
>>
>> Thanks and best regards,
>> Bernard
>>
>
>

