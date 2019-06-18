Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9048249E6B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFRKmB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 18 Jun 2019 06:42:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729287AbfFRKmB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 06:42:01 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5IAb7aU096933
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:42:00 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t6xc186th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:42:00 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 18 Jun 2019 10:42:00 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 18 Jun 2019 10:41:57 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019061810415616-336440 ;
          Tue, 18 Jun 2019 10:41:56 +0000 
In-Reply-To: <d49ac66f-3005-bd78-a99f-fec18e5e4990@samba.org>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Tue, 18 Jun 2019 10:41:56 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <d49ac66f-3005-bd78-a99f-fec18e5e4990@samba.org>,<20190614135750.15874-12-bmt
 () zurich ! ibm ! com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 6D989911:7A99B8E5-0025841D:003AC54A;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 30227
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061810-0163-0000-0000-000006858B47
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000095
X-IBM-SpamModules-Versions: BY=3.00011284; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01219697; UDB=6.00641572; IPR=6.01000838;
 BA=6.00006336; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027358; XFM=3.00000015;
 UTC=2019-06-18 10:41:59
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-18 05:21:24 - 6.00010062
x-cbparentid: 19061810-0164-0000-0000-00000FC9C21D
Message-Id: <OF6D989911.7A99B8E5-ON0025841D.003AC54A-0025841D.003AC550@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH v2 11/11] SIW addition to kernel build environment
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
>"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 06/18/2019 12:14PM
>Subject: [EXTERNAL] Re: [PATCH v2 11/11] SIW addition to kernel build
>environment
>
>Hi Bernard,
>
>>  source "drivers/infiniband/ulp/ipoib/Kconfig"
>> diff --git a/drivers/infiniband/sw/Makefile
>b/drivers/infiniband/sw/Makefile
>> index 8b095b27db87..6a0bb877f914 100644
>> --- a/drivers/infiniband/sw/Makefile
>> +++ b/drivers/infiniband/sw/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_INFINIBAND_RDMAVT)		+= rdmavt/
>>  obj-$(CONFIG_RDMA_RXE)			+= rxe/
>> +obj-$(CONFIG_RDMA_RXE)			+= siw/
>
>Shouldn't this be CONFIG_RDMA_SIW?
>
Hi Stefan, yes, this develops into a nightmare now! I seem to
be unable to get those lines right! Sorry about that.

@all - shall I resend PATCH v2 11/11 to get things
moving forward?

>Thanks for all your efforts to upstream the driver!
>It'll help me a lot in order to setup automated tests
>for my smbdirect driver.
>
>metze

Nice to hear of a good new use case!

Many thanks,
Bernard.

