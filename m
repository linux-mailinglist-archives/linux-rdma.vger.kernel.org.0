Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E3716A44F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXKuQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:50:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXKuQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 05:50:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id e8so9807452wrm.5
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 02:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BmppQlbJRz0w8KNJ0nbzuNuPVPH7cIIQhQrpCUHRnOY=;
        b=LVJiV9zp34c+6J6pdTB1DKDBB0ncHQ0DQWS9JVdJPnnraQBAuBGAOYpepMMapf5XgH
         tdV66jlyuywedywY52gAaCaZ2VpppJeIqvUxg7rPX1fGp0J3GZq6pVqw510tKgUomfrK
         aqyaaRT6hAVvX+t+gv87ps5oFPZC1ncS1R8/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BmppQlbJRz0w8KNJ0nbzuNuPVPH7cIIQhQrpCUHRnOY=;
        b=tqPpgSnET+iOTJDEKGNl8bJcd68VL8sFZSAlIqqMCMHJ0iPznxuGSu0wrJFpdxcJKT
         rB7rqS+6xIeklfF4WGAYQFvvpLvQYWxB+c5tGvzQHRGrFPJdO2p7+Ys+KfQ4fyIf0FGY
         YZMGt2OpKYPUKvXuLHtGuNy+Cp5W54VeWRinSHfulUX8mn08ZaosuRWK3Gbk/HWR+HZg
         0mUb6u2mBiwZ4vMAfAVbb/0Ow2lfQ453vTQrSst118hc0DeZIrwzdyt6LmhLjOK+eiVu
         nkzO/Ls/P/T6rJaTFO3JfVsfGurM8eJW6i5SjEhtgwxR4wB9SV3Am4wzCuEDiJ0WRtoP
         +m/g==
X-Gm-Message-State: APjAAAU9suPZb85Rd4mF4ricuNIyTiySEefC9QI0ublQdYdGsDZO2jHM
        4g1/8YVFqllrYbWmOEVs1Pl6Tg==
X-Google-Smtp-Source: APXvYqz/g3v0Xw5V1SCjcI5bkUHB24x5mvxYdmGWWeJeSJlaWJYFzUHrgg66iWsfzQFT9PM7z6N41A==
X-Received: by 2002:adf:db48:: with SMTP id f8mr62540198wrj.146.1582541413697;
        Mon, 24 Feb 2020 02:50:13 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c9sm18096426wrq.44.2020.02.24.02.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 02:50:13 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 3/3] RDMA/bnxt_re: Use driver_unregister and unregistration API
Date:   Mon, 24 Feb 2020 02:49:55 -0800
Message-Id: <1582541395-19409-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using the new unregister APIs provided by the core.
Provide the dealloc_driver hook for the core to callback at the time
of device un-registration.

bnxt_re VF resources are created by the corresponding PF driver.
During ib_unregister_driver, PF might get removed before VF
and this could cause failure when VFs are removed. Driver
is explicitly queuing the removal of VF devices before
calling ib_unregister_driver. Commands to any VFs after
the PF removal will timeout and driver will proceed with
unregisteration and free up the host resources.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 105 +++++++++++++++--------------------
 1 file changed, 44 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3a548b1..6dec09d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -79,7 +79,8 @@ static struct list_head bnxt_re_dev_list = LIST_HEAD_INIT(bnxt_re_dev_list);
 static DEFINE_MUTEX(bnxt_re_dev_lock);
 static struct workqueue_struct *bnxt_re_wq;
 static void bnxt_re_remove_device(struct bnxt_re_dev *rdev);
-static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev);
+static void bnxt_re_dealloc_driver(struct ib_device *ib_dev);
+static void bnxt_re_stop_irq(void *handle);
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
 {
@@ -237,10 +238,10 @@ static void bnxt_re_shutdown(void *p)
 
 	if (!rdev)
 		return;
-
-	bnxt_re_ib_uninit(rdev);
 	ASSERT_RTNL();
-	bnxt_re_remove_device(rdev);
+	/* Release the MSIx vectors before queuing unregister */
+	bnxt_re_stop_irq(rdev);
+	ib_unregister_device_queued(&rdev->ibdev);
 }
 
 static void bnxt_re_stop_irq(void *handle)
@@ -542,17 +543,12 @@ static bool is_bnxt_re_dev(struct net_device *netdev)
 
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
@@ -626,11 +622,6 @@ static const struct attribute_group bnxt_re_dev_attr_group = {
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
@@ -645,6 +636,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
 	.create_cq = bnxt_re_create_cq,
 	.create_qp = bnxt_re_create_qp,
 	.create_srq = bnxt_re_create_srq,
+	.dealloc_driver = bnxt_re_dealloc_driver,
 	.dealloc_pd = bnxt_re_dealloc_pd,
 	.dealloc_ucontext = bnxt_re_dealloc_ucontext,
 	.del_gid = bnxt_re_del_gid,
@@ -741,15 +733,11 @@ static void bnxt_re_dev_remove(struct bnxt_re_dev *rdev)
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
@@ -1320,15 +1308,6 @@ static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
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
@@ -1355,10 +1334,6 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 	u8 type;
 	int rc;
 
-	if (test_and_clear_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags)) {
-		/* Cleanup ib dev */
-		bnxt_re_unregister_ib(rdev);
-	}
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
@@ -1627,6 +1602,19 @@ static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
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
@@ -1701,6 +1689,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	struct bnxt_re_dev *rdev;
 	int rc = 0;
 	bool sch_work = false;
+	bool release = true;
 
 	real_dev = rdma_vlan_dev_real_dev(netdev);
 	if (!real_dev)
@@ -1708,7 +1697,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 	rdev = bnxt_re_from_netdev(real_dev);
 	if (!rdev && event != NETDEV_REGISTER)
-		goto exit;
+		return NOTIFY_OK;
+
 	if (real_dev != netdev)
 		goto exit;
 
@@ -1719,6 +1709,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		rc = bnxt_re_add_device(&rdev, real_dev);
 		if (!rc)
 			sch_work = true;
+		release = false;
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -1727,8 +1718,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		 */
 		if (atomic_read(&rdev->sched_count) > 0)
 			goto exit;
-		bnxt_re_ib_uninit(rdev);
-		bnxt_re_remove_device(rdev);
+		ib_unregister_device_queued(&rdev->ibdev);
 		break;
 
 	default:
@@ -1750,6 +1740,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	}
 
 exit:
+	if (rdev && release)
+		ib_device_put(&rdev->ibdev);
 	return NOTIFY_DONE;
 }
 
@@ -1785,32 +1777,23 @@ static int __init bnxt_re_mod_init(void)
 
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
-		ibdev_info(&rdev->ibdev, "Unregistering Device");
-		/*
-		 * Flush out any scheduled tasks before destroying the
-		 * resources
+	list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
+		/* VF device removal should be called before the removal
+		 * of PF device. Queue VFs unregister first, so that VFs
+		 * shall be removed before the PF during the call of
+		 * ib_unregister_driver. Commands to any VFs after the
+		 * PF removal will timeout and driver will proceed with
+		 * unregisteration and free up the host resources.
 		 */
-		flush_workqueue(bnxt_re_wq);
-		bnxt_re_dev_stop(rdev);
-		bnxt_re_ib_uninit(rdev);
-		/* Acquire the rtnl_lock as the L2 resources are freed here */
-		rtnl_lock();
-		bnxt_re_remove_device(rdev);
-		rtnl_unlock();
+		if (rdev->is_virtfn)
+			ib_unregister_device_queued(&rdev->ibdev);
 	}
+	mutex_unlock(&bnxt_re_dev_lock);
+	ib_unregister_driver(RDMA_DRIVER_BNXT_RE);
 	unregister_netdevice_notifier(&bnxt_re_netdev_notifier);
 	if (bnxt_re_wq)
 		destroy_workqueue(bnxt_re_wq);
-- 
2.5.5

