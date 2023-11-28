Return-Path: <linux-rdma+bounces-116-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B307FBA18
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 13:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04A2282A09
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Nov 2023 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5984F5E4;
	Tue, 28 Nov 2023 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA22Dlsf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17256774;
	Tue, 28 Nov 2023 12:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E20DC433C7;
	Tue, 28 Nov 2023 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701174607;
	bh=Hr4nB6qIyAl9SrKx63EHLJuuK3BK3CxkeypRrNZUQbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA22Dlsf3bnDdvMXSPmTUc5ShXV9BFcJhBq6wUNUAiXPIeAo7sCBtQqxPS/P1Sue/
	 7nM0MlVJxkEs4dR+ho+pQVrw7EMSBSGSn1n1VpucFLuPA7kBwThJh0P9Deuy+OPs0j
	 s2EcJ28ZWqphrJ6obSr5RuqjbYwzkKg+k/Q1s01IPI3me1n3voVigIqlz86K8zHm3L
	 anPXVh9QDJbQ3gmTGyCuXf49yhep46SgynozPat5kNP55iHw2M8Gj9A7E0Wa/w+SHU
	 Jou1l+FAZ6W1FGJ7DGaq74uVhjHX49EoK9AoEBJaAXVjWQ1cVa1oCZAUtHyPVYhcRV
	 N8XbP/IcjR2kA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 1/5] net/mlx5: Introduce indirect-sw-encap icm properties
Date: Tue, 28 Nov 2023 14:29:45 +0200
Message-ID: <79470c08ce852496b03d777749074efd937d5bf6.1701172481.git.leon@kernel.org>
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

From: Shun Hao <shunh@nvidia.com>

Add new fields for device memory capabilities, in order to support
creation of new ICM memory type of SW encap.

Signed-off-by: Shun Hao <shunh@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 6f3631425f38..02b25dc36143 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1193,7 +1193,8 @@ struct mlx5_ifc_device_mem_cap_bits {
 	u8         log_sw_icm_alloc_granularity[0x6];
 	u8         log_steering_sw_icm_size[0x8];
 
-	u8         reserved_at_120[0x18];
+	u8         log_indirect_encap_sw_icm_size[0x8];
+	u8         reserved_at_128[0x10];
 	u8         log_header_modify_pattern_sw_icm_size[0x8];
 
 	u8         header_modify_sw_icm_start_address[0x40];
@@ -1204,7 +1205,11 @@ struct mlx5_ifc_device_mem_cap_bits {
 
 	u8         memic_operations[0x20];
 
-	u8         reserved_at_220[0x5e0];
+	u8         reserved_at_220[0x20];
+
+	u8         indirect_encap_sw_icm_start_address[0x40];
+
+	u8         reserved_at_280[0x580];
 };
 
 struct mlx5_ifc_device_event_cap_bits {
-- 
2.43.0


