Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32C8611C9A8
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfLLJlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfLLJlK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:10 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A343C2173E;
        Thu, 12 Dec 2019 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143670;
        bh=9u07fJhZugFMZeiz08pe2ceIS6U6CBwfyhWEJ9dGdUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnYOWEjV98fxDFpNSrYzsPOgeRojrBR28HX+iFo9b63zruEaQqc6Fhfjt+cjL78aE
         PEK0m70pugMYWGOXg1cverva/F6ft4AP+6PNoW8B6JoQRhhmOt2F0goHReY++SCfov
         YbYTVet6sNHp3GPIx9/q8onrHk8W51Y1GhgKG7lE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 43/48] RDMA/cm: Convert LAP flow label field
Date:   Thu, 12 Dec 2019 11:38:25 +0200
Message-Id: <20191212093830.316934-44-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
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
index ec2206b9dd14..b41ee97cda86 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3124,7 +3124,8 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 {
 	path->dgid = lap_msg->alt_local_gid;
 	path->sgid = lap_msg->alt_remote_gid;
-	path->flow_label = cm_lap_get_flow_label(lap_msg);
+	path->flow_label =
+		cpu_to_be32(IBA_GET(CM_LAP_ALTERNATE_FLOW_LABEL, lap_msg));
 	path->hop_limit = lap_msg->alt_hop_limit;
 	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
 	path->reversible = 1;
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 2172a5c53fbd..978eff812ce1 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -192,11 +192,6 @@ struct cm_lap_msg {
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

