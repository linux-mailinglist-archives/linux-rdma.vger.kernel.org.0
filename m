Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3676648A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjG1Gx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 02:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjG1GxF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 02:53:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD033A97
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 23:52:22 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RBytG3z0JzLnw7;
        Fri, 28 Jul 2023 14:49:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 14:52:19 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <yishaih@nvidia.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] RDMA/mlx: remove a lot of unnecessary NULL values
Date:   Fri, 28 Jul 2023 14:51:39 +0800
Message-ID: <20230728065139.3411703-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ther are many pointers assigned first, which need not to be initialized, so
remove the NULL assignment.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/infiniband/hw/mlx4/main.c | 36 +++++++++++++++----------------
 drivers/infiniband/hw/mlx5/mad.c  | 32 +++++++++++++--------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index b18e9f2adc82..832e0067b091 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -132,7 +132,7 @@ static struct net_device *mlx4_ib_get_netdev(struct ib_device *device,
 
 	if (dev) {
 		if (mlx4_is_bonded(ibdev->dev)) {
-			struct net_device *upper = NULL;
+			struct net_device *upper;
 
 			upper = netdev_master_upper_dev_get_rcu(dev);
 			if (upper) {
@@ -254,7 +254,7 @@ static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 	int ret = 0;
 	int hw_update = 0;
 	int i;
-	struct gid_entry *gids = NULL;
+	struct gid_entry *gids;
 	u16 vlan_id = 0xffff;
 	u8 mac[ETH_ALEN];
 
@@ -345,7 +345,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	struct mlx4_port_gid_table   *port_gid_table;
 	int ret = 0;
 	int hw_update = 0;
-	struct gid_entry *gids = NULL;
+	struct gid_entry *gids;
 
 	if (!rdma_cap_roce_gid_table(attr->device, attr->port_num))
 		return -EINVAL;
@@ -431,8 +431,8 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 				struct ib_udata *uhw)
 {
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err;
 	int have_ib_ports;
 	struct mlx4_uverbs_ex_query_device cmd;
@@ -649,8 +649,8 @@ mlx4_ib_port_link_layer(struct ib_device *device, u32 port_num)
 static int ib_link_query_port(struct ib_device *ibdev, u32 port,
 			      struct ib_port_attr *props, int netw_view)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int ext_active_speed;
 	int mad_ifc_flags = MLX4_MAD_IFC_IGNORE_KEYS;
 	int err = -ENOMEM;
@@ -827,8 +827,8 @@ static int mlx4_ib_query_port(struct ib_device *ibdev, u32 port,
 int __mlx4_ib_query_gid(struct ib_device *ibdev, u32 port, int index,
 			union ib_gid *gid, int netw_view)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 	struct mlx4_ib_dev *dev = to_mdev(ibdev);
 	int clear = 0;
@@ -892,8 +892,8 @@ static int mlx4_ib_query_sl2vl(struct ib_device *ibdev, u32 port,
 			       u64 *sl2vl_tbl)
 {
 	union sl2vl_tbl_to_u64 sl2vl64;
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int mad_ifc_flags = MLX4_MAD_IFC_IGNORE_KEYS;
 	int err = -ENOMEM;
 	int jj;
@@ -952,8 +952,8 @@ static void mlx4_init_sl2vl_tbl(struct mlx4_ib_dev *mdev)
 int __mlx4_ib_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 			 u16 *pkey, int netw_view)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int mad_ifc_flags = MLX4_MAD_IFC_IGNORE_KEYS;
 	int err = -ENOMEM;
 
@@ -1968,8 +1968,8 @@ static int mlx4_ib_mcg_detach(struct ib_qp *ibqp, union ib_gid *gid, u16 lid)
 
 static int init_node_data(struct mlx4_ib_dev *dev)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int mad_ifc_flags = MLX4_MAD_IFC_IGNORE_KEYS;
 	int err = -ENOMEM;
 
@@ -2621,7 +2621,7 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
 	int num_req_counters;
 	int allocated;
 	u32 counter_index;
-	struct counter_index *new_counter_index = NULL;
+	struct counter_index *new_counter_index;
 
 	pr_info_once("%s", mlx4_ib_version);
 
@@ -2923,7 +2923,7 @@ int mlx4_ib_steer_qp_reg(struct mlx4_ib_dev *mdev, struct mlx4_ib_qp *mqp,
 {
 	int err;
 	size_t flow_size;
-	struct ib_flow_attr *flow = NULL;
+	struct ib_flow_attr *flow;
 	struct ib_flow_spec_ib *ib_spec;
 
 	if (is_attach) {
@@ -2992,7 +2992,7 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
 
 static void do_slave_init(struct mlx4_ib_dev *ibdev, int slave, int do_init)
 {
-	struct mlx4_ib_demux_work **dm = NULL;
+	struct mlx4_ib_demux_work **dm;
 	struct mlx4_dev *dev = ibdev->dev;
 	int i;
 	unsigned long flags;
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 9c8a7b206dcf..c5e103abdd24 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -308,8 +308,8 @@ int mlx5_ib_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
 
 int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, unsigned int port)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 	u16 packet_error;
 
@@ -338,7 +338,7 @@ int mlx5_query_ext_port_caps(struct mlx5_ib_dev *dev, unsigned int port)
 static int mlx5_query_mad_ifc_smp_attr_node_info(struct ib_device *ibdev,
 						 struct ib_smp *out_mad)
 {
-	struct ib_smp *in_mad = NULL;
+	struct ib_smp *in_mad;
 	int err = -ENOMEM;
 
 	in_mad = kzalloc(sizeof(*in_mad), GFP_KERNEL);
@@ -358,7 +358,7 @@ static int mlx5_query_mad_ifc_smp_attr_node_info(struct ib_device *ibdev,
 int mlx5_query_mad_ifc_system_image_guid(struct ib_device *ibdev,
 					 __be64 *sys_image_guid)
 {
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	out_mad = kmalloc(sizeof(*out_mad), GFP_KERNEL);
@@ -380,7 +380,7 @@ int mlx5_query_mad_ifc_system_image_guid(struct ib_device *ibdev,
 int mlx5_query_mad_ifc_max_pkeys(struct ib_device *ibdev,
 				 u16 *max_pkeys)
 {
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	out_mad = kmalloc(sizeof(*out_mad), GFP_KERNEL);
@@ -402,7 +402,7 @@ int mlx5_query_mad_ifc_max_pkeys(struct ib_device *ibdev,
 int mlx5_query_mad_ifc_vendor_id(struct ib_device *ibdev,
 				 u32 *vendor_id)
 {
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	out_mad = kmalloc(sizeof(*out_mad), GFP_KERNEL);
@@ -423,8 +423,8 @@ int mlx5_query_mad_ifc_vendor_id(struct ib_device *ibdev,
 
 int mlx5_query_mad_ifc_node_desc(struct mlx5_ib_dev *dev, char *node_desc)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof(*in_mad), GFP_KERNEL);
@@ -448,8 +448,8 @@ int mlx5_query_mad_ifc_node_desc(struct mlx5_ib_dev *dev, char *node_desc)
 
 int mlx5_query_mad_ifc_node_guid(struct mlx5_ib_dev *dev, __be64 *node_guid)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof(*in_mad), GFP_KERNEL);
@@ -474,8 +474,8 @@ int mlx5_query_mad_ifc_node_guid(struct mlx5_ib_dev *dev, __be64 *node_guid)
 int mlx5_query_mad_ifc_pkey(struct ib_device *ibdev, u32 port, u16 index,
 			    u16 *pkey)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof(*in_mad), GFP_KERNEL);
@@ -503,8 +503,8 @@ int mlx5_query_mad_ifc_pkey(struct ib_device *ibdev, u32 port, u16 index,
 int mlx5_query_mad_ifc_gids(struct ib_device *ibdev, u32 port, int index,
 			    union ib_gid *gid)
 {
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int err = -ENOMEM;
 
 	in_mad  = kzalloc(sizeof(*in_mad), GFP_KERNEL);
@@ -545,8 +545,8 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u32 port,
 {
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	struct mlx5_core_dev *mdev = dev->mdev;
-	struct ib_smp *in_mad  = NULL;
-	struct ib_smp *out_mad = NULL;
+	struct ib_smp *in_mad;
+	struct ib_smp *out_mad;
 	int ext_active_speed;
 	int err = -ENOMEM;
 
-- 
2.34.1

