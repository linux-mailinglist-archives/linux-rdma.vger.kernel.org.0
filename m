Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA53402AF
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCRKDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 06:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhCRKDe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 06:03:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EEE964F38;
        Thu, 18 Mar 2021 10:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616061813;
        bh=nnSTKMb/YbVph7iTd0PDi7d0tIkhMbxltIHumsholM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ca6OPjige6J6oj1Co/dohrR0MB6lAxrKHDAQ26B36EC6rAQrKYNHA1uhgPL0wwgvb
         3qMgrmcJkfxFwoymy7FrxLp9VmHKL8aEVjyi0NRQ2u3QRy5EKptvgZvrQrZmhTCZjB
         4/jC9ZW+MRUdNjsyX8Qvw27sp/fnM7lxZzdJxaen9HfPzwnjj7AiAPUXwNzOPc5YWo
         mTQ3RzDFSg8N4mUjCifYcuEHdrczazKN2wbFTss2Grykn1gJBJnHebgCejmHPK91Wi
         NMgS3KWaxnJSha0PHlipLRqHvf2ouZbvPSbSmHP9oBFTgmg9Be9FsmmZ5LvtzsmMTA
         /fXXIw4ZBVtow==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/6] IB/cm: Initialize av before acquire the spin lock in cm_lap_handler
Date:   Thu, 18 Mar 2021 12:03:09 +0200
Message-Id: <20210318100309.670344-7-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318100309.670344-1-leon@kernel.org>
References: <20210318100309.670344-1-leon@kernel.org>
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
index 4e6f4c6d7b2a..d4c76c85b3e8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3357,6 +3357,17 @@ static int cm_lap_handler(struct cm_work *work)
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
@@ -3391,17 +3402,6 @@ static int cm_lap_handler(struct cm_work *work)
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

