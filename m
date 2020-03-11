Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EC181D77
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgCKQNV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45437 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbgCKQNV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:13:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id m9so3353021wro.12
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8kf6j8xGdq+NN7alk/HuFM7wn8Aa/jDFZrWaoTNTEQg=;
        b=PuaouYFrwabdVLQBOERQiaWTp0W9bPMiQxCUWiAZ3Bv18ze6fC6QumOxk7qq7JoPzx
         Szexo4NzHx8JZIwrN8e0HyfX2Y1CD+Ec3vx8dK/QrrQMyn0nNHSnUFQ3jRAHW/S+mfsp
         Hzihmr+RfT7cdwthIg1ZjgCBrWvxvrm9lOFieVH97II6XjD51Jsb5ZFYXe+avbWLBJZu
         qmDm0345es6iOPuQ64m72c0E0HIlAKK4bDVLMUXDGK5XIxMeBgT8T/lP+9JNHCItxDQA
         mKWAS+e6FfuLGbea+inkwUcJxUYRgHy+MewUzHiA+/8EDDr1kvyKMBEXqFhtwKatE6Tn
         4t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8kf6j8xGdq+NN7alk/HuFM7wn8Aa/jDFZrWaoTNTEQg=;
        b=IucQ32oX0GuzfYw1WVTM+AyYwiThziBHXsdgoViaXzMpfLsHjzG27rvW6g81Xg920b
         /PfwFAo5L6L0L16Z0MIpUAgR5XOxknCkHErJqR6RXIJZ35rHXuK+7yID6QScGPedXfre
         lb4tK6UMlIQ9nKNnb9jPU7P7ABsbnX/+AkKPKOpvPdVd0DXZxree12/i6SnACF8/eoFF
         HFDaCbSwPIhhq/CJIl7LQsoU8Dk7ipHpKyILsysx7cw8FGifFzhFNpGajXwBwx82smwM
         6nNUdL8JbiJbgFST8g7TJiKHocgDU2UlBbPsAZ1dEDne/2sF1MmiumSaK2xvGlwReCnO
         WYcA==
X-Gm-Message-State: ANhLgQ2kDE1GflU9hmGKckUQtaAkJ3gV2Q/XU3yb9NGIvRtdh9ZuOuPP
        LPTOvWpAlUMlCgQBA0DnsXF5Cg==
X-Google-Smtp-Source: ADFU+vvtoAiZU9maGYiswvMmbqMDx3q0WhxG9hA/xWPN/VH5aDUHW8VuYTrdzCfHx0v8m0t+8yA49w==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr5084835wrv.353.1583943199067;
        Wed, 11 Mar 2020 09:13:19 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:18 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 24/26] block/rnbd: include client and server modules into kernel compilation
Date:   Wed, 11 Mar 2020 17:12:38 +0100
Message-Id: <20200311161240.30190-25-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
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

