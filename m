Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57549740E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiAWSDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51858 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiAWSDN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F763B80DE2;
        Sun, 23 Jan 2022 18:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBE9C340E2;
        Sun, 23 Jan 2022 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642960990;
        bh=QM74zjTB/Y5FBJZy+Z8avdL2zj0ZPAtA0BhDZQJTknY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7JmaeKb0sDGfF+OrJWjcKvbFLnK9qL7ZWC+NZIsfWVGgjOD3C8zcuUmWmrRepG/e
         OjaYyiYyAip8c6uQ0vVGS7lmAQMfg+5l+MAeWm7A/Bqeq4+nXwxjc7Fv+QgCABMH3d
         LGDqG14ERwE8/cGJMagB21lUm9kY9OP+a+i1WD4wFVNWdoDAH595eKLyqf+2UB/OBm
         SObnFYwvj/6jCJ9vA70pdzWXc8ie8BDpXC7ZxPVZ3RFS6AAEEvtrkd+o+96GCudp6z
         VLSrGI0dgtCzkmX45wblEg/aZCjek2tQQVVkQAt6kKxpKfgp2lh80MCSoKwH+JVeXD
         lb80vQ5kQwOug==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 02/11] RDMA/core: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:51 +0200
Message-Id: <e412c83b45b6ebdd937886cc9c2cc7c8abcc34fa.1642960861.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642960861.git.leonro@nvidia.com>
References: <cover.1642960861.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need in include of module.h in the following files.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/addr.c         | 1 -
 drivers/infiniband/core/cache.c        | 1 -
 drivers/infiniband/core/cma_configfs.c | 1 -
 drivers/infiniband/core/cq.c           | 1 -
 drivers/infiniband/core/iwpm_util.h    | 1 -
 drivers/infiniband/core/sa_query.c     | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 65e3e7df8a4b..f253295795f0 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -37,7 +37,6 @@
 #include <linux/inetdevice.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
-#include <linux/module.h>
 #include <net/arp.h>
 #include <net/neighbour.h>
 #include <net/route.h>
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index f6aa1a964573..4084d05a4510 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -34,7 +34,6 @@
  */
 
 #include <linux/if_vlan.h>
-#include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index 9ac16e0db761..de8a2d5d741c 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
 #include <linux/configfs.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 433b426729d4..a70876a0a231 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2015 HGST, a Western Digital Company.
  */
-#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <rdma/ib_verbs.h>
diff --git a/drivers/infiniband/core/iwpm_util.h b/drivers/infiniband/core/iwpm_util.h
index 3a42ad43056e..d6fc8402158a 100644
--- a/drivers/infiniband/core/iwpm_util.h
+++ b/drivers/infiniband/core/iwpm_util.h
@@ -33,7 +33,6 @@
 #ifndef _IWPM_UTIL_H
 #define _IWPM_UTIL_H
 
-#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/in.h>
 #include <linux/in6.h>
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 74ecd7456a11..8dc7d1f4b35d 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -32,7 +32,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/random.h>
-- 
2.34.1

