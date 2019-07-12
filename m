Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C867185
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfGLOgB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 10:36:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727072AbfGLOgB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 10:36:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CEX9Te078530
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 10:36:00 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tptvnbe4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 10:36:00 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 14:35:59 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 14:35:51 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019071214355089-551209 ;
          Fri, 12 Jul 2019 14:35:50 +0000 
In-Reply-To: <20190712135339.GC27512@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Doug Ledford" <dledford@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 14:35:50 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712135339.GC27512@ziepe.ca>,<20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 12499
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071214-1799-0000-0000-00000C368D1A
X-IBM-SpamModules-Scores: BY=0.030592; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.011778
X-IBM-SpamModules-Versions: BY=3.00011415; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231133; UDB=6.00648522; IPR=6.01012417;
 BA=6.00006355; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027692; XFM=3.00000015;
 UTC=2019-07-12 14:35:56
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 09:11:03 - 6.00010155
x-cbparentid: 19071214-1800-0000-0000-0000004D9BE6
Message-Id: <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
Subject: Re:  Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 07/12/2019 03:53PM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on
>a u64
>
>On Fri, Jul 12, 2019 at 01:05:14PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 07/12/2019 02:03PM
>> >Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
>> ><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
>> >linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>> >Subject: [EXTERNAL] Re: [PATCH] rdma/siw: avoid smp_store_mb() on
>a
>> >u64
>> >
>> >On Fri, Jul 12, 2019 at 11:33:46AM +0000, Bernard Metzler wrote:
>> >> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >b/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >index 32dc79d0e898..41c5ab293fe1 100644
>> >> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> >> >@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq
>> >*base_cq,
>> >> >enum ib_cq_notify_flags flags)
>> >> > 
>> >> > 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
>> >> > 		/* CQ event for next solicited completion */
>> >> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
>> >> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
>> >> > 	else
>> >> > 		/* CQ event for any signalled completion */
>> >> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
>> >> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
>> >> >+	smp_wmb();
>> >> > 
>> >> > 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
>> >> > 		return cq->cq_put - cq->cq_get;
>> >> 
>> >> 
>> >> Hi Arnd,
>> >> Many thanks for pointing that out! Indeed, this CQ notification
>> >> mechanism does not take 32 bit architectures into account.
>> >> Since we have only three flags to hold here, it's probably
>better
>> >> to make it a 32bit value. That would remove the issue w/o
>> >> introducing extra smp_wmb(). 
>> >
>> >I also prefer not to see smp_wmb() in drivers..
>> >
>> >> I'd prefer smp_store_mb(), since on some architectures it shall
>be
>> >> more efficient.  That would also make it sufficient to use
>> >> READ_ONCE.
>> >
>> >The READ_ONCE is confusing to me too, if you need store_release
>> >semantics then the reader also needs to pair with load_acquite -
>> >otherwise it doesn't work.
>> >
>> >Still, we need to do something rapidly to fix the i386 build,
>please
>> >revise right away..
>> >
>> >Jason
>> >
>> >
>> 
>> We share CQ (completion queue) notification flags between
>application
>> (which may be user land) and producer (kernel QP's (queue pairs)).
>> Those flags can be written by both application and QP's. The
>application
>> writes those flags to let the driver know if it shall inform about
>new
>> work completions. It can write those flags at any time.
>> Only a kernel producer reads those flags to decide if
>> the CQ notification handler shall be kicked, if a new CQ element
>gets
>> added to the CQ. When kicking the completion handler, the driver
>resets the
>> notification flag, which must get re-armed by the application.
>
>This looks wrong to me.. a userspace notification re-arm cannot be
>lost, so have a split READ/TEST/WRITE sequence can't possibly work?
>
>I'd expect an atomic test and clear here?

We cannot avoid the case that the application re-arms the
CQ only after a CQE got placed. That is why folks are polling the
CQ once after re-arming it - to make sure they do not miss the
very last and single CQE which would have produced a CQ event.

I do not think an atomic test and clear would change that picture.

Also, per RDMA verbs semantics, if the user would re-arm the CQ
more then once before it gets a CQ event, it will still get only one
CQ event if a new CQ element becomes ready. 
>
>
>> @@ -1141,11 +1145,17 @@ int siw_req_notify_cq(struct ib_cq
>*base_cq, enum ib_cq_notify_flags flags)
>>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
>>  
>>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
>> -		/* CQ event for next solicited completion */
>> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
>> +		/*
>> +		 * Enable CQ event for next solicited completion.
>> +		 * and make it visible to all associated producers.
>> +		 */
>> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
>
>But what is the 2nd piece of data to motivate the smp_store_mb?

Another core (such as a concurrent RX operation) shall see this
CQ being re-armed asap.

Best,
Bernard.
>
>Jason
>
>

