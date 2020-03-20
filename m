Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E218CDBE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgCTMRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgCTMRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so7155626wrc.8
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8kf6j8xGdq+NN7alk/HuFM7wn8Aa/jDFZrWaoTNTEQg=;
        b=DG39nVBXwG9X2KmP4FMbQFtAoud+oPV7lJbtZJuHaAsuRQMxEMCLnlwxILsqAcV/Cx
         kGy6MPykDkz0b1gxrKXEhGpeXS01F7DoMDOvN2sCiDFRA5Zo9VDQIEYHtPtVqfnM+OQ5
         CWdF057lLMaDzhs21aEwzW0dxHQrFgbDSaNdbLHhPsDDaCzPREhJAg14bTnM1mVsKUwf
         /JCEeH9GWcElvUhgWrIiWlC7rbN1Rfss/GJaAiEwhYX6LWSDplni9ljviCjn4w8d2TmQ
         aYFZ8ZlTpuEIP/nrPOf2D5i0+Yp0OfLbQgXmtyR1orxflsh6XO6pH+IzE3EG/3CAf6sC
         nHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8kf6j8xGdq+NN7alk/HuFM7wn8Aa/jDFZrWaoTNTEQg=;
        b=AuJehlqRVqtqj9xUAGGD1k0JP0GY+Y8pJt31twRPLa1D8uL8lvaqCMwokERR5BfSXj
         SZKKak2QZZCka+NUAoq8iLERsvKhuM7uRUVQg/VXcOxNUnB9szR3c1Xt3XX0RQehS61b
         pMbdMLe7NHi8X72Z3DWTYMby2oks6/euJay18R6scVR0p2Mk4WwfsM5lqWSHuYYy+xKG
         Ux8WaTG6WmwVJrLrwwN6MpYlB32+QTV//T2AfXFOh+nm8QAoyBhUEVrDpk+xi9pGz9Ca
         QwIje0msRxWF4wcGdjZwSzr3DbyHBlnu9p8GWTYOpa99bxxWaLklI4rlyxPpkxEU3f/1
         VMOg==
X-Gm-Message-State: ANhLgQ3ikMa94o6prQJvi9RV3Gc9W2grIE139T2FpLS/0a8XxU5+2eAe
        bk8T4N4SctYospAnsiui1pB3wg==
X-Google-Smtp-Source: ADFU+vsA3hUe2XscrdVnwCaista7fn++/5Axu6uVzmFLWEls93CWjHtpN3bYVWJXpyTRSsjxjkDjwg==
X-Received: by 2002:adf:f6d0:: with SMTP id y16mr10569700wrp.298.1584706657806;
        Fri, 20 Mar 2020 05:17:37 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:37 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 24/26] block/rnbd: include client and server modules into kernel compilation
Date:   Fri, 20 Mar 2020 13:16:55 +0100
Message-Id: <20200320121657.1165-25-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

