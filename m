Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3426D4D17D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfFTPEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 11:04:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36125 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732109AbfFTPEK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 11:04:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so5213013edq.3;
        Thu, 20 Jun 2019 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdpy+BrZyPT+R43pmHrYxlLWAJDkS+Y8Bc4/qngqh8g=;
        b=jCIhNFJxkboCervYWyVAdstiYXbqCLtsTleu/NPAOlSTypSU8ewZZmXOUNeaLBmD+S
         vuk5Qsk42BcRCSFZTEJL+htQd4uL0eB+E2az1SM7UJeDszY7SEQchL2hog7bzFld031y
         m+XGajRtJmQ1qeOLTouBGvEn9tLDIDvTtro/+37+LP8GFHkCBcGhQIrvWwPwbwJ6XQ2f
         d/WPgSD8TiO8ew1IGoP++em4Lb9x2rlUSbjyDDVxYI9gk3+vVp1TperpSVWFUEYxafi9
         lgTEDYVjk7J7/r10M1vc2+aWeBtdv3jcwbZP7IsJYqxfP0J9sNcmSZMm9M2W16UUQp7t
         75zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdpy+BrZyPT+R43pmHrYxlLWAJDkS+Y8Bc4/qngqh8g=;
        b=fg7PFlclmxf8+r7CtaBXs7pMDwDsWLhaW54cdEZ7FC2Pogfb4li6r1rX0iyCtpht9Q
         0A424VLKiVHJtsC3Qq7XFnGfby0Wwx5SqG6wyC+mcF/0iYmGlcRP/ZONjILa9Km80ZgE
         3Vmd5qccJO2ycvUYtjvwtmlLupkBkOPhb3IAy1Muko4IdRcq8tWPmzFQ5F5eDpc8j2Lx
         o0asH4U470Tiuw76T/jbiU6hnTjMnINbaBs+TiGkG/+sCr587BLuEdOgHBrMBOdFLMgg
         UBCda+qogl8kOjf46p7a0CEXQ3WTF5Q5K/EuWly42oNNR2XJ6fLaL+yKRoCqtX3jOTgj
         IXNg==
X-Gm-Message-State: APjAAAWehjv2mlyZN5SAZaQGJJy3Eh/pNs0hOX7aqrb0n/NYf3szVILO
        qyszWQsq5VhU2jzjsAABvI7wFNVtgY4=
X-Google-Smtp-Source: APXvYqy1dzGZd+mNI2VM5g/m2Rwxma/fOX6sN76p2ECBWsm6XRBAWqak4qp840vefePifLauibYNgw==
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr6889849edz.60.1561043048450;
        Thu, 20 Jun 2019 08:04:08 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.04.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:04:07 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 23/25] ibnbd: include client and server modules into kernel compilation
Date:   Thu, 20 Jun 2019 17:03:35 +0200
Message-Id: <20190620150337.7847-24-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

Add IBNBD Makefile, Kconfig and also corresponding lines into upper
block layer files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/Kconfig        |  2 ++
 drivers/block/Makefile       |  1 +
 drivers/block/ibnbd/Kconfig  | 24 ++++++++++++++++++++++++
 drivers/block/ibnbd/Makefile | 13 +++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 drivers/block/ibnbd/Kconfig
 create mode 100644 drivers/block/ibnbd/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 20bb4bfa4be6..9904c030d488 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -468,4 +468,6 @@ config BLK_DEV_RSXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rsxx.
 
+source "drivers/block/ibnbd/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a53cc1e3a2d3..bde0b015e07a 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
+obj-$(CONFIG_BLK_DEV_IBNBD)	+= ibnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
diff --git a/drivers/block/ibnbd/Kconfig b/drivers/block/ibnbd/Kconfig
new file mode 100644
index 000000000000..936a91c8392e
--- /dev/null
+++ b/drivers/block/ibnbd/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_IBNBD
+	bool
+
+config BLK_DEV_IBNBD_CLIENT
+	tristate "Network block device driver on top of IBTRS transport"
+	depends on INFINIBAND_IBTRS_CLIENT
+	select BLK_DEV_IBNBD
+	help
+	  IBNBD client allows for mapping of a remote block devices over
+	  IBTRS protocol from a target system where IBNBD server is running.
+
+	  If unsure, say N.
+
+config BLK_DEV_IBNBD_SERVER
+	tristate "Network block device over RDMA Infiniband server support"
+	depends on INFINIBAND_IBTRS_SERVER
+	select BLK_DEV_IBNBD
+	help
+	  IBNBD server allows for exporting local block devices to a remote client
+	  over IBTRS protocol.
+
+	  If unsure, say N.
diff --git a/drivers/block/ibnbd/Makefile b/drivers/block/ibnbd/Makefile
new file mode 100644
index 000000000000..4eb817a16ed2
--- /dev/null
+++ b/drivers/block/ibnbd/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -Idrivers/infiniband/ulp/ibtrs
+
+ibnbd-client-y := ibnbd-clt.o \
+		  ibnbd-clt-sysfs.o
+
+ibnbd-server-y := ibnbd-srv.o \
+		  ibnbd-srv-dev.o \
+		  ibnbd-srv-sysfs.o
+
+obj-$(CONFIG_BLK_DEV_IBNBD_CLIENT) += ibnbd-client.o
+obj-$(CONFIG_BLK_DEV_IBNBD_SERVER) += ibnbd-server.o
-- 
2.17.1

