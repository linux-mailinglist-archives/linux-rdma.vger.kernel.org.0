Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB64B284C39
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJFNHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 09:07:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45654 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgJFNHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 09:07:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096D5feR190631;
        Tue, 6 Oct 2020 13:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=z7gmEoADRt17dQboSr+Z/jgc+lb3/sPVCU5BQM8XUo8=;
 b=xjFEwRd61HwHatDPaagxQj2MGrK2fnFCsnBLWwepf1ZebQZj+15OrfhXG9ederJXxKRo
 v8vVuoDV0ItqWpqYEGNb19asuKr/Zu2rMpEKFubKjOyY2mI454i/0DM/TSQvg+RSMq1M
 IXXz94PI0eabvFET6qle4CdpiYenz40glOvlfVRMhisWWWtjDYWU9yr0mbXHOnzRsARl
 vvRTqcjuHWcNcO0qIT9n1DwTzjvRRPpJs6klr9faCCautLu5KN6lIofu8Q783WNSN4/F
 8fC6P+cTI05DHIaSj9XuXgOTLNc562llCmlETBnH8Lqy/DtMkvNfL35xOk4kAnLBmG1K cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33xhxmutnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 13:07:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 096D1DQO116930;
        Tue, 6 Oct 2020 13:07:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33yyjfhfhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 13:07:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 096D7alf019567;
        Tue, 6 Oct 2020 13:07:36 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 06:07:36 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [PATCH for-next] IB/mlx4: Convert rej_tmout radix-tree to XArray
Date:   Tue,  6 Oct 2020 15:07:14 +0200
Message-Id: <1601989634-4595-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060084
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes: b7d8e64fa9db ("IB/mlx4: Add support for REJ due to timeout")

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/cm.c      | 73 +++++++++++++++---------------------
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  4 +-
 2 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 0ce4b5a..6c7986b 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -58,9 +58,7 @@ struct rej_tmout_entry {
 	int slave;
 	u32 rem_pv_cm_id;
 	struct delayed_work timeout;
-	struct radix_tree_root *rej_tmout_root;
-	/* Points to the mutex protecting this radix-tree */
-	struct mutex *lock;
+	struct xarray *xa_rej_tmout;
 };
 
 struct cm_generic_msg {
@@ -350,9 +348,7 @@ static void rej_tmout_timeout(struct work_struct *work)
 	struct rej_tmout_entry *item = container_of(delay, struct rej_tmout_entry, timeout);
 	struct rej_tmout_entry *deleted;
 
-	mutex_lock(item->lock);
-	deleted = radix_tree_delete_item(item->rej_tmout_root, item->rem_pv_cm_id, NULL);
-	mutex_unlock(item->lock);
+	deleted = xa_cmpxchg(item->xa_rej_tmout, item->rem_pv_cm_id, item, NULL, 0);
 
 	if (deleted != item)
 		pr_debug("deleted(%p) != item(%p)\n", deleted, item);
@@ -363,14 +359,13 @@ static void rej_tmout_timeout(struct work_struct *work)
 static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id, int slave)
 {
 	struct rej_tmout_entry *item;
-	int sts;
+	struct rej_tmout_entry *old;
+
+	item = xa_load(&sriov->xa_rej_tmout, (unsigned long)rem_pv_cm_id);
 
-	mutex_lock(&sriov->rej_tmout_lock);
-	item = radix_tree_lookup(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id);
-	mutex_unlock(&sriov->rej_tmout_lock);
 	if (item) {
-		if (IS_ERR(item))
-			return PTR_ERR(item);
+		if (xa_err(item))
+			return xa_err(item);
 		/* If a retry, adjust delayed work */
 		mod_delayed_work(system_wq, &item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 		return 0;
@@ -383,36 +378,30 @@ static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id, int sl
 	INIT_DELAYED_WORK(&item->timeout, rej_tmout_timeout);
 	item->slave = slave;
 	item->rem_pv_cm_id = rem_pv_cm_id;
-	item->rej_tmout_root = &sriov->rej_tmout_root;
-	item->lock = &sriov->rej_tmout_lock;
+	item->xa_rej_tmout = &sriov->xa_rej_tmout;
 
-	mutex_lock(&sriov->rej_tmout_lock);
-	sts = radix_tree_insert(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id, item);
-	mutex_unlock(&sriov->rej_tmout_lock);
-	if (sts)
-		goto err_insert;
+	old = xa_cmpxchg(&sriov->xa_rej_tmout, (unsigned long)rem_pv_cm_id, NULL, item, GFP_KERNEL);
+	if (old) {
+		pr_debug("Non-null old entry (%p) or error (%d) when inserting\n", old, xa_err(old));
+		kfree(item);
+		return xa_err(old);
+	}
 
 	schedule_delayed_work(&item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
 
 	return 0;
-
-err_insert:
-	kfree(item);
-	return sts;
 }
 
 static int lookup_rej_tmout_slave(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id)
 {
 	struct rej_tmout_entry *item;
 
-	mutex_lock(&sriov->rej_tmout_lock);
-	item = radix_tree_lookup(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id);
-	mutex_unlock(&sriov->rej_tmout_lock);
+	item = xa_load(&sriov->xa_rej_tmout, (unsigned long)rem_pv_cm_id);
 
-	if (!item || IS_ERR(item)) {
+	if (!item || xa_err(item)) {
 		pr_debug("Could not find slave. rem_pv_cm_id 0x%x error: %d\n",
-			 rem_pv_cm_id, (int)PTR_ERR(item));
-		return !item ? -ENOENT : PTR_ERR(item);
+			 rem_pv_cm_id, xa_err(item));
+		return !item ? -ENOENT : xa_err(item);
 	}
 
 	return item->slave;
@@ -483,34 +472,34 @@ void mlx4_ib_cm_paravirt_init(struct mlx4_ib_dev *dev)
 	INIT_LIST_HEAD(&dev->sriov.cm_list);
 	dev->sriov.sl_id_map = RB_ROOT;
 	xa_init_flags(&dev->sriov.pv_id_table, XA_FLAGS_ALLOC);
-	mutex_init(&dev->sriov.rej_tmout_lock);
-	INIT_RADIX_TREE(&dev->sriov.rej_tmout_root, GFP_KERNEL);
+	xa_init(&dev->sriov.xa_rej_tmout);
 }
 
-static void rej_tmout_tree_cleanup(struct mlx4_ib_sriov *sriov, int slave)
+static void rej_tmout_xa_cleanup(struct mlx4_ib_sriov *sriov, int slave)
 {
-	struct radix_tree_iter iter;
+	struct rej_tmout_entry *item;
 	bool flush_needed = false;
-	__rcu void **slot;
+	unsigned long id;
 	int cnt = 0;
 
-	mutex_lock(&sriov->rej_tmout_lock);
-	radix_tree_for_each_slot(slot, &sriov->rej_tmout_root, &iter, 0) {
-		struct rej_tmout_entry *item = *slot;
-
+	xa_lock(&sriov->xa_rej_tmout);
+	xa_for_each(&sriov->xa_rej_tmout, id, item) {
 		if (slave < 0 || slave == item->slave) {
 			mod_delayed_work(system_wq, &item->timeout, 0);
 			flush_needed = true;
 			++cnt;
 		}
 	}
-	mutex_unlock(&sriov->rej_tmout_lock);
+	xa_unlock(&sriov->xa_rej_tmout);
 
 	if (flush_needed) {
 		flush_scheduled_work();
-		pr_debug("Deleted %d entries in radix_tree for slave %d during cleanup\n",
-			 slave, cnt);
+		pr_debug("Deleted %d entries in xarray for slave %d during cleanup\n",
+			 cnt, slave);
 	}
+
+	if (slave < 0)
+		WARN_ON(!xa_empty(&sriov->xa_rej_tmout));
 }
 
 /* slave = -1 ==> all slaves */
@@ -581,5 +570,5 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev *dev, int slave)
 		kfree(map);
 	}
 
-	rej_tmout_tree_cleanup(sriov, slave);
+	rej_tmout_xa_cleanup(sriov, slave);
 }
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 2ab83ed..d8add5f 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -495,9 +495,7 @@ struct mlx4_ib_sriov {
 	spinlock_t id_map_lock;
 	struct rb_root sl_id_map;
 	struct list_head cm_list;
-	/* Protects the radix-tree */
-	struct mutex rej_tmout_lock;
-	struct radix_tree_root rej_tmout_root;
+	struct xarray xa_rej_tmout;
 };
 
 struct gid_cache_context {
-- 
1.8.3.1

