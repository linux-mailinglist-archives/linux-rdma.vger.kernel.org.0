Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F53CF601
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhGTHhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:52 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:42560
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233914AbhGTHhr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFMpOZC2exOyR1rK7m0iZoI8jkX5IV0ZQFZhHhqePGb5hhyLv7UxV0fFnAp5bFfztbHYMxfP92zth16UB3O6OyJKE67PlBDyhnrvfuqzkVXuREZtgo7xkzzxPxZEFP4d+gxNyrfs9DaJwCzPdRCRhjtjhKsu4s3HPrE/+9J8cJ/r5PXpUi9cZJXoVJxOkmzwL+BBqQQ1n7JnlDIDakqkYvWwhIjwE5P/vZSI+oYasMwV+0Fu3pW6ahx0RgTfh7n5ckpqsQRaV7PqP9N7blcoMRzGFdZlNUa2QbQ+CT4tIg5YTRrMDZ6Szj8ygXr/PgCs0lB43Zlhi2k/Qw/0S/p7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWsUAp/k0ZVYbnsyUXVy1xP2x4dvZojPCzTtnoqIy2g=;
 b=Tjo4iogwcH/hK6g6B2KNdX/NPtkIQpGV1gU/6c9OcuagNx0COXqdtU4E/eW6jcPwZjP2DAcxE8JM2LGXjp9N0tFAfCNpaqWq1MWT7ModRcVjldee3z+RKopaU9kq08btQeYzDSt3Z7PgiQzqHYoNwahheqAbXvmiJva9WePnQRcD1UvFA+juqp2Puui5XMwNS/XKbGs7eBa1L4SlsPely/e7N3OujhBsgvyGJNpHSeOIo58zJDo/LM0OERXTFyWjkRxgNbEtRNNOqD5efpvvBQQxcfQTHw177vdb6B2QHLRPuv2Yla4YcwRNX8Ab4DQhTHO0cADEAIdYfOMEBPRrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWsUAp/k0ZVYbnsyUXVy1xP2x4dvZojPCzTtnoqIy2g=;
 b=gqJR9Y62tGQcF+igFG9oKLUWLwMpbs39Rd7eRZsFNO1f611hM6ZQl6udC/uN5xmktC74s7nufPQBTclf4yHsNDwp+Uou4h0LRFVe1CQZqbH0vrb28fzAq3V57VJ4ej/nS71rMxPC0xVtqILYcZ3PN7KLimCrwLoBAaL51TwYXd67wK8X2Ab9XYLUytlKNceGo6z26l7mtH4mHdQZKoIpG1XcIVUIJwJvRxY1RAWEnGeHWHsN6QgDPzYqwnH2WpUygPrJttJG7od6GGvPcrYFGuP+ssZbWxSjuvdLR3EzobdD9eg30ClP2HgXfEiYOOLnzVsVKahnmZj/lQjhYDWNow==
Received: from BN6PR19CA0055.namprd19.prod.outlook.com (2603:10b6:404:e3::17)
 by BN6PR12MB1299.namprd12.prod.outlook.com (2603:10b6:404:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:18:25 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::2a) by BN6PR19CA0055.outlook.office365.com
 (2603:10b6:404:e3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:24 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:05 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:18:05 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:18:02 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 16/27] mlx5: Support initial DEVX/DV APIs over vfio
Date:   Tue, 20 Jul 2021 11:16:36 +0300
Message-ID: <20210720081647.1980-17-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 610a1b71-99f5-4858-d1f6-08d94b56f20c
X-MS-TrafficTypeDiagnostic: BN6PR12MB1299:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1299205704C08DF2210C362FC3E29@BN6PR12MB1299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fc9M9vU9Mz/l8p2azdhpKz+tRYzk/G2Vx8cAqC/W5ome8wad2kWDTt153105LpjFZkJoOsZZ57HGqzGyekqSjERdWFDh/yig7cLFOsoGuX3oHjWote1srjvptgVww3MNGMxVg2T/IqQ1UEbobDzuAZgbAwz9AiDiJmV6CEtBvMreoepQLkV8j+tWHNiVUUm4Iv0SoHuSoT7na1sIP4uJFJPjMCiiK7CeczZ1ZkLUsKnqzkGsWhUnB4337uIUTf1BzKzBKwgQfUUbSbYIgtbxKgMdwNqUUzoyo+Zs/nIrECbFYus/U5d9UIFtjRe6NYNQJBb3AYDnAuy/PCQQZJ4j7q5Sd65PQO7jbr2YxBogRN7XRYaVd5lznLtm1qItjKV4JG8IiZ92A+kqF24M5zK13aMNYbH8x/72SIg3APELH/kqaVeqRUOM1gAwD7stH3n6f9Hip3gLGQWr+hnWeB2PXbVRfs2NTf9+fuTdtXt673ce9fMRy6ZHtOAlb+jCaPsYvCENU4LHoKED891WmH9+5esTioiEz4z1dafYsE66Y/skyP0JUNYa6DmMyj4HmUUn/Vnwn2dw1mNlx+XeBf8utZQz8ZV8o63y2XKAdCM9cOjK0qugy26izPc3ByqNq/XFP4wg/zxoN4pA0+1cRj5hBQO5xXXqNcitxX2rVCXKZRK1frFPknjD0eD+lR+guSK/1WAcrAAoZbLzY7cfp2CC1Q==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(2616005)(478600001)(1076003)(36860700001)(7636003)(36756003)(4326008)(47076005)(54906003)(7696005)(356005)(70586007)(8676002)(86362001)(26005)(6916009)(82310400003)(82740400003)(426003)(107886003)(5660300002)(30864003)(8936002)(6666004)(70206006)(2906002)(316002)(336012)(186003)(36906005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:24.7644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610a1b71-99f5-4858-d1f6-08d94b56f20c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1299
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Support initial DEVX/DV APIs over vfio for UMEM/UAR/EQN usage.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  |  70 ++++++++++++++
 providers/mlx5/mlx5_vfio.c | 228 ++++++++++++++++++++++++++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.h |  10 ++
 3 files changed, 307 insertions(+), 1 deletion(-)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 1cbe846..1bd7466 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -88,6 +88,8 @@ enum {
 	MLX5_CMD_OP_CREATE_GENERAL_OBJECT = 0xa00,
 	MLX5_CMD_OP_MODIFY_GENERAL_OBJECT = 0xa01,
 	MLX5_CMD_OP_QUERY_GENERAL_OBJECT = 0xa02,
+	MLX5_CMD_OP_CREATE_UMEM = 0xa08,
+	MLX5_CMD_OP_DESTROY_UMEM = 0xa0a,
 	MLX5_CMD_OP_SYNC_STEERING = 0xb00,
 };
 
@@ -4656,4 +4658,72 @@ struct mlx5_ifc_dealloc_pd_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_mtt_bits {
+	u8         ptag_63_32[0x20];
+
+	u8         ptag_31_8[0x18];
+	u8         reserved_at_38[0x6];
+	u8         wr_en[0x1];
+	u8         rd_en[0x1];
+};
+
+struct mlx5_ifc_umem_bits {
+	u8         reserved_at_0[0x80];
+
+	u8         reserved_at_80[0x1b];
+	u8         log_page_size[0x5];
+
+	u8         page_offset[0x20];
+
+	u8         num_of_mtt[0x40];
+
+	struct mlx5_ifc_mtt_bits  mtt[];
+};
+
+struct mlx5_ifc_create_umem_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+
+	struct mlx5_ifc_umem_bits  umem;
+};
+
+struct mlx5_ifc_create_umem_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         umem_id[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_umem_in_bits {
+	u8        opcode[0x10];
+	u8        uid[0x10];
+
+	u8        reserved_at_20[0x10];
+	u8        op_mod[0x10];
+
+	u8        reserved_at_40[0x8];
+	u8        umem_id[0x18];
+
+	u8        reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_destroy_umem_out_bits {
+	u8        status[0x8];
+	u8        reserved_at_8[0x18];
+
+	u8        syndrome[0x20];
+
+	u8        reserved_at_40[0x40];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 23c6eeb..5e55697 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -37,6 +37,8 @@ enum {
 	MLX5_VFIO_SUPP_MR_ACCESS_FLAGS = IBV_ACCESS_LOCAL_WRITE |
 		IBV_ACCESS_REMOTE_WRITE | IBV_ACCESS_REMOTE_READ |
 		IBV_ACCESS_REMOTE_ATOMIC | IBV_ACCESS_RELAXED_ORDERING,
+	MLX5_VFIO_SUPP_UMEM_ACCESS_FLAGS = IBV_ACCESS_LOCAL_WRITE |
+		IBV_ACCESS_REMOTE_WRITE | IBV_ACCESS_REMOTE_READ,
 };
 
 static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx, uint16_t func_id,
@@ -173,7 +175,6 @@ static void mlx5_vfio_free_page(struct mlx5_vfio_context *ctx, uint64_t iova)
 		bitmap_set_bit(page_block->free_pages, pg);
 		if (bitmap_full(page_block->free_pages, MLX5_VFIO_BLOCK_NUM_PAGES))
 			mlx5_vfio_free_block(ctx, page_block);
-
 		goto end;
 	}
 
@@ -2467,6 +2468,220 @@ vfio_devx_obj_create(struct ibv_context *context, const void *in,
 	return NULL;
 }
 
+static int vfio_devx_query_eqn(struct ibv_context *ibctx, uint32_t vector,
+			       uint32_t *eqn)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
+
+	if (vector > ibctx->num_comp_vectors - 1)
+		return EINVAL;
+
+	/* For now use the singleton EQN created for async events */
+	*eqn = ctx->async_eq.eqn;
+	return 0;
+}
+
+static struct mlx5dv_devx_uar *
+vfio_devx_alloc_uar(struct ibv_context *ibctx, uint32_t flags)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
+	struct mlx5_devx_uar *uar;
+
+	if (flags != MLX5_IB_UAPI_UAR_ALLOC_TYPE_NC) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	uar = calloc(1, sizeof(*uar));
+	if (!uar) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	uar->dv_devx_uar.page_id = ctx->eqs_uar.uarn;
+	uar->dv_devx_uar.base_addr = (void *)ctx->eqs_uar.iova;
+	uar->dv_devx_uar.reg_addr = uar->dv_devx_uar.base_addr + MLX5_BF_OFFSET;
+	uar->context = ibctx;
+
+	return &uar->dv_devx_uar;
+}
+
+static void vfio_devx_free_uar(struct mlx5dv_devx_uar *dv_devx_uar)
+{
+	free(dv_devx_uar);
+}
+
+static struct mlx5dv_devx_umem *
+_vfio_devx_umem_reg(struct ibv_context *context,
+		    void *addr, size_t size, uint32_t access,
+		    uint64_t pgsz_bitmap)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(context);
+	uint32_t out[DEVX_ST_SZ_DW(create_umem_out)] = {};
+	struct mlx5_vfio_devx_umem *vfio_umem;
+	int iova_page_shift;
+	uint64_t iova_size;
+	int ret;
+	void *in;
+	uint32_t inlen;
+	__be64 *mtt;
+	void *umem;
+	bool writeable;
+	void *aligned_va;
+	int num_pas;
+
+	if (!check_comp_mask(access, MLX5_VFIO_SUPP_UMEM_ACCESS_FLAGS)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	if ((access & IBV_ACCESS_REMOTE_WRITE) &&
+	    !(access & IBV_ACCESS_LOCAL_WRITE)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	/* Page size that encloses the start and end of the umem range */
+	iova_size = max(roundup_pow_of_two(size + ((uint64_t) addr & (ctx->iova_min_page_size - 1))),
+			ctx->iova_min_page_size);
+
+	if (!(iova_size & pgsz_bitmap)) {
+		/* input should include the iova page size */
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	writeable = access &
+		(IBV_ACCESS_LOCAL_WRITE | IBV_ACCESS_REMOTE_WRITE);
+
+	vfio_umem = calloc(1, sizeof(*vfio_umem));
+	if (!vfio_umem) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	vfio_umem->iova_size = iova_size;
+	if (ibv_dontfork_range(addr, size))
+		goto err;
+
+	ret = iset_alloc_range(ctx->iova_alloc, vfio_umem->iova_size, &vfio_umem->iova);
+	if (ret)
+		goto err_alloc;
+
+	/* The registration's arguments have to reflect real VA presently mapped into the process */
+	aligned_va = (void *) ((unsigned long) addr & ~(ctx->iova_min_page_size - 1));
+	vfio_umem->iova_reg_size = align((addr + size) - aligned_va, ctx->iova_min_page_size);
+	ret = mlx5_vfio_register_mem(ctx, aligned_va, vfio_umem->iova, vfio_umem->iova_reg_size);
+	if (ret)
+		goto err_reg;
+
+	iova_page_shift = ilog32(vfio_umem->iova_size - 1);
+	num_pas = 1;
+	if (iova_page_shift > MLX5_MAX_PAGE_SHIFT) {
+		iova_page_shift = MLX5_MAX_PAGE_SHIFT;
+		num_pas = DIV_ROUND_UP(vfio_umem->iova_size, (1ULL << iova_page_shift));
+	}
+
+	inlen = DEVX_ST_SZ_BYTES(create_umem_in) + DEVX_ST_SZ_BYTES(mtt) * num_pas;
+
+	in = calloc(1, inlen);
+	if (!in) {
+		errno = ENOMEM;
+		goto err_in;
+	}
+
+	umem = DEVX_ADDR_OF(create_umem_in, in, umem);
+	mtt = (__be64 *)DEVX_ADDR_OF(umem, umem, mtt);
+
+	DEVX_SET(create_umem_in, in, opcode, MLX5_CMD_OP_CREATE_UMEM);
+	DEVX_SET64(umem, umem, num_of_mtt, num_pas);
+	DEVX_SET(umem, umem, log_page_size, iova_page_shift - MLX5_ADAPTER_PAGE_SHIFT);
+	DEVX_SET(umem, umem, page_offset, addr - aligned_va);
+
+	mlx5_vfio_populate_pas(vfio_umem->iova, num_pas, (1ULL << iova_page_shift), mtt,
+			       (writeable ? MLX5_MTT_WRITE : 0) | MLX5_MTT_READ);
+
+	ret = mlx5_vfio_cmd_exec(ctx, in, inlen, out, sizeof(out), 0);
+	if (ret)
+		goto err_exec;
+
+	free(in);
+
+	vfio_umem->dv_devx_umem.umem_id = DEVX_GET(create_umem_out, out, umem_id);
+	vfio_umem->context = context;
+	vfio_umem->addr = addr;
+	vfio_umem->size = size;
+	return &vfio_umem->dv_devx_umem;
+
+err_exec:
+	free(in);
+err_in:
+	mlx5_vfio_unregister_mem(ctx, vfio_umem->iova, vfio_umem->iova_reg_size);
+err_reg:
+	iset_insert_range(ctx->iova_alloc, vfio_umem->iova, vfio_umem->iova_size);
+err_alloc:
+	ibv_dofork_range(addr, size);
+err:
+	free(vfio_umem);
+	return NULL;
+}
+
+static struct mlx5dv_devx_umem *
+vfio_devx_umem_reg(struct ibv_context *context,
+		   void *addr, size_t size, uint32_t access)
+{
+	return _vfio_devx_umem_reg(context, addr, size, access, UINT64_MAX);
+}
+
+static struct mlx5dv_devx_umem *
+vfio_devx_umem_reg_ex(struct ibv_context *ctx, struct mlx5dv_devx_umem_in *in)
+{
+	if (!check_comp_mask(in->comp_mask, 0)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	return _vfio_devx_umem_reg(ctx, in->addr, in->size, in->access, in->pgsz_bitmap);
+}
+
+static int vfio_devx_umem_dereg(struct mlx5dv_devx_umem *dv_devx_umem)
+{
+	struct mlx5_vfio_devx_umem *vfio_umem =
+		container_of(dv_devx_umem, struct mlx5_vfio_devx_umem,
+			     dv_devx_umem);
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(vfio_umem->context);
+	uint32_t in[DEVX_ST_SZ_DW(create_umem_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(create_umem_out)] = {};
+	int ret;
+
+	DEVX_SET(destroy_umem_in, in, opcode, MLX5_CMD_OP_DESTROY_UMEM);
+	DEVX_SET(destroy_umem_in, in, umem_id, dv_devx_umem->umem_id);
+
+	ret = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+	if (ret)
+		return ret;
+
+	mlx5_vfio_unregister_mem(ctx, vfio_umem->iova, vfio_umem->iova_reg_size);
+	iset_insert_range(ctx->iova_alloc, vfio_umem->iova, vfio_umem->iova_size);
+	ibv_dofork_range(vfio_umem->addr, vfio_umem->size);
+	free(vfio_umem);
+	return 0;
+}
+
+static int vfio_init_obj(struct mlx5dv_obj *obj, uint64_t obj_type)
+{
+	struct ibv_pd *pd_in = obj->pd.in;
+	struct mlx5dv_pd *pd_out = obj->pd.out;
+	struct mlx5_pd *mpd = to_mpd(pd_in);
+
+	if (obj_type != MLX5DV_OBJ_PD)
+		return EOPNOTSUPP;
+
+	pd_out->comp_mask = 0;
+	pd_out->pdn = mpd->pdn;
+	return 0;
+}
+
 static int vfio_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in,
 				size_t inlen, void *out, size_t outlen)
 {
@@ -2476,6 +2691,13 @@ static int vfio_devx_obj_query(struct mlx5dv_devx_obj *obj, const void *in,
 static struct mlx5_dv_context_ops mlx5_vfio_dv_ctx_ops = {
 	.devx_obj_create = vfio_devx_obj_create,
 	.devx_obj_query = vfio_devx_obj_query,
+	.devx_query_eqn = vfio_devx_query_eqn,
+	.devx_alloc_uar = vfio_devx_alloc_uar,
+	.devx_free_uar = vfio_devx_free_uar,
+	.devx_umem_reg = vfio_devx_umem_reg,
+	.devx_umem_reg_ex = vfio_devx_umem_reg_ex,
+	.devx_umem_dereg = vfio_devx_umem_dereg,
+	.init_obj = vfio_init_obj,
 };
 
 static void mlx5_vfio_uninit_context(struct mlx5_vfio_context *ctx)
@@ -2544,6 +2766,10 @@ mlx5_vfio_alloc_context(struct ibv_device *ibdev,
 
 	verbs_set_ops(&mctx->vctx, &mlx5_vfio_common_ops);
 	mctx->dv_ctx_ops = &mlx5_vfio_dv_ctx_ops;
+
+	/* For now only a singelton EQ is supported */
+	mctx->vctx.context.num_comp_vectors = 1;
+
 	return &mctx->vctx;
 
 func_teardown:
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 79b8033..766c48c 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -47,6 +47,16 @@ struct mlx5_vfio_mr {
 	uint64_t iova_reg_size;
 };
 
+struct mlx5_vfio_devx_umem {
+	struct mlx5dv_devx_umem dv_devx_umem;
+	struct ibv_context *context;
+	void *addr;
+	size_t size;
+	uint64_t iova;
+	uint64_t iova_size;
+	uint64_t iova_reg_size;
+};
+
 struct mlx5_vfio_device {
 	struct verbs_device vdev;
 	char *pci_name;
-- 
1.8.3.1

