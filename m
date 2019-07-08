Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDA862126
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfGHPIs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 8 Jul 2019 11:08:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729189AbfGHPIr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 11:08:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68F5wO0001311
        for <linux-rdma@vger.kernel.org>; Mon, 8 Jul 2019 11:08:46 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm5rm6p5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 11:08:41 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 8 Jul 2019 15:08:33 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 8 Jul 2019 15:08:26 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019070815082637-510136 ;
          Mon, 8 Jul 2019 15:08:26 +0000 
In-Reply-To: <20190708145630.GG23966@mellanox.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@mellanox.com>
Cc:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Doug Ledford" <dledford@redhat.com>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Mon, 8 Jul 2019 15:08:25 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190708145630.GG23966@mellanox.com>,<20190708140858.GC23966@mellanox.com>
 <20190708130351.2141a39b@canb.auug.org.au>
 <OF8B5D0A35.3AB4C2D3-ON00258431.004F7CF8-00258431.004F7D00@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: EBC65677:2F5A7D49-00258431:00532B28;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 379
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19070815-1529-0000-0000-0000066D4330
X-IBM-SpamModules-Scores: BY=0.020148; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.003611
X-IBM-SpamModules-Versions: BY=3.00011397; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01229252; UDB=6.00647378; IPR=6.01010511;
 BA=6.00006352; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027634; XFM=3.00000015;
 UTC=2019-07-08 15:08:31
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-08 15:01:34 - 6.00010140
x-cbparentid: 19070815-1530-0000-0000-0000736E4A8B
Message-Id: <OFEBC65677.2F5A7D49-ON00258431.00532B28-00258431.00532B2D@notes.na.collabserv.com>
Subject: Re:  Re: Re: linux-next: build failure after merge of the rdma tree
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@mellanox.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@mellanox.com>
>Date: 07/08/2019 04:56PM
>Cc: "Stephen Rothwell" <sfr@canb.auug.org.au>, "Doug Ledford"
><dledford@redhat.com>, "Linux Next Mailing List"
><linux-next@vger.kernel.org>, "Linux Kernel Mailing List"
><linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
><linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] Re: Re: linux-next: build failure after merge of
>the rdma tree
>
>On Mon, Jul 08, 2019 at 02:28:13PM +0000, Bernard Metzler wrote:
>
>> Thanks for  bringing this up. Indeed, that explicit
>> initialization seem to be inappropriate. Can you please
>> fix that as you suggest?
>
>I'm applying this to fix the PER_CPU stuff in siw:
>
>From 4c7d6dcd364843e408a60952ba914bb72bafc6cc Mon Sep 17 00:00:00
>2001
>From: Jason Gunthorpe <jgg@mellanox.com>
>Date: Mon, 8 Jul 2019 11:36:32 -0300
>Subject: [PATCH] RDMA/siw: Fix DEFINE_PER_CPU compilation when
> ARCH_NEEDS_WEAK_PER_CPU
>
>The initializer for the variable cannot be inside the macro (and zero
>initialization isn't needed anyhow).
>
>include/linux/percpu-defs.h:92:33: warning: '__pcpu_unique_use_cnt'
>initialized and declared 'extern'
>  extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;  \
>                                 ^~~~~~~~~~~~~~
>include/linux/percpu-defs.h:115:2: note: in expansion of macro
>'DEFINE_PER_CPU_SECTION'
>  DEFINE_PER_CPU_SECTION(type, name, "")
>  ^~~~~~~~~~~~~~~~~~~~~~
>drivers/infiniband/sw/siw/siw_main.c:129:8: note: in expansion of
>macro 'DEFINE_PER_CPU'
> static DEFINE_PER_CPU(atomic_t, use_cnt = ATOMIC_INIT(0));
>        ^~~~~~~~~~~~~~
>
>Also the rules for PER_CPU require the variable names to be globally
>unique, so prefix them with siw_
>
>Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
>Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
>Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>---
> drivers/infiniband/sw/siw/siw_main.c  |  8 ++++----
> drivers/infiniband/sw/siw/siw_qp_tx.c | 10 +++++-----
> 2 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index 3f5f3d27ebe5a1..fd2552a9091dee 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -126,7 +126,7 @@ static int siw_dev_qualified(struct net_device
>*netdev)
> 	return 0;
> }
> 
>-static DEFINE_PER_CPU(atomic_t, use_cnt = ATOMIC_INIT(0));
>+static DEFINE_PER_CPU(atomic_t, siw_use_cnt);
> 
> static struct {
> 	struct cpumask **tx_valid_cpus;
>@@ -215,7 +215,7 @@ int siw_get_tx_cpu(struct siw_device *sdev)
> 		if (!siw_tx_thread[cpu])
> 			continue;
> 
>-		usage = atomic_read(&per_cpu(use_cnt, cpu));
>+		usage = atomic_read(&per_cpu(siw_use_cnt, cpu));
> 		if (usage <= min_use) {
> 			tx_cpu = cpu;
> 			min_use = usage;
>@@ -226,7 +226,7 @@ int siw_get_tx_cpu(struct siw_device *sdev)
> 
> out:
> 	if (tx_cpu >= 0)
>-		atomic_inc(&per_cpu(use_cnt, tx_cpu));
>+		atomic_inc(&per_cpu(siw_use_cnt, tx_cpu));
> 	else
> 		pr_warn("siw: no tx cpu found\n");
> 
>@@ -235,7 +235,7 @@ int siw_get_tx_cpu(struct siw_device *sdev)
> 
> void siw_put_tx_cpu(int cpu)
> {
>-	atomic_dec(&per_cpu(use_cnt, cpu));
>+	atomic_dec(&per_cpu(siw_use_cnt, cpu));
> }
> 
> static struct ib_qp *siw_get_base_qp(struct ib_device *base_dev, int
>id)
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index 5e926fac51db30..1c9fa8fa96e513 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -1183,12 +1183,12 @@ struct tx_task_t {
> 	wait_queue_head_t waiting;
> };
> 
>-static DEFINE_PER_CPU(struct tx_task_t, tx_task_g);
>+static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
> 
> void siw_stop_tx_thread(int nr_cpu)
> {
> 	kthread_stop(siw_tx_thread[nr_cpu]);
>-	wake_up(&per_cpu(tx_task_g, nr_cpu).waiting);
>+	wake_up(&per_cpu(siw_tx_task_g, nr_cpu).waiting);
> }
> 
> int siw_run_sq(void *data)
>@@ -1196,7 +1196,7 @@ int siw_run_sq(void *data)
> 	const int nr_cpu = (unsigned int)(long)data;
> 	struct llist_node *active;
> 	struct siw_qp *qp;
>-	struct tx_task_t *tx_task = &per_cpu(tx_task_g, nr_cpu);
>+	struct tx_task_t *tx_task = &per_cpu(siw_tx_task_g, nr_cpu);
> 
> 	init_llist_head(&tx_task->active);
> 	init_waitqueue_head(&tx_task->waiting);
>@@ -1261,9 +1261,9 @@ int siw_sq_start(struct siw_qp *qp)
> 	}
> 	siw_qp_get(qp);
> 
>-	llist_add(&qp->tx_list, &per_cpu(tx_task_g, qp->tx_cpu).active);
>+	llist_add(&qp->tx_list, &per_cpu(siw_tx_task_g,
>qp->tx_cpu).active);
> 
>-	wake_up(&per_cpu(tx_task_g, qp->tx_cpu).waiting);
>+	wake_up(&per_cpu(siw_tx_task_g, qp->tx_cpu).waiting);
> 
> 	return 0;
> }
>-- 
>2.21.0
>
>

Many thanks Jason!

Very much appreciated!

Bernard.

