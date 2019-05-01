Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D5A1072D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfEAKtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 06:49:25 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:46473 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfEAKtZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 06:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556707764; x=1588243764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rlkskBIyCkDJz+65z5+EqkXHhPCo2nLcpvDxmbUToAQ=;
  b=f6nMfgQ1OsYW9O3J7FhtfCK5m3leMT2GES1vlUftuSrpB+uNR07jTk4o
   GTqgc1pWzJ6vpMiaEu8M9dHabiFTVEAJ+96BCkhGZoO31p9haOdXE7GDk
   2MUBC7nLpE/TEc2pKA3tzYP5N1FeNcXkLpRRM95uETfOtblzR04ZofaNx
   k=;
X-IronPort-AV: E=Sophos;i="5.60,417,1549929600"; 
   d="scan'208";a="802280111"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 01 May 2019 10:49:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x41AnL3M088321
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 1 May 2019 10:49:21 GMT
Received: from EX13D04UWB002.ant.amazon.com (10.43.161.133) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:49:21 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D04UWB002.ant.amazon.com (10.43.161.133) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 1 May 2019 10:49:21 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.21) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 1 May 2019 10:49:17 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next v6 12/12] RDMA/efa: Add driver to Kconfig/Makefile
Date:   Wed, 1 May 2019 13:48:24 +0300
Message-ID: <1556707704-11192-13-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556707704-11192-1-git-send-email-galpress@amazon.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add EFA Makefile and Kconfig.

Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
---
 MAINTAINERS                        |  9 +++++++++
 drivers/infiniband/Kconfig         |  1 +
 drivers/infiniband/hw/Makefile     |  1 +
 drivers/infiniband/hw/efa/Kconfig  | 15 +++++++++++++++
 drivers/infiniband/hw/efa/Makefile |  9 +++++++++
 5 files changed, 35 insertions(+)
 create mode 100644 drivers/infiniband/hw/efa/Kconfig
 create mode 100644 drivers/infiniband/hw/efa/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index da2cd7265fb2..a868d8ce1437 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -744,6 +744,15 @@ S:	Supported
 F:	Documentation/networking/device_drivers/amazon/ena.txt
 F:	drivers/net/ethernet/amazon/
 
+AMAZON RDMA EFA DRIVER
+M:	Gal Pressman <galpress@amazon.com>
+R:	Yossi Leybovich <sleybo@amazon.com>
+L:	linux-rdma@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-rdma/list/
+S:	Supported
+F:	drivers/infiniband/hw/efa/
+F:	include/uapi/rdma/efa-abi.h
+
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 M:	Gary Hook <gary.hook@amd.com>
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a1fb840de45d..e549be36dffe 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -94,6 +94,7 @@ source "drivers/infiniband/hw/mthca/Kconfig"
 source "drivers/infiniband/hw/qib/Kconfig"
 source "drivers/infiniband/hw/cxgb3/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
+source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/i40iw/Kconfig"
 source "drivers/infiniband/hw/mlx4/Kconfig"
 source "drivers/infiniband/hw/mlx5/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index e4f31c1be8f7..77094be1b262 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_INFINIBAND_MTHCA)		+= mthca/
 obj-$(CONFIG_INFINIBAND_QIB)		+= qib/
 obj-$(CONFIG_INFINIBAND_CXGB3)		+= cxgb3/
 obj-$(CONFIG_INFINIBAND_CXGB4)		+= cxgb4/
+obj-$(CONFIG_INFINIBAND_EFA)		+= efa/
 obj-$(CONFIG_INFINIBAND_I40IW)		+= i40iw/
 obj-$(CONFIG_MLX4_INFINIBAND)		+= mlx4/
 obj-$(CONFIG_MLX5_INFINIBAND)		+= mlx5/
diff --git a/drivers/infiniband/hw/efa/Kconfig b/drivers/infiniband/hw/efa/Kconfig
new file mode 100644
index 000000000000..457e18ba1d57
--- /dev/null
+++ b/drivers/infiniband/hw/efa/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+# Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+#
+# Amazon fabric device configuration
+#
+
+config INFINIBAND_EFA
+	tristate "Amazon Elastic Fabric Adapter (EFA) support"
+	depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
+	depends on INFINIBAND_USER_ACCESS
+	help
+	  This driver supports Amazon Elastic Fabric Adapter (EFA).
+
+	  To compile this driver as a module, choose M here.
+	  The module will be called efa.
diff --git a/drivers/infiniband/hw/efa/Makefile b/drivers/infiniband/hw/efa/Makefile
new file mode 100644
index 000000000000..6e83083af0bc
--- /dev/null
+++ b/drivers/infiniband/hw/efa/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+# Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+#
+# Makefile for Amazon Elastic Fabric Adapter (EFA) device driver.
+#
+
+obj-$(CONFIG_INFINIBAND_EFA) += efa.o
+
+efa-y := efa_com_cmd.o efa_com.o efa_main.o efa_verbs.o
-- 
2.7.4

