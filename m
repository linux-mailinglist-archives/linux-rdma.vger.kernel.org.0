Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B552A97A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 13:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfEZLmy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 May 2019 07:42:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727638AbfEZLmy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 May 2019 07:42:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4QBgqCC114433
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 07:42:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sqk0gapt4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 07:42:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Sun, 26 May 2019 12:42:30 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 May 2019 12:42:29 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4QBgSUe46006284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 May 2019 11:42:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77BEEA4054;
        Sun, 26 May 2019 11:42:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5463BA405B;
        Sun, 26 May 2019 11:42:28 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 May 2019 11:42:28 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next v1 12/12] SIW addition to kernel build environment
Date:   Sun, 26 May 2019 13:41:56 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190526114156.6827-1-bmt@zurich.ibm.com>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052611-0016-0000-0000-0000027F9505
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052611-0017-0000-0000-000032DC9624
Message-Id: <20190526114156.6827-13-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905260084
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 MAINTAINERS                        |  7 +++++++
 drivers/infiniband/Kconfig         |  1 +
 drivers/infiniband/sw/Makefile     |  1 +
 drivers/infiniband/sw/siw/Kconfig  | 17 +++++++++++++++++
 drivers/infiniband/sw/siw/Makefile | 12 ++++++++++++
 5 files changed, 38 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/Kconfig
 create mode 100644 drivers/infiniband/sw/siw/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..3b437abffc39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14545,6 +14545,13 @@ M:	Chris Boot <bootc@bootc.net>
 S:	Maintained
 F:	drivers/leds/leds-net48xx.c
 
+SOFT-RDMA DRIVER (siw)
+M:	Bernard Metzler (bmt@zurich,ibm.com)
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/sw/rxe/
+F:	include/uapi/rdma/siw-abi.h
+
 SOFT-ROCE DRIVER (rxe)
 M:	Moni Shoua <monis@mellanox.com>
 L:	linux-rdma@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cbfbea49f126..2013ef848fd1 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -107,6 +107,7 @@ source "drivers/infiniband/hw/hfi1/Kconfig"
 source "drivers/infiniband/hw/qedr/Kconfig"
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
+source "drivers/infiniband/sw/siw/Kconfig"
 endif
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
diff --git a/drivers/infiniband/sw/Makefile b/drivers/infiniband/sw/Makefile
index 8b095b27db87..d37610fcbbc7 100644
--- a/drivers/infiniband/sw/Makefile
+++ b/drivers/infiniband/sw/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_INFINIBAND_RDMAVT)		+= rdmavt/
 obj-$(CONFIG_RDMA_RXE)			+= rxe/
+obj-$(CONFIG_RDMA_SIW)			+= siw/
diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
new file mode 100644
index 000000000000..94f684174ce3
--- /dev/null
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -0,0 +1,17 @@
+config RDMA_SIW
+	tristate "Software RDMA over TCP/IP (iWARP) driver"
+	depends on INET && INFINIBAND && CRYPTO_CRC32
+	help
+	This driver implements the iWARP RDMA transport over
+	the Linux TCP/IP network stack. It enables a system with a
+	standard Ethernet adapter to interoperate with a iWARP
+	adapter or with another system running the SIW driver.
+	(See also RXE which is a similar software driver for RoCE.)
+
+	The driver interfaces with the Linux RDMA stack and
+	implements both a kernel and user space RDMA verbs API.
+	The user space verbs API requires a support
+	library named libsiw which is loaded by the generic user
+	space verbs API, libibverbs. To implement RDMA over
+	TCP/IP, the driver further interfaces with the Linux
+	in-kernel TCP socket layer.
diff --git a/drivers/infiniband/sw/siw/Makefile b/drivers/infiniband/sw/siw/Makefile
new file mode 100644
index 000000000000..ff190cb0d254
--- /dev/null
+++ b/drivers/infiniband/sw/siw/Makefile
@@ -0,0 +1,12 @@
+obj-$(CONFIG_RDMA_SIW) += siw.o
+
+siw-y := \
+	siw_cm.o \
+	siw_cq.o \
+	siw_debug.o \
+	siw_main.o \
+	siw_mem.o \
+	siw_qp.o \
+	siw_qp_tx.o \
+	siw_qp_rx.o \
+	siw_verbs.o
-- 
2.17.2

