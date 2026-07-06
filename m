Return-Path: <linux-rdma+bounces-22797-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M3JINNibS2qCWwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22797-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 14:13:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A07105AF
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 14:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=SB5aVRKn;
	dmarc=pass (policy=reject) header.from=oracle.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22797-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22797-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C799130015BB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7A8423775;
	Mon,  6 Jul 2026 12:03:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628193F8235;
	Mon,  6 Jul 2026 12:03:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339411; cv=none; b=S5ipVe65IKDpJQKXDdMfGHPdfWRQjG6TiWtdDFrAAAZectX7f91TnAmqo62VRD5tZhMr02YmI75XXLe4QCZJ1UrDqNFrSgWdlMSbcXPMn49N2Zd4f7pWd6ovjUCyotHjgZhdrdGM/IlkQsFxo/vA0GA2iw7HrweZTPeDeHBVJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339411; c=relaxed/simple;
	bh=ukvaTAckKHAnp6s4H0UTPJApdtYkOolL7I9PCtzORos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMD5u9bHKjjf3De91tnT1OVPEp7Skg6lyueADElHZd6QKP5c1OeDoN/n2uqHsRK2tYyIiSCGunT2C6Q1DKayarB6xnZIbtwWnPvpYvXeP/If01OnmNIfFoc5IwzQlAZn5RCi+evMlu7R1rO14Z09mSHmo9rZ7inQfvnZA4+ngac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SB5aVRKn; arc=none smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6660F1Ud1374527;
	Mon, 6 Jul 2026 12:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=uSm2kqE9Y15qTBPFy4b/C/c95LXuv
	Xw2DxFDgixktro=; b=SB5aVRKnWBzZUy5f0d/yVHVHly5aysGOUz2wSGSGspvT5
	hi4D7/gePPHKGzr0KcD+XQBL3eZPfp9pNbK1d3Wz2VmB2gXwmMnPz3FtANYMRF2m
	uU/tIplICb/jiPcMpR6TJbV6S8lfFGFbUv1x4jCEPKDWhL6diXxI38yatnQPYhEI
	TkBF1V90D3eUr3UqJ8wF+lveouShx1HV7Oi3t8sZdrImUuHebawYg9Ok3vwLryFf
	6iYkV7fKHZ8zg6gnIl1hlI5wDuhj/0OV2guFI80TlYHxOuuVRHMHFWB/UUe9RtjZ
	W3RXiQh15yC42iUuQ67/g1uoW2obO8F83HeF/QS6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6s393f1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:03:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 666C39GL011905;
	Mon, 6 Jul 2026 12:03:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6twghqtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 12:03:23 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 666C3KKc013581;
	Mon, 6 Jul 2026 12:03:20 GMT
Received: from pkannoju-dev-build.osdevelopmeniad.oraclevcn.com (pkannoju-dev-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4f6twghqdf-1;
	Mon, 06 Jul 2026 12:03:20 +0000 (GMT)
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: yishaih@nvidia.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH v2] IB/mlx4: Fix stale CM id_map entries when RTU is never received
Date: Mon,  6 Jul 2026 12:02:55 +0000
Message-ID: <20260706120255.639985-1-praveen.kannoju@oracle.com>
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
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060122
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyMiBTYWx0ZWRfXzUfDWWZv15EK
 4X5vOsvcW1dlwXv2CYoMN9LJ+i+gV2pBR+PxWcNGSb8vjp1UqhQfFdaYtigwcOnPlsEgEMQBjHq
 9KKYw5SE1kZaAR4QVennghmmszpnqau1kOK46TDKHg/WAVFBQWalrzEFPK7m+a2/EhRbPwy1hYA
 GvJS5rRMR+ZUdQbiTzYUkJcV2Pxxf3ccbW0pteg9N1XkN6m1TB3O2+rd0irwZ0wU/e/TsyJ1HWU
 3RUowrieLcUvYCoFBF9Ubw+LgRBO8pqcbZoqiHJXgLGYfPzHLU8JhqQmGD3up9DFYkvkoKT93DH
 KcsKLUZffSqedcS9yDYlCzTM9m1BOeN6UHmieQUxEQ0o5fk0u51s36F51aspuKfbWem7x5xhbj3
 u8ThW9bz9nV5IyKsOkDpiWvZM+TszaC0kZL0AtoWrVnga58hc5XjfA9pUw28P5tYOUd0ObGyUyt
 ivSzYbvqoqyGDrQ75kQ==
X-Proofpoint-ORIG-GUID: sWoFudxYEfp4DnPqhG9_pI4QYJZvm58f
X-Proofpoint-GUID: sWoFudxYEfp4DnPqhG9_pI4QYJZvm58f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyMiBTYWx0ZWRfXzwqhAXU929RT
 Hu01yvzGLkiR6Jn7hl6706EX+syicHQkpdwl9n7eYj8JVjtqeuCWIQGWPyhgo+zpAnY2CK7ich7
 XB0W/Z7X0MoCUgsszv1fQwTnnI4q0K4J4gHaNKIHdgrdZCR3reQX
X-Authority-Analysis: v=2.4 cv=RI2D2Yi+ c=1 sm=1 tr=0 ts=6a4b998c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=E04TgaOCr6W4hcjG9RYA:9
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
	TAGGED_FROM(0.00)[bounces-22797-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:from_mime,oracle.com:email,oracle.com:mid,oracle.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 418A07105AF

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

Changes in v2:
- Queue the RTU-abandon timeout on the mlx4 CM workqueue through
  schedule_delayed() and use mod_delayed_work() so DREQ/REJ cleanup can
  shorten a pending RTU timeout.
- Track RTU-abandon cleanup separately from normal DREQ/REJ cleanup so a
  late or duplicate RTU does not cancel a teardown timer.
- Hold id_map_lock while looking up id_map entries, canceling or updating
  delayed work, and copying CM IDs needed by the handlers.
- Make RTU lose the race when the timeout callback has already started.

 drivers/infiniband/hw/mlx4/cm.c | 101 ++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 25 deletions(-)

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
@@ -261,48 +274,46 @@ id_map_alloc(struct ib_device *ibdev, int slave_id, u32 sl_cm_id)
 	return ERR_PTR(-ENOMEM);
 }
 
+/* Lock should be taken before called */
 static struct id_map_entry *
 id_map_get(struct ib_device *ibdev, int *pv_cm_id, int slave_id, int sl_cm_id)
 {
 	struct id_map_entry *ent;
-	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
 
-	spin_lock(&sriov->id_map_lock);
 	if (*pv_cm_id == -1) {
 		ent = id_map_find_by_sl_id(ibdev, slave_id, sl_cm_id);
 		if (ent)
 			*pv_cm_id = (int) ent->pv_cm_id;
 	} else
-		ent = xa_load(&sriov->pv_id_table, *pv_cm_id);
-	spin_unlock(&sriov->id_map_lock);
+		ent = xa_load(&to_mdev(ibdev)->sriov.pv_id_table, *pv_cm_id);
 
 	return ent;
 }
 
-static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
+/* Lock should be taken before called */
+static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id,
+			     unsigned long timeout, bool rtu_timeout)
 {
 	struct mlx4_ib_sriov *sriov = &to_mdev(ibdev)->sriov;
 	unsigned long flags;
 
-	spin_lock(&sriov->id_map_lock);
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

