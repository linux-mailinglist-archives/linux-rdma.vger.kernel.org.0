Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BB497412
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiAWSDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:03:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55902 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiAWSDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:03:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C6D61031;
        Sun, 23 Jan 2022 18:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B705C340E2;
        Sun, 23 Jan 2022 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642961000;
        bh=GjiOHAvRJQRdW5cmzBcDZ8FhEEi+z1roRXu4UOvfkks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvpXJeqz8wimFhKnm7tIotIhljuVPDYDaAgk1IfPbPzsJf0Wzq1g+2iBfBLxygCfQ
         0GAHk6i0xxyNE5WGUoaG2sw40fTour1i8PtVLFYMjXcfXTDrk6Ev2NV2dQa8t+Pc7B
         YXReFMsBZ+r9Igvh/ngk1qbHahcbk5KOYTHhoFQchL/yndurn4y9yDHpPK0z4TxZsr
         yJ5KHRpyZlTibGGbAO8THEUXh/uO4jzmOXWKRfQzXC9UznMrGjTOGKUg1Jap7OKrOw
         9JhYcR6l3wJBiED204UQiJa1jIrPRCRy+3WFHgT9HSV1tchIU3i998M9blIrp6kgTI
         APZ7q/IanXmDw==
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
Subject: [PATCH rdma-next 01/11] RDMA/mlx5: Delete useless module.h include
Date:   Sun, 23 Jan 2022 20:02:50 +0200
Message-Id: <3ab153e25c7ea59599022dc7fe3c409fcfe1aac1.1642960861.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/mlx5/ib_virt.c | 1 -
 drivers/infiniband/hw/mlx5/mem.c     | 1 -
 drivers/infiniband/hw/mlx5/qp.c      | 1 -
 drivers/infiniband/hw/mlx5/srq.c     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_virt.c b/drivers/infiniband/hw/mlx5/ib_virt.c
index f2f62875d072..afeb5e53254f 100644
--- a/drivers/infiniband/hw/mlx5/ib_virt.c
+++ b/drivers/infiniband/hw/mlx5/ib_virt.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
 #include <linux/mlx5/vport.h>
 #include "mlx5_ib.h"
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 844545064c9e..6191aa833ac2 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -30,7 +30,6 @@
  * SOFTWARE.
  */
 
-#include <linux/module.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 4f325a844c93..8fa6570caa1b 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -31,7 +31,6 @@
  */
 
 #include <linux/etherdevice.h>
-#include <linux/module.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_cache.h>
 #include <rdma/ib_user_verbs.h>
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 0694e9cba8d3..757756c50cc6 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013-2018, Mellanox Technologies inc.  All rights reserved.
  */
 
-#include <linux/module.h>
 #include <linux/mlx5/qp.h>
 #include <linux/slab.h>
 #include <rdma/ib_umem.h>
-- 
2.34.1

