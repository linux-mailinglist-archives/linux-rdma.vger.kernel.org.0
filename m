Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F302D16F6D1
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 06:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgBZFKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 00:10:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45828 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 00:10:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so806524pfg.12
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 21:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=65vXred2Low6Uc/jFBrbdFfpoQKpbRTCCRyo30AFiQw=;
        b=eJ3x2Wba4tAINKmhlA3O7AUzs9JmSQw1iqKlEVHQQcu1LTK3AYl+3DkPCjcawf6tmW
         510ko0O3cJVXyqOV249yWGnduDJXsf5ractojLCk8OM/u2pXFPYuz6ONf3Vum0iZeKJ9
         qUoX05jUE1uWcLJp3Q6tUTpuRyviwwpBvUlu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=65vXred2Low6Uc/jFBrbdFfpoQKpbRTCCRyo30AFiQw=;
        b=N/ddhFK8/XWCVoyN9hYhfupKhOebKOf9XadsQHiUWH+4cdjTUllnRJJW5aLwpdsOdc
         uMYmIxPuR5M20t2hL956+WKO5DfQxWD4jAT2vMDuIbJZuSMiFM/IRsC37ZvmJC4V6brk
         ErMoWZXhm2RZuA3PJbfHJ1D7GzrYJ6C8BIr5ZGaa7HIWGDFhHvou2V2b6W3HsoErqH+V
         1nc/JEf9VmfwJJ67khkHXfdPOM9McAP/pJmqO8/z6bpqsGx2k0Q78UaP1K4Xh1GDQrmT
         84oj2xDk9qFfsfJlohmQCvByqL7E/OP3oJlJXSERR1Y+2nO6eWU0ssvjiVUTq8iNIzAU
         sNtA==
X-Gm-Message-State: APjAAAVejiKTTfRp5MYnV8X30eWdXxwx03toyQ6/XPLKSRR64poEJiND
        6vsv5fl7bi6IuHtzuQtdIaYuK5PBxLc=
X-Google-Smtp-Source: APXvYqxmhJbceVL/AUR4xcJfASo/LvN3ae7HoHn9vOACiCDkt0B+62cZPGrLB7JGjhDffAPHm5qp5w==
X-Received: by 2002:a63:d18:: with SMTP id c24mr2055137pgl.218.1582693807661;
        Tue, 25 Feb 2020 21:10:07 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o73sm817962pje.7.2020.02.25.21.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 21:10:06 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 1/2] RDMA/bnxt_re: Refactor device add/remove functionalities
Date:   Tue, 25 Feb 2020 21:09:53 -0800
Message-Id: <1582693794-23373-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c | 135 ++++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b5128cc..f44dee2 100644
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
@@ -237,7 +238,9 @@ static void bnxt_re_shutdown(void *p)
 	if (!rdev)
 		return;
 
-	bnxt_re_ib_unreg(rdev);
+	bnxt_re_ib_uninit(rdev);
+	ASSERT_RTNL();
+	bnxt_re_remove_device(rdev);
 }
 
 static void bnxt_re_stop_irq(void *handle)
@@ -1317,7 +1320,37 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
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
@@ -1373,20 +1406,15 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
-static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
+static int bnxt_re_dev_init(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_creq_ctx *creq;
 	struct bnxt_re_ring_attr rattr;
 	u32 db_offt;
-	bool locked;
 	int vid;
 	u8 type;
 	int rc;
 
-	/* Acquire rtnl lock through out this function */
-	rtnl_lock();
-	locked = true;
-
 	/* Registered a new RoCE device instance to netdev */
 	memset(&rattr, 0, sizeof(rattr));
 	rc = bnxt_re_register_netdev(rdev);
@@ -1514,23 +1542,6 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 		schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 	}
 
-	rtnl_unlock();
-	locked = false;
-
-	/* Register ib dev */
-	rc = bnxt_re_register_ib(rdev);
-	if (rc) {
-		ibdev_err(&rdev->ibdev,
-			  "Failed to register with IB: %#x\n", rc);
-		goto fail;
-	}
-	set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
-	ibdev_info(&rdev->ibdev, "Device registered successfully");
-	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
-			 &rdev->active_width);
-	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
-	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, IB_EVENT_PORT_ACTIVE);
-
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
@@ -1544,10 +1555,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 free_rcfw:
 	bnxt_qplib_free_rcfw_channel(&rdev->rcfw);
 fail:
-	if (!locked)
-		rtnl_lock();
-	bnxt_re_ib_unreg(rdev);
-	rtnl_unlock();
+	bnxt_re_dev_uninit(rdev);
 
 	return rc;
 }
@@ -1589,9 +1597,35 @@ static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
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
@@ -1606,16 +1640,17 @@ static void bnxt_re_task(struct work_struct *work)
 
 	if (re_work->event != NETDEV_REGISTER &&
 	    !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
-		return;
+		goto done;
 
 	switch (re_work->event) {
 	case NETDEV_REGISTER:
-		rc = bnxt_re_ib_reg(rdev);
+		rc = bnxt_re_ib_init(rdev);
 		if (rc) {
 			ibdev_err(&rdev->ibdev,
 				  "Failed to register with IB: %#x", rc);
-			bnxt_re_remove_one(rdev);
-			bnxt_re_dev_unreg(rdev);
+			rtnl_lock();
+			bnxt_re_remove_device(rdev);
+			rtnl_unlock();
 			goto exit;
 		}
 		break;
@@ -1638,17 +1673,13 @@ static void bnxt_re_task(struct work_struct *work)
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
@@ -1686,17 +1717,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	case NETDEV_REGISTER:
 		if (rdev)
 			break;
-		rc = bnxt_re_dev_reg(&rdev, real_dev);
-		if (rc == -ENODEV)
-			break;
-		if (rc) {
-			ibdev_err(&rdev->ibdev,
-				  "Failed to register with the device %s: %#x\n",
-				  real_dev->name, rc);
-			break;
-		}
-		bnxt_re_init_one(rdev);
-		sch_work = true;
+		rc = bnxt_re_add_device(&rdev, real_dev);
+		if (!rc)
+			sch_work = true;
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -1705,9 +1728,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
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
@@ -1784,12 +1806,11 @@ static void __exit bnxt_re_mod_exit(void)
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

