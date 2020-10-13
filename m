Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633BC28CE0D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgJMMPf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 08:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgJMMO5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:57 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A75122400;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=Xx1nqZUs1Cn9NQ/RFywLp52tQmE9pzr1tQGxN0xfLMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLKZYwUfqS0djbTxgctSN2fB7QbIYBPSRA4YlKJTv/cs4TC6puun3kxAlJUQni4ur
         2BZNRJJUlMcZIl/xgG4uNxuAf4MlY+AkWUJklHabE3h42dfrcUvTV+q9E90uamsN8n
         zXTF9wjWHX/RSSVa8X/kpTRbmr/b/GgmolNhv70A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCf-006Coo-CF; Tue, 13 Oct 2020 14:14:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH v2 23/24] RDMA: add a missing kernel-doc parameter markup
Date:   Tue, 13 Oct 2020 14:14:50 +0200
Message-Id: <6b2ed339933d066622d5715903870676d8cc523a.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602590106.git.mchehab+huawei@kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changeset 54816d3e69d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
added a new parameter to ib_register_device().

Document it.

Fixes: 54816d3e69d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/infiniband/core/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index feaec8d2f0ca..a3b1fc84cdca 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1318,7 +1318,10 @@ static void prevent_dealloc_device(struct ib_device *ib_dev)
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
  * @name: unique string device name. This may include a '%' which will
- * cause a unique index to be added to the passed device name.
+ * 	  cause a unique index to be added to the passed device name.
+ * @dma_device: pointer to a DMA-capable device. If %NULL, then the IB
+ *	        device will be used. In this case the caller should fully
+ *		setup the ibdev for DMA. This usually means using dma_virt_ops.
  *
  * Low-level drivers use ib_register_device() to register their
  * devices with the IB core.  All registered clients will receive a
-- 
2.26.2

