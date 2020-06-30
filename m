Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7AA20F1CA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbgF3Jj1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 05:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgF3JjZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B8E206A1;
        Tue, 30 Jun 2020 09:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593509965;
        bh=dbjcsyelM+YIGy3/tBnfYnaHL+fcVDLLoR7VPqUboNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIqDmJ2w+P7sL4Lun0HmyMerrgRvwrjF2D070NCt9Nu58A/3qNJIkydZgOLSE8Jhs
         tt/h7jNRUOGZJRtIo0NMSRkVuhzQkP1GNtRpwXmMRxCdeuo//nWC8wRUytOsM+eKQF
         of+KdnwtsERtPWGNenM3ij3LCEOWOCQvOSTSxlkw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 1/7] IB/uverbs: Enable CQ ioctl commands by default
Date:   Tue, 30 Jun 2020 12:39:10 +0300
Message-Id: <20200630093916.332097-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630093916.332097-1-leon@kernel.org>
References: <20200630093916.332097-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Enable CQ ioctl commands by default, this functionality is fully mature
to be used over ioctl, no reason to maintain any more the EXP KCONFIG
entry to enable it.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/Kconfig                    | 8 --------
 drivers/infiniband/core/uverbs_std_types_cq.c | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a83f9eb86bfe..91b023341b77 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -37,14 +37,6 @@ config INFINIBAND_USER_ACCESS
 	  libibverbs, libibcm and a hardware driver library from
 	  rdma-core <https://github.com/linux-rdma/rdma-core>.
 
-config INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI
-	bool "Allow experimental legacy verbs in new ioctl uAPI  (EXPERIMENTAL)"
-	depends on INFINIBAND_USER_ACCESS
-	help
-	  IOCTL based uAPI support for Infiniband is enabled by default for
-	  new verbs only. This allows userspace to invoke the IOCTL based uAPI
-	  for current legacy verbs too.
-
 config INFINIBAND_USER_MEM
 	bool
 	depends on INFINIBAND_USER_ACCESS != n
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 5dce2c7cc323..b1c7dacc02de 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -207,11 +207,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_CQ,
 	UVERBS_TYPE_ALLOC_IDR_SZ(sizeof(struct ib_ucq_object), uverbs_free_cq),
-
-#if IS_ENABLED(CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI)
 	&UVERBS_METHOD(UVERBS_METHOD_CQ_CREATE),
 	&UVERBS_METHOD(UVERBS_METHOD_CQ_DESTROY)
-#endif
 );
 
 const struct uapi_definition uverbs_def_obj_cq[] = {
-- 
2.26.2

