Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670D51ED355
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFCP3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCP3G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 11:29:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE7C08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ScFMdV2Z8LCxdHq9mBB24jrXvESyG26CqkFOcoDuAY8=; b=ku9emOttAuZ9ETjz+/BxvVDgny
        stYCubjYGUL2d7O+cZeLyuEE1xTQ0JT3faZyFmOi7WDSdJuN8UrdezhdplTpEWSYZyXjftLXcCAoN
        CIe8d4tOpb8MTMjjLWz/v+EQI8euKZOI27U/OxpQqPKMkAWGHxybtflYNA1cb2o/sOYyBTeSGpus9
        ia3FjrkWB18e15d6WnH++gSEa8EJc5Y5dOSmIvXD2J2koaXE5OaolnDJYjvkG3MnqI0gCszeN40lo
        pbrvWmvvrzIKN9kJaQPks8HXTc7LgLKmbTI02sefwuZtBK+l3ITxtyRi8gTXEHu66Gfh70AH1WvmF
        Qg7WPcAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgVKB-0004kW-7L; Wed, 03 Jun 2020 15:29:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-rdma@vger.kernel.org, Paul Blakey <paulb@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] net/mlx5: Improve tuple ID allocation
Date:   Wed,  3 Jun 2020 08:29:01 -0700
Message-Id: <20200603152901.17985-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

There's no need to use a temporary variable; the XArray is designed to
write directly into the object being allocated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 4eb305af0106..63d392a8043d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -57,7 +57,7 @@ struct mlx5_ct_flow {
 struct mlx5_ct_zone_rule {
 	struct mlx5_flow_handle *rule;
 	struct mlx5_esw_flow_attr attr;
-	int tupleid;
+	u32 tupleid;
 	bool nat;
 };
 
@@ -484,7 +484,6 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 	struct mlx5_esw_flow_attr *attr = &zone_rule->attr;
 	struct mlx5_eswitch *esw = ct_priv->esw;
 	struct mlx5_flow_spec *spec = NULL;
-	u32 tupleid;
 	int err;
 
 	zone_rule->nat = nat;
@@ -494,17 +493,16 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 		return -ENOMEM;
 
 	/* Get tuple unique id */
-	err = xa_alloc(&ct_priv->tuple_ids, &tupleid, zone_rule,
+	err = xa_alloc(&ct_priv->tuple_ids, &zone_rule->tupleid, zone_rule,
 		       XA_LIMIT(1, TUPLE_ID_MAX), GFP_KERNEL);
 	if (err) {
 		netdev_warn(ct_priv->netdev,
 			    "Failed to allocate tuple id, err: %d\n", err);
 		goto err_xa_alloc;
 	}
-	zone_rule->tupleid = tupleid;
 
 	err = mlx5_tc_ct_entry_create_mod_hdr(ct_priv, attr, flow_rule,
-					      tupleid, nat);
+					      zone_rule->tupleid, nat);
 	if (err) {
 		ct_dbg("Failed to create ct entry mod hdr");
 		goto err_mod_hdr;
-- 
2.26.2

