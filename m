Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19534EB158
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 14:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfJaNip convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 31 Oct 2019 09:38:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbfJaNip (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 09:38:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VDb4tR094614
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2019 09:38:44 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyyh1jpqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2019 09:38:44 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 31 Oct 2019 13:38:43 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 31 Oct 2019 13:38:37 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019103113383738-483488 ;
          Thu, 31 Oct 2019 13:38:37 +0000 
In-Reply-To: <20191029045447.GA5545@unreal>
Subject: Re: Re: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
        bvanassche@acm.org
Date:   Thu, 31 Oct 2019 13:38:37 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191029045447.GA5545@unreal>,<20191027052111.GW4853@unreal>
 <20191004174804.GF13988@ziepe.ca> <20191002154728.GH5855@unreal>
 <20191002143858.4550-1-bmt@zurich.ibm.com>
 <OFA7E48CEB.393CBE8D-ON00258489.0047C07A-00258489.004DD109@notes.na.collabserv.com>
 <OF6A4B581E.5377D66F-ON0025849E.0041A942-0025849E.0042F36B@notes.na.collabserv.com>
 <OF7628E460.D6869428-ON002584A1.003AE367-002584A1.00455D5D@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP61 October 18, 2019 at 15:11
X-LLNOutbound: False
X-Disclaimed: 51475
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19103113-9463-0000-0000-0000014D66F8
X-IBM-SpamModules-Scores: BY=0.283747; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.335479
X-IBM-SpamModules-Versions: BY=3.00012025; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01283378; UDB=6.00680252; IPR=6.01065525;
 MB=3.00029320; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-31 13:38:42
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-31 08:38:19 - 6.00010593
x-cbparentid: 19103113-9464-0000-0000-000038CB71B5
Message-Id: <OF30885433.61CAFFA8-ON002584A4.0045D240-002584A4.004AF272@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 10/29/2019 05:55AM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
>bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
>bvanassche@acm.org
>Subject: [EXTERNAL] Re: Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw:
>Fix SQ/RQ drain logic
>
>On Mon, Oct 28, 2019 at 12:37:38PM +0000, Bernard Metzler wrote:
>> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>>
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Leon Romanovsky" <leon@kernel.org>
>> >Date: 10/27/2019 06:21AM
>> >Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
>> >bharat@chelsio.com, nirranjan@chelsio.com, krishna2@chelsio.com,
>> >bvanassche@acm.org
>> >Subject: [EXTERNAL] Re: Re: Re: [[PATCH v2 for-next]] RDMA/siw:
>Fix
>> >SQ/RQ drain logic
>> >
>> >On Fri, Oct 25, 2019 at 12:11:16PM +0000, Bernard Metzler wrote:
>> >> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>> >>
>> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >> >Date: 10/04/2019 07:48PM
>> >> >Cc: "Leon Romanovsky" <leon@kernel.org>,
>> >linux-rdma@vger.kernel.org,
>> >> >bharat@chelsio.com, nirranjan@chelsio.com,
>krishna2@chelsio.com,
>> >> >bvanassche@acm.org
>> >> >Subject: [EXTERNAL] Re: Re: [[PATCH v2 for-next]] RDMA/siw: Fix
>> >SQ/RQ
>> >> >drain logic
>> >> >
>> >> >On Fri, Oct 04, 2019 at 02:09:57PM +0000, Bernard Metzler
>wrote:
>> >> >> <...>
>> >> >>
>> >> >> >>   *
>> >> >> >> @@ -705,6 +746,12 @@ int siw_post_send(struct ib_qp
>*base_qp,
>> >> >const
>> >> >> >struct ib_send_wr *wr,
>> >> >> >>  	unsigned long flags;
>> >> >> >>  	int rv = 0;
>> >> >> >>
>> >> >> >> +	if (wr && !qp->kernel_verbs) {
>> >> >> >
>> >> >> >It is not related to this specific patch, but all siw
>> >> >"kernel_verbs"
>> >> >> >should go, we have standard way to distinguish between
>kernel
>> >and
>> >> >> >user
>> >> >> >verbs.
>> >> >> >
>> >> >> >Thanks
>> >> >> >
>> >> >> Understood. I think we touched on that already.
>> >> >> rdma core objects have a uobject pointer which
>> >> >> is valid only if it belongs to a user land
>> >> >> application. We might better use that.
>> >> >
>> >> >No, the uobject pointer is not to be touched by drivers
>> >> >
>> >> Now what would be the appropriate way of remembering/
>> >> detecting user level nature of endpoint resources?
>> >> I see drivers _are_ doing 'if (!ibqp->uobject)' ...
>> >
>> >IMHO, you should rely in "udata" to distinguish user/kernel
>objects.
>> >
>>
>> right, we already do that at resource creation time, when
>> 'udata' is available.  But there is no such parameter
>> around during resource access (post_send/post_recv/poll_cq/...),
>> when user land or kernel land application specific
>> code might be required.
>> That's why siw currently saves that info to a resource
>> (QP/CQ/SRQ) specific parameter 'kernel_verbs'. I agree
>> this parameter is redundant, if the rdma core object
>> provides that information as well. The only way I see
>> it provided is the validity of the uobject pointer of
>> all those resources.
>> Either (1) we use that uobject pointer as an indication
>> of application location, or (2) we remember it from
>> resource creation time when udata was available, or
>> (3) we have the rdma core exporting that information
>> explicitly.
>> siw, and other drivers, are currently implementing (2).
>> Some drivers implement (1). I'd be happy to change siw
>> to implement (1) - to get rid of 'kernel_verbs'.
>
>Many if not all "kernel_verbs" variables are copy/paste.
>The usual way to handle difference in internal flows is to
>rely on having pointer initialized, e.g.
>if (siw_device->some_specific_kernel_pointer)
> do_kernelwork(siw_device->some_specific_kernel_pointer->extra)
>

The conditional code is always rather short:

- a few lines for extra checks during post_sq,
  post_rq and post_srq to forbid writing queue
  entries via syscall.

- write the qp kernel pointer to a CQE only
  if it is a kernel application. Don't expose
  it to user land.

IMO, these checks do not qualify for a change
to a function indirection, which would establish
two very similar functions, differing only in
very few lines. It would also decrease readability.
The function pointer would have to be part of
the resource itself (QP/SRQ/CQ), as the flag
is now.

Let me limit the usage of this obviously unliked
flag to its possible minimum. During resource
construction/destruction I do not really need
it (except setting it), since 'udata' is there.
It would appear only in the fast path for
meentioned checks.
I still prefer that siw private flag to
avoid to rely on potentially changing semantics
of rdma core private structures the driver
IMHO better should not interpret. But I am
completely open to do it that way, if preferred
by the maintainers.

Thanks and best regards,
Bernard.

>Thanks
>
>>
>> Thanks and best regards,
>> Bernard.
>>
>>
>>
>>
>> >>
>> >> Other drivers keep it with the private state, like iw40,
>> >> but I learned we shall get rid of it.
>> >>
>> >> We may export an inline query from RDMA core, or simply
>> >> #define is_usermode(ib_obj *) (ib_obj->uobject != NULL)
>> >> ?
>> >>
>> >> Thanks and best regards,
>> >> Bernard
>> >>
>> >
>> >
>>
>
>

