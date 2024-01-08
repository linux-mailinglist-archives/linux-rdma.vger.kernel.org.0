Return-Path: <linux-rdma+bounces-560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8E827318
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B64A1F25935
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8852F91;
	Mon,  8 Jan 2024 15:28:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44D524D3;
	Mon,  8 Jan 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [183.159.171.224])
	by mail-app2 (Coremail) with SMTP id by_KCgBn+fBKGZxleMgHAA--.4251S2;
	Mon, 08 Jan 2024 23:48:27 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] net/mlx5e: fix a double-free in arfs_create_groups
Date: Mon,  8 Jan 2024 23:26:04 +0800
Message-Id: <20240108152605.3712050-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgBn+fBKGZxleMgHAA--.4251S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUXrWrXw4kWF48KrWDCFg_yoW5Ar48pF
	45J34DKFs5Za48XanrA3yvqw1rCa18tayUu3WIv34SqwnFyr4UCFyrK3y3AFyxCFW3ArnF
	y3Z8Zw1UAFZxArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
	J5UUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When `in` allocated by kvzalloc fails, arfs_create_groups will free
ft->g and return an error. However, arfs_create_table, the only caller of
arfs_create_groups, will hold this error and call to
mlx5e_destroy_flow_table, in which the ft->g will be freed again.

Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changelog:

v2: free ft->g just in arfs_create_groups with a unwind ladde.
---
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c   | 17 +++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c |  1 -
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index bb7f86c993e5..c96f4c571b63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -252,13 +252,14 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	int err;
 	u8 *mc;
 
+	ft->num_groups = 0;
+
 	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
 			sizeof(*ft->g), GFP_KERNEL);
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if  (!in || !ft->g) {
-		kfree(ft->g);
-		kvfree(in);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_ft;
 	}
 
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
@@ -278,7 +279,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto free_ft;
 	}
 
 	switch (type) {
@@ -300,7 +301,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto free_ft;
 	}
 
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
@@ -327,7 +328,9 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 err:
 	err = PTR_ERR(ft->g[ft->num_groups]);
 	ft->g[ft->num_groups] = NULL;
-out:
+free_ft:
+	kfree(ft->g);
+	ft->g = NULL;
 	kvfree(in);
 
 	return err;
@@ -343,8 +346,6 @@ static int arfs_create_table(struct mlx5e_flow_steering *fs,
 	struct mlx5_flow_table_attr ft_attr = {};
 	int err;
 
-	ft->num_groups = 0;
-
 	ft_attr.max_fte = MLX5E_ARFS_TABLE_SIZE;
 	ft_attr.level = MLX5E_ARFS_FT_LEVEL;
 	ft_attr.prio = MLX5E_NIC_PRIO;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 777d311d44ef..7b6aa0c8b58d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -883,7 +883,6 @@ void mlx5e_fs_init_l2_addr(struct mlx5e_flow_steering *fs, struct net_device *ne
 void mlx5e_destroy_flow_table(struct mlx5e_flow_table *ft)
 {
 	mlx5e_destroy_groups(ft);
-	kfree(ft->g);
 	mlx5_destroy_flow_table(ft->t);
 	ft->t = NULL;
 }
-- 
2.34.1


