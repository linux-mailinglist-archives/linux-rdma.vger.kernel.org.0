Return-Path: <linux-rdma+bounces-23117-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VkYBI1TIVGrBSwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23117-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:13:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF40B74A355
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:13:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=Cgce6k4J;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23117-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23117-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20239303F99F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202B383991;
	Mon, 13 Jul 2026 11:11:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A604381EBB;
	Mon, 13 Jul 2026 11:11:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941114; cv=none; b=JzaC2hDS1zLrhKvzPCe/H+L1qpZIH8mNWROTdBJeNcCLiUjXHnM65cvMoCp2jcBmr3yvUL4j2qAO2xKWG0eLMJxTCb7iTQj+yIQGuVG8MhnZnXGeV/pmuHQetpRpqA1YiKmw3NX9j0ID9V6aVNQn3/PElHUxQ/Wf1Lzz+Et0KL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941114; c=relaxed/simple;
	bh=Qrc6nlJln6BSiGD1sKzgMMyAaAV5cuNLY5oslgJb2MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLrUw2EMZkzDddqLPZ+GtC2BIjAIrrV851tbM07HdhB3oViXm4z6ypm1FotjYOsS5ydPgIlO7Be49hdzrZFA2uh+kK5fO6XACdLDwYOgSb8GyydFpvsLVOC78G3xyQt6gAmQ6Gz7lns31h8eRvnW6mNx8+ViPrZvkud6wY9x/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cgce6k4J; arc=none smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D2dHqi399937;
	Mon, 13 Jul 2026 11:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=q3mG1fngXj7heK9K93ZW66+C9umr1
	0Ub5mv9YvnTz8I=; b=Cgce6k4JacWirLOaIzcaJEnnpMsTcH+XyU1e9lqJm+PGb
	AoefWI+DMgj7ksMpbpkqHDlem7mXCMRF30EMaTu7EFxVIbYeGVD9ViIkZ6hcFFL2
	LJJEGPFlWrOlxV8izH8/u+lf5fYXLWXgc2L6qOmnAnLYnLKaXdLl2/7QXtSi+vDr
	gjgr1r7XfwT+uF1SiA2p7X6bQp8bURCoVLHJMzmlReSvKHPRS61eP9dfYKaNHw5T
	Cn2zz6jSzJTzIek4NkRwvxj5eZPYbZXtYbJXWM8DBDEXU/vjMQTMdfCiWSmi8H3a
	9G344Nkf0g0G/3Kmvr0a5COBedMSLR/1qCf1Vzogw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeedhya5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:11:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DB8XdR036694;
	Mon, 13 Jul 2026 11:11:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9q615y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:11:46 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66DBBkq8008415;
	Mon, 13 Jul 2026 11:11:46 GMT
Received: from pkannoju-dev-build.osdevelopmeniad.oraclevcn.com (pkannoju-dev-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9q615t-1;
	Mon, 13 Jul 2026 11:11:46 +0000 (GMT)
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: yishaih@nvidia.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v3] IB/mlx4: Fix stale CM id_map entries when RTU is never received
Date: Mon, 13 Jul 2026 11:11:42 +0000
Message-ID: <20260713111142.1206710-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607130116
X-Authority-Analysis: v=2.4 cv=d+bFDxjE c=1 sm=1 tr=0 ts=6a54c7f4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=UqCG9HQmAAAA:8
 a=Qwf4xDF1JrWRajezon4A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12222
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfXzgAXwdmwao/R
 8LyeD9GRcm41YRTFosg5PJNNlrb9dimi0aIo2CG6aL06bo1DndLAGWhFBgb48jE1J96xE5jKdWX
 PYMRiXkRBeTyTJoCb/uXcMggAHTp9JlR+xeDJzOPBRt3rPFmlMTNkr4vjSbI2G/q1D7dTFklhqm
 NmqeMZCS7NO433QzW2i51QJA5d8Ww8TVC1WLOzEunwLPGiaOSo9YfGWr/RGtEwiN39e1WksMmkI
 SutPmQATtFIrMY+Dz2N5n7Lifg/wwYbxLfphrR3DvgwPoTEjleNUSqDnJ5UvLBlAgqD4UalQ9oS
 4goi37BlJA3+9PyBmj4a8qwSqXUkOMpYkA1rjiffeVe0sVgoTJk3hkQyOsVWD5PorwAn9sHX7WN
 /yWzEA6V/NwCKcixnp4rdiynGv9DbcAXel1HuetUFrjGs9khWzmd7C6oZG6W3I7qf4Gcmlw25zR
 8m51cfFezadIdrk7twJi0nfTORmyQJFIjBtzBr+w=
X-Proofpoint-GUID: SMLEcoraRbCdhRhHmkHq2F9o6hyaAn99
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfXyYaok3Xk3+a1
 PM1dJAQv+FNDMrUHnORyNwvqLj2yzyvO63g/xeR5Epm/jB/g8AL8PcEZzTnDSOSse8QcdZqZDA5
 vo8FCh3UBT4z6UyFcSP6VWEzXcFRzQguV5JJutyNXeTFbjUZFzuW
X-Proofpoint-ORIG-GUID: SMLEcoraRbCdhRhHmkHq2F9o6hyaAn99
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23117-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yishaih@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:praveen.kannoju@oracle.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:from_mime,oracle.com:mid,oracle.com:email,oracle.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF40B74A355

mlx4_ib_multiplex_cm_handler() allocates an id_map_entry for CM
transactions, but the entry is normally released only on DREQ or REJ
flows.

In the duplicate REP handling scenario, cm_dup_rep_handler() may be
invoked when the remote side receives a REP for which no matching
cm_id_priv exists. In such cases the CM handshake never reaches RTU, and
the sender side may never receive either DREQ or REJ cleanup events.

As a result, the allocated id_map_entry remains indefinitely, resulting in
a stale mapping leak.

Fix this by arming an RTU-abandon cleanup timeout when the id_map_entry is
allocated. The timeout uses the mlx4 CM workqueue and the existing
schedule_delayed() path, so later DREQ/REJ cleanup can shorten the pending
timeout with mod_delayed_work().

Track whether a pending cleanup timeout is still waiting for RTU. RTU
cancels only that initial timeout; if DREQ/REJ has already converted it to
normal teardown cleanup, a late or duplicate RTU does not cancel the
teardown timer. If the RTU timeout callback has already started, leave the
entry on the timeout path and make the RTU packet lose that race.

Hold id_map_lock while looking up the entry, canceling the RTU timeout,
scheduling teardown cleanup, and copying the id values needed by the CM
handlers. The delayed-work callback rechecks scheduled_delete under the
same lock before removing and freeing the entry, avoiding use-after-free
when RTU races with timeout execution.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
v1: https://lore.kernel.org/linux-rdma/20260507154755.452008-1-praveen.kannoju@oracle.com/T/#u
v2: https://lore.kernel.org/linux-rdma/BL0PR10MB282074FA0D571F5072DFCB4B8CF12@BL0PR10MB2820.namprd10.prod.outlook.com/T/#t

Changes in v3:
- Replace "Lock should be taken before called" comments with
  lockdep_assert_held(&sriov->id_map_lock).

Changes in v2:
- Queue the RTU-abandon timeout on the mlx4 CM workqueue through
  schedule_delayed() and use mod_delayed_work() so DREQ/REJ cleanup can
  shorten a pending RTU timeout.
- Track RTU-abandon cleanup separately from normal DREQ/REJ cleanup so a
  late or duplicate RTU does not cancel a teardown timer.
- Hold id_map_lock while looking up id_map entries, canceling or updating
  delayed work, and copying CM IDs needed by the handlers.
- Make RTU lose the race when the timeout callback has already started.

 drivers/infiniband/hw/mlx4/cm.c | 98 ++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
index 63a868a..f7905df 100644
--- a/drivers/infiniband/hw/mlx4/cm.c
+++ b/drivers/infiniband/hw/mlx4/cm.c
@@ -40,6 +40,7 @@
 #include "mlx4_ib.h"
 
 #define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
+#define CM_RTU_TIMEOUT		  (60 * HZ)
 
 struct id_map_entry {
 	struct rb_node node;
@@ -48,6 +49,7 @@ struct id_map_entry {
 	u32 pv_cm_id;
 	int slave_id;
 	int scheduled_delete;
+	bool rtu_timeout;
 	struct mlx4_ib_dev *dev;
 
 	struct list_head list;
@@ -184,6 +186,10 @@ static void id_map_ent_timeout(struct work_struct *work)
 	struct rb_root *sl_id_map = &sriov->sl_id_map;
 
 	spin_lock(&sriov->id_map_lock);
+	if (!ent->scheduled_delete) {
+		spin_unlock(&sriov->id_map_lock);
+		return;
+	}
 	if (!xa_erase(&sriov->pv_id_table, ent->pv_cm_id))
 		goto out;
 	found_ent = id_map_find_by_sl_id(&dev->ib_dev, ent->slave_id, ent->sl_cm_id);
@@ -228,8 +234,12 @@ static void sl_id_map_add(struct ib_device *ibdev, struct id_map_entry *new)
 	rb_insert_color(&new->node, sl_id_map);
 }
 
+static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id,
+			     unsigned long timeout, bool rtu_timeout);
+
 static struct id_map_entry *
-id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
+id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id,
+	     u32 *pv_cm_id)
 {
 	int ret;
 	struct id_map_entry *ent;
@@ -242,6 +252,7 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
 	ent->sl_cm_id = sl_cm_id;
 	ent->slave_id = slave_id;
 	ent->scheduled_delete = 0;
+	ent->rtu_timeout = false;
 	ent->dev = to_mdev(ibdev);
 	INIT_DELAYED_WORK(&ent->timeout, id_map_ent_timeout);
 
@@ -251,6 +262,8 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
 		spin_lock(&sriov->id_map_lock);
 		sl_id_map_add(ibdev, ent);
 		list_add_tail(&ent->list, &sriov->cm_list);
+		*pv_cm_id = ent->pv_cm_id;
+		schedule_delayed(ibdev, ent, CM_RTU_TIMEOUT, true);
 		spin_unlock(&sriov->id_map_lock);
 		return ent;
 	}
@@ -261,48 +274,47 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
 	return ERR_PTR(-ENOMEM);
 }
 
 static struct id_map_entry *
 id_map_get(struct ib_device *ibdev, int *pv_cm_id, int slave_id, int sl_cm_id)
 {
 	struct id_map_entry *ent;
 	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
 
-	spin_lock(&sriov->id_map_lock);
+	lockdep_assert_held(&sriov->id_map_lock);
 	if (*pv_cm_id == -1) {
 		ent = id_map_find_by_sl_id(ibdev, slave_id, sl_cm_id);
 		if (ent)
 			*pv_cm_id = (int) ent->pv_cm_id;
 	} else
 		ent = xa_load(&sriov->pv_id_table, *pv_cm_id);
-	spin_unlock(&sriov->id_map_lock);
 
 	return ent;
 }
 
-static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
+static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id,
+			     unsigned long timeout, bool rtu_timeout)
 {
 	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
 	unsigned long flags;
 
-	spin_lock(&sriov->id_map_lock);
+	lockdep_assert_held(&sriov->id_map_lock);
 	spin_lock_irqsave(&sriov->going_down_lock, flags);
 	/*make sure that there is no schedule inside the scheduled work.*/
-	if (!sriov->is_going_down && !id->scheduled_delete) {
+	if (!sriov->is_going_down || id->scheduled_delete) {
 		id->scheduled_delete = 1;
-		queue_delayed_work(cm_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
-	} else if (id->scheduled_delete) {
-		/* Adjust timeout if already scheduled */
-		mod_delayed_work(cm_wq, &id->timeout, CM_CLEANUP_CACHE_TIMEOUT);
+		id->rtu_timeout = rtu_timeout;
+		mod_delayed_work(cm_wq, &id->timeout, timeout);
 	}
 	spin_unlock_irqrestore(&sriov->going_down_lock, flags);
-	spin_unlock(&sriov->id_map_lock);
 }
 
 #define REJ_REASON(m) be16_to_cpu(((struct cm_generic_msg *)(m))->rej_reason)
 int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id,
 		struct ib_mad *mad)
 {
+	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
 	struct id_map_entry *id;
+	u32 pv_cm_id_to_set = 0;
 	u32 sl_cm_id;
 	int pv_cm_id = -1;
 
@@ -312,10 +323,15 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 	    mad->mad_hdr.attr_id == CM_SIDR_REQ_ATTR_ID ||
 	    (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID && REJ_REASON(mad) == IB_CM_REJ_TIMEOUT)) {
 		sl_cm_id = get_local_comm_id(mad);
+		spin_lock(&sriov->id_map_lock);
 		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
+		if (id)
+			pv_cm_id_to_set = id->pv_cm_id;
+		spin_unlock(&sriov->id_map_lock);
 		if (id)
 			goto cont;
-		id = id_map_alloc(ibdev, slave_id, sl_cm_id);
+		id = id_map_alloc(ibdev, slave_id, sl_cm_id,
+				  &pv_cm_id_to_set);
 		if (IS_ERR(id)) {
 			mlx4_ib_warn(ibdev, "%s: id{slave: %d, sl_cm_id: 0x%x} Failed to id_map_alloc\n",
 				__func__, slave_id, sl_cm_id);
@@ -326,7 +342,25 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 		return 0;
 	} else {
 		sl_cm_id = get_local_comm_id(mad);
+		spin_lock(&sriov->id_map_lock);
 		id = id_map_get(ibdev, &pv_cm_id, slave_id, sl_cm_id);
+		if (id) {
+			if (mad->mad_hdr.attr_id == CM_RTU_ATTR_ID &&
+			    id->rtu_timeout) {
+				id->rtu_timeout = false;
+				if (cancel_delayed_work(&id->timeout))
+					id->scheduled_delete = 0;
+				else
+					id = NULL;
+			}
+			if (id)
+				pv_cm_id_to_set = id->pv_cm_id;
+			if (id && mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
+				schedule_delayed(ibdev, id,
+						 CM_CLEANUP_CACHE_TIMEOUT,
+						 false);
+		}
+		spin_unlock(&sriov->id_map_lock);
 	}
 
 	if (!id) {
@@ -336,10 +370,7 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
 	}
 
 cont:
-	set_local_comm_id(mad, id->pv_cm_id);
-
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID)
-		schedule_delayed(ibdev, id);
+	set_local_comm_id(mad, pv_cm_id_to_set);
 	return 0;
 }
 
@@ -429,7 +460,10 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
 	u32 rem_pv_cm_id = get_local_comm_id(mad);
 	u32 pv_cm_id;
+	u32 sl_cm_id = 0;
 	struct id_map_entry *id;
+	int pv_cm_id_int;
+	int slave_id = 0;
 	int sts;
 
 	if (mad->mad_hdr.attr_id == CM_REQ_ATTR_ID ||
@@ -457,7 +491,28 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	}
 
 	pv_cm_id = get_remote_comm_id(mad);
-	id = id_map_get(ibdev, (int *)&pv_cm_id, -1, -1);
+	pv_cm_id_int = pv_cm_id;
+	spin_lock(&sriov->id_map_lock);
+	id = id_map_get(ibdev, &pv_cm_id_int, -1, -1);
+	if (id) {
+		if (mad->mad_hdr.attr_id == CM_RTU_ATTR_ID &&
+		    id->rtu_timeout) {
+			id->rtu_timeout = false;
+			if (cancel_delayed_work(&id->timeout))
+				id->scheduled_delete = 0;
+			else
+				id = NULL;
+		}
+		if (id && slave)
+			slave_id = id->slave_id;
+		if (id)
+			sl_cm_id = id->sl_cm_id;
+		if (id && (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
+			   mad->mad_hdr.attr_id == CM_REJ_ATTR_ID))
+			schedule_delayed(ibdev, id,
+					 CM_CLEANUP_CACHE_TIMEOUT, false);
+	}
+	spin_unlock(&sriov->id_map_lock);
 
 	if (!id) {
 		if (mad->mad_hdr.attr_id == CM_REJ_ATTR_ID &&
@@ -472,12 +527,8 @@ int mlx4_ib_demux_cm_handler(struct ib_device *ibdev, int port, int *slave,
 	}
 
 	if (slave)
-		*slave = id->slave_id;
-	set_remote_comm_id(mad, id->sl_cm_id);
-
-	if (mad->mad_hdr.attr_id == CM_DREQ_ATTR_ID ||
-	    mad->mad_hdr.attr_id == CM_REJ_ATTR_ID)
-		schedule_delayed(ibdev, id);
+		*slave = slave_id;
+	set_remote_comm_id(mad, sl_cm_id);
 
 	return 0;
 }

