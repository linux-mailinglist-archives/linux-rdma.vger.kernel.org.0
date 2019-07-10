Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82A9643A6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfGJIiL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 10 Jul 2019 04:38:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727174AbfGJIiK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Jul 2019 04:38:10 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6A8ajRS084370
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 04:38:08 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tnb4nkw3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 04:38:08 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 10 Jul 2019 08:38:07 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 10 Jul 2019 08:38:00 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071008375974-184574 ;
          Wed, 10 Jul 2019 08:37:59 +0000 
In-Reply-To: <20190710043554.GA7034@mtr-leonro.mtl.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "YueHaibing" <yuehaibing@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Date:   Wed, 10 Jul 2019 08:38:00 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190710043554.GA7034@mtr-leonro.mtl.com>,<20190710015009.57120-1-yuehaibing@huawei.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: B29B4146:7E46891A-00258433:002BBAD4;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 59203
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071008-3017-0000-0000-0000004E3DB3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.064514
X-IBM-SpamModules-Versions: BY=3.00011404; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01230075; UDB=6.00647874; IPR=6.01011341;
 MB=3.00027663; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-10 08:38:05
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-10 03:22:57 - 6.00010146
x-cbparentid: 19071008-3018-0000-0000-000000835860
Message-Id: <OFB29B4146.7E46891A-ON00258433.002BBAD4-00258433.002F6CB8@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH] RDMA/siw: Print error code while kthread_create failed
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "YueHaibing" <yuehaibing@huawei.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 07/10/2019 06:36AM
>Cc: bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
>linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Print error code while
>kthread_create failed
>
>On Wed, Jul 10, 2019 at 09:50:09AM +0800, YueHaibing wrote:
>> In iw_create_tx_threads(), if we failed to create kthread,
>> we should print the 'rv', this fix gcc warning:
>>
>> drivers/infiniband/sw/siw/siw_main.c: In function
>'siw_create_tx_threads':
>> drivers/infiniband/sw/siw/siw_main.c:91:11: warning:
>>  variable 'rv' set but not used [-Wunused-but-set-variable]
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>> index fd2552a..2a70830d 100644
>> --- a/drivers/infiniband/sw/siw/siw_main.c
>> +++ b/drivers/infiniband/sw/siw/siw_main.c
>> @@ -101,7 +101,8 @@ static int siw_create_tx_threads(void)
>>  		if (IS_ERR(siw_tx_thread[cpu])) {
>>  			rv = PTR_ERR(siw_tx_thread[cpu]);
>>  			siw_tx_thread[cpu] = NULL;
>> -			pr_info("Creating TX thread for CPU %d failed", cpu);
>> +			pr_info("Creating TX thread for CPU%d failed %d\n",
>> +				cpu, rv);
>
>Delete this print together with variable, failure to create kthread
>is basic failure, which affect performance only. The whole kthread
>creation spam in this driver looked suspicious during submission
>and it continues to be.
>
>Thanks

Right, I agree with Leon. Better remove all those printouts. We
already have a warning if we cannot start any thread. Also
stopping those threads is not worth spamming the console. I just
forgot to remove after Leon's comment. Would it be possible
to apply the following?

Thanks a lot!
Bernard.

From e4ca3d4dec86bb5731f8e3cb0cdd01e84b315d80 Mon Sep 17 00:00:00 2001
From: Bernard Metzler <bmt@zurich.ibm.com>
Date: Wed, 10 Jul 2019 10:03:17 +0200
Subject: [PATCH] remove kthread create/destroy printouts

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_main.c  | 4 +---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index fd2552a9091d..f55c4e80aea4 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -88,7 +88,7 @@ static void siw_device_cleanup(struct ib_device *base_dev)
 
 static int siw_create_tx_threads(void)
 {
-	int cpu, rv, assigned = 0;
+	int cpu, assigned = 0;
 
 	for_each_online_cpu(cpu) {
 		/* Skip HT cores */
@@ -99,9 +99,7 @@ static int siw_create_tx_threads(void)
 			kthread_create(siw_run_sq, (unsigned long *)(long)cpu,
 				       "siw_tx/%d", cpu);
 		if (IS_ERR(siw_tx_thread[cpu])) {
-			rv = PTR_ERR(siw_tx_thread[cpu]);
 			siw_tx_thread[cpu] = NULL;
-			pr_info("Creating TX thread for CPU %d failed", cpu);
 			continue;
 		}
 		kthread_bind(siw_tx_thread[cpu], cpu);
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 2c3d250ee57c..fff02b56d38a 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1200,8 +1200,6 @@ int siw_run_sq(void *data)
 	init_llist_head(&tx_task->active);
 	init_waitqueue_head(&tx_task->waiting);
 
-	pr_info("Started siw TX thread on CPU %u\n", nr_cpu);
-
 	while (1) {
 		struct llist_node *fifo_list = NULL;
 
@@ -1239,8 +1237,6 @@ int siw_run_sq(void *data)
 			siw_sq_resume(qp);
 		}
 	}
-	pr_info("Stopped siw TX thread on CPU %u\n", nr_cpu);
-
 	return 0;
 }
 
-- 
2.17.2


 


