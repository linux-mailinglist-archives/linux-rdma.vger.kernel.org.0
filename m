Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88080239F94
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Aug 2020 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHCGUI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Aug 2020 02:20:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgHCGUI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Aug 2020 02:20:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736H6lv142432;
        Mon, 3 Aug 2020 06:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Y4Am94wJlPmUlcS9GYRdReIpJgsVQCUgfSwaJEy6r5g=;
 b=C4fE3mLL5kyFMrLTL2wG44ax3jXBtfVGG8qM/d9egXBzXBwrTg2ZG5K6BHfbnKmQrUm/
 SqFL2yK0H0BDhPMmFBfhWGE2304R7OB6jJUaIldS14Bb8Ayxs0UP7SSBvyIIXbLzYky/
 Clxnvyg9JQasyanfx6ilRWZTRDsVjR+LAJuKDXO7uA68pJpv0IjofhbZY3D4X6qqT8cL
 T7M0D1CDna1swx7YbMMpMA/Xndnv9yr0g0D2OAcJ0LsxzDR+N7VImeqAf2YckHwYVsSd
 k5nF3QCaNcPY9PZxp2c/kqkuA+Mr0H603UE69Qi+QLmtoEqpb982UNDDaOp3CE4XbENS zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32mytqvpa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 06:20:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0736Hd7i168467;
        Mon, 3 Aug 2020 06:20:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32njaugb9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 06:20:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0736K0QF010093;
        Mon, 3 Aug 2020 06:20:00 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 Aug 2020 23:20:00 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     jgg@mellanox.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, yishaih@mellanox.com,
        jackm@dev.mellanox.co.il, ranro@mellanox.com
Subject: [PATCH for-rc v2 5/6] IB/mlx4: Add support for REJ due to timeout
Date:   Mon,  3 Aug 2020 08:19:40 +0200
Message-Id: <20200803061941.1139994-6-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803061941.1139994-1-haakon.bugge@oracle.com>
References: <20200803061941.1139994-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9701 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030045
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A CM REJ packet with its reason equal to timeout is a special beast in
the sense that it doesn't have a Remote Communication ID nor does it
have a Remote Port GID.

Using CX-3 virtual functions, either from a bare-metal machine or
pass-through from a VM, MAD packets are proxied through the PF driver.

Since the VF drivers have separate name spaces for MAD Transaction Ids
(TIDs), the PF driver has to re-map the TIDs and keep the book keeping
in a cache.

This proxying doesn't not handle said REJ packets.

If the active side abandons its connection attempt after having sent a
REQ, it will send a REJ with the reason being timeout. This example
can be provoked by a simple user-verbs program, which ends up doing:

    rdma_connect(cm_id, &conn_param);
    rdma_destroy_id(cm_id);

using the async librdmacm API.

Having dynamic debug prints enabled in the mlx4_ib driver, we will
then see:

mlx4_ib_demux_cm_handler: Couldn't find an entry for pv_cm_id 0x0, attr_id 0x12

The solution is to introduce a radix-tree. When a REQ packet is
received and handled in mlx4_ib_demux_cm_handler(), we know the
connecting peer's para-virtual cm_id and the destination slave. We
then insert an entry into the tree with said information. We also
schedule work to remove this entry from the tree and free it, in order
to avoid memory leak.

When a REJ packet with reason timeout is received, we can look up the
slave in the tree, and deliver the packet to the correct slave.

When a duplicate REQ packet is received, the entry is in the tree. In
this case, we adjust the delayed work in order to avoid a too
premature eviction of the entry.

When cleaning up, we simply traverse the tree and modify any delayed
work to use a zero delay. A subsequent flush of the system_wq will
ensure all entries being wiped out.

Fixes: 3cf69cc8dbeb ("IB/mlx4: Add CM paravirtualization")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---
    v1 -> v2:
    * Removed noisy pr_debug()
    * Adjust the delay of the work when a duplicate REQ is observed
    * Re-factor the lookup of the slave to accommodate for a REJ sent
      due to timeout receiving the MRA
    * Added __rcu to "void **slot" in rej_tmout_tree_cleanup()
---
 drivers/infiniband/hw/mlx4/cm.c      | 135 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx4/mlx4_ib.h |   3 +
 2 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 6f0ffd0906e6..b10737f74449 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -54,11 +54,22 @@ struct id_map_entry {
 	struct delayed_work timeout;
 };
 
+struct rej_tmout_entry {
+	int slave;
+	u32 rem_pv_cm_id;
+	struct delayed_work timeout;
+	struct radix_tree_root *rej_tmout_root;
+	/* Points to the mutex protecting this radix-tree */
+	struct mutex *lock;
+};
+
 struct cm_generic_msg {
 	struct ib_mad_hdr hdr;
 
 	__be32 local_comm_id;
 	__be32 remote_comm_id;
+	unsigned char unused[2];
+	__be16 rej_reason;
 };
 
 struct cm_sidr_generic_msg {
@@ -285,6 +296,7 @@ static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
 	spin_unlock(&sriov->id_map_lock);
 }
 
+#define REJ_REASON(m) be16_to_cpu(((struct cm_generic_msg *)(m))->rej_reason)
 int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id,
 		struct ib_mad *mad)
 {
@@ -295,7 +307,8 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 	if (mad->mad_hdr.attr_id == CM_REQ_ATTR_ID ||
 	    mad->mad_hdr.attr_id == CM_REP_ATTR_ID ||
 	    mad->mad_hdr.attr_id == CM_MRA_ATTR_ID ||
-	    mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID) {
+	    mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID ||
+	    (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID && REJ_REASON(mad) == IB_CM_REJ_TIMEOUT)) {
 		sl_cm_id = get_local_comm_id(mad);
 		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
 		if (id)
@@ -328,11 +341,88 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 	return 0;
 }
 
+static void rej_tmout_timeout(struct work_struct *work)
+{
+	struct delayed_work *delay = to_delayed_work(work);
+	struct rej_tmout_entry *item = container_of(delay, struct rej_tmout_entry, timeout);
+	struct rej_tmout_entry *deleted;
+
+	mutex_lock(item->lock);
+	deleted = radix_tree_delete_item(item->rej_tmout_root, item->rem_pv_cm_id, NULL);
+	mutex_unlock(item->lock);
+
+	if (deleted != item)
+		pr_debug("deleted(%p) != item(%p)\n", deleted, item);
+
+	kfree(item);
+}
+
+static int alloc_rej_tmout(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id, int slave)
+{
+	struct rej_tmout_entry *item;
+	int sts;
+
+	mutex_lock(&sriov->rej_tmout_lock);
+	item = radix_tree_lookup(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id);
+	mutex_unlock(&sriov->rej_tmout_lock);
+	if (item) {
+		if (IS_ERR(item))
+			return PTR_ERR(item);
+		/* If a retry, adjust delayed work */
+		mod_delayed_work(system_wq, &item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+		return 0;
+	}
+
+	item = kmalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&item->timeout, rej_tmout_timeout);
+	item->slave = slave;
+	item->rem_pv_cm_id = rem_pv_cm_id;
+	item->rej_tmout_root = &sriov->rej_tmout_root;
+	item->lock = &sriov->rej_tmout_lock;
+
+	mutex_lock(&sriov->rej_tmout_lock);
+	sts = radix_tree_insert(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id, item);
+	mutex_unlock(&sriov->rej_tmout_lock);
+	if (sts)
+		goto err_insert;
+
+	schedule_delayed_work(&item->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+
+	return 0;
+
+err_insert:
+	kfree(item);
+	return sts;
+}
+
+static int lookup_rej_tmout_slave(struct mlx4_ib_sriov *sriov, u32 rem_pv_cm_id)
+{
+	struct rej_tmout_entry *item;
+
+	mutex_lock(&sriov->rej_tmout_lock);
+	item = radix_tree_lookup(&sriov->rej_tmout_root, (unsigned long)rem_pv_cm_id);
+	mutex_unlock(&sriov->rej_tmout_lock);
+
+	if (!item || IS_ERR(item)) {
+		pr_debug("Could not find slave. rem_pv_cm_id 0x%x error: %d\n",
+			 rem_pv_cm_id, (int)PTR_ERR(item));
+		return !item ? -ENOENT : PTR_ERR(item);
+	}
+
+	return item->slave;
+}
+
 int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 			     struct ib_mad *mad)
 {
+	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
+	u32 rem_pv_cm_id = get_local_comm_id(mad);
 	u32 pv_cm_id;
 	struct id_map_entry *id;
+	int sts;
 
 	if (mad->mad_hdr.attr_id == CM_REQ_ATTR_ID ||
 	    mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID) {
@@ -348,6 +438,13 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 				     be64_to_cpu(gid.global.interface_id));
 			return -ENOENT;
 		}
+
+		sts = alloc_rej_tmout(sriov, rem_pv_cm_id, *slave);
+		if (sts)
+			/* Even if this fails, we pass on the REQ to the slave */
+			pr_debug("Could not allocate rej_tmout entry. rem_pv_cm_id 0x%x slave %d status %d\n",
+				 rem_pv_cm_id, *slave, sts);
+
 		return 0;
 	}
 
@@ -355,6 +452,12 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	id = id_map_get(ibdev, (int *)&pv_cm_id, -1, -1);
 
 	if (!id) {
+		if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID &&
+		    REJ_REASON(mad) == IB_CM_REJ_TIMEOUT && slave) {
+			*slave = lookup_rej_tmout_slave(sriov, rem_pv_cm_id);
+
+			return (*slave < 0) ? *slave : 0;
+		}
 		pr_debug("Couldn't find an entry for pv_cm_id 0x%x, attr_id 0x%x\n",
 			 pv_cm_id, be16_to_cpu(mad->mad_hdr.attr_id));
 		return -ENOENT;
@@ -377,6 +480,34 @@ void mlx4_ib_cm_paravirt_init(struct mlx4_ib_dev *dev)
 	INIT_LIST_HEAD(&dev->sriov.cm_list);
 	dev->sriov.sl_id_map = RB_ROOT;
 	xa_init_flags(&dev->sriov.pv_id_table, XA_FLAGS_ALLOC);
+	mutex_init(&dev->sriov.rej_tmout_lock);
+	INIT_RADIX_TREE(&dev->sriov.rej_tmout_root, GFP_KERNEL);
+}
+
+static void rej_tmout_tree_cleanup(struct mlx4_ib_sriov *sriov, int slave)
+{
+	struct radix_tree_iter iter;
+	bool flush_needed = false;
+	__rcu void **slot;
+	int cnt = 0;
+
+	mutex_lock(&sriov->rej_tmout_lock);
+	radix_tree_for_each_slot(slot, &sriov->rej_tmout_root, &iter, 0) {
+		struct rej_tmout_entry *item = *slot;
+
+		if (slave < 0 || slave == item->slave) {
+			mod_delayed_work(system_wq, &item->timeout, 0);
+			flush_needed = true;
+			++cnt;
+		}
+	}
+	mutex_unlock(&sriov->rej_tmout_lock);
+
+	if (flush_needed) {
+		flush_scheduled_work();
+		pr_debug("Deleted %d entries in radix_tree for slave %d during cleanup\n",
+			 slave, cnt);
+	}
 }
 
 /* slave = -1 ==> all slaves */
@@ -446,4 +577,6 @@ void mlx4_ib_cm_paravirt_clean(struct mlx4_ib_dev *dev, int slave)
 		list_del(&map->list);
 		kfree(map);
 	}
+
+	rej_tmout_tree_cleanup(sriov, slave);
 }
diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 8686f8ce7529..2ab83ed3a097 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -495,6 +495,9 @@ struct mlx4_ib_sriov {
 	spinlock_t id_map_lock;
 	struct rb_root sl_id_map;
 	struct list_head cm_list;
+	/* Protects the radix-tree */
+	struct mutex rej_tmout_lock;
+	struct radix_tree_root rej_tmout_root;
 };
 
 struct gid_cache_context {
-- 
2.20.1

