Return-Path: <linux-rdma+bounces-14060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A5C0CAC8
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 964AD347B91
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC02F5A13;
	Mon, 27 Oct 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5zB+tJs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488162F0689;
	Mon, 27 Oct 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557659; cv=none; b=T3gEZgQgKovehscrZ9sME3JK14QA6l6h+o3VngBzqr7MGdzXNhwvW1jG0xipC6I3vLlDwoLeHfKUIRxIA3CNiNHVrHoXCidCbQ7sIO5UFK1tJTVgkNLK9d7tJcR5gNgvoRk7GYRcxRPNX5ZazuDW+HOyQWT9bsdygDWK9VBmwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557659; c=relaxed/simple;
	bh=jNY7vyah/H0XlZOl9k3qgI+ts9k9GGcIuJnN4Nfa3WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg8Ml3kc+09rZxww5v9o71GPTO1jq+fCwea4jgpO3popL/eLQow8eoITacolWPkgQHpf5SqjhU0URja+1R1/Y5nXub6BhN6B8pZg6/LVLBTZXZ4Vhk7NG9HdahnsBGFs1WYxD15s1648FA4QqQKG+da99mNfBCqgyp+ylbOrG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5zB+tJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416BFC4CEFB;
	Mon, 27 Oct 2025 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761557658;
	bh=jNY7vyah/H0XlZOl9k3qgI+ts9k9GGcIuJnN4Nfa3WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5zB+tJs7ztrUbF52xo2zNWKbTb7K8pN7/5gc0IzjRfkStU/Vexx40f4TYt1IwSzU
	 nvEEywQG6h217t0r2wFgUwmmRlb9HkiqtRQiy99DroL2CWB+rsNMygzCjmaP8jgj7j
	 +hyUxM5sRynlpWf6qxkmjRYSFLlfEpqTMDAb8wZWn6zOr/mHTgfYvTNzESGzFvSixd
	 PxPQqUu7gWznMmDlL/1kv4W4JCm9oXUgF5KEQx3h1u10AEjeLG+yc0UMvrlPTDPJFI
	 Ns3rrLJQ+g0Z47ZNI04RJ6LOHHTGrXTyn3a2qle61T7FMfD7/m5W61L8rICaBLxxtd
	 7QjHoWLHQkQPA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: Add direct ST mode support for RDMA
Date: Mon, 27 Oct 2025 11:34:02 +0200
Message-ID: <20251027-st-direct-mode-v1-2-e0ad953866b6@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
References: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Add support for direct ST mode where ST Table Location equals
PCI_TPH_LOC_NONE.

In that case, no steering table exists, the steering tag itself will be
used directly by the SW, FW, HW from the mkey.

This enables RDMA users to use the current exposed APIs to work in
direct mode.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 29 ++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
index 47fe215f66bf..ef06fe6cbb51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -19,13 +19,16 @@ struct mlx5_st {
 	struct mutex lock;
 	struct xa_limit index_limit;
 	struct xarray idx_xa; /* key == index, value == struct mlx5_st_idx_data */
+	u8 direct_mode : 1;
 };
 
 struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
 {
 	struct pci_dev *pdev = dev->pdev;
 	struct mlx5_st *st;
+	u8 direct_mode = 0;
 	u16 num_entries;
+	u32 tbl_loc;
 	int ret;
 
 	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
@@ -40,10 +43,16 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
 	if (!pdev->tph_cap)
 		return NULL;
 
-	num_entries = pcie_tph_get_st_table_size(pdev);
-	/* We need a reserved entry for non TPH cases */
-	if (num_entries < 2)
-		return NULL;
+	tbl_loc = pcie_tph_get_st_table_loc(pdev);
+	if (tbl_loc == PCI_TPH_LOC_NONE)
+		direct_mode = 1;
+
+	if (!direct_mode) {
+		num_entries = pcie_tph_get_st_table_size(pdev);
+		/* We need a reserved entry for non TPH cases */
+		if (num_entries < 2)
+			return NULL;
+	}
 
 	/* The OS doesn't support ST */
 	ret = pcie_enable_tph(pdev, PCI_TPH_ST_DS_MODE);
@@ -56,6 +65,10 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
 
 	mutex_init(&st->lock);
 	xa_init_flags(&st->idx_xa, XA_FLAGS_ALLOC);
+	st->direct_mode = direct_mode;
+	if (st->direct_mode)
+		return st;
+
 	/* entry 0 is reserved for non TPH cases */
 	st->index_limit.min = MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX + 1;
 	st->index_limit.max = num_entries - 1;
@@ -96,6 +109,11 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
 	if (ret)
 		return ret;
 
+	if (st->direct_mode) {
+		*st_index = tag;
+		return 0;
+	}
+
 	mutex_lock(&st->lock);
 
 	xa_for_each(&st->idx_xa, index, idx_data) {
@@ -145,6 +163,9 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
 	if (!st)
 		return -EOPNOTSUPP;
 
+	if (st->direct_mode)
+		return 0;
+
 	mutex_lock(&st->lock);
 	idx_data = xa_load(&st->idx_xa, st_index);
 	if (WARN_ON_ONCE(!idx_data)) {

-- 
2.51.0


