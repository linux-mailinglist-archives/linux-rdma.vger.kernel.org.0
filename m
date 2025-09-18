Return-Path: <linux-rdma+bounces-13483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E96BCB84440
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF8746811E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F7302170;
	Thu, 18 Sep 2025 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BZKR4Kwy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248672FCBF4;
	Thu, 18 Sep 2025 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193533; cv=none; b=m5VkORu5E1duGVqBh2z9PGHB1YBRkUDIT5CErGPoOh/jPED0IMJJAS6q5DDxF9bTCa/zoUnUjHJfbpG7GsaPWmzDe7CV/1X01P3551ZbW1ef5CwlBft9BHVu0UyOclim7zhibGJ7LH1Tfk4BvLIUScXA9bc1lrhMvAQki67Pc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193533; c=relaxed/simple;
	bh=WwCnVGbYofUwCrJSTcqVwgX/cBky/z97QuheVNai1/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhmUFgYCaSx2rXXM98I59VR0Ijkfb9Lofl9IwxGiYKHZXD5EyiXurHQ3JsFNb7yyAkJ/v9xjbBqtg+Cml3hCeqgZWEz3SKR/+oo4tt6Nr85cG2UvoZzJ4jO+y+OZIhvLxMcFjPf4OxgS8/em+Dj4LfjeqGLdZ4AEN8mnxTYSTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BZKR4Kwy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5wain011014;
	Thu, 18 Sep 2025 11:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J0y8rl3Nel8ETmnqA
	F2ckgO48YAPmgbb92F8C0os1Fc=; b=BZKR4KwyVw816PNklK5mYqHARnC6to9EK
	BzsjG6XnJRrDR3RayClaCA5gRswWNXcvdsWZaj6/hznohpgPtTynSVz6p+CEX3Ws
	ww0HetIw4KxJkWeeNWLX5yM9fGCFDt9E3sMlVeUknonLb52LxHzPVWrMI4edF2QF
	hB8gwwoY5yf5LIfjiwdWH3Mw8XE/31CYJ2yp9rfW2l9AwPVo5VxeZQzJVhg5yKp4
	7DRBeirjecN/r0Rvks++X86VNLtqXRvZrRFNBvgSgRcYSliF7kztfrLAE1zpo+iB
	Xyr2RMkmItwy1etGrIhOusq2cmajdQRillfBUzYwEBD69HlZTBT7g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nhaun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB56C2024112;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4nhaub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9XTu7022297;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpx9xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51ka55640484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51A822005A;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ADB72004D;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id C0E62E1558; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 09/14] dibs: Create class dibs
Date: Thu, 18 Sep 2025 13:04:55 +0200
Message-ID: <20250918110500.1731261-10-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68cbe762 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=rhFwxXKG5dtNbWJtHqsA:9
X-Proofpoint-GUID: qxl4w2IEL93msTQ_J_BV3oDfLtfMEjdN
X-Proofpoint-ORIG-GUID: Wxi6DZTFtZytGZZ_f5oHJ60m3D0OSrUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX2sAb6V30u3ue
 k5E7MDisF5HLkF5FVp+L+RJ25o0lF9EEPYXKID7Orr9R4uEYd0vn3YMP3SQ6g3VSwtVqkMu6r87
 RTvL2PvbSf6bc4iCcqdlP3M6zFed7bv68DExHN8q4iAopfxgVXLMuCoiK/j/yQlX3geaBXgVAO5
 z+uHi12IZWCM8ONLTt6XU53ZfTVWotQmR54eBYVnFWDuSpiICp8KPBPgng8sT7i8S4bR0Wc9GE6
 lRudSDgoRg7RxjoUezvpEnf7g52pJQOodC1+N6FP5a44FRvlLNtXO2IpGXJlWjddVQXFaY2H3wV
 iLtgiQ3qyDSvFX0X7HVoqKAc348N3ChE2FajPhQRxcaG2/NUCA742odiRN9WFosnyc+B2QUl6H+
 44cSSF6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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
 drivers/dibs/dibs_main.c   | 40 ++++++++++++++++++++++++++++++++++++++
 drivers/s390/net/ism_drv.c |  5 ++++-
 net/smc/smc_pnet.c         | 16 +++++++++++----
 3 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 610b6c452211..b3f21805aa59 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
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
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index d0df7f2b03aa..a3a1e1fde8eb 100644
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
@@ -1190,7 +1193,6 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
  */
 int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
 {
-	const char *ib_name = dev_name(&smcddev->dibs->dev);
 	struct smc_pnettable *pnettable;
 	struct smc_pnetentry *tmp_pe;
 	struct smc_net *sn;
@@ -1203,7 +1205,13 @@ int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
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


