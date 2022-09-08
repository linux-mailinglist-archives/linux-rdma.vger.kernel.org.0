Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BD65B19AA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiIHKJX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 06:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiIHKJV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 06:09:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA68FE1246
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 03:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAC9FCE1EE3
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 10:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C0C433D6;
        Thu,  8 Sep 2022 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662631753;
        bh=yT7UVymAEci31hyjNAxM7/fjlKhIc3KYAG/RBf3X3n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uu2CgAIjw0v1zDmECVoW2/tbpe79EcQ9K6OdkuXyxdL+0vSe8OhQiEOKymi+OnZb8
         SE60Fw3qa7zl89zNfm7YmH2l5tNPStiU4Avbu/mvM7eM14M8rhqfDo6DgKzN0lQEn/
         /Lqo68RGeJ/1nvmn+nzZ5Bv/0IKPIX7qFc8AfVfaf3bciwD4j+dDBNULsMFrqdJ2gx
         P0C5fuvju/XNfArhicWfPoP6KtBdkvi4J6FyYFdqjNieP8v0w+eYtkmdy2bOqallJC
         xx+K9VVbQ4Op2gHeA/YJ0yvVIchR66kJvecBw6yYBIE3uYgJUm4wASOFjFtqrrsGZz
         GD45h9aEajghA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 1/4] RDMA/core: Rename rdma_route.num_paths field to num_pri_alt_paths
Date:   Thu,  8 Sep 2022 13:09:00 +0300
Message-Id: <cbe424de63a56207870d70c5edce7c68e45f429e.1662631201.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662631201.git.leonro@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

This fields means the total number of primary and alternative paths,
i.e.,:
  0 - No primary nor alternate path is available;
  1 - Only primary path is available;
  2 - Both primary and alternate path are available.
Rename it to avoid confusion as with follow patches primary path will
support multiple path records.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c  | 18 +++++++++---------
 drivers/infiniband/core/ucma.c | 10 +++++-----
 include/rdma/rdma_cm.h         |  7 ++++++-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 46d06678dfbe..91e72a76d95e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2241,14 +2241,14 @@ cma_ib_new_conn_id(const struct rdma_cm_id *listen_id,
 		goto err;
 
 	rt = &id->route;
-	rt->num_paths = ib_event->param.req_rcvd.alternate_path ? 2 : 1;
-	rt->path_rec = kmalloc_array(rt->num_paths, sizeof(*rt->path_rec),
-				     GFP_KERNEL);
+	rt->num_pri_alt_paths = ib_event->param.req_rcvd.alternate_path ? 2 : 1;
+	rt->path_rec = kmalloc_array(rt->num_pri_alt_paths,
+				     sizeof(*rt->path_rec), GFP_KERNEL);
 	if (!rt->path_rec)
 		goto err;
 
 	rt->path_rec[0] = *path;
-	if (rt->num_paths == 2)
+	if (rt->num_pri_alt_paths == 2)
 		rt->path_rec[1] = *ib_event->param.req_rcvd.alternate_path;
 
 	if (net_dev) {
@@ -2826,7 +2826,7 @@ static void cma_query_handler(int status, struct sa_path_rec *path_rec,
 	route = &work->id->id.route;
 
 	if (!status) {
-		route->num_paths = 1;
+		route->num_pri_alt_paths = 1;
 		*route->path_rec = *path_rec;
 	} else {
 		work->old_state = RDMA_CM_ROUTE_QUERY;
@@ -3081,7 +3081,7 @@ int rdma_set_ib_path(struct rdma_cm_id *id,
 		dev_put(ndev);
 	}
 
-	id->route.num_paths = 1;
+	id->route.num_pri_alt_paths = 1;
 	return 0;
 
 err_free:
@@ -3214,7 +3214,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 		goto err1;
 	}
 
-	route->num_paths = 1;
+	route->num_pri_alt_paths = 1;
 
 	ndev = cma_iboe_set_path_rec_l2_fields(id_priv);
 	if (!ndev) {
@@ -3274,7 +3274,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 err2:
 	kfree(route->path_rec);
 	route->path_rec = NULL;
-	route->num_paths = 0;
+	route->num_pri_alt_paths = 0;
 err1:
 	kfree(work);
 	return ret;
@@ -4265,7 +4265,7 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	}
 
 	req.primary_path = &route->path_rec[0];
-	if (route->num_paths == 2)
+	if (route->num_pri_alt_paths == 2)
 		req.alternate_path = &route->path_rec[1];
 
 	req.ppath_sgid_attr = id_priv->id.route.addr.dev_addr.sgid_attr;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 9d6ac9dff39a..bf42650f125b 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -754,8 +754,8 @@ static void ucma_copy_ib_route(struct rdma_ucm_query_route_resp *resp,
 {
 	struct rdma_dev_addr *dev_addr;
 
-	resp->num_paths = route->num_paths;
-	switch (route->num_paths) {
+	resp->num_paths = route->num_pri_alt_paths;
+	switch (route->num_pri_alt_paths) {
 	case 0:
 		dev_addr = &route->addr.dev_addr;
 		rdma_addr_get_dgid(dev_addr,
@@ -781,8 +781,8 @@ static void ucma_copy_iboe_route(struct rdma_ucm_query_route_resp *resp,
 				 struct rdma_route *route)
 {
 
-	resp->num_paths = route->num_paths;
-	switch (route->num_paths) {
+	resp->num_paths = route->num_pri_alt_paths;
+	switch (route->num_pri_alt_paths) {
 	case 0:
 		rdma_ip2gid((struct sockaddr *)&route->addr.dst_addr,
 			    (union ib_gid *)&resp->ib_route[0].dgid);
@@ -921,7 +921,7 @@ static ssize_t ucma_query_path(struct ucma_context *ctx,
 	if (!resp)
 		return -ENOMEM;
 
-	resp->num_paths = ctx->cm_id->route.num_paths;
+	resp->num_paths = ctx->cm_id->route.num_pri_alt_paths;
 	for (i = 0, out_len -= sizeof(*resp);
 	     i < resp->num_paths && out_len > sizeof(struct ib_path_rec_data);
 	     i++, out_len -= sizeof(struct ib_path_rec_data)) {
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 5b18e2e36ee6..81916039ee24 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -52,7 +52,12 @@ struct rdma_addr {
 struct rdma_route {
 	struct rdma_addr addr;
 	struct sa_path_rec *path_rec;
-	int num_paths;
+	/*
+	 * 0 - No primary nor alternate path is available
+	 * 1 - Only primary path is available
+	 * 2 - Both primary and alternate path are available
+	 */
+	int num_pri_alt_paths;
 };
 
 struct rdma_conn_param {
-- 
2.37.2

