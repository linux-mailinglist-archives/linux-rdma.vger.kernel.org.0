Return-Path: <linux-rdma+bounces-13118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D9FB45B0E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423F33A1B53
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35F3728BA;
	Fri,  5 Sep 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OWrJupdS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4D5371EAE;
	Fri,  5 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084085; cv=none; b=l0XEkTIhbfZJHdyYUQlYUiTrO4OqpKdmw0RH9OB/Tb7Cm5J7G6RnX6XqnI4zCdB3iZ1MTwuvg1bQheporSf0v7TlrUjgr2BMUygvIkdOm3S3h2cDvCxUWjosaq1JAW5zycj0sg84PEabDLZCepylcDJ3f/kpTagCgGJGM33VjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084085; c=relaxed/simple;
	bh=fuzalqkYsyqMSGmIwtBsZdJHSGIxt3HTQr/5Fp9CgbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwNwPQyXLPIyRS6ZQ6qvmxxhYqrgXKYTDhgxcPl/JTwgdIb+rgypjCO0MTePeZaM19Y8CtILnoN8T9/7RjWYYLxKNGxGvourEGTcFK9nGLGyFyE4SGFdftj3LbZPYJPa19ctPYUevfytjdRvSOTqbxR+gh7t9DbYh4yNydUjX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OWrJupdS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585CIcdS016443;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/fy0pI0imUXhdqw6h
	cDVmG01EQWAbUc1sOgWNnfJZgM=; b=OWrJupdSRl0cNthMf+v5GJCyVODL62Vhw
	7jn/Za6sB2EdKVfbv7RtDtMRF2PUJtDPZlxVhhjvMSAYj3GF0tWMMzAI9C9vUlf+
	1Gcujla0VYh1tP36uOSfvVAermMY3K4+Qev9A1p9qSmcX5rhzZr3ggu7AnlLrxFu
	IlWoxzy84kOng7pjCyvJkMBAbJhV7xB7tnxdy4fowJ16AcN+g05CDgudfVyaVd6K
	tFgVH6bdyWJUCk1mS8kEEwak+3trIRJbCX/8kmec6KhI6UZoo9lM5G/eZwXnCdPs
	GY6QtUQOXOXcuElnFXvD/c5luEiHQow3KF4A2/nr6RvC9bkwAWQ0A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurh7dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:34 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585Eqwra022401;
	Fri, 5 Sep 2025 14:54:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurh7d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585D07Xn019316;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n9tva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSgN52953496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3BD72004B;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8173E20040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 33E62E1180; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
Subject: [PATCH net-next 09/14] net/dibs: Create class dibs
Date: Fri,  5 Sep 2025 16:54:22 +0200
Message-ID: <20250905145428.1962105-10-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX6ivvENx/Up3Q
 Kr0ZI4Csij+uUCAyqbBQWk0RXafUO1J0uVRp/9Q2GuwWHrGMb6IS+Kn3jLKn+QCDEVlQATUGieF
 /GK7nfIIjnNphPuE5YX5qOunWc5ZvxHkwiXm4eZUoFZV57D8gyg1KSxc/bxdrDGW4yFbWwUGv+J
 vuiz0Z9zoXlbvN6It+pDrjtKA79c/Xo3+Xapshhg79UqdYSOA5arSFc60s8pLIi6RJeLmJx+vfh
 2JJRzGBW6Bgp4hrJdJIrBvZadgtNZyMwz6yu22T7FQy/jvP9QH3ESCfLJbzXLi6Kcnz02MaH5sl
 c1s1wDIAgIQvNVKWfLqOLZezNEIounyRpnCIYEIyd8zsxE1pMuiQuZ/HHcnBoQj1KPO+aCZ5mwu
 6aZUfRYo
X-Proofpoint-GUID: ToSkAYm4UwLyBCm-6L9jQwAebByZnrlX
X-Proofpoint-ORIG-GUID: QS7DZSLeyV4obUD_gwzOQXspXxb8eruB
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68baf9aa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=rhFwxXKG5dtNbWJtHqsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

From: Julian Ruess <julianr@linux.ibm.com>

Create '/sys/class/dibs' to represent multiple kinds of dibs devices in
sysfs. Show s390/ism devices as well as dibs_loopback devices.

Show attribute fabric_id using dibs_ops.get_fabric_id(). This can help
users understand which dibs devices are connected to the same fabric in
different systems and which dibs devices are loopback devices
(fabric_id 0xffff)

Instead of using the same name as the pci device, give the ism devices
their own readable names based on uid or fid from the HW definition.

smc_loopback was never visible in sysfs. dibs_loopback is now represented
as a virtual device.

For the SMC feature "software defined pnet-id" either the ib device name or
the PCI-ID (actually the parent device name) can be used for SMC-R entries.
Mimic this behaviour for SMC-D, and check the parent device name as well.
So device name or PCI-ID can be used for ism and device name can be used
for dibs-loopback. Note that this:
IB_DEVICE_NAME_MAX - 1 == smc_pnet_policy.[SMC_PNETID_IBNAME].len
is the length of smcd_name. Future SW-pnetid cleanup patches to could use a
meaningful define, but that would touch too much unrelated code here.

Examples:
---------
ism before:
> ls /sys/bus/pci/devices/0000:00:00.0/0000:00:00.0
uevent

ism now:
> ls /sys/bus/pci/devices/0000:00:00.0/dibs/ism30
device -> ../../../0000:00:00.0/
fabric_id
subsystem -> ../../../../../class/dibs/
uevent

dibs loopback:
> ls /sys/devices/virtual/dibs/lo/
fabric_id
subsystem -> ../../../../class/dibs/
uevent

dibs class:
> ls -l /sys/class/dibs/
ism30 -> ../../devices/pci0000:00/0000:00:00.0/dibs/ism30/
lo -> ../../devices/virtual/dibs/lo/

For comparison:
> ls -l /sys/class/net/
enc8410 -> ../../devices/qeth/0.0.8410/net/enc8410/
ens1693 -> ../../devices/pci0001:00/0001:00:00.0/net/ens1693/
lo -> ../../devices/virtual/net/lo/

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Co-developed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c |  5 ++++-
 net/dibs/dibs_main.c       | 40 ++++++++++++++++++++++++++++++++++++++
 net/smc/smc_pnet.c         | 16 +++++++++++----
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 4096ea9faa7e..ab1d61eb3e3b 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -629,6 +629,7 @@ static void ism_dev_exit(struct ism_dev *ism)
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct dibs_dev *dibs;
+	struct zpci_dev *zdev;
 	struct ism_dev *ism;
 	int ret;
 
@@ -672,7 +673,9 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_dibs;
 
 	dibs->dev.parent = &pdev->dev;
-	dev_set_name(&dibs->dev, "%s", dev_name(&pdev->dev));
+
+	zdev = to_zpci(pdev);
+	dev_set_name(&dibs->dev, "ism%x", zdev->uid ? zdev->uid : zdev->fid);
 
 	ret = dibs_dev_add(dibs);
 	if (ret)
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index 610b6c452211..b3f21805aa59 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -20,6 +20,8 @@
 MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
 MODULE_LICENSE("GPL");
 
+static struct class *dibs_class;
+
 /* use an array rather a list for fast mapping: */
 static struct dibs_client *clients[MAX_DIBS_CLIENTS];
 static u8 max_client;
@@ -105,12 +107,35 @@ struct dibs_dev *dibs_dev_alloc(void)
 	if (!dibs)
 		return dibs;
 	dibs->dev.release = dibs_dev_release;
+	dibs->dev.class = dibs_class;
 	device_initialize(&dibs->dev);
 
 	return dibs;
 }
 EXPORT_SYMBOL_GPL(dibs_dev_alloc);
 
+static ssize_t fabric_id_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct dibs_dev *dibs;
+	u16 fabric_id;
+
+	dibs = container_of(dev, struct dibs_dev, dev);
+	fabric_id = dibs->ops->get_fabric_id(dibs);
+
+	return sysfs_emit(buf, "0x%04x\n", fabric_id);
+}
+static DEVICE_ATTR_RO(fabric_id);
+
+static struct attribute *dibs_dev_attrs[] = {
+	&dev_attr_fabric_id.attr,
+	NULL,
+};
+
+static const struct attribute_group dibs_dev_attr_group = {
+	.attrs = dibs_dev_attrs,
+};
+
 int dibs_dev_add(struct dibs_dev *dibs)
 {
 	int i, ret;
@@ -119,6 +144,11 @@ int dibs_dev_add(struct dibs_dev *dibs)
 	if (ret)
 		return ret;
 
+	ret = sysfs_create_group(&dibs->dev.kobj, &dibs_dev_attr_group);
+	if (ret) {
+		dev_err(&dibs->dev, "sysfs_create_group failed for dibs_dev\n");
+		goto err_device_del;
+	}
 	mutex_lock(&dibs_dev_list.mutex);
 	mutex_lock(&clients_lock);
 	for (i = 0; i < max_client; ++i) {
@@ -130,6 +160,11 @@ int dibs_dev_add(struct dibs_dev *dibs)
 	mutex_unlock(&dibs_dev_list.mutex);
 
 	return 0;
+
+err_device_del:
+	device_del(&dibs->dev);
+	return ret;
+
 }
 EXPORT_SYMBOL_GPL(dibs_dev_add);
 
@@ -158,6 +193,10 @@ static int __init dibs_init(void)
 	memset(clients, 0, sizeof(clients));
 	max_client = 0;
 
+	dibs_class = class_create("dibs");
+	if (IS_ERR(&dibs_class))
+		return PTR_ERR(&dibs_class);
+
 	rc = dibs_loopback_init();
 	if (rc)
 		pr_err("%s fails with %d\n", __func__, rc);
@@ -168,6 +207,7 @@ static int __init dibs_init(void)
 static void __exit dibs_exit(void)
 {
 	dibs_loopback_exit();
+	class_destroy(dibs_class);
 }
 
 module_init(dibs_init);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 653d7dce908a..99246d792631 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -332,8 +332,11 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
 
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
-		if (!strncmp(dev_name(&smcd_dev->dibs->dev),
-			     smcd_name, IB_DEVICE_NAME_MAX - 1))
+		if (!strncmp(dev_name(&smcd_dev->dibs->dev), smcd_name,
+			     IB_DEVICE_NAME_MAX - 1) ||
+		    (smcd_dev->dibs->dev.parent &&
+		     !strncmp(dev_name(smcd_dev->dibs->dev.parent), smcd_name,
+			      IB_DEVICE_NAME_MAX - 1)))
 			goto out;
 	}
 	smcd_dev = NULL;
@@ -1189,7 +1192,6 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
  */
 int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
 {
-	const char *ib_name = dev_name(&smcddev->dibs->dev);
 	struct smc_pnettable *pnettable;
 	struct smc_pnetentry *tmp_pe;
 	struct smc_net *sn;
@@ -1202,7 +1204,13 @@ int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
 	mutex_lock(&pnettable->lock);
 	list_for_each_entry(tmp_pe, &pnettable->pnetlist, list) {
 		if (tmp_pe->type == SMC_PNET_IB &&
-		    !strncmp(tmp_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX)) {
+		    (!strncmp(tmp_pe->ib_name,
+			       dev_name(&smcddev->dibs->dev),
+			       sizeof(tmp_pe->ib_name)) ||
+		     (smcddev->dibs->dev.parent &&
+		      !strncmp(tmp_pe->ib_name,
+			       dev_name(smcddev->dibs->dev.parent),
+			       sizeof(tmp_pe->ib_name))))) {
 			smc_pnet_apply_smcd(smcddev, tmp_pe->pnet_name);
 			rc = 0;
 			break;
-- 
2.48.1


