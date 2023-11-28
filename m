Return-Path: <linux-rdma+bounces-120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0AE7FBA23
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 13:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7BC1C21394
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 12:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891F04F8AF;
	Tue, 28 Nov 2023 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk5H+MT/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695E5646A;
	Tue, 28 Nov 2023 12:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54049C433C7;
	Tue, 28 Nov 2023 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174624;
	bh=o4z3H0SdMr/XqkuOyTB0EV1y8u6oSsiRuqBA0j4ZH6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dk5H+MT/kYXXY8rf3LmBD58z22yEDAjemQs4JpDg4UiFX8E+6e68w7RnUAFPYCAse
	 aIRfkfWFuqeY13kmwceT3bvkP+vDO1aVSITlyCOlymVDZMzwIjRkBG41wceJgaV+79
	 254bRsW0YCQRkaYxH8iKfZ/PeWtSVOKl6L6tNesbbFj+CSG0y1SKiOHi3mOoeSWE//
	 KEXHcoXJUo6cYRN5Gcl/wk3iurtMngEsJOhftPIsurWODpnoxj8hCqAIx4bCGyuL6i
	 qvNU3ZZ8VdlatPmU/Bv9yiEkgq4FKVs4sEiqDkVl/p9NFtCVK/TO4b7mjyE1B5rtEH
	 dYAdkgjkAvJyw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shun Hao <shunh@nvidia.com>
Subject: [PATCH mlx5-next 5/5] RDMA/mlx5: Expose register c0 for RDMA device
Date: Tue, 28 Nov 2023 14:29:49 +0200
Message-ID: <3c7e589ae069616414630ab88c1d283d79754496.1701172481.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701172481.git.leon@kernel.org>
References: <cover.1701172481.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

This patch introduces improvements for matching egress traffic sent by the
local device. When applicable, all egress traffic from the local vport is
now tagged with the provided value. This enhancement is particularly useful
for FDB steering purposes.

The primary focus of this update is facilitating the transmission of
traffic from the hypervisor to a VF. To achieve this, one must initiate an
SQ on the hypervisor and subsequently create a rule in the FDB that matches
on the eswitch manager vport and the SQN of the aforementioned SQ.

Obtaining the SQN can be had from SQ opened, and the eswitch manager vport
match can be substituted with the register c0 value exposed by this patch.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 24 ++++++++++++++++++++++++
 include/uapi/rdma/mlx5-abi.h      |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 10c4b5e0aab5..5de19bfccbed 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -849,6 +849,17 @@ static int mlx5_query_node_desc(struct mlx5_ib_dev *dev, char *node_desc)
 				    MLX5_REG_NODE_DESC, 0, 0);
 }
 
+static void fill_esw_mgr_reg_c0(struct mlx5_core_dev *mdev,
+				struct mlx5_ib_query_device_resp *resp)
+{
+	struct mlx5_eswitch *esw = mdev->priv.eswitch;
+	u16 vport = mlx5_eswitch_manager_vport(mdev);
+
+	resp->reg_c0.value = mlx5_eswitch_get_vport_metadata_for_match(esw,
+								      vport);
+	resp->reg_c0.mask = mlx5_eswitch_get_vport_metadata_mask();
+}
+
 static int mlx5_ib_query_device(struct ib_device *ibdev,
 				struct ib_device_attr *props,
 				struct ib_udata *uhw)
@@ -1240,6 +1251,19 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			MLX5_CAP_GEN(mdev, log_max_dci_errored_streams);
 	}
 
+	if (offsetofend(typeof(resp), reserved) <= uhw_outlen)
+		resp.response_length += sizeof(resp.reserved);
+
+	if (offsetofend(typeof(resp), reg_c0) <= uhw_outlen) {
+		struct mlx5_eswitch *esw = mdev->priv.eswitch;
+
+		resp.response_length += sizeof(resp.reg_c0);
+
+		if (mlx5_eswitch_mode(mdev) == MLX5_ESWITCH_OFFLOADS &&
+		    mlx5_eswitch_vport_match_metadata_enabled(esw))
+			fill_esw_mgr_reg_c0(mdev, &resp);
+	}
+
 	if (uhw_outlen) {
 		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
 
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index a96b7d2770e1..d4f6a36dffb0 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -37,6 +37,7 @@
 #include <linux/types.h>
 #include <linux/if_ether.h>	/* For ETH_ALEN. */
 #include <rdma/ib_user_ioctl_verbs.h>
+#include <rdma/mlx5_user_ioctl_verbs.h>
 
 enum {
 	MLX5_QP_FLAG_SIGNATURE		= 1 << 0,
@@ -275,6 +276,7 @@ struct mlx5_ib_query_device_resp {
 	__u32	tunnel_offloads_caps; /* enum mlx5_ib_tunnel_offloads */
 	struct  mlx5_ib_dci_streams_caps dci_streams_caps;
 	__u16 reserved;
+	struct mlx5_ib_uapi_reg reg_c0;
 };
 
 enum mlx5_ib_create_cq_flags {
-- 
2.43.0


