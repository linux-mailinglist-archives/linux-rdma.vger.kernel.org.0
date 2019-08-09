Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37F35878EE
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 13:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405999AbfHILoz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 9 Aug 2019 07:44:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbfHILoy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 07:44:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79Bh7WD129986
        for <linux-rdma@vger.kernel.org>; Fri, 9 Aug 2019 07:44:53 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u95dse7xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2019 07:44:53 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 9 Aug 2019 11:44:52 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 9 Aug 2019 11:44:45 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2019080911444465-361241 ;
          Fri, 9 Aug 2019 11:44:44 +0000 
In-Reply-To: <20190809101619.GB17867@mwanda>
Subject: Re: [PATCH] RDMA/siw: Fix a memory leak in siw_init_cpulist()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Fri, 9 Aug 2019 11:44:45 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190809101619.GB17867@mwanda>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 16059
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080911-8889-0000-0000-0000000E11E8
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011574; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244295; UDB=6.00656462; IPR=6.01025777;
 MB=3.00028107; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-09 11:44:50
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-09 09:10:27 - 6.00010264
x-cbparentid: 19080911-8890-0000-0000-00000018129F
Message-Id: <OF1431A46D.4DAAB987-ON00258451.003E917F-00258451.0040859B@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Dan Carpenter" <dan.carpenter@oracle.com>
>Date: 08/09/2019 12:16PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
>kernel-janitors@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] RDMA/siw: Fix a memory leak in
>siw_init_cpulist()
>
>The error handling code doesn't free siw_cpu_info.tx_valid_cpus[0].
>The
>first iteration through the loop is a no-op so this is sort of an off
>by
>one bug.
>
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>---
> drivers/infiniband/sw/siw/siw_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index d0f140daf659..95ace3967391 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -160,9 +160,9 @@ static int siw_init_cpulist(void)
> 
> out_err:
> 	siw_cpu_info.num_nodes = 0;
>-	while (i) {
>+	while (--i >= 0) {
> 		kfree(siw_cpu_info.tx_valid_cpus[i]);
>-		siw_cpu_info.tx_valid_cpus[i--] = NULL;
>+		siw_cpu_info.tx_valid_cpus[i] = NULL;
> 	}
> 	kfree(siw_cpu_info.tx_valid_cpus);
> 	siw_cpu_info.tx_valid_cpus = NULL;
>-- 
>2.20.1
>
>
Dan, many thanks for catching this one!

I suggest you provide an even simpler fix, taking the 
chance to remove the redundant
"siw_cpu_info.tx_valid_cpus[i] = NULL;" line (since
the whole structure gets kfree'd a line further
down...).
This shall be suffcient:

-	while (i) {
+	while (--i >= 0)
 		kfree(siw_cpu_info.tx_valid_cpus[i]);
-		siw_cpu_info.tx_valid_cpus[i--] = NULL;
-	}
+


Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

