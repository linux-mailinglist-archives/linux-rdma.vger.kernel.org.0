Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3C3BD17
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389099AbfFJTtP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 15:49:15 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37210 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbfFJTtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 15:49:15 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so3326165uaa.4
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91oHmaoT7ycnY+1e5HwqBS5NaVQbeIQ8yMG8ce2KIKY=;
        b=T2E+LtufWW2S6WO4yiYNKjmQMkWvl1VYKuzH5KyhjtVvVVqT8VvuzQQLfLLA9sKDZd
         GfGWrAn1aCCNJELTg1kpBILflGFXIQ00lpCoPArY+L4GHDKZ5PL6Z5gjFQ9v32TaHpbE
         tnHq8GEAkYjtV+yTxKg6Xqa7RTWQixc0bFxbOl1F+B5nCVWO/myluieIj3ykSLg5yd8O
         aBPlqQgA0AvxdzKOzefsG21uVITMowYLTn8StfOT61+sjEjBL3Aov2/h5+4v5mCQvrka
         NHku4jTq9uTlXPF0vfXLpkeSd+N7y0ZnSQujM9rMj949di6vfPirUKPPc+deBJyCIvoy
         FKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=91oHmaoT7ycnY+1e5HwqBS5NaVQbeIQ8yMG8ce2KIKY=;
        b=rBIyd03Kf7SuwmYmLeaa+4xC+gMWShWtFPjfF3qiwX7ZTwisQXlFguqjeO+0+GBv5W
         hX8QMOajWI7McJTALMbtZscgksQILggoSV4e9CiQ3R1kvRqKTVGTXVLe1mpIJvG0l7pK
         EyfnrRQXdJtmK8AYzzF+7tsKRHGgvbPJJmwtMkhM8O9ZZxf+iAQWYP+76YlGJ6d3udyH
         kFNsZTrtDjFV3S3WclQPYyLXe5PRdvyqUn3gWL66qT3i9l8kyitMpgJu1TFSVBLUJm6v
         u7+qxY1H6F+3+Xc/FzAL++V7cnvSPYuxmEVK1GIZ4O+JFWnkqCPrSA2BSJHbl1UWxP7U
         IsgQ==
X-Gm-Message-State: APjAAAWfR0WTpVYEcokY+rKT66e4Ub1l0BYqzmS63aE9EuqpFM+cqfDQ
        UbnQAEczm36puXnefkqvBOJR4ytC0PQzZw==
X-Google-Smtp-Source: APXvYqyOqCQ6IOwWKmk0Tv4kit/uPK2Pe/votbaF5hpinpZANi+kvjwkAgedKJ468IVWGJXkwFUdUw==
X-Received: by 2002:ab0:234e:: with SMTP id h14mr11013167uao.25.1560196154024;
        Mon, 10 Jun 2019 12:49:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x14sm3470597uae.16.2019.06.10.12.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 12:49:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haQI4-0004r8-UF; Mon, 10 Jun 2019 16:49:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Latif, Faisal" <faisal.latif@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH] rdma: Remove nes
Date:   Mon, 10 Jun 2019 16:49:11 -0300
Message-Id: <20190610194911.12427-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This driver was first merged over 10 years ago and has not seen major
activity by the authors in the last 7 years. However, in that time it has
been patched 150 times to adapt it to changing kernel APIs.

Further, the hardware has several issues, like not supporting 64 bit DMA,
that make it rather uninteresting for use with modern systems and RDMA.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .../ABI/stable/sysfs-class-infiniband         |   17 -
 MAINTAINERS                                   |    8 -
 drivers/infiniband/Kconfig                    |    1 -
 drivers/infiniband/hw/Makefile                |    1 -
 drivers/infiniband/hw/nes/Kconfig             |   15 -
 drivers/infiniband/hw/nes/Makefile            |    3 -
 drivers/infiniband/hw/nes/nes.c               | 1205 -----
 drivers/infiniband/hw/nes/nes.h               |  574 ---
 drivers/infiniband/hw/nes/nes_cm.c            | 3992 -----------------
 drivers/infiniband/hw/nes/nes_cm.h            |  470 --
 drivers/infiniband/hw/nes/nes_context.h       |  193 -
 drivers/infiniband/hw/nes/nes_hw.c            | 3887 ----------------
 drivers/infiniband/hw/nes/nes_hw.h            | 1380 ------
 drivers/infiniband/hw/nes/nes_mgt.c           | 1155 -----
 drivers/infiniband/hw/nes/nes_mgt.h           |   97 -
 drivers/infiniband/hw/nes/nes_nic.c           | 1870 --------
 drivers/infiniband/hw/nes/nes_utils.c         |  915 ----
 drivers/infiniband/hw/nes/nes_verbs.c         | 3754 ----------------
 drivers/infiniband/hw/nes/nes_verbs.h         |  198 -
 include/uapi/rdma/nes-abi.h                   |  115 -
 20 files changed, 19850 deletions(-)
 delete mode 100644 drivers/infiniband/hw/nes/Kconfig
 delete mode 100644 drivers/infiniband/hw/nes/Makefile
 delete mode 100644 drivers/infiniband/hw/nes/nes.c
 delete mode 100644 drivers/infiniband/hw/nes/nes.h
 delete mode 100644 drivers/infiniband/hw/nes/nes_cm.c
 delete mode 100644 drivers/infiniband/hw/nes/nes_cm.h
 delete mode 100644 drivers/infiniband/hw/nes/nes_context.h
 delete mode 100644 drivers/infiniband/hw/nes/nes_hw.c
 delete mode 100644 drivers/infiniband/hw/nes/nes_hw.h
 delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.c
 delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.h
 delete mode 100644 drivers/infiniband/hw/nes/nes_nic.c
 delete mode 100644 drivers/infiniband/hw/nes/nes_utils.c
 delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.c
 delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.h
 delete mode 100644 include/uapi/rdma/nes-abi.h

As discussed.

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 17211ceb9bf438..aed21b8916a25a 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -423,23 +423,6 @@ Description:
 		(e.g. driver restart on the VM which owns the VF).
 
 
-sysfs interface for NetEffect RNIC Low-Level iWARP driver (nes)
----------------------------------------------------------------
-
-What:		/sys/class/infiniband/nesX/hw_rev
-What:		/sys/class/infiniband/nesX/hca_type
-What:		/sys/class/infiniband/nesX/board_id
-Date:		Feb, 2008
-KernelVersion:	v2.6.25
-Contact:	linux-rdma@vger.kernel.org
-Description:
-		hw_rev:		(RO) Hardware revision number
-
-		hca_type:	(RO) Host Channel Adapter type (NEX020)
-
-		board_id:	(RO) Manufacturing board id
-
-
 sysfs interface for Chelsio T4/T5 RDMA driver (cxgb4)
 -----------------------------------------------------
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce57503..9ac03f3e3bd562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10830,14 +10830,6 @@ F:	driver/net/net_failover.c
 F:	include/net/net_failover.h
 F:	Documentation/networking/net_failover.rst
 
-NETEFFECT IWARP RNIC DRIVER (IW_NES)
-M:	Faisal Latif <faisal.latif@intel.com>
-L:	linux-rdma@vger.kernel.org
-W:	http://www.intel.com/Products/Server/Adapters/Server-Cluster/Server-Cluster-overview.htm
-S:	Supported
-F:	drivers/infiniband/hw/nes/
-F:	include/uapi/rdma/nes-abi.h
-
 NETEM NETWORK EMULATOR
 M:	Stephen Hemminger <stephen@networkplumber.org>
 L:	netem@lists.linux-foundation.org (moderated for non-subscribers)
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cbaafa4e030269..0fe6f76e8fdccf 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -86,7 +86,6 @@ source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/i40iw/Kconfig"
 source "drivers/infiniband/hw/mlx4/Kconfig"
 source "drivers/infiniband/hw/mlx5/Kconfig"
-source "drivers/infiniband/hw/nes/Kconfig"
 source "drivers/infiniband/hw/ocrdma/Kconfig"
 source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
 source "drivers/infiniband/hw/usnic/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index 77094be1b2627d..433fca59febdff 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_INFINIBAND_EFA)		+= efa/
 obj-$(CONFIG_INFINIBAND_I40IW)		+= i40iw/
 obj-$(CONFIG_MLX4_INFINIBAND)		+= mlx4/
 obj-$(CONFIG_MLX5_INFINIBAND)		+= mlx5/
-obj-$(CONFIG_INFINIBAND_NES)		+= nes/
 obj-$(CONFIG_INFINIBAND_OCRDMA)		+= ocrdma/
 obj-$(CONFIG_INFINIBAND_VMWARE_PVRDMA)	+= vmw_pvrdma/
 obj-$(CONFIG_INFINIBAND_USNIC)		+= usnic/
diff --git a/drivers/infiniband/hw/nes/Kconfig b/drivers/infiniband/hw/nes/Kconfig
deleted file mode 100644
index 52caae954e4ae6..00000000000000
diff --git a/drivers/infiniband/hw/nes/Makefile b/drivers/infiniband/hw/nes/Makefile
deleted file mode 100644
index 97820c23ecef7a..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes.c b/drivers/infiniband/hw/nes/nes.c
deleted file mode 100644
index e00add6d78ec77..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/nes.h
deleted file mode 100644
index a895fe980d10ac..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_cm.c b/drivers/infiniband/hw/nes/nes_cm.c
deleted file mode 100644
index 62bf986eba67b1..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_cm.h b/drivers/infiniband/hw/nes/nes_cm.h
deleted file mode 100644
index b9cc02b4e8d59c..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_context.h b/drivers/infiniband/hw/nes/nes_context.h
deleted file mode 100644
index a69eef16d72d03..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_hw.c b/drivers/infiniband/hw/nes/nes_hw.c
deleted file mode 100644
index 5517e392bc018a..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_hw.h b/drivers/infiniband/hw/nes/nes_hw.h
deleted file mode 100644
index 3c56470816a87f..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_mgt.c b/drivers/infiniband/hw/nes/nes_mgt.c
deleted file mode 100644
index cc4dce5c3e5f6d..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_mgt.h b/drivers/infiniband/hw/nes/nes_mgt.h
deleted file mode 100644
index 4f7f701c4a817c..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_nic.c b/drivers/infiniband/hw/nes/nes_nic.c
deleted file mode 100644
index 16f33454c198d2..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_utils.c b/drivers/infiniband/hw/nes/nes_utils.c
deleted file mode 100644
index 90f28890246dd4..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
deleted file mode 100644
index fb2d0762c7c820..00000000000000
diff --git a/drivers/infiniband/hw/nes/nes_verbs.h b/drivers/infiniband/hw/nes/nes_verbs.h
deleted file mode 100644
index 114a9b59fefd58..00000000000000
diff --git a/include/uapi/rdma/nes-abi.h b/include/uapi/rdma/nes-abi.h
deleted file mode 100644
index f80495baa9697e..00000000000000
-- 
2.21.0

