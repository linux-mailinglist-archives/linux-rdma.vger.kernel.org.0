Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB51C6D55
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 11:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgEFJmD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 05:42:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:55215 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729084AbgEFJmD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 05:42:03 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0oO015451;
        Wed, 6 May 2020 12:42:00 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0469g0O5024596;
        Wed, 6 May 2020 12:42:00 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0469g0Xq024595;
        Wed, 6 May 2020 12:42:00 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 4/8] verbs: Fix ibv_get_srq_num() man page
Date:   Wed,  6 May 2020 12:41:05 +0300
Message-Id: <1588758069-24464-5-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
References: <1588758069-24464-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix ibv_get_srq_num() man page to mention that it's applicable only when
the given SRQ is an XRC as defined by its specification.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/man/ibv_get_srq_num.3.md | 2 +-
 providers/mlx5/verbs.c              | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/libibverbs/man/ibv_get_srq_num.3.md b/libibverbs/man/ibv_get_srq_num.3.md
index f015b9e..9140a37 100644
--- a/libibverbs/man/ibv_get_srq_num.3.md
+++ b/libibverbs/man/ibv_get_srq_num.3.md
@@ -23,7 +23,7 @@ int ibv_get_srq_num(struct ibv_srq *srq, uint32_t *srq_num);
 
 # DESCRIPTION
 
-**ibv_get_srq_num()** return srq number associated with the given shared
+**ibv_get_srq_num()** return srq number associated with the given XRC shared
 receive queue The argument *srq* is an ibv_srq struct, as defined in
 <infiniband/verbs.h>. *srq_num* is an output parameter that holds the returned
 srq number.
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 47e8380..1835e93 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -2898,8 +2898,12 @@ int mlx5_get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
 {
 	struct mlx5_srq *msrq = to_msrq(srq);
 
+	/* May be used by DC users in addition to XRC ones, as there is no
+	 * indication on the SRQ for DC usage we can't force the above check.
+	 * Even DC users are encouraged to use mlx5dv_init_obj() to get
+	 * the SRQN.
+	 */
 	*srq_num = msrq->srqn;
-
 	return 0;
 }
 
-- 
1.8.3.1

