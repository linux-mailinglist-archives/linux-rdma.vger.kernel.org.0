Return-Path: <linux-rdma+bounces-12615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FD5B1C918
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F836721E3C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B82BD029;
	Wed,  6 Aug 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mZE464H8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C229E115;
	Wed,  6 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494907; cv=none; b=OxESajAZHMF5MnBA+hbzTYBlbg3UObN7WyonxBMJvBKibZYjsTqpJBNzCoHX1XaKIhkbj8DkX2zXpH9PnS/IqRJQ1l4ZfhLoHpzZaCwQKGDV17d8wRGGTea7PlFJx55QFtOhabSWbm2wSG8kQ3CamqF6lv+R+Bq4iVVz3RVOqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494907; c=relaxed/simple;
	bh=YCWYBoCul+mqxPthIuEg4u5kHUva0xlc4xzbyh6sVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsVWALlSkIEQVLoFGc9NLc1L3iwYQUmSUNzPcfLc+++BxkThrFKtiJ3foJAj77j7OfYC4oeJSZKC/OVESmCkIynJYkFEAoBn4O54UDTqXPDByxPledVMB3n1/nGqkpEX3TyPQdW8LSsILQkP4+Q6IyK+TiUh/e1mXdTF/QUg6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mZE464H8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576FWXUR020980;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lXfOlTYFFnWSKOsiN
	lsEPYleIetuWECkIgjcYi7AlOc=; b=mZE464H8ZB4PM24kZRI74YyQt0keXj1Ol
	gNeKhUWThaLbo/MI0RE/VeHqd2EPxcJ7c0VoODCSJ+FzEbslY0Bsykr9ELQGc0UJ
	WlM3mnC0FKtUaXOj4uUo7zmo8Ke+3RS5Tp+wJUpRQziYx5dtCTHCu/BrJCa7DDO9
	YkPGKmxWuRPqn5RLpXr5hAXmczj8AZX379klTRyS89Y2MUScP9fZ/RDZkhpSiFbE
	6EvlVXLnTa+AROwifdQARXzjNDuLmrNjpdgAz+k2qDNzDBsL7KNvB90BnxFASJRG
	/qJpWffhzjlvhiGd1yE1KHI+zOlDtZ3C2Jui9wbWZ+G69oZ0o6Gpw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6350u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FSo5g031398;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6350u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CBXNP008028;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwmv8s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNSk5374250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 289E92004F;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B64A2004E;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A599AE12A2; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 08/17] net/dibs: Register ism as dibs device
Date: Wed,  6 Aug 2025 17:41:13 +0200
Message-ID: <20250806154122.3413330-9-wintera@linux.ibm.com>
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
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=J5zLYp9vnqA3vR8feqYA:9
X-Proofpoint-GUID: 2yxufZikpJdbHdyMw3RQm7bAF5aYDAdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfXzNAJQU5oICoh
 xN+eEQ5u8HSQFtrV6LKxRcy/9O+kkYmHPBIeZ93M+gzb9JKCArZVRMOp+BnxpWG9vAAw28PADBm
 WxBAe31BRX/A+K7z6NrpG6VBTOrf5dJw2iyOK1MAZ/Q4kflnKVpNS6H5O+xaO4R1CxBlwF0pgJf
 Cf8VPukSitcnbm2qpyQzur+XeYc8yxep1nUPmx+aZwlTLvdoiVhTHKwfFZLjHA8vplOGQuRaMBf
 7R7zfc3SIR63mEtLQFDXtHhjyow9x44ZQH/2p8UjosiMP4w1mViM9cvmpOF2agELF40Sm0DYkxY
 vScmqd4VKo0WRvnVJYJp0Wd1jOtLlWQ6wPBzBfEj/GCQiup6kd8i7DW/ulNy+SFcS5OBTZMGSNK
 JyxT31mQO5oxHsfU3pjiqBFcJu96EB+ZHOzpcqExjOFwv7CBkX0qBVCMDhi13R/PTNNAvxnN
X-Proofpoint-ORIG-GUID: IulfDQvQkZQmRb1uZ-N26fjd919T-XYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

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
 drivers/s390/net/Kconfig   |  2 +-
 drivers/s390/net/ism.h     |  1 +
 drivers/s390/net/ism_drv.c | 83 ++++++++++++++++++++++++--------------
 include/linux/dibs.h       | 38 +++++++++++++++++
 include/linux/ism.h        |  1 +
 net/dibs/dibs_main.c       | 36 +++++++++++++++++
 6 files changed, 129 insertions(+), 32 deletions(-)

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
index a543e59818bb..7948334f8d30 100644
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
index 5c432699becb..e9a66cc7f25d 100644
--- a/include/linux/dibs.h
+++ b/include/linux/dibs.h
@@ -9,6 +9,7 @@
 #ifndef _DIBS_H
 #define _DIBS_H
 
+#include <linux/device.h>
 /* DIBS - Direct Internal Buffer Sharing - concept
  * -----------------------------------------------
  * In the case of multiple system sharing the same hardware, dibs fabrics can
@@ -61,4 +62,41 @@ int dibs_register_client(struct dibs_client *client);
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
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index d91e461f2f06..5345e41ae5e4 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -21,6 +21,15 @@ MODULE_LICENSE("GPL");
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
@@ -56,6 +65,33 @@ int dibs_unregister_client(struct dibs_client *client)
 }
 EXPORT_SYMBOL_GPL(dibs_unregister_client);
 
+struct dibs_dev *dibs_dev_alloc(void)
+{
+	struct dibs_dev *dibs;
+
+	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
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
-- 
2.48.1


