Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7928916F6D2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 06:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgBZFKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 00:10:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45222 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFKM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Feb 2020 00:10:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id r77so688464pgr.12
        for <linux-rdma@vger.kernel.org>; Tue, 25 Feb 2020 21:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ldTzKn3oUGCLA1h+1yhCorE/mKDLJ3OTbxvySgSJ6rw=;
        b=Y/bnHpmkEa24arfGplatCjKy82bLsDMtHbndK+oFp8mQJhOJEHHXSmiUdRtBYyBSRY
         +GXrtE1ybsjotSjKO51xUOXWE+6MnOeGrtgyJr/Uujc6nX+XLfdSnMcid3+2SUxNl4gr
         E5iBGp4DYCHKVoIWkn505OU9t6FIlnhd96f4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ldTzKn3oUGCLA1h+1yhCorE/mKDLJ3OTbxvySgSJ6rw=;
        b=eN55a9sWliG/eka7yp80p+XFygtjTScFJfXDoZaPDL68XaHxG9mYTMmptgzGQX6dt+
         r9FbPFvmKJqLOUDJ/e4IlKJafC53IcA5Kxq4RUS2vzSv/v+A1mAfCR1MG5zAqfJjMmmr
         63rgURYh5CqKi8kntcTq/isddfl6XnNV1iUjv9H4V6gM2z/3vRigp6iTKF3uvCfg8WZB
         xRxQCIlDdaBODWqEIc3NIOyk9NLiHmITnlaUntZCIqNwnkw7bIwk6U0Qi7Cegi2AcsSk
         k2sX3FdIA5RUZQ6Q6zzM4DD8RVf6Z5IItv3h8m5VihMRh18NFFqyWvRNJAQ+Emgtc7MF
         2SCg==
X-Gm-Message-State: APjAAAX+Pq8twPCN3yPpL8CELFCvg6zA4+N2QQ2OMG6gRVIITsX6KVl5
        jTT2mtthlGyiNsAwYaPXQ9IX6UqHqUw=
X-Google-Smtp-Source: APXvYqwT6s8jsLT3OjSC9zuYhBzi5DrJP3h0+Wzqybi0CHE0JgVs+jNHmoIP8OjcpBs2H3JIZR/u2A==
X-Received: by 2002:a63:3349:: with SMTP id z70mr2018912pgz.408.1582693810878;
        Tue, 25 Feb 2020 21:10:10 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o73sm817962pje.7.2020.02.25.21.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 21:10:09 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 2/2] RDMA/bnxt_re: Use driver_unregister and unregistration API
Date:   Tue, 25 Feb 2020 21:09:54 -0800
Message-Id: <1582693794-23373-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
References: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
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
calling ib_unregister_driver.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 106 ++++++++++++++---------------------
 1 file changed, 42 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index f44dee2..28bdb01 100644
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
 
@@ -1628,6 +1603,19 @@ static int bnxt_re_add_device(struct bnxt_re_dev **rdev,
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
@@ -1702,6 +1690,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	struct bnxt_re_dev *rdev;
 	int rc = 0;
 	bool sch_work = false;
+	bool release = true;
 
 	real_dev = rdma_vlan_dev_real_dev(netdev);
 	if (!real_dev)
@@ -1709,7 +1698,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 
 	rdev = bnxt_re_from_netdev(real_dev);
 	if (!rdev && event != NETDEV_REGISTER)
-		goto exit;
+		return NOTIFY_OK;
+
 	if (real_dev != netdev)
 		goto exit;
 
@@ -1720,6 +1710,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		rc = bnxt_re_add_device(&rdev, real_dev);
 		if (!rc)
 			sch_work = true;
+		release = false;
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -1728,8 +1719,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		 */
 		if (atomic_read(&rdev->sched_count) > 0)
 			goto exit;
-		bnxt_re_ib_uninit(rdev);
-		bnxt_re_remove_device(rdev);
+		ib_unregister_device_queued(&rdev->ibdev);
 		break;
 
 	default:
@@ -1751,6 +1741,8 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	}
 
 exit:
+	if (rdev && release)
+		ib_device_put(&rdev->ibdev);
 	return NOTIFY_DONE;
 }
 
@@ -1786,35 +1778,21 @@ static int __init bnxt_re_mod_init(void)
 
 static void __exit bnxt_re_mod_exit(void)
 {
-	struct bnxt_re_dev *rdev, *next;
-	LIST_HEAD(to_be_deleted);
+	struct bnxt_re_dev *rdev;
 
-	mutex_lock(&bnxt_re_dev_lock);
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
-		 */
-		flush_workqueue(bnxt_re_wq);
-		bnxt_re_dev_stop(rdev);
-		bnxt_re_ib_uninit(rdev);
-		/* Acquire the rtnl_lock as the L2 resources are freed here */
-		rtnl_lock();
-		bnxt_re_remove_device(rdev);
-		rtnl_unlock();
-	}
 	unregister_netdevice_notifier(&bnxt_re_netdev_notifier);
 	if (bnxt_re_wq)
 		destroy_workqueue(bnxt_re_wq);
+	list_for_each_entry(rdev, &bnxt_re_dev_list, list) {
+		/* VF device removal should be called before the removal
+		 * of PF device. Queue VFs unregister first, so that VFs
+		 * shall be removed before the PF during the call of
+		 * ib_unregister_driver.
+		 */
+		if (rdev->is_virtfn)
+			ib_unregister_device(&rdev->ibdev);
+	}
+	ib_unregister_driver(RDMA_DRIVER_BNXT_RE);
 }
 
 module_init(bnxt_re_mod_init);
-- 
2.5.5

