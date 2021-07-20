Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39C3CF605
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbhGTHh7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:59 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:31520
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234601AbhGTHh1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDeGE0xsKVWrZHvBJEqY/RW7Zlgm/nmKnv6v6BRACAcbdlA5eUPsiXUrxOLva7Eqalo9WoVfq6soBSyidiHBUNc1QJpMWJ//GfTCQvT6UFXC6ePuDKzHUbLq25SOruCggIgkmCFtAkVX07iQEzO/KbMpwMB1ErE98xEmWSPiRagMivg6RYhukArgsatC1PruxBqqTP7KmtS6liUAnhxTYrgRU1nLMyU1xQguYT9EEwudNRsrQPfg6/k0c8rljzsRugvytG+5P7ugxkZfPIPg0gQrbWOSJf6KycTvXayUxrFDqXTFSZlIwdv3U4yHFGti62EWe41FteZoS3BDALjZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4XET3Dc1HkQEAllLj/8WpTwISgj7/uIqCvKq12ANuI=;
 b=LVYXhENqwxuzfLADRd9rpiaGmv3oVrODx6i7tejnLjEPjZPRag3iSRWdm39DFMbuAOstyTq3bEZ7fKal0BcKdACDoROEfJAWAVZ04a3ou+SOITvfs2dU/nhwURzdeMMKNi2wQIO7xMOlmMEwWA8lTGIwniaKlVZi4/22wrl3R4EksGUOdmZi+gT2i2XWWqePstCfuEzF3nZPh5wf31oNkyLP5nfAjuEF2Lxa1OS/4M16i3F+cCr7yyhmO5kQfdDC2FyX43KerJpPfdBlADPiN9XOGk9ZNCSXcUCC2e+vKuQRgubastKIxP7TZBVoNl4zRAPQIZOQzzpRSWF8BzU5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4XET3Dc1HkQEAllLj/8WpTwISgj7/uIqCvKq12ANuI=;
 b=ClMa3deCbwLXeQSu/AuaUS3whNfPA0uzGCny/jm3bz+vbVXUof1URKKf/Cx4KOMl1r478Gj/wFwJ4EYL+uE2TzstqOFthPTWQAl5bl9wT/zrR3pR3QTYUpOBUbqQalRyoI1+CBVSa/72/kK0u1d0+tyEpXnmqTFJmQHruY2ztvhoabSR7I7nFObO7MlQxSe26xIkmWeIJJzK2b1Odqi8H7en0pUaWecfWJmR3PUAlkN5Z9dPbN5CoRKWxUIbMzGLv3stodqQIXgoOcTfSlqAEiQMwNshf40Z2qdLtrAX9TYsaZs25qJuibI7/uzlh8EymL9/1cOyafGum0nG0oQvDw==
Received: from BN1PR13CA0014.namprd13.prod.outlook.com (2603:10b6:408:e2::19)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:18:01 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::ce) by BN1PR13CA0014.outlook.office365.com
 (2603:10b6:408:e2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend
 Transport; Tue, 20 Jul 2021 08:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:18:01 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:18:00 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:58 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 14/27] mlx5: Implement basic verbs operation for PD and MR over vfio
Date:   Tue, 20 Jul 2021 11:16:34 +0300
Message-ID: <20210720081647.1980-15-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117e3058-a80f-429f-d867-08d94b56e3f6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4224:
X-Microsoft-Antispam-PRVS: <MN2PR12MB422450CDC0D9C0EF4CE06BECC3E29@MN2PR12MB4224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJTdAIcnuRFt6WfyQdL0w23xSJbq4ucblu92PjtcOee/I3mVyYl/S54jtBJ0V+CgnXmvwkH63vod/LJ1M9EvNRBQdhLO88TyimDi3rHzZdzncHCQsF9mgqqPKCbzBQUndx0bZrnI3Z+rEU1sWbwJF/RT8S3AgdB28pWlgi8YZQzciVPDH2SQ8FzLtZrEAXoenM+xKLS+sjKY2sEkraRLlY224W3sRY4sFMj/FwQk/gxZM8a6P/kvbypVvRBbh9zcBYYVSbp+iGndW/rrWu7d0fj/I20Hu4CrtrmGKjDBn5LcTq3a5KgVQxo7sBElmXcxVHzA/f+aI0NTJnoKCY96jcENNv8ZZZeVrJqGPG5LC7j90YlmnUDoEccsAsTRq3QAt5qZ9i9eJMyWOSRgEvy7QnQGP+Q5gqfC1YiBgEnXW7NezOS60zdV9Hxb9U+LUYeGQipgJgB2GXy1Svpx33grutWiQ3XZoJsxxRNoT0WjV+lcMYmLD9C5zJ/RLGNEcms0vbJGSGVPgNYJS1HTRlBnH0oUUT2Rleir2EQ8vpXC094uzaBUUgI8I9xwFKSYBRaqZOL8NCIWuuwJhlJf0OAJljyS7g0xQEUScDavJIaPR/UHVFqe0sRNyAb6VT1qyFpD/d1Akpj4BR/WtGNCARG696DxecgBmvZ85IOan68/EoS7BMiDw09FGdWkbd2oAZOKQLONOR7CYApGbmBa9vZdWg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(36860700001)(36756003)(356005)(82740400003)(47076005)(1076003)(70586007)(30864003)(186003)(8936002)(7696005)(26005)(7636003)(86362001)(82310400003)(336012)(5660300002)(6916009)(83380400001)(2906002)(8676002)(70206006)(54906003)(4326008)(316002)(107886003)(478600001)(6666004)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:18:01.1942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 117e3058-a80f-429f-d867-08d94b56e3f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement basic verbs operation for PD and MR over vfio, this includes:
- PD alloc/dealloc
- MR reg/dereg.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  |  76 ++++++++++++-
 providers/mlx5/mlx5_vfio.c | 273 +++++++++++++++++++++++++++++++++++++++++++++
 providers/mlx5/mlx5_vfio.h |  25 +++++
 util/util.h                |   5 +
 4 files changed, 377 insertions(+), 2 deletions(-)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 2129779..1cbe846 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -51,6 +51,7 @@ enum {
 	MLX5_CMD_OP_QUERY_ISSI = 0x10a,
 	MLX5_CMD_OP_SET_ISSI = 0x10b,
 	MLX5_CMD_OP_CREATE_MKEY = 0x200,
+	MLX5_CMD_OP_DESTROY_MKEY = 0x202,
 	MLX5_CMD_OP_CREATE_EQ = 0x301,
 	MLX5_CMD_OP_DESTROY_EQ = 0x302,
 	MLX5_CMD_OP_CREATE_QP = 0x500,
@@ -67,6 +68,8 @@ enum {
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
 	MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT = 0x755,
 	MLX5_CMD_OP_QUERY_ROCE_ADDRESS = 0x760,
+	MLX5_CMD_OP_ALLOC_PD = 0x800,
+	MLX5_CMD_OP_DEALLOC_PD = 0x801,
 	MLX5_CMD_OP_ALLOC_UAR = 0x802,
 	MLX5_CMD_OP_DEALLOC_UAR = 0x803,
 	MLX5_CMD_OP_ACCESS_REG = 0x805,
@@ -1380,7 +1383,8 @@ enum {
 };
 
 enum {
-	MLX5_MKC_ACCESS_MODE_KLMS  = 0x2,
+	MLX5_MKC_ACCESS_MODE_MTT = 0x1,
+	MLX5_MKC_ACCESS_MODE_KLMS = 0x2,
 };
 
 struct mlx5_ifc_mkc_bits {
@@ -1425,7 +1429,9 @@ struct mlx5_ifc_mkc_bits {
 
 	u8         translations_octword_size[0x20];
 
-	u8         reserved_at_1c0[0x1b];
+	u8         reserved_at_1c0[0x19];
+	u8         relaxed_ordering_read[0x1];
+	u8         reserved_at_1d9[0x1];
 	u8         log_page_size[0x5];
 
 	u8         reserved_at_1e0[0x20];
@@ -1467,6 +1473,28 @@ struct mlx5_ifc_create_mkey_in_bits {
 	u8         klm_pas_mtt[0][0x20];
 };
 
+struct mlx5_ifc_destroy_mkey_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_destroy_mkey_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x8];
+	u8         mkey_index[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_l2_hdr_bits {
 	u8         dmac_47_16[0x20];
 	u8         dmac_15_0[0x10];
@@ -4584,4 +4612,48 @@ struct mlx5_ifc_destroy_eq_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_alloc_pd_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         pd[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_alloc_pd_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_dealloc_pd_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_dealloc_pd_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x8];
+	u8         pd[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index c37358c..e85a8cc 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -33,6 +33,12 @@ enum {
 	MLX5_VFIO_CMD_VEC_IDX,
 };
 
+enum {
+	MLX5_VFIO_SUPP_MR_ACCESS_FLAGS = IBV_ACCESS_LOCAL_WRITE |
+		IBV_ACCESS_REMOTE_WRITE | IBV_ACCESS_REMOTE_READ |
+		IBV_ACCESS_REMOTE_ATOMIC | IBV_ACCESS_RELAXED_ORDERING,
+};
+
 static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx, uint16_t func_id,
 				int32_t npages, bool is_event);
 static int mlx5_vfio_reclaim_pages(struct mlx5_vfio_context *ctx, uint32_t func_id,
@@ -2191,6 +2197,268 @@ static int mlx5_vfio_setup_function(struct mlx5_vfio_context *ctx)
 	return err;
 }
 
+static struct ibv_pd *mlx5_vfio_alloc_pd(struct ibv_context *ibctx)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
+	uint32_t in[DEVX_ST_SZ_DW(alloc_pd_in)] = {0};
+	uint32_t out[DEVX_ST_SZ_DW(alloc_pd_out)] = {0};
+	int err;
+	struct mlx5_pd *pd;
+
+	pd = calloc(1, sizeof(*pd));
+	if (!pd)
+		return NULL;
+
+	DEVX_SET(alloc_pd_in, in, opcode, MLX5_CMD_OP_ALLOC_PD);
+	err = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+
+	if (err)
+		goto err;
+
+	pd->pdn = DEVX_GET(alloc_pd_out, out, pd);
+
+	return &pd->ibv_pd;
+err:
+	free(pd);
+	return NULL;
+}
+
+static int mlx5_vfio_dealloc_pd(struct ibv_pd *pd)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(pd->context);
+	uint32_t in[DEVX_ST_SZ_DW(dealloc_pd_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(dealloc_pd_out)] = {};
+	struct mlx5_pd *mpd = to_mpd(pd);
+	int ret;
+
+	DEVX_SET(dealloc_pd_in, in, opcode, MLX5_CMD_OP_DEALLOC_PD);
+	DEVX_SET(dealloc_pd_in, in, pd, mpd->pdn);
+
+	ret = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+	if (ret)
+		return ret;
+
+	free(mpd);
+	return 0;
+}
+
+static size_t calc_num_dma_blocks(uint64_t iova, size_t length,
+				   unsigned long pgsz)
+{
+	return (size_t)((align(iova + length, pgsz) -
+			 align_down(iova, pgsz)) / pgsz);
+}
+
+static int get_octo_len(uint64_t addr, uint64_t len, int page_shift)
+{
+	uint64_t page_size = 1ULL << page_shift;
+	uint64_t offset;
+	int npages;
+
+	offset = addr & (page_size - 1);
+	npages = align(len + offset, page_size) >> page_shift;
+	return (npages + 1) / 2;
+}
+
+static inline uint32_t mlx5_mkey_to_idx(uint32_t mkey)
+{
+	return mkey >> 8;
+}
+
+static inline uint32_t mlx5_idx_to_mkey(uint32_t mkey_idx)
+{
+	return mkey_idx << 8;
+}
+
+static void set_mkc_access_pd_addr_fields(void *mkc, int acc, uint64_t start_addr,
+					  struct ibv_pd *pd)
+{
+	struct mlx5_pd *mpd = to_mpd(pd);
+
+	DEVX_SET(mkc, mkc, a, !!(acc & IBV_ACCESS_REMOTE_ATOMIC));
+	DEVX_SET(mkc, mkc, rw, !!(acc & IBV_ACCESS_REMOTE_WRITE));
+	DEVX_SET(mkc, mkc, rr, !!(acc & IBV_ACCESS_REMOTE_READ));
+	DEVX_SET(mkc, mkc, lw, !!(acc & IBV_ACCESS_LOCAL_WRITE));
+	DEVX_SET(mkc, mkc, lr, 1);
+	/* Application is responsible to set based on caps */
+	DEVX_SET(mkc, mkc, relaxed_ordering_write,
+		 !!(acc & IBV_ACCESS_RELAXED_ORDERING));
+	DEVX_SET(mkc, mkc, relaxed_ordering_read,
+		 !!(acc & IBV_ACCESS_RELAXED_ORDERING));
+	DEVX_SET(mkc, mkc, pd, mpd->pdn);
+	DEVX_SET(mkc, mkc, qpn, 0xffffff);
+	DEVX_SET64(mkc, mkc, start_addr, start_addr);
+}
+
+static int mlx5_vfio_dereg_mr(struct verbs_mr *vmr)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(vmr->ibv_mr.context);
+	struct mlx5_vfio_mr *mr = to_mvfio_mr(&vmr->ibv_mr);
+	uint32_t in[DEVX_ST_SZ_DW(destroy_mkey_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(destroy_mkey_in)] = {};
+	int ret;
+
+	DEVX_SET(destroy_mkey_in, in, opcode, MLX5_CMD_OP_DESTROY_MKEY);
+	DEVX_SET(destroy_mkey_in, in, mkey_index, mlx5_mkey_to_idx(vmr->ibv_mr.lkey));
+	ret = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+	if (ret)
+		return ret;
+
+	mlx5_vfio_unregister_mem(ctx, mr->iova + mr->iova_aligned_offset,
+				 mr->iova_reg_size);
+	iset_insert_range(ctx->iova_alloc, mr->iova, mr->iova_page_size);
+
+	free(vmr);
+	return 0;
+}
+
+static void mlx5_vfio_populate_pas(uint64_t dma_addr, int num_dma, size_t page_size,
+				  __be64 *pas, uint64_t access_flags)
+{
+	int i;
+
+	for (i = 0; i < num_dma; i++) {
+		*pas = htobe64(dma_addr | access_flags);
+		pas++;
+		dma_addr += page_size;
+	}
+}
+
+static uint64_t calc_spanning_page_size(uint64_t start, uint64_t length)
+{
+	/* Compute a page_size such that:
+	 * start & (page_size-1) == (start + length) & (page_size - 1)
+	 */
+	uint64_t diffs = start ^ (start + length - 1);
+
+	return roundup_pow_of_two(diffs + 1);
+}
+
+static struct ibv_mr *mlx5_vfio_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+				       uint64_t hca_va, int access)
+{
+	struct mlx5_vfio_device *dev = to_mvfio_dev(pd->context->device);
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(pd->context);
+	uint32_t out[DEVX_ST_SZ_DW(create_mkey_out)] = {};
+	uint32_t mkey_index;
+	uint32_t *in;
+	int inlen, num_pas, ret;
+	struct mlx5_vfio_mr *mr;
+	struct verbs_mr *vmr;
+	int page_shift, iova_min_page_shift;
+	__be64 *pas;
+	uint8_t key;
+	void *mkc;
+	void *aligned_va;
+
+	if (!check_comp_mask(access, MLX5_VFIO_SUPP_MR_ACCESS_FLAGS)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	if (((uint64_t)addr & (ctx->iova_min_page_size - 1)) !=
+	    (hca_va & (ctx->iova_min_page_size - 1))) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	mr = calloc(1, sizeof(*mr));
+	if (!mr) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	/* Page size that encloses the start and end of the mkey's hca_va range */
+	mr->iova_page_size = max(calc_spanning_page_size(hca_va, length),
+				 ctx->iova_min_page_size);
+
+	ret = iset_alloc_range(ctx->iova_alloc, mr->iova_page_size, &mr->iova);
+	if (ret)
+		goto end;
+
+	aligned_va = (void *)((unsigned long)addr & ~(ctx->iova_min_page_size - 1));
+	page_shift = ilog32(mr->iova_page_size - 1);
+	iova_min_page_shift = ilog32(ctx->iova_min_page_size - 1);
+	if (page_shift > iova_min_page_shift)
+		/* Ensure the low bis of the mkey VA match the low bits of the IOVA because the mkc
+		 * start_addr specifies both the wire VA and the DMA VA.
+		 */
+		mr->iova_aligned_offset = hca_va & GENMASK(page_shift - 1, iova_min_page_shift);
+
+	mr->iova_reg_size = align(length + hca_va, ctx->iova_min_page_size) -
+				  align_down(hca_va, ctx->iova_min_page_size);
+
+	assert(mr->iova_page_size >= mr->iova_aligned_offset + mr->iova_reg_size);
+	ret = mlx5_vfio_register_mem(ctx, aligned_va,
+				     mr->iova + mr->iova_aligned_offset,
+				     mr->iova_reg_size);
+
+	if (ret)
+		goto err_reg;
+
+	num_pas = 1;
+	if (page_shift > MLX5_MAX_PAGE_SHIFT) {
+		page_shift = MLX5_MAX_PAGE_SHIFT;
+		num_pas = calc_num_dma_blocks(hca_va, length, (1ULL << MLX5_MAX_PAGE_SHIFT));
+	}
+
+	inlen = DEVX_ST_SZ_BYTES(create_mkey_in) + (sizeof(*pas) * align(num_pas, 2));
+
+	in = calloc(1, inlen);
+	if (!in) {
+		errno = ENOMEM;
+		goto err_in;
+	}
+
+	pas = (__be64 *)DEVX_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
+	mlx5_vfio_populate_pas(mr->iova, num_pas, (1ULL << page_shift), pas, MLX5_MTT_PRESENT);
+
+	DEVX_SET(create_mkey_in, in, opcode, MLX5_CMD_OP_CREATE_MKEY);
+	DEVX_SET(create_mkey_in, in, pg_access, 1);
+	mkc = DEVX_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	set_mkc_access_pd_addr_fields(mkc, access, hca_va, pd);
+	DEVX_SET(mkc, mkc, free, 0);
+	DEVX_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
+	DEVX_SET64(mkc, mkc, len, length);
+	DEVX_SET(mkc, mkc, bsf_octword_size, 0);
+	DEVX_SET(mkc, mkc, translations_octword_size,
+		 get_octo_len(hca_va, length, page_shift));
+	DEVX_SET(mkc, mkc, log_page_size, page_shift);
+
+	DEVX_SET(create_mkey_in, in, translations_octword_actual_size,
+		 get_octo_len(hca_va, length, page_shift));
+
+	key = atomic_fetch_add(&dev->mkey_var, 1);
+	DEVX_SET(mkc, mkc, mkey_7_0, key);
+
+	ret = mlx5_vfio_cmd_exec(ctx, in, inlen, out, sizeof(out), 0);
+	if (ret)
+		goto err_exec;
+
+	free(in);
+	mkey_index = DEVX_GET(create_mkey_out, out, mkey_index);
+	vmr = &mr->vmr;
+	vmr->ibv_mr.lkey = key | mlx5_idx_to_mkey(mkey_index);
+	vmr->ibv_mr.rkey = vmr->ibv_mr.lkey;
+	vmr->ibv_mr.context = pd->context;
+	vmr->mr_type = IBV_MR_TYPE_MR;
+	vmr->access = access;
+	vmr->ibv_mr.handle = 0;
+
+	return &mr->vmr.ibv_mr;
+
+err_exec:
+	free(in);
+err_in:
+	mlx5_vfio_unregister_mem(ctx, mr->iova + mr->iova_aligned_offset,
+				 mr->iova_reg_size);
+err_reg:
+	iset_insert_range(ctx->iova_alloc, mr->iova, mr->iova_page_size);
+end:
+	free(mr);
+	return NULL;
+}
+
 static void mlx5_vfio_uninit_context(struct mlx5_vfio_context *ctx)
 {
 	mlx5_close_debug_file(ctx->dbg_fp);
@@ -2213,6 +2481,10 @@ static void mlx5_vfio_free_context(struct ibv_context *ibctx)
 }
 
 static const struct verbs_context_ops mlx5_vfio_common_ops = {
+	.alloc_pd = mlx5_vfio_alloc_pd,
+	.dealloc_pd = mlx5_vfio_dealloc_pd,
+	.reg_mr = mlx5_vfio_reg_mr,
+	.dereg_mr = mlx5_vfio_dereg_mr,
 	.free_context = mlx5_vfio_free_context,
 };
 
@@ -2446,6 +2718,7 @@ mlx5dv_get_vfio_device_list(struct mlx5dv_vfio_context_attr *attr)
 
 	vfio_dev->flags = attr->flags;
 	vfio_dev->page_size = sysconf(_SC_PAGESIZE);
+	atomic_init(&vfio_dev->mkey_var, 0);
 
 	list[0] = &vfio_dev->vdev.device;
 	return list;
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 296d6d1..5311c6f 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -23,17 +23,37 @@ enum {
 	MLX5_PCI_CMD_XPORT = 7,
 };
 
+enum mlx5_ib_mtt_access_flags {
+	MLX5_MTT_READ  = (1 << 0),
+	MLX5_MTT_WRITE = (1 << 1),
+};
+
+enum {
+	MLX5_MAX_PAGE_SHIFT = 31,
+};
+
+#define MLX5_MTT_PRESENT (MLX5_MTT_READ | MLX5_MTT_WRITE)
+
 enum {
 	MLX5_VFIO_BLOCK_SIZE = 2 * 1024 * 1024,
 	MLX5_VFIO_BLOCK_NUM_PAGES = MLX5_VFIO_BLOCK_SIZE / MLX5_ADAPTER_PAGE_SIZE,
 };
 
+struct mlx5_vfio_mr {
+	struct verbs_mr vmr;
+	uint64_t iova;
+	uint64_t iova_page_size;
+	uint64_t iova_aligned_offset;
+	uint64_t iova_reg_size;
+};
+
 struct mlx5_vfio_device {
 	struct verbs_device vdev;
 	char *pci_name;
 	char vfio_path[IBV_SYSFS_PATH_MAX];
 	int page_size;
 	uint32_t flags;
+	atomic_int mkey_var;
 };
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
@@ -282,4 +302,9 @@ static inline struct mlx5_vfio_context *to_mvfio_ctx(struct ibv_context *ibctx)
 	return container_of(ibctx, struct mlx5_vfio_context, vctx.context);
 }
 
+static inline struct mlx5_vfio_mr *to_mvfio_mr(struct ibv_mr *ibmr)
+{
+	return container_of(ibmr, struct mlx5_vfio_mr, vmr.ibv_mr);
+}
+
 #endif
diff --git a/util/util.h b/util/util.h
index 2c05631..45f5065 100644
--- a/util/util.h
+++ b/util/util.h
@@ -70,6 +70,11 @@ static inline unsigned long align(unsigned long val, unsigned long align)
 	return (val + align - 1) & ~(align - 1);
 }
 
+static inline unsigned long align_down(unsigned long val, unsigned long _align)
+{
+	return align(val - (_align - 1), _align);
+}
+
 static inline uint64_t roundup_pow_of_two(uint64_t n)
 {
 	return n == 1 ? 1 : 1ULL << ilog64(n - 1);
-- 
1.8.3.1

