Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A7167B48
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgBUKru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgBUKrt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:49 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so1760950edv.9;
        Fri, 21 Feb 2020 02:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YbImRicNDAVu8yb2uewialXCho1fKwJXLs27Azq1fW0=;
        b=TByFaURQGL7Avu3bt8V06wbbUjptc1J/iHQGhixTI+mY6RYEayGgEelvJ20zzQ7Rbq
         3M06uxgIHNc50plbCafo7UA9X6TwLnF46IqzgMB700G7lqZKlzdPyrAMN+QLFMje/qc6
         OnllHZ8mTylaomgUtYyGoVcuGn68PxGg8LOlKJovVoDVIFUOVIo3vbG/tpuIr8vjJp7H
         TbZ2DcpecBEXfUk2BYQBmKB5dAqTRtUF35xQ7X7aTRpsquEnqnbB9KCpVGISTznuaEi3
         HzNQFrgEsMv9e2LPTwU+4smRs3yUNsC+O+cNkAfcDMZjPsvPV1Bavmm7sHdLXDVVGjww
         U5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YbImRicNDAVu8yb2uewialXCho1fKwJXLs27Azq1fW0=;
        b=gyWWJf8Jm/DNsni3qvvfTeZQKo6obOveguq95/GtDTYDo23ESO3PCDidQw7Kfeafu0
         pBjSgrbtPZEm3H1obyR6NhTt0BNuJLy8+Sg9m67Z7gSZy4Cqo0dhGYKY9P1U6N7JtajM
         SVQ048Yij8M+E4rFG59dWtbjwE+pzKZj2A4CJwOlaGE/z09NOAykIpISkL0B0HVZ1MT1
         CxhHiVfuQGlF5ah2wAZOxtQgwlfq9Q/wqibeCLmyyPysjCVpYZApCGQ/t4U2gTQwhLbG
         nyzGeyRxN6T87sJBv3CIJeMRRi0saY9si1WOVBqhakIWf9xZehByvqmc1DZtUak43L4D
         H3cQ==
X-Gm-Message-State: APjAAAXVvtdf9iKj6Q/SYxUHA+Kc6XhK71/UyNEAfFBHhdbpqNdvId5s
        qvc35OAAH71Sv9DgiD1MdfupYpbI
X-Google-Smtp-Source: APXvYqxwawdMU7+Wk57VwoJkvbASaW/7GXf20nzPLHFlD4Fsx/pQn/HPNcBcWYwm4FTnNXRCmzIcKA==
X-Received: by 2002:a17:906:ff01:: with SMTP id zn1mr31829216ejb.323.1582282067755;
        Fri, 21 Feb 2020 02:47:47 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:47 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v9 23/25] block/rnbd: include client and server modules into kernel compilation
Date:   Fri, 21 Feb 2020 11:47:19 +0100
Message-Id: <20200221104721.350-24-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
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
2.17.1

