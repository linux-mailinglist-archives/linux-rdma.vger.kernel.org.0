Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7E21CDBFD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgEKNxY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730255AbgEKNxY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:53:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC5C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so19348650wmh.3
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THOEf/EtQ5Fz6CQ4n8MG839SjQe4WPGN9/Y98jgBUSQ=;
        b=OW14dI5FVz1snFpm8u4j3ixbqpbp93XnBUpk8QXNO+xFzLiHfOa8jAHL9AS/7dlLCm
         ggdb5nCs8Sn6GGl2RO2cnqOJzck72EnQoeu+dsrUXY6WhGj3CAXUjNlm/CSa0xVCg6cc
         6QtzSsiXUQ2hKVvrNNBT6hxJeIeV5yz8ZpqrdGRHkYGPUdsFPeP+FrZuZVnJOWSsaDtw
         JBgBwj4tEyWuW06cuR5VM2Jd2u1fcG14Df14YOcTVFsTFYysliMKJVdfcuE/jXUbhtW6
         ilpkyezgOfc1HTOr/ZAJ8MJ2PqRCn8t0/c2g9FprzdojlvtEv61ycC0jogxm8GcTyDIO
         Cpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THOEf/EtQ5Fz6CQ4n8MG839SjQe4WPGN9/Y98jgBUSQ=;
        b=DEq0dnauKxtwfgNv/uDgKswsgaEDov3yZwRDRRo36QYf6QwStdpUoriliVrtC0z13W
         EW325zb92CJIejohWA8mkAWhqTt9N35DB09Xab0Jl3X27ejwJxo+2enhOC04M9CYXtNm
         RFT3lz82v+qepH/N92TzvkLrfObOE05TyEl/uhibl6M3pV89Aww2QqTZOwvNyiczir3C
         94Xd0DaDU9Dt1rlX4VT6VHPLsDu3DclxV11Qku0dkoldNy/ubXhcgIj7NVOUPhsDvfsg
         VucyxHquik5PzTgc/I9jwhQojq/QGgudg1uYIjXZ3rn51u5txRiGMN8WD3FIqXuV4c6M
         sbHw==
X-Gm-Message-State: AGi0PuaQQu0DSFHCVOscQWSZbIzSzXOCbZEbqSG3KDXYUkJ5giyxHZAx
        f+glNgCt6LdYWYni1b9RLVNn
X-Google-Smtp-Source: APiQypKrOBYchtmsVAEv5i14raqTZ7BTAKYP7UE/1hgso72ddUW81m1148gtzq24RU6r+0vcDvIG/A==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr4951067wmh.157.1589205202663;
        Mon, 11 May 2020 06:53:22 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:22 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 13/25] RDMA/rtrs: include client and server modules into kernel compilation
Date:   Mon, 11 May 2020 15:51:19 +0200
Message-Id: <20200511135131.27580-14-danil.kipnis@cloud.ionos.com>
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

Add rtrs Makefile, Kconfig and also corresponding lines into upper
layer infiniband/ulp files.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/Kconfig           |  1 +
 drivers/infiniband/ulp/Makefile      |  1 +
 drivers/infiniband/ulp/rtrs/Kconfig  | 27 +++++++++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/Makefile | 15 +++++++++++++++
 4 files changed, 44 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
 create mode 100644 drivers/infiniband/ulp/rtrs/Makefile

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ade86388434f..477418b37786 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -107,6 +107,7 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
 
 source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
+source "drivers/infiniband/ulp/rtrs/Kconfig"
 
 source "drivers/infiniband/ulp/opa_vnic/Kconfig"
 
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 437813c7b481..4d0004b58377 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_OPA_VNIC)	+= opa_vnic/
+obj-$(CONFIG_INFINIBAND_RTRS)		+= rtrs/
diff --git a/drivers/infiniband/ulp/rtrs/Kconfig b/drivers/infiniband/ulp/rtrs/Kconfig
new file mode 100644
index 000000000000..9092b62e6dc8
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INFINIBAND_RTRS
+	tristate
+	depends on INFINIBAND_ADDR_TRANS
+
+config INFINIBAND_RTRS_CLIENT
+	tristate "RTRS client module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_RTRS
+	help
+	  RDMA transport client module.
+
+	  RDMA Transport (RTRS) client implements a reliable transport layer
+	  and also multipathing functionality and that it is intended to be
+	  the base layer for a block storage initiator over RDMA.
+
+config INFINIBAND_RTRS_SERVER
+	tristate "RTRS server module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_RTRS
+	help
+	  RDMA transport server module.
+
+	  RDMA Transport (RTRS) server module processing connection and IO
+	  requests received from the RTRS client module, it will pass the
+	  IO requests to its user eg. RNBD_server.
diff --git a/drivers/infiniband/ulp/rtrs/Makefile b/drivers/infiniband/ulp/rtrs/Makefile
new file mode 100644
index 000000000000..3898509be270
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+rtrs-client-y := rtrs-clt.o \
+		  rtrs-clt-stats.o \
+		  rtrs-clt-sysfs.o
+
+rtrs-server-y := rtrs-srv.o \
+		  rtrs-srv-stats.o \
+		  rtrs-srv-sysfs.o
+
+rtrs-core-y := rtrs.o
+
+obj-$(CONFIG_INFINIBAND_RTRS)        += rtrs-core.o
+obj-$(CONFIG_INFINIBAND_RTRS_CLIENT) += rtrs-client.o
+obj-$(CONFIG_INFINIBAND_RTRS_SERVER) += rtrs-server.o
-- 
2.20.1

