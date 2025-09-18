Return-Path: <linux-rdma+bounces-13491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B6B8448B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1541C00B50
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F030595F;
	Thu, 18 Sep 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jz+VM4zQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E7303A06;
	Thu, 18 Sep 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193538; cv=none; b=HloHjUVIRZyJ/be/7E1TYydCu7fxK3QXGumuP9vr30vBdM4kIAgmpRT9Caqsirv2t/kP3iqTfw6GaiaWi5zr/04vuW8A9SCUSjPILlBSOiYZe4o/kjagySeGUNHK7JdWp6tfUtapdqUs5JkwyUwa4imSpy7ErBLVNvhDdUpOG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193538; c=relaxed/simple;
	bh=kDJJIihbtR9/omzYFGDN4XFwTYz0H6uB4lxVoMreM88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiK2JsD6f3UFERY/490Ep0Ap6P9vPfHt9hLcrNJ8dIERdQpGWSp/FsEnGE/U+NxKbR6rYVX2+E8hbtz6ZBmI3REeYeqMMMmljEZbc3gamQoqQnTKCl7k8/QlrZusjxx6aQnyAWVXOfy3B9SZhgpWXiyollW3MqB5UYv8Fb70Mw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jz+VM4zQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7uto3031409;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oFZwzGp1Og1qhLFSh
	qL6EITvxWZfJM2IYXS8cTts8LI=; b=jz+VM4zQD9W46cLeqpL3ybTzwmQ9mVW98
	ZfzFP0s1PWnWna35dynd2DEba6UCg/kR9lLQUHWV7F++NGDb7GMX3ShRmHpe2pp3
	HZ+oU+Dlh0eOeY6/57G8XQwLMXcbMq5/RvwH4AQcjUHZZc6yFMS29Jg2o7DWPUnn
	M3Jo6/uEZtojPIQogSq1AZLQHraU6lRD/zQqa9keITF0t8WM4GAq42xTwkvb+Edu
	qCLhilWIvMJhyk8AlglitdGvjPPrj915foLilIk4yR3m1ALAwtqi0LDAy+g4vCR7
	E/Ewj5dA6NxfW6LBz4E6p11lY/FRkZwWLCd4rWkqCPz+YuRn5pm9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hsrhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB4fw1020729;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hsrhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAJ8P7022278;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpx9xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51iT39584098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44EEB20049;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E1320040;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B21C8E14F1; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 05/14] dibs: Register ism as dibs device
Date: Thu, 18 Sep 2025 13:04:51 +0200
Message-ID: <20250918110500.1731261-6-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nm060EX9eGvX522IMm9QHPpuEVabNm2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+2F76trxt0LW
 9AFq4xcGcxA2OhdNkgEPF9+dON2hgMD5LBsYXmBU1YgCm3UMQJDjUm8eYt2VtlXIEdX2r4Xdxwr
 xP5cz39XCnFkPQtLC8a08zH98F6ebfhouk1c0yiknBdQ7GBclW62dM0WOGzXR21zLMRR/hc//vC
 FmpVGdj2Ua8/NzjQeO+jitQjhbzDB5p2ElzOFDB+hH/iGiNsGKVKVEm28BaPE/WksbKZhcn0aar
 MsK5ad2FNH4B42lkXymeSPU+OemzbZEDS5hL54tunVoV9eIcqWWbVRMWX5+j+pQ0Bqb3XBGdx8w
 qitiZqkSpl6vzvoE9ZL1QQ1Apvq8EROY5PLqznZ8KGS5OfCagqO635mOyVM2b71Iyozg6NU3hf4
 OHAkOXd7
X-Proofpoint-GUID: cDmsspceOSrQ-bQWUlfuFmj38nn1yXVb
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cbe763 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=J5zLYp9vnqA3vR8feqYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

Register ism devices with the dibs layer. Follow-on patches will move
functionality to the dibs layer.

As DIBS is only a shim layer without any dependencies, we can depend ISM
on DIBS without adding indirect dependencies. A follow-on patch will
remove implication of SMC by ISM.

Define struct dibs_dev. Follow-on patches will move more content into
dibs_dev.  The goal of follow-on patches is that ism_dev will only
contain fields that are special for this device driver. The same concept
will apply to other dibs device drivers.

Define dibs_dev_alloc(), dibs_dev_add() and dibs_dev_del() to be called
by dibs device drivers and call them from ism_drv.c
Use ism_dev.dibs for a pointer to dibs_dev.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_main.c   | 38 +++++++++++++++++
 drivers/s390/net/Kconfig   |  2 +-
 drivers/s390/net/ism.h     |  1 +
 drivers/s390/net/ism_drv.c | 83 ++++++++++++++++++++++++--------------
 include/linux/dibs.h       | 38 +++++++++++++++++
 include/linux/ism.h        |  1 +
 6 files changed, 131 insertions(+), 32 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index a5d2be9c3246..2f420e077417 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/dibs.h>
 
@@ -21,6 +22,15 @@ MODULE_LICENSE("GPL");
 static struct dibs_client *clients[MAX_DIBS_CLIENTS];
 static u8 max_client;
 static DEFINE_MUTEX(clients_lock);
+struct dibs_dev_list {
+	struct list_head list;
+	struct mutex mutex; /* protects dibs device list */
+};
+
+static struct dibs_dev_list dibs_dev_list = {
+	.list = LIST_HEAD_INIT(dibs_dev_list.list),
+	.mutex = __MUTEX_INITIALIZER(dibs_dev_list.mutex),
+};
 
 int dibs_register_client(struct dibs_client *client)
 {
@@ -56,6 +66,34 @@ int dibs_unregister_client(struct dibs_client *client)
 }
 EXPORT_SYMBOL_GPL(dibs_unregister_client);
 
+struct dibs_dev *dibs_dev_alloc(void)
+{
+	struct dibs_dev *dibs;
+
+	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
+
+	return dibs;
+}
+EXPORT_SYMBOL_GPL(dibs_dev_alloc);
+
+int dibs_dev_add(struct dibs_dev *dibs)
+{
+	mutex_lock(&dibs_dev_list.mutex);
+	list_add(&dibs->list, &dibs_dev_list.list);
+	mutex_unlock(&dibs_dev_list.mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dibs_dev_add);
+
+void dibs_dev_del(struct dibs_dev *dibs)
+{
+	mutex_lock(&dibs_dev_list.mutex);
+	list_del_init(&dibs->list);
+	mutex_unlock(&dibs_dev_list.mutex);
+}
+EXPORT_SYMBOL_GPL(dibs_dev_del);
+
 static int __init dibs_init(void)
 {
 	memset(clients, 0, sizeof(clients));
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 2b43f6f28362..92985f595d59 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -81,7 +81,7 @@ config CCWGROUP
 
 config ISM
 	tristate "Support for ISM vPCI Adapter"
-	depends on PCI
+	depends on PCI && DIBS
 	imply SMC
 	default n
 	help
diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index b5b03db52fce..3078779fa71e 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <linux/dibs.h>
 #include <linux/ism.h>
 #include <net/smc.h>
 #include <asm/pci_insn.h>
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 6cd60b174315..8ecd0cccc7e8 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -599,8 +599,39 @@ static void ism_dev_release(struct device *dev)
 	kfree(ism);
 }
 
+static void ism_dev_exit(struct ism_dev *ism)
+{
+	struct pci_dev *pdev = ism->pdev;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&ism->lock, flags);
+	for (i = 0; i < max_client; ++i)
+		ism->subs[i] = NULL;
+	spin_unlock_irqrestore(&ism->lock, flags);
+
+	mutex_lock(&ism_dev_list.mutex);
+	mutex_lock(&clients_lock);
+	for (i = 0; i < max_client; ++i) {
+		if (clients[i])
+			clients[i]->remove(ism);
+	}
+	mutex_unlock(&clients_lock);
+
+	if (ism_v2_capable)
+		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
+	unregister_ieq(ism);
+	unregister_sba(ism);
+	free_irq(pci_irq_vector(pdev, 0), ism);
+	kfree(ism->sba_client_arr);
+	pci_free_irq_vectors(pdev);
+	list_del_init(&ism->list);
+	mutex_unlock(&ism_dev_list.mutex);
+}
+
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct dibs_dev *dibs;
 	struct ism_dev *ism;
 	int ret;
 
@@ -636,12 +667,28 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dma_set_max_seg_size(&pdev->dev, SZ_1M);
 	pci_set_master(pdev);
 
+	dibs = dibs_dev_alloc();
+	if (!dibs) {
+		ret = -ENOMEM;
+		goto err_resource;
+	}
+	ism->dibs = dibs;
+
 	ret = ism_dev_init(ism);
 	if (ret)
-		goto err_resource;
+		goto err_dibs;
+
+	ret = dibs_dev_add(dibs);
+	if (ret)
+		goto err_ism;
 
 	return 0;
 
+err_ism:
+	ism_dev_exit(ism);
+err_dibs:
+	/* pairs with dibs_dev_alloc() */
+	kfree(dibs);
 err_resource:
 	pci_release_mem_regions(pdev);
 err_disable:
@@ -655,41 +702,15 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return ret;
 }
 
-static void ism_dev_exit(struct ism_dev *ism)
-{
-	struct pci_dev *pdev = ism->pdev;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&ism->lock, flags);
-	for (i = 0; i < max_client; ++i)
-		ism->subs[i] = NULL;
-	spin_unlock_irqrestore(&ism->lock, flags);
-
-	mutex_lock(&ism_dev_list.mutex);
-	mutex_lock(&clients_lock);
-	for (i = 0; i < max_client; ++i) {
-		if (clients[i])
-			clients[i]->remove(ism);
-	}
-	mutex_unlock(&clients_lock);
-
-	if (ism_v2_capable)
-		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
-	unregister_ieq(ism);
-	unregister_sba(ism);
-	free_irq(pci_irq_vector(pdev, 0), ism);
-	kfree(ism->sba_client_arr);
-	pci_free_irq_vectors(pdev);
-	list_del_init(&ism->list);
-	mutex_unlock(&ism_dev_list.mutex);
-}
-
 static void ism_remove(struct pci_dev *pdev)
 {
 	struct ism_dev *ism = dev_get_drvdata(&pdev->dev);
+	struct dibs_dev *dibs = ism->dibs;
 
+	dibs_dev_del(dibs);
 	ism_dev_exit(ism);
+	/* pairs with dibs_dev_alloc() */
+	kfree(dibs);
 
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
index 7bedeaf52c1b..c12db19c98c0 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -9,6 +9,7 @@
 #ifndef _DIBS_H
 #define _DIBS_H
 
+#include <linux/device.h>
 /* DIBS - Direct Internal Buffer Sharing - concept
  * -----------------------------------------------
  * In the case of multiple system sharing the same hardware, dibs fabrics can
@@ -62,4 +63,41 @@ int dibs_register_client(struct dibs_client *client);
  */
 int dibs_unregister_client(struct dibs_client *client);
 
+/* DIBS devices
+ * ------------
+ */
+struct dibs_dev {
+	struct list_head list;
+};
+
+/* ------- End of client-only functions ----------- */
+
+/*
+ * Functions to be called by dibs device drivers:
+ */
+/**
+ * dibs_dev_alloc() - allocate and reference device structure
+ *
+ * The following fields will be valid upon successful return: dev
+ * NOTE: Use put_device(dibs_get_dev(@dibs)) to give up your reference instead
+ * of freeing @dibs @dev directly once you have successfully called this
+ * function.
+ * Return: Pointer to dibs device structure
+ */
+struct dibs_dev *dibs_dev_alloc(void);
+/**
+ * dibs_dev_add() - register with dibs layer and all clients
+ * @dibs: dibs device
+ *
+ * The following fields must be valid upon entry: dev, ops, drv_priv
+ * All fields will be valid upon successful return.
+ * Return: zero on success
+ */
+int dibs_dev_add(struct dibs_dev *dibs);
+/**
+ * dibs_dev_del() - unregister from dibs layer and all clients
+ * @dibs: dibs device
+ */
+void dibs_dev_del(struct dibs_dev *dibs);
+
 #endif	/* _DIBS_H */
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 8358b4cd7ba6..9a53d3c48c16 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -30,6 +30,7 @@ struct ism_dev {
 	spinlock_t lock; /* protects the ism device */
 	spinlock_t cmd_lock; /* serializes cmds */
 	struct list_head list;
+	struct dibs_dev *dibs;
 	struct pci_dev *pdev;
 
 	struct ism_sba *sba;
-- 
2.48.1


