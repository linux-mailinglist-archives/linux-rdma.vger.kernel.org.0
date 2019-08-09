Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3434F87CC2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406197AbfHIO26 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 9 Aug 2019 10:28:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfHIO26 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 10:28:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79ESZKE008603
        for <linux-rdma@vger.kernel.org>; Fri, 9 Aug 2019 10:28:57 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u98v34y7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2019 10:28:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 9 Aug 2019 14:28:56 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.39) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 9 Aug 2019 14:28:51 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019080914285108-486498 ;
          Fri, 9 Aug 2019 14:28:51 +0000 
In-Reply-To: <20190809140904.GB3552@mwanda>
Subject: Re: [PATCH v2] RDMA/siw: Fix a memory leak in siw_init_cpulist()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Fri, 9 Aug 2019 14:28:50 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190809140904.GB3552@mwanda>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: D09B6B8D:A208B8E7-00258451:004F8BA4;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 44107
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080914-9547-0000-0000-0000001F5D87
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011574; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01244350; UDB=6.00656494; IPR=6.01025832;
 MB=3.00028107; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-09 14:28:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-09 09:48:12 - 6.00010264
x-cbparentid: 19080914-9548-0000-0000-0000003568AA
Message-Id: <OFD09B6B8D.A208B8E7-ON00258451.004F8BA4-00258451.004F8BAA@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Dan Carpenter" <dan.carpenter@oracle.com>
>Date: 08/09/2019 04:09PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
>kernel-janitors@vger.kernel.org
>Subject: [EXTERNAL] [PATCH v2] RDMA/siw: Fix a memory leak in
>siw_init_cpulist()
>
>The error handling code doesn't free siw_cpu_info.tx_valid_cpus[0].
>The
>first iteration through the loop is a no-op so this is sort of an off
>by one bug.  Also Bernard pointed out that we can remove the NULL
>assignment and simplify the code a bit.
>
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
>---
>v2:  Remove the NULL assignment like Bernard Metzler pointed out.
>
> drivers/infiniband/sw/siw/siw_main.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index d0f140daf659..05a92f997f60 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -160,10 +160,8 @@ static int siw_init_cpulist(void)
> 
> out_err:
> 	siw_cpu_info.num_nodes = 0;
>-	while (i) {
>+	while (--i >= 0)
> 		kfree(siw_cpu_info.tx_valid_cpus[i]);
>-		siw_cpu_info.tx_valid_cpus[i--] = NULL;
>-	}
> 	kfree(siw_cpu_info.tx_valid_cpus);
> 	siw_cpu_info.tx_valid_cpus = NULL;
> 
>-- 
>2.20.1
>
>

Dan, many thanks for finding and fixing this!


Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

