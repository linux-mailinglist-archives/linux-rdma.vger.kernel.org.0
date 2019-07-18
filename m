Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C6F6CCEC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbfGRKl6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 18 Jul 2019 06:41:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbfGRKl5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jul 2019 06:41:57 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IAbhSe004891
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2019 06:41:56 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.104])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttnrxkr7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2019 06:41:56 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 18 Jul 2019 10:41:56 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.44) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 18 Jul 2019 10:41:50 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071810414460-324980 ;
          Thu, 18 Jul 2019 10:41:44 +0000 
In-Reply-To: <20190718092710.85709-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH] RDMA/siw: fix error return code in siw_init_module()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Wei Yongjun" <weiyongjun1@huawei.com>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Date:   Thu, 18 Jul 2019 10:41:44 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190718092710.85709-1-weiyongjun1@huawei.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 35A9F852:4EA5883B-0025843B:0035B005;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 1183
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071810-5525-0000-0000-0000005802EE
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000062
X-IBM-SpamModules-Versions: BY=3.00011451; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01233881; UDB=6.00650192; IPR=6.01015209;
 MB=3.00027775; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-18 10:41:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-18 10:27:10 - 6.00010179
x-cbparentid: 19071810-5526-0000-0000-0000009204F2
Message-Id: <OF35A9F852.4EA5883B-ON0025843B.0035B005-0025843B.003AC0D0@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Wei Yongjun" <weiyongjun1@huawei.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Wei Yongjun" <weiyongjun1@huawei.com>
>Date: 07/18/2019 11:21AM
>Cc: "Wei Yongjun" <weiyongjun1@huawei.com>,
><linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH] RDMA/siw: fix error return code in
>siw_init_module()
>
>Fix to return a negative error code from the error handling
>case instead of 0, as done elsewhere in this function.
>
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>---
> drivers/infiniband/sw/siw/siw_main.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index fd2552a9091d..9040692f83d7 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -614,6 +614,7 @@ static __init int siw_init_module(void)
> 
> 	if (!siw_create_tx_threads()) {
> 		pr_info("siw: Could not start any TX thread\n");
>+		rv = -ENOMEM;
> 		goto out_error;
> 	}
> 	/*
>
>
>
>
Yes, thanks Wei!

Bernard.

