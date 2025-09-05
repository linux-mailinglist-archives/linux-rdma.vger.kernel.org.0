Return-Path: <linux-rdma+bounces-13125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30785B45B29
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6DF65C6B75
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FC393DFE;
	Fri,  5 Sep 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sAKoJRsY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30529374284;
	Fri,  5 Sep 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084088; cv=none; b=uJ6c2teqVQt3IyYzMjN8naSndkJ0Zg4+RTocy+hXMG/HAfYMIiY1h8niDW4O0HztrNjY2aTtesQy3ZRvyBBepWt3J9hgKT93IDSzS06pI1KoLmOQes6O2D0+bfGrIaz6DP4gN+ou9oc7EP8RUuBhGi3wRw1l6YdAMY2xmNRmmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084088; c=relaxed/simple;
	bh=av6UihAi1erkgLqKtNiOf7zRhxYl/XFIouCrVWH4uFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW30L0XifP1WiOb0MU2rIfh2a/jhF/VHb12BWA9rbZ5coCEweqCc1H5vImDwyhpfIwScrOGGsjCeouXUQDPgnkrMBJwPZGQq5AW+8eqxWCJrfuGSliMxcNy1k8eyY1z+Qxrm/Gpv10+9x9SRB/8pBy/cmVabm3G/rejtDrvFEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sAKoJRsY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857q0Pf000693;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=umuvL108EubJLpdSe
	Qxf/PrfiBtcQYtDDJOJV3Y/8lY=; b=sAKoJRsYA13Mw22LAFm0wZbAS1cmvmHsO
	hUA/x0qNT+4sq0ZRNgDeIqP6j0hOLlJTIFyFWtv9EeQkln7qvrGUrXVgGBOSQB4v
	/GKOQtoKSea0PxvfPjk0eSCFBVoSH+mjp8zlhbDLbW4jdL12QHh0qWJ9bTDZFnbq
	RZ9YJIXQvi1CMcAn3Z/56XD+fDWc73P/rUFY0ZBGQ4MoHfrMC26htDgaBFfyFXgm
	mFX1DbO8QGJhFrGuL9XtQ/SAV7ztv3NWB/1nCJVZU664QjzA3noZDH7J7VXREQwi
	ii1J+WMImwS+y5bUOsGo96iYa1mpsYXmmlY82Timmq1h/ZVIVhj2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfcejq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EpRsM022921;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfcejc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585EVCH8013959;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3snq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSLG56689146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC18520043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CA5320040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3A5C0E1183; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 11/14] net/dibs: Move vlan support to dibs_dev_ops
Date: Fri,  5 Sep 2025 16:54:24 +0200
Message-ID: <20250905145428.1962105-12-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905145428.1962105-1-wintera@linux.ibm.com>
References: <20250905145428.1962105-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2WzuX3WJ4pNZPmC5LCjVtcZkiR1AlKFG
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68baf9aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=z8tP7dbUM_-rWPAmZuAA:9
X-Proofpoint-ORIG-GUID: ykGVLplkNT4trL8j_9n5IJa8fAGGlCTJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX2Gt0Eo5EeDtR
 4Ue+XpBahpmC/gU6j/WwVs+YE9jJe1pgdijfdTWXKLAE280W9ZiuHFRrAVmFMaK9UofFv4CcAMB
 PRL3rEI6/d2SGg/2540tXjt93eRX9GgiUximpcnZUrZXrLoSO9i9nU2YD5DNKqjOUXjQZCwbH63
 sdJZnoCCmUJcnP21oUp+yyqoON7N1OSbkP9qrASspI9NLXODRT+E/a72ipEBEBnSeEXgycVgkLI
 pNTKGOUV6Y0u8yzHE94sxEFoegkD2f1qx9SxGin4/yx50QlXiFhV6KA2Y4MQZj1/jhc9GgtloYK
 SpCX8iYPYXASx40y+w33jnmmORwvEWuoZl4E1PDvsvXC/qGi0wezorlPNZtnr47WEaqRYXK/s2w
 mIW3FzxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

It can be debated how much benefit definition of vlan ids for dibs devices
brings, as the dmbs are accessible only by a single peer anyhow. But ism
provides vlan support and smcd exploits it, so move it to dibs layer as an
optional feature.

smcd_loopback simply ignores all vlan settings, do the same in
dibs_loopback.

SMC-D and ISM have a method to use the invalid VLAN ID 1FFF
(ISM_RESERVED_VLANID), to indicate that both communication peers support
routable SMC-Dv2. Tolerate it in dibs, but move it to SMC only.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 47 +++++---------------------------------
 include/linux/dibs.h       | 19 +++++++++++++++
 include/net/smc.h          |  5 ----
 net/smc/smc_ism.c          | 14 ++++++++----
 net/smc/smc_loopback.c     |  5 ----
 5 files changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e58c55fb03c2..ed4c28ca355b 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -36,7 +36,6 @@ static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
 						/* a list for fast mapping  */
 static u8 max_client;
 static DEFINE_MUTEX(clients_lock);
-static bool ism_v2_capable;
 struct ism_dev_list {
 	struct list_head list;
 	struct mutex mutex; /* protects ism device list */
@@ -409,8 +408,9 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 }
 EXPORT_SYMBOL_GPL(ism_unregister_dmb);
 
-static int ism_add_vlan_id(struct ism_dev *ism, u64 vlan_id)
+static int ism_add_vlan_id(struct dibs_dev *dibs, u64 vlan_id)
 {
+	struct ism_dev *ism = dibs->drv_priv;
 	union ism_set_vlan_id cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -422,8 +422,9 @@ static int ism_add_vlan_id(struct ism_dev *ism, u64 vlan_id)
 	return ism_cmd(ism, &cmd);
 }
 
-static int ism_del_vlan_id(struct ism_dev *ism, u64 vlan_id)
+static int ism_del_vlan_id(struct dibs_dev *dibs, u64 vlan_id)
 {
+	struct ism_dev *ism = dibs->drv_priv;
 	union ism_set_vlan_id cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -536,6 +537,8 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 
 static const struct dibs_dev_ops ism_ops = {
 	.get_fabric_id = ism_get_chid,
+	.add_vlan_id = ism_add_vlan_id,
+	.del_vlan_id = ism_del_vlan_id,
 };
 
 static int ism_dev_init(struct ism_dev *ism)
@@ -565,12 +568,6 @@ static int ism_dev_init(struct ism_dev *ism)
 	if (ret)
 		goto unreg_sba;
 
-	if (!ism_add_vlan_id(ism, ISM_RESERVED_VLANID))
-		/* hardware is V2 capable */
-		ism_v2_capable = true;
-	else
-		ism_v2_capable = false;
-
 	mutex_lock(&ism_dev_list.mutex);
 	mutex_lock(&clients_lock);
 	for (i = 0; i < max_client; ++i) {
@@ -611,8 +608,6 @@ static void ism_dev_exit(struct ism_dev *ism)
 
 	mutex_lock(&ism_dev_list.mutex);
 
-	if (ism_v2_capable)
-		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
 	unregister_ieq(ism);
 	unregister_sba(ism);
 	free_irq(pci_irq_vector(pdev, 0), ism);
@@ -786,26 +781,6 @@ static int smcd_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	return ism_unregister_dmb(smcd->priv, (struct ism_dmb *)dmb);
 }
 
-static int smcd_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
-{
-	return ism_add_vlan_id(smcd->priv, vlan_id);
-}
-
-static int smcd_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
-{
-	return ism_del_vlan_id(smcd->priv, vlan_id);
-}
-
-static int smcd_set_vlan_required(struct smcd_dev *smcd)
-{
-	return ism_cmd_simple(smcd->priv, ISM_SET_VLAN);
-}
-
-static int smcd_reset_vlan_required(struct smcd_dev *smcd)
-{
-	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
-}
-
 static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
 			  u32 event_code, u64 info)
 {
@@ -837,22 +812,12 @@ static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 	return ism_move(smcd->priv, dmb_tok, idx, sf, offset, data, size);
 }
 
-static int smcd_supports_v2(void)
-{
-	return ism_v2_capable;
-}
-
 static const struct smcd_ops ism_smcd_ops = {
 	.query_remote_gid = smcd_query_rgid,
 	.register_dmb = smcd_register_dmb,
 	.unregister_dmb = smcd_unregister_dmb,
-	.add_vlan_id = smcd_add_vlan_id,
-	.del_vlan_id = smcd_del_vlan_id,
-	.set_vlan_required = smcd_set_vlan_required,
-	.reset_vlan_required = smcd_reset_vlan_required,
 	.signal_event = smcd_signal_ieq,
 	.move_data = smcd_move,
-	.supports_v2 = smcd_supports_v2,
 };
 
 const struct smcd_ops *ism_get_smcd_ops(void)
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 904f37505c27..166148fb8d76 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -133,6 +133,25 @@ struct dibs_dev_ops {
 	 * Return: 2 byte dibs fabric id
 	 */
 	u16 (*get_fabric_id)(struct dibs_dev *dev);
+	/**
+	 * add_vlan_id() - add dibs device to vlan (optional, deprecated)
+	 * @dev: dibs device
+	 * @vlan_id: vlan id
+	 *
+	 * In order to write into a vlan-tagged dmb, the remote device needs
+	 * to belong to the this vlan. A device can belong to more than 1 vlan.
+	 * Any device can access an untagged dmb.
+	 * Deprecated, only supported for backwards compatibility.
+	 * Return: zero on success
+	 */
+	int (*add_vlan_id)(struct dibs_dev *dev, u64 vlan_id);
+	/**
+	 * del_vlan_id() - remove dibs device from vlan (optional, deprecated)
+	 * @dev: dibs device
+	 * @vlan_id: vlan id
+	 * Return: zero on success
+	 */
+	int (*del_vlan_id)(struct dibs_dev *dev, u64 vlan_id);
 };
 
 struct dibs_dev {
diff --git a/include/net/smc.h b/include/net/smc.h
index 9cb8385bbc6e..51b4aefc106a 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -61,13 +61,8 @@ struct smcd_ops {
 	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
-	int (*supports_v2)(void);
 
 	/* optional operations */
-	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
-	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
-	int (*set_vlan_required)(struct smcd_dev *dev);
-	int (*reset_vlan_required)(struct smcd_dev *dev);
 	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
 			    u32 trigger_irq, u32 event_code, u64 info);
 	int (*support_dmb_nocopy)(struct smcd_dev *dev);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 00868583b115..435e28364885 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -140,7 +140,7 @@ int smc_ism_get_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 	if (!vlanid)			/* No valid vlan id */
 		return -EINVAL;
-	if (!smcd->ops->add_vlan_id)
+	if (!smcd->dibs->ops->add_vlan_id)
 		return -EOPNOTSUPP;
 
 	/* create new vlan entry, in case we need it */
@@ -163,7 +163,7 @@ int smc_ism_get_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 	/* no existing entry found.
 	 * add new entry to device; might fail, e.g., if HW limit reached
 	 */
-	if (smcd->ops->add_vlan_id(smcd, vlanid)) {
+	if (smcd->dibs->ops->add_vlan_id(smcd->dibs, vlanid)) {
 		kfree(new_vlan);
 		rc = -EIO;
 		goto out;
@@ -187,7 +187,7 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 	if (!vlanid)			/* No valid vlan id */
 		return -EINVAL;
-	if (!smcd->ops->del_vlan_id)
+	if (!smcd->dibs->ops->del_vlan_id)
 		return -EOPNOTSUPP;
 
 	spin_lock_irqsave(&smcd->lock, flags);
@@ -205,7 +205,7 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 	}
 
 	/* Found and the last reference just gone */
-	if (smcd->ops->del_vlan_id(smcd, vlanid))
+	if (smcd->dibs->ops->del_vlan_id(smcd->dibs, vlanid))
 		rc = -EIO;
 	list_del(&vlan->list);
 	kfree(vlan);
@@ -537,8 +537,12 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 	if (smc_pnetid_by_dev_port(dibs->dev.parent, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
-	if (smcd->ops->supports_v2())
+	if (smc_ism_is_loopback(dibs) ||
+	    (dibs->ops->add_vlan_id &&
+	     !dibs->ops->add_vlan_id(dibs, ISM_RESERVED_VLANID))) {
 		smc_ism_set_v2_capable();
+	}
+
 	mutex_lock(&smcd_dev_list.mutex);
 	/* sort list:
 	 * - devices without pnetid before devices with pnetid;
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 454d9d6a6e8f..982a19430313 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -20,7 +20,6 @@
 #include "smc_ism.h"
 #include "smc_loopback.h"
 
-#define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
 #define SMC_LO_SUPPORT_NOCOPY	0x1
 #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
@@ -242,10 +241,6 @@ static const struct smcd_ops lo_ops = {
 	.support_dmb_nocopy = smc_lo_support_dmb_nocopy,
 	.attach_dmb = smc_lo_attach_dmb,
 	.detach_dmb = smc_lo_detach_dmb,
-	.add_vlan_id		= NULL,
-	.del_vlan_id		= NULL,
-	.set_vlan_required	= NULL,
-	.reset_vlan_required	= NULL,
 	.signal_event		= NULL,
 	.move_data = smc_lo_move_data,
 };
-- 
2.48.1


