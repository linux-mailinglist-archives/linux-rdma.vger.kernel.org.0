Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0128467242
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGLPY1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 11:24:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbfGLPY1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 11:24:27 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CFEdRU052806
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 11:24:26 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpvau9ge7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 11:24:26 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 15:24:25 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 15:24:10 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2019071215240985-637744 ;
          Fri, 12 Jul 2019 15:24:09 +0000 
In-Reply-To: <20190712144257.GE27512@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Doug Ledford" <dledford@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 15:24:09 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712144257.GE27512@ziepe.ca>,<20190712135339.GC27512@ziepe.ca>
 <20190712120328.GB27512@ziepe.ca> <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 16599
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071215-9717-0000-0000-00000CE3A9F4
X-IBM-SpamModules-Scores: BY=0.032673; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.128333
X-IBM-SpamModules-Versions: BY=3.00011415; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231149; UDB=6.00648532; IPR=6.01012434;
 BA=6.00006355; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027693; XFM=3.00000015;
 UTC=2019-07-12 15:24:23
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 15:07:04 - 6.00010156
x-cbparentid: 19071215-9718-0000-0000-00005C4FBB41
Message-Id: <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
Subject: Re:  Re: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
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
>Date: 07/12/2019 04:43PM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: Re: [PATCH] rdma/siw: avoid
>smp_store_mb() on a u64
>
>On Fri, Jul 12, 2019 at 02:35:50PM +0000, Bernard Metzler wrote:
>
>> >This looks wrong to me.. a userspace notification re-arm cannot be
>> >lost, so have a split READ/TEST/WRITE sequence can't possibly
>work?
>> >
>> >I'd expect an atomic test and clear here?
>> 
>> We cannot avoid the case that the application re-arms the
>> CQ only after a CQE got placed. That is why folks are polling the
>> CQ once after re-arming it - to make sure they do not miss the
>> very last and single CQE which would have produced a CQ event.
>
>That is different, that is re-arm happing after a CQE placement and
>this can't be fixed.
>
>What I said is that a re-arm from userspace cannot be lost. So you
>can't blindly clear the arm flag with the WRITE_ONCE. It might be OK
>beacuse of the if, but...
>
>It is just goofy to write it without a 'test and clear' atomic. If
>the
>writer side consumes the notify it should always be done atomically.
>
Hmmm, I don't yet get why we should test and clear atomically, if we
clear anyway - is it because we want to avoid clearing a re-arm which
happens just after testing and before clearing?
(1) If the test was positive, we will call the CQ event handler,
and per RDMA verbs spec, the application MUST re-arm the CQ after it
got a CQ event, to get another one. So clearing it sometimes before
calling the handler is right.
(2) If the test was negative, a test and reset would not change
anything.

Another complication -- test_and_set_bit() operates on a single
bit, but we have to test two bits, and reset both, if one is
set. Can we do that atomically, if we test the bits conditionally?
I didn't find anything appropriate.

>And then I think all the weird barriers go away
>
>> >> @@ -1141,11 +1145,17 @@ int siw_req_notify_cq(struct ib_cq
>> >*base_cq, enum ib_cq_notify_flags flags)
>> >>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
>> >>  
>> >>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
>> >> -		/* CQ event for next solicited completion */
>> >> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
>> >> +		/*
>> >> +		 * Enable CQ event for next solicited completion.
>> >> +		 * and make it visible to all associated producers.
>> >> +		 */
>> >> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
>> >
>> >But what is the 2nd piece of data to motivate the smp_store_mb?
>> 
>> Another core (such as a concurrent RX operation) shall see this
>> CQ being re-armed asap.
>
>'ASAP' is not a '2nd piece of data'. 
>
>AFAICT this requirement is just a normal atomic set_bit which does
>also expedite making the change visible?

Absolutely!!
good point....this is just a single flag we are operating on.
And the weird barrier goes away ;)

Many thanks!
Bernard.

