Return-Path: <linux-rdma+bounces-3179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E619909E69
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436F9281726
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E21CA85;
	Sun, 16 Jun 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnrwiRXg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4E17BA0;
	Sun, 16 Jun 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554173; cv=none; b=KjcbzawymKI8MthT0p5Cfmhy8KQeaandqmooUAVorGfLOZTj5teEm0+WUnRFFuPKKOmcpUfRomqWS7Ea3Lu8lWiShEeLHwveEDrFL86bssrqIRfmrwP6gZmqp/ya8DQ38oUhfTh2WMn1sffz5aTgTw03QwqoFkgi318uYy4a98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554173; c=relaxed/simple;
	bh=MgIW0KG+Xo9pSbK+szkI6XxTCrkblZCeUhTtNNCvjkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmGUNEGEhXuIGW6Psu4zLw3ZPREaprxYwKsS2pU6swKmxdxGT0pyGSgKdUA936AWSsPuGCa+Y/oCeadR4BZ5WwqYWrEZc0tpZCWj0jA9PhYTfZpWE4Uio6Vg61ujLIUCiJgtq1idcaQ2tm0lbzymZcmNi0q20ywowSiUkfnHZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnrwiRXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DC9C2BBFC;
	Sun, 16 Jun 2024 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554172;
	bh=MgIW0KG+Xo9pSbK+szkI6XxTCrkblZCeUhTtNNCvjkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnrwiRXgvnH1DPOgI6Ik+zD82QEMx99yp1jnR7SV67Dl/n4mvmo6W6CBN+xUGrN82
	 7qtlVr4sMtDOlT4JCWO4Ed+uWupG3YRl7brfCee9d+ahgg9eVlu3bDp0jEGASoKWbe
	 vOBGpYBAUlVjgVo9mibt5TdRg06bLikpyPUMKGG9nhE13Slcjb4LljWh+lU1UPdKXT
	 OXhk9//ujiIR8ugrcFXEiPS9kNhdu2172TNWDoKvw9YLf+snFYDVmwITAtDN1HcuT6
	 Is5vh/zYDngjtSCSMMvrqzlEZauzZiEVecbJcv5nmow2qlJatWoCmoIhrSLIZRPyND
	 S+fLzxrbLGZbA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 11/12] net/mlx5: mlx5_ifc update for accessing ppcnt register of plane ports
Date: Sun, 16 Jun 2024 19:08:43 +0300
Message-ID: <70221cdd79aad0e21cbf385d9567e3ebffbc5137.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

This patch adds new fields to support multi-plane and the extend port
counters group. Actual support will be added in the next patch.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 47 +++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 61738990e399..5fea7b747607 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2651,6 +2651,46 @@ struct mlx5_ifc_ib_port_cntrs_grp_data_layout_bits {
 	u8         port_xmit_wait[0x20];
 };
 
+struct mlx5_ifc_ib_ext_port_cntrs_grp_data_layout_bits {
+	u8         reserved_at_0[0x300];
+
+	u8         port_xmit_data_high[0x20];
+
+	u8         port_xmit_data_low[0x20];
+
+	u8         port_rcv_data_high[0x20];
+
+	u8         port_rcv_data_low[0x20];
+
+	u8         port_xmit_pkts_high[0x20];
+
+	u8         port_xmit_pkts_low[0x20];
+
+	u8         port_rcv_pkts_high[0x20];
+
+	u8         port_rcv_pkts_low[0x20];
+
+	u8         reserved_at_400[0x80];
+
+	u8         port_unicast_xmit_pkts_high[0x20];
+
+	u8         port_unicast_xmit_pkts_low[0x20];
+
+	u8         port_multicast_xmit_pkts_high[0x20];
+
+	u8         port_multicast_xmit_pkts_low[0x20];
+
+	u8         port_unicast_rcv_pkts_high[0x20];
+
+	u8         port_unicast_rcv_pkts_low[0x20];
+
+	u8         port_multicast_rcv_pkts_high[0x20];
+
+	u8         port_multicast_rcv_pkts_low[0x20];
+
+	u8         reserved_at_580[0x240];
+};
+
 struct mlx5_ifc_eth_per_tc_prio_grp_data_layout_bits {
 	u8         transmit_queue_high[0x20];
 
@@ -4543,6 +4583,7 @@ union mlx5_ifc_eth_cntrs_grp_data_layout_auto_bits {
 	struct mlx5_ifc_eth_per_tc_prio_grp_data_layout_bits eth_per_tc_prio_grp_data_layout;
 	struct mlx5_ifc_eth_per_tc_congest_prio_grp_data_layout_bits eth_per_tc_congest_prio_grp_data_layout;
 	struct mlx5_ifc_ib_port_cntrs_grp_data_layout_bits ib_port_cntrs_grp_data_layout;
+	struct mlx5_ifc_ib_ext_port_cntrs_grp_data_layout_bits ib_ext_port_cntrs_grp_data_layout;
 	struct mlx5_ifc_phys_layer_cntrs_bits phys_layer_cntrs;
 	struct mlx5_ifc_phys_layer_statistical_cntrs_bits phys_layer_statistical_cntrs;
 	u8         reserved_at_0[0x7c0];
@@ -9851,8 +9892,10 @@ struct mlx5_ifc_ppcnt_reg_bits {
 	u8         grp[0x6];
 
 	u8         clr[0x1];
-	u8         reserved_at_21[0x1c];
-	u8         prio_tc[0x3];
+	u8         reserved_at_21[0x13];
+	u8         plane_ind[0x4];
+	u8         reserved_at_38[0x3];
+	u8         prio_tc[0x5];
 
 	union mlx5_ifc_eth_cntrs_grp_data_layout_auto_bits counter_set;
 };
-- 
2.45.2


