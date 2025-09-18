Return-Path: <linux-rdma+bounces-13485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BEAB8445B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1611C00422
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77596303A30;
	Thu, 18 Sep 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ImhtC8yX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA30302174;
	Thu, 18 Sep 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193536; cv=none; b=pKYo8cNMzrLqqifLtv2/pUIq4DuGSI5OI+TdIWHffNJ20agTJNZfWksJKP4HeGjJa7Dg+GHdQR+QZZ1CZLxZgxvrjvMFc2b8Dj+kIOVbT5K/KJGMIkcXUgP/VeLlGncGBOLK4kEO21h7W0kYvNnkmJa9kruczS0/c7F9ylEY5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193536; c=relaxed/simple;
	bh=lIUtMxXYhtZ0MLeH5oXFakyVi29q6EpWVrdNej9qhP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyjNVqpU79icMi2KY+1WU58sniCPSQ8Q0X9xJI6PSNxGUdriytEEaXEWZCE61OKyRWNU5jmGdqM2Q7H8oAwhn+A90xEAfSiyhc9V1IbkMz3iZCyGUPNsAUxxtWUPWi7wzcxfnH9EZBSBnowsMMM/A7i0pb+khKyZVdBc+S+NRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ImhtC8yX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5sDQE011459;
	Thu, 18 Sep 2025 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8GLROcu6jW83b/88H
	mIwXi6Ii49zLsXun6TgfRrZNBc=; b=ImhtC8yX8Dmd3ucaftfDqXTdvf6S7/nsB
	Zc3a195tHp+41hpCRFf8xj1pFJEmTXTr+IGm8jUYPANwZ14rHOB65IRYKSozdD4J
	zGg7xhNrAqAQHVDfLRccW3baYpa1oPJlpWVidT7Wt4dpOPEUOOd1G53t6/fdoT/W
	+zzL2jk4uH4U7/gWyVjpKSNwiz7xUqUdNSKKEBjoGBv5HfJIEdlHQB1nwF+5iDL0
	6Z/Zd7aHABgQ12T8DJG7ynAo24+dcrRiDLc8rEfGEwcmOs8mFvT3TL58X2hHLIrd
	d3CRNOJlJLDFgt1ibGI9dMs1J+G18rRDO8Up4tAl1KJ1PtHvHGCRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j9skg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB34GT028485;
	Thu, 18 Sep 2025 11:05:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4j9ska-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAKC7u027268;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495mene6em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB51Op43712780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F000A20040;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D868D2004E;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id AB237E14CB; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
Subject: [PATCH net-next v3 03/14] dibs: Create drivers/dibs
Date: Thu, 18 Sep 2025 13:04:49 +0200
Message-ID: <20250918110500.1731261-4-wintera@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Qf5mvtbv c=1 sm=1 tr=0 ts=68cbe763 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=MnbvIMOYAAAA:8
 a=xsEuQG0pSSLqzmWC_KQA:9 a=nIhNrWrp-4j-7tTyx4uX:22
X-Proofpoint-ORIG-GUID: igHH_WkB7MnKph6fIp9Zk8cgw67W-ScX
X-Proofpoint-GUID: v3udZRTICxeOit12zOguZDwHgrP2-4en
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX343cBxkmdgQ/
 hzuH5l6H31ecvvloZbYk81bwnjCC5mHi/Elo253L7ehurs/ONDawkcyCq05sV6qDOkITDU79jem
 N8zEr9abQ6UfbS6YGBPN/+qBW3ED3uqanWgRc6CU0Feq35BUTqeBbM4QMr2+xD9YQe0F8267kpq
 w8Kz7G65hVNsS3nPyiJb8x6agOaybOts1+L1VlXnwWZFUaN5kh4CxFnY267yhyO0tUz9zQczemf
 g0a20DMLo8hItedito5z9pISWvQNYe2IqcsWLu5ZYVEsOdFYhIp/aQf8rcdaJic8eYw9c9+prmp
 Fag+PexUE+cxEIxZHd847QKxPJ/7uH4W4CPX4UatdfvEFhwNEboW578G6UwVuzc3Y0vJEjPM/kU
 yODBJNMt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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
index 47bc35743f22..10d3ccebaa73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7132,6 +7132,13 @@ L:	linux-gpio@vger.kernel.org
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


