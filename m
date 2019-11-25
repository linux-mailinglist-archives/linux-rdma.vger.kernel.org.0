Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB748108A28
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfKYIkI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:40:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51749 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIkI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:40:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so14159107wme.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnCWu2YByTvrq6H4KNxnq0uugqxVE2UA7neUdMCLUOA=;
        b=O1a37BgZAOYBbIifxdbamQKfzZlPhlBYqtstU4FfGTY4c9vIXG3wTqjBS0UnIhblGL
         PZEw1WD6LkIOtAXdTnML7iF6tpJivq4i4FT4WHcnyvryvwzusbjrdXfOVFIX9QuqZ/VE
         TUjB5OOPkC99Ek3gUjf9T+E9/AgKVHgCqRiAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dnCWu2YByTvrq6H4KNxnq0uugqxVE2UA7neUdMCLUOA=;
        b=VM4NbSlPQHx8+R2mo2kRhFHswNs9P1jh4kZDqPfIvkPWMbdhSfJb65RKq9ZwocyQvQ
         qMwYDgadyZC33Zbm9Tw4HmX9DvGZxzekhXf2JQ0dfkJfQ+swZ98D6K6/y5KJIcR2fqlC
         moZufdUL8sHR5s+JFKo66d0bgpZKomDurxzH1uWXpEOfBpNbvzCd1cu5b7ZbLpxarp7N
         h+1nBT0XM4WHoOb33yYJ+pVQP7Ue2F89eC4ZdQk7xf4rv1482A0u4Kuz406TNtOsVC5J
         ts79V5YfWT/RgVXoC35NFiPe9Y60COa3duQX3Uy3fdLaS066C4v/cHtc59sKGzcQLsm+
         xLqA==
X-Gm-Message-State: APjAAAWX/VFfnCpiGhkOsp9a7BWaegOsGV8qrbj1IdVjaKFcaFOfn8Jv
        ZejVhZwvoM2VCyK/rNNM2IfLHg==
X-Google-Smtp-Source: APXvYqyIfQPdDelULJk/jLvbW8FvDgjoa71Yz38tqmeSMKqbn3ldET0YrxP8xZ9VXxkgpfGYm89n0g==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr29259513wmd.80.1574671205375;
        Mon, 25 Nov 2019 00:40:05 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:40:04 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 4/6] RDMA/bnxt_re: Refactor device add/remove functionalities
Date:   Mon, 25 Nov 2019 00:39:32 -0800
Message-Id: <1574671174-5064-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 - bnxt_re_ib_reg() handles two main functionalities - initializing
   the device and registering with the IB stack.  Split it into 2
   functions i.e. bnxt_re_dev_init() and bnxt_re_ib_init()  to account
   for the same thereby improve modularity. Do the same for
   bnxt_re_ib_unreg()i.e. split into two functions - bnxt_re_dev_uninit()
   and  bnxt_re_ib_uninit().
 - Simplify the code by combining the different steps to add and
   remove the device into two functions.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 133 ++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fbe3192..0cf38a4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -78,7 +78,8 @@ static struct list_head bnxt_re_dev_list = LIST_HEAD_INIT(bnxt_re_dev_list);
 /* Mutex to protect the list of bnxt_re devices added */
 static DEFINE_MUTEX(bnxt_re_dev_lock);
 static struct workqueue_struct *bnxt_re_wq;
-static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev);
+static void bnxt_re_remove_device(struct bnxt_re_dev *rdev);
+static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev);
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 {
@@ -222,7 +223,9 @@ static void bnxt_re_shutdown(void *p)
 	if (!rdev)
 		return;
 
-	bnxt_re_ib_unreg(rdev);
+	bnxt_re_ib_uninit(rdev);
+	/* rtnl_lock held by L2 before coming here */
+	bnxt_re_remove_device(rdev);
 }
 
 static void bnxt_re_stop_irq(void *handle)
@@ -1297,7 +1300,37 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 		le16_to_cpu(resp.hwrm_intf_patch);
 }
 
-static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev)
+static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev)
+{
+	/* Cleanup ib dev */
+	if (test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags)) {
+		ib_unregister_device(&rdev->ibdev);
+		clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
+	}
+}
+
+int bnxt_re_ib_init(struct bnxt_re_dev *rdev)
+{
+	int rc = 0;
+
+	/* Register ib dev */
+	rc = bnxt_re_register_ib(rdev);
+	if (rc) {
+		pr_err("Failed to register with IB: %#x\n", rc);
+		return rc;
+	}
+	set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
+	dev_info(rdev_to_dev(rdev), "Device registered successfully");
+	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
+			 &rdev->active_width);
+	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
+	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, IB_EVENT_PORT_ACTIVE);
+	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, IB_EVENT_GID_CHANGE);
+
+	return rc;
+}
+
+static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 {
 	u8 type;
 	int rc;
@@ -1358,19 +1391,14 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
-static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
+static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 {
 	dma_addr_t *pg_map;
 	u32 db_offt, ridx;
 	int pages, vid;
-	bool locked;
 	u8 type;
 	int rc;
 
-	/* Acquire rtnl lock through out this function */
-	rtnl_lock();
-	locked = true;
-
 	/* Registered a new RoCE device instance to netdev */
 	rc = bnxt_re_register_netdev(rdev);
 	if (rc) {
@@ -1493,29 +1521,10 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 		schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 	}
 
-	rtnl_unlock();
-	locked = false;
-
-	/* Register ib dev */
-	rc = bnxt_re_register_ib(rdev);
-	if (rc) {
-		pr_err("Failed to register with IB: %#x\n", rc);
-		goto fail;
-	}
-	set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
-	dev_info(rdev_to_dev(rdev), "Device registered successfully");
-	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
-			 &rdev->active_width);
-	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
-	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, IB_EVENT_PORT_ACTIVE);
-
 	return 0;
 fail:
-	if (!locked)
-		rtnl_lock();
-	bnxt_re_ib_unreg(rdev);
-	rtnl_unlock();
 
+	bnxt_re_dev_uninit(rdev);
 	return rc;
 }
 
@@ -1555,9 +1564,35 @@ static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
 	return rc;
 }
 
-static void bnxt_re_remove_one(struct bnxt_re_dev *rdev)
+static void bnxt_re_remove_device(struct bnxt_re_dev *rdev)
 {
+	bnxt_re_dev_uninit(rdev);
 	pci_dev_put(rdev->en_dev->pdev);
+	bnxt_re_dev_unreg(rdev);
+}
+
+static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
+			      struct net_device *netdev)
+{
+	int rc;
+
+	rc = bnxt_re_dev_reg(rdev, netdev);
+	if (rc == -ENODEV)
+		return rc;
+	if (rc) {
+		pr_err("Failed to register with the device %s: %#x\n",
+		       netdev->name, rc);
+		return rc;
+	}
+
+	pci_dev_get((*rdev)->en_dev->pdev);
+	rc = bnxt_re_dev_init(*rdev);
+	if (rc) {
+		pci_dev_put((*rdev)->en_dev->pdev);
+		bnxt_re_dev_unreg(*rdev);
+	}
+
+	return rc;
 }
 
 /* Handle all deferred netevents tasks */
@@ -1572,16 +1607,17 @@ static void bnxt_re_task(struct work_struct *work)
 
 	if (re_work->event != NETDEV_REGISTER &&
 	    !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
-		return;
+		goto done;
 
 	switch (re_work->event) {
 	case NETDEV_REGISTER:
-		rc = bnxt_re_ib_reg(rdev);
+		rc = bnxt_re_ib_init(rdev);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev),
 				"Failed to register with IB: %#x", rc);
-			bnxt_re_remove_one(rdev);
-			bnxt_re_dev_unreg(rdev);
+			rtnl_lock();
+			bnxt_re_remove_device(rdev);
+			rtnl_unlock();
 			goto exit;
 		}
 		break;
@@ -1604,17 +1640,13 @@ static void bnxt_re_task(struct work_struct *work)
 	default:
 		break;
 	}
+done:
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:
 	kfree(re_work);
 }
 
-static void bnxt_re_init_one(struct bnxt_re_dev *rdev)
-{
-	pci_dev_get(rdev->en_dev->pdev);
-}
-
 /*
  * "Notifier chain callback can be invoked for the same chain from
  * different CPUs at the same time".
@@ -1652,16 +1684,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	case NETDEV_REGISTER:
 		if (rdev)
 			break;
-		rc = bnxt_re_dev_reg(&rdev, real_dev);
-		if (rc == -ENODEV)
-			break;
-		if (rc) {
-			pr_err("Failed to register with the device %s: %#x\n",
-			       real_dev->name, rc);
-			break;
-		}
-		bnxt_re_init_one(rdev);
-		sch_work = true;
+		rc = bnxt_re_add_device(&rdev, real_dev);
+		if (!rc)
+			sch_work = true;
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -1670,9 +1695,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		 */
 		if (atomic_read(&rdev->sched_count) > 0)
 			goto exit;
-		bnxt_re_ib_unreg(rdev);
-		bnxt_re_remove_one(rdev);
-		bnxt_re_dev_unreg(rdev);
+		bnxt_re_ib_uninit(rdev);
+		bnxt_re_remove_device(rdev);
 		break;
 
 	default:
@@ -1749,12 +1773,11 @@ static void __exit bnxt_re_mod_exit(void)
 		 */
 		flush_workqueue(bnxt_re_wq);
 		bnxt_re_dev_stop(rdev);
+		bnxt_re_ib_uninit(rdev);
 		/* Acquire the rtnl_lock as the L2 resources are freed here */
 		rtnl_lock();
-		bnxt_re_ib_unreg(rdev);
+		bnxt_re_remove_device(rdev);
 		rtnl_unlock();
-		bnxt_re_remove_one(rdev);
-		bnxt_re_dev_unreg(rdev);
 	}
 	unregister_netdevice_notifier(&bnxt_re_netdev_notifier);
 	if (bnxt_re_wq)
-- 
2.5.5

