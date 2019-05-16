Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A820B8D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfEPPv5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 16 May 2019 11:51:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfEPPvz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 11:51:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GFkeMl124140
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 11:51:53 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2shahr91yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 11:51:53 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 16 May 2019 15:51:52 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 16 May 2019 15:51:47 -0000
Received: from us1b3-mail163.a3dr.sjc03.isc4sb.com ([10.160.174.69])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019051615514748-1852344 ;
          Thu, 16 May 2019 15:51:47 +0000 
In-Reply-To: <20190516154720.GE22587@ziepe.ca>
Subject: Re: iWARP and soft-iWARP interop testing
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Leon Romanovsky" <leon@kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Thu, 16 May 2019 15:51:47 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190516154720.GE22587@ziepe.ca>,<20190507161304.GH6201@ziepe.ca>
 <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <OF39E350A0.36B83BDF-ON002583FC.0053C32C-002583FC.0055FBFD@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: 8865413E:BEF32DF5-002583FC:0057236E;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 35815
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19051615-7769-0000-0000-000006BB77A3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.118080
X-IBM-SpamModules-Versions: BY=3.00011105; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01204201; UDB=6.00632145; IPR=6.00985131;
 BA=6.00006311; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026918; XFM=3.00000015;
 UTC=2019-05-16 15:51:50
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-16 15:07:31 - 6.00009933
x-cbparentid: 19051615-7770-0000-0000-000030EA8FC2
Message-Id: <OF8865413E.BEF32DF5-ON002583FC.0057236E-002583FC.00572374@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 05/16/2019 05:47PM
>Cc: "Leon Romanovsky" <leon@kernel.org>, "Doug Ledford"
><dledford@redhat.com>, "linux-rdma" <linux-rdma@vger.kernel.org>
>Subject: Re: iWARP and soft-iWARP interop testing
>
>On Thu, May 16, 2019 at 03:39:10PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Doug Ledford" <dledford@redhat.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 05/07/2019 06:13PM
>> >Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Bernard Metzler"
>> ><BMT@zurich.ibm.com>
>> >Subject: Re: iWARP and soft-iWARP interop testing
>> >
>> >On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
>> >> So, Jason and I were discussing the soft-iWARP driver
>submission,
>> >and he
>> >> thought it would be good to know if it even works with the
>various
>> >iWARP
>> >> hardware devices.  I happen to have most of them on hand in one
>> >form or
>> >> another, so I set down to test it.  In the process, I ran across
>> >some
>> >> issues just with the hardware versions themselves, let alone
>with
>> >soft-
>> >> iWARP.  So, here's the results of my matrix of tests.  These
>aren't
>> >> performance tests, just basic "does it work" smoke tests...
>> >
>> >Well, lets imagine to merge this at 5.2-rc1? 
>> >
>> >Bernard you'll need to rebase and resend when it comes out in two
>> >weeks.
>> >
>> >Thanks,
>> >Jason
>> >
>> >
>> I think I addressed all major issues of the current siw RFC.
>> 
>> Probably most important, it's now guaranteed that the remaining
>> two objects (QP and MR) are kfree'd after return from the
>> ib_devices free call. This makes it easier for future development
>> of mid layers resource management, as Leon was pointing out.
>> 
>> All IDR usage is gone as well.
>> 
>> I removed the siw protection domain, since there is nothing
>> siw specific to be stored within. I just keep a structure
>> definition of 'struct siw_pd {struct ib_pd *base_pd}' to
>> keep INIT_RDMA_OBJ_SIZE() happy. 
>
>? Really? I iwarp doesn't use a protection domain?

Aehm no, siw does not need any siw specific additions to the ib_pd.
So there is no need to define any extra siw_pd besides of ib_pd.
Except for the INIT_RDMA_OBJ_SIZE thing.

siw can just use struct ib_pd. It has all it needs...

>
>> Please advise what I shall do next to keep it going. Shall
>> I send another RFC or rebase/resend it to current for-next
>> now?
>
>Rebase it when rc1 comes out and resend as not an RFC
>
>Jason
>
>

