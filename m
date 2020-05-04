Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3A1C3B2D
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEDNZs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 09:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgEDNZs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 09:25:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C8F2073E;
        Mon,  4 May 2020 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588598747;
        bh=s6zgKhYeGMpzZm7FaZXhnZ7uC39Dz08UdyR6zXgqAfs=;
        h=From:To:Cc:Subject:Date:From;
        b=gyB9yBFDieuzE43xMQzzml7WalnnqXP5Xs58ZL8XBL4N2xircV0lbHpOPxR8M0VlX
         IbeSn54FJxVKRxSCiZgueUWL8iHlfMUIEhhI0E7ixt4FQmiX/NbixKJ+/Z5Ek1pTOf
         sjiT/VK31BozrvHKG9gn2944JUInVMxVM5oX7oNA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH rdma-next v1] RDMA/ucma: Return stable IB device index as identifier
Date:   Mon,  4 May 2020 16:25:41 +0300
Message-Id: <20200504132541.355710-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The librdmacm uses node_guid as identifier to correlate between
IB devices and CMA devices. However FW resets cause to such
"connection" to be lost and require from the user to restart
its application.

Extend UCMA to return IB device index, which is stable identifier.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Changelog:
v1: Fixed padding to u64 in response structures
v0: https://lore.kernel.org/linux-rdma/20200430152939.77967-1-leon@kernel.org
---
 drivers/infiniband/core/ucma.c   | 16 +++++++++-------
 include/uapi/rdma/rdma_user_cm.h |  4 ++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 99482dc5934b..d5723465478e 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -848,7 +848,7 @@ static ssize_t ucma_query_route(struct ucma_file *file,
 	struct sockaddr *addr;
 	int ret = 0;

-	if (out_len < sizeof(resp))
+	if (out_len < offsetof(struct rdma_ucm_query_route_resp, ibdev_index))
 		return -ENOSPC;

 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
@@ -872,6 +872,7 @@ static ssize_t ucma_query_route(struct ucma_file *file,
 		goto out;

 	resp.node_guid = (__force __u64) ctx->cm_id->device->node_guid;
+	resp.ibdev_index = ctx->cm_id->device->index;
 	resp.port_num = ctx->cm_id->port_num;

 	if (rdma_cap_ib_sa(ctx->cm_id->device, ctx->cm_id->port_num))
@@ -883,8 +884,8 @@ static ssize_t ucma_query_route(struct ucma_file *file,

 out:
 	mutex_unlock(&ctx->mutex);
-	if (copy_to_user(u64_to_user_ptr(cmd.response),
-			 &resp, sizeof(resp)))
+	if (copy_to_user(u64_to_user_ptr(cmd.response), &resp,
+			 min_t(size_t, out_len, sizeof(resp))))
 		ret = -EFAULT;

 	ucma_put_ctx(ctx);
@@ -898,6 +899,7 @@ static void ucma_query_device_addr(struct rdma_cm_id *cm_id,
 		return;

 	resp->node_guid = (__force __u64) cm_id->device->node_guid;
+	resp->ibdev_index = cm_id->device->index;
 	resp->port_num = cm_id->port_num;
 	resp->pkey = (__force __u16) cpu_to_be16(
 		     ib_addr_get_pkey(&cm_id->route.addr.dev_addr));
@@ -910,7 +912,7 @@ static ssize_t ucma_query_addr(struct ucma_context *ctx,
 	struct sockaddr *addr;
 	int ret = 0;

-	if (out_len < sizeof(resp))
+	if (out_len < offsetof(struct rdma_ucm_query_addr_resp, ibdev_index))
 		return -ENOSPC;

 	memset(&resp, 0, sizeof resp);
@@ -925,7 +927,7 @@ static ssize_t ucma_query_addr(struct ucma_context *ctx,

 	ucma_query_device_addr(ctx->cm_id, &resp);

-	if (copy_to_user(response, &resp, sizeof(resp)))
+	if (copy_to_user(response, &resp, min_t(size_t, out_len, sizeof(resp))))
 		ret = -EFAULT;

 	return ret;
@@ -977,7 +979,7 @@ static ssize_t ucma_query_gid(struct ucma_context *ctx,
 	struct sockaddr_ib *addr;
 	int ret = 0;

-	if (out_len < sizeof(resp))
+	if (out_len < offsetof(struct rdma_ucm_query_addr_resp, ibdev_index))
 		return -ENOSPC;

 	memset(&resp, 0, sizeof resp);
@@ -1010,7 +1012,7 @@ static ssize_t ucma_query_gid(struct ucma_context *ctx,
 						    &ctx->cm_id->route.addr.dst_addr);
 	}

-	if (copy_to_user(response, &resp, sizeof(resp)))
+	if (copy_to_user(response, &resp, min_t(size_t, out_len, sizeof(resp))))
 		ret = -EFAULT;

 	return ret;
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index e545f2de1e13..91a52e3fccaf 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -168,6 +168,8 @@ struct rdma_ucm_query_route_resp {
 	__u32 num_paths;
 	__u8 port_num;
 	__u8 reserved[3];
+	__u32 ibdev_index;
+	__u32 reserved1;
 };

 struct rdma_ucm_query_addr_resp {
@@ -179,6 +181,8 @@ struct rdma_ucm_query_addr_resp {
 	__u16 dst_size;
 	struct __kernel_sockaddr_storage src_addr;
 	struct __kernel_sockaddr_storage dst_addr;
+	__u32 ibdev_index;
+	__u32 reserved1;
 };

 struct rdma_ucm_query_path_resp {
--
2.26.2

