Return-Path: <linux-rdma+bounces-12612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0181B1C90A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C132B566485
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD622BCF5C;
	Wed,  6 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BYgZucOL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842F29B8F0;
	Wed,  6 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494905; cv=none; b=TmgdMvOgwSwqNCIxulQMOjUSLs5gC568Q/z4YH+wqHAgj0FVolEKAaHthYkrkGsNBPeABiXzPqLj7jo7rNJv9PeRpwILSFXLdFfRGBtfFAECHmjyiD5LIGARxutd7/rJcmOhxrNrtqAeYo9QfR7z9vzfUOfX3X7mU4UV8sy3+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494905; c=relaxed/simple;
	bh=pMf/8kGGor0+uCqs9Jkan35DBzuppnTvapbh5xAimbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBg0Mj2zgTk8/L4C9kRMeoZjzoCvUCGS8KEJ2NGgOywurJpDEU//8pmV/3/4/QbU0RA7q1mpCp++xPM6463i/oaZxlossVTk5JjW7r9Mjd4mYtEbI2oU1hJ+kOKAN/fC+IXHONF/xCJxllKuKfbXfx5lLiUFi6LZSaPWJeHRmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BYgZucOL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768uOCQ017880;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=H+0giMFAS+mTekarU
	tx0aH73kVvW0P2ev/gvC84fsps=; b=BYgZucOLBFMDpecRTCqBNe7WZe36fwZKn
	s/3zxejdqxqd0AKJe5EQtyE55TBYLTQ/bzRI0IfWNdoZoLFLpM/RxS2LvofSoy2q
	OYQwe4enEJxYgMkxoOl6zdB/6HaSmqMGfxlVN518iqoT+gyIjpCRAN5bsnW5+4nf
	b8hF4UuIyYgno9Hy+3Xmy3jVO0M0bKVu5Rfdg8DD0ZoYYFAklWUGe4uFcU/uifUe
	UruOJTEPdU7V1JUgD7D6PzNOg8Xnzmq4q55fFD0c0nJv11Ms2jUzJIUs0trmsxSi
	28kB4xuynu+HjgBN3eWTWz8HlFdy0sxSbGeQI8rlQKfU+YLYyPRvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63519u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FZNbR012466;
	Wed, 6 Aug 2025 15:41:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63519n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CLlqG022661;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqc8nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNvm51708388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 146FF2004D;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09DE20043;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A89CAE12A6; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 09/17] net/dibs: Define dibs loopback
Date: Wed,  6 Aug 2025 17:41:14 +0200
Message-ID: <20250806154122.3413330-10-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfXyWvVkQffN0gf
 9KPbseQwMFcEaULxrn17QJNdCPQ5hTxZ53e6IHyjCHKK5YuyWE9znOUULHB/w5NdCVfDrxidHFD
 Ulg+c7RZAh/KeKMZoKCRK5ixjJRgJvXXhx8YBC32dZ4iPr2c1V0wen2EP/MSLj0vaIrSYsJJ+aH
 G3yVcZuTIExgeXQj/8KpW6bG1RQ2Zvw1Crv9O185Jw2yxjSN5AtXGNvhtBj0NnT+wX9ZeSgKyZY
 +UDncIrrKjCG4aAnEX8Qjgp2COBp+z1GJhBaq/qt5vXSSl6oYftQQFBagmPbOGdGRsQz5Qh10B0
 pAyFs1/SRkePTpc82iPQK71Ypvi8VZMz1Bz1RGjAfIFLBInyfQ4t3FONdIvqW+NUoJ5l2Vd58Z8
 LNsY2qD2gQ5A/GpE0edMR+cXBSXWIYp/UmO1/rmrAbUHEu4/99V3fNSWi6kTbr68Sc46sy3N
X-Proofpoint-GUID: effSYh5RL-nG1rAJB6RwgiabhY6cDRBX
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=l2lI7CjW9fdM60nPdvYA:9
X-Proofpoint-ORIG-GUID: 2IeQX4JxzG3yUiiBFCkeQyL6GKx_QqwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

The first stage of loopback-ism was implemented as part of the
SMC module [1]. Now that we have the dibs layer, provide access to a
dibs_loopback device to all dibs clients.

This is the first step of moving loopback-ism from net/smc/smc_loopback.*
to net/dibs/dibs_loopback.*. One global structure lo_dev is allocated
and added to the dibs devices. Follow-on patches will move functionality.

Same as smc_loopback, dibs_loopback is provided by a config option.
Note that there is no way to dynamically add or remove the loopback
device. That could be a future improvement.

When moving code to net/dibs, replace ism_ prefix with dibs_ prefix.
As this is mostly a move of existing code, copyright and authors are
unchanged.

Link: https://lore.kernel.org/lkml/20240428060738.60843-1-guwen@linux.alibaba.com/ [1]

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/dibs/Kconfig         | 13 +++++++
 net/dibs/Makefile        |  1 +
 net/dibs/dibs_loopback.c | 77 ++++++++++++++++++++++++++++++++++++++++
 net/dibs/dibs_loopback.h | 38 ++++++++++++++++++++
 net/dibs/dibs_main.c     | 14 ++++++--
 5 files changed, 141 insertions(+), 2 deletions(-)
 create mode 100644 net/dibs/dibs_loopback.c
 create mode 100644 net/dibs/dibs_loopback.h

diff --git a/net/dibs/Kconfig b/net/dibs/Kconfig
index 968c52938708..9a6182391b25 100644
--- a/net/dibs/Kconfig
+++ b/net/dibs/Kconfig
@@ -12,3 +12,16 @@ config DIBS
 
 	  To compile as a module choose M. The module name is dibs.
 	  If unsure, choose N.
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
+
+	  if unsure, say N.
diff --git a/net/dibs/Makefile b/net/dibs/Makefile
index 825dec431bfc..85805490c77f 100644
--- a/net/dibs/Makefile
+++ b/net/dibs/Makefile
@@ -5,3 +5,4 @@
 
 dibs-y += dibs_main.o
 obj-$(CONFIG_DIBS) += dibs.o
+dibs-$(CONFIG_DIBS_LO) += dibs_loopback.o
\ No newline at end of file
diff --git a/net/dibs/dibs_loopback.c b/net/dibs/dibs_loopback.c
new file mode 100644
index 000000000000..c221b55d24a2
--- /dev/null
+++ b/net/dibs/dibs_loopback.c
@@ -0,0 +1,77 @@
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
diff --git a/net/dibs/dibs_loopback.h b/net/dibs/dibs_loopback.h
new file mode 100644
index 000000000000..fd03b6333a24
--- /dev/null
+++ b/net/dibs/dibs_loopback.h
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
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
index 5345e41ae5e4..2c213e1f8f93 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/dibs.h>
 
+#include "dibs_loopback.h"
+
 MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
 MODULE_LICENSE("GPL");
 
@@ -94,15 +96,23 @@ EXPORT_SYMBOL_GPL(dibs_dev_del);
 
 static int __init dibs_init(void)
 {
+	int rc;
+
 	memset(clients, 0, sizeof(clients));
 	max_client = 0;
 
-	pr_info("module loaded\n");
-	return 0;
+	rc = dibs_loopback_init();
+	if (rc)
+		pr_err("%s fails with %d\n", __func__, rc);
+	else
+		pr_info("module loaded\n");
+
+	return rc;
 }
 
 static void __exit dibs_exit(void)
 {
+	dibs_loopback_exit();
 	pr_info("module unloaded\n");
 }
 
-- 
2.48.1


