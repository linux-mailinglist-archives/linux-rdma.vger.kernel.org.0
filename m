Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F335B418
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhDKMW1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 08:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKMW1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 08:22:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45344610C8;
        Sun, 11 Apr 2021 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618143731;
        bh=5gS33VzRbpbM/be/JYJZAGOlBx+QllBzQbR5P1kJs0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKYjaDmMYGI7O/RLYsCvNNilYSqxdRDFlpTfrhz+nNbllUKbmHDDHgij/r62lPcjs
         A7a90Ur28Ru6Bk4ZOZA0HJoXfAXozivtgQI29SAU4P0HFC+yI/lMc7LVUx0j65DT2P
         4IPpjzVRcOI4K4NV4lYkLEgo0ztDIVi39rh64yHQb9pxw8Sx0ZHT6eDrXPhlNT1mUN
         dn8sXlAg13kvnQk5gnC4zLLwuUqWQDtWfVXP6506eSXfd1OeIf6Xart5gPeY8U/4qz
         U3gjTujQDpqixCRYoINPyWivmUD1vWd9gOYdwTPgM+YZLUmCy4hIo/Bp4dMiQ92V7i
         DQospAFuTZZdA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 5/5] IB/cm: Initialize av before aquire the spin lock in cm_lap_handler
Date:   Sun, 11 Apr 2021 15:21:52 +0300
Message-Id: <20210411122152.59274-6-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210411122152.59274-1-leon@kernel.org>
References: <20210411122152.59274-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Both cm_init_av_for_lap and cm_init_av_by_path and might sleep and should
not be called within a spin_lock.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d8368d71ac7c..5ca328f3e34a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3364,6 +3364,17 @@ static int cm_lap_handler(struct cm_work *work)
 	work->cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
 
+	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
+				 work->mad_recv_wc->recv_buf.grh,
+				 cm_id_priv);
+	if (ret)
+		goto deref;
+
+	ret = cm_init_av_by_path(param->alternate_path, NULL,
+				 cm_id_priv, false);
+	if (ret)
+		goto deref;
+
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
 		goto unlock;
@@ -3398,17 +3409,6 @@ static int cm_lap_handler(struct cm_work *work)
 		goto unlock;
 	}
 
-	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
-				 work->mad_recv_wc->recv_buf.grh,
-				 cm_id_priv);
-	if (ret)
-		goto unlock;
-
-	ret = cm_init_av_by_path(param->alternate_path, NULL,
-				 cm_id_priv, false);
-	if (ret)
-		goto unlock;
-
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
 	cm_queue_work_unlock(cm_id_priv, work);
-- 
2.30.2

