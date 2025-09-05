Return-Path: <linux-rdma+bounces-13120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94AB45B13
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC501777C5
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A237C0EB;
	Fri,  5 Sep 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V71S6tIU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504537426B;
	Fri,  5 Sep 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084086; cv=none; b=gscS5iJZH1GiAOJMi6EmLkJ57iGZTKFWr7FtQrP1W3QI/hODptn+cmcmXNk16xvrw6ZWd/mYOQKCAsMdc/2ZByJ04WWuZ1RHwFONHx3qloWGpiFykSqlNbzpFE8352vwezJI38qAXhdY7jEQ5peGCkoEcelorw4E/uAEKzHaIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084086; c=relaxed/simple;
	bh=9V3OZ322bL1BTgQi9jDQboxA+msHPUfe6/RY8b9biyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxjuuObhK/1A4i6jKbaI0d87xm0KNt1ro5foBGagjxrucV8xYYKvBHELQSjYuGt+FdqbbM8+Ykagjw2ch/ZTSUhQ2k4h6BdC2X/hoWb1kZ9+8aQDYvErQwu3S+mC7refj+VV5WxK9om7KLy04+P7jKJ92wZTBvQ/o+0rfjkY+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V71S6tIU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585924nB014694;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1UUf1Capi/J40Vfp4
	QA85ezgKIYNgZOSms/0R+qlV4o=; b=V71S6tIUuNo6XJas5Ch/C/ZsDCx1zlfkc
	PtvU2pxZs0rW1nmPdx4EluQ+8Saf/CJJqLEFjmy6+BUetnIxf06g3nZN9bxCebir
	7csTamaqVYFp7Z9r4YlOy5IzXqGaBKjO+7eB52YIIOTezVKCaKCysSiaqAb+Pog2
	0lLhTt/li7k11LQnvsl+NN9+Nk2ebQ2dcteVB97sTZS1ZTK8P5KuptAOJp5DOszf
	pDNIDogFlTHTL4LOKfcyX5uGhn3pQVE84PkNiZV0SctbeqTBbVw5IFp9uQei0ads
	vcNfacIU1VFPjj72NfzP4z2m4PdVAudXM4GD0UWUyeVznPp034AZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfcejn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585EmSTU017994;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshfcejd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585D07Xm019316;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n9tv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSET48955840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C2372004B;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BED20040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 20C14E113D; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
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
Subject: [PATCH net-next 03/14] net/dibs: Create net/dibs
Date: Fri,  5 Sep 2025 16:54:16 +0200
Message-ID: <20250905145428.1962105-4-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: JoQv64Yuq1kO69eSPgGgX7OaB6cf43Jp
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68baf9a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=xsEuQG0pSSLqzmWC_KQA:9
X-Proofpoint-ORIG-GUID: 10IBuEt5BBLoWotNXMJC75kAijs1shiB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfXxd7ilCvtOqLy
 DCOZJdD6gwuuf7Tuc7NevsBuc39gOvJOjC1AJdISPDzXFBPEoSP1fJRjiwmNN4NQohKj5lKjYXg
 nBkSmnT7Lkh8pbXEwX424h4khQsSx/v7cKfFyJq7LacHlJNY10bLRxbdonEWBijxssjeiDWIImP
 Vuctp79dj74yVvG0tT3fms1/+cMf8dF3haa6YQJgc7pa1Dg6AXHX8n927rW+IN7GU2If4Z7dSju
 5DhwIJibGPRsaV+PZ8S+FJS67vbzrjSfajZpiMWTOOQQWcbpOktdvwE/GPRZ9Yj1wUyNTWgwemD
 8ozD0kYWF9VPuHOl5wO846WQVNZOGAGWBWAkV3XQE1gVglKRo4q+Hruk3Exv0RuhLnG3nI7j0Ly
 cdeoJhX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

Create an 'DIBS' shim layer that will provide generic functionality and
declarations for dibs device drivers and dibs clients.

Following patches will add functionality.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 MAINTAINERS          |  7 +++++++
 include/linux/dibs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 net/Kconfig          |  1 +
 net/Makefile         |  1 +
 net/dibs/Kconfig     | 12 ++++++++++++
 net/dibs/Makefile    |  7 +++++++
 net/dibs/dibs_main.c | 37 +++++++++++++++++++++++++++++++++++++
 7 files changed, 107 insertions(+)
 create mode 100644 include/linux/dibs.h
 create mode 100644 net/dibs/Kconfig
 create mode 100644 net/dibs/Makefile
 create mode 100644 net/dibs/dibs_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea95..c621ed92eb0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13047,6 +13047,13 @@ F:	Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
 F:	Documentation/hwmon/isl28022.rst
 F:	drivers/hwmon/isl28022.c
 
+DIBS (DIRECT INTERNAL BUFFER SHARING)
+M:	Alexandra Winter <wintera@linux.ibm.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	include/linux/dibs.h
+F:	net/dibs/
+
 ISOFS FILESYSTEM
 M:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
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
index d5865cf19799..5410226f314b 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -87,6 +87,7 @@ source "net/tls/Kconfig"
 source "net/xfrm/Kconfig"
 source "net/iucv/Kconfig"
 source "net/smc/Kconfig"
+source "net/dibs/Kconfig"
 source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
diff --git a/net/Makefile b/net/Makefile
index aac960c41db6..3e4771cfe48e 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_TIPC)		+= tipc/
 obj-$(CONFIG_NETLABEL)		+= netlabel/
 obj-$(CONFIG_IUCV)		+= iucv/
 obj-$(CONFIG_SMC)		+= smc/
+obj-$(CONFIG_DIBS)		+= dibs/
 obj-$(CONFIG_RFKILL)		+= rfkill/
 obj-$(CONFIG_NET_9P)		+= 9p/
 obj-$(CONFIG_CAIF)		+= caif/
diff --git a/net/dibs/Kconfig b/net/dibs/Kconfig
new file mode 100644
index 000000000000..09c12f6838ad
--- /dev/null
+++ b/net/dibs/Kconfig
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
diff --git a/net/dibs/Makefile b/net/dibs/Makefile
new file mode 100644
index 000000000000..825dec431bfc
--- /dev/null
+++ b/net/dibs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# DIBS class module
+#
+
+dibs-y += dibs_main.o
+obj-$(CONFIG_DIBS) += dibs.o
diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
new file mode 100644
index 000000000000..68e189932fcf
--- /dev/null
+++ b/net/dibs/dibs_main.c
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
-- 
2.48.1


