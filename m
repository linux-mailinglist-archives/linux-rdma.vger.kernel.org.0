Return-Path: <linux-rdma+bounces-13287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FCB53C97
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BD55A3AB2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4B369350;
	Thu, 11 Sep 2025 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gT88PHUM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFF329F18;
	Thu, 11 Sep 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620128; cv=none; b=UPuEs7G3SBHMJedKpCZHVUDuNBBg/ownw7XNWFNY30fyA2PabjmXosDyB9/PSMpsv+3JX1tLyo12w6/Y2hj4lrX8jySVjkEj9CBS5FLGWe4oAS83RElZseSLQDHGbSuxR4mg+PG2hxUudGS2W3V3lNZ0cvY/93w5esb8Ctb3gJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620128; c=relaxed/simple;
	bh=PfuuqzmtTuXKpUhe3hUBatdhO5gBYcumoAdAZyEXMDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bS+OKm6+WTP3rMoXFpzDzJRfPEvWk8BPTr4X0moa/abea4MwbSRGNbVAErXZEzh3UoFZ1EhvXvam75m7F7vjPYSfrZaZYIVsUl4+SM59tBas4rq5b4kn+81xC2KZpBsfNnL2skI1kbp0uqNSypbgnIUfiFINqJfyl50YzKfRm28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gT88PHUM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BE2D5I005152;
	Thu, 11 Sep 2025 19:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dxqREcAdHRZP9PRhM
	+hpPJw9LfSxy1ch0zc4HybGhSk=; b=gT88PHUM8RQ+gnMIapcf/LZcJfx4pyvdG
	b4x0tNn1IYhVw0vjbxpk7rgvqd8Dt5KtHpgLTK88WpwZ2jA4njEtVGQ4F6XI1GKa
	Uvc+TVQkQ4Nr/O7B/35x/nj+NFjczD5A8MEaj2pR4NtfDMYJdP50jh9PpJvxIKwm
	L2E34AOI68U7XKoTpHvyuojSyFtxCMqiC9g9EM67fC5NQEarYNw001kglR6i87gD
	kCWdMq3qjitFsZOKKvsOpGs8cfYSWCvIO6u5GScbzJ9jAxmFLrmN3TiDSNIlKm9k
	JPzt4IpYR0Z+V5JOy8Zu07VvOLvkZBEMpV7pT76PoO77LH/6ZOYtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeuhcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BJlaIp020561;
	Thu, 11 Sep 2025 19:48:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeuhcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHLN1I007950;
	Thu, 11 Sep 2025 19:48:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pyg98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BJmSdt48628102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:48:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E9E22004B;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D22D20040;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id C3BF1E12F7; Thu, 11 Sep 2025 21:48:27 +0200 (CEST)
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
        Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH net-next v2 10/14] dibs: Local gid for dibs devices
Date: Thu, 11 Sep 2025 21:48:23 +0200
Message-ID: <20250911194827.844125-11-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911194827.844125-1-wintera@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX0HHmngM72nQf
 wucPcgVN5uwXROlLQMtEjiq887ir0vEN7Y/5YNi/syfObD4M0PIRxYMIttcKoQtzm6yw8Z2G/K4
 j+EInc33h6FtVThM1v8CjgGgHvZouvf42ZX1Xo/TFM4glCewDWnFtw1NapqWmmib75ZYAjxCtoE
 lM74FUNS0h6AkA2RqWvKmmcisF7S/KyQV9W0AFDmumaAKG/q+n14DYn/4Hi2NA9U3wTK0LYzEbr
 i6rlO0S6BjOAQxtmeaNv0dDqqYJHbWKkarU7lItXXBZhdQEDWyEzpUyAXcgcw5C//C4N2DkZ2pm
 Tc+g0zOuDG74wm5dxUX4WY9PUjxzKs9KwAn4jYnzFfyFitgRk+OmeV4d/XbosZJF8h/by/2BxNy
 vYewFHLe
X-Proofpoint-ORIG-GUID: SPQio3A5ceXp0HdW_-pLTRj1BFmky4xW
X-Proofpoint-GUID: qhCNWgf04e7DA2bR--0Nn8ZP2iskmS6W
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c32791 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=48vgC7mUAAAA:8 a=VnNF1IyMAAAA:8 a=3oSkw3nq568YOmkJtqoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

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
 drivers/dibs/dibs_loopback.c |  1 +
 drivers/dibs/dibs_main.c     | 12 ++++++++++++
 drivers/s390/net/ism.h       |  9 +++++++++
 drivers/s390/net/ism_drv.c   | 30 +++++++++---------------------
 include/linux/dibs.h         |  3 +++
 include/linux/ism.h          |  1 -
 include/net/smc.h            |  1 -
 net/smc/smc_clc.c            |  6 +++---
 net/smc/smc_core.c           |  2 +-
 net/smc/smc_diag.c           |  2 +-
 net/smc/smc_ism.h            | 22 ++++++++++++++++++++++
 net/smc/smc_loopback.c       | 29 ++++-------------------------
 net/smc/smc_loopback.h       |  1 -
 13 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index 76e479d5724b..d7e6fa5e90f3 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -46,6 +46,7 @@ static int dibs_lo_dev_probe(void)
 
 	ldev->dibs = dibs;
 	dibs->drv_priv = ldev;
+	uuid_gen(&dibs->gid);
 	dibs->ops = &dibs_lo_ops;
 
 	dibs->dev.parent = NULL;
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index b3f21805aa59..f20ed0594a51 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -114,6 +114,17 @@ struct dibs_dev *dibs_dev_alloc(void)
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
@@ -128,6 +139,7 @@ static ssize_t fabric_id_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(fabric_id);
 
 static struct attribute *dibs_dev_attrs[] = {
+	&dev_attr_gid.attr,
 	&dev_attr_fabric_id.attr,
 	NULL,
 };
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
index ab1d61eb3e3b..e58c55fb03c2 100644
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
@@ -841,18 +842,6 @@ static int smcd_supports_v2(void)
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
@@ -864,7 +853,6 @@ static const struct smcd_ops ism_smcd_ops = {
 	.signal_event = smcd_signal_ieq,
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
-	.get_local_gid = smcd_get_local_gid,
 };
 
 const struct smcd_ops *ism_get_smcd_ops(void)
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 793c6e1ece0f..904f37505c27 100644
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
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 08be56dfb3f2..505fb4a27843 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -913,7 +913,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		/* add SMC-D specifics */
 		if (ini->ism_dev[0]) {
 			smcd = ini->ism_dev[0];
-			smcd->ops->get_local_gid(smcd, &smcd_gid);
+			copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 			pclc_smcd->ism.gid = htonll(smcd_gid.gid);
 			pclc_smcd->ism.chid =
 				htons(smc_ism_get_chid(ini->ism_dev[0]));
@@ -963,7 +963,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		if (ini->ism_offered_cnt) {
 			for (i = 1; i <= ini->ism_offered_cnt; i++) {
 				smcd = ini->ism_dev[i];
-				smcd->ops->get_local_gid(smcd, &smcd_gid);
+				copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 				gidchids[entry].chid =
 					htons(smc_ism_get_chid(ini->ism_dev[i]));
 				gidchids[entry].gid = htonll(smcd_gid.gid);
@@ -1056,7 +1056,7 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 	/* SMC-D specific settings */
 	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
 	       sizeof(SMCD_EYECATCHER));
-	smcd->ops->get_local_gid(smcd, &smcd_gid);
+	copy_to_smcdgid(&smcd_gid, &smcd->dibs->gid);
 	clc->hdr.typev1 = SMC_TYPE_D;
 	clc->d0.gid = htonll(smcd_gid.gid);
 	clc->d0.token = htonll(conn->rmb_desc->token);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2b9e2245d586..76524bd4ddbc 100644
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


