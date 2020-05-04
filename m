Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270641C3C36
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgEDOCt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgEDOCt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 10:02:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5EAC061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 07:02:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so9196705wmg.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuJOZVsEd9h9dD9WNCH05BihJUfcD+XqHViZvcPGzLM=;
        b=GSAGPINvyuA4PGCS1K4yL81PPys7talOGsp1S+YxcyOApmWhurLhjoxl/Fgc6V/i0Z
         6TXIZdfqiM3dAAi8p9lH54yjo7kF+POKD4r7au3IA3kqpgfKqTlzhhuEsXz15aOJiTEk
         Zfe/RtzUdbrPMEz7NiGa4aW+4EhyEfEjBytVfIFzcyrOWlSXb6XLh0lOUnO9Vx0CMEBA
         wCl2vlDlhDzj2wOANqCC21U2RnzAfyUYg5lltmy/EuOkrBE7bpKrikH3siwUF7f0AyfI
         JzO0udIXBkYoR82OXExJmTnz/7w/LOikQrONqy9n0pf/cdbKTCG4kXuPqAMqY0akABhr
         YrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuJOZVsEd9h9dD9WNCH05BihJUfcD+XqHViZvcPGzLM=;
        b=jgrI52JJwOaYPQlNnCEMmgrcE9HGMp7yslSjW4oL8m3MXspKXdMDLoo9fdTGXd8O55
         OLtEYLdVMf8ddVGokgpVk7msILSkCoTio7cYQQEIZJSDdyl+xq9gcydw/Du1blzmOFLD
         U+NPVe4vwlGwtqlaK4fJvKFpsf5pux9EXeIZPGtRyHXbKV0jDOtDhu/FCFHXwsfGG5Ap
         7Ke239rG/FfgSwMZVUgqHlLe8OBiCU0D4m+yzutuo2ofMOYrWqft2PRDFACQbX7jbwhv
         suMz/v8tLt8+v/+TBXGfWbW8FjwjckGHhIKY9z5rnVHngTuhpPTCzOEPr++nuSYspCPD
         m6Lg==
X-Gm-Message-State: AGi0PuYJ9P8XOVkcB39QAA+2BEOqvE+/A6SOyLNScnLfgjlE2tIQyc8x
        eTMidaRgQHMaqsKJNiqoscrP
X-Google-Smtp-Source: APiQypIknBf/SiDaQVJUVHhepIa5gC9zZsYR7ZUbf5N/wd1VcY2tjZPYitmkYSgpkBEBUSFWE3lXog==
X-Received: by 2002:a05:600c:2196:: with SMTP id e22mr14439946wme.105.1588600967391;
        Mon, 04 May 2020 07:02:47 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:46 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Mon,  4 May 2020 16:01:13 +0200
Message-Id: <20200504140115.15533-24-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Add rnbd Makefile, Kconfig and also corresponding lines into upper
block layer files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/Kconfig       |  2 ++
 drivers/block/Makefile      |  1 +
 drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/block/rnbd/Makefile | 15 +++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 drivers/block/rnbd/Kconfig
 create mode 100644 drivers/block/rnbd/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 025b1b77b11a..084b9efcefca 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -458,4 +458,6 @@ config BLK_DEV_RSXX
 	  To compile this driver as a module, choose M here: the
 	  module will be called rsxx.
 
+source "drivers/block/rnbd/Kconfig"
+
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 795facd8cf19..e1f63117ee94 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
 obj-$(CONFIG_ZRAM) += zram/
+obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk.o
 null_blk-objs	:= null_blk_main.o
diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
new file mode 100644
index 000000000000..4b6d3d816d1f
--- /dev/null
+++ b/drivers/block/rnbd/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_RNBD
+	bool
+
+config BLK_DEV_RNBD_CLIENT
+	tristate "RDMA Network Block Device driver client"
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
+	tristate "RDMA Network Block Device driver server"
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
2.20.1

