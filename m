Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25C06746F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 19:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfGLRk4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 13:40:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbfGLRk4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 13:40:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CHbujV141500
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 13:40:55 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpwr0tfkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 13:40:55 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 17:40:54 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 17:40:44 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019071217404319-687984 ;
          Fri, 12 Jul 2019 17:40:43 +0000 
In-Reply-To: <20190712153243.GI27512@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Doug Ledford" <dledford@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 17:40:43 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712153243.GI27512@ziepe.ca>,<20190712144257.GE27512@ziepe.ca>
 <20190712135339.GC27512@ziepe.ca> <20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <OF3D069E00.E0996A14-ON00258435.004DD8C8-00258435.00502F8C@notes.na.collabserv.com>
 <OF9F46C3F6.DC3E03FF-ON00258435.00521546-00258435.00549C01@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 21983
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071217-3067-0000-0000-000000050945
X-IBM-SpamModules-Scores: BY=0.033397; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.035923
X-IBM-SpamModules-Versions: BY=3.00011416; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231195; UDB=6.00648559; IPR=6.01012479;
 MB=3.00027693; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 17:40:51
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 15:44:48 - 6.00010156
x-cbparentid: 19071217-3068-0000-0000-000000082D7E
Message-Id: <OFAB0712BA.E95178B5-ON00258435.00611CBE-00258435.00611CC4@notes.na.collabserv.com>
Subject: Re:  Re: Re: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 07/12/2019 05:33PM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: Re: Re: [PATCH] rdma/siw: avoid
>smp_store_mb() on a u64
>
>On Fri, Jul 12, 2019 at 03:24:09PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 07/12/2019 04:43PM
>> >Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
>> ><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
>> >linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>> >Subject: [EXTERNAL] Re: Re: Re: [PATCH] rdma/siw: avoid
>> >smp_store_mb() on a u64
>> >
>> >On Fri, Jul 12, 2019 at 02:35:50PM +0000, Bernard Metzler wrote:
>> >
>> >> >This looks wrong to me.. a userspace notification re-arm cannot
>be
>> >> >lost, so have a split READ/TEST/WRITE sequence can't possibly
>> >work?
>> >> >
>> >> >I'd expect an atomic test and clear here?
>> >> 
>> >> We cannot avoid the case that the application re-arms the
>> >> CQ only after a CQE got placed. That is why folks are polling
>the
>> >> CQ once after re-arming it - to make sure they do not miss the
>> >> very last and single CQE which would have produced a CQ event.
>> >
>> >That is different, that is re-arm happing after a CQE placement
>and
>> >this can't be fixed.
>> >
>> >What I said is that a re-arm from userspace cannot be lost. So you
>> >can't blindly clear the arm flag with the WRITE_ONCE. It might be
>OK
>> >beacuse of the if, but...
>> >
>> >It is just goofy to write it without a 'test and clear' atomic. If
>> >the
>> >writer side consumes the notify it should always be done
>atomically.
>> >
>> Hmmm, I don't yet get why we should test and clear atomically, if
>we
>> clear anyway - is it because we want to avoid clearing a re-arm
>which
>> happens just after testing and before clearing?
>
>It is just clearer as to the intent.. 
>
>Are you trying to optimize away an atomic or something? That might
>work better as a dual counter scheme.
>
>> Another complication -- test_and_set_bit() operates on a single
>> bit, but we have to test two bits, and reset both, if one is
>> set.
>
>Why are two bits needed to represent armed and !armed?
>
>Jason

It is because there are two levels a CQ can be armed:

       #include <infiniband/verbs.h>

       int ibv_req_notify_cq(struct ibv_cq *cq, int solicited_only);

If we kick the CQ handler, we have to clear the whole
thing. The user later again decides how he wants to get it
re-armed...SOLICITED completions only, or ALL signaled.

Best,
Bernard.

>
>

