Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5188513DAF2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgAPM7v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:51 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44272 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgAPM7t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so18805278edb.11;
        Thu, 16 Jan 2020 04:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XLx29JHWWbfg/Ftz1WZq0INXnQEZR0WXlVsDXoGL6VY=;
        b=CODR15VyAJ+Z3NghieBlJ1LZ1Pbq4QilK4qxvPeN3TP3qUl5PBVv3D545LD7sCD0yu
         szI30bEC8WMpmUEQnRon3la7bvKEgFvhgJEGBuoSu0wFTYciKYwbery2192ePWxiYa/G
         jXBbVcu2pRCAr7wkPanxvmlOdH6W5FgLnkMjLhzL/qSU/DQ0Yp5SumksXqvGKnh+mV2a
         jkotPK5e3UVNyb+dcYjLb5KEFaAn99SJ8RECY0x/m+WblX2EaYsok3tSHLj01nU4YwEA
         DPwd0WojVEAYftTS/F+q64V5s/dVDHSyLSCFFbC5B2X7oZrzMd3yH4luCwcfskDXg9pE
         f1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XLx29JHWWbfg/Ftz1WZq0INXnQEZR0WXlVsDXoGL6VY=;
        b=exorcq1JEGwJsl7sLp2TdoH7R+QbnjW4fz/bcCwbbCNv4IjqRfvRUyExw0Fvg8LzJy
         aeLM9uvi1Y5L7FopyoQrfVxpZ48IyAkEHgQpyUsharessGjnEgqewWqZ5KXk4gX7L9+S
         zrl5tAvaFr/JlPrEDSVUHUXEEdHcRy/cB/NiCms1T8XL2q7vVpNb30UyjZqKfIo144+O
         zKGmJ4K1344zDXxHyQq0///KQ1g0cFyXRvXQCgJH32M2GWlB9dAoLpgzYuL8nrY75PB8
         F6Qhnq0s8O8sQFebMLU1bc0vwHac2mK/EiVCP5C9ztsMqLYfxoBQAxFNzHqmmyZJx16M
         RYjA==
X-Gm-Message-State: APjAAAViWLZgwrCVLKDask1Z7y/Eby/zFo/ECL5hk/rlMzS38/EOfehb
        e0MUW4zmSZ1HnsDjOQ2nXYxJIHY9
X-Google-Smtp-Source: APXvYqxOP/+LaO/znWVZUBnyrsQVjzZseoRMooKAIwaLmdOMT504EttncYBxDBNuVXdFrV7sjAMXlw==
X-Received: by 2002:a17:906:c40d:: with SMTP id u13mr2804173ejz.178.1579179587809;
        Thu, 16 Jan 2020 04:59:47 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:47 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Thu, 16 Jan 2020 13:59:13 +0100
Message-Id: <20200116125915.14815-24-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
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
 drivers/block/rnbd/Makefile | 17 +++++++++++++++++
 4 files changed, 48 insertions(+)
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
index 000000000000..125c3576f221
--- /dev/null
+++ b/drivers/block/rnbd/Makefile
@@ -0,0 +1,17 @@
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
+
+-include $(src)/compat/compat.mk
-- 
2.17.1

