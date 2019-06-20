Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8D4D396
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbfFTQVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:21:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732179AbfFTQVx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:21:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KGJTUr145931
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 12:21:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8amn8yjc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 12:21:52 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Thu, 20 Jun 2019 17:21:50 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 17:21:48 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KGLl0L61014220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 16:21:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C4E911C04C;
        Thu, 20 Jun 2019 16:21:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39D9C11C052;
        Thu, 20 Jun 2019 16:21:47 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 16:21:47 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v3 11/11] SIW addition to kernel build environment
Date:   Thu, 20 Jun 2019 18:21:33 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620162133.13074-1-bmt@zurich.ibm.com>
References: <20190620162133.13074-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062016-0028-0000-0000-0000037C17EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062016-0029-0000-0000-0000243C2B33
Message-Id: <20190620162133.13074-12-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200119
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
index 9ac03f3e3bd5..bf275e142232 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14537,6 +14537,13 @@ M:	Chris Boot <bootc@bootc.net>
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
index 0fe6f76e8fdc..979547c54ab8 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -95,6 +95,7 @@ source "drivers/infiniband/hw/hfi1/Kconfig"
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

