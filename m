Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29EB2220C5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGPKmE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 06:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPKmE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 06:42:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C4A2074B;
        Thu, 16 Jul 2020 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594896123;
        bh=V6OGdLr2D3t29QwhoO9f6JJQ7xpsahkvoW8LIDWqpOg=;
        h=From:To:Cc:Subject:Date:From;
        b=qS0/VfpuZuryAEe3wvKka9yUg672zAqjUd1f25Tiz+WDDCaTIir1IhjPa/yFd4BlN
         hO0UKDhYUXZjk1aV5B3qNq9YTY2p1oVgv0x/4g/hJ3H/K0ANhIVHKdhOBZxr8QeQxl
         LXvkHIB67B2w0Vs8uoTRzylAbkLg8hOI7DUBwVfc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        Alex Rosenbaum <alexr@mellanox.com>,
        linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next] IB/cm: Consider local communication ID when check for a stale connection
Date:   Thu, 16 Jul 2020 13:41:58 +0300
Message-Id: <20200716104158.1422501-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Made the check for duplicate/stale CM more strict by adding comparison
for remote communication ID field.

The absence of such strict check causes to the following flows not being
handled properly:
1. Client tries to setup more than one connection with same QP in
   a server (e.g., when use external QP), the client would reject
   the reply.
2. Client node reboots, and when it gets the same QP number as that
   of before the reboot time, the server would rejects the request.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Alex Rosenbaum <alexr@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0d1377232933..23dfba947357 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -775,12 +775,17 @@ static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
 	struct cm_timewait_info *cur_timewait_info;
 	__be64 remote_ca_guid = timewait_info->remote_ca_guid;
 	__be32 remote_qpn = timewait_info->remote_qpn;
+	__be32 remote_id = timewait_info->work.remote_id;
 
 	while (*link) {
 		parent = *link;
 		cur_timewait_info = rb_entry(parent, struct cm_timewait_info,
 					     remote_qp_node);
-		if (be32_lt(remote_qpn, cur_timewait_info->remote_qpn))
+		if (be32_lt(remote_id, cur_timewait_info->work.remote_id))
+			link = &(*link)->rb_left;
+		else if (be32_gt(remote_id, cur_timewait_info->work.remote_id))
+			link = &(*link)->rb_right;
+		else if (be32_lt(remote_qpn, cur_timewait_info->remote_qpn))
 			link = &(*link)->rb_left;
 		else if (be32_gt(remote_qpn, cur_timewait_info->remote_qpn))
 			link = &(*link)->rb_right;
-- 
2.26.2

