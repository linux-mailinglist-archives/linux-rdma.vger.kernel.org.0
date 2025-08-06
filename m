Return-Path: <linux-rdma+bounces-12611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD1B1C907
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7925663D8
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61929E106;
	Wed,  6 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JjVj+Bz2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25E29B783;
	Wed,  6 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494905; cv=none; b=cf4J8dVU1RUxRrH9jHZu888TDYMhslwWva32LBuh+UtXZ7B4CzGxHp+tAvN1Ser4yhV6pARcSywMk4q5HVQeitAlFc1aA6X0t7Ymovr/LgKGs7QV2v3DXF/CYk+LHnGmyKpwkwi4Q3tcNku623+PRxb/LH7yzkvdRI2NG1BoWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494905; c=relaxed/simple;
	bh=mINSOEbOSFVEYCz5aSXYDCXqw8Bvbns58gNuUGmFVRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGVBCImQRvOsCysRGPlMyCbo0dYwihe45bZUilBR9FBpNh+MZ/Hy7bcrTgnlF4dzUGuDe2j7pxzHpTF6/80A1eRRms/m8iZ/RuaOeV0pasNnEsh1fPRAUCjcFBWR4BWlbH1WUp2RLsDl+qraMAr7O/8mzBrsurxYoAJ5wFwCzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JjVj+Bz2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576FIVOH021674;
	Wed, 6 Aug 2025 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EqWOK+N9oozlJInao
	GzkdxFxOcvf/Huov+G17wxnLr0=; b=JjVj+Bz2XjbVSmO+7Rakyj1awdI3G7SaD
	J0eVcjppTuwncC2KROm9Gucb5D/zNG9AekhpXH2QaCJM9EvKiK9KcifZcruvWTlY
	9oTgvWdeotjXXcAY7U+pglcnd8IsMwrfvVeSSvUDx/zXbNuao27UbTZcSqjo8OuZ
	X2mSylIxeuHWcPagwLBaZFWA7KpZCYfhiwfImO/+Vx3QPvJGdsxzcPcnYK6OFJZ5
	indKwNMxRJ8n+PsyjAF/IrN9gtsDIuPGR5P8bpH7QKomtnSvWmoutzZaYB+ExaoI
	PQ25OuDN77wgTT+Nvwv831KSGWvVOzAUenXb0y9E3r8W8zruSB79Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61w19x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FfSbn016666;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61w19q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CZNn5031326;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnc8td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNUY52691424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 355C220043;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14E782004E;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B585EE12C5; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [RFC net-next 13/17] net/dibs: Local gid for dibs devices
Date: Wed,  6 Aug 2025 17:41:18 +0200
Message-ID: <20250806154122.3413330-14-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806154122.3413330-1-wintera@linux.ibm.com>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX+ltIm/roKiP2
 fsJs6luQHzpkxQ2CPcYvt75e/5jKP0EfncjANINQnBn1R2SMIHBOzrA4Ohkp4/+sKAyFVb+ymRG
 MCwxKtbGIjoiUXSlEqF5jUmvp9c8UvUYfPosRFJC5qADdun3+DmsUkzllZ8MJiFD6jQUPQOEPI1
 HLB87tqDVVhkpa0BXEXC2+cGy5dtA5oezQYfIX8XsUsjdWN4lcVji9Yk9VxZzslNG5SIRR0zELK
 cW+KGuZA8k8UwhUOnEAjhSkVJIhdIEVpYE0sJchatbB/nItHuPCd0/Itt9+mH54CXlXsMV44PXk
 Rvwcf2vtccCooyE8ocJsh1eB9xU/kc8Nj6sL/H5NBxUl/UvIdrEi0bhmJMerTBnhwIWaGu0ItU7
 Ntasd09eCrLchskdSSBJiwoIwnChJIB3/ZSvWnYSW+66yUao2HCqEg8H+PeiVPBBkKIt3VUO
X-Proofpoint-GUID: jswWBrquBYh7TyFViS6l0DyREYWxJVbz
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=689377a9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=48vgC7mUAAAA:8 a=VnNF1IyMAAAA:8 a=3oSkw3nq568YOmkJtqoA:9
X-Proofpoint-ORIG-GUID: KaOSkxdzqnvHgqJCY0Ne18uZO7aiFeC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

Define a uuid_t GID attribute to identify a dibs device.

SMC uses 64 Bit and 128 Bit Global Identifiers (GIDs) per device, that
need to be sent via the SMC protocol. Because the smc code uses integers,
network endianness and host endianness need to be considered. Avoid this
in the dibs layer by using uuid_t byte arrays. Future patches could change
SMC to use uuid_t. For now conversion helper functions are introduced.

ISM devices provide 64 Bit GIDs. Map them to dibs uuid_t GIDs like this:
 _________________________________________
| 64 Bit ISM-vPCI GID | 00000000_00000000 |
 -----------------------------------------
If interpreted as UUID [1], this would be interpreted as the UIID variant,
that is reserved for NCS backward compatibility. So it will not collide
with UUIDs that were generated according to the standard.

smc_loopback already uses version 4 UUIDs as 128 Bit GIDs, move that to
dibs loopback. A temporary change to smc_lo_query_rgid() is required,
that will be moved to dibs_loopback with a follow-on patch.

Provide gid of a dibs device as sysfs read-only attribute.

Link: https://datatracker.ietf.org/doc/html/rfc4122 [1]
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 drivers/s390/net/ism.h     |  9 +++++++++
 drivers/s390/net/ism_drv.c | 30 +++++++++---------------------
 include/linux/dibs.h       |  3 +++
 include/linux/ism.h        |  1 -
 include/net/smc.h          |  1 -
 net/dibs/dibs_loopback.c   |  1 +
 net/dibs/dibs_main.c       | 12 ++++++++++++
 net/smc/smc_clc.c          |  6 +++---
 net/smc/smc_core.c         |  2 +-
 net/smc/smc_diag.c         |  2 +-
 net/smc/smc_ism.h          | 22 ++++++++++++++++++++++
 net/smc/smc_loopback.c     | 29 ++++-------------------------
 net/smc/smc_loopback.h     |  1 -
 13 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 3078779fa71e..1b9fa14da20c 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -67,6 +67,15 @@ union ism_reg_ieq {
 	} response;
 } __aligned(16);
 
+/* ISM-vPCI devices provide 64 Bit GIDs
+ * Map them to ISM UUID GIDs like this:
+ *  _________________________________________
+ * | 64 Bit ISM-vPCI GID | 00000000_00000000 |
+ *  -----------------------------------------
+ * This will be interpreted as a UIID variant, that is reserved
+ * for NCS backward compatibility. So it will not collide with
+ * proper UUIDs.
+ */
 union ism_read_gid {
 	struct {
 		struct ism_req_hdr hdr;
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 31f50cad4b39..2dbf4ebb6bff 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -272,8 +272,9 @@ static int unregister_ieq(struct ism_dev *ism)
 	return 0;
 }
 
-static int ism_read_local_gid(struct ism_dev *ism)
+static int ism_read_local_gid(struct dibs_dev *dibs)
 {
+	struct ism_dev *ism = dibs->drv_priv;
 	union ism_read_gid cmd;
 	int ret;
 
@@ -285,7 +286,8 @@ static int ism_read_local_gid(struct ism_dev *ism)
 	if (ret)
 		goto out;
 
-	ism->local_gid = cmd.response.gid;
+	memset(&dibs->gid, 0, sizeof(dibs->gid));
+	memcpy(&dibs->gid, &cmd.response.gid, sizeof(cmd.response.gid));
 out:
 	return ret;
 }
@@ -563,10 +565,6 @@ static int ism_dev_init(struct ism_dev *ism)
 	if (ret)
 		goto unreg_sba;
 
-	ret = ism_read_local_gid(ism);
-	if (ret)
-		goto unreg_ieq;
-
 	if (!ism_add_vlan_id(ism, ISM_RESERVED_VLANID))
 		/* hardware is V2 capable */
 		ism_v2_capable = true;
@@ -588,8 +586,6 @@ static int ism_dev_init(struct ism_dev *ism)
 	query_info(ism);
 	return 0;
 
-unreg_ieq:
-	unregister_ieq(ism);
 unreg_sba:
 	unregister_sba(ism);
 free_irq:
@@ -672,6 +668,11 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_dibs;
 
+	/* after ism_dev_init() we can call ism function to set gid */
+	ret = ism_read_local_gid(dibs);
+	if (ret)
+		goto err_ism;
+
 	dibs->dev.parent = &pdev->dev;
 
 	zdev = to_zpci(pdev);
@@ -846,18 +847,6 @@ static int smcd_supports_v2(void)
 	return ism_v2_capable;
 }
 
-static u64 ism_get_local_gid(struct ism_dev *ism)
-{
-	return ism->local_gid;
-}
-
-static void smcd_get_local_gid(struct smcd_dev *smcd,
-			       struct smcd_gid *smcd_gid)
-{
-	smcd_gid->gid = ism_get_local_gid(smcd->priv);
-	smcd_gid->gid_ext = 0;
-}
-
 static const struct smcd_ops ism_smcd_ops = {
 	.query_remote_gid = smcd_query_rgid,
 	.register_dmb = smcd_register_dmb,
@@ -869,7 +858,6 @@ static const struct smcd_ops ism_smcd_ops = {
 	.signal_event = smcd_signal_ieq,
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
-	.get_local_gid = smcd_get_local_gid,
 };
 
 const struct smcd_ops *ism_get_smcd_ops(void)
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 4459b9369dc0..058dfc14aa5c 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -10,6 +10,8 @@
 #define _DIBS_H
 
 #include <linux/device.h>
+#include <linux/uuid.h>
+
 /* DIBS - Direct Internal Buffer Sharing - concept
  * -----------------------------------------------
  * In the case of multiple system sharing the same hardware, dibs fabrics can
@@ -138,6 +140,7 @@ struct dibs_dev {
 	struct device dev;
 	/* To be filled by device driver, before calling dibs_dev_add(): */
 	const struct dibs_dev_ops *ops;
+	uuid_t gid;
 	/* priv pointer for device driver */
 	void *drv_priv;
 
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 84f1afb3dded..a926dd61b5a1 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -42,7 +42,6 @@ struct ism_dev {
 	struct ism_eq *ieq;
 	dma_addr_t ieq_dma_addr;
 
-	u64 local_gid;
 	int ieq_idx;
 
 	struct ism_client *subs[MAX_CLIENTS];
diff --git a/include/net/smc.h b/include/net/smc.h
index 05faac83371e..9cb8385bbc6e 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -62,7 +62,6 @@ struct smcd_ops {
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
 	int (*supports_v2)(void);
-	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
 
 	/* optional operations */
 	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
diff --git a/net/dibs/dibs_loopback.c b/net/dibs/dibs_loopback.c
index bf02563527b4..d3800264fbba 100644
--- a/net/dibs/dibs_loopback.c
+++ b/net/dibs/dibs_loopback.c
@@ -45,6 +45,7 @@ static int dibs_lo_dev_probe(void)
 
 	ldev->dibs = dibs;
 	dibs->drv_priv = ldev;
+	uuid_gen(&dibs->gid);
 	dibs->ops = &dibs_lo_ops;
 
 	dibs->dev.parent = NULL;
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index e530c90a2934..3e8b7e31b57c 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -113,6 +113,17 @@ struct dibs_dev *dibs_dev_alloc(void)
 }
 EXPORT_SYMBOL_GPL(dibs_dev_alloc);
 
+static ssize_t gid_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct dibs_dev *dibs;
+
+	dibs = container_of(dev, struct dibs_dev, dev);
+
+	return sysfs_emit(buf, "%pUb\n", &dibs->gid);
+}
+static DEVICE_ATTR_RO(gid);
+
 static ssize_t fabric_id_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -127,6 +138,7 @@ static ssize_t fabric_id_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(fabric_id);
 
 static struct attribute *dibs_dev_attrs[] = {
+	&dev_attr_gid.attr,
 	&dev_attr_fabric_id.attr,
 	NULL,
 };
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 5a4db151fe95..e44cbfd2619d 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -915,7 +915,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		/* add SMC-D specifics */
 		if (ini->ism_dev[0]) {
 			smcd = ini->ism_dev[0];
-			smcd->ops->get_local_gid(smcd, &smcd_gid);
+			copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 			pclc_smcd->ism.gid = htonll(smcd_gid.gid);
 			pclc_smcd->ism.chid =
 				htons(smc_ism_get_chid(ini->ism_dev[0]));
@@ -965,7 +965,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		if (ini->ism_offered_cnt) {
 			for (i = 1; i <= ini->ism_offered_cnt; i++) {
 				smcd = ini->ism_dev[i];
-				smcd->ops->get_local_gid(smcd, &smcd_gid);
+				copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 				gidchids[entry].chid =
 					htons(smc_ism_get_chid(ini->ism_dev[i]));
 				gidchids[entry].gid = htonll(smcd_gid.gid);
@@ -1058,7 +1058,7 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 	/* SMC-D specific settings */
 	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
 	       sizeof(SMCD_EYECATCHER));
-	smcd->ops->get_local_gid(smcd, &smcd_gid);
+	copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 	clc->hdr.typev1 = SMC_TYPE_D;
 	clc->d0.gid = htonll(smcd_gid.gid);
 	clc->d0.token = htonll(conn->rmb_desc->token);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 71c410dc3658..405cb0003241 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -555,7 +555,7 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_ID, *((u32 *)&lgr->id)))
 		goto errattr;
-	smcd->ops->get_local_gid(smcd, &smcd_gid);
+	copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_GID,
 			      smcd_gid.gid, SMC_NLA_LGR_D_PAD))
 		goto errattr;
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 8ed2f6689b01..bf0beaa23bdb 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -175,7 +175,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 		dinfo.linkid = *((u32 *)conn->lgr->id);
 		dinfo.peer_gid = conn->lgr->peer_gid.gid;
 		dinfo.peer_gid_ext = conn->lgr->peer_gid.gid_ext;
-		smcd->ops->get_local_gid(smcd, &smcd_gid);
+		copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 		dinfo.my_gid = smcd_gid.gid;
 		dinfo.my_gid_ext = smcd_gid.gid_ext;
 		dinfo.token = conn->rmb_desc->token;
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 04699951d03f..139e99da2c9f 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -96,4 +96,26 @@ static inline bool smc_ism_is_loopback(struct dibs_dev *dibs)
 	return (dibs->ops->get_fabric_id(dibs) == DIBS_LOOPBACK_FABRIC);
 }
 
+static inline void copy_to_smcdgid(struct smcd_gid *sgid, uuid_t *dibs_gid)
+{
+	__be64 temp;
+
+	memcpy(&temp, dibs_gid, sizeof(sgid->gid));
+	sgid->gid = ntohll(temp);
+	memcpy(&temp, (uint8_t *)dibs_gid + sizeof(sgid->gid),
+	       sizeof(sgid->gid_ext));
+	sgid->gid_ext = ntohll(temp);
+}
+
+static inline void copy_to_dibsgid(uuid_t *dibs_gid, struct smcd_gid *sgid)
+{
+	__be64 temp;
+
+	temp = htonll(sgid->gid);
+	memcpy(dibs_gid, &temp, sizeof(sgid->gid));
+	temp = htonll(sgid->gid_ext);
+	memcpy((uint8_t *)dibs_gid + sizeof(sgid->gid), &temp,
+	       sizeof(sgid->gid_ext));
+}
+
 #endif
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 262d0d0df4d0..454d9d6a6e8f 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -13,6 +13,7 @@
 
 #include <linux/device.h>
 #include <linux/types.h>
+#include <linux/dibs.h>
 #include <net/smc.h>
 
 #include "smc_cdc.h"
@@ -25,25 +26,14 @@
 
 static struct smc_lo_dev *lo_dev;
 
-static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
-{
-	struct smcd_gid *lgid = &ldev->local_gid;
-	uuid_t uuid;
-
-	uuid_gen(&uuid);
-	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
-	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
-	       sizeof(lgid->gid_ext));
-}
-
 static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 			     u32 vid_valid, u32 vid)
 {
-	struct smc_lo_dev *ldev = smcd->priv;
+	uuid_t temp;
 
+	copy_to_dibsgid(&temp, rgid);
 	/* rgid should be the same as lgid */
-	if (!ldev || rgid->gid != ldev->local_gid.gid ||
-	    rgid->gid_ext != ldev->local_gid.gid_ext)
+	if (!uuid_equal(&temp, &smcd->dibs->gid))
 		return -ENETUNREACH;
 	return 0;
 }
@@ -245,15 +235,6 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
 	return 0;
 }
 
-static void smc_lo_get_local_gid(struct smcd_dev *smcd,
-				 struct smcd_gid *smcd_gid)
-{
-	struct smc_lo_dev *ldev = smcd->priv;
-
-	smcd_gid->gid = ldev->local_gid.gid;
-	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
-}
-
 static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
@@ -267,7 +248,6 @@ static const struct smcd_ops lo_ops = {
 	.reset_vlan_required	= NULL,
 	.signal_event		= NULL,
 	.move_data = smc_lo_move_data,
-	.get_local_gid = smc_lo_get_local_gid,
 };
 
 const struct smcd_ops *smc_lo_get_smcd_ops(void)
@@ -277,7 +257,6 @@ const struct smcd_ops *smc_lo_get_smcd_ops(void)
 
 static void smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
-	smc_lo_generate_ids(ldev);
 	rwlock_init(&ldev->dmb_ht_lock);
 	hash_init(ldev->dmb_ht);
 	atomic_set(&ldev->dmb_cnt, 0);
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index a033bf10890a..33bb96ec8b77 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -32,7 +32,6 @@ struct smc_lo_dmb_node {
 
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
-	struct smcd_gid local_gid;
 	atomic_t dmb_cnt;
 	rwlock_t dmb_ht_lock;
 	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
-- 
2.48.1


