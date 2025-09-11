Return-Path: <linux-rdma+bounces-13291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6EB53C9F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED723A3FDF
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0809536CC82;
	Thu, 11 Sep 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CBFZmed3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1B369331;
	Thu, 11 Sep 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620130; cv=none; b=MDbI5VMFr5VNX59yn4zuc9ktlbP9LIEJ0Emilhgr0ElRoRTmQ4u1RqzY08e1gi75JwmpI5asoGZUKA84gpmzKFcRCxloACD41s33zBe60c/Kn1o7421kJpzRkN8YJpoGG3cTAtnfhfJ+LBAZ+61oWFotbfCkhIr+mSQTkyxJvlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620130; c=relaxed/simple;
	bh=txVQKmxNUjB0cYPE0KJ0IgSGWejjB89Ze2cC4EeW/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TURQoKtp2vGe84WaR75qCay9+sHDLvyI2iU8QA5lifN8pe++6OOczbk6Gk8lcQs+Q2mAN+Klyz8RRU2xay8QJg1tdL6mzIcDVP1+GaYuyc1WVeOuGAdJ7tYyyvQBYJgeAJmGyvnwDcX8vo+H/9rvAabCsOsjNLzfwviJgqoMR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CBFZmed3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH50nS012298;
	Thu, 11 Sep 2025 19:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uorp4S9r5Mn0E27Al
	ZcaHDCVFgwIil0I9kRGV61D4Zo=; b=CBFZmed3EzwWPX2D+jF6qaaRHdeF/TlNE
	uGqXKcquNRXaBKyNvCVbV8KOZ3FcvUPmyVYeE+E8CYwNmXbVLi1twn+N1+AwNUhb
	B+EuH4vsko8dtgZTw40yj6M/YplcHkAFoDMQ2MImjJrQ+SFSkJX2GCensdeU6/nC
	whglF1untcwclgshdRM57wVZEDQX2BweCKbyWUdaxE6JpjgOOKZ+4/dpVvFTQFqe
	jMQPsvVUrcfaCrLyD5HPfkbzOAninTOFYh9EUZ6bMbDGE2JVM67DZosyVY8ffPs2
	HUnphpfh0z4bqGUU6ZO1t8/7pwWzXS2ZFMe46rDmKsYKu9AOlia4g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffq10c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BJmXIX009987;
	Thu, 11 Sep 2025 19:48:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffq102-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH9Fqh007895;
	Thu, 11 Sep 2025 19:48:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pyg96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BJmSZQ35717556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:48:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ACB32004F;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 262C32004B;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 19:48:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B4A52E12DC; Thu, 11 Sep 2025 21:48:27 +0200 (CEST)
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
Subject: [PATCH net-next v2 06/14] dibs: Define dibs loopback
Date: Thu, 11 Sep 2025 21:48:19 +0200
Message-ID: <20250911194827.844125-7-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XUjiVuIb_LQbq69WlBhrbeJWOdG6rl4b
X-Proofpoint-GUID: 5_Im7JDOX-HyFtXVuUN74GdwQbGmWNtS
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c32792 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=0i72I1VtUECP_la-LOwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX7iaEgdmcvgbK
 p8EiUh3sZQmLsENpPJ+c9ng07YcX47I0eZ6fIyGT6JGvj/HCiUaYpDAaPrMCZEiJavKUAn9N9DP
 xkL1PPzlaPCwISQgl4nLoaQvDgbkt4jL9qVhGwdigNVPAv80CE/Bnv6FFeSgsglkv58ggU2t/bv
 0ao6s6YJ7ZoAUhj5N2Ihsz4kkLAWcNG/1BOI7KEmTkWgv0neOjwly2A2otVEswFTEpZ/8YkqtTu
 6FsASCtE8Prsj5DKnBRiusuXiI/JXa/pX3/8RZCMkabDbIT8Dl2k6JvkjqVsjrYg5/fozxKjbQp
 FyRRMKRoWpKlku9Yc3gZ4YldJXW9la5X8I8bi7n3WbbjqoLDZilfIvccxMrdPSCGBHWulHW0mtD
 VExxyYfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

The first stage of loopback-ism was implemented as part of the
SMC module [1]. Now that we have the dibs layer, provide access to a
dibs_loopback device to all dibs clients.

This is the first step of moving loopback-ism from net/smc/smc_loopback.*
to drivers/dibs/dibs_loopback.*. One global structure lo_dev is allocated
and added to the dibs devices. Follow-on patches will move functionality.

Same as smc_loopback, dibs_loopback is provided by a config option.
Note that there is no way to dynamically add or remove the loopback
device. That could be a future improvement.

When moving code to drivers/dibs, replace ism_ prefix with dibs_ prefix.
As this is mostly a move of existing code, copyright and authors are
unchanged.

Link: https://lore.kernel.org/lkml/20240428060738.60843-1-guwen@linux.alibaba.com/ [1]
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |  1 +
 arch/s390/configs/defconfig       |  1 +
 drivers/dibs/Kconfig              | 11 +++++
 drivers/dibs/Makefile             |  1 +
 drivers/dibs/dibs_loopback.c      | 78 +++++++++++++++++++++++++++++++
 drivers/dibs/dibs_loopback.h      | 38 +++++++++++++++
 drivers/dibs/dibs_main.c          | 11 ++++-
 7 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dibs/dibs_loopback.c
 create mode 100644 drivers/dibs/dibs_loopback.h

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 7bc54f053a3b..5a2ed07b6198 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -121,6 +121,7 @@ CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
 CONFIG_DIBS=y
+CONFIG_DIBS_LO=y
 CONFIG_SMC_DIAG=m
 CONFIG_SMC_LO=y
 CONFIG_INET=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 4bf6f3311f7d..4cbdd7e2ff9f 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -112,6 +112,7 @@ CONFIG_UNIX_DIAG=m
 CONFIG_XFRM_USER=m
 CONFIG_NET_KEY=m
 CONFIG_DIBS=y
+CONFIG_DIBS_LO=y
 CONFIG_SMC_DIAG=m
 CONFIG_SMC_LO=y
 CONFIG_INET=y
diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index 09c12f6838ad..5dc347b9b235 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -10,3 +10,14 @@ config DIBS
 	  Select this option to provide the abstraction layer between
 	  dibs devices and dibs clients like the SMC protocol.
 	  The module name is dibs.
+
+config DIBS_LO
+	bool "intra-OS shortcut with dibs loopback"
+	depends on DIBS
+	default n
+	help
+	  DIBS_LO enables the creation of an software-emulated dibs device
+	  named lo which can be used for transferring data when communication
+	  occurs within the same OS. This helps in convenient testing of
+	  dibs clients, since dibs loopback is independent of architecture or
+	  hardware.
diff --git a/drivers/dibs/Makefile b/drivers/dibs/Makefile
index 825dec431bfc..85805490c77f 100644
--- a/drivers/dibs/Makefile
+++ b/drivers/dibs/Makefile
@@ -5,3 +5,4 @@
 
 dibs-y += dibs_main.o
 obj-$(CONFIG_DIBS) += dibs.o
+dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
\ No newline at end of file
diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
new file mode 100644
index 000000000000..225514a452a8
--- /dev/null
+++ b/drivers/dibs/dibs_loopback.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Functions for dibs loopback/loopback-ism device.
+ *
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#include <linux/dibs.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "dibs_loopback.h"
+
+/* global loopback device */
+static struct dibs_lo_dev *lo_dev;
+
+static void dibs_lo_dev_exit(struct dibs_lo_dev *ldev)
+{
+	dibs_dev_del(ldev->dibs);
+}
+
+static int dibs_lo_dev_probe(void)
+{
+	struct dibs_lo_dev *ldev;
+	struct dibs_dev *dibs;
+	int ret;
+
+	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
+	if (!ldev)
+		return -ENOMEM;
+
+	dibs = dibs_dev_alloc();
+	if (!dibs) {
+		kfree(ldev);
+		return -ENOMEM;
+	}
+
+	ldev->dibs = dibs;
+
+	ret = dibs_dev_add(dibs);
+	if (ret)
+		goto err_reg;
+	lo_dev = ldev;
+	return 0;
+
+err_reg:
+	/* pairs with dibs_dev_alloc() */
+	kfree(dibs);
+	kfree(ldev);
+
+	return ret;
+}
+
+static void dibs_lo_dev_remove(void)
+{
+	if (!lo_dev)
+		return;
+
+	dibs_lo_dev_exit(lo_dev);
+	/* pairs with dibs_dev_alloc() */
+	kfree(lo_dev->dibs);
+	kfree(lo_dev);
+	lo_dev = NULL;
+}
+
+int dibs_loopback_init(void)
+{
+	return dibs_lo_dev_probe();
+}
+
+void dibs_loopback_exit(void)
+{
+	dibs_lo_dev_remove();
+}
diff --git a/drivers/dibs/dibs_loopback.h b/drivers/dibs/dibs_loopback.h
new file mode 100644
index 000000000000..fd03b6333a24
--- /dev/null
+++ b/drivers/dibs/dibs_loopback.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  dibs loopback (aka loopback-ism) device structure definitions.
+ *
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#ifndef _DIBS_LOOPBACK_H
+#define _DIBS_LOOPBACK_H
+
+#include <linux/dibs.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#if IS_ENABLED(CONFIG_DIBS_LO)
+
+struct dibs_lo_dev {
+	struct dibs_dev *dibs;
+};
+
+int dibs_loopback_init(void);
+void dibs_loopback_exit(void);
+#else
+static inline int dibs_loopback_init(void)
+{
+	return 0;
+}
+
+static inline void dibs_loopback_exit(void)
+{
+}
+#endif
+
+#endif /* _DIBS_LOOPBACK_H */
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 2f420e077417..a7e33be36158 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -15,6 +15,8 @@
 #include <linux/err.h>
 #include <linux/dibs.h>
 
+#include "dibs_loopback.h"
+
 MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
 MODULE_LICENSE("GPL");
 
@@ -96,14 +98,21 @@ EXPORT_SYMBOL_GPL(dibs_dev_del);
 
 static int __init dibs_init(void)
 {
+	int rc;
+
 	memset(clients, 0, sizeof(clients));
 	max_client = 0;
 
-	return 0;
+	rc = dibs_loopback_init();
+	if (rc)
+		pr_err("%s fails with %d\n", __func__, rc);
+
+	return rc;
 }
 
 static void __exit dibs_exit(void)
 {
+	dibs_loopback_exit();
 }
 
 module_init(dibs_init);
-- 
2.48.1


