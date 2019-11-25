Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E79E108A29
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKYIkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:40:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIkL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:40:11 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so14861482wmk.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rKMFStMwnjz7q1hlJIu8NYh75xwdbICmdZIplHFUWU8=;
        b=EnHGZVc+kkOtpdWVA+tMBYe/kJBTqzdJ2iaFX6iiPSLLlHyWruNDOZV6D/VD6Wte1S
         Ias8bwBWv4zVbaCuxnkQ5I5IopALRb+xf89YhRUay4Bh+06T7tevDUBXEQWu9azEPbZY
         GBNPXo9lOX0hxqSOJd24ZRl0YEoSDIK/BE4Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rKMFStMwnjz7q1hlJIu8NYh75xwdbICmdZIplHFUWU8=;
        b=SOzOkuR6FFRwGcYjJXaO0iyQet8Wy5XQe1IuTJhZuB3Y5OltmMSHhcETSAiNjdYo8I
         1pKR/6lMmeBMqCk9RzUWTUsq1ogKADiGuLoAePZTUBwz6cZNUzy5Y0+aPdY5WAQCeeju
         BVuuDuNvajCItOJ7pichkn/8mEgkatnTlxXoAUGozETy2KukOfgi+h50ykXrZCTCVUti
         acxi4qv6QDqxiDUsAzgQz9GcrkVRUHz12sN/Zk6W655WeK36TWMRJYz8VXi1x5knf76P
         6VIbQPQGHnfFFF8rppPm2Qrf8VLsy/+6ICI0bAShjuzuACslILoRuGhzIgRkBNhWbYjL
         jU+A==
X-Gm-Message-State: APjAAAVdQ9Fkv2H9YdTtB3FSHJ4iDBEnn7IeaMRjaQg8pAcVUYYtB0De
        WuLTCvkojD3arX70aH9Mfl2eFwZKndM=
X-Google-Smtp-Source: APXvYqxZAHWtp09gsjg/sJ0JCeEffg7fD3Y1a1ivQgvV8IeX/qooGEGyA72Pdmabz29gn6o42donTA==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr17435576wmo.143.1574671208307;
        Mon, 25 Nov 2019 00:40:08 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:40:07 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 5/6] RDMA/bnxt_re: Use driver_unregister and unregistration API
Date:   Mon, 25 Nov 2019 00:39:33 -0800
Message-Id: <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using the new unregister APIs provided by the core.
Provide the dealloc_driver hook for the core to callback at the time
of device un-registration. Also, simplify bnxt_re_from_netdev by
retrieving the netdev information from the core API- ib_device_get_by_netdev.

bnxt_re VF resources are created by the corresponding PF driver.
During driver unload, if PFs gets destroyed first, driver need
not send down any command to FW. So adding a state (res_deinit) in the
per device structures to detect driver removal and avoid failures
VF destroy due to driver removal.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       | 100 ++++++++++++-----------------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   7 ++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   1 +
 3 files changed, 48 insertions(+), 60 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 0cf38a4..9ea4ce7 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -79,7 +79,7 @@ static struct list_head bnxt_re_dev_list = LIST_HEAD_INIT(bnxt_re_dev_list);
 static DEFINE_MUTEX(bnxt_re_dev_lock);
 static struct workqueue_struct *bnxt_re_wq;
 static void bnxt_re_remove_device(struct bnxt_re_dev *rdev);
-static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev);
+static void bnxt_re_dealloc_driver(struct ib_device *ib_dev);
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 {
@@ -223,9 +223,7 @@ static void bnxt_re_shutdown(void *p)
 	if (!rdev)
 		return;
 
-	bnxt_re_ib_uninit(rdev);
-	/* rtnl_lock held by L2 before coming here */
-	bnxt_re_remove_device(rdev);
+	ib_unregister_device_queued(&rdev->ibdev);
 }
 
 static void bnxt_re_stop_irq(void *handle)
@@ -527,17 +525,12 @@ static bool is_bnxt_re_dev(struct net_device *netdev)
 
 static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
 {
-	struct bnxt_re_dev *rdev;
+	struct ib_device *ibdev =
+		ib_device_get_by_netdev(netdev, RDMA_DRIVER_BNXT_RE);
+	if (!ibdev)
+		return NULL;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(rdev, &bnxt_re_dev_list, list) {
-		if (rdev->netdev == netdev) {
-			rcu_read_unlock();
-			return rdev;
-		}
-	}
-	rcu_read_unlock();
-	return NULL;
+	return container_of(ibdev, struct bnxt_re_dev, ibdev);
 }
 
 static void bnxt_re_dev_unprobe(struct net_device *netdev,
@@ -611,11 +604,6 @@ static const struct attribute_group bnxt_re_dev_attr_group = {
 	.attrs = bnxt_re_attributes,
 };
 
-static void bnxt_re_unregister_ib(struct bnxt_re_dev *rdev)
-{
-	ib_unregister_device(&rdev->ibdev);
-}
-
 static const struct ib_device_ops bnxt_re_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_BNXT_RE,
@@ -630,6 +618,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.create_cq = bnxt_re_create_cq,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,
+	.dealloc_driver = bnxt_re_dealloc_driver,
 	.dealloc_pd = bnxt_re_dealloc_pd,
 	.dealloc_ucontext = bnxt_re_dealloc_ucontext,
 	.del_gid = bnxt_re_del_gid,
@@ -726,15 +715,11 @@ static void bnxt_re_dev_remove(struct bnxt_re_dev *rdev)
 {
 	dev_put(rdev->netdev);
 	rdev->netdev = NULL;
-
 	mutex_lock(&bnxt_re_dev_lock);
 	list_del_rcu(&rdev->list);
 	mutex_unlock(&bnxt_re_dev_lock);
 
 	synchronize_rcu();
-
-	ib_dealloc_device(&rdev->ibdev);
-	/* rdev is gone */
 }
 
 static struct bnxt_re_dev *bnxt_re_dev_add(struct net_device *netdev,
@@ -767,6 +752,7 @@ static struct bnxt_re_dev *bnxt_re_dev_add(struct net_device *netdev,
 	mutex_lock(&bnxt_re_dev_lock);
 	list_add_tail_rcu(&rdev->list, &bnxt_re_dev_list);
 	mutex_unlock(&bnxt_re_dev_lock);
+
 	return rdev;
 }
 
@@ -1300,15 +1286,6 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 		le16_to_cpu(resp.hwrm_intf_patch);
 }
 
-static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev)
-{
-	/* Cleanup ib dev */
-	if (test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags)) {
-		ib_unregister_device(&rdev->ibdev);
-		clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
-	}
-}
-
 int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
 {
 	int rc = 0;
@@ -1335,10 +1312,6 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 	u8 type;
 	int rc;
 
-	if (test_and_clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags)) {
-		/* Cleanup ib dev */
-		bnxt_re_unregister_ib(rdev);
-	}
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
@@ -1595,6 +1568,19 @@ static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
 	return rc;
 }
 
+static void bnxt_re_dealloc_driver(struct ib_device *ib_dev)
+{
+	struct bnxt_re_dev *rdev =
+		container_of(ib_dev, struct bnxt_re_dev, ibdev);
+
+	clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
+	dev_info(rdev_to_dev(rdev), "Unregistering Device");
+
+	rtnl_lock();
+	bnxt_re_remove_device(rdev);
+	rtnl_unlock();
+}
+
 /* Handle all deferred netevents tasks */
 static void bnxt_re_task(struct work_struct *work)
 {
@@ -1669,6 +1655,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	struct bnxt_re_dev *rdev;
 	int rc = 0;
 	bool sch_work = false;
+	bool release = true;
 
 	real_dev = rdma_vlan_dev_real_dev(netdev);
 	if (!real_dev)
@@ -1676,7 +1663,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 	rdev = bnxt_re_from_netdev(real_dev);
 	if (!rdev && event != NETDEV_REGISTER)
-		goto exit;
+		return NOTIFY_OK;
+
 	if (real_dev != netdev)
 		goto exit;
 
@@ -1687,6 +1675,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		rc = bnxt_re_add_device(&rdev, real_dev);
 		if (!rc)
 			sch_work = true;
+		release = false;
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -1695,8 +1684,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		 */
 		if (atomic_read(&rdev->sched_count) > 0)
 			goto exit;
-		bnxt_re_ib_uninit(rdev);
-		bnxt_re_remove_device(rdev);
+		ib_unregister_device_queued(&rdev->ibdev);
 		break;
 
 	default:
@@ -1718,6 +1706,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	}
 
 exit:
+	if (release)
+		ib_device_put(&rdev->ibdev);
 	return NOTIFY_DONE;
 }
 
@@ -1753,32 +1743,22 @@ static int __init bnxt_re_mod_init(void)
 
 static void __exit bnxt_re_mod_exit(void)
 {
-	struct bnxt_re_dev *rdev, *next;
-	LIST_HEAD(to_be_deleted);
+	struct bnxt_re_dev *rdev;
 
+	flush_workqueue(bnxt_re_wq);
 	mutex_lock(&bnxt_re_dev_lock);
-	/* Free all adapter allocated resources */
-	if (!list_empty(&bnxt_re_dev_list))
-		list_splice_init(&bnxt_re_dev_list, &to_be_deleted);
-	mutex_unlock(&bnxt_re_dev_lock);
-       /*
-	* Cleanup the devices in reverse order so that the VF device
-	* cleanup is done before PF cleanup
-	*/
-	list_for_each_entry_safe_reverse(rdev, next, &to_be_deleted, list) {
-		dev_info(rdev_to_dev(rdev), "Unregistering Device");
+	list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
 		/*
-		 * Flush out any scheduled tasks before destroying the
-		 * resources
+		 * Set unreg flag to avoid VF resource cleanup
+		 * in module unload path. This is required because
+		 * dealloc_driver for VF can come after PF cleaning
+		 * the VF resources.
 		 */
-		flush_workqueue(bnxt_re_wq);
-		bnxt_re_dev_stop(rdev);
-		bnxt_re_ib_uninit(rdev);
-		/* Acquire the rtnl_lock as the L2 resources are freed here */
-		rtnl_lock();
-		bnxt_re_remove_device(rdev);
-		rtnl_unlock();
+		if (rdev->is_virtfn)
+			rdev->rcfw.res_deinit = true;
 	}
+	mutex_unlock(&bnxt_re_dev_lock);
+	ib_unregister_driver(RDMA_DRIVER_BNXT_RE);
 	unregister_netdevice_notifier(&bnxt_re_netdev_notifier);
 	if (bnxt_re_wq)
 		destroy_workqueue(bnxt_re_wq);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5cdfa84..2304f97 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -211,6 +211,13 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	u8 opcode, retry_cnt = 0xFF;
 	int rc = 0;
 
+	/* Check if the command needs to be send down to HW.
+	 * Return success if resources are de-initialized
+	 */
+
+	if (rcfw->res_deinit)
+		return 0;
+
 	do {
 		opcode = req->opcode;
 		rc = __send_message(rcfw, req, resp, sb, is_block);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index dfeadc1..c2b930e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -265,6 +265,7 @@ struct bnxt_qplib_rcfw {
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
+	bool res_deinit;
 };
 
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw);
-- 
2.5.5

