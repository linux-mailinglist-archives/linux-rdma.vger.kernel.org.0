Return-Path: <linux-rdma+bounces-13286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C2B53C90
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320F43B7995
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71402362094;
	Thu, 11 Sep 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LU1moVWt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AD329F05;
	Thu, 11 Sep 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620128; cv=none; b=M4g7cpELdY0TZZxpJECi/O4fKbGVNc70u8b6ME0SuocKifESBxB5LWFY5iVp9UBFJ0nnPXRbvbxp25ZDnqnFiy/ollGbWo/t4pP1t2btavjL4SCp+cCxbfEAHhm4NZTatEMiXzHk9zUbDpKdIeiO30QqZ3zHwV0YsjvrO8AffeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620128; c=relaxed/simple;
	bh=WvXW7yP0N7m/i7/hPpcAFNJCw+Ex6EX+u815WTu5bs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJV1IdvSWkJK009d8u1kA64vvFffRN0S495l3ntxO9ak73KieqFgtaOtM4RyEc0ploaHeAniTKWuNhPzWmuiRfHTRrApAQSqb6ya4/FsTKnBpU7Pr75/p1E3Yzq95fS/I5Dhqa22pmTbAgPHHlG2wglyKcgkPjTWGLSwYRebxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LU1moVWt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BEBoAi024558;
	Thu, 11 Sep 2025 19:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BAs+VWc1ge4P3WSHA
	UJ4kVpWCWtEnFIjUpW9wk4XH9A=; b=LU1moVWtUXB63uEaaBqRvPOBDtriPqhrS
	7cNQdunvMf5BPc7OY4r8y63K1xvAUL44Pau/fu2oRTaupsAM5UhBjt4XL8eILDCn
	uwHGAw/aZ2+gT6c8qZfCqiU5XTdmIN6lr/c0viu7bAroMbcziG9qLpEXIkztphLT
	QeBukxCnV1f/KvPHRV3eiTzN2QGYxRRfmW6YUntGdBznknQyl7DxLMcHSBXmjFS5
	vlLdyA8vGgqwlobAftWAC8VWPKYkaH6zvVxZcLDLMXcw+f1vE6gfAeZVEizn80Ry
	qnB1kU36IDDCRjwcdNdFdQ9DyJz+D6FzhEaHEkhE1vbMntgHMZNfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx70bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BJkB0a021570;
	Thu, 11 Sep 2025 19:48:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx70bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGYt89020492;
	Thu, 11 Sep 2025 19:48:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp17myt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 19:48:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BJmSkI48890132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 19:48:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA55F2004B;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D289D20043;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 19:48:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id AA647E12D5; Thu, 11 Sep 2025 21:48:27 +0200 (CEST)
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
Subject: [PATCH net-next v2 03/14] dibs: Create drivers/dibs
Date: Thu, 11 Sep 2025 21:48:16 +0200
Message-ID: <20250911194827.844125-4-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: 7YQbz-B2IB8JCBZlzVUoJSHWyT_TkKPV
X-Proofpoint-ORIG-GUID: yYGFfty-mgjpYB3vHnhMDQ1bjnnfhQoj
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c32792 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=MnbvIMOYAAAA:8
 a=xsEuQG0pSSLqzmWC_KQA:9 a=nIhNrWrp-4j-7tTyx4uX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxtTo0Sij8E7E
 UVzpX2i411w8bFGkMLiwJqw+bJjoaxB5qUDGNPvNkjZibHwQYx+ZPapW1ydNFneVHqWX8eHQJ0C
 3VHWzQqabmNOGHkh1LMwDSkX7WWWgvhZJjmoESHtzQsbY/8ZXUtFxa+ztA7LLgXV6TqOEtf4KXN
 Rq9JcQZ9vlgSUw5yx6BmglmrtT319kH6x40rA4QsuTm5v6yQFBELNm41aqjxabYjXSBlikE+av7
 IXT1J2BjTqp4YTVUIBWkGx8a59V7xPogCVezUA0TRZ3eltE0OaUxeSaTz465AV/BAa7LpxkA+U3
 rIiPePDlmYXNpOfr5dKhufmdp23CJT64YG/peEdwS7R0F0Bw3W7nmuyDGLQceiGx+1rnRL8OBSO
 /9TYdIkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

Create the file structure for a 'DIBS - Direct Internal Buffer Sharing'
shim layer that will provide generic functionality and declarations for
dibs device drivers and dibs clients.

Following patches will add functionality.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 MAINTAINERS              |  7 +++++++
 drivers/Makefile         |  1 +
 drivers/dibs/Kconfig     | 12 ++++++++++++
 drivers/dibs/Makefile    |  7 +++++++
 drivers/dibs/dibs_main.c | 37 +++++++++++++++++++++++++++++++++++
 include/linux/dibs.h     | 42 ++++++++++++++++++++++++++++++++++++++++
 net/Kconfig              |  1 +
 7 files changed, 107 insertions(+)
 create mode 100644 drivers/dibs/Kconfig
 create mode 100644 drivers/dibs/Makefile
 create mode 100644 drivers/dibs/dibs_main.c
 create mode 100644 include/linux/dibs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e3907f0c1243..f2a266fbd611 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7134,6 +7134,13 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-gpio-mm.c
 
+DIBS (DIRECT INTERNAL BUFFER SHARING)
+M:	Alexandra Winter <wintera@linux.ibm.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/dibs/
+F:	include/linux/dibs.h
+
 DIGITEQ AUTOMOTIVE MGB4 V4L2 DRIVER
 M:	Martin Tuma <martin.tuma@digiteqautomotive.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/Makefile b/drivers/Makefile
index b5749cf67044..a104163b1353 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,4 +195,5 @@ obj-$(CONFIG_DRM_ACCEL)		+= accel/
 obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
 
+obj-$(CONFIG_DIBS)		+= dibs/
 obj-$(CONFIG_S390)		+= s390/
diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
new file mode 100644
index 000000000000..09c12f6838ad
--- /dev/null
+++ b/drivers/dibs/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+config DIBS
+	tristate "DIBS support"
+	default n
+	help
+	  Direct Internal Buffer Sharing (DIBS)
+	  A communication method that uses common physical (internal) memory
+	  for synchronous direct access into a remote buffer.
+
+	  Select this option to provide the abstraction layer between
+	  dibs devices and dibs clients like the SMC protocol.
+	  The module name is dibs.
diff --git a/drivers/dibs/Makefile b/drivers/dibs/Makefile
new file mode 100644
index 000000000000..825dec431bfc
--- /dev/null
+++ b/drivers/dibs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# DIBS class module
+#
+
+dibs-y += dibs_main.o
+obj-$(CONFIG_DIBS) += dibs.o
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
new file mode 100644
index 000000000000..68e189932fcf
--- /dev/null
+++ b/drivers/dibs/dibs_main.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  DIBS - Direct Internal Buffer Sharing
+ *
+ *  Implementation of the DIBS class module
+ *
+ *  Copyright IBM Corp. 2025
+ */
+#define KMSG_COMPONENT "dibs"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/dibs.h>
+
+MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
+MODULE_LICENSE("GPL");
+
+/* use an array rather a list for fast mapping: */
+static struct dibs_client *clients[MAX_DIBS_CLIENTS];
+static u8 max_client;
+
+static int __init dibs_init(void)
+{
+	memset(clients, 0, sizeof(clients));
+	max_client = 0;
+
+	return 0;
+}
+
+static void __exit dibs_exit(void)
+{
+}
+
+module_init(dibs_init);
+module_exit(dibs_exit);
diff --git a/include/linux/dibs.h b/include/linux/dibs.h
new file mode 100644
index 000000000000..3f4175aaa732
--- /dev/null
+++ b/include/linux/dibs.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Direct Internal Buffer Sharing
+ *
+ *  Definitions for the DIBS module
+ *
+ *  Copyright IBM Corp. 2025
+ */
+#ifndef _DIBS_H
+#define _DIBS_H
+
+/* DIBS - Direct Internal Buffer Sharing - concept
+ * -----------------------------------------------
+ * In the case of multiple system sharing the same hardware, dibs fabrics can
+ * provide dibs devices to these systems. The systems use dibs devices of the
+ * same fabric to communicate via dmbs (Direct Memory Buffers). Each dmb has
+ * exactly one owning local dibs device and one remote using dibs device, that
+ * is authorized to write into this dmb. This access control is provided by the
+ * dibs fabric.
+ *
+ * Because the access to the dmb is based on access to physical memory, it is
+ * lossless and synchronous. The remote devices can directly access any offset
+ * of the dmb.
+ *
+ * Dibs fabrics, dibs devices and dmbs are identified by tokens and ids.
+ * Dibs fabric id is unique within the same hardware (with the exception of the
+ * dibs loopback fabric), dmb token is unique within the same fabric, dibs
+ * device gids are guaranteed to be unique within the same fabric and
+ * statistically likely to be globally unique. The exchange of these tokens and
+ * ids between the systems is not part of the dibs concept.
+ *
+ * The dibs layer provides an abstraction between dibs device drivers and dibs
+ * clients.
+ */
+
+#define MAX_DIBS_CLIENTS	8
+
+struct dibs_client {
+	const char *name;
+};
+
+#endif	/* _DIBS_H */
diff --git a/net/Kconfig b/net/Kconfig
index d5865cf19799..f370f8f196f6 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -87,6 +87,7 @@ source "net/tls/Kconfig"
 source "net/xfrm/Kconfig"
 source "net/iucv/Kconfig"
 source "net/smc/Kconfig"
+source "drivers/dibs/Kconfig"
 source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
-- 
2.48.1


