Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3022D128007
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLTPvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLTPvp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so9404463wmj.4;
        Fri, 20 Dec 2019 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hsVyR0dD6wxBlUbk1dR9P1nl7/7T8dJLLC4GRywhLWo=;
        b=O9U6mVsws2NS3dNeoYu7RrRmthfl/Rv+9LOmkAfPyTP2RFeSeMYfK4JPrCCfa5chD4
         Vp5E7zIcCsyZDnfGhzmYsf5koBLrZ4A1IdUABkbyu+O72erTDeKhFBapZR/ET4NF+JIA
         yHndXZ63nVAL1eExDHGDcLgpFCuL2HP+L1rDekyoWDYu8IcRW3yiEELlm5sEIbKsTAqp
         DKsdIXN6fZcXhOiVKxt04QyqWYlCWgqIAaepYWDkksAEAFMd7Fd6R2o+OiAY9wbkkfBB
         D6zffM+PYYa9r1kKKPwq1u+vLxG2wRdyYxjzVk6XdH00uplpWlS+kBaX89lUeRDRFsF8
         JlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hsVyR0dD6wxBlUbk1dR9P1nl7/7T8dJLLC4GRywhLWo=;
        b=GPwheFSRxv6OZ9Br7z/MoxHHHalxvCFNJnErPxwVgMN4/Gf+9vOV8hw+mxm7yJggpm
         9OzXpve9sjRjG3bfcy2lv96FkVQG1owydcC/zKRQ+iUdEjCYeddu5Gr8KghoPc6QPCeS
         xJO6H0sFUhlorToyUyMQo4dW2KwUtHUKOZFyxj4NwXd8Savva21XRF7E+ScNeHXwZhEk
         oBz9gOQgG41fh6+OGvE4QZARg5Vih7VpywJdzIlhSWnC7Aq5tdPTvBAv3UvbPS8mQ/jp
         EFKwyPv2KXTw1g7KQ8folaTI1P7uzRWxvVIibM9nKdm0d1ohYxAHKgxp9tpv9IHAkt4q
         repg==
X-Gm-Message-State: APjAAAUXAHWKfUZyr48EhwnfZYqBp97coEwp/iC4FvC9jGExy6FmYCG8
        2U9hwkHtFQlwR+xsmAgluCwk2OPA
X-Google-Smtp-Source: APXvYqwxxCZ6tKK1N7+X5TDEtZxyqwNXDXGedVhY6du52vyYZu4GawseiN4Rrro96U/Ib7ubHFrm3Q==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr17859484wmj.169.1576857103668;
        Fri, 20 Dec 2019 07:51:43 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:43 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 23/25] rnbd: include client and server modules into kernel compilation
Date:   Fri, 20 Dec 2019 16:51:07 +0100
Message-Id: <20191220155109.8959-24-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
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
index 000000000000..67882d2ff58f
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
+	tristate "Network block device over RDMA Infiniband server support"
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

