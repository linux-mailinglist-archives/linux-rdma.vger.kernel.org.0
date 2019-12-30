Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4672F12CED4
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfL3KaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:30:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35299 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfL3KaA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:30:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so32223776edv.2;
        Mon, 30 Dec 2019 02:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dlz8/r2lAq9MWwGVb3islQaFajiPDRixzWoG7/v0iOw=;
        b=tUVKPSzIcyBSbU+ZcNgA6JL0FNhHiDRv4IturjwwDWUc6I3tq2VPgdYtF8bCRiD2PL
         B+cODzITK6/KzFPueB89wVUkoRjA1LkbyfVjejw6mbsQAY8ryhrTpkmBiLY+2U1rGBDh
         6GMSwNFOaIdVU+6dMyAZh66fyIou/GKdNU8xmJx2KdgxjU28EDufnoUaJ95DF55jqfC+
         /CqRkJ3VDEkm9kBVf7Ec/FCyAuClY6DklF8EgUFV99hpN/eqCgfuMJlwW8gBZ3JiCS0z
         rCmtSRnTR3jHFuBuP/rsVtvdEQN0BVo+VtYAHTEH9PbwS2XDcAO8OdPhcVSTMZmt4D4v
         vbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dlz8/r2lAq9MWwGVb3islQaFajiPDRixzWoG7/v0iOw=;
        b=AIPCVXYyDVXxhmvCbtIU8nSNiBqF4uYZmPTSrGw/nTY1nIUtV7CC1BE6oC7BeudAoC
         4l2WOtgQjcqdNmFMejpSUlQjoUveG1yf1G9PDJMJLBZ5Er01oPEnvls+FCm2MV6c7rzr
         oV+nXdLaOhrZ9Tcc+XJ1mAyqXefycwmmAsurBK0YzNk6KxsWZotNbTi/usAD15wenHpQ
         phOBIz8703GKlPS1sGQBHbA8bl7CseIQJjY36kto3ZSSIiuWh7SE35MzxboMUBW1Z+3A
         WBYCyWxMmUN4RvCmVYww3fyshyijxqU8hWXWkCA2oC4KWtRfzMo2luBoo3h5itufKcp0
         ZW9g==
X-Gm-Message-State: APjAAAWkK0MuOsNIvZPtx17fXPGdUnWnISOuHObgRQjmZHRzSQrkVZfo
        3sPnCVL2zpnQ46YULfwPtkmsNQjD
X-Google-Smtp-Source: APXvYqy8DrjIELpqVtO818qRhKKqxMlQOhtUUMtK50895YmtPLeceQ538bIAb66p5ffRnVP3LvDIVQ==
X-Received: by 2002:a17:906:d0c9:: with SMTP id bq9mr69725042ejb.56.1577701799032;
        Mon, 30 Dec 2019 02:29:59 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:58 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 13/25] rtrs: include client and server modules into kernel compilation
Date:   Mon, 30 Dec 2019 11:29:30 +0100
Message-Id: <20191230102942.18395-14-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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
 drivers/infiniband/ulp/rtrs/Makefile | 17 +++++++++++++++++
 4 files changed, 46 insertions(+)
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
index 000000000000..1d6c670a4504
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
+	  RTRS client allows for simplified data transfer and connection
+	  establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
+	  READ/WRITE semantics and provides multipath capabilities.
+
+config INFINIBAND_RTRS_SERVER
+	tristate "RTRS server module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_RTRS
+	help
+	  RDMA transport server module.
+
+	  RTRS server module processing connection and IO requests received
+	  from the RTRS client module, it will pass the IO requests to its
+	  user eg. RNBD_server.
diff --git a/drivers/infiniband/ulp/rtrs/Makefile b/drivers/infiniband/ulp/rtrs/Makefile
new file mode 100644
index 000000000000..89332be15c9e
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/Makefile
@@ -0,0 +1,17 @@
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
+
+-include $(src)/compat/compat.mk
-- 
2.17.1

