Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29626766BF8
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 13:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjG1Lod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjG1Loc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 07:44:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1485E30FC
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jul 2023 04:44:31 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SBgf7L003758;
        Fri, 28 Jul 2023 11:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fGCcDqOdyDTsaQ9gs7wyKnzrwMI1y1n9u0oPOh3YIJo=;
 b=FhLgdv/lFFIB1zw60DgxQNBLvOBCY5ZBb/uz3KVkKMykO0bmB2iKy2ZsMf5XoqPiORkb
 CKgadssRWM+B1qGrgf9UWWo55+G2rMlMrSvFK14+9zB6KP12f4MEUQeaW7wA9Yp2Sb+Y
 zJfRMBLnnOMCBZFVwZJc4N7mQQKbSIqbwSfY9ekqYpa2sRJtfGPjTrfGEOjU/O8WEa0h
 SHiGaMyOoYtOV3EFAnhd2Elnj4SYP18SXJhVo7ENhX8gLOa5C7dge64aNBV+yWscjZhG
 kABFkqimO7ryENizvo00E+emOmgsnNvbOJFYu2jtyuCctuiezVt2sans731A/aGVeCDI bg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4cdu1aee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 11:44:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36SBFX85016588;
        Fri, 28 Jul 2023 11:44:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v51w2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 11:44:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36SBiLaD31064774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 11:44:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA6292004B;
        Fri, 28 Jul 2023 11:44:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B33692004E;
        Fri, 28 Jul 2023 11:44:21 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.66])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jul 2023 11:44:21 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org, guoqing.jiang@linux.dev
Cc:     jgg@ziepe.ca, leon@kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix tx thread initialization.
Date:   Fri, 28 Jul 2023 13:44:18 +0200
Message-Id: <20230728114418.124328-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O4Bn1E7aqpVgya_VwV7a7hUA8HOm-rEs
X-Proofpoint-GUID: O4Bn1E7aqpVgya_VwV7a7hUA8HOm-rEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=822 phishscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Immediately removing the siw module after insertion may
crash in siw_stop_tx_thread(), if the according thread did
not yet had a chance to initialize its wait queue and
siw_stop_tx_thread() tries to wakeup that thread. Initializing
the threads state before spwaning it fixes it.

Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  3 +-
 drivers/infiniband/sw/siw/siw_main.c  | 40 ++----------------------
 drivers/infiniband/sw/siw/siw_qp_tx.c | 44 +++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 2f3a9cda3850..7af311934c7a 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -530,11 +530,12 @@ void siw_qp_llp_data_ready(struct sock *sk);
 void siw_qp_llp_write_space(struct sock *sk);
 
 /* QP TX path functions */
+int siw_create_tx_threads(void);
+void siw_stop_tx_threads(void);
 int siw_run_sq(void *arg);
 int siw_qp_sq_process(struct siw_qp *qp);
 int siw_sq_start(struct siw_qp *qp);
 int siw_activate_tx(struct siw_qp *qp);
-void siw_stop_tx_thread(int nr_cpu);
 int siw_get_tx_cpu(struct siw_device *sdev);
 void siw_put_tx_cpu(int cpu);
 
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 65b5cda5457b..ba44a5776006 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -88,29 +88,6 @@ static void siw_device_cleanup(struct ib_device *base_dev)
 	xa_destroy(&sdev->mem_xa);
 }
 
-static int siw_create_tx_threads(void)
-{
-	int cpu, assigned = 0;
-
-	for_each_online_cpu(cpu) {
-		/* Skip HT cores */
-		if (cpu % cpumask_weight(topology_sibling_cpumask(cpu)))
-			continue;
-
-		siw_tx_thread[cpu] =
-			kthread_run_on_cpu(siw_run_sq,
-					   (unsigned long *)(long)cpu,
-					   cpu, "siw_tx/%u");
-		if (IS_ERR(siw_tx_thread[cpu])) {
-			siw_tx_thread[cpu] = NULL;
-			continue;
-		}
-
-		assigned++;
-	}
-	return assigned;
-}
-
 static int siw_dev_qualified(struct net_device *netdev)
 {
 	/*
@@ -535,7 +512,6 @@ static struct rdma_link_ops siw_link_ops = {
 static __init int siw_init_module(void)
 {
 	int rv;
-	int nr_cpu;
 
 	if (SENDPAGE_THRESH < SIW_MAX_INLINE) {
 		pr_info("siw: sendpage threshold too small: %u\n",
@@ -580,12 +556,8 @@ static __init int siw_init_module(void)
 	return 0;
 
 out_error:
-	for (nr_cpu = 0; nr_cpu < nr_cpu_ids; nr_cpu++) {
-		if (siw_tx_thread[nr_cpu]) {
-			siw_stop_tx_thread(nr_cpu);
-			siw_tx_thread[nr_cpu] = NULL;
-		}
-	}
+	siw_stop_tx_threads();
+
 	if (siw_crypto_shash)
 		crypto_free_shash(siw_crypto_shash);
 
@@ -599,14 +571,8 @@ static __init int siw_init_module(void)
 
 static void __exit siw_exit_module(void)
 {
-	int cpu;
+	siw_stop_tx_threads();
 
-	for_each_possible_cpu(cpu) {
-		if (siw_tx_thread[cpu]) {
-			siw_stop_tx_thread(cpu);
-			siw_tx_thread[cpu] = NULL;
-		}
-	}
 	unregister_netdevice_notifier(&siw_netdev_nb);
 	rdma_link_unregister(&siw_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_SIW);
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index ffb16beb6c30..a1f8def4504e 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1209,10 +1209,45 @@ struct tx_task_t {
 
 static DEFINE_PER_CPU(struct tx_task_t, siw_tx_task_g);
 
-void siw_stop_tx_thread(int nr_cpu)
+int siw_create_tx_threads(void)
 {
-	kthread_stop(siw_tx_thread[nr_cpu]);
-	wake_up(&per_cpu(siw_tx_task_g, nr_cpu).waiting);
+	int cpu, assigned = 0;
+
+	for_each_online_cpu(cpu) {
+		struct tx_task_t *tx_task;
+
+		/* Skip HT cores */
+		if (cpu % cpumask_weight(topology_sibling_cpumask(cpu)))
+			continue;
+
+		tx_task = &per_cpu(siw_tx_task_g, cpu);
+		init_llist_head(&tx_task->active);
+		init_waitqueue_head(&tx_task->waiting);
+
+		siw_tx_thread[cpu] =
+			kthread_run_on_cpu(siw_run_sq,
+					   (unsigned long *)(long)cpu,
+					   cpu, "siw_tx/%u");
+		if (IS_ERR(siw_tx_thread[cpu])) {
+			siw_tx_thread[cpu] = NULL;
+			continue;
+		}
+		assigned++;
+	}
+	return assigned;
+}
+
+void siw_stop_tx_threads(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (siw_tx_thread[cpu]) {
+			kthread_stop(siw_tx_thread[cpu]);
+			wake_up(&per_cpu(siw_tx_task_g, cpu).waiting);
+			siw_tx_thread[cpu] = NULL;
+		}
+	}
 }
 
 int siw_run_sq(void *data)
@@ -1222,9 +1257,6 @@ int siw_run_sq(void *data)
 	struct siw_qp *qp;
 	struct tx_task_t *tx_task = &per_cpu(siw_tx_task_g, nr_cpu);
 
-	init_llist_head(&tx_task->active);
-	init_waitqueue_head(&tx_task->waiting);
-
 	while (1) {
 		struct llist_node *fifo_list = NULL;
 
-- 
2.38.1

