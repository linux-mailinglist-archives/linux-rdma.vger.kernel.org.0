Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4618D16A44D
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBXKuN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:50:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41536 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXKuN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 05:50:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so9810500wrw.8
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 02:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UYc4YubWH5Kmwr3B3MeH+4mb+bQlFGCCqkM+VNqFF0Q=;
        b=RRxAjh0hQNnCT15I1I1a8cF7yr4ZZdl/Dsa5sf2R8M6xNCWRgSONp6iCO3VKA1NGAm
         Gs52z3hVZWbbEpfuizmNdq4EunwqeVoT6brJTyuADubJNhc4qNWAGrDzpAFmSnDCAsdc
         fu6Y2VSC/u0QqoZUjbiUe+5dkZhxQKH178e48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UYc4YubWH5Kmwr3B3MeH+4mb+bQlFGCCqkM+VNqFF0Q=;
        b=qD2H2d9jMNG93LJHDbchDbErexmF+TUqXyLV02FMthKGZZPYFqHJLoTKm2y5UeV5uE
         X9fI9oBEphsI+g4cSjVajrStJJ2RUlD3qaSgFRjR8u/4Q9hOA6MiTUyViD6m/Z+IzBi7
         CdzUPxfNlNfPYPFRb+Tb1GjMYHx+c/I96S9M+LW3hrEYw+fmcDld5x54Prc9Acugtwyo
         W68HqQYwR/ge3K06z/CJMK48sOeRV6IrV+N7LGYwntjZ7bfdYBSyzItG0yq2p+gX591L
         c3vFrsT5T7x6F37rgIRSonRv7ww8P8GVOcXjeWArWoGCJhHbY/ib74FkQ05MqKeRrrjO
         fFdA==
X-Gm-Message-State: APjAAAUXj+AQA5JdYLh/CjLrElwUjVs5RDWVNOPitwfl23+wG6jVorjf
        B980tn1ZnuSwNmG5gTcFSVg1gg==
X-Google-Smtp-Source: APXvYqxOcmMc9H+FhT6OgDTsomuP8ZNdI9JAiPLybYIVeF+X9YIcPzH4pv1I4HFqfNjBP/lyMnhheA==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr66497694wrq.155.1582541410874;
        Mon, 24 Feb 2020 02:50:10 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c9sm18096426wrq.44.2020.02.24.02.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 02:50:09 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/3] RDMA/bnxt_re: Refactor device add/remove functionalities
Date:   Mon, 24 Feb 2020 02:49:54 -0800
Message-Id: <1582541395-19409-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
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
index 1402130..3a548b1 100644
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
@@ -1378,20 +1411,15 @@ static void bnxt_re_worker(struct work_struct *work)
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
@@ -1524,30 +1552,10 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
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
 fail:
-	if (!locked)
-		rtnl_lock();
-	bnxt_re_ib_unreg(rdev);
-	rtnl_unlock();
 
+	bnxt_re_dev_uninit(rdev);
 	return rc;
 }
 
@@ -1588,9 +1596,35 @@ static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
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
@@ -1605,16 +1639,17 @@ static void bnxt_re_task(struct work_struct *work)
 
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
@@ -1637,17 +1672,13 @@ static void bnxt_re_task(struct work_struct *work)
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
@@ -1685,17 +1716,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
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
@@ -1704,9 +1727,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
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
@@ -1783,12 +1805,11 @@ static void __exit bnxt_re_mod_exit(void)
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

