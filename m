Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675B7148FC3
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbgAXUs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:48:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36992 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgAXUs3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:48:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so3973521edb.4;
        Fri, 24 Jan 2020 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YLg2XJoKBP5uIsxd+uP4S63l8nuV+YlwMWqroDFms3U=;
        b=W1sYeSyop5BEUPkedH+nPBakE74miB5lVt7WvDapmrjjkEbjbr53QCTl2FcCoNaXM1
         Ibi+HLc33ghnuTT+I2LCVmwLBvYUcsJf0cxX3WNRMWiRA33he/lGbgTL/pC5w6Ydmj25
         AsmBxh1j3dN9UKVnRy7O8gb3nzPCBFtFLj4rXlZuZYe3cCpdeaY07RWPCVqXyasFgtdU
         M9R4PyLIBff+hnengIXHdR5ZQQX0ZY0WBYr+u3RSDniaej/7Uk4PPdbg0t70UAS6mOiC
         eZOH8dONSfhYmg6RxOzubOgOao2BJzg1/GYGEy/bopCwUC32TDtckSWdMwgEhMHpc8IM
         pGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YLg2XJoKBP5uIsxd+uP4S63l8nuV+YlwMWqroDFms3U=;
        b=Dv3U9PqV7ncCi6PUcZSi2okEesrYSgROHWFSg9+NGPkjScU8HwNJXOHKZ4l8G1WgLy
         73EsCFffKeSFEIIkCzt2j+3faQX2FMYL5JWdMiLKdMNJpu9/G3EmEU6ekLSpj57SafTf
         jj0QHpobZ2RmsziwvR8aL1hCpLC0tYm4G4FkoTd4vJs3TjinNKo4kbAZO5lVA+ltg5d8
         yuUnnOUns6oQbZs6DDYC7JZjkGTyF27N9E44dj4m+ql4WGO8EkVB8FE/LCRO5faJBFWW
         oWmhE6+gkAqTbNjEBpIVqqbApkmx3HQyJJ7KrWkVpPN1jsCmJbD3Q7hfecd9zqZqlbT5
         8rSQ==
X-Gm-Message-State: APjAAAXDTdxrvXYkUaiqLzjc9dqfXD9QIAIj8/3k1bzNJ9m6rXhxFqxa
        YxEbPiV7YHBLuaZcVeZ8v9Xo1SHe
X-Google-Smtp-Source: APXvYqwV4cdxTKc6/iJ/n9XPrraPpY0ok21c26oxVUDFH0u806zea5fuJ6Mc5+eBVeksNuJpbkt4Gw==
X-Received: by 2002:a17:906:4b59:: with SMTP id j25mr4453562ejv.148.1579898907092;
        Fri, 24 Jan 2020 12:48:27 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:48:26 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v8 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Fri, 24 Jan 2020 21:47:51 +0100
Message-Id: <20200124204753.13154-24-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Add rnbd Makefile, Kconfig and also corresponding lines into upper
block layer files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/Kconfig       |  2 ++
 drivers/block/Makefile      |  1 +
 drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/block/rnbd/Makefile | 15 +++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 drivers/block/rnbd/Kconfig
 create mode 100644 drivers/block/rnbd/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..1636a7d9e91e 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -468,4 +468,6 @@ config BLK_DEV_RSXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rsxx.
 
+source "drivers/block/rnbd/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a53cc1e3a2d3..914f9d07835c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
+obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
new file mode 100644
index 000000000000..56e44745a36a
--- /dev/null
+++ b/drivers/block/rnbd/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_RNBD
+	bool
+
+config BLK_DEV_RNBD_CLIENT
+	tristate "Network block device driver on top of RTRS transport"
+	depends on INFINIBAND_RTRS_CLIENT
+	select BLK_DEV_RNBD
+	help
+	  RNBD client is a network block device driver using rdma transport.
+
+	  RNBD client allows for mapping of a remote block devices over
+	  RTRS protocol from a target system where RNBD server is running.
+
+	  If unsure, say N.
+
+config BLK_DEV_RNBD_SERVER
+	tristate "Network block device over RDMA server support"
+	depends on INFINIBAND_RTRS_SERVER
+	select BLK_DEV_RNBD
+	help
+	  RNBD server is the server side of RNBD using rdma transport.
+
+	  RNBD server allows for exporting local block devices to a remote client
+	  over RTRS protocol.
+
+	  If unsure, say N.
diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
new file mode 100644
index 000000000000..450a9e4974d7
--- /dev/null
+++ b/drivers/block/rnbd/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -Idrivers/infiniband/ulp/rtrs
+
+rnbd-client-y := rnbd-clt.o \
+		  rnbd-common.o \
+		  rnbd-clt-sysfs.o
+
+rnbd-server-y := rnbd-srv.o \
+		  rnbd-common.o \
+		  rnbd-srv-dev.o \
+		  rnbd-srv-sysfs.o
+
+obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
+obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
-- 
2.17.1

