Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAD1702FA
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 16:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgBZPpq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 10:45:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35586 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgBZPpp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 10:45:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id i19so1657159pfa.2
        for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2020 07:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DWZPRVFNWjprGh+RXaeW0rZxltLJKRsKKrF/853Uiz4=;
        b=CMJcl6bY7osiBWqPBTbRCmxWoYwuw+q+ixtVdpbbiMX0iL0CxLWlMTM+j0vYSbWfos
         7K3hYi/nggQFCdegr/Q8mGalx1eXWwjXlFt+D9I0xBo47EDSm/hW69oxGfoxUDQQsy/q
         nPEbd1Wrkl1IvvW6W9n/qsZINL8jrSMgd7OUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DWZPRVFNWjprGh+RXaeW0rZxltLJKRsKKrF/853Uiz4=;
        b=EqB+YxOpm7/Y1f/qVhBKfbz0HpHIA1LaKn++FHOS3uvBbW00ZPNhQUiD2Yun9xS/+F
         lozLUTFvjwRiTKE0gop9yzz2EvKwx2F+QShXrUyzSzmM0POczTMbTfGqYBRj1L0ALNMZ
         8fRww2hzuDR+D/lszuPkNAQybwoHaZC8u6tJqWQBbdfTRBEwqp3RdhA6QM9WfaQq+pEB
         GMjYUdk4XTov+zVWo/muBfhHN6MWms5iQ3QuyTu0CoNN6KEV5iyYyO75ice5sEshdBiX
         wWzER/6+ufGIgC5mVoiZ8gE2065H3bvPbqXDXkmOAHbGMNTTVuN8vymWdJpXkUDz1dhb
         zbAw==
X-Gm-Message-State: APjAAAUpJVCr+qtnGcUXs94hmiB5EKsphasP8aWiQUyepGAyqOkpOYxf
        iPMRAHxfxwJ/Wa32SkyANIpyQw==
X-Google-Smtp-Source: APXvYqzzfz5y2kmjr9fIxJT/2KBN9yXV2Xo+wrpTf2FD9AHj20FsZBRLbzspQdDut16h2ih6q066Fw==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr5096237pfh.189.1582731944318;
        Wed, 26 Feb 2020 07:45:44 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h3sm3502785pfo.102.2020.02.26.07.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 07:45:43 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v4 1/2] RDMA/bnxt_re: Refactor device add/remove functionalities
Date:   Wed, 26 Feb 2020 07:45:31 -0800
Message-Id: <1582731932-26574-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
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
 - Report correct netdev link state during device register

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 139 +++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b5128cc..5f8fd74 100644
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
@@ -1317,7 +1320,41 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
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
+	u32 event;
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
+
+	event = netif_running(rdev->netdev) && netif_carrier_ok(rdev->netdev) ?
+		IB_EVENT_PORT_ACTIVE : IB_EVENT_PORT_ERR;
+
+	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1, event);
+
+	return rc;
+}
+
+static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 {
 	u8 type;
 	int rc;
@@ -1373,20 +1410,15 @@ static void bnxt_re_worker(struct work_struct *work)
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
@@ -1514,23 +1546,6 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
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
@@ -1544,10 +1559,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
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
@@ -1589,9 +1601,35 @@ static int bnxt_re_dev_reg(struct bnxt_re_dev **rdev, struct net_device *netdev)
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
@@ -1606,16 +1644,17 @@ static void bnxt_re_task(struct work_struct *work)
 
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
@@ -1638,17 +1677,13 @@ static void bnxt_re_task(struct work_struct *work)
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
@@ -1686,17 +1721,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
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
@@ -1705,9 +1732,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
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
@@ -1784,12 +1810,11 @@ static void __exit bnxt_re_mod_exit(void)
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

