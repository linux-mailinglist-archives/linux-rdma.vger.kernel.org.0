Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1981217F37C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCJJ0S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0S (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:18 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE1F2051A;
        Tue, 10 Mar 2020 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832378;
        bh=112Ue7MhGoS6xkpLolB06P4YVn+2ZOliDbqRKV49T+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pxcr5Y0fkyCGFIiI3Igp0qIZb4Gv548PzJoXDUxyQ9jz+di6hFawA8H9awt3ZL9b5
         rYW3Lvlo7Lu59rgkVTDw0t3WVmFrsSg98k0czOQ8nVynTdjbvCdrP60BLLM/RLyQi2
         tdvpNNpilGxlgpJ/7a/zqXFZA1vuQEqwR7CZGO5o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 10/15] RDMA/cm: Add some lockdep assertions for cm_id_priv->lock
Date:   Tue, 10 Mar 2020 11:25:40 +0200
Message-Id: <20200310092545.251365-11-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

These functions all touch state, so must be called under the lock.
Inspection shows this is currently true.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d002b34bd5a3..84679f16a923 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -978,6 +978,8 @@ static void cm_enter_timewait(struct cm_id_private *cm_id_priv)
 	unsigned long flags;
 	struct cm_device *cm_dev;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	cm_dev = ib_get_client_data(cm_id_priv->id.device, &cm_client);
 	if (!cm_dev)
 		return;
@@ -1009,6 +1011,8 @@ static void cm_reset_to_idle(struct cm_id_private *cm_id_priv)
 {
 	unsigned long flags;
 
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	cm_id_priv->id.state = IB_CM_IDLE;
 	if (cm_id_priv->timewait_info) {
 		spin_lock_irqsave(&cm.lock, flags);
@@ -1838,6 +1842,8 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 			  const void *private_data,
 			  u8 private_data_len)
 {
+	lockdep_assert_held(&cm_id_priv->lock);
+
 	cm_format_mad_hdr(&rej_msg->hdr, CM_REJ_ATTR_ID, cm_id_priv->tid);
 	IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
 		be32_to_cpu(cm_id_priv->id.remote_id));
-- 
2.24.1

