Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA413BB95
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfFJSEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 14:04:12 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43797 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbfFJSEM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 14:04:12 -0400
Received: by mail-vs1-f65.google.com with SMTP id d128so6025092vsc.10
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWe3NcrFQdRudgG+4quXEcAvCA4xjSy6qCu4ofCqJro=;
        b=YhXn3+jY+qCeqHdZs2p0FFOdiAhpFH06ccdyFkA6WAe4NCxoz49sK3J+Ayw3+JP0Qt
         +HNtko9bxJ4fPGgh9I/iVTMwkW0PBc+D62olv+zhX7CpEOFHydIpQwkKOadL9TfDOP5f
         a7Z+HXYC79HXbQoUqCzXX/bD+a1zHJXB3gMPFDZisO9jxeCiUN5N95dbQ+I+KdkIqBWx
         8u4qAyWeX15ZYteGz8DgNk7/UjkAB8sBRtABnew1Y/7UU/kXJA+qGxqXbXA6MrBfVcXs
         5zuzmBu6+XnA6stCKYLl282XK6v7DjET9OH2BUIkpE0GILTRzAn6G6qgRCTdrI0kq1EF
         HdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWe3NcrFQdRudgG+4quXEcAvCA4xjSy6qCu4ofCqJro=;
        b=AmKj5F1NlgLo5APGay3FySpkbuNmZaoWVJAIYaoFnen89L1dn6pDBbDjddfHFK3/wW
         t8xj6HF2Pwm7jmEpkpWZulHsEzLB8VFFeYwMthysx0Z/HOO73qyWe2Q+guxdNPZx9/0C
         pb+VlsGTEsybRCZ5fQIbmfP5Sw8pDjOgeLlHg/KyxztX4xaT4CXW7RzuHT1rGZZN/01l
         pe+XTGWmh4Dd74lBRX93qeT4MUC8NRqmLonLeqcObZ4KEvTg9UZQOIffr1ByNAYzzIW0
         BRtvlociFGJ7gSu68UJc4gEcyqKKzN/YWpGK87WvM5TMWcM+VhA3Kb5yKxnjVs0FqWlw
         7Usw==
X-Gm-Message-State: APjAAAXUanvBq5INt3nAM5s74eLlEkCVNdD45jjTk5nC82xxeA1ahmeW
        /93U0pSw7mchDR44DtUWKHg3JK0CzPcm4A==
X-Google-Smtp-Source: APXvYqy3ypt6IASA9hzUpS1WBX0JcWldfQglP3/6gjMjtyKRG3437VpvjYgeFhqbBxR6rwU/5igkMw==
X-Received: by 2002:a67:8b44:: with SMTP id n65mr32629025vsd.99.1560189851190;
        Mon, 10 Jun 2019 11:04:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z21sm2990842vsk.30.2019.06.10.11.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 11:04:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haOeQ-0002uW-A1; Mon, 10 Jun 2019 15:04:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH] rdma: Delete the ib_ucm module
Date:   Mon, 10 Jun 2019 15:04:07 -0300
Message-Id: <20190610180407.11104-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This has been marked CONFIG_BROKEN for over a year now with no complaints.
Delete the whole thing for good.

The module provided the /dev/infiniband/ucmX interface.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/Kconfig       |   11 -
 drivers/infiniband/core/Makefile |    3 -
 drivers/infiniband/core/ucm.c    | 1350 ------------------------------
 include/uapi/rdma/ib_user_cm.h   |  326 --------
 4 files changed, 1690 deletions(-)
 delete mode 100644 drivers/infiniband/core/ucm.c
 delete mode 100644 include/uapi/rdma/ib_user_cm.h

Leon points out it is time for this to go, so let it be so.

This is just deleting, so I'm going to queue it to wip right now.

Jason

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cbfbea49f126cd..cbaafa4e030269 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -35,17 +35,6 @@ config INFINIBAND_USER_ACCESS
 	  libibverbs, libibcm and a hardware driver library from
 	  rdma-core <https://github.com/linux-rdma/rdma-core>.
 
-config INFINIBAND_USER_ACCESS_UCM
-	tristate "Userspace CM (UCM, DEPRECATED)"
-	depends on BROKEN || COMPILE_TEST
-	depends on INFINIBAND_USER_ACCESS
-	help
-	  The UCM module has known security flaws, which no one is
-	  interested to fix. The user-space part of this code was
-	  dropped from the upstream a long time ago.
-
-	  This option is DEPRECATED and planned to be removed.
-
 config INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI
 	bool "Allow experimental legacy verbs in new ioctl uAPI  (EXPERIMENTAL)"
 	depends on INFINIBAND_USER_ACCESS
diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 313f2349b51843..42f1b2a4f74662 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_INFINIBAND) +=		ib_core.o ib_cm.o iw_cm.o \
 					$(infiniband-y)
 obj-$(CONFIG_INFINIBAND_USER_MAD) +=	ib_umad.o
 obj-$(CONFIG_INFINIBAND_USER_ACCESS) += ib_uverbs.o $(user_access-y)
-obj-$(CONFIG_INFINIBAND_USER_ACCESS_UCM) += ib_ucm.o $(user_access-y)
 
 ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o fmr_pool.o cache.o netlink.o \
@@ -29,8 +28,6 @@ rdma_ucm-y :=			ucma.o
 
 ib_umad-y :=			user_mad.o
 
-ib_ucm-y :=			ucm.o
-
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
deleted file mode 100644
index 8e7da2d41fd80f..00000000000000
diff --git a/include/uapi/rdma/ib_user_cm.h b/include/uapi/rdma/ib_user_cm.h
deleted file mode 100644
index e2709bb8cb1802..00000000000000
-- 
2.21.0

