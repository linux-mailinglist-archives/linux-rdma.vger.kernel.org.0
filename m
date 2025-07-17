Return-Path: <linux-rdma+bounces-12260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F1B08CA6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FD11C21E92
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E82BD00C;
	Thu, 17 Jul 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwxfWIL9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEB13AF2;
	Thu, 17 Jul 2025 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754669; cv=none; b=K/iq8JdzXR4udopwVxYEehWREuVUQuklEzgV1h9HKcvdsGWMcLdLMya0E/EtEI5thnu+p+/WbnciTZnR03fkSED6bgCcIcRCNAka4PVtX3zGDVChX/EsOcSfkNlNJbME2Q/maxtoVKV7EIKAyQQ3Uq1bsRzovU+YMJT1hLhtzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754669; c=relaxed/simple;
	bh=Ke2yN6mclBqh56VLx7XX4NtRId6DcchOebg//MToGVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToPTKkgNqamDnI2FsWxyp/t22K23lBuLiBLt7q9IFjdRJQe/MCTiSRGHy3CH6Lg0mFGZNeINoriiyH+iRPSae9u6XQyG2Di32RtDy1xXGJgU62He7uKsZK86SteG6DB/mKHWNRsez51DyjJ9j1H3PlEd8q6xsY5V4YFVPfDuQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwxfWIL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90142C4CEE3;
	Thu, 17 Jul 2025 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752754669;
	bh=Ke2yN6mclBqh56VLx7XX4NtRId6DcchOebg//MToGVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwxfWIL91nKeMiqA8aHKanIoWaJAkC7BlxmYHqLBIh7OdHLu3dVSFtzLchitZ57hO
	 T4K7pSFigrPIxeYlh7Svy9HzfgxCeagvImS5wPbC6JYaNwKtEFhhgvz9IYXPpOYKkk
	 4dD7D+U8l+Dzpfi942WdtW4nAZAVYq+4QvvJf8FySwrEtMD6xkUUnZJ317SXZPPTE8
	 6M/cm4F/QwlDhgVYAjJ1L0kX73MIIWsDVuCHDUaMQiCspZmkSrzfukO11VrVKvlVn9
	 AE6WtUkbTlsk8ysop58zFcvYi9zQT87c+CKG49JMjV/Ek2Bn6F+Ly7nP3EgL0N/TrG
	 GWP3/2iv8lAYA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next v2 2/8] net/mlx5: Expose IFC bits for TPH
Date: Thu, 17 Jul 2025 15:17:26 +0300
Message-ID: <38ea3a0d56551364214e8edf359c9c77c9a3b71b.1752752567.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752752567.git.leon@kernel.org>
References: <cover.1752752567.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Expose IFC bits for the TPH functionality.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index a1bd92ed8f3a9..789a1f0a67393 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1859,7 +1859,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0xb];
+	u8         reserved_at_2a0[0x7];
+	u8         mkey_pcie_tph[0x1];
+	u8         reserved_at_2a8[0x3];
 	u8         shampo[0x1];
 	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
@@ -4406,6 +4408,10 @@ enum {
 	MLX5_MKC_ACCESS_MODE_CROSSING = 0x6,
 };
 
+enum {
+	MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX = 0,
+};
+
 struct mlx5_ifc_mkc_bits {
 	u8         reserved_at_0[0x1];
 	u8         free[0x1];
@@ -4457,7 +4463,11 @@ struct mlx5_ifc_mkc_bits {
 	u8         relaxed_ordering_read[0x1];
 	u8         log_page_size[0x6];
 
-	u8         reserved_at_1e0[0x20];
+	u8         reserved_at_1e0[0x5];
+	u8         pcie_tph_en[0x1];
+	u8         pcie_tph_ph[0x2];
+	u8         pcie_tph_steering_tag_index[0x8];
+	u8         reserved_at_1f0[0x10];
 };
 
 struct mlx5_ifc_pkey_bits {
-- 
2.50.1


