Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89745FC0
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 16:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFNN6H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:58:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728621AbfFNN6F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EDohFP008993
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t4b9aca1t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 14 Jun 2019 14:57:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 14:57:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EDvtcJ28508334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 13:57:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 999BB4204B;
        Fri, 14 Jun 2019 13:57:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76DCD42047;
        Fri, 14 Jun 2019 13:57:55 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 13:57:55 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 11/11] SIW addition to kernel build environment
Date:   Fri, 14 Jun 2019 15:57:50 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190614135750.15874-1-bmt@zurich.ibm.com>
References: <20190614135750.15874-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061413-0008-0000-0000-000002F3C674
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061413-0009-0000-0000-00002260D0FF
Message-Id: <20190614135750.15874-12-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140118
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
 drivers/infiniband/sw/siw/Makefile | 11 +++++++++++
 5 files changed, 37 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/Kconfig
 create mode 100644 drivers/infiniband/sw/siw/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..91b9a94081b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14545,6 +14545,13 @@ M:	Chris Boot <bootc@bootc.net>
 S:	Maintained
 F:	drivers/leds/leds-net48xx.c
 
+SOFT-IWARP DRIVER (siw)
+M:	Bernard Metzler <bmt@zurich.ibm.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/sw/siw/
+F:	include/uapi/rdma/siw-abi.h
+
 SOFT-ROCE DRIVER (rxe)
 M:	Moni Shoua <monis@mellanox.com>
 L:	linux-rdma@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cbaafa4e0302..32242b807aad 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -96,6 +96,7 @@ source "drivers/infiniband/hw/hfi1/Kconfig"
 source "drivers/infiniband/hw/qedr/Kconfig"
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
+source "drivers/infiniband/sw/siw/Kconfig"
 endif
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
diff --git a/drivers/infiniband/sw/Makefile b/drivers/infiniband/sw/Makefile
index 8b095b27db87..6a0bb877f914 100644
--- a/drivers/infiniband/sw/Makefile
+++ b/drivers/infiniband/sw/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_INFINIBAND_RDMAVT)		+= rdmavt/
 obj-$(CONFIG_RDMA_RXE)			+= rxe/
+obj-$(CONFIG_RDMA_RXE)			+= siw/
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
index 000000000000..f5f7e3867889
--- /dev/null
+++ b/drivers/infiniband/sw/siw/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_RDMA_SIW) += siw.o
+
+siw-y := \
+	siw_cm.o \
+	siw_cq.o \
+	siw_main.o \
+	siw_mem.o \
+	siw_qp.o \
+	siw_qp_tx.o \
+	siw_qp_rx.o \
+	siw_verbs.o
-- 
2.17.2

