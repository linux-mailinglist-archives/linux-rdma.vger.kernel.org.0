Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043D54EBAF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfFUPQR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 21 Jun 2019 11:16:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbfFUPQQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 11:16:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LF85qu006933
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 11:16:15 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t90fcupqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 11:16:15 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 21 Jun 2019 15:16:13 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 21 Jun 2019 15:16:08 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019062115160788-590155 ;
          Fri, 21 Jun 2019 15:16:07 +0000 
In-Reply-To: <20190507161304.GH6201@ziepe.ca>
Subject: Re: iWARP and soft-iWARP interop testing
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Fri, 21 Jun 2019 15:16:08 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190507161304.GH6201@ziepe.ca>,<49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 86155861:EB9F4D23-00258420:0044617C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 25403
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19062115-7769-0000-0000-000007095753
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.128758
X-IBM-SpamModules-Versions: BY=3.00011303; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01221229; UDB=6.00642491; IPR=6.01002367;
 BA=6.00006339; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027408; XFM=3.00000015;
 UTC=2019-06-21 15:16:12
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-21 10:09:55 - 6.00010074
x-cbparentid: 19062115-7770-0000-0000-000031795EFE
Message-Id: <OF86155861.EB9F4D23-ON00258420.0044617C-00258420.0053DFF0@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_10:,,
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

Now, quite some rework and a few 5.2-rc's later ... any
remaining real obstacles to get siw pulled in?

Best regards,
Bernard.

