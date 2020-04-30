Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130581C00A6
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgD3PnC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 11:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgD3PnB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 11:43:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A79E2076D;
        Thu, 30 Apr 2020 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588261380;
        bh=aBMbBLxgKtpTincnThjQVBU2DYWKtjRT7uBNWR11Gxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsH4VzY96bs53yIwnemZ7I1jfFaHteUYNB7aotAp29End+d9+C01vt3DQjLaYuvES
         MtV7Y+GitVNgEMB4v1H8LZRt+xm22pFFwnQYqYRt2aKvLg1q+AGA0hPIwRFzhqU8Dw
         VEES8PFEhqjnlrEbDqyVtlaP8AxcQsYHM5eqsGq0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 4/4] librdmacm: Rely on IB device index if available
Date:   Thu, 30 Apr 2020 18:42:37 +0300
Message-Id: <20200430154237.78838-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430154237.78838-1-leon@kernel.org>
References: <20200430154237.78838-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

For the kernels that support query over netlink, rely on the device
index returned and not on node_guid which doesn't identify IB device
reliably.

Change-Id: I2c6f2a2185cca626855a10ac0ea8f9fc7852902b
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 librdmacm/cma.c          | 53 +++++++++++++++++++++++++++++++---------
 librdmacm/rdma_cma_abi.h |  2 ++
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index 9855d0a8..ec6d2e72 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -74,6 +74,8 @@ do {						\
 	(req)->response = (uintptr_t) (resp);	\
 } while (0)

+#define UCMA_INVALID_IB_INDEX -1
+
 struct cma_port {
 	uint8_t			link_layer;
 };
@@ -89,6 +91,7 @@ struct cma_device {
 	int		    max_qpsize;
 	uint8_t		    max_initiator_depth;
 	uint8_t		    max_responder_resources;
+	int		    ibv_idx;
 };

 struct cma_id_private {
@@ -292,8 +295,10 @@ int ucma_init(void)
 		goto err2;
 	}

-	for (i = 0; dev_list[i]; i++)
+	for (i = 0; dev_list[i]; i++) {
 		cma_dev_array[i].guid = ibv_get_device_guid(dev_list[i]);
+		cma_dev_array[i].ibv_idx = ibv_get_device_index(dev_list[i]);
+	}

 	cma_dev_cnt = dev_cnt;
 	ucma_set_af_ib_support();
@@ -309,20 +314,31 @@ err1:
 	return ret;
 }

-static struct ibv_context *ucma_open_device(__be64 guid)
+static bool match(struct cma_device *cma_dev, __be64 guid, uint32_t idx)
+{
+	if (idx == UCMA_INVALID_IB_INDEX)
+		return cma_dev->guid == guid;
+
+	return cma_dev->ibv_idx == idx && cma_dev->guid == guid;
+}
+
+static struct ibv_context *ucma_open_device(struct cma_device *cma_dev)
 {
 	struct ibv_device **dev_list;
 	struct ibv_context *verbs = NULL;
 	int i;

 	dev_list = ibv_get_device_list(NULL);
-	if (!dev_list) {
+	if (!dev_list)
 		return NULL;
-	}

 	for (i = 0; dev_list[i]; i++) {
-		if (ibv_get_device_guid(dev_list[i]) == guid) {
-			verbs = ibv_open_device(dev_list[i]);
+		struct ibv_device *dev = dev_list[i];
+		uint32_t idx = ibv_get_device_index(dev);
+		__be64 guid = ibv_get_device_guid(dev);
+
+		if (match(cma_dev, guid, idx)) {
+			verbs = ibv_open_device(dev);
 			break;
 		}
 	}
@@ -340,7 +356,7 @@ static int ucma_init_device(struct cma_device *cma_dev)
 	if (cma_dev->verbs)
 		return 0;

-	cma_dev->verbs = ucma_open_device(cma_dev->guid);
+	cma_dev->verbs = ucma_open_device(cma_dev);
 	if (!cma_dev->verbs)
 		return ERR(ENODEV);

@@ -452,14 +468,15 @@ void rdma_destroy_event_channel(struct rdma_event_channel *channel)
 	free(channel);
 }

-static int ucma_get_device(struct cma_id_private *id_priv, __be64 guid)
+static int ucma_get_device(struct cma_id_private *id_priv, __be64 guid,
+			   uint32_t idx)
 {
 	struct cma_device *cma_dev;
 	int i, ret;

 	for (i = 0; i < cma_dev_cnt; i++) {
 		cma_dev = &cma_dev_array[i];
-		if (cma_dev->guid == guid)
+		if (match(cma_dev, guid, idx))
 			goto match;
 	}

@@ -701,6 +718,12 @@ static int ucma_query_addr(struct rdma_cm_id *id)
 	cmd.id = id_priv->handle;
 	cmd.option = UCMA_QUERY_ADDR;

+	/*
+	 * If kernel doesn't support ibdev_index, this field will
+	 * be left as is by the kernel.
+	 */
+	resp.ibdev_index = UCMA_INVALID_IB_INDEX;
+
 	ret = write(id->channel->fd, &cmd, sizeof cmd);
 	if (ret != sizeof cmd)
 		return (ret >= 0) ? ERR(ENODATA) : -1;
@@ -711,7 +734,8 @@ static int ucma_query_addr(struct rdma_cm_id *id)
 	memcpy(&id->route.addr.dst_addr, &resp.dst_addr, resp.dst_size);

 	if (!id_priv->cma_dev && resp.node_guid) {
-		ret = ucma_get_device(id_priv, resp.node_guid);
+		ret = ucma_get_device(id_priv, resp.node_guid,
+				      resp.ibdev_index);
 		if (ret)
 			return ret;
 		id->port_num = resp.port_num;
@@ -826,6 +850,12 @@ static int ucma_query_route(struct rdma_cm_id *id)
 	id_priv = container_of(id, struct cma_id_private, id);
 	cmd.id = id_priv->handle;

+	/*
+	 * If kernel doesn't support ibdev_index, this field will
+	 * be left as is by the kernel.
+	 */
+	resp.ibdev_index = UCMA_INVALID_IB_INDEX;
+
 	ret = write(id->channel->fd, &cmd, sizeof cmd);
 	if (ret != sizeof cmd)
 		return (ret >= 0) ? ERR(ENODATA) : -1;
@@ -855,7 +885,8 @@ static int ucma_query_route(struct rdma_cm_id *id)
 	       sizeof resp.dst_addr);

 	if (!id_priv->cma_dev && resp.node_guid) {
-		ret = ucma_get_device(id_priv, resp.node_guid);
+		ret = ucma_get_device(id_priv, resp.node_guid,
+				      resp.ibdev_index);
 		if (ret)
 			return ret;
 		id_priv->id.port_num = resp.port_num;
diff --git a/librdmacm/rdma_cma_abi.h b/librdmacm/rdma_cma_abi.h
index ab4adb00..cceb516f 100644
--- a/librdmacm/rdma_cma_abi.h
+++ b/librdmacm/rdma_cma_abi.h
@@ -180,6 +180,7 @@ struct ucma_abi_query_route_resp {
 	__u32 num_paths;
 	__u8 port_num;
 	__u8 reserved[3];
+	__u32 ibdev_index;
 };

 struct ucma_abi_query_addr_resp {
@@ -191,6 +192,7 @@ struct ucma_abi_query_addr_resp {
 	__u16 dst_size;
 	struct sockaddr_storage src_addr;
 	struct sockaddr_storage dst_addr;
+	__u32 ibdev_index;
 };

 struct ucma_abi_query_path_resp {
--
2.26.2

