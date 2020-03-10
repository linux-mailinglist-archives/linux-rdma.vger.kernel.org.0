Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1A17F32D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgCJJOr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJOr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:14:47 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E4A2467F;
        Tue, 10 Mar 2020 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831686;
        bh=TG5y+3SaRpDm7JwiPv4RCU56PrAv/yhSJZVf3wLmP7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNKLh09HlJqYVdGChXr7gpX2jlKEzznJNBPRyiZzrsuhFFzN0mJPhuIWuI+kVv8yy
         SMYzIUyWgtfI+Lnj5VsIBQ5ca+LtNk3hq0BfJtEdR3CSHnHiXWM8irAZ2QQGGoU6O9
         ktc86EPsZkYlFmP06mT4PrCfQDrUEtbpuP9gvAbQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next v1 02/11] RDMA/mlx4: Delete duplicated offsetofend implementation
Date:   Tue, 10 Mar 2020 11:14:29 +0200
Message-Id: <20200310091438.248429-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
References: <20200310091438.248429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert mlx4 to use in-kernel offsetofend() instead
of its duplicated implementation.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx4/main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 2f5d9b181848..a66518a5c938 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -434,9 +434,6 @@ int mlx4_ib_gid_index_to_real_index(struct mlx4_ib_dev *ibdev,
 	return real_index;
 }
 
-#define field_avail(type, fld, sz) (offsetof(type, fld) + \
-				    sizeof(((type *)0)->fld) <= (sz))
-
 static int mlx4_ib_query_device(struct ib_device *ibdev,
 				struct ib_device_attr *props,
 				struct ib_udata *uhw)
@@ -447,7 +444,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 	int err;
 	int have_ib_ports;
 	struct mlx4_uverbs_ex_query_device cmd;
-	struct mlx4_uverbs_ex_query_device_resp resp = {.comp_mask = 0};
+	struct mlx4_uverbs_ex_query_device_resp resp = {};
 	struct mlx4_clock_params clock_params;
 
 	if (uhw->inlen) {
@@ -602,7 +599,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 			sizeof(struct mlx4_wqe_data_seg);
 	}
 
-	if (field_avail(typeof(resp), rss_caps, uhw->outlen)) {
+	if (offsetofend(typeof(resp), rss_caps) <= uhw->outlen) {
 		if (props->rss_caps.supported_qpts) {
 			resp.rss_caps.rx_hash_function =
 				MLX4_IB_RX_HASH_FUNC_TOEPLITZ;
@@ -626,7 +623,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 				       sizeof(resp.rss_caps);
 	}
 
-	if (field_avail(typeof(resp), tso_caps, uhw->outlen)) {
+	if (offsetofend(typeof(resp), tso_caps) <= uhw->outlen) {
 		if (dev->dev->caps.max_gso_sz &&
 		    ((mlx4_ib_port_link_layer(ibdev, 1) ==
 		    IB_LINK_LAYER_ETHERNET) ||
-- 
2.24.1

