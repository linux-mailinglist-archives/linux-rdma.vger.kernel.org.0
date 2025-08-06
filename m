Return-Path: <linux-rdma+bounces-12616-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7191B1C91B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4695A18C4E4A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECF2BDC24;
	Wed,  6 Aug 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LVVnBLrh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0629CB4F;
	Wed,  6 Aug 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494907; cv=none; b=gEKZdWjpqKWfZQFnLxedeVGpxRZraSev+2lPD6cHyhg/sf5v2cmLveCDwZ3Ep++5QMakQOMyRP8tEhSykj0W0soCJdZbIyYTG06juvMAlGz//tQDzXL3Ca76XW+KCv8IKXv/xe/8cGyMRHmkt4R6N3WrSLg6p9MZcI/PbmpXgho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494907; c=relaxed/simple;
	bh=1vCWGsVkbS0BmYzKveDN9jURsRgtWJG24W/dLcFUnls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEA6ufPQRDR6W9iubmGkEgOGzK+wGZhe2Mh3D52zgmurrLnbfWAAPTSppUvmImpzJZCVecXtqZQ32M+2F3a+MqO+Cp6XA43yRqKICrvi8uqmYesQQI4Ck/Vtcxa+5Dl8FvXWiydukVA+wnvm++KJiMmK/Ye9ctVi+DfHtSBEHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LVVnBLrh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766a9kv021685;
	Wed, 6 Aug 2025 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JAP4aFsJ42+QWxoEw
	eItJxflyTb3A6N2nWHYeq2CD98=; b=LVVnBLrhq5VGLXRPW/oI37jmgREu0apwT
	d3dtu61ngqYlloUPtbrdbUqlsN/olw5fsF/zw2AYoN1o9QKZW3K2KdCZUpIX6QD6
	eYTin2MimWdFkcxvgUi5CogzRpWPL/nSqZeFq5CdfrGsIcTsWZEjGz/x23LmN0Nc
	j2gRhgor5MGQMGvw4WN3z9AyaTrSp4ibpOHqaSgHwPc1ZNQA3DBTcEN3hsEyqyTv
	Yc9/dqFekvE21HQYWDwD4XpxpT9F/V+FXnYVw4cooJEEa7joMNjAOu8x5zZk3kZl
	cRoQpFhh+ccnfV1JFcRvbRgLmTNQ4/PBsovS5mlDT8TyewnkYlPtA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6350ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FcPkZ018099;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6350u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CJkfM031345;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwnc8tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfN5M58392932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 325342005A;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3522004B;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id AF566E12AA; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 11/17] net/dibs: Move struct device to dibs_dev
Date: Wed,  6 Aug 2025 17:41:16 +0200
Message-ID: <20250806154122.3413330-12-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=GsYJ2B-qGPzP3Sa6f2MA:9
X-Proofpoint-GUID: OqiDyTKWdOw07nmMKvJpYn3pdRK7fdoU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX9K/nS0NIWb1l
 iEnbFIVZUtbYGEly/cR3WAxpZFDx/MURJQbYcx/cNpHmAARX4+JoyEtgZJ7Ea1pSbcWhXcH5JJK
 aYv9PG92FdjlS7ayrMyYVP+NMcSz70r4gI6t4unq7+SadYY0OzRpHU4Cwb+ZjDvvlCtZvX9+FRt
 r4UAdSIK7d2hxU9oiF3J/a+XFOvHvDQXIWpE2nu5kitzxzWjPv2bvWhv8oMhNYYHQNm+J/FxeS4
 v6kHvfkRB1VSmSu0WP46BmNfRZM/9pAuzTtd/iSEeQjzMVKlNSKAV89/PrSa89+KVwIoLhpzMH0
 6+s9wxVh0O4OCkk/1jeiouTG13vctlR81NO+74zkRhaIZ6v+wzZ5iDoG1dc5JU/B0GngaUCF9eK
 gsatS94ebYt1GNkVXoqju4zOFcFY/CbWnawnzLVxvKs1jS26vgQ8cC09VWfQi6/TWGUPe3tj
X-Proofpoint-ORIG-GUID: 9uOEnyqpEpcQpLNFIRnZxR5KKd3P7Z7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

From: Julian Ruess <julianr@linux.ibm.com>

Move struct device from ism_dev and smc_lo_dev to dibs_dev, and define a
corresponding release function. Free ism_dev in ism_remove() and smc_lo_dev
in smc_lo_dev_remove().

Replace smcd->ops->get_dev(smcd) by dibs_get_dev().

An alternative design would be to embed dibs_dev as a field in ism_dev and
do the same for other dibs device driver specific structs. However that
would have the disadvantage that each dibs device driver needs to allocate
dibs_dev and each dibs device driver needs a different device release
function. The advantage would be that ism_dev and other device driver
specific structs would be covered by device reference counts.

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Co-developed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 40 ++++++++------------------------------
 include/linux/dibs.h       | 16 +++++++++++++++
 include/linux/ism.h        |  1 -
 include/net/smc.h          |  1 -
 net/dibs/dibs_loopback.c   | 15 +++++++-------
 net/dibs/dibs_main.c       | 21 +++++++++++++++++++-
 net/smc/smc_core.c         |  4 ++--
 net/smc/smc_ism.c          | 28 ++++++++++++--------------
 net/smc/smc_loopback.c     | 21 +-------------------
 net/smc/smc_loopback.h     |  1 -
 net/smc/smc_pnet.c         |  8 ++++----
 11 files changed, 70 insertions(+), 86 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 84a6e9ae2e64..0ddfd47a3a7c 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -602,15 +602,6 @@ static int ism_dev_init(struct ism_dev *ism)
 	return ret;
 }
 
-static void ism_dev_release(struct device *dev)
-{
-	struct ism_dev *ism;
-
-	ism = container_of(dev, struct ism_dev, dev);
-
-	kfree(ism);
-}
-
 static void ism_dev_exit(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
@@ -649,17 +640,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&ism->cmd_lock);
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
-	ism->dev.parent = &pdev->dev;
-	ism->dev.release = ism_dev_release;
-	device_initialize(&ism->dev);
-	dev_set_name(&ism->dev, "%s", dev_name(&pdev->dev));
-	ret = device_add(&ism->dev);
-	if (ret)
-		goto err_dev;
 
 	ret = pci_enable_device_mem(pdev);
 	if (ret)
-		goto err;
+		goto err_dev;
 
 	ret = pci_request_mem_regions(pdev, DRV_NAME);
 	if (ret)
@@ -687,6 +671,9 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		goto err_dibs;
 
+	dibs->dev.parent = &pdev->dev;
+	dev_set_name(&dibs->dev, "%s", dev_name(&pdev->dev));
+
 	ret = dibs_dev_add(dibs);
 	if (ret)
 		goto err_ism;
@@ -697,16 +684,14 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ism_dev_exit(ism);
 err_dibs:
 	/* pairs with dibs_dev_alloc() */
-	kfree(dibs);
+	put_device(dibs_get_dev(dibs));
 err_resource:
 	pci_release_mem_regions(pdev);
 err_disable:
 	pci_disable_device(pdev);
-err:
-	device_del(&ism->dev);
 err_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
-	put_device(&ism->dev);
+	kfree(ism);
 
 	return ret;
 }
@@ -719,13 +704,12 @@ static void ism_remove(struct pci_dev *pdev)
 	dibs_dev_del(dibs);
 	ism_dev_exit(ism);
 	/* pairs with dibs_dev_alloc() */
-	kfree(dibs);
+	put_device(dibs_get_dev(dibs));
 
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
-	device_del(&ism->dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-	put_device(&ism->dev);
+	kfree(ism);
 }
 
 static struct pci_driver ism_driver = {
@@ -871,13 +855,6 @@ static void smcd_get_local_gid(struct smcd_dev *smcd,
 	smcd_gid->gid_ext = 0;
 }
 
-static inline struct device *smcd_get_dev(struct smcd_dev *dev)
-{
-	struct ism_dev *ism = dev->priv;
-
-	return &ism->dev;
-}
-
 static const struct smcd_ops ism_smcd_ops = {
 	.query_remote_gid = smcd_query_rgid,
 	.register_dmb = smcd_register_dmb,
@@ -890,7 +867,6 @@ static const struct smcd_ops ism_smcd_ops = {
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
 	.get_local_gid = smcd_get_local_gid,
-	.get_dev = smcd_get_dev,
 };
 
 const struct smcd_ops *ism_get_smcd_ops(void)
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 805ab33271b5..4459b9369dc0 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -135,6 +135,7 @@ struct dibs_dev_ops {
 
 struct dibs_dev {
 	struct list_head list;
+	struct device dev;
 	/* To be filled by device driver, before calling dibs_dev_add(): */
 	const struct dibs_dev_ops *ops;
 	/* priv pointer for device driver */
@@ -158,6 +159,21 @@ static inline void *dibs_get_priv(struct dibs_dev *dev,
 
 /* ------- End of client-only functions ----------- */
 
+/* Functions to be called by dibs clients and dibs device drivers:
+ */
+/**
+ * dibs_get_dev()
+ * @dev: dibs device
+ * @token: dmb token of the remote dmb
+ *
+ * TODO: provide get and put functions
+ * Return: struct device* to be used for device refcounting
+ */
+static inline struct device *dibs_get_dev(struct dibs_dev *dibs)
+{
+	return &dibs->dev;
+}
+
 /* Functions to be called by dibs device drivers:
  */
 /**
diff --git a/include/linux/ism.h b/include/linux/ism.h
index c818a25996db..84f1afb3dded 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -42,7 +42,6 @@ struct ism_dev {
 	struct ism_eq *ieq;
 	dma_addr_t ieq_dma_addr;
 
-	struct device dev;
 	u64 local_gid;
 	int ieq_idx;
 
diff --git a/include/net/smc.h b/include/net/smc.h
index e271891b85e6..05faac83371e 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -63,7 +63,6 @@ struct smcd_ops {
 			 unsigned int size);
 	int (*supports_v2)(void);
 	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
-	struct device* (*get_dev)(struct smcd_dev *dev);
 
 	/* optional operations */
 	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
diff --git a/net/dibs/dibs_loopback.c b/net/dibs/dibs_loopback.c
index 1d9d3081c020..bf02563527b4 100644
--- a/net/dibs/dibs_loopback.c
+++ b/net/dibs/dibs_loopback.c
@@ -14,6 +14,7 @@
 
 #include "dibs_loopback.h"
 
+static const char dibs_lo_dev_name[] = "lo";
 /* global loopback device */
 static struct dibs_lo_dev *lo_dev;
 
@@ -26,11 +27,6 @@ static const struct dibs_dev_ops dibs_lo_ops = {
 	.get_fabric_id = dibs_lo_get_fabric_id,
 };
 
-static void dibs_lo_dev_exit(struct dibs_lo_dev *ldev)
-{
-	dibs_dev_del(ldev->dibs);
-}
-
 static int dibs_lo_dev_probe(void)
 {
 	struct dibs_lo_dev *ldev;
@@ -51,6 +47,9 @@ static int dibs_lo_dev_probe(void)
 	dibs->drv_priv = ldev;
 	dibs->ops = &dibs_lo_ops;
 
+	dibs->dev.parent = NULL;
+	dev_set_name(&dibs->dev, "%s", dibs_lo_dev_name);
+
 	ret = dibs_dev_add(dibs);
 	if (ret)
 		goto err_reg;
@@ -59,7 +58,7 @@ static int dibs_lo_dev_probe(void)
 
 err_reg:
 	/* pairs with dibs_dev_alloc() */
-	kfree(dibs);
+	put_device(&dibs->dev);
 	kfree(ldev);
 
 	return ret;
@@ -70,9 +69,9 @@ static void dibs_lo_dev_remove(void)
 	if (!lo_dev)
 		return;
 
-	dibs_lo_dev_exit(lo_dev);
+	dibs_dev_del(lo_dev->dibs);
 	/* pairs with dibs_dev_alloc() */
-	kfree(lo_dev->dibs);
+	put_device(&lo_dev->dibs->dev);
 	kfree(lo_dev);
 	lo_dev = NULL;
 }
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index d8fa4a0b5935..8ffe1b4c90ef 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -87,11 +87,24 @@ int dibs_unregister_client(struct dibs_client *client)
 }
 EXPORT_SYMBOL_GPL(dibs_unregister_client);
 
+static void dibs_dev_release(struct device *dev)
+{
+	struct dibs_dev *dibs;
+
+	dibs = container_of(dev, struct dibs_dev, dev);
+
+	kfree(dibs);
+}
+
 struct dibs_dev *dibs_dev_alloc(void)
 {
 	struct dibs_dev *dibs;
 
 	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
+	if (!dibs)
+		return dibs;
+	dibs->dev.release = dibs_dev_release;
+	device_initialize(&dibs->dev);
 
 	return dibs;
 }
@@ -99,7 +112,11 @@ EXPORT_SYMBOL_GPL(dibs_dev_alloc);
 
 int dibs_dev_add(struct dibs_dev *dibs)
 {
-	int i;
+	int i, ret;
+
+	ret = device_add(&dibs->dev);
+	if (ret)
+		return ret;
 
 	mutex_lock(&dibs_dev_list.mutex);
 	mutex_lock(&clients_lock);
@@ -128,6 +145,8 @@ void dibs_dev_del(struct dibs_dev *dibs)
 	mutex_unlock(&clients_lock);
 	list_del_init(&dibs->list);
 	mutex_unlock(&dibs_dev_list.mutex);
+
+	device_del(&dibs->dev);
 }
 EXPORT_SYMBOL_GPL(dibs_dev_del);
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 67f9e0b83ebc..71c410dc3658 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -924,7 +924,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
 		smcd = ini->ism_dev[ini->ism_selected];
-		get_device(smcd->ops->get_dev(smcd));
+		get_device(dibs_get_dev(smcd->dibs));
 		lgr->peer_gid.gid =
 			ini->ism_peer_gid[ini->ism_selected].gid;
 		lgr->peer_gid.gid_ext =
@@ -1474,7 +1474,7 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 	destroy_workqueue(lgr->tx_wq);
 	if (lgr->is_smcd) {
 		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-		put_device(lgr->smcd->ops->get_dev(lgr->smcd));
+		put_device(dibs_get_dev(lgr->smcd->dibs));
 	}
 	smc_lgr_put(lgr); /* theoretically last lgr_put */
 }
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 0943e7d4cd2a..dd46d8000381 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -303,12 +303,12 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
 	struct smc_pci_dev smc_pci_dev;
 	struct nlattr *port_attrs;
+	struct dibs_dev *dibs;
 	struct nlattr *attrs;
-	struct ism_dev *ism;
 	int use_cnt = 0;
 	void *nlh;
 
-	ism = smcd->priv;
+	dibs = smcd->dibs;
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &smc_gen_nl_family, NLM_F_MULTI,
 			  SMC_NETLINK_GET_DEV_SMCD);
@@ -323,7 +323,7 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
 		goto errattr;
 	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
-	smc_set_pci_values(ism->pdev, &smc_pci_dev);
+	smc_set_pci_values(to_pci_dev(dibs->dev.parent), &smc_pci_dev);
 	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
 		goto errattr;
 	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))
@@ -509,12 +509,12 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 
 	if (smc_ism_is_loopback(dibs)) {
 		ops = smc_lo_get_smcd_ops();
-		smcd = smcd_alloc_dev(dev_name(&smc_lo->dev), ops,
+		smcd = smcd_alloc_dev(dev_name(&dibs->dev), ops,
 				      SMC_LO_MAX_DMBS);
 	} else {
 		ism = dibs->drv_priv;
 		ops = ism_get_smcd_ops();
-		smcd = smcd_alloc_dev(dev_name(&ism->pdev->dev), ops,
+		smcd = smcd_alloc_dev(dev_name(&dibs->dev), ops,
 				      ISM_NR_DMBS);
 	}
 	if (!smcd)
@@ -529,10 +529,11 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 	} else {
 		smcd->priv = ism;
 		ism_set_priv(ism, &smc_ism_client, smcd);
-		if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
-			smc_pnetid_by_table_smcd(smcd);
 	}
 
+	if (smc_pnetid_by_dev_port(dibs->dev.parent, 0, smcd->pnetid))
+		smc_pnetid_by_table_smcd(smcd);
+
 	smcd->client = &smc_ism_client;
 
 	if (smcd->ops->supports_v2())
@@ -556,27 +557,22 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 
 	if (smc_pnet_is_pnetid_set(smcd->pnetid))
 		pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
-				    dev_name(&ism->dev), smcd->pnetid,
+				    dev_name(&dibs->dev), smcd->pnetid,
 				    smcd->pnetid_by_user ?
 					" (user defined)" :
 					"");
 	else
 		pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
-				    dev_name(&ism->dev));
+				    dev_name(&dibs->dev));
 	return;
 }
 
 static void smcd_unregister_dev(struct dibs_dev *dibs)
 {
 	struct smcd_dev *smcd = dibs_get_priv(dibs, &smc_dibs_client);
-	struct ism_dev *ism = dibs->drv_priv;
 
-	if (smc_ism_is_loopback(dibs)) {
-		pr_warn_ratelimited("smc: removing smcd loopback device\n");
-	} else {
-		pr_warn_ratelimited("smc: removing smcd device %s\n",
-				    dev_name(&ism->dev));
-	}
+	pr_warn_ratelimited("smc: removing smcd device %s\n",
+			    dev_name(&dibs->dev));
 	smcd->going_away = 1;
 	smc_smcd_terminate_all(smcd);
 	mutex_lock(&smcd_dev_list.mutex);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 37d8366419f7..262d0d0df4d0 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -23,7 +23,6 @@
 #define SMC_LO_SUPPORT_NOCOPY	0x1
 #define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
-static const char smc_lo_dev_name[] = "loopback-ism";
 static struct smc_lo_dev *lo_dev;
 
 static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
@@ -255,11 +254,6 @@ static void smc_lo_get_local_gid(struct smcd_dev *smcd,
 	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
 }
 
-static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
-{
-	return &((struct smc_lo_dev *)smcd->priv)->dev;
-}
-
 static const struct smcd_ops lo_ops = {
 	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb = smc_lo_register_dmb,
@@ -274,7 +268,6 @@ static const struct smcd_ops lo_ops = {
 	.signal_event		= NULL,
 	.move_data = smc_lo_move_data,
 	.get_local_gid = smc_lo_get_local_gid,
-	.get_dev = smc_lo_get_dev,
 };
 
 const struct smcd_ops *smc_lo_get_smcd_ops(void)
@@ -299,14 +292,6 @@ static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
 		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
 }
 
-static void smc_lo_dev_release(struct device *dev)
-{
-	struct smc_lo_dev *ldev =
-		container_of(dev, struct smc_lo_dev, dev);
-
-	kfree(ldev);
-}
-
 static int smc_lo_dev_probe(void)
 {
 	struct smc_lo_dev *ldev;
@@ -315,10 +300,6 @@ static int smc_lo_dev_probe(void)
 	if (!ldev)
 		return -ENOMEM;
 
-	ldev->dev.parent = NULL;
-	ldev->dev.release = smc_lo_dev_release;
-	device_initialize(&ldev->dev);
-	dev_set_name(&ldev->dev, smc_lo_dev_name);
 	smc_lo_dev_init(ldev);
 
 	lo_dev = ldev; /* global loopback device */
@@ -332,7 +313,7 @@ static void smc_lo_dev_remove(void)
 		return;
 
 	smc_lo_dev_exit(lo_dev);
-	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
+	kfree(lo_dev);
 	lo_dev = NULL;
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 76c62526e2e5..a033bf10890a 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -32,7 +32,6 @@ struct smc_lo_dmb_node {
 
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
-	struct device dev;
 	struct smcd_gid local_gid;
 	atomic_t dmb_cnt;
 	rwlock_t dmb_ht_lock;
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 76ad29e31d60..bbdd875731f2 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -169,7 +169,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
 			pr_warn_ratelimited("smc: smcd device %s "
 					    "erased user defined pnetid "
 					    "%.16s\n",
-					    dev_name(smcd->ops->get_dev(smcd)),
+					    dev_name(dibs_get_dev(smcd->dibs)),
 					    smcd->pnetid);
 			memset(smcd->pnetid, 0, SMC_MAX_PNETID_LEN);
 			smcd->pnetid_by_user = false;
@@ -332,7 +332,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
 
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
-		if (!strncmp(dev_name(smcd_dev->ops->get_dev(smcd_dev)),
+		if (!strncmp(dev_name(dibs_get_dev(smcd_dev->dibs)),
 			     smcd_name, IB_DEVICE_NAME_MAX - 1))
 			goto out;
 	}
@@ -431,7 +431,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 	if (smcd) {
 		smcddev_applied = smc_pnet_apply_smcd(smcd, pnet_name);
 		if (smcddev_applied) {
-			dev = smcd->ops->get_dev(smcd);
+			dev = dibs_get_dev(smcd->dibs);
 			pr_warn_ratelimited("smc: smcd device %s "
 					    "applied user defined pnetid "
 					    "%.16s\n", dev_name(dev),
@@ -1192,7 +1192,7 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
  */
 int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
 {
-	const char *ib_name = dev_name(smcddev->ops->get_dev(smcddev));
+	const char *ib_name = dev_name(dibs_get_dev(smcddev->dibs));
 	struct smc_pnettable *pnettable;
 	struct smc_pnetentry *tmp_pe;
 	struct smc_net *sn;
-- 
2.48.1


