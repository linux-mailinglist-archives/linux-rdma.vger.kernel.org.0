Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE449741E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiAWSD7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56198 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbiAWSDr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037446102E;
        Sun, 23 Jan 2022 18:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854D7C340E2;
        Sun, 23 Jan 2022 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961026;
        bh=rPm/MfJmdW9mkuVRVnSiq1klc95ya16yzGNa0zq5t7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXqveEHyi46jZ8PeVjhIHksrahnMJy16P/TtuIye4q9DMOdkVg43FJ3pWxvkyZ+JY
         /qxGiVUzVvbcgiROYzKx0k3plGSQOxxooWHa7B1YclYJ43K+NlC7bJOVo0I50QQkZO
         EvWuKINLVo7zauQ2eFmkqP6vQ4MVOwvJRKB36UBjy8AsaZUwOJqigvR/M1XJguIB1q
         Z0fZfYlZsZZUYqfnrQOGLU7eYN3sURRKk1mNVxA6lzXce1xTKkKTbnV4GMIKVb1OoC
         twqBjXDPD7iZwQOoxlGRLVzT9cdn9KZ8XaiMnKwR0BLL2rtyGSx/UICCSmEZ9QG1cZ
         P/uuU1udxa+Ug==
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
Subject: [PATCH rdma-next 07/11] RDMA/usnic: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:56 +0200
Message-Id: <745480bafd6f63c97a7049f34d84ef17dbc167d6.1642960861.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/usnic/usnic_debugfs.c   | 1 -
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c | 1 -
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  | 1 -
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  | 1 -
 drivers/infiniband/hw/usnic/usnic_transport.c | 1 -
 drivers/infiniband/hw/usnic/usnic_vnic.c      | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_debugfs.c b/drivers/infiniband/hw/usnic/usnic_debugfs.c
index e5a3f02fb078..10a8cd5ba076 100644
--- a/drivers/infiniband/hw/usnic/usnic_debugfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_debugfs.c
@@ -32,7 +32,6 @@
  */
 
 #include <linux/debugfs.h>
-#include <linux/module.h>
 
 #include "usnic.h"
 #include "usnic_log.h"
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
index 3b60fa9cb58d..59bfbfaee325 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c
@@ -32,7 +32,6 @@
  */
 #include <linux/bug.h>
 #include <linux/errno.h>
-#include <linux/module.h>
 #include <linux/spinlock.h>
 
 #include "usnic_log.h"
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index 7d868f033bbf..fdb63a8fb997 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -31,7 +31,6 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index 5a0e26cd648e..d3a9670bf971 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  *
  */
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff --git a/drivers/infiniband/hw/usnic/usnic_transport.c b/drivers/infiniband/hw/usnic/usnic_transport.c
index 82dd810bc000..dc37066900a5 100644
--- a/drivers/infiniband/hw/usnic/usnic_transport.c
+++ b/drivers/infiniband/hw/usnic/usnic_transport.c
@@ -32,7 +32,6 @@
  */
 #include <linux/bitmap.h>
 #include <linux/file.h>
-#include <linux/module.h>
 #include <linux/slab.h>
 #include <net/inet_sock.h>
 
diff --git a/drivers/infiniband/hw/usnic/usnic_vnic.c b/drivers/infiniband/hw/usnic/usnic_vnic.c
index ebe08f348453..0c47f73aaed5 100644
--- a/drivers/infiniband/hw/usnic/usnic_vnic.c
+++ b/drivers/infiniband/hw/usnic/usnic_vnic.c
@@ -31,7 +31,6 @@
  *
  */
 #include <linux/errno.h>
-#include <linux/module.h>
 #include <linux/pci.h>
 
 #include "usnic_ib.h"
-- 
2.34.1

