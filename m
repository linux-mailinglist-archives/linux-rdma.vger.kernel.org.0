Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18350166DF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 17:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfEGPfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 11:35:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726656AbfEGPfr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 11:35:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47FZXXs018379
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 11:35:46 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sbb0vnjxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 11:35:41 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 15:35:27 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 15:35:25 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019050715352446-777363 ;
          Tue, 7 May 2019 15:35:24 +0000 
In-Reply-To: <20190428165633.GR6705@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 09/12] SIW receive path
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        "Bernard Metzler" <bmt@rims.zurich.ibm.com>
Date:   Tue, 7 May 2019 15:35:25 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190428165633.GR6705@mtr-leonro.mtl.com>,<20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-10-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 1467
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050715-3815-0000-0000-00000B3FC308
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.421684; ST=0; TS=0; UL=0; ISC=; MB=0.103533
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199929; UDB=6.00629557; IPR=6.00980811;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026771; XFM=3.00000015;
 UTC=2019-05-07 15:35:27
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 15:15:40 - 6.00009896
x-cbparentid: 19050715-3816-0000-0000-00000FA1DC33
Message-Id: <OF9ECA30AB.B0FB08EE-ON002583F3.00548F77-002583F3.0055A3E2@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



---
Bernard Metzler, PhD
Tech. Leader High Performance I/O, Principal Research Staff
IBM Zurich Research Laboratory
Saeumerstrasse 4
CH-8803 Rueschlikon, Switzerland
+41 44 724 8605

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 04/28/2019 06:56PM
>Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
><bmt@rims.zurich.ibm.com>
>Subject: Re: [PATCH v8 09/12] SIW receive path
>
>On Fri, Apr 26, 2019 at 03:18:49PM +0200, Bernard Metzler wrote:
>> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
>>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_qp_rx.c | 1520
>+++++++++++++++++++++++++
>>  1 file changed, 1520 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
>>
>
>Are you sure that likely/unlikely annotations almost in every line
>better than correctly written functions with success oriented flows?
>
>I would be glad to see any performance proof for such extensive
>usage.

That's almost impossible, but I can give it a try ;)

I think, unlikely() statements around protocol failure checks
is rather common in networking code. But let me check if I have
overdone it...

>
>Thanks
>
>

