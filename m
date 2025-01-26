Return-Path: <linux-rdma+bounces-7224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805CA1CA84
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 16:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C254C162C3F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E461199EB2;
	Sun, 26 Jan 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKp8hYVM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9C1991DB;
	Sun, 26 Jan 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903664; cv=none; b=RIyGLONGmyIMziVYwbJ/cutJhQ5Uy69BlwS0lxZH0ow9YUhwaaGrxt3z/RCSt7wYGSKfD3KxIOA5OwolLdqkat2s99M0hPbR6mOiccKUWqU3s4Q/VZUU899LkFIf99hanNUzXVREjHCHf1dH1caWAnJQgOJFGp6gi350IayCqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903664; c=relaxed/simple;
	bh=vXz3NrQX5HK+DkHR+vTmua7NC3rct2Frbf5GEft/my8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHtffXGabeS0/H6u2Eb3M4zHzuycVVAsGf48u68Eab1XYaM4/YhX/j9vS0AE0zwRXYV4V8dMc5MwKH01oRuu0ed63aWK7aa9wX8lqCSPApl/83T8Y6+n6pEz0X0bYOIPhr6N3CAWG3EWv/BaHBUs4JXC51DxqtJ5DettDV/eCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKp8hYVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256E6C4CED3;
	Sun, 26 Jan 2025 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903664;
	bh=vXz3NrQX5HK+DkHR+vTmua7NC3rct2Frbf5GEft/my8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKp8hYVMH6AeJWP7SKn28AGVSuM2rImkC5lhGCwZiLClhQ9lqNdT89UYbG5UMhgr8
	 4Hm4VZqye+LFVLsZHg+m4R+11jt3dkQWsdqC5hM3VRw2iq0dXTSCfKki8OtlEHgPGz
	 cyTwnC7pi4WnTeVy4nGF8L+N/MVJEEBxk+zispm/SZW2zIS/BFV2lK9NfyFcXDy9YU
	 2cKvUE5Bz7xfpniSUuWW4INq5foCK7M6FWyTpXnA1Lfa0oP2FM9D4UjITM6ovoKZ1o
	 0RnWFDhLKCHxFY9RhXKf252bHZtw3jmK3j4Z8wV7Fk2PzujTRxITpLP4T6PurI7iMP
	 I7ja/FXwlLLLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 13/35] net/mlx5: HWS, change error flow on matcher disconnect
Date: Sun, 26 Jan 2025 10:00:07 -0500
Message-Id: <20250126150029.953021-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

[ Upstream commit 1ce840c7a659aa53a31ef49f0271b4fd0dc10296 ]

Currently, when firmware failure occurs during matcher disconnect flow,
the error flow of the function reconnects the matcher back and returns
an error, which continues running the calling function and eventually
frees the matcher that is being disconnected.
This leads to a case where we have a freed matcher on the matchers list,
which in turn leads to use-after-free and eventual crash.

This patch fixes that by not trying to reconnect the matcher back when
some FW command fails during disconnect.

Note that we're dealing here with FW error. We can't overcome this
problem. This might lead to bad steering state (e.g. wrong connection
between matchers), and will also lead to resource leakage, as it is
the case with any other error handling during resource destruction.

However, the goal here is to allow the driver to continue and not crash
the machine with use-after-free error.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250102181415.1477316-7-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/steering/hws/matcher.c | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 1bb3a6f8c3cda..e94f96c0c781f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -165,14 +165,14 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 						    next->match_ste.rtc_0_id,
 						    next->match_ste.rtc_1_id);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Failed to disconnect matcher\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect matcher\n");
+			return ret;
 		}
 	} else {
 		ret = mlx5hws_table_connect_to_miss_table(tbl, tbl->default_miss.miss_tbl);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Failed to disconnect last matcher\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx, "Fatal error, failed to disconnect last matcher\n");
+			return ret;
 		}
 	}
 
@@ -180,27 +180,19 @@ static int hws_matcher_disconnect(struct mlx5hws_matcher *matcher)
 	if (prev_ft_id == tbl->ft_id) {
 		ret = mlx5hws_table_update_connected_miss_tables(tbl);
 		if (ret) {
-			mlx5hws_err(tbl->ctx, "Fatal error, failed to update connected miss table\n");
-			goto matcher_reconnect;
+			mlx5hws_err(tbl->ctx,
+				    "Fatal error, failed to update connected miss table\n");
+			return ret;
 		}
 	}
 
 	ret = mlx5hws_table_ft_set_default_next_ft(tbl, prev_ft_id);
 	if (ret) {
 		mlx5hws_err(tbl->ctx, "Fatal error, failed to restore matcher ft default miss\n");
-		goto matcher_reconnect;
+		return ret;
 	}
 
 	return 0;
-
-matcher_reconnect:
-	if (list_empty(&tbl->matchers_list) || !prev)
-		list_add(&matcher->list_node, &tbl->matchers_list);
-	else
-		/* insert after prev matcher */
-		list_add(&matcher->list_node, &prev->list_node);
-
-	return ret;
 }
 
 static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
-- 
2.39.5


