Return-Path: <linux-rdma+bounces-17495-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIKCINxdqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17495-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:29:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3F204448
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AA933010765
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7F35E93A;
	Wed,  4 Mar 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThfwijaM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7235E939;
	Wed,  4 Mar 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641044; cv=none; b=FFunSPzt6iCSMzvPo2PWHrQ26YMhKNmXAs4O2sGVfnJQKzmstGTg7rY7osZb5DuY/OeOJjCv6MXlrvYS+fq4+IMfBOJ/5FY6KlAJtUbD17ioeRM6COc9pyx4Nb7ZMYVo7guGvywuVg64cSRCvXchk+n8x4q/q7mSVGTmw0VQtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641044; c=relaxed/simple;
	bh=ywYiMsYTtAz4vCZZhs0h0CIWMYzBUX8EGn5ktDgQ6cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNMvZ2TSEBEEV1qWXXH128DbnQexrmE0EnsK356xK61oY+RtqIxdplV89HMHrCXyXjfBobfNSykVQb76lQchSulptCabDa6VEze92T8W8uuPBW+AClykFQwDwuqeH1m1AevVVT01oCKU1YO5tXR6WTswt34+WQ6MckWmnqUJYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ThfwijaM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624FrXkL3032201;
	Wed, 4 Mar 2026 16:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=IFixIG4h0jJ5QA8kMpukNjAsR7RsB
	CMOlOf0xpOGZns=; b=ThfwijaMmOnsIkLusTuEfQQi2/cfb+J4P7wVkcy0rZUvk
	tjnnzblkOHPRM2ZZkyHWtmbneQWAC7xLqJBhfCXz79/JzfLle0rKDPrG8h1tv9IY
	zRXUt0CtfX+ZKKPK6rZ+TLhBHxci/AK7oQRvytoMND6K3mpJRUzhSbTqfxtN+xK7
	e4DdBuxSdcWCBkXqu3P+0oEoVAlNH4RX1DONSnIwgtLq94GUJZ6JaSpsDne9WQ8N
	5dL2LobXMl5YUq+TkkZ06v39PyFMCs8dj/v1K+CtwvlqsA4GP18d7LVmAJAxmRMZ
	eflDEqKLuhaL8dEyOPNFyHYmLChiFxZImCBXcWpfA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cpqsbr2ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 16:17:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 624FAD0w034716;
	Wed, 4 Mar 2026 16:17:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptg1ba6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Mar 2026 16:17:11 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 624GHB2e005768;
	Wed, 4 Mar 2026 16:17:11 GMT
Received: from pkannoju-dev-build.osdevelopmeniad.oraclevcn.com (pkannoju-dev-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.59])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptg1b9g-1;
	Wed, 04 Mar 2026 16:17:10 +0000
From: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
To: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com,
        anand.a.khoje@oracle.com,
        Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Date: Wed,  4 Mar 2026 16:17:04 +0000
Message-ID: <20260304161704.910564-1-praveen.kannoju@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603040131
X-Proofpoint-GUID: uC45aMbQRRe8T4wocvcXgYbjO1QV8Bjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEzMiBTYWx0ZWRfX3Tfd/wNhDnOa
 i1F1HjJP2hYOohLYbINbVkzsbF0OJpYaCqC/sdVp1YTadhrZL2Z3atwkSeXyRpfJPLnkWfu65r7
 mfZm8X0jGvFYPKxMusj8FVdMSo8EtO//3Wb06CFbzhubSGNqC7/5O+afEvppSpLrEkZNsUSkiOw
 hgz1jG/aM5josd3/Wf6MoiLDlmT5rJHSmxPujhlSqv8QjbpV5LGBM7r1ant+mMrpv4RXuYibaOB
 4vy8w6ljmQx1zb1ngp7iZ9knxrrt9j/GuX5TN/ud8lF5fJdP3UwIzQKnD++NwLSDmosgLid1To2
 6sOSjp8En6OcQ1oO2v85GqGfLn9pSAG1GX0/TN1b4fBhHuDbR7NG5JxJFzpuKXKIuAzNAZeB1Zq
 KQux7I53vfQwyEPY/SBDxN0PeDMOFFSV8I5GIU8JYnSqsAfSBPCQ1Mw8Lu0J6rp/PE+O+hdGEs3
 YMVjLqb6nGr13gGfjHUHqU6dHIvaHB2EP93oHkmc=
X-Proofpoint-ORIG-GUID: uC45aMbQRRe8T4wocvcXgYbjO1QV8Bjp
X-Authority-Analysis: v=2.4 cv=EOELElZC c=1 sm=1 tr=0 ts=69a85b08 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=tFMKXHgGLOdB1ZkV82YA:9 cc=ntf
 awl=host:12266
X-Rspamd-Queue-Id: 86C3F204448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17495-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Interrupt lost scenario has been observed in multiple issues during IRQ
migration due to cpu scaling activity. This further led to the presence of
unhandled EQE's causing corresponding Mellanox transmission queues to
become full and get timedout. This patch overcomes this situation by
polling the EQ associated with the IRQ which undergoes migration, to
recover any unhandled EQE's and keep the transmission uninterrupted from
the corresponding queue.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 41 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/eq.h  |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 25499da177bc..4f0653305f46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -22,6 +22,10 @@
 #include "devlink.h"
 #include "en_accel/ipsec.h"
 
+unsigned int mlx5_reap_eq_irq_aff_change;
+module_param(mlx5_reap_eq_irq_aff_change, int, 0644);
+MODULE_PARM_DESC(mlx5_reap_eq_irq_aff_change, "mlx5_reap_eq_irq_aff_change: 0 = Disable MLX5 EQ Reap upon IRQ affinity change, \
+		 1 = Enable MLX5 EQ Reap upon IRQ affinity change. Default=0");
 enum {
 	MLX5_EQE_OWNER_INIT_VAL	= 0x1,
 };
@@ -951,10 +955,36 @@ static int alloc_rmap(struct mlx5_core_dev *mdev) { return 0; }
 static void free_rmap(struct mlx5_core_dev *mdev) {}
 #endif
 
+void mlx5_eq_reap_irq_notify(struct irq_affinity_notify *notify, const cpumask_t *mask)
+{
+	u32 eqe_count;
+	struct mlx5_eq_comp *eq = container_of(notify, struct mlx5_eq_comp, notify);
+
+	if (mlx5_reap_eq_irq_aff_change) {
+		mlx5_core_warn(eq->core.dev, "irqn = 0x%x migration notified, EQ 0x%x: Cons = 0x%x\n",
+			       eq->core.irqn, eq->core.eqn, eq->core.cons_index);
+
+		while (!rtnl_trylock())
+			msleep(20);
+
+		eqe_count = mlx5_eq_poll_irq_disabled(eq);
+		if (eqe_count)
+			mlx5_core_warn(eq->core.dev, "Recovered %d eqes on EQ 0x%x\n",
+				       eqe_count, eq->core.eqn);
+		rtnl_unlock();
+	}
+}
+
+void mlx5_eq_reap_irq_release(struct kref *ref) {}
+
 static void destroy_comp_eq(struct mlx5_core_dev *dev, struct mlx5_eq_comp *eq, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 
+	if (irq_set_affinity_notifier(eq->core.irqn, NULL))
+		mlx5_core_warn(dev, "failed to unset EQ 0x%x to irq 0x%x affinty\n",
+			       eq->core.eqn, eq->core.irqn);
+
 	xa_erase(&table->comp_eqs, vecidx);
 	mlx5_eq_disable(dev, &eq->core, &eq->irq_nb);
 	if (destroy_unmap_eq(dev, &eq->core))
@@ -990,6 +1020,7 @@ static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 	struct mlx5_irq *irq;
 	int nent;
 	int err;
+	int ret;
 
 	lockdep_assert_held(&table->comp_lock);
 	if (table->curr_comp_eqs == table->max_comp_eqs) {
@@ -1036,6 +1067,16 @@ static int create_comp_eq(struct mlx5_core_dev *dev, u16 vecidx)
 	if (err)
 		goto disable_eq;
 
+	eq->notify.notify = mlx5_eq_reap_irq_notify;
+	eq->notify.release = mlx5_eq_reap_irq_release;
+	ret = irq_set_affinity_notifier(eq->core.irqn, &eq->notify);
+	if (ret) {
+		mlx5_core_warn(dev, "mlx5_eq_reap_irq_nofifier: EQ 0x%x irqn = 0x%x irq_set_affinity_notifier failed: %d\n",
+			       eq->core.eqn, eq->core.irqn, ret);
+	}
+	mlx5_core_dbg(dev, "mlx5_eq_reap_irq_nofifier: EQ 0x%x irqn = 0x%x irq_set_affinity_notifier set.\n",
+		      eq->core.eqn, eq->core.irqn);
+
 	table->curr_comp_eqs++;
 	return eq->core.eqn;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index b1edc71ffc6d..669bacb9e390 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -46,6 +46,7 @@ struct mlx5_eq_comp {
 	struct notifier_block   irq_nb;
 	struct mlx5_eq_tasklet  tasklet_ctx;
 	struct list_head        list;
+	struct irq_affinity_notify notify;
 };
 
 static inline u32 eq_get_size(struct mlx5_eq *eq)
-- 
2.43.7


