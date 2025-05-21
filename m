Return-Path: <linux-rdma+bounces-10478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F4BABF2EB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 13:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4791A4E2A74
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B443263F3D;
	Wed, 21 May 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng+1j+Tp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A562638BA
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827304; cv=none; b=DdVGmwGIjDelHW8O71rONZsclWpewrK8vYrz3mecFsK22835WczrPBedwAlRgYDDoYf9N/BK67969nvMr5PE4YTJkaZbi+7mpeY4pAPbxOo/GWEGC6NIi5budJInUEnLk150BQsMfOLZT2B3mr8r2aCz8D4ENoTq3mMTmUQ+6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827304; c=relaxed/simple;
	bh=7ZuEQXF3LCnjONyYKkd9K2MS9bAifC9p9YjDAODChVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geJaIxQDAO61DeZ5GBvIpOl2s6xk7kByZHuodmWnT0tGKY+Qpc7Vl79aqr54tVt2mBcXfK3AmiRgNQ9G4smpzq0Z/Jtv9ZbW9pOxt+cV9rQTnVXPcQeF8RC/dj5DVJaYpTq+doTnLO9LFSADSZzuXIQ0tPPbKKWdRF0/qiZxRpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng+1j+Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8022EC4CEE4;
	Wed, 21 May 2025 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747827303;
	bh=7ZuEQXF3LCnjONyYKkd9K2MS9bAifC9p9YjDAODChVk=;
	h=From:To:Cc:Subject:Date:From;
	b=ng+1j+Tpf3ezoqq5GEgoKpRQ8qOAFKyv6/xyj8NrpPkxlhE0ajHVN6fyyMx3C7DZH
	 JMKTaTuW2AwbwnxukAPhZy0Xqkcdq1a2LbCAdgPmqPnJompfloiViSa/LLWq3CxGoI
	 RduMh0leRSSjVYZBzUtdvTgIND4qEuo2umumN8SJRu6q0BUO56m/4pHQ3ZYWVJCOym
	 Km10xYC/GOmUckwOhBMcHJl+P5OiDH4C7kQNTeRMIZolUOrbc94yVrsfSXktRYrJhx
	 D9k+uoGdynYBgnviPt7Z0AWAuqr3oZiwXU5zVgWEFlaKAscyqyHHnemaxYHk3p1DxI
	 McNpXvZvXyx1w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Avoid flexible array warning
Date: Wed, 21 May 2025 14:34:58 +0300
Message-ID: <7b891b96a9fc053d01284c184d25ae98d35db2d4.1747827041.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The following warning is reported by sparse tool:
drivers/infiniband/hw/mlx5/fs.c:1664:26: warning: array of flexible
structures

Avoid it by simply splitting array into two separate structs.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 58 ++++++++++++---------------------
 1 file changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 251246c73b339..1d67f0ce6b59a 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1645,11 +1645,6 @@ static struct mlx5_ib_flow_handler *create_flow_rule(struct mlx5_ib_dev *dev,
 	return _create_flow_rule(dev, ft_prio, flow_attr, dst, 0, NULL);
 }
 
-enum {
-	LEFTOVERS_MC,
-	LEFTOVERS_UC,
-};
-
 static struct mlx5_ib_flow_handler *create_leftovers_rule(struct mlx5_ib_dev *dev,
 							  struct mlx5_ib_flow_prio *ft_prio,
 							  struct ib_flow_attr *flow_attr,
@@ -1659,43 +1654,32 @@ static struct mlx5_ib_flow_handler *create_leftovers_rule(struct mlx5_ib_dev *de
 	struct mlx5_ib_flow_handler *handler = NULL;
 
 	static struct {
-		struct ib_flow_attr	flow_attr;
 		struct ib_flow_spec_eth eth_flow;
-	} leftovers_specs[] = {
-		[LEFTOVERS_MC] = {
-			.flow_attr = {
-				.num_of_specs = 1,
-				.size = sizeof(leftovers_specs[0])
-			},
-			.eth_flow = {
-				.type = IB_FLOW_SPEC_ETH,
-				.size = sizeof(struct ib_flow_spec_eth),
-				.mask = {.dst_mac = {0x1} },
-				.val =  {.dst_mac = {0x1} }
-			}
-		},
-		[LEFTOVERS_UC] = {
-			.flow_attr = {
-				.num_of_specs = 1,
-				.size = sizeof(leftovers_specs[0])
-			},
-			.eth_flow = {
-				.type = IB_FLOW_SPEC_ETH,
-				.size = sizeof(struct ib_flow_spec_eth),
-				.mask = {.dst_mac = {0x1} },
-				.val = {.dst_mac = {} }
-			}
-		}
-	};
+		struct ib_flow_attr	flow_attr;
+	} leftovers_wc = { .flow_attr = { .num_of_specs = 1,
+					  .size = sizeof(leftovers_wc) },
+			   .eth_flow = {
+				   .type = IB_FLOW_SPEC_ETH,
+				   .size = sizeof(struct ib_flow_spec_eth),
+				   .mask = { .dst_mac = { 0x1 } },
+				   .val = { .dst_mac = { 0x1 } } } };
 
-	handler = create_flow_rule(dev, ft_prio,
-				   &leftovers_specs[LEFTOVERS_MC].flow_attr,
-				   dst);
+	static struct {
+		struct ib_flow_spec_eth eth_flow;
+		struct ib_flow_attr	flow_attr;
+	} leftovers_uc = { .flow_attr = { .num_of_specs = 1,
+					  .size = sizeof(leftovers_uc) },
+			   .eth_flow = {
+				   .type = IB_FLOW_SPEC_ETH,
+				   .size = sizeof(struct ib_flow_spec_eth),
+				   .mask = { .dst_mac = { 0x1 } },
+				   .val = { .dst_mac = {} } } };
+
+	handler = create_flow_rule(dev, ft_prio, &leftovers_wc.flow_attr, dst);
 	if (!IS_ERR(handler) &&
 	    flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT) {
 		handler_ucast = create_flow_rule(dev, ft_prio,
-						 &leftovers_specs[LEFTOVERS_UC].flow_attr,
-						 dst);
+						 &leftovers_uc.flow_attr, dst);
 		if (IS_ERR(handler_ucast)) {
 			mlx5_del_flow_rules(handler->rule);
 			ft_prio->refcount--;
-- 
2.49.0


