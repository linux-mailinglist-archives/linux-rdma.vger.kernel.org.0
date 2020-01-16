Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB813DADE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgAPM7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36251 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgAPM7h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so18827591edp.3;
        Thu, 16 Jan 2020 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODoMGcQXoudvtOdIewnbP5JCd9nIA0t8Qz5zrJ9zsgA=;
        b=vSHX0yZF35CUPC8MxHBc39U0RIVi2zp8inkisWYjNkMfIvsYZeic1cC0WF7cOOK5ij
         /Jvgpice/9ro9X3NwEtV8oeDnqD/+WmY8wOtkHOf/HD+EAHd9UlSbpoJUPcaG3jhyDjp
         XvkfB5vJGed04YldTD8la5PP3KF2GgeAPH8nRPxkc5Mnn5IYOznm4Sqe2Ll0BJQCeeG/
         3/T54QOujnMw+fmV/FgC8/sKzhg7pdCTfDR4v2Jrjx9ODgHiEp9ERBAFQwiVcUEWdRj2
         CJY9tCh+yywhZklT8bMIWND3hlQW5j79OE2LMg104ICF0RSFANelMP1N5UjVMlpdxjHy
         8wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODoMGcQXoudvtOdIewnbP5JCd9nIA0t8Qz5zrJ9zsgA=;
        b=bTbYv+e6dczl6+Q2imR/C+qTwA28Y8lu3t4rKHmHiBd9XTguFiVTzSH8HcwYpT5ZRf
         csHALB3aAY7lUFKK+toYvukepv6IW9VzFBE5S49SO7RftT07RfDahAzYG3kvMdlVU2c6
         0UlOX+q4MPsHjtVvaTlZPySWdAYlO5qFDK49Et5ppXsvSXVW8u+iPtUZ/rwjSeKixto1
         RbpiCbo9l3i66HmD2kuUP/LviiJFebF/mEZmM/OzUVJgcPc3RMdbWNBZNOTKewnvuWTB
         YQ18Oo5vapkG1u05oqb7b3vBNNCryG1RB0MRcDu61Nt0UJc2TvDSEVjSuogDufRUyey0
         1oow==
X-Gm-Message-State: APjAAAWY7sTG1YA6O4q6pizUQKfwia62azbp7pXqFGHfd8MVApIFnCn7
        /tHWPnRDQqkSfdGn4ifFMQcvsUst
X-Google-Smtp-Source: APXvYqyCABmxnBxItQgviHYfwUwW04qdVw1ki3hr9ratsaYSzfbbi+qBdYxqJK9QTSvV4DOOZr/aaw==
X-Received: by 2002:a05:6402:c10:: with SMTP id co16mr35623170edb.180.1579179574925;
        Thu, 16 Jan 2020 04:59:34 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:34 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de
Subject: [PATCH v7 13/25] RDMA/rtrs: include client and server modules into kernel compilation
Date:   Thu, 16 Jan 2020 13:59:03 +0100
Message-Id: <20200116125915.14815-14-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
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

