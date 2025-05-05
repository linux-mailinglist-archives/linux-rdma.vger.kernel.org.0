Return-Path: <linux-rdma+bounces-9986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A6CAAA117
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 00:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD2461C9D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 22:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7C29A3D8;
	Mon,  5 May 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JstQqrvw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5C270ED2;
	Mon,  5 May 2025 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483562; cv=none; b=CCMJygdX41X2R+tLxd8Of3r5tO8SYc7CMZjlI6+zVpv9VrvY3OnFAotY4WWlJxNOmIlYQVEydX/oi+TPNn0+1TQUJiM4qBKhr9ZbFx0M8S7hQpSMYBH+Qq54RSLnwvRkb81SncwmMsHX7EfnHQHqVSNNB6kjGxcSIp86ltqclMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483562; c=relaxed/simple;
	bh=gJOWUeD1S/7jV0r5kWY4nHy8F7NqqrZHwZ4AE47cmc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yt2h66MiNyAjH8LaYSAsyPcjSOXoZlDh1PrcQF9KKTujNJ50ZXb/MMQv6UiQMvhY6ElYumgkguAHHW6ruUk3qsCGnexMlMfchyWY7P5qzW52mcC2CiSyWdiue7J7WEkuZhlY9Ci8lJz7JVreOBo2X+G3wbAWUa3BHZTA58O0qB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JstQqrvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF76C4CEED;
	Mon,  5 May 2025 22:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483561;
	bh=gJOWUeD1S/7jV0r5kWY4nHy8F7NqqrZHwZ4AE47cmc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JstQqrvw44sh9hYCVA2glV+oU4HqMrLxsoXiFuyyfLB8fnrWRbW+0u2mtyvhexcOW
	 SvAfPhy8ezMFrRMR3KYj/W++RdtXn+qOEgALvXzFlebOJAhMnHix4HX4a3z53dEeQn
	 3wg7YdZZe/rF7lVmegMuR8pwB8dsOy1in+jALg5R3jR5u5eFwOK5BlatmCDl7rJ58+
	 mj/k1U/Fu4UwS9uyJuVnyWFEkqkZ1lagFtQjhmdMGD3Hk0buQjGrKbCrrkfiWc/EUE
	 Tfdfdqfg6a+7kppEyvEfD45hepQV2Vi5KspCm3WhanXsKwpQVppSB84NSS1RxfzEDE
	 0gJbOvSUF9MvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	saeedm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	cratiu@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 115/642] net/mlx5: Preserve rate settings when creating a rate node
Date: Mon,  5 May 2025 18:05:31 -0400
Message-Id: <20250505221419.2672473-115-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit f88c349c75e3784a3f5463f5b403ff28dd823782 ]

Modify `esw_qos_create_node_sched_elem()` to receive max_rate and
bw_share values while maintaining the previous configuration.

This change is essential for the upcoming patch that will modify rate
nodes and requires the existing settings to be preserved unless
explicitly changed.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1741642016-44918-4-git-send-email-tariqt@nvidia.com
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 823c1ba456cd1..803bacf2a95e6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -305,8 +305,9 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 	return 0;
 }
 
-static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
-					  u32 *tsar_ix)
+static int
+esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
+			       u32 max_rate, u32 bw_share, u32 *tsar_ix)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	void *attr;
@@ -323,6 +324,8 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 parent_element_id);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw, max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share, bw_share);
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
 	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
 
@@ -396,7 +399,8 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 	u32 tsar_ix;
 	int err;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0,
+					     0, &tsar_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
@@ -463,7 +467,8 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0,
+					     &esw->qos.root_tsar_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
-- 
2.39.5


