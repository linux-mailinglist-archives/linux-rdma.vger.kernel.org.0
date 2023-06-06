Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0E672388E
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 09:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjFFHNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbjFFHMs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 03:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB02E76
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 00:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0180B61E04
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 07:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47466C433D2;
        Tue,  6 Jun 2023 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686035565;
        bh=8sCXY1B4DQd1o4Ka7KZAPoloKoGNpJo+CtM+mi4AaG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gV+leH04BugM5XdHCftZoSt9d+eIPZuH7MDIPLCzJgF55/qnaV04IoFkXPOyEdZCX
         59C8S/QxEkW+7i2hvgw5NyNXA29j72eOZ/0nKhGuTxPkvSyjawlkS1glD2Yf+pgQ+X
         b81/qoilpcXRp1JBwg43Zx5iQ0Ee4es1wRxliPdnZEo0SzKqtdbQiWtnE3UHjpHd6w
         VU1UN46GEd2OC//GcrUvUePMMvVsU64sqXf4P5q9ZxvKWACIEs/by8lznb3jpuN/mL
         wJKdoKXWe748nsKBc8/kqd+o1XDS2aH8F36lsqnADM99hPRIHG77fN8cVoDgyGstth
         EASYWQUedGYqw==
From:   Saeed Mahameed <saeed@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Oz Shlomo <ozsh@nvidia.com>,
        Paul Blakey <paulb@nvidia.com>
Subject: [net-next 12/15] net/mlx5e: TC, refactor access to hash key
Date:   Tue,  6 Jun 2023 00:12:16 -0700
Message-Id: <20230606071219.483255-13-saeed@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071219.483255-1-saeed@kernel.org>
References: <20230606071219.483255-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Oz Shlomo <ozsh@nvidia.com>

Currently, a temp object is filled and used as a key for rhashtable_lookup.
Lookups will only works while key remains the first attribute in the
relevant rhashtable node object.

Fix this by passing a key, instead of a object containing the key.

Signed-off-by: Oz Shlomo <ozsh@nvidia.com>
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/tc/act_stats.c    | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act_stats.c
index 07c1895a2b23..7aa926e542d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act_stats.c
@@ -25,8 +25,8 @@ struct mlx5e_tc_act_stats {
 
 static const struct rhashtable_params act_counters_ht_params = {
 	.head_offset = offsetof(struct mlx5e_tc_act_stats, hash),
-	.key_offset = 0,
-	.key_len = offsetof(struct mlx5e_tc_act_stats, counter),
+	.key_offset = offsetof(struct mlx5e_tc_act_stats, tc_act_cookie),
+	.key_len = sizeof_field(struct mlx5e_tc_act_stats, tc_act_cookie),
 	.automatic_shrinking = true,
 };
 
@@ -169,14 +169,11 @@ mlx5e_tc_act_stats_fill_stats(struct mlx5e_tc_act_stats_handle *handle,
 {
 	struct rhashtable *ht = &handle->ht;
 	struct mlx5e_tc_act_stats *item;
-	struct mlx5e_tc_act_stats key;
 	u64 pkts, bytes, lastused;
 	int err = 0;
 
-	key.tc_act_cookie = fl_act->cookie;
-
 	rcu_read_lock();
-	item = rhashtable_lookup(ht, &key, act_counters_ht_params);
+	item = rhashtable_lookup(ht, &fl_act->cookie, act_counters_ht_params);
 	if (!item) {
 		rcu_read_unlock();
 		err = -ENOENT;
-- 
2.40.1

