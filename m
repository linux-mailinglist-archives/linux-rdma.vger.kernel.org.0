Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14476C3CF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Aug 2023 06:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjHBEBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Aug 2023 00:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHBEBJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Aug 2023 00:01:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB99B;
        Tue,  1 Aug 2023 21:01:03 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RFyt76sYKz1GDG0;
        Wed,  2 Aug 2023 11:59:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 12:01:01 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <tariqt@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH net-next v2] net/mlx4: Remove many unnecessary NULL values
Date:   Wed, 2 Aug 2023 12:00:26 +0800
Message-ID: <20230802040026.2588675-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The NULL initialization of the pointers assigned by kzalloc() first is
not necessary, because if the kzalloc() failed, the pointers will be
assigned NULL, otherwise it works as usual. so remove it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
v2:
- add the wrong removed NULL hunk code in mlx4_init_hca().
- update the commit message.
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 10 +++++-----
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c  |  4 ++--
 drivers/net/ethernet/mellanox/mlx4/main.c       |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 7d45f1d55f79..164a13272faa 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1467,8 +1467,8 @@ static int add_ip_rule(struct mlx4_en_priv *priv,
 		       struct list_head *list_h)
 {
 	int err;
-	struct mlx4_spec_list *spec_l2 = NULL;
-	struct mlx4_spec_list *spec_l3 = NULL;
+	struct mlx4_spec_list *spec_l2;
+	struct mlx4_spec_list *spec_l3;
 	struct ethtool_usrip4_spec *l3_mask = &cmd->fs.m_u.usr_ip4_spec;
 
 	spec_l3 = kzalloc(sizeof(*spec_l3), GFP_KERNEL);
@@ -1505,9 +1505,9 @@ static int add_tcp_udp_rule(struct mlx4_en_priv *priv,
 			     struct list_head *list_h, int proto)
 {
 	int err;
-	struct mlx4_spec_list *spec_l2 = NULL;
-	struct mlx4_spec_list *spec_l3 = NULL;
-	struct mlx4_spec_list *spec_l4 = NULL;
+	struct mlx4_spec_list *spec_l2;
+	struct mlx4_spec_list *spec_l3;
+	struct mlx4_spec_list *spec_l4;
 	struct ethtool_tcpip4_spec *l4_mask = &cmd->fs.m_u.tcp_ip4_spec;
 
 	spec_l2 = kzalloc(sizeof(*spec_l2), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index e11bc0ac880e..403604ceebc8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -291,7 +291,7 @@ mlx4_en_filter_alloc(struct mlx4_en_priv *priv, int rxq_index, __be32 src_ip,
 		     __be32 dst_ip, u8 ip_proto, __be16 src_port,
 		     __be16 dst_port, u32 flow_id)
 {
-	struct mlx4_en_filter *filter = NULL;
+	struct mlx4_en_filter *filter;
 
 	filter = kzalloc(sizeof(struct mlx4_en_filter), GFP_ATOMIC);
 	if (!filter)
@@ -2935,7 +2935,7 @@ static void mlx4_en_bond_work(struct work_struct *work)
 static int mlx4_en_queue_bond_work(struct mlx4_en_priv *priv, int is_bonded,
 				   u8 v2p_p1, u8 v2p_p2)
 {
-	struct mlx4_en_bond *bond = NULL;
+	struct mlx4_en_bond *bond;
 
 	bond = kzalloc(sizeof(*bond), GFP_ATOMIC);
 	if (!bond)
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 61286b0d9b0c..8a5409b00530 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -864,7 +864,7 @@ static void mlx4_slave_destroy_special_qp_cap(struct mlx4_dev *dev)
 
 static int mlx4_slave_special_qp_cap(struct mlx4_dev *dev)
 {
-	struct mlx4_func_cap *func_cap = NULL;
+	struct mlx4_func_cap *func_cap;
 	struct mlx4_caps *caps = &dev->caps;
 	int i, err = 0;
 
@@ -908,9 +908,9 @@ static int mlx4_slave_cap(struct mlx4_dev *dev)
 {
 	int			   err;
 	u32			   page_size;
-	struct mlx4_dev_cap	   *dev_cap = NULL;
-	struct mlx4_func_cap	   *func_cap = NULL;
-	struct mlx4_init_hca_param *hca_param = NULL;
+	struct mlx4_dev_cap	   *dev_cap;
+	struct mlx4_func_cap	   *func_cap;
+	struct mlx4_init_hca_param *hca_param;
 
 	hca_param = kzalloc(sizeof(*hca_param), GFP_KERNEL);
 	func_cap = kzalloc(sizeof(*func_cap), GFP_KERNEL);
-- 
2.34.1

