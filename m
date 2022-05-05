Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316C751B7C3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 08:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiEEGLa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 May 2022 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiEEGL1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 May 2022 02:11:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094C3ED34;
        Wed,  4 May 2022 23:07:47 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24567QCd016807;
        Thu, 5 May 2022 15:07:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Thu, 05 May 2022 15:07:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24567QY4016802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 5 May 2022 15:07:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fbe5e9a8-0110-0c22-b7d6-74d53948d042@I-love.SAKURA.ne.jp>
Date:   Thu, 5 May 2022 15:07:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        target-devel@vger.kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] IB/isert: Avoid flush_scheduled_work() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_wq with local isert_login_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Note: This patch is only compile tested.

 drivers/infiniband/ulp/isert/ib_isert.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 181e39e2a673..b9e8afb51f6e 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -42,6 +42,7 @@ MODULE_PARM_DESC(sg_tablesize,
 
 static DEFINE_MUTEX(device_list_mutex);
 static LIST_HEAD(device_list);
+static struct workqueue_struct *isert_login_wq;
 static struct workqueue_struct *isert_comp_wq;
 static struct workqueue_struct *isert_release_wq;
 
@@ -1017,7 +1018,7 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 		complete(&isert_conn->login_comp);
 		return;
 	}
-	schedule_delayed_work(&conn->login_work, 0);
+	queue_delayed_work(isert_login_wq, &conn->login_work, 0);
 }
 
 static struct iscsi_cmd
@@ -2348,9 +2349,9 @@ isert_get_login_rx(struct iscsi_conn *conn, struct iscsi_login *login)
 
 	/*
 	 * For login requests after the first PDU, isert_rx_login_req() will
-	 * kick schedule_delayed_work(&conn->login_work) as the packet is
-	 * received, which turns this callback from iscsi_target_do_login_rx()
-	 * into a NOP.
+	 * kick queue_delayed_work(isert_login_wq, &conn->login_work) as
+	 * the packet is received, which turns this callback from
+	 * iscsi_target_do_login_rx() into a NOP.
 	 */
 	if (!login->first_request)
 		return 0;
@@ -2606,20 +2607,23 @@ static struct iscsit_transport iser_target_transport = {
 
 static int __init isert_init(void)
 {
-	int ret;
+	isert_login_wq = alloc_workqueue("isert_login_wq", 0, 0);
+	if (!isert_login_wq) {
+		isert_err("Unable to allocate isert_login_wq\n");
+		return -ENOMEM;
+	}
 
 	isert_comp_wq = alloc_workqueue("isert_comp_wq",
 					WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!isert_comp_wq) {
 		isert_err("Unable to allocate isert_comp_wq\n");
-		return -ENOMEM;
+		goto destroy_login_wq;
 	}
 
 	isert_release_wq = alloc_workqueue("isert_release_wq", WQ_UNBOUND,
 					WQ_UNBOUND_MAX_ACTIVE);
 	if (!isert_release_wq) {
 		isert_err("Unable to allocate isert_release_wq\n");
-		ret = -ENOMEM;
 		goto destroy_comp_wq;
 	}
 
@@ -2630,17 +2634,20 @@ static int __init isert_init(void)
 
 destroy_comp_wq:
 	destroy_workqueue(isert_comp_wq);
+destroy_login_wq:
+	destroy_workqueue(isert_login_wq);
 
-	return ret;
+	return -ENOMEM;
 }
 
 static void __exit isert_exit(void)
 {
-	flush_scheduled_work();
+	flush_workqueue(isert_login_wq);
 	destroy_workqueue(isert_release_wq);
 	destroy_workqueue(isert_comp_wq);
 	iscsit_unregister_transport(&iser_target_transport);
 	isert_info("iSER_TARGET[0] - Released iser_target_transport\n");
+	destroy_workqueue(isert_login_wq);
 }
 
 MODULE_DESCRIPTION("iSER-Target for mainline target infrastructure");
-- 
2.18.4
