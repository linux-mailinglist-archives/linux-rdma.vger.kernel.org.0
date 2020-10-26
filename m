Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5029921B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 17:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775315AbgJZQP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 12:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775124AbgJZQP4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 12:15:56 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F0B22400;
        Mon, 26 Oct 2020 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728956;
        bh=WqkBUcS83VtOQSnX/TD6ZEtEOPKFuqQjQUXMWk3f5bU=;
        h=From:To:Cc:Subject:Date:From;
        b=btA7bA6RH7NP/KOcg8Btw2N2xshmuPwDmBfZZXGhze+A27KNxVyNcVjxyPGc9tg5l
         TwSLVhPRi3KAKaUJaJ08MEzLnqwOzUozATOkS02BZLL3PBKtpDtW/cAmxmvb6xMsLt
         h/vMwj43CECO+sC82PnK0UhZReXE8oW/6Z5cN0c0=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IB/verbs: avoid nested container_of()
Date:   Mon, 26 Oct 2020 17:15:39 +0100
Message-Id: <20201026161549.3709175-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Nested container_of() calls work correctly but cause a warning when
building with W=2. Invoking it from an inline function like in
drivers/infiniband/hw/mlx5/mlx5_ib.h means we get hundreds of
warnings like:

include/linux/kernel.h:852:8: warning: declaration of '__mptr' shadows a previous local [-Wshadow]
  852 |  void *__mptr = (void *)(ptr);     \
      |        ^~~~~~
include/rdma/uverbs_ioctl.h:651:11: note: in expansion of macro 'container_of'
  651 |  (udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
      |           ^~~~~~~~~~~~
include/rdma/uverbs_ioctl.h:651:24: note: in expansion of macro 'container_of'
  651 |  (udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
      |                        ^~~~~~~~~~~~
drivers/infiniband/hw/mthca/mthca_qp.c:564:35: note: in expansion of macro 'rdma_udata_to_drv_context'
  564 |  struct mthca_ucontext *context = rdma_udata_to_drv_context(
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/kernel.h:852:8: note: shadowed declaration is here
  852 |  void *__mptr = (void *)(ptr);     \
      |        ^~~~~~
include/rdma/uverbs_ioctl.h:651:11: note: in expansion of macro 'container_of'
  651 |  (udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
      |           ^~~~~~~~~~~~
drivers/infiniband/hw/mthca/mthca_qp.c:564:35: note: in expansion of macro 'rdma_udata_to_drv_context'
  564 |  struct mthca_ucontext *context = rdma_udata_to_drv_context(
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from <command-line>:
include/linux/kernel.h:852:8: warning: declaration of '__mptr' shadows a previous local [-Wshadow]
  852 |  void *__mptr = (void *)(ptr);     \
      |        ^~~~~~

Rewrite the macro to use an inline function internally, which makes
it more readable and reduces the amount of useless output from
make W=2.

Fixes: 730623f4a56f ("IB/verbs: Add helper function rdma_udata_to_drv_context")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/rdma/uverbs_ioctl.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index b00270c72740..bf167ef6c688 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -647,12 +647,15 @@ static inline bool uverbs_attr_is_valid(const struct uverbs_attr_bundle *attrs_b
  * 'ucontext'.
  *
  */
-#define rdma_udata_to_drv_context(udata, drv_dev_struct, member)               \
-	(udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
-					   driver_udata)                       \
-				      ->context,                               \
-			      drv_dev_struct, member) :                        \
-		 (drv_dev_struct *)NULL)
+static inline struct uverbs_attr_bundle *
+rdma_udata_to_uverbs_attr_bundle(struct ib_udata *udata)
+{
+	return container_of(udata, struct uverbs_attr_bundle, driver_udata);
+}
+
+#define rdma_udata_to_drv_context(udata, drv_dev_struct, member)                \
+	(udata ? container_of(rdma_udata_to_uverbs_attr_bundle(udata)->context, \
+			      drv_dev_struct, member) : (drv_dev_struct *)NULL)
 
 #define IS_UVERBS_COPY_ERR(_ret)		((_ret) && (_ret) != -ENOENT)
 
-- 
2.27.0

