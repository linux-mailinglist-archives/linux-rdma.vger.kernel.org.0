Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C40BFA6A1E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfICNjo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 3 Sep 2019 09:39:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727667AbfICNjo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 09:39:44 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x83DbI0b086603
        for <linux-rdma@vger.kernel.org>; Tue, 3 Sep 2019 09:39:43 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2usrsuseby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2019 09:39:42 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 3 Sep 2019 13:39:41 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 3 Sep 2019 13:39:34 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019090313393457-458979 ;
          Tue, 3 Sep 2019 13:39:34 +0000 
In-Reply-To: <MN2PR18MB31820A0183CC9474BB358D38A1B90@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Michal Kalderon" <mkalderon@marvell.com>
Cc:     "Ariel Elior" <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Tue, 3 Sep 2019 13:39:34 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <MN2PR18MB31820A0183CC9474BB358D38A1B90@MN2PR18MB3182.namprd18.prod.outlook.com>,<20190902162314.17508-1-michal.kalderon@marvell.com>
 <OF54E87903.EA13ABB5-ON0025846A.003EBEF2-0025846A.003FD51F@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 8FE8C296:A77797D1-0025846A:004B089E;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 48231
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090313-3975-0000-0000-0000004442CC
X-IBM-SpamModules-Scores: BY=0.000001; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.001053
X-IBM-SpamModules-Versions: BY=3.00011710; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01256125; UDB=6.00663665; IPR=6.01037793;
 MB=3.00028451; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-03 13:39:40
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-03 12:49:09 - 6.00010364
x-cbparentid: 19090313-3976-0000-0000-0000006E4955
Message-Id: <OF8FE8C296.A77797D1-ON0025846A.004B089E-0025846A.004B08AB@notes.na.collabserv.com>
Subject: RE: [EXT] Re: [PATCH v9 rdma-next 0/7] RDMA/qedr: Use the doorbell overflow
 recovery mechanism for RDMA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Michal Kalderon" <mkalderon@marvell.com> wrote: -----

... 

>> 
>> Hi Michal,
>> 
>> I wanted to try out things -- can you please help me:
>> Where would that patch apply to? I tried rdma-next master and
>for-next. I
>> am getting conflicts in drivers/infiniband/core/ib_core_uverbs.c.
>Is there any
>> previous patch needed for this series?
>It applies to rdma for-next branch. The ib_core_uverbs.c is a new
>file, 
>Perhaps you have it from previous apply ? 
>
>Please make sure you're synced to head and that you don't have the
>file. 
>Let me know if it worked out, 
>
>Thanks,
>Michal 
>

Oh yes, that was the issue. 

Many thanks,
Bernard.

