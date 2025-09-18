Return-Path: <linux-rdma+bounces-13488-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24CB84470
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157C61C002A5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158BE2FB08C;
	Thu, 18 Sep 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DcdgwsY4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF33303A05;
	Thu, 18 Sep 2025 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193537; cv=none; b=hdeIZt61qc7lUExY4YksR8cvgjwp9b93h6i3FYwMpo6kDDmFZ9KLITYVbRfyWxqgxNchFxpd1vqOMp23GmQFJ+MolmLn9gPVKJ0pC9MGu4ZOEn1VoFmovhMdxhWQOSKywZDi3WtaJLggz0aOLYF/1fGSj+sW7i9gv2f4iJt/LuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193537; c=relaxed/simple;
	bh=txVQKmxNUjB0cYPE0KJ0IgSGWejjB89Ze2cC4EeW/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCTHh21eQ4wt/rxubY222eS1r/DGU2a/yAprkuBIQENUWOZGd/7gwnIMkwwRceRvFZK2PIe2fjm1iSOhp5Xwl2Obq5PnlowLZvtNhJwOW+eMRDq/7IXH95g6Wezd4J8RKqHOoKYQrIeq8rHZlPgHO4ZsFnGH40zjwRhjwGloGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DcdgwsY4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I51dhc023812;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uorp4S9r5Mn0E27Al
	ZcaHDCVFgwIil0I9kRGV61D4Zo=; b=DcdgwsY4nlYCAkmY5KsYXWPx/sStRCIY6
	1A4YKnC+pB6MjyzgmazMecENN5kAqEuBMPX6IpHP9IHtyC90rxxUuQgKepEE9OWQ
	J6GidoU7CMDJF8z8zdqYXbrpIAGvL2cEw/gkFtkB2dn72p002ThfCWRRiUr91q0Z
	E5E3+laBSwdyUauKAz330IvD8ZMAF0fjoV7Ii02eTcw25YqZqRqqvjhvjvc/dltW
	UIhqWbM0xMyTfTaX7VJj+lWlpMoxtpO2qsXSV6WMTJFo9q7FMI+w9K0Mk6fH/tem
	mMnYvF6Slfvlhuu5aRl+UE+btDaUuHBkBihjWNBFoiS62TLdfZyiw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB05qI018775;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qs9ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I9Fqkn005940;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxuefug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB516k52167136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 464DA2005A;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2630B2004F;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B5854E14F2; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 06/14] dibs: Define dibs loopback
Date: Thu, 18 Sep 2025 13:04:52 +0200
Message-ID: <20250918110500.1731261-7-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Qp7yaxUVKEyCq-7fF530BFllcZurzfgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX5WyibNTs4349
 N/TQkzsWvR6yWhpSafrpm0zWiLpXbJSN2RTVZNh4DKjLRUw64fzN/05a3VSbgAnHGtOv5ArbVu3
 64l7Sc8lyhhcXBTxbemqI5KsRFTydsUhdEmEQz8fQKGUgKBc/hUZ8yKHbelIvjAuSo4K24pXW6o
 AZD16JVmpkqQmbpiROKalKuJ+FdM53GS5QEoweHvTz4wcoUWzJRLajghASk2sVRtkHZYs/NjmTF
 vfB81pCoq//qcoWQMXlg4xq+57gZibLw4v0MpKRZYUkosaIjfxGHwvW49xZn5w75foc7JyTWTDt
 5wFQr8XcZWBb1/8+AbJpMqDuQhdtY6pNo6/+Awbj53dqVwF3DmoCsVNKNgjUX+OO6kSvfUE6Jl1
 QPWhQa3O
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cbe763 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=0i72I1VtUECP_la-LOwA:9
X-Proofpoint-GUID: f0_CYu1M0LFUOCZqcdUDsHofwQYGpQoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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


