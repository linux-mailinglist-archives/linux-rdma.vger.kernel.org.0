Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB477BB01
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjHNOIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjHNOIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 10:08:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDB1D7;
        Mon, 14 Aug 2023 07:08:11 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RPbmq0HYLz1GDWN;
        Mon, 14 Aug 2023 22:06:51 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 22:08:08 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <saeedm@nvidia.com>, <leon@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <borisp@nvidia.com>, <tariqt@nvidia.com>, <lkayal@nvidia.com>,
        <msanalla@nvidia.com>, <kliteyn@nvidia.com>, <valex@nvidia.com>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/mlx5: Remove unused declaration
Date:   Mon, 14 Aug 2023 22:08:04 +0800
Message-ID: <20230814140804.47660-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 2ac9cfe78223 ("net/mlx5e: IPSec, Add Innova IPSec offload TX data path")
declared mlx5e_ipsec_inverse_table_init() but never implemented it.
Commit f52f2faee581 ("net/mlx5e: Introduce flow steering API")
declared mlx5e_fs_set_tc() but never implemented it.
Commit f2f3df550139 ("net/mlx5: EQ, Privatize eq_table and friends")
declared mlx5_eq_comp_cpumask() but never implemented it.
Commit cac1eb2cf2e3 ("net/mlx5: Lag, properly lock eswitch if needed")
removed mlx5_lag_update() but not its declaration.
Commit 35ba005d820b ("net/mlx5: DR, Set flex parser for TNL_MPLS dynamically")
removed mlx5dr_ste_build_tnl_mpls() but not its declaration.

Commit e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
declared but never implemented mlx5_alloc_cmd_mailbox_chain() and mlx5_free_cmd_mailbox_chain().
Commit 0cf53c124756 ("net/mlx5: FWPage, Use async events chain")
removed mlx5_core_req_pages_handler() but not its declaration.
Commit 938fe83c8dcb ("net/mlx5_core: New device capabilities handling")
removed mlx5_query_odp_caps() but not its declaration.
Commit f6a8a19bb11b ("RDMA/netdev: Hoist alloc_netdev_mqs out of the driver")
removed mlx5_rdma_netdev_alloc() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |  1 -
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |  1 -
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  2 --
 .../mellanox/mlx5/core/steering/dr_types.h         |  4 ----
 include/linux/mlx5/driver.h                        | 14 --------------
 6 files changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index e5a44b0b9616..4d6225e0eec7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -150,7 +150,6 @@ struct mlx5e_flow_steering *mlx5e_fs_init(const struct mlx5e_profile *profile,
 					  struct dentry *dfs_root);
 void mlx5e_fs_cleanup(struct mlx5e_flow_steering *fs);
 struct mlx5e_vlan_table *mlx5e_fs_get_vlan(struct mlx5e_flow_steering *fs);
-void mlx5e_fs_set_tc(struct mlx5e_flow_steering *fs, struct mlx5e_tc_table *tc);
 struct mlx5e_tc_table *mlx5e_fs_get_tc(struct mlx5e_flow_steering *fs);
 struct mlx5e_l2_table *mlx5e_fs_get_l2(struct mlx5e_flow_steering *fs);
 struct mlx5_flow_namespace *mlx5e_fs_get_ns(struct mlx5e_flow_steering *fs, bool egress);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 9ee014a8ad24..2ed99772f168 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -54,7 +54,6 @@ struct mlx5e_accel_tx_ipsec_state {
 
 #ifdef CONFIG_MLX5_EN_IPSEC
 
-void mlx5e_ipsec_inverse_table_init(void);
 void mlx5e_ipsec_set_iv_esn(struct sk_buff *skb, struct xfrm_state *x,
 			    struct xfrm_offload *xo);
 void mlx5e_ipsec_set_iv(struct sk_buff *skb, struct xfrm_state *x,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
index 69a75459775d..4b7f7131c560 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h
@@ -85,7 +85,6 @@ void mlx5_eq_del_cq(struct mlx5_eq *eq, struct mlx5_core_cq *cq);
 struct mlx5_eq_comp *mlx5_eqn2comp_eq(struct mlx5_core_dev *dev, int eqn);
 struct mlx5_eq *mlx5_get_async_eq(struct mlx5_core_dev *dev);
 void mlx5_cq_tasklet_cb(struct tasklet_struct *t);
-struct cpumask *mlx5_eq_comp_cpumask(struct mlx5_core_dev *dev, int ix);
 
 u32 mlx5_eq_poll_irq_disabled(struct mlx5_eq_comp *eq);
 void mlx5_cmd_eq_recover(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 43b0144121ca..ccc2d088b569 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -292,8 +292,6 @@ static inline int mlx5_rescan_drivers(struct mlx5_core_dev *dev)
 	return ret;
 }
 
-void mlx5_lag_update(struct mlx5_core_dev *dev);
-
 enum {
 	MLX5_NIC_IFC_FULL		= 0,
 	MLX5_NIC_IFC_DISABLED		= 1,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 6c59de3e28f6..1a98d25a9bae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -436,10 +436,6 @@ void mlx5dr_ste_build_mpls(struct mlx5dr_ste_ctx *ste_ctx,
 			   struct mlx5dr_ste_build *sb,
 			   struct mlx5dr_match_param *mask,
 			   bool inner, bool rx);
-void mlx5dr_ste_build_tnl_mpls(struct mlx5dr_ste_ctx *ste_ctx,
-			       struct mlx5dr_ste_build *sb,
-			       struct mlx5dr_match_param *mask,
-			       bool inner, bool rx);
 void mlx5dr_ste_build_tnl_mpls_over_gre(struct mlx5dr_ste_ctx *ste_ctx,
 					struct mlx5dr_ste_build *sb,
 					struct mlx5dr_match_param *mask,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 3e1017d764b7..d7b906da13e3 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1032,10 +1032,6 @@ void mlx5_trigger_health_work(struct mlx5_core_dev *dev);
 int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 			     struct mlx5_frag_buf *buf, int node);
 void mlx5_frag_buf_free(struct mlx5_core_dev *dev, struct mlx5_frag_buf *buf);
-struct mlx5_cmd_mailbox *mlx5_alloc_cmd_mailbox_chain(struct mlx5_core_dev *dev,
-						      gfp_t flags, int npages);
-void mlx5_free_cmd_mailbox_chain(struct mlx5_core_dev *dev,
-				 struct mlx5_cmd_mailbox *head);
 int mlx5_core_create_mkey(struct mlx5_core_dev *dev, u32 *mkey, u32 *in,
 			  int inlen);
 int mlx5_core_destroy_mkey(struct mlx5_core_dev *dev, u32 mkey);
@@ -1049,8 +1045,6 @@ void mlx5_pagealloc_start(struct mlx5_core_dev *dev);
 void mlx5_pagealloc_stop(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_pages_debugfs_cleanup(struct mlx5_core_dev *dev);
-void mlx5_core_req_pages_handler(struct mlx5_core_dev *dev, u16 func_id,
-				 s32 npages, bool ec_function);
 int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot);
 int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev);
 void mlx5_register_debugfs(void);
@@ -1090,8 +1084,6 @@ int mlx5_core_create_psv(struct mlx5_core_dev *dev, u32 pdn,
 int mlx5_core_destroy_psv(struct mlx5_core_dev *dev, int psv_num);
 __be32 mlx5_core_get_terminate_scatter_list_mkey(struct mlx5_core_dev *dev);
 void mlx5_core_put_rsc(struct mlx5_core_rsc_common *common);
-int mlx5_query_odp_caps(struct mlx5_core_dev *dev,
-			struct mlx5_odp_caps *odp_caps);
 
 int mlx5_init_rl_table(struct mlx5_core_dev *dev);
 void mlx5_cleanup_rl_table(struct mlx5_core_dev *dev);
@@ -1193,12 +1185,6 @@ int mlx5_sriov_blocking_notifier_register(struct mlx5_core_dev *mdev,
 void mlx5_sriov_blocking_notifier_unregister(struct mlx5_core_dev *mdev,
 					     int vf_id,
 					     struct notifier_block *nb);
-#ifdef CONFIG_MLX5_CORE_IPOIB
-struct net_device *mlx5_rdma_netdev_alloc(struct mlx5_core_dev *mdev,
-					  struct ib_device *ibdev,
-					  const char *name,
-					  void (*setup)(struct net_device *));
-#endif /* CONFIG_MLX5_CORE_IPOIB */
 int mlx5_rdma_rn_get_params(struct mlx5_core_dev *mdev,
 			    struct ib_device *device,
 			    struct rdma_netdev_alloc_params *params);
-- 
2.34.1

