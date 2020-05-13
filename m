Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E331D0D2A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgEMJuv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 05:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbgEMJuv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 05:50:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471B720575;
        Wed, 13 May 2020 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363451;
        bh=rr6bFSxZIxGM0QoBtOVzKIu40b9F3dN63WdCDRYmzg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w21xLPGyIjDVLO8jMbTXCLpEbHHr4n0dz8pZayt7Dqgtt6Y/2bnXSqvy5afRedOb4
         nCBVbdHcrQDLu5H4OtNY0ePb1UgfC/c1OWBA6Gs4OM3PDx1HsS0SM6DCy3cUPMlmeU
         076/wI5eeZkbTsHuQU7NDRIIZ5o7up5boPtuulIA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 04/14] RDMA/core: Allow to override device op
Date:   Wed, 13 May 2020 12:50:24 +0300
Message-Id: <20200513095034.208385-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513095034.208385-1-leon@kernel.org>
References: <20200513095034.208385-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Current device ops implementation allows only two stages "set"/"not set"
and requires caller to check if function pointer exists before
calling it.

In order to simplify this repetitive task, let's give an option to
overwrite those pointers. This will allow us to set dummy functions
for the specific function pointers.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d9f565a779df..9486e60b42cc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2542,11 +2542,10 @@ EXPORT_SYMBOL(ib_get_net_dev_by_params);
 void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 {
 	struct ib_device_ops *dev_ops = &dev->ops;
-#define SET_DEVICE_OP(ptr, name)                                               \
-	do {                                                                   \
-		if (ops->name)                                                 \
-			if (!((ptr)->name))				       \
-				(ptr)->name = ops->name;                       \
+#define SET_DEVICE_OP(ptr, name)					\
+	do {								\
+		if (ops->name)						\
+			(ptr)->name = ops->name;			\
 	} while (0)
 
 #define SET_OBJ_SIZE(ptr, name) SET_DEVICE_OP(ptr, size_##name)
-- 
2.26.2

