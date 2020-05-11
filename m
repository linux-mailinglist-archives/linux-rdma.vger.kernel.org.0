Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C525F1CDC12
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgEKNxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730284AbgEKNxj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:53:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BBC05BD09
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w19so4601999wmc.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gn68bNVSNHciCtQWHr1NVTfhRzOYW2ukgjidraGWe8g=;
        b=bucyy1TpemLx27yTcVQYpa+K1mmHdqqsNlYZmsXbw3xk3C+wwTUAx8cCSEiPhJaMEN
         mWJ6s5UziLk5epjQrk4Y2/BS9/UDZWkw6q2uEn/vVm/Z1rAudu0Pr3NT4I1Vzsw8yXSd
         3oBU2Ne2z4H+GwY8jJ3nCfzpL8Kkm/sUZpK6xD0eJyR/qtM9f+YN5NGLDCZtrAoZKlNd
         IG5FyRssLsU2I+XtDO5gPr60CLVxXHVR7qIuREJnsQ9n1PcwWXr4LQi9rMGhMNy/UbkY
         fh4CX2AJ1044eAZa5IbXN65qTzHeYtUSGSEfvElcgtwsLm3N7iJ47644G7Vwztzinr2Z
         XvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gn68bNVSNHciCtQWHr1NVTfhRzOYW2ukgjidraGWe8g=;
        b=gd+F9TbIgX3qwm/FZE131g/wash0vPHTeCgXWUyK/2Z83J1u1SwSVxEm/JcrqCVsr4
         Y4wlFcvIvZua8k2IShEVD9lXR57JUWWY6PMFo55fZcfj2+4fcpM7mI0nb2YpOgufXD1y
         zt4m81HPleMqcvtC+cBLk6RB+s6yN+nw9Ai1JHpKc0gGS3gHfImi/fz4flpoKs/z1+yr
         J52o4m0BwOmRigYbJ9ftjUgnQBEL1Dq9azjhsqlA2fTUDUX7oFtuIHvpGDUE4zrOUtDs
         nAPGlSQgn9JqaRJmIqCjWUtYg+izuYefSZMOabqXHL3K9thypw4AWsUju3R1ucvhhs3L
         qE6g==
X-Gm-Message-State: AGi0Pua0+HooK6CzFdHtmmJy3zShnjN1GzBafx4vjQQLKvgtD5FKEs0e
        PsbAlHyRoK+xMM2enkiXbopt
X-Google-Smtp-Source: APiQypLjdviCPNoFN3Yjn1XiMU3KjpeXQ4ZgjdKx3N1PwWsWByEmDWKXGaH0ZzPa9NgBEfYetD4J7g==
X-Received: by 2002:a7b:caf2:: with SMTP id t18mr9342881wml.35.1589205215972;
        Mon, 11 May 2020 06:53:35 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:35 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Mon, 11 May 2020 15:51:29 +0200
Message-Id: <20200511135131.27580-24-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
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
index 000000000000..5bb1a7ad1ada
--- /dev/null
+++ b/drivers/block/rnbd/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs
+
+rnbd-client-y := rnbd-clt.o \
+		  rnbd-clt-sysfs.o \
+		  rnbd-common.o
+
+rnbd-server-y := rnbd-common.o \
+		  rnbd-srv.o \
+		  rnbd-srv-dev.o \
+		  rnbd-srv-sysfs.o
+
+obj-$(CONFIG_BLK_DEV_RNBD_CLIENT) += rnbd-client.o
+obj-$(CONFIG_BLK_DEV_RNBD_SERVER) += rnbd-server.o
-- 
2.20.1

