Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5257C127FEB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLTPvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51730 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLTPvb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so9426878wmd.1;
        Fri, 20 Dec 2019 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dlz8/r2lAq9MWwGVb3islQaFajiPDRixzWoG7/v0iOw=;
        b=WtcLXYvl54Ko7uvFlvX/DkrNexc1Q4PulwEHOmUx/6Kuy6CtDoN9W5du/fcCEpS7u3
         SIf7uqO92fdd2wfFWwXCbbqCOm8vrU+pseGKqM1neHph5PmzLPNzhH/b9jRZL+26QuL9
         +JqMkxPdm2WzpSC73wEyutWezL3u30Ajic5BtpPX3vFlLWEdl2nB6lANiworZ1BAnGFu
         zuw4uHCnasKkHGkv8ICc9U043U+dUQgPhVtH3xw7Swfu99xBznA9kQLG1L3jak8rc5BP
         fQhm6Rq69JiJa8j/oqDEjbXY+OrJEB/HFhkhXSaMYN3UpNX3XBu3OeRUhCUzw6l0dUEb
         3Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dlz8/r2lAq9MWwGVb3islQaFajiPDRixzWoG7/v0iOw=;
        b=fJfYVfdBDvW5rHhwT/JnlLpifBzaR6AOHTfe9wsFs5Bb5f4pmgdxRunxVwiBcFL2pp
         +ArQHfN6TdEQSb6iUpMJnhlKsTxw77aImCrlBo+BThNS42Xvm2cRnv+qR3VG/a6okmG9
         OyWLm8lxnJbN0vKQeO/YWI4WmQqYdUGapzToJcvb00UJqEItHqDB5vnDFCd46V1oieZl
         RXqsgvpHknuBbKvMmIxK/DwFpbYz/w5pEXKQPfMb+RYplyxoOSAldAsLTGl6OnwUH0sw
         SdZ5MibfiM0fUej4v84ozi9jRkK14TLhoV0PEK0ejPd9bXyaQ0Z53t/NCDZypNyXpcP5
         3f3A==
X-Gm-Message-State: APjAAAWn0ny5MFbACmGGgemT48y79F0QJyzkKubnWKoS97HzgRBjkrBK
        I+Mvcp5GgtcRR1AxFWhZVcbmygzL/JI=
X-Google-Smtp-Source: APXvYqzVjWCenMOIPzYwgeekHXI7V8nucmmZNvKDlzGRLjUia5I1nPUldPb7t+UaftYSwigyRvdLuw==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr17069689wmh.35.1576857089402;
        Fri, 20 Dec 2019 07:51:29 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:28 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 13/25] rtrs: include client and server modules into kernel compilation
Date:   Fri, 20 Dec 2019 16:50:57 +0100
Message-Id: <20191220155109.8959-14-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
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

