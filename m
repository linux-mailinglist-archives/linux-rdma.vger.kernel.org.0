Return-Path: <linux-rdma+bounces-609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0682BBCA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jan 2024 08:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0C1C247E9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jan 2024 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54425C91E;
	Fri, 12 Jan 2024 07:30:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906F5C8FD;
	Fri, 12 Jan 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app2 (Coremail) with SMTP id by_KCgBn+fCG6qBlmFQzAA--.25619S2;
	Fri, 12 Jan 2024 15:30:16 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] net/mlx5e: fix a double-free in arfs_create_groups
Date: Fri, 12 Jan 2024 15:29:16 +0800
Message-Id: <20240112072916.3726945-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgBn+fCG6qBlmFQzAA--.25619S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUGFWrJw1UGFWUWr1kGrg_yoW5Xr4DpF
	47JryDtFs5A3WxX39Iy3y0qrn5Cw48Ka1UuFyI934Sqrsrtr4kGFy0g345ArWxCFy3AwnF
	y34rZw1UCFnrCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
	UUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When `in` allocated by kvzalloc fails, arfs_create_groups will free
ft->g and return an error. However, arfs_create_table, the only caller of
arfs_create_groups, will hold this error and call to
mlx5e_destroy_flow_table, in which the ft->g will be freed again.

Fixes: 1cabe6b0965e ("net/mlx5e: Create aRFS flow tables")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: free ft->g just in arfs_create_groups with a unwind ladder.
v3: split the allocation of ft->g and in. Rename the error label.
    remove some refector change in v2.
---
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index bb7f86c993e5..0424ae068a60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -254,11 +254,13 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 
 	ft->g = kcalloc(MLX5E_ARFS_NUM_GROUPS,
 			sizeof(*ft->g), GFP_KERNEL);
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if  (!in || !ft->g) {
-		kfree(ft->g);
-		kvfree(in);
+	if(!ft->g)
 		return -ENOMEM;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if  (!in) {
+		err = -ENOMEM;
+		goto err_free_g;
 	}
 
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
@@ -278,7 +280,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	switch (type) {
@@ -300,7 +302,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 		break;
 	default:
 		err = -EINVAL;
-		goto out;
+		goto err_free_in;
 	}
 
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
@@ -309,7 +311,7 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	memset(in, 0, inlen);
@@ -318,18 +320,20 @@ static int arfs_create_groups(struct mlx5e_flow_table *ft,
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ft->g[ft->num_groups] = mlx5_create_flow_group(ft->t, in);
 	if (IS_ERR(ft->g[ft->num_groups]))
-		goto err;
+		goto err_clean_group;
 	ft->num_groups++;
 
 	kvfree(in);
 	return 0;
 
-err:
+err_clean_group:
 	err = PTR_ERR(ft->g[ft->num_groups]);
 	ft->g[ft->num_groups] = NULL;
-out:
+err_free_in:
 	kvfree(in);
-
+err_free_g:
+	kfree(ft->g);
+	ft->g = NULL;
 	return err;
 }
 
-- 
2.34.1


