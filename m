Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8503051D99A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 May 2022 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiEFNyc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiEFNya (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 09:54:30 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20251E55
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 06:50:46 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 246DoawE061937;
        Fri, 6 May 2022 22:50:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 06 May 2022 22:50:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 246DoHZQ061862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 May 2022 22:50:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <22f7183b-cc16-5a34-e879-7605f5efc6e6@I-love.SAKURA.ne.jp>
Date:   Fri, 6 May 2022 22:50:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] RDMA/mlx4: Avoid flush_scheduled_work() usage
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
Replace system_wq with local cm_wq.

Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Note: This patch is only compile tested.

 drivers/infiniband/hw/mlx4/cm.c      | 29 +++++++++++++++++++++-------
 drivers/infiniband/hw/mlx4/main.c    | 10 +++++++++-
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  3 +++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 4aff1c8298b1..12b481d138cf 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -80,6 +80,7 @@ struct cm_req_msg {
 	union ib_gid primary_path_sgid;
 };
 
+static struct workqueue_struct *cm_wq;
 
 static void set_local_comm_id(struct ib_mad *mad, u32 cm_id)
 {
@@ -288,10 +289,10 @@ static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
 	/*make sure that there is no schedule inside the scheduled work.*/
 	if (!sriov->is_going_down && !id->scheduled_delete) {
 		id->scheduled_delete = 1;
-		schedule_delayed_work(&id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+		queue_delayed_work(cm_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 	} else if (id->scheduled_delete) {
 		/* Adjust timeout if already scheduled */
-		mod_delayed_work(system_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+		mod_delayed_work(cm_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 	}
 	spin_unlock_irqrestore(&sriov->going_down_lock, flags);
 	spin_unlock(&sriov->id_map_lock);
@@ -370,7 +371,7 @@ static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id, int sl
 			ret =  xa_err(item);
 		else
 			/* If a retry, adjust delayed work */
-			mod_delayed_work(system_wq, &item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+			mod_delayed_work(cm_wq, &item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 		goto err_or_exists;
 	}
 	xa_unlock(&sriov->xa_rej_tmout);
@@ -393,7 +394,7 @@ static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id, int sl
 		return xa_err(old);
 	}
 
-	schedule_delayed_work(&item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+	queue_delayed_work(cm_wq, &item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 
 	return 0;
 
@@ -500,7 +501,7 @@ static void rej_tmout_xa_cleanup(struct mlx4_ib_sriov *sriov, int slave)
 	xa_lock(&sriov->xa_rej_tmout);
 	xa_for_each(&sriov->xa_rej_tmout, id, item) {
 		if (slave < 0 || slave == item->slave) {
-			mod_delayed_work(system_wq, &item->timeout, 0);
+			mod_delayed_work(cm_wq, &item->timeout, 0);
 			flush_needed = true;
 			++cnt;
 		}
@@ -508,7 +509,7 @@ static void rej_tmout_xa_cleanup(struct mlx4_ib_sriov *sriov, int slave)
 	xa_unlock(&sriov->xa_rej_tmout);
 
 	if (flush_needed) {
-		flush_scheduled_work();
+		flush_workqueue(cm_wq);
 		pr_debug("Deleted %d entries in xarray for slave %d during cleanup\n",
 			 cnt, slave);
 	}
@@ -540,7 +541,7 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev *dev, int slave)
 	spin_unlock(&sriov->id_map_lock);
 
 	if (need_flush)
-		flush_scheduled_work(); /* make sure all timers were flushed */
+		flush_workqueue(cm_wq); /* make sure all timers were flushed */
 
 	/* now, remove all leftover entries from databases*/
 	spin_lock(&sriov->id_map_lock);
@@ -587,3 +588,17 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev *dev, int slave)
 
 	rej_tmout_xa_cleanup(sriov, slave);
 }
+
+int mlx4_ib_cm_init(void)
+{
+	cm_wq = alloc_workqueue("mlx4_ib_cm", 0, 0);
+	if (!cm_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void mlx4_ib_cm_destroy(void)
+{
+	destroy_workqueue(cm_wq);
+}
diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index c448168375db..ba47874f90d3 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3307,10 +3307,14 @@ static int __init mlx4_ib_init(void)
 	if (!wq)
 		return -ENOMEM;
 
-	err = mlx4_ib_mcg_init();
+	err = mlx4_ib_cm_init();
 	if (err)
 		goto clean_wq;
 
+	err = mlx4_ib_mcg_init();
+	if (err)
+		goto clean_cm;
+
 	err = mlx4_register_interface(&mlx4_ib_interface);
 	if (err)
 		goto clean_mcg;
@@ -3320,6 +3324,9 @@ static int __init mlx4_ib_init(void)
 clean_mcg:
 	mlx4_ib_mcg_destroy();
 
+clean_cm:
+	mlx4_ib_cm_destroy();
+
 clean_wq:
 	destroy_workqueue(wq);
 	return err;
@@ -3329,6 +3336,7 @@ static void __exit mlx4_ib_cleanup(void)
 {
 	mlx4_unregister_interface(&mlx4_ib_interface);
 	mlx4_ib_mcg_destroy();
+	mlx4_ib_cm_destroy();
 	destroy_workqueue(wq);
 }
 
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index d84023b4b1b8..6a3b0f121045 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -937,4 +937,7 @@ mlx4_ib_destroy_rwq_ind_table(struct ib_rwq_ind_table *wq_ind_table)
 int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
 				       int *num_of_mtts);
 
+int mlx4_ib_cm_init(void);
+void mlx4_ib_cm_destroy(void);
+
 #endif /* MLX4_IB_H */
-- 
2.34.1
