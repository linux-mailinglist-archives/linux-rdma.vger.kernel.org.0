Return-Path: <linux-rdma+bounces-12605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE16B1C8F7
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C35E18C0778
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAEA29B20A;
	Wed,  6 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VPlT7ENA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5A29A9CD;
	Wed,  6 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494902; cv=none; b=Wv13rrwI5xctUvnkdZ359dL0sIgESfUmz7LFjz+eBqDvl+ap5kILjM7WFjDfFCLG9dJa0g42IsqJP1DfsShOaGIyxxstu2608OipBnuTTaaASSzai4G04Sqz3qCz/bLJBq2WRB6vjpdxnvugc6tNl67JEMuEgMR/H/YkZCdw6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494902; c=relaxed/simple;
	bh=nYtxfXtJ+AO4o8SSu8EMk+v7hn9p4hl3yQ9exFL5kOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA1NPOoI7bhdSu0TeNWFfIHDb8Fg7DZVzBwoeOKXX7a1pE/V1W3tZuoeLanBPb6/wqKCJL7sFxMJKuWyYml2soyef0BRoRgw5wAyu0ZPDnvXZfR1+q+b2GMrFbf0BZE+gb3sknWCzjbGOTlsfEcs9grSvzOOOPSt1c0Sdmq5rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VPlT7ENA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57684l3B028218;
	Wed, 6 Aug 2025 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=L3bDhLXYOu+4KksH/
	YnBBp38FdRM+LSRJnx9A4bmdXY=; b=VPlT7ENAztF4WesEGas2DMMvFixb1TbGe
	2ZVtjRndg++C6sHjNn6UhgDhjXDa6WrIAIOVEhgUsTWNERN//p+mHLMu1/THYEUn
	fTbt+hIVt4p7MPZuU/ZPZXZUBWcwK/tWuwzj+79Qq1fEMrOozYP0ilh7SbqMJX3g
	qPKVkDonVJChEX5Rnp8GoMXGPxd6KKlLrqe923MQA7dBDfqQOiJfF4hKllqSUzuB
	TrnrOXCGzYoANpMEwfaCkVIGH+mqh3PCPyS1JLG3tIQsp3b39c4J+ZQxP3nlxiRK
	9zz3kK85m/VQ6B7NNaFRb9qmsvwsdpR+/5coN8rPtegT2uZ36dtNQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60w498-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FMiKj027191;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60w490-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CKRnM022640;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqc8np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNN456426996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268622004B;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0777B2004D;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B2556E12BD; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 12/17] net/dibs: Create class dibs
Date: Wed,  6 Aug 2025 17:41:17 +0200
Message-ID: <20250806154122.3413330-13-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: HriFUBm7lsUwV6Z8KlVpyH3PpqDNALQ5
X-Proofpoint-ORIG-GUID: -YGePKUn3nzDkC7jbVg8kevkqi7y-chV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX2jvOaqDo36ze
 IzTAHdo/lD1jaMuB41FGv82RYLblHHLmFUwZLpKgspuVZu3/TYJXOVd2ySwhZfV+XeT/VRJL2Yn
 MVf4icYg2KI5W/TGe2QB5DfE/Gb6M7I39erma8tBI10RtMZ1e4dG/pXszlsyQyf8z3plWvsuQoU
 NgtIFbhXLZx18V5vQIIgmZIPJy+gCF6dGuUyvH39Kon+fF7UoOIqlaMO6o0xqYBXxrb5EfSVz7d
 EZC44MdkZKqar0xPh+WoqOeGy/InJ9Ll6xC3QeW1nn38kh7X6M2BULBsjG40PGjUy12L7g1L3yg
 Yn+4cGfNm8E6Ikr2z7AAqHPie446X06bOHvOglaz83PiC0EQno8Ks/2OzbFNn4XMSWLgAUUVmYg
 RDvPK7bis3I+vwRxyARxC4FBi/cRhraHyWg5uHIktsoaPOZGthiTITX1Od4VzvTpINfBuatz
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=689377a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=9r-DvrwJgjAc_ovKuuUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

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
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 0ddfd47a3a7c..31f50cad4b39 100644
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
index 8ffe1b4c90ef..e530c90a2934 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -19,6 +19,8 @@
 MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
 MODULE_LICENSE("GPL");
 
+static struct class *dibs_class;
+
 /* use an array rather a list for fast mapping: */
 static struct dibs_client *clients[MAX_DIBS_CLIENTS];
 static u8 max_client;
@@ -104,12 +106,35 @@ struct dibs_dev *dibs_dev_alloc(void)
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
@@ -118,6 +143,11 @@ int dibs_dev_add(struct dibs_dev *dibs)
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
@@ -129,6 +159,11 @@ int dibs_dev_add(struct dibs_dev *dibs)
 	mutex_unlock(&dibs_dev_list.mutex);
 
 	return 0;
+
+err_device_del:
+	device_del(&dibs->dev);
+	return ret;
+
 }
 EXPORT_SYMBOL_GPL(dibs_dev_add);
 
@@ -157,6 +192,10 @@ static int __init dibs_init(void)
 	memset(clients, 0, sizeof(clients));
 	max_client = 0;
 
+	dibs_class = class_create("dibs");
+	if (IS_ERR(&dibs_class))
+		return PTR_ERR(&dibs_class);
+
 	rc = dibs_loopback_init();
 	if (rc)
 		pr_err("%s fails with %d\n", __func__, rc);
@@ -169,6 +208,7 @@ static int __init dibs_init(void)
 static void __exit dibs_exit(void)
 {
 	dibs_loopback_exit();
+	class_destroy(dibs_class);
 	pr_info("module unloaded\n");
 }
 
-- 
2.48.1


