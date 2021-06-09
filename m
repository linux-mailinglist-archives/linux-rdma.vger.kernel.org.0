Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE9D3A11F8
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhFILB0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 07:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235843AbhFILBZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 07:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1397B6136D;
        Wed,  9 Jun 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623236370;
        bh=hawZVUXye10SHmSE8BbW1Adn+u8wdEz8D70FNM/p/ow=;
        h=From:To:Cc:Subject:Date:From;
        b=I5Zd+n0T3syBuzrroz7Udd5xRxBeLjphh31KHH3D2d+zCIO/BsRt3FzlzkGDd7055
         SF/+Om8NIyh5i/n4fN/hZDGV27dSSw2fuBGyc0A8ZrD9LFOLz1mtdBfHc3+OiKfyJV
         N8aQ5HtaP6fJdW32VBZnM19prlCW6zjgmRxcP/IULdZeMLmWzaSGDc4fTD2goCGVML
         uebKrfvP/Omvh523OhEabwzigW6xHE47zTioBBaoY7ej/ueFxgaEcI2SK9MHLY4hfk
         IDzMq63GRTYNnfuPdGqqp7yjXrFbJO7Sb4n5zD20FxHKJZSzbwZq6iruH1paiJUbhF
         aMJkhPSG5kH0Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next] IB/cm: Remove dgid from the cm_id_priv av
Date:   Wed,  9 Jun 2021 13:59:25 +0300
Message-Id: <2e7c87b6f662c90c642fc1838e363ad3e6ef14a4.1623236345.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

It turns out this is only being used to store the LID for SIDR mode to
search the RB tree for request de-duplication. Store the LID value
directly and don't pretend it is a GID.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 1827118c41e3..4a92729068eb 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -174,7 +174,6 @@ struct cm_device {
 
 struct cm_av {
 	struct cm_port *port;
-	union ib_gid dgid;
 	struct rdma_ah_attr ah_attr;
 	u16 pkey_index;
 	u8 timeout;
@@ -207,6 +206,7 @@ struct cm_id_private {
 
 	struct rb_node service_node;
 	struct rb_node sidr_id_node;
+	u32 sidr_slid;
 	spinlock_t lock;	/* Do not acquire inside cm.lock */
 	struct completion comp;
 	refcount_t refcount;
@@ -785,7 +785,6 @@ cm_insert_remote_sidr(struct cm_id_private *cm_id_priv)
 	struct rb_node **link = &cm.remote_sidr_table.rb_node;
 	struct rb_node *parent = NULL;
 	struct cm_id_private *cur_cm_id_priv;
-	union ib_gid *port_gid = &cm_id_priv->av.dgid;
 	__be32 remote_id = cm_id_priv->id.remote_id;
 
 	while (*link) {
@@ -797,12 +796,9 @@ cm_insert_remote_sidr(struct cm_id_private *cm_id_priv)
 		else if (be32_gt(remote_id, cur_cm_id_priv->id.remote_id))
 			link = &(*link)->rb_right;
 		else {
-			int cmp;
-			cmp = memcmp(port_gid, &cur_cm_id_priv->av.dgid,
-				     sizeof *port_gid);
-			if (cmp < 0)
+			if (cur_cm_id_priv->sidr_slid < cm_id_priv->sidr_slid)
 				link = &(*link)->rb_left;
-			else if (cmp > 0)
+			else if (cur_cm_id_priv->sidr_slid > cm_id_priv->sidr_slid)
 				link = &(*link)->rb_right;
 			else
 				return cur_cm_id_priv;
@@ -3568,8 +3564,7 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	cm_id_priv->tid = sidr_req_msg->hdr.tid;
 
 	wc = work->mad_recv_wc->wc;
-	cm_id_priv->av.dgid.global.subnet_prefix = cpu_to_be64(wc->slid);
-	cm_id_priv->av.dgid.global.interface_id = 0;
+	cm_id_priv->sidr_slid = wc->slid;
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
 				      &cm_id_priv->av);
-- 
2.31.1

