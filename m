Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37CE9B2F8
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfHWPFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 23 Aug 2019 11:05:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732530AbfHWPFY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 11:05:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NF34qJ061461
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 11:05:22 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujhrcsvms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 23 Aug 2019 11:05:22 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 23 Aug 2019 15:05:21 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 23 Aug 2019 15:05:15 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019082315051498-571853 ;
          Fri, 23 Aug 2019 15:05:14 +0000 
In-Reply-To: <20190823144221.GF12968@ziepe.ca>
Subject: Re: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org,
        geert@linux-m68k.org
Date:   Fri, 23 Aug 2019 15:05:15 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190823144221.GF12968@ziepe.ca>,<0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
 <20190822173738.26817-1-bmt@zurich.ibm.com>
 <20190822184147.GO29433@mtr-leonro.mtl.com>
 <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 63663
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082315-2475-0000-0000-0000006DB8C9
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.068008
X-IBM-SpamModules-Versions: BY=3.00011641; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250985; UDB=6.00660517; IPR=6.01032549;
 MB=3.00028301; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-23 15:05:20
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-23 10:55:42 - 6.00010320
x-cbparentid: 19082315-2476-0000-0000-00002B6EC974
Message-Id: <OF6BB8D2A0.FBBB26D8-ON0025845F.00522370-0025845F.0052E0CD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-23_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/23/2019 04:42PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Leon Romanovsky"
><leon@kernel.org>, linux-rdma@vger.kernel.org, geert@linux-m68k.org
>Subject: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer
>inconsistency
>
>On Fri, Aug 23, 2019 at 02:33:56PM +0000, Bernard Metzler wrote:
>> >> > diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>> >> > b/drivers/infiniband/sw/siw/siw_cm.c
>> >> > index 9ce8a1b925d2..ae7ea3ad7224 100644
>> >> > +++ b/drivers/infiniband/sw/siw/siw_cm.c
>> >> > @@ -355,8 +355,8 @@ static int siw_cm_upcall(struct siw_cep
>*cep,
>> >> > enum iw_cm_event_type reason,
>> >> >  		getname_local(cep->sock, &event.local_addr);
>> >> >  		getname_peer(cep->sock, &event.remote_addr);
>> >> >  	}
>> >> > -	siw_dbg_cep(cep, "[QP %u]: id 0x%p, reason=%d, status=%d\n",
>> >> > -		    cep->qp ? qp_id(cep->qp) : -1, id, reason, status);
>> >> > +	siw_dbg_cep(cep, "[QP %u]: reason=%d, status=%d\n",
>> >> > +		    cep->qp ? qp_id(cep->qp) : -1, reason, status);
>> >>                                              ^^^^
>> >> There is a chance that such construction (attempt to print -1
>with
>> >%u)
>> >> will generate some sort of warning.
>> >> 
>> >> Thanks
>> >
>> >I didn't see any warnings when I built it.  And %u->-1 would be
>the
>> >same
>> >error on 64bit or 32bit, so I think we're safe here.
>> >
>> 
>> Doug,
>> May I ask you to amend this patch in a way which would
>> just stop this monument of programming stupidity from
>> prolonging into the future, while of course recognizing
>> the impossibility of erasing it from the past?
>> Exchanging the %u with %d would help me regaining
>> some self-confidence ;)
>
>A
>  q?a:b
>
>Expression has only a single type. There are some tricky rules on
>this, but since gcc does not complain on the %u it means
>'q?(u32):(int)' is a (u32) and the -1 is implicitly casted.
>
>The better thing to write would have been U32_MAX instead of -1
>

What I wanted to have though is an easy to spot invalid number
for the QP. This is why I wanted to have it a negative number
on the screen, which is obviously not nicely achievable. So,
yeah, U32_MAX is a better idea. It will not very often be a
valid QP ID...

Thanks
Bernard.


