Return-Path: <linux-rdma+bounces-13484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D3BB84450
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C817ABD5D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA6B302CD7;
	Thu, 18 Sep 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d/hhb943"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ABF3016FE;
	Thu, 18 Sep 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193535; cv=none; b=TsQrANSiCgD02yqPKgiRINjjI7fZK/TdS6jPkReT6p+HpWHG0nJGU+ixjPSuG9NCS8LbJFOTWdMXOONwti76JfGuf4B8mKf5BLcXeE7ppTZCBReZNq7S56TLzeqelJNWHj6KgL+wrS01Uwj9pPNcjQOkjOASEjCuCCRvxsRmKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193535; c=relaxed/simple;
	bh=bGug2TMrasSwLsQs2f/SL6ty3KSChsn2pPrmiNuGEbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3MZELXcnz25E0Rq3+SeiAfvvWi0Y4Y6RbWCU1rJPpfJ2s5gGrI3+MbVTOJuxA8vEHjCZ8/64Iu342Zraw0jJIcGZCOjxT7ouAr/Kth1Klcuc6msiAdfz6Uxu9buMObMgSm5QUlLSWqrq5bWHxx1MkYuhy1hFQvhRylYXyu/gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d/hhb943; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8GL1R024759;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1R2FRvqYkTiAFoReC
	YwD9o49UkijhJ4zipzBvBh2WlA=; b=d/hhb943HKDr4CXtT9SJJefOVuqYj/FiU
	iVyJRsX/Zk91VbqP7bsU2qRCABpO7E1O5vvrS06RlsnCrq07GNoPDAWQ0q/m6mvE
	dp3UK7MTLy1Fr5ycFtXLUHvHTgznAFOZYxKfEJ6h+AW25oZaXs5axyy9MmjTqDSR
	Pb4oJ6NzzHnAcF8EB7XuDUhnqNrxWqbpFOLRQRw7LRL2bzd5Zbp/bdrx9s3/Fiyj
	2V4ijyWTN036Ws+xKXps9Pn2uQ804AxPAEhkxEjxp6hEr0ntfD76xEUnkSfr/4v/
	CRyNHREV38So1GmDgUrxJSr4hbmc6PZb42ZHqxNSD4BHh/0rWiFDA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IAuq9j011190;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9X1YC029514;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb16f4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51nL51511630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422002004E;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CD5020040;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id C84ADE156D; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Konstantin Shkolnyy <kshk@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shannon Nelson <sln@onemain.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH net-next v3 11/14] dibs: Move vlan support to dibs_dev_ops
Date: Thu, 18 Sep 2025 13:04:57 +0200
Message-ID: <20250918110500.1731261-12-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918110500.1731261-1-wintera@linux.ibm.com>
References: <20250918110500.1731261-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2jpzlWMEp_wGCvdnGubBlz6szyAMMhdj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX4RxHxwLSe/hd
 kfQIgdoHvV5lZgd9amXV0lkKTMdot5akAbofATj+TSEXdPemxo9R76dUxUqXq3uuvZjXnFrt4bO
 FYF26eZ4SrqMzYml7b3TB8aBoKaLHc/V1BlDJtt4ZMTShp9GyjmOg5qBzs3bTU1fQWYRfycwra+
 YV9Yffht04nT09LlZ6Qin4LsZmqJJdhbK4kVj6R7F7QWSj+Y0GpdXsm9d3fpFUnn7CU3qpgNvSg
 oNOJaQxcHv/X3Ek9WIE0PzR01ICuMShfFUXAGukLiMK8F1RDJ5LSuJbY0ezsvnz5Gui/Su4PTUp
 lzPj6YF1Jv7duuSXyJgvV2yG9ZifEFhMSqVUd4MAq0HJ24TYZbSUQ2tVaixxQSqaCHzcp2r5J1u
 7cwa6Hd3
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cbe762 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=z8tP7dbUM_-rWPAmZuAA:9
X-Proofpoint-GUID: FTw7_-k35YIPG7E-rtmJsyqDCO3830wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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
index 6a6e7c9641e8..5118441bed18 100644
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
@@ -539,8 +539,12 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 	if (smc_pnetid_by_dev_port(dibs->dev.parent, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
-	if (smc_ism_is_loopback(dibs) || smcd->ops->supports_v2())
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


