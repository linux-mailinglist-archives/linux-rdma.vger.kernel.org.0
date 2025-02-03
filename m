Return-Path: <linux-rdma+bounces-7368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7CA2630D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964F718848B7
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AD1CAA80;
	Mon,  3 Feb 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UmwfYHPz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB31199236;
	Mon,  3 Feb 2025 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608759; cv=none; b=acCwMswV0z150v97mPHKJmj0Hg+57TnIhWF/WiBlpMB7tlxc7KRXblpCH8CT8cUhIaYi6vJJRTV82Fz5axHJGI6by+emAp4/j6lWaMDGh0PcK8jPVTKTKAvq07g8wrN07Ax4GR/TPgdwC1yNXuZnvZZHsDSz7IhxHABuDlo6fkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608759; c=relaxed/simple;
	bh=OgHx0zkCX1alf5bPqXKjWg83bR9h4Ptf5GXWQnGi8OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cd/B84e19yOuS5AOnO67//KKnogQ1uSKU6eNBHRdjHu5wz+rG5fIcSt/y1kVzH7VFUZrq9fvTWFYhJ7Pv+jbohESjXDJTbDwZWvjSkv6EnNUYfPh2OAPAwo9+SCNw1OQ/3AC84lG9xm3yyNo5yrRnt7JAgyF8wM4l5ySDgUNumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UmwfYHPz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ifwKiXeYOpXh/sYAVyBEyCy4Utga0cjaiv+2qLLScEs=; b=UmwfYHPzSGz4rgYf
	PPvXF8CXv504IIO10DnquUIHkJifCQKKv/XlR94rzIhhLdPZpVGgjG7yxhq68lUdhK0ZDDgTNqCpX
	FRt4WHMsasiXhU8c6m93TU6RcrRtcu2Bw3oInxRJr4E7AAKyWdrU3GtKTcgTteRXbPfHsC2zg4kHh
	CWh3EcMYYhKCYj3z9xXWy9kmOaIx7IOU0eNaDRyr6pr0WmkX+BWulw5EIqBd6NL5Cjxau73MFuNqB
	mV48zSkTo5AjYSebEj+wvzrh+L5b3/dSNDAP43HUfxmxfulNr50qnn01EmWPMqbdtv3ChPDT8whvI
	1ZjnbRn4Nu5D/4MM/w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tf1Yc-00DLt2-1b;
	Mon, 03 Feb 2025 18:52:30 +0000
From: linux@treblig.org
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yishaih@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] mlx4: Remove unused functions
Date: Mon,  3 Feb 2025 18:52:29 +0000
Message-ID: <20250203185229.204279-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of mlx4_find_cached_mac() was removed in 2014 by
commit 2f5bb473681b ("mlx4: Add ref counting to port MAC table for RoCE")

mlx4_zone_free_entries() was added in 2014 by
commit 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
but hasn't been used. (The _unique version is used)

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 22 ----------------------
 drivers/net/ethernet/mellanox/mlx4/mlx4.h  |  6 ------
 drivers/net/ethernet/mellanox/mlx4/port.c  | 20 --------------------
 include/linux/mlx4/device.h                |  1 -
 4 files changed, 49 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index b330020dc0d6..598df63518c5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -526,28 +526,6 @@ u32 mlx4_zone_alloc_entries(struct mlx4_zone_allocator *zones, u32 uid, int coun
 	return res;
 }
 
-u32 mlx4_zone_free_entries(struct mlx4_zone_allocator *zones, u32 uid, u32 obj, u32 count)
-{
-	struct mlx4_zone_entry *zone;
-	int res = 0;
-
-	spin_lock(&zones->lock);
-
-	zone = __mlx4_find_zone_by_uid(zones, uid);
-
-	if (NULL == zone) {
-		res = -1;
-		goto out;
-	}
-
-	__mlx4_free_from_zone(zone, obj, count);
-
-out:
-	spin_unlock(&zones->lock);
-
-	return res;
-}
-
 u32 mlx4_zone_free_entries_unique(struct mlx4_zone_allocator *zones, u32 obj, u32 count)
 {
 	struct mlx4_zone_entry *zone;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index d7d856d1758a..b213094ea30f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -1478,12 +1478,6 @@ void mlx4_zone_allocator_destroy(struct mlx4_zone_allocator *zone_alloc);
 u32 mlx4_zone_alloc_entries(struct mlx4_zone_allocator *zones, u32 uid, int count,
 			    int align, u32 skip_mask, u32 *puid);
 
-/* Free <count> objects, start from <obj> of the uid <uid> from zone_allocator
- * <zones>.
- */
-u32 mlx4_zone_free_entries(struct mlx4_zone_allocator *zones,
-			   u32 uid, u32 obj, u32 count);
-
 /* If <zones> was allocated with MLX4_ZONE_ALLOC_FLAGS_NO_OVERLAP, instead of
  * specifying the uid when freeing an object, zone allocator could figure it by
  * itself. Other parameters are similar to mlx4_zone_free.
diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 4e43f4a7d246..e3d0b13c1610 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -147,26 +147,6 @@ static int mlx4_set_port_mac_table(struct mlx4_dev *dev, u8 port,
 	return err;
 }
 
-int mlx4_find_cached_mac(struct mlx4_dev *dev, u8 port, u64 mac, int *idx)
-{
-	struct mlx4_port_info *info = &mlx4_priv(dev)->port[port];
-	struct mlx4_mac_table *table = &info->mac_table;
-	int i;
-
-	for (i = 0; i < MLX4_MAX_MAC_NUM; i++) {
-		if (!table->refs[i])
-			continue;
-
-		if (mac == (MLX4_MAC_MASK & be64_to_cpu(table->entries[i]))) {
-			*idx = i;
-			return 0;
-		}
-	}
-
-	return -ENOENT;
-}
-EXPORT_SYMBOL_GPL(mlx4_find_cached_mac);
-
 static bool mlx4_need_mf_bond(struct mlx4_dev *dev)
 {
 	int i, num_eth_ports = 0;
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c89..87edb7a8173b 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1415,7 +1415,6 @@ int mlx4_get_is_vlan_offload_disabled(struct mlx4_dev *dev, u8 port,
 				      bool *vlan_offload_disabled);
 void mlx4_handle_eth_header_mcast_prio(struct mlx4_net_trans_rule_hw_ctrl *ctrl,
 				       struct _rule_hw *eth_header);
-int mlx4_find_cached_mac(struct mlx4_dev *dev, u8 port, u64 mac, int *idx);
 int mlx4_find_cached_vlan(struct mlx4_dev *dev, u8 port, u16 vid, int *idx);
 int mlx4_register_vlan(struct mlx4_dev *dev, u8 port, u16 vlan, int *index);
 void mlx4_unregister_vlan(struct mlx4_dev *dev, u8 port, u16 vlan);
-- 
2.48.1


