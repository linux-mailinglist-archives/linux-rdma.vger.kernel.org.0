Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6446412CEE7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfL3KaM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39907 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfL3KaL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:11 -0500
Received: by mail-ed1-f67.google.com with SMTP id t17so32200616eds.6;
        Mon, 30 Dec 2019 02:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hsVyR0dD6wxBlUbk1dR9P1nl7/7T8dJLLC4GRywhLWo=;
        b=eP7zkqRJR+2Mbf60ds+cg6AaT4mHx1r8mav5SRdTj02lKUmJtQbP6aF+Yu7YdPzIQ8
         me5hcVi6nVVucVBMydrYphxxWxzsiXBnzBSep87cPfSBzOYuZhzWZdZOP230Z2bKoACE
         oIEKuNLmT44rg7NbFQkysMYuNaNVuIMF3SvYrysl4IZEm4PE/4cSTbFyHMLP5heNIqQN
         zbXWsgzuwc+wTkzOjxctU4i1CHfbCX//OObVGeMyQbBVop2aOimXZHf3UOicNhTk6Llm
         GwCRfF3SVmWzKzgB7qgfSP1voCEAxsw9uXprK5gVuESraUJNSAeAASkLKu3VytxNEug+
         piGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hsVyR0dD6wxBlUbk1dR9P1nl7/7T8dJLLC4GRywhLWo=;
        b=aB0uMVWlyaVbNPhmnmQ8FB6j6Pp4jdE6sX3qHyVNpzkfWqauD1i+CLNle+VJvkqTcU
         KFpeWOI3pv2IH4/ZYmuRyjSgOOZALeI9zHhaiBtHM36MR/Czh5mFL+RqNPsrTJftrLqI
         wgYa0dPOH54XCRd3tOQ1hxGtzl4btkCLPQYAPow1QNYbUnEPhqKH/MB6sv2QJldYlHja
         xrjCH3Tu4j0A9jOWgEww65EtMbeiBF1ESfBypMqoSzYijpu1tweKRZc7IIxN2FfU7cZc
         7yPZJZNGdycF/1u5ncW0QG01Hv/p9kpGxBCbPSvX0gVICDPhhJYe4oQEgP4Tgr/rOSH6
         hxCw==
X-Gm-Message-State: APjAAAXB1+QclAifUgK3/PJnm11H4FTxEk1x9DI68Vey84NewB1cr/6f
        4ksgxvAxyzSejJ0UvkHVMZMuL4Gy
X-Google-Smtp-Source: APXvYqwES6dj0U99PPZu16YWGpwttwGRURF+jbZT92+c6kCpHnLwkK35rwlWr6fqX6c3Z3W3shVxrw==
X-Received: by 2002:aa7:d80c:: with SMTP id v12mr71078399edq.302.1577701809967;
        Mon, 30 Dec 2019 02:30:09 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:30:09 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 23/25] rnbd: include client and server modules into kernel compilation
Date:   Mon, 30 Dec 2019 11:29:40 +0100
Message-Id: <20191230102942.18395-24-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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

