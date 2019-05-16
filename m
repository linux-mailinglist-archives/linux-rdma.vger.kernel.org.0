Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A284220B66
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfEPPjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 16 May 2019 11:39:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727037AbfEPPjR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 11:39:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4GFWJNw119103
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 11:39:16 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sh8f1q7hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2019 11:39:16 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 16 May 2019 15:39:16 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.39) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 16 May 2019 15:39:11 -0000
Received: from us1b3-mail163.a3dr.sjc03.isc4sb.com ([10.160.174.69])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019051615391079-457718 ;
          Thu, 16 May 2019 15:39:10 +0000 
In-Reply-To: <20190507161304.GH6201@ziepe.ca>
Subject: Re: iWARP and soft-iWARP interop testing
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Thu, 16 May 2019 15:39:10 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190507161304.GH6201@ziepe.ca>,<49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: 39E350A0:36B83BDF-002583FC:0053C32C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 53331
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19051615-6371-0000-0000-0000064169D7
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.208991
X-IBM-SpamModules-Versions: BY=3.00011105; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01204196; UDB=6.00632142; IPR=6.00985126;
 BA=6.00006311; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026918; XFM=3.00000015;
 UTC=2019-05-16 15:39:14
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-16 14:42:51 - 6.00009933
x-cbparentid: 19051615-6372-0000-0000-0000DBC27E62
Message-Id: <OF39E350A0.36B83BDF-ON002583FC.0053C32C-002583FC.0055FBFD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-16_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Doug Ledford" <dledford@redhat.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 05/07/2019 06:13PM
>Cc: "linux-rdma" <linux-rdma@vger.kernel.org>, "Bernard Metzler"
><BMT@zurich.ibm.com>
>Subject: Re: iWARP and soft-iWARP interop testing
>
>On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
>> So, Jason and I were discussing the soft-iWARP driver submission,
>and he
>> thought it would be good to know if it even works with the various
>iWARP
>> hardware devices.  I happen to have most of them on hand in one
>form or
>> another, so I set down to test it.  In the process, I ran across
>some
>> issues just with the hardware versions themselves, let alone with
>soft-
>> iWARP.  So, here's the results of my matrix of tests.  These aren't
>> performance tests, just basic "does it work" smoke tests...
>
>Well, lets imagine to merge this at 5.2-rc1? 
>
>Bernard you'll need to rebase and resend when it comes out in two
>weeks.
>
>Thanks,
>Jason
>
>
I think I addressed all major issues of the current siw RFC.

Probably most important, it's now guaranteed that the remaining
two objects (QP and MR) are kfree'd after return from the
ib_devices free call. This makes it easier for future development
of mid layers resource management, as Leon was pointing out.

All IDR usage is gone as well.

I removed the siw protection domain, since there is nothing
siw specific to be stored within. I just keep a structure
definition of 'struct siw_pd {struct ib_pd *base_pd}' to
keep INIT_RDMA_OBJ_SIZE() happy. 

Please advise what I shall do next to keep it going. Shall
I send another RFC or rebase/resend it to current for-next
now?

Many thanks,
Bernard 

