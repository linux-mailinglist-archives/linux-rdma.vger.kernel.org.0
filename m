Return-Path: <linux-rdma+bounces-13126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E0B45B2B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E79A47174
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F792F7AAF;
	Fri,  5 Sep 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KlEWcCdZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CE36CDE2;
	Fri,  5 Sep 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084088; cv=none; b=qFSkTNRmC9P67SRDlHNAk5Em9Uyl7MC0+yzrUjR6g0P4/dTuoFd8E9NsI72uy3BGhanvRUqZLp+Li918uR9xGZxaqPGwqBbk5+xDo4rwD4LbTOHmqHbMJYWeLEbN4dX/jBmKLJEHVDtXfWDweR35Eaggt9KnTehf3lUwy0SLBSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084088; c=relaxed/simple;
	bh=F84rabfEpE3pA9vNCf1thQyj53SdcmdUQt3hmEKNEsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1ICPPZhwrjdlY3kkmfSlKkJn0RE/HAgi/3bih9PqTOmn0tuMoXxfjM7LcZnY02MIjRfc6O++cqW3LQQz7JrjKIUddzG/uYKEsnWs37ySSYhC/9Rtv0vufz7QUfiAdtC6mK/kJpD4Qk7OguX6lVJyvAVD8csw73GFcHhHVaF9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KlEWcCdZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58582679031738;
	Fri, 5 Sep 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8jZu2dT0LUqthCEJ/
	ZgVbvBJIGyiauEs4BhgYD6oUZI=; b=KlEWcCdZIpS8NNKtGxYD939I6CuJLk+L+
	LuWllhPxGHcTxVuOmdmLk+WTR6t2VTabNI0/8TKV1fez3TVeZSmtuirOKCTVT4HY
	XAbd1htq5rVZHJ3WgOJwFVC3oLuYq+yq2FgGxQRucLUX2mc2+82LFZcGOhjLo5kn
	koKLaBh+8o6KrkIU25vHSEPkJ1BKeT0QVBoXtOPxYr96fyNTA/hzHyMJcLNea+oJ
	Q2rdAyyrKzU6COi3S9zTfoJaPBGQQI2plPLd9Wq8rrIQ7x5AY7qVZ7aTQ9L4XXfm
	J3H1/9ICyTWhoIwzGd52OGLJhe2ahywTkb+k//TIqPKB4sArCiVNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswds98d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EmZqH002267;
	Fri, 5 Sep 2025 14:54:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswds984-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585Ca3OW021191;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmq1yst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSeb52953472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 967742004B;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81C4320040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 29D3CE1179; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
Subject: [PATCH net-next 06/14] net/dibs: Define dibs loopback
Date: Fri,  5 Sep 2025 16:54:19 +0200
Message-ID: <20250905145428.1962105-7-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68baf9aa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=0i72I1VtUECP_la-LOwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX86VMI8LwpO3V
 QwI7Tt+gpKtG10Thra14dD6uR66FrLUhmtEoS+HWNQ0p8w7n6kCfPSRKX/pDKHPCIFcJjp9HhbL
 optb4Mr5+pPXAD8eYdftZAvMSr9h5RESZS+y1eD5hEz8E5gQ4PjOkfRx5YNJMneW7eeFx92Yf7e
 m48f5wxzy4PKq5eQmjm+XqB7d27pNSpVNAc7CTp1Rpr4xGqeBkqiX4euW6qtyCeWeTKl2OuIo1j
 xWMgHmE863mEECje/C/wMBupQQwnzg94FqBe8IU5tOWT1u33qQvNyMIRUpbIN/dsStKB9fEOXMY
 f52Adu3Z/h132vmst1g3ufcYXQgvldOneZRQgTTpv82Pg7HrDw7ov4Zt62jZzaoMqwZU0yljsBI
 SLY9+/pN
X-Proofpoint-GUID: aIICQ0yHmrMfz0PIsrX4AB8dms1BU_85
X-Proofpoint-ORIG-GUID: Qb-nGN-zLbZSscvp-Tb1mRZt8CCgI28X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

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
 arch/s390/configs/debug_defconfig |  1 +
 arch/s390/configs/defconfig       |  1 +
 net/dibs/Kconfig                  | 11 +++++
 net/dibs/Makefile                 |  1 +
 net/dibs/dibs_loopback.c          | 78 +++++++++++++++++++++++++++++++
 net/dibs/dibs_loopback.h          | 38 +++++++++++++++
 net/dibs/dibs_main.c              | 11 ++++-
 7 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 net/dibs/dibs_loopback.c
 create mode 100644 net/dibs/dibs_loopback.h

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
diff --git a/net/dibs/Kconfig b/net/dibs/Kconfig
index 09c12f6838ad..5dc347b9b235 100644
--- a/net/dibs/Kconfig
+++ b/net/dibs/Kconfig
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
index 000000000000..225514a452a8
--- /dev/null
+++ b/net/dibs/dibs_loopback.c
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
index 2f420e077417..a7e33be36158 100644
--- a/net/dibs/dibs_main.c
+++ b/net/dibs/dibs_main.c
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


