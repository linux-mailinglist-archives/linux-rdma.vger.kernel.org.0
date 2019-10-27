Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C90E615B
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfJ0HIr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HIq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:08:46 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5390020578;
        Sun, 27 Oct 2019 07:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160126;
        bh=XqusfRdj7uXgS/d8ah+wT4az8aIxjBWgl8p5V35JQ4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfGFsWj8ZJHohoo32vN4uv50Yd9JmgrvNWtWVp9i7FLIVp7OYsUK6PWTXxMxk98hK
         tJ+tdWM3SrOVLO6j6rJHSjWHp5CZHVjMTXcwKpw8WYXGgpUxzyHmeWFyWL2WaVKkea
         3+RfHR+OMgRv4bcZd1JO4tU1mq6zaAjdbstros0s=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 40/43] RDMA/cm: Convert LAP flow label field
Date:   Sun, 27 Oct 2019 09:06:18 +0200
Message-Id: <20191027070621.11711-41-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027070621.11711-1-leon@kernel.org>
References: <20191027070621.11711-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert LAP flow label field.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 3 ++-
 drivers/infiniband/core/cm_msgs.h | 5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 25a20c04e07b..2fe1e8908445 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3121,7 +3121,8 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 {
 	path->dgid = lap_msg->alt_local_gid;
 	path->sgid = lap_msg->alt_remote_gid;
-	path->flow_label = cm_lap_get_flow_label(lap_msg);
+	path->flow_label =
+		cpu_to_be32(CM_GET(LAP_ALTERNATE_FLOW_LABEL, lap_msg));
 	path->hop_limit = lap_msg->alt_hop_limit;
 	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
 	path->reversible = 1;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 41193dc44fee..fa475a59ed53 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -522,11 +522,6 @@ struct cm_lap_msg {
 	u8 private_data[CM_LAP_PRIVATE_DATA_SIZE];
 } __packed;
 
-static inline __be32 cm_lap_get_flow_label(struct cm_lap_msg *lap_msg)
-{
-	return cpu_to_be32(be32_to_cpu(lap_msg->offset56) >> 12);
-}
-
 static inline u8 cm_lap_get_traffic_class(struct cm_lap_msg *lap_msg)
 {
 	return (u8) be32_to_cpu(lap_msg->offset56);
-- 
2.20.1

