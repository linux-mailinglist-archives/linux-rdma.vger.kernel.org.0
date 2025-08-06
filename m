Return-Path: <linux-rdma+bounces-12609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57355B1C8F8
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E257AA6F8
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDAB29CB53;
	Wed,  6 Aug 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OwSMSDd5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8029ACDE;
	Wed,  6 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494904; cv=none; b=hLh8nxXEkNPYQFUL7WqlvCbQsTZtounKUKvOdtGXvIz2dZK/SYC7+pOkiU+0OHHIXJqo61NSU6Br9tRwbnhOL6HvyAEZPn65ygyb9Sl+n0wHtMiItNRXz68I9mDj2cMR4gV9LkS4JhvBIK1soEW+w1mzZ7Tjez13OskzPAh58Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494904; c=relaxed/simple;
	bh=D6mFJ5asbi699g9mUKiKSDEQzJ+qjeI4PeDmfs0SwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kma2io3PpXUIstyBtzPEUW2gHUYIxc/DXvRRda1azXglwD4TFmos8RLntznPSf3GsHfeZg3C5KIAXJINu7Nog39pE7oqOelespfxbRelgPtSTsffYQYeGJDHyZz/EKLqxhBbW7Puv2i9ikVRhTmLfzmjWSJ4c/0y3SIet7YsIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OwSMSDd5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5767nXgN028370;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bcR8opYOUnPu6Imq3
	VpZ5mjjDKrC2ghbQKuw9RxNdQA=; b=OwSMSDd5Rgt2oM2a60k5+LhDLU8Kvk/Gx
	m2BASSV5l+6KfKhzusqzhu3wBwARpDRBP6lqmJOqIn9dBtHDi6LX6UcWRXUY8VDB
	c8Yz8J2D+Rhy3le8K7mtI8XK30W51KldlACV8yE3XfGsAJNT1YvFDoKgJxXX8Txx
	h/YB3uGhy8xfhUtt586ISNXh2VFoE0E7YcCO09LBivcQPKcmh36H9diuN7WB4vKx
	CqiYMS4vEoLe/CE3l+2BnXvZaCyOKVlBjwmVI/YRr7wWFz449YqvL1F/QKg+VTIA
	7JGdnriJjSY9J0EJAo2+inExFOiUJL5HctAUtJL+5aXD0ZD2WqgEQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60w493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FXgtp019252;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq60w48x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CDpsH001574;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqv8k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNKM52691422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1725D2004F;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010192004B;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 9F841E128B; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 06/17] net/dibs: Create net/dibs
Date: Wed,  6 Aug 2025 17:41:11 +0200
Message-ID: <20250806154122.3413330-7-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: 2ugF9Qg7G5FVowzDaFPUHv9fp9Sf-0ga
X-Proofpoint-ORIG-GUID: HLcm0Xjnd9S7HLquM4kJe2l6FjJMDL-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX0ImEGZxpk2TC
 WlBe5nFo/lXmxPIEOjT2ZyS3F18zqfPPe16kKRqMvkYrohNPVtPTt4klEBc+5mEGHtFC+jdZu9U
 7lgt6S6THPz8O4oYySSLJ16HMTWDd989Z2mJNQm4PIEv3oZJRavWEP8DCUsVizaZmQkntep0F7r
 eXi8GqJvGxjWmLuSzs1XHczIEFJlisuP8g6wIC9IQLyA7bGFGgHWIQSndmd+BTTACBiAoBnLheg
 IX4GzKUG+GfPBwc7hCr8oRH+O7bjoTtfS9lDwXmWF/V4aku0Z49DBO6JccU5UHlnsAwmuwbAHwk
 Ad2/5SJJpbEHJKnM4psHM7CLCNbWegj1iFuo7bEyEqWv4f8wOfBi3o/H2oC7b8WLpW9fpIuIDeV
 +FvH9rvcTusf0OaOD7Na9ESwRqDXjfIafpcp97qZotLDoAQkmxIQU4erP9BtHjlqCE4v7Kfb
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=xsEuQG0pSSLqzmWC_KQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=782 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

Create an 'DIBS' shim layer that will provide generic functionality and
declarations for dibs device drivers and dibs clients.

Following patches will add functionality.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 MAINTAINERS          |  7 +++++++
 include/linux/dibs.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 net/Kconfig          |  1 +
 net/Makefile         |  1 +
 net/dibs/Kconfig     | 14 ++++++++++++++
 net/dibs/Makefile    |  7 +++++++
 net/dibs/dibs_main.c | 39 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 111 insertions(+)
 create mode 100644 include/linux/dibs.h
 create mode 100644 net/dibs/Kconfig
 create mode 100644 net/dibs/Makefile
 create mode 100644 net/dibs/dibs_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b968bc6959d1..e28d92f64236 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12948,6 +12948,13 @@ F:	Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
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
index 000000000000..968c52938708
--- /dev/null
+++ b/net/dibs/Kconfig
@@ -0,0 +1,14 @@
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
+
+	  To compile as a module choose M. The module name is dibs.
+	  If unsure, choose N.
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
index 000000000000..348242fd05dd
--- /dev/null
+++ b/net/dibs/dibs_main.c
@@ -0,0 +1,39 @@
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
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void __exit dibs_exit(void)
+{
+	pr_info("module unloaded\n");
+}
+
+module_init(dibs_init);
+module_exit(dibs_exit);
-- 
2.48.1


