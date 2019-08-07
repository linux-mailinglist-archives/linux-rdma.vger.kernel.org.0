Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1500E849A5
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfHGKeb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfHGKeb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 06:34:31 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566C621E6E;
        Wed,  7 Aug 2019 10:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565174071;
        bh=sQsYb8oa6kbZFp9chjRreTMkAOUwv973c0v/4dx8DDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsgrHoCuQuYxD209Nutyl99aAOhMjlvB/UHpJcydQu7kl6w4zbmfKQkKHNKIVqwW2
         XaWiDZZz8zvlSP5I4j/tTRYYf5VSgdthPw/9+xS4Lba6l7tFTAL1nwS8YBkZAdYZjk
         Fxo2hs8vATm6HZCAID0kGrs3rr8vGGmB1RGF/ELM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: [PATCH rdma-next 3/6] RDMA/nldev: Return ODP type per MR
Date:   Wed,  7 Aug 2019 13:34:00 +0300
Message-Id: <20190807103403.8102-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807103403.8102-1-leon@kernel.org>
References: <20190807103403.8102-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Erez Alfasi <ereza@mellanox.com>

Provide an ODP explicit/implicit type indicator
as part of 'rdma resource mr show' dump.

For example:
~$: rdma resource mr show
dev mlx5_0 mrn 1 rkey 0xa99a lkey 0xa99a mrlen 50000000
pdn 9 pid 7372 odp explicit comm ibv_rc_pingpong

For non-ODP MRs, we won't print "odp ..." at all.

Signed-off-by: Erez Alfasi <ereza@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/nldev.c  | 8 ++++++++
 include/uapi/rdma/rdma_netlink.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e287b71a1cfd..1562b9446c51 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -37,6 +37,8 @@
 #include <net/netlink.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/ib_umem.h>
+#include <rdma/ib_umem_odp.h>
 
 #include "core_priv.h"
 #include "cma_priv.h"
@@ -101,6 +103,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_RES_MRLEN]		= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_RES_MRN]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_RES_MR_ENTRY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_RES_MR_ODP_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_PATH_MIG_STATE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_RES_PD]		= { .type = NLA_NESTED },
 	[RDMA_NLDEV_ATTR_RES_PDN]		= { .type = NLA_U32 },
@@ -589,6 +592,11 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			goto err;
 	}
 
+	if (mr->umem->is_odp)
+		if (nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_MR_ODP_TYPE,
+			       to_ib_umem_odp(mr->umem)->type))
+			goto err;
+
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_MRLEN, mr->length,
 			      RDMA_NLDEV_ATTR_PAD))
 		goto err;
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8e277783fa96..765771a7caf7 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -525,6 +525,11 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
 
+	/*
+	 * MR ODP type, e.g. implicit/explicit.
+	 */
+	RDMA_NLDEV_ATTR_RES_MR_ODP_TYPE,	/* u8 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.20.1

