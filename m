Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA90C458DE4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbhKVL5T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239459AbhKVL5R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 06:57:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EEFB60240;
        Mon, 22 Nov 2021 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637582051;
        bh=/UfjuMxMloWjQpp8SissYGZGqNvquzZ24EkrpWjAC5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIBxA2I2WJLo3WLcVV3hVNDt2532jANyjR/0SWi1Um+HR5RRxrCjt0tRMeL40Uv6C
         qipCkUGUKiaAL3mt3n/WachkMcJbT//KRGFtnk+F3f9UxyNvS5xn7nBl+vqbFaiLz8
         8zTSuJ3DeTb+HwiFuS+DY31PHYAO6XLYnIZn+vWckBUhqzHTpdb7DwUuclb6f1IR/V
         PDcvOrTVYfJks8408vDR7P8YcHlCe2bG1L5fm3qA1OQRE+6+h/Wl/z3LL4E6ZTQsUG
         zGC7bOcQ1nc11YFs77CUaEhZJ0TAcxdof5jRJ3bc+wpxT2nrbKc6vQiUmFJqjD3Hr+
         gZ2tfsI8g35VA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 3/3] RDMA/cma: Let cma_resolve_ib_dev() continue search even after empty entry
Date:   Mon, 22 Nov 2021 13:53:58 +0200
Message-Id: <3e133449a4c7484cafc0fe6bd7f9dbaec63a0c87.1637581778.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637581778.git.leonro@nvidia.com>
References: <cover.1637581778.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Currently, when cma_resolve_ib_dev() searches for a matching GID it will
stop searching after encountering the first empty GID table entry. This
behavior is wrong since neither IB nor RoCE spec enforce tightly packed
GID tables.

For example, when the matching valid GID entry exists at index N, and if
a GID entry is empty at index N-1, cma_resolve_ib_dev() will fail to
find the matching valid entry.

Fix it by making cma_resolve_ib_dev() continue searching even after
encountering missing entries.

Fixes: f17df3b0dede ("RDMA/cma: Add support for AF_IB to rdma_resolve_addr()")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 835ac54d4a24..b669002c9255 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -766,6 +766,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	unsigned int p;
 	u16 pkey, index;
 	enum ib_port_state port_state;
+	int ret;
 	int i;
 
 	cma_dev = NULL;
@@ -784,9 +785,16 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 			if (ib_get_cached_port_state(cur_dev->device, p, &port_state))
 				continue;
-			for (i = 0; !rdma_query_gid(cur_dev->device,
-						    p, i, &gid);
-			     i++) {
+
+			for (i = 0; i < cur_dev->device->port_data[p].immutable.gid_tbl_len;
+			     ++i) {
+				ret = rdma_query_gid(cur_dev->device, p, i,
+						     &gid);
+				if (ret == -ENOENT)
+					continue;
+				if (ret)
+					break;
+
 				if (!memcmp(&gid, dgid, sizeof(gid))) {
 					cma_dev = cur_dev;
 					sgid = gid;
-- 
2.33.1

