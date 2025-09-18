Return-Path: <linux-rdma+bounces-13490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE6B8447F
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD8B624CB7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0E03054C7;
	Thu, 18 Sep 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QPQJ3MNX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498A303A01;
	Thu, 18 Sep 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193538; cv=none; b=tbevU5ZRe5w/YNFIFOtiFEgMolO2vAUtabRR/tzceXL+imhTK7CPo9ZcZ716ISo5qVftbvLY/p7rFjKfpachhpDFd292rKXXX6KFtZ1bg9l4Ey4NSmKqHYAt5vToeo0uqETUbnpXKdJyAYNtsbBu5uj91dSimlGiUaq1hQd361g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193538; c=relaxed/simple;
	bh=NdI3zMLT852f1gCKn4V4jwW1ZY8pwdFu4ohIjKfFqTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZzUP1QzCw3isuAmAKfOBMg3U79jBc7/ZHWI3uFPE0JPpNj4L/hVcSVNXXIpggbNV8EkGZwTFZa6IigcoTRWDWzz8fBr21w6OcwhR72s065wNscxqiK4q4JKMw5S0tqtwBIvVVSkqAg3k9FtFM4rKlnMwOrrpB47SVPkSic4JUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QPQJ3MNX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4lSLS025007;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ly1rXN4IbeINkAIwK
	6h+JvLzfM7WZ56TpqHhRA43KUo=; b=QPQJ3MNXBFU67HspqBq5Mr8zmDqUG6eev
	IseObjVsgsexkYUkrJbcGdTiMntubNWH+QBMWgovotF+vS9RIp1N+lloGJqwevDH
	rxeEssmh9JtlFA0JSoa0YJ1E2prC+iOFBmWwBBda/mtTwrXOwgrb7yThGfQiXP6p
	G5dyTR9/2ydQxlBce5cSSsVXiJWvwifrCh4dGYThSwqGjULR4CBWMxl+hF2nkv21
	r8Ed7wCHiCgX5YQqxIUS178Cua0O/ZOnyF4R16+UDesTWEc7a5YS+Y9aZFXN25Gq
	iBDaTSzmYJeCvu+Zb8T6AAsn8tCtVLvpr6iODUEAylG4x+CyB98Fw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB1NNH020809;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9XTu8022297;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpx9xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51Fk43057560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404D920040;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D2892004B;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id BD58DE152E; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 08/14] dibs: Move struct device to dibs_dev
Date: Thu, 18 Sep 2025 13:04:54 +0200
Message-ID: <20250918110500.1731261-9-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: DHzwiAsTgkEMmDet3RfJC0v4OiHohS3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+3ygW94aTcb0
 ba0vyBi5xhEx53i3rDZTJOiKbTWH53B9g3z0qqxNb19B7XX777AxOxgWYijHhurdOhsUUxyHSlw
 tfwJ7s4JuEVrx+j52ydGu88pPnSVo0MbuJDknhqpF9D9EaRPkv5px4/jzd5BT6YfJpyioEVR6V3
 wHPg5vwnwCVCNaPIUo/zDeJQGIZ53Z0ajsPdBqsVdqB0d0Mn8hV9/r8b5E14rU2vEN2x7M46C1H
 KqZfCee2udU607jNp1G2W57qen58U0+9PJqXmCGHXgsaLRTNXNTZOeOiWRL/p2eNccUpLcHniwl
 dWAttaHq33zQR6nYtY870BLRg4cu8vn7is8cq9AfKqWfmvI5uyV3ME2YhWjHOKUOtLnL97epW7g
 WLg7uaG7
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cbe763 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=GsYJ2B-qGPzP3Sa6f2MA:9
X-Proofpoint-GUID: WN2p17PWBVHvF77MWIGbh1zF5YvocPy2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

From: Julian Ruess <julianr@linux.ibm.com>

Move struct device from ism_dev and smc_lo_dev to dibs_dev, and define a
corresponding release function. Free ism_dev in ism_remove() and smc_lo_dev
in smc_lo_dev_remove().

Replace smcd->ops->get_dev(smcd) by using dibs->dev directly.

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
 drivers/dibs/dibs_loopback.c | 15 ++++++------
 drivers/dibs/dibs_main.c     | 21 +++++++++++++++-
 drivers/s390/net/ism_drv.c   | 40 +++++++------------------------
 include/linux/dibs.h         |  1 +
 include/linux/ism.h          |  1 -
 include/net/smc.h            |  1 -
 net/smc/smc_core.c           |  4 ++--
 net/smc/smc_ism.c            | 46 +++++++++++++++---------------------
 net/smc/smc_loopback.c       | 21 +---------------
 net/smc/smc_loopback.h       |  1 -
 net/smc/smc_pnet.c           | 13 ++++------
 11 files changed, 63 insertions(+), 101 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index 215986ae54a4..76e479d5724b 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -15,6 +15,7 @@
 
 #include "dibs_loopback.h"
 
+static const char dibs_lo_dev_name[] = "lo";
 /* global loopback device */
 static struct dibs_lo_dev *lo_dev;
 
@@ -27,11 +28,6 @@ static const struct dibs_dev_ops dibs_lo_ops = {
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
@@ -52,6 +48,9 @@ static int dibs_lo_dev_probe(void)
 	dibs->drv_priv = ldev;
 	dibs->ops = &dibs_lo_ops;
 
+	dibs->dev.parent = NULL;
+	dev_set_name(&dibs->dev, "%s", dibs_lo_dev_name);
+
 	ret = dibs_dev_add(dibs);
 	if (ret)
 		goto err_reg;
@@ -60,7 +59,7 @@ static int dibs_lo_dev_probe(void)
 
 err_reg:
 	/* pairs with dibs_dev_alloc() */
-	kfree(dibs);
+	put_device(&dibs->dev);
 	kfree(ldev);
 
 	return ret;
@@ -71,9 +70,9 @@ static void dibs_lo_dev_remove(void)
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
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index f1cfa5849277..610b6c452211 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -88,11 +88,24 @@ int dibs_unregister_client(struct dibs_client *client)
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
@@ -100,7 +113,11 @@ EXPORT_SYMBOL_GPL(dibs_dev_alloc);
 
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
@@ -129,6 +146,8 @@ void dibs_dev_del(struct dibs_dev *dibs)
 	mutex_unlock(&clients_lock);
 	list_del_init(&dibs->list);
 	mutex_unlock(&dibs_dev_list.mutex);
+
+	device_del(&dibs->dev);
 }
 EXPORT_SYMBOL_GPL(dibs_dev_del);
 
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2bd8f64ebb56..4096ea9faa7e 100644
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
+	put_device(&dibs->dev);
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
+	put_device(&dibs->dev);
 
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
-	device_del(&ism->dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-	put_device(&ism->dev);
+	kfree(ism);
 }
 
 static struct pci_driver ism_driver = {
@@ -866,13 +850,6 @@ static void smcd_get_local_gid(struct smcd_dev *smcd,
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
@@ -885,7 +862,6 @@ static const struct smcd_ops ism_smcd_ops = {
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
 	.get_local_gid = smcd_get_local_gid,
-	.get_dev = smcd_get_dev,
 };
 
 const struct smcd_ops *ism_get_smcd_ops(void)
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 805ab33271b5..793c6e1ece0f 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -135,6 +135,7 @@ struct dibs_dev_ops {
 
 struct dibs_dev {
 	struct list_head list;
+	struct device dev;
 	/* To be filled by device driver, before calling dibs_dev_add(): */
 	const struct dibs_dev_ops *ops;
 	/* priv pointer for device driver */
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
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2a559a98541c..585e86890ff7 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -924,7 +924,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
 		smcd = ini->ism_dev[ini->ism_selected];
-		get_device(smcd->ops->get_dev(smcd));
+		get_device(&smcd->dibs->dev);
 		lgr->peer_gid.gid =
 			ini->ism_peer_gid[ini->ism_selected].gid;
 		lgr->peer_gid.gid_ext =
@@ -1474,7 +1474,7 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 	destroy_workqueue(lgr->tx_wq);
 	if (lgr->is_smcd) {
 		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-		put_device(lgr->smcd->ops->get_dev(lgr->smcd));
+		put_device(&lgr->smcd->dibs->dev);
 	}
 	smc_lgr_put(lgr); /* theoretically last lgr_put */
 }
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 415f03910c91..6a6e7c9641e8 100644
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
@@ -509,14 +509,14 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 
 	if (smc_ism_is_loopback(dibs)) {
 		ops = smc_lo_get_smcd_ops();
-		smcd = smcd_alloc_dev(dev_name(&smc_lo->dev), ops,
+		smcd = smcd_alloc_dev(dev_name(&dibs->dev), ops,
 				      SMC_LO_MAX_DMBS);
 	} else {
 		ism = dibs->drv_priv;
 #if IS_ENABLED(CONFIG_ISM)
 		ops = ism_get_smcd_ops();
 #endif
-		smcd = smcd_alloc_dev(dev_name(&ism->pdev->dev), ops,
+		smcd = smcd_alloc_dev(dev_name(&dibs->dev), ops,
 				      ISM_NR_DMBS);
 	}
 	if (!smcd)
@@ -534,10 +534,11 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 		ism_set_priv(ism, &smc_ism_client, smcd);
 		smcd->client = &smc_ism_client;
 #endif
-		if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
-			smc_pnetid_by_table_smcd(smcd);
 	}
 
+	if (smc_pnetid_by_dev_port(dibs->dev.parent, 0, smcd->pnetid))
+		smc_pnetid_by_table_smcd(smcd);
+
 	if (smc_ism_is_loopback(dibs) || smcd->ops->supports_v2())
 		smc_ism_set_v2_capable();
 	mutex_lock(&smcd_dev_list.mutex);
@@ -557,33 +558,24 @@ static void smcd_register_dev(struct dibs_dev *dibs)
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
-	if (smc_ism_is_loopback(dibs)) {
-		pr_warn_ratelimited("smc: adding smcd loopback device\n");
-	} else {
-		if (smc_pnet_is_pnetid_set(smcd->pnetid))
-			pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
-					    dev_name(&ism->dev), smcd->pnetid,
-					    smcd->pnetid_by_user ?
-							    " (user defined)" :
-							    "");
-		else
-			pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
-					    dev_name(&ism->dev));
-	}
+	if (smc_pnet_is_pnetid_set(smcd->pnetid))
+		pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
+				    dev_name(&dibs->dev), smcd->pnetid,
+				    smcd->pnetid_by_user ?
+					" (user defined)" :
+					"");
+	else
+		pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
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
index 7225b5fa17a6..d0df7f2b03aa 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -169,7 +169,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
 			pr_warn_ratelimited("smc: smcd device %s "
 					    "erased user defined pnetid "
 					    "%.16s\n",
-					    dev_name(smcd->ops->get_dev(smcd)),
+					    dev_name(&smcd->dibs->dev),
 					    smcd->pnetid);
 			memset(smcd->pnetid, 0, SMC_MAX_PNETID_LEN);
 			smcd->pnetid_by_user = false;
@@ -332,7 +332,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
 
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
-		if (!strncmp(dev_name(smcd_dev->ops->get_dev(smcd_dev)),
+		if (!strncmp(dev_name(&smcd_dev->dibs->dev),
 			     smcd_name, IB_DEVICE_NAME_MAX - 1))
 			goto out;
 	}
@@ -413,7 +413,6 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 	bool smcddev_applied = true;
 	bool ibdev_applied = true;
 	struct smcd_dev *smcd;
-	struct device *dev;
 	bool new_ibdev;
 
 	/* try to apply the pnetid to active devices */
@@ -431,10 +430,8 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 	if (smcd) {
 		smcddev_applied = smc_pnet_apply_smcd(smcd, pnet_name);
 		if (smcddev_applied) {
-			dev = smcd->ops->get_dev(smcd);
-			pr_warn_ratelimited("smc: smcd device %s "
-					    "applied user defined pnetid "
-					    "%.16s\n", dev_name(dev),
+			pr_warn_ratelimited("smc: smcd device %s applied user defined pnetid %.16s\n",
+					    dev_name(&smcd->dibs->dev),
 					    smcd->pnetid);
 		}
 	}
@@ -1193,7 +1190,7 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
  */
 int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
 {
-	const char *ib_name = dev_name(smcddev->ops->get_dev(smcddev));
+	const char *ib_name = dev_name(&smcddev->dibs->dev);
 	struct smc_pnettable *pnettable;
 	struct smc_pnetentry *tmp_pe;
 	struct smc_net *sn;
-- 
2.48.1


