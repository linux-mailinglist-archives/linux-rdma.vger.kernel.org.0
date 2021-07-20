Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B63CF5F9
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhGTHhL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:11 -0400
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:63072
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233945AbhGTHhF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfYx9uiZQwJamNoZGBC5ojw2B2O8ZAh9GdjiYC5mf8+43501SqrOWBfi3SOptvEhtQlx5Z4kH2j9Pxqbw053nsKx4OW/8NEj0zLYWknxCXbbTqN/BOE4b9t1ZjwynUKls4AsZwnUmJXY1By9OaWk3Y4v3E6K4H9tR8+gl+6HafV9PmKwd8KErccJRfXCP0DeYDXRcptP8UCyDR6ITVfz0yz6CagSFjuybl3H7PIxJxQ565UqCU9BtphBgUlCFKadocTl9gpUn8hQ5tzkW8j+cVO8eRQQpPMN3oX6q16ZdLbC4HsrbYJjTdhQcGT0KFAe7Hh7L1HdKHaDef48EKG4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An+u1DXLDCI5xfqxApG/lPvw8T6G18ijck7VwCXALI0=;
 b=NUkHbgv6i8nJIad1Q4mc/eUVCG15WISn7Cohq6gegjLsK0CuxK8Zv10mRGcKvjQ7fKxPmYySUrpSB0Xh3Fq8jIevHiEXZZx7+E70Sx8MTGiB0bQfvGtN599T+0IMhorK2bBSekLwirKIa1A+9XVnFcMADWuYFw0sjeIdWvgoKsL42T+8mUcctI1OVdFOon2OqZmB89r/9Z1RS2hepkreSDxlZ22pAxh8QNciEGSl73KZMSfYlHkImc1RYV1amkW31EsOAYP5wwXT3ro2dS0AgF2uHfjR3xCONwa3mlMrrk4GBRW06LxkENdqenTjwU7OELPE4M7NbPA5JrnmzYxdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An+u1DXLDCI5xfqxApG/lPvw8T6G18ijck7VwCXALI0=;
 b=KOsmyJihZF9eils24u6vQEC4Hbl+udGx/66DlDY3lpfiEkW0WASUDOazKPJo7i2I4k2GYqiGKdR3g1rSdn107huFK0NJZzpe6XDeLjNcheJ560KAcQYtsBYXIU5wIvty5fQ43oHGNRE4G7mwme1j9lgkpS6E7IkDjb0uQboTIlnSjELcM6n9jb0GmcOpeBQ9iae7blEDEzzgIpL06oT8SoiM5RGmjjiYLINZ9ny07cXJF3tJDLlk5wouRusSQGFt9mrL5PygNHhm6IDTWb6YE6pPqWXXpbMWXj0adGHaXcuOBuuT96bXIGAhMKBtkbIqOBcyvn1/XMlfhDwEgx3R3Q==
Received: from BN1PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:e0::8)
 by SN6PR12MB2816.namprd12.prod.outlook.com (2603:10b6:805:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:17:42 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::42) by BN1PR10CA0003.outlook.office365.com
 (2603:10b6:408:e0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:42 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:17:40 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:38 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 06/27] mlx5: Setup mlx5 vfio context
Date:   Tue, 20 Jul 2021 11:16:26 +0300
Message-ID: <20210720081647.1980-7-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 267cf182-dd9b-4aef-4ce1-08d94b56d8b4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2816:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28164D19EBA01206D2332EF1C3E29@SN6PR12MB2816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpzESYiZ9XCT+768HEZAF9EUhQz7A5+XRwPHVhalZHY4OsQfLpATK1mnx426X64U5L6o0i7T9kBsyh3Fk6a3ZzO08UVlB8AFxStr/DpyDRlTqRc2pP+7+lS0G+RUrwpWI7/oBwvxa7pvVXO72j+Q7qeL9ja/bA/km6YQl0yFpwJWxnLJT7LGrpUEC6b+GaK6TLOCyVKUHIGyt3I/T6r5mjxFkyXTyktGV0H8+zKyuRUbvtMwSz/k5uSVxNDVREPLjE0zfIuwvcB6jGicsjwcQZ3BI5eNd5V+pHBIWN3nY6Eq4GImI14iFnkTwlpzV3t3nxTmIGr/InF36fNfqyLpySYM24PkXXvCVzoI9kQNsk66CHmpin/jF5JPYrreix9HnG7ve0ncu8JpemOuR8Np0XpBWiAtzN5BDHWBcw9YlzzvB0cVxh8gWm5MrQ6RzXg3L64bhPfHUKsfXbNmH1JgPZZSi0GxA6VWEx+wIXZwsCOo15FGPgIvvbDdD0drbsmLtpMAmWWWkow+5wmyBgJs86ocWrZhMyV0UHFagTcmKfGjn5oD+C7PELo5vPDQZ1OQ6/IA4fREMJr0l7ot98o3n7mN6hTDx7bWCwP5ZxjQetd1XoxjNm9lyhxiVgThTvXUTcjqUbN1CLAmgmKxGPw1wXfaMOEwsUE/MqQPMf2lf2/FWn1yMWuF+areBeyMSHJZGSe2t1/Tdp3rIbIdJCAsag==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(4326008)(82310400003)(7696005)(186003)(70206006)(82740400003)(47076005)(478600001)(36860700001)(26005)(1076003)(86362001)(36756003)(356005)(7636003)(6666004)(8936002)(316002)(8676002)(83380400001)(30864003)(426003)(70586007)(2906002)(54906003)(336012)(107886003)(5660300002)(2616005)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:42.3022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 267cf182-dd9b-4aef-4ce1-08d94b56d8b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Setup mlx5 vfio context by using the ioctl API over vfio to read the
device initialization segment and other required stuff.

As part of that the applicable IOVA ranges are set to be ready for DMA
usage and the command interface is initialized.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5.h      |   2 +
 providers/mlx5/mlx5_vfio.c | 740 +++++++++++++++++++++++++++++++++++++++++++++
 providers/mlx5/mlx5_vfio.h | 134 ++++++++
 3 files changed, 876 insertions(+)

diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 7436bc8..7e7d70d 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -72,6 +72,7 @@ enum {
 
 enum {
 	MLX5_ADAPTER_PAGE_SIZE		= 4096,
+	MLX5_ADAPTER_PAGE_SHIFT		= 12,
 };
 
 #define MLX5_CQ_PREFIX "MLX_CQ"
@@ -90,6 +91,7 @@ enum {
 	MLX5_DBG_CQ_CQE		= 1 << 4,
 	MLX5_DBG_CONTIG		= 1 << 5,
 	MLX5_DBG_DR		= 1 << 6,
+	MLX5_DBG_VFIO		= 1 << 7,
 };
 
 extern uint32_t mlx5_debug_mask;
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 69c7662..86f14f1 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -15,15 +15,755 @@
 #include <sys/mman.h>
 #include <string.h>
 #include <sys/param.h>
+#include <linux/vfio.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
 
 #include "mlx5dv.h"
 #include "mlx5_vfio.h"
 #include "mlx5.h"
 
+static void mlx5_vfio_free_cmd_msg(struct mlx5_vfio_context *ctx,
+				   struct mlx5_cmd_msg *msg);
+
+static int mlx5_vfio_alloc_cmd_msg(struct mlx5_vfio_context *ctx,
+				   uint32_t size, struct mlx5_cmd_msg *msg);
+
+static int mlx5_vfio_register_mem(struct mlx5_vfio_context *ctx,
+				  void *vaddr, uint64_t iova, uint64_t size)
+{
+	struct vfio_iommu_type1_dma_map dma_map = { .argsz = sizeof(dma_map) };
+
+	dma_map.vaddr = (uintptr_t)vaddr;
+	dma_map.size = size;
+	dma_map.iova = iova;
+	dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+
+	return ioctl(ctx->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+}
+
+static void mlx5_vfio_unregister_mem(struct mlx5_vfio_context *ctx,
+				     uint64_t iova, uint64_t size)
+{
+	struct vfio_iommu_type1_dma_unmap dma_unmap = {};
+
+	dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+	dma_unmap.size = size;
+	dma_unmap.iova = iova;
+
+	if (ioctl(ctx->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap))
+		assert(false);
+}
+
+static struct page_block *mlx5_vfio_new_block(struct mlx5_vfio_context *ctx)
+{
+	struct page_block *page_block;
+	int err;
+
+	page_block = calloc(1, sizeof(*page_block));
+	if (!page_block) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	err = posix_memalign(&page_block->page_ptr, MLX5_VFIO_BLOCK_SIZE,
+			     MLX5_VFIO_BLOCK_SIZE);
+	if (err) {
+		errno = err;
+		goto err;
+	}
+
+	err = iset_alloc_range(ctx->iova_alloc, MLX5_VFIO_BLOCK_SIZE, &page_block->iova);
+	if (err)
+		goto err_range;
+
+	bitmap_fill(page_block->free_pages, MLX5_VFIO_BLOCK_NUM_PAGES);
+	err = mlx5_vfio_register_mem(ctx, page_block->page_ptr, page_block->iova,
+				     MLX5_VFIO_BLOCK_SIZE);
+	if (err)
+		goto err_reg;
+
+	list_add(&ctx->mem_alloc.block_list, &page_block->next_block);
+	return page_block;
+
+err_reg:
+	iset_insert_range(ctx->iova_alloc, page_block->iova,
+			  MLX5_VFIO_BLOCK_SIZE);
+err_range:
+	free(page_block->page_ptr);
+err:
+	free(page_block);
+	return NULL;
+}
+
+static void mlx5_vfio_free_block(struct mlx5_vfio_context *ctx,
+				 struct page_block *page_block)
+{
+	mlx5_vfio_unregister_mem(ctx, page_block->iova, MLX5_VFIO_BLOCK_SIZE);
+	iset_insert_range(ctx->iova_alloc, page_block->iova, MLX5_VFIO_BLOCK_SIZE);
+	list_del(&page_block->next_block);
+	free(page_block->page_ptr);
+	free(page_block);
+}
+
+static int mlx5_vfio_alloc_page(struct mlx5_vfio_context *ctx, uint64_t *iova)
+{
+	struct page_block *page_block;
+	unsigned long pg;
+	int ret = 0;
+
+	pthread_mutex_lock(&ctx->mem_alloc.block_list_mutex);
+	while (true) {
+		list_for_each(&ctx->mem_alloc.block_list, page_block, next_block) {
+			pg = bitmap_ffs(page_block->free_pages, 0, MLX5_VFIO_BLOCK_NUM_PAGES);
+			if (pg != MLX5_VFIO_BLOCK_NUM_PAGES) {
+				bitmap_clear_bit(page_block->free_pages, pg);
+				*iova = page_block->iova + pg * MLX5_ADAPTER_PAGE_SIZE;
+				goto end;
+			}
+		}
+		if (!mlx5_vfio_new_block(ctx)) {
+			ret = -1;
+			goto end;
+		}
+	}
+end:
+	pthread_mutex_unlock(&ctx->mem_alloc.block_list_mutex);
+	return ret;
+}
+
+static void mlx5_vfio_free_page(struct mlx5_vfio_context *ctx, uint64_t iova)
+{
+	struct page_block *page_block;
+	unsigned long pg;
+
+	pthread_mutex_lock(&ctx->mem_alloc.block_list_mutex);
+	list_for_each(&ctx->mem_alloc.block_list, page_block, next_block) {
+		if (page_block->iova > iova ||
+		    (page_block->iova + MLX5_VFIO_BLOCK_SIZE <= iova))
+			continue;
+
+		pg = (iova - page_block->iova) / MLX5_ADAPTER_PAGE_SIZE;
+		assert(!bitmap_test_bit(page_block->free_pages, pg));
+		bitmap_set_bit(page_block->free_pages, pg);
+		if (bitmap_full(page_block->free_pages, MLX5_VFIO_BLOCK_NUM_PAGES))
+			mlx5_vfio_free_block(ctx, page_block);
+
+		goto end;
+	}
+
+	assert(false);
+end:
+	pthread_mutex_unlock(&ctx->mem_alloc.block_list_mutex);
+}
+
+static int mlx5_vfio_enable_pci_cmd(struct mlx5_vfio_context *ctx)
+{
+	struct vfio_region_info pci_config_reg = {};
+	uint16_t pci_com_buf = 0x6;
+	char buffer[4096];
+
+	pci_config_reg.argsz = sizeof(pci_config_reg);
+	pci_config_reg.index = VFIO_PCI_CONFIG_REGION_INDEX;
+
+	if (ioctl(ctx->device_fd, VFIO_DEVICE_GET_REGION_INFO, &pci_config_reg))
+		return -1;
+
+	if (pwrite(ctx->device_fd, &pci_com_buf, 2, pci_config_reg.offset + 0x4) != 2)
+		return -1;
+
+	if (pread(ctx->device_fd, buffer, pci_config_reg.size, pci_config_reg.offset)
+			!= pci_config_reg.size)
+		return -1;
+
+	return 0;
+}
+
+static void free_cmd_box(struct mlx5_vfio_context *ctx,
+			 struct mlx5_cmd_mailbox *mailbox)
+{
+	mlx5_vfio_unregister_mem(ctx, mailbox->iova, MLX5_ADAPTER_PAGE_SIZE);
+	iset_insert_range(ctx->iova_alloc, mailbox->iova, MLX5_ADAPTER_PAGE_SIZE);
+	free(mailbox->buf);
+	free(mailbox);
+}
+
+static struct mlx5_cmd_mailbox *alloc_cmd_box(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_cmd_mailbox *mailbox;
+	int ret;
+
+	mailbox = calloc(1, sizeof(*mailbox));
+	if (!mailbox) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	ret = posix_memalign(&mailbox->buf, MLX5_ADAPTER_PAGE_SIZE,
+			     MLX5_ADAPTER_PAGE_SIZE);
+	if (ret) {
+		errno = ret;
+		goto err_free;
+	}
+
+	memset(mailbox->buf, 0, MLX5_ADAPTER_PAGE_SIZE);
+
+	ret = iset_alloc_range(ctx->iova_alloc, MLX5_ADAPTER_PAGE_SIZE, &mailbox->iova);
+	if (ret)
+		goto err_tree;
+
+	ret = mlx5_vfio_register_mem(ctx, mailbox->buf, mailbox->iova,
+				     MLX5_ADAPTER_PAGE_SIZE);
+	if (ret)
+		goto err_reg;
+
+	return mailbox;
+
+err_reg:
+	iset_insert_range(ctx->iova_alloc, mailbox->iova,
+			  MLX5_ADAPTER_PAGE_SIZE);
+err_tree:
+	free(mailbox->buf);
+err_free:
+	free(mailbox);
+	return NULL;
+}
+
+static int mlx5_calc_cmd_blocks(uint32_t msg_len)
+{
+	int size = msg_len;
+	int blen = size - min_t(int, 16, size);
+
+	return DIV_ROUND_UP(blen, MLX5_CMD_DATA_BLOCK_SIZE);
+}
+
+static void mlx5_vfio_free_cmd_msg(struct mlx5_vfio_context *ctx,
+				   struct mlx5_cmd_msg *msg)
+{
+	struct mlx5_cmd_mailbox *head = msg->next;
+	struct mlx5_cmd_mailbox *next;
+
+	while (head) {
+		next = head->next;
+		free_cmd_box(ctx, head);
+		head = next;
+	}
+	msg->len = 0;
+}
+
+static int mlx5_vfio_alloc_cmd_msg(struct mlx5_vfio_context *ctx,
+				   uint32_t size, struct mlx5_cmd_msg *msg)
+{
+	struct mlx5_cmd_mailbox *tmp, *head = NULL;
+	struct mlx5_cmd_block *block;
+	int i, num_blocks;
+
+	msg->len = size;
+	num_blocks = mlx5_calc_cmd_blocks(size);
+
+	for (i = 0; i < num_blocks; i++) {
+		tmp = alloc_cmd_box(ctx);
+		if (!tmp)
+			goto err_alloc;
+
+		block = tmp->buf;
+		tmp->next = head;
+		block->next = htobe64(tmp->next ? tmp->next->iova : 0);
+		block->block_num = htobe32(num_blocks - i - 1);
+		head = tmp;
+	}
+	msg->next = head;
+	return 0;
+
+err_alloc:
+	while (head) {
+		tmp = head->next;
+		free_cmd_box(ctx, head);
+		head = tmp;
+	}
+	msg->len = 0;
+	return -1;
+}
+
+static void mlx5_vfio_free_cmd_slot(struct mlx5_vfio_context *ctx, int slot)
+{
+	struct mlx5_vfio_cmd_slot *cmd_slot = &ctx->cmd.cmds[slot];
+
+	mlx5_vfio_free_cmd_msg(ctx, &cmd_slot->in);
+	mlx5_vfio_free_cmd_msg(ctx, &cmd_slot->out);
+	close(cmd_slot->completion_event_fd);
+}
+
+static int mlx5_vfio_setup_cmd_slot(struct mlx5_vfio_context *ctx, int slot)
+{
+	struct mlx5_vfio_cmd *cmd = &ctx->cmd;
+	struct mlx5_vfio_cmd_slot *cmd_slot = &cmd->cmds[slot];
+	struct mlx5_cmd_layout *cmd_lay;
+	int ret;
+
+	ret = mlx5_vfio_alloc_cmd_msg(ctx, 4096, &cmd_slot->in);
+	if (ret)
+		return ret;
+
+	ret = mlx5_vfio_alloc_cmd_msg(ctx, 4096, &cmd_slot->out);
+	if (ret)
+		goto err;
+
+	cmd_lay = cmd->vaddr + (slot * (1 << cmd->log_stride));
+	cmd_lay->type = MLX5_PCI_CMD_XPORT;
+	cmd_lay->iptr = htobe64(cmd_slot->in.next->iova);
+	cmd_lay->optr = htobe64(cmd_slot->out.next->iova);
+
+	cmd_slot->lay = cmd_lay;
+	cmd_slot->completion_event_fd = eventfd(0, EFD_CLOEXEC);
+	if (cmd_slot->completion_event_fd < 0) {
+		ret = -1;
+		goto err_fd;
+	}
+
+	pthread_mutex_init(&cmd_slot->lock, NULL);
+
+	return 0;
+
+err_fd:
+	mlx5_vfio_free_cmd_msg(ctx, &cmd_slot->out);
+err:
+	mlx5_vfio_free_cmd_msg(ctx, &cmd_slot->in);
+	return ret;
+}
+
+static int mlx5_vfio_init_cmd_interface(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_init_seg *init_seg = ctx->bar_map;
+	struct mlx5_vfio_cmd *cmd = &ctx->cmd;
+	uint16_t cmdif_rev;
+	uint32_t cmd_h, cmd_l;
+	int ret;
+
+	cmdif_rev = be32toh(init_seg->cmdif_rev_fw_sub) >> 16;
+
+	if (cmdif_rev != 5) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	cmd_l = be32toh(init_seg->cmdq_addr_l_sz) & 0xff;
+	ctx->cmd.log_sz = cmd_l >> 4 & 0xf;
+	ctx->cmd.log_stride = cmd_l & 0xf;
+	if (1 << ctx->cmd.log_sz > MLX5_MAX_COMMANDS) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (ctx->cmd.log_sz + ctx->cmd.log_stride > MLX5_ADAPTER_PAGE_SHIFT) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* The initial address must be 4K aligned */
+	ret = posix_memalign(&cmd->vaddr, MLX5_ADAPTER_PAGE_SIZE,
+			     MLX5_ADAPTER_PAGE_SIZE);
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+
+	memset(cmd->vaddr, 0, MLX5_ADAPTER_PAGE_SIZE);
+
+	ret = iset_alloc_range(ctx->iova_alloc, MLX5_ADAPTER_PAGE_SIZE, &cmd->iova);
+	if (ret)
+		goto err_free;
+
+	ret = mlx5_vfio_register_mem(ctx, cmd->vaddr, cmd->iova, MLX5_ADAPTER_PAGE_SIZE);
+	if (ret)
+		goto err_reg;
+
+	cmd_h = (uint32_t)((uint64_t)(cmd->iova) >> 32);
+	cmd_l = (uint32_t)(uint64_t)(cmd->iova);
+
+	init_seg->cmdq_addr_h = htobe32(cmd_h);
+	init_seg->cmdq_addr_l_sz = htobe32(cmd_l);
+
+	/* Make sure firmware sees the complete address before we proceed */
+	udma_to_device_barrier();
+
+	ret = mlx5_vfio_setup_cmd_slot(ctx, 0);
+	if (ret)
+		goto err_slot_0;
+
+	ret = mlx5_vfio_setup_cmd_slot(ctx, MLX5_MAX_COMMANDS - 1);
+	if (ret)
+		goto err_slot_1;
+
+	ret = mlx5_vfio_enable_pci_cmd(ctx);
+	if (!ret)
+		return 0;
+
+	mlx5_vfio_free_cmd_slot(ctx, MLX5_MAX_COMMANDS - 1);
+err_slot_1:
+	mlx5_vfio_free_cmd_slot(ctx, 0);
+err_slot_0:
+	mlx5_vfio_unregister_mem(ctx, cmd->iova, MLX5_ADAPTER_PAGE_SIZE);
+err_reg:
+	iset_insert_range(ctx->iova_alloc, cmd->iova, MLX5_ADAPTER_PAGE_SIZE);
+err_free:
+	free(cmd->vaddr);
+	return ret;
+}
+
+static void mlx5_vfio_clean_cmd_interface(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_vfio_cmd *cmd = &ctx->cmd;
+
+	mlx5_vfio_free_cmd_slot(ctx, 0);
+	mlx5_vfio_free_cmd_slot(ctx, MLX5_MAX_COMMANDS - 1);
+	mlx5_vfio_unregister_mem(ctx, cmd->iova, MLX5_ADAPTER_PAGE_SIZE);
+	iset_insert_range(ctx->iova_alloc, cmd->iova, MLX5_ADAPTER_PAGE_SIZE);
+	free(cmd->vaddr);
+}
+
+static void set_iova_min_page_size(struct mlx5_vfio_context *ctx,
+				   uint64_t iova_pgsizes)
+{
+	int i;
+
+	for (i = MLX5_ADAPTER_PAGE_SHIFT; i < 64; i++) {
+		if (iova_pgsizes & (1 << i)) {
+			ctx->iova_min_page_size = 1 << i;
+			return;
+		}
+	}
+
+	assert(false);
+}
+
+/* if the kernel does not report usable IOVA regions, choose the legacy region */
+#define MLX5_VFIO_IOVA_MIN1 0x10000ULL
+#define MLX5_VFIO_IOVA_MAX1 0xFEDFFFFFULL
+#define MLX5_VFIO_IOVA_MIN2 0xFEF00000ULL
+#define MLX5_VFIO_IOVA_MAX2 ((1ULL << 39) - 1)
+
+static int mlx5_vfio_get_iommu_info(struct mlx5_vfio_context *ctx)
+{
+	struct vfio_iommu_type1_info *info;
+	int ret, i;
+	void *ptr;
+	uint32_t offset;
+
+	info = calloc(1, sizeof(*info));
+	if (!info) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	info->argsz = sizeof(*info);
+	ret = ioctl(ctx->container_fd, VFIO_IOMMU_GET_INFO, info);
+	if (ret)
+		goto end;
+
+	if (info->argsz > sizeof(*info)) {
+		info = realloc(info, info->argsz);
+		if (!info) {
+			errno = ENOMEM;
+			ret = -1;
+			goto end;
+		}
+
+		ret = ioctl(ctx->container_fd, VFIO_IOMMU_GET_INFO, info);
+		if (ret)
+			goto end;
+	}
+
+	set_iova_min_page_size(ctx, (info->flags & VFIO_IOMMU_INFO_PGSIZES) ?
+			       info->iova_pgsizes : 4096);
+
+	if (!(info->flags & VFIO_IOMMU_INFO_CAPS))
+		goto set_legacy;
+
+	offset = info->cap_offset;
+	while (offset) {
+		struct vfio_iommu_type1_info_cap_iova_range *iova_range;
+		struct vfio_info_cap_header *header;
+
+		ptr = (void *)info + offset;
+		header = ptr;
+
+		if (header->id != VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE) {
+			offset = header->next;
+			continue;
+		}
+
+		iova_range = (struct vfio_iommu_type1_info_cap_iova_range *)header;
+
+		for (i = 0; i < iova_range->nr_iovas; i++) {
+			mlx5_dbg(ctx->dbg_fp, MLX5_DBG_VFIO, "\t%02d: %016llx - %016llx\n", i,
+				 iova_range->iova_ranges[i].start,
+				 iova_range->iova_ranges[i].end);
+			ret = iset_insert_range(ctx->iova_alloc, iova_range->iova_ranges[i].start,
+						iova_range->iova_ranges[i].end -
+						iova_range->iova_ranges[i].start + 1);
+			if (ret)
+				goto end;
+		}
+
+		goto end;
+	}
+
+set_legacy:
+	ret = iset_insert_range(ctx->iova_alloc, MLX5_VFIO_IOVA_MIN1,
+				MLX5_VFIO_IOVA_MAX1 - MLX5_VFIO_IOVA_MIN1 + 1);
+	if (!ret)
+		ret = iset_insert_range(ctx->iova_alloc, MLX5_VFIO_IOVA_MIN2,
+					MLX5_VFIO_IOVA_MAX2 - MLX5_VFIO_IOVA_MIN2 + 1);
+
+end:
+	free(info);
+	return ret;
+}
+
+static void mlx5_vfio_clean_device_dma(struct mlx5_vfio_context *ctx)
+{
+	struct page_block *page_block, *tmp;
+
+	list_for_each_safe(&ctx->mem_alloc.block_list, page_block,
+			   tmp, next_block)
+		mlx5_vfio_free_block(ctx, page_block);
+
+	iset_destroy(ctx->iova_alloc);
+}
+
+static int mlx5_vfio_init_device_dma(struct mlx5_vfio_context *ctx)
+{
+	ctx->iova_alloc = iset_create();
+	if (!ctx->iova_alloc)
+		return -1;
+
+	list_head_init(&ctx->mem_alloc.block_list);
+	pthread_mutex_init(&ctx->mem_alloc.block_list_mutex, NULL);
+
+	if (mlx5_vfio_get_iommu_info(ctx))
+		goto err;
+
+	/* create an initial block of DMA memory ready to be used */
+	if (!mlx5_vfio_new_block(ctx))
+		goto err;
+
+	return 0;
+err:
+	iset_destroy(ctx->iova_alloc);
+	return -1;
+}
+
+static void mlx5_vfio_uninit_bar0(struct mlx5_vfio_context *ctx)
+{
+	munmap(ctx->bar_map, ctx->bar_map_size);
+}
+
+static int mlx5_vfio_init_bar0(struct mlx5_vfio_context *ctx)
+{
+	struct vfio_region_info reg = { .argsz = sizeof(reg) };
+	void *base;
+	int err;
+
+	reg.index = 0;
+	err = ioctl(ctx->device_fd, VFIO_DEVICE_GET_REGION_INFO, &reg);
+	if (err)
+		return err;
+
+	base = mmap(NULL, reg.size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		    ctx->device_fd, reg.offset);
+	if (base == MAP_FAILED)
+		return -1;
+
+	ctx->bar_map = (struct mlx5_init_seg *)base;
+	ctx->bar_map_size = reg.size;
+	return 0;
+}
+
+#define MLX5_VFIO_MAX_INTR_VEC_ID 1
+#define MSIX_IRQ_SET_BUF_LEN (sizeof(struct vfio_irq_set) + \
+			      sizeof(int) * (MLX5_VFIO_MAX_INTR_VEC_ID))
+
+/* enable MSI-X interrupts */
+static int
+mlx5_vfio_enable_msix(struct mlx5_vfio_context *ctx)
+{
+	char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
+	struct vfio_irq_set *irq_set;
+	int len;
+	int *fd_ptr;
+
+	len = sizeof(irq_set_buf);
+
+	irq_set = (struct vfio_irq_set *)irq_set_buf;
+	irq_set->argsz = len;
+	irq_set->count = 1;
+	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+	irq_set->start = 0;
+	fd_ptr = (int *)&irq_set->data;
+	fd_ptr[0] = ctx->cmd_comp_fd;
+
+	return ioctl(ctx->device_fd, VFIO_DEVICE_SET_IRQS, irq_set);
+}
+
+static int mlx5_vfio_init_async_fd(struct mlx5_vfio_context *ctx)
+{
+	struct vfio_irq_info irq = { .argsz = sizeof(irq) };
+
+	irq.index = VFIO_PCI_MSIX_IRQ_INDEX;
+	if (ioctl(ctx->device_fd, VFIO_DEVICE_GET_IRQ_INFO, &irq))
+		return -1;
+
+	/* fail if this vector cannot be used with eventfd */
+	if ((irq.flags & VFIO_IRQ_INFO_EVENTFD) == 0)
+		return -1;
+
+	/* set up an eventfd for command completion interrupts */
+	ctx->cmd_comp_fd = eventfd(0, EFD_CLOEXEC);
+	if (ctx->cmd_comp_fd < 0)
+		return -1;
+
+	if (mlx5_vfio_enable_msix(ctx))
+		goto err_msix;
+
+	return 0;
+
+err_msix:
+	close(ctx->cmd_comp_fd);
+	return -1;
+}
+
+static void mlx5_vfio_close_fds(struct mlx5_vfio_context *ctx)
+{
+	close(ctx->device_fd);
+	close(ctx->container_fd);
+	close(ctx->group_fd);
+	close(ctx->cmd_comp_fd);
+}
+
+static int mlx5_vfio_open_fds(struct mlx5_vfio_context *ctx,
+			      struct mlx5_vfio_device *mdev)
+{
+	struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
+
+	/* Create a new container */
+	ctx->container_fd = open("/dev/vfio/vfio", O_RDWR);
+
+	if (ctx->container_fd < 0)
+		return -1;
+
+	if (ioctl(ctx->container_fd, VFIO_GET_API_VERSION) != VFIO_API_VERSION)
+		goto close_cont;
+
+	if (!ioctl(ctx->container_fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU))
+		/* Doesn't support the IOMMU driver we want. */
+		goto close_cont;
+
+	/* Open the group */
+	ctx->group_fd = open(mdev->vfio_path, O_RDWR);
+	if (ctx->group_fd < 0)
+		goto close_cont;
+
+	/* Test the group is viable and available */
+	if (ioctl(ctx->group_fd, VFIO_GROUP_GET_STATUS, &group_status))
+		goto close_group;
+
+	if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
+		/* Group is not viable (ie, not all devices bound for vfio) */
+		errno = EINVAL;
+		goto close_group;
+	}
+
+	/* Add the group to the container */
+	if (ioctl(ctx->group_fd, VFIO_GROUP_SET_CONTAINER, &ctx->container_fd))
+		goto close_group;
+
+	/* Enable the IOMMU model we want */
+	if (ioctl(ctx->container_fd, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU))
+		goto close_group;
+
+	/* Get a file descriptor for the device */
+	ctx->device_fd = ioctl(ctx->group_fd, VFIO_GROUP_GET_DEVICE_FD,
+			       mdev->pci_name);
+	if (ctx->device_fd < 0)
+		goto close_group;
+
+	if (mlx5_vfio_init_async_fd(ctx))
+		goto close_group;
+
+	return 0;
+
+close_group:
+	close(ctx->group_fd);
+close_cont:
+	close(ctx->container_fd);
+	return -1;
+}
+
+static void mlx5_vfio_uninit_context(struct mlx5_vfio_context *ctx)
+{
+	mlx5_close_debug_file(ctx->dbg_fp);
+
+	verbs_uninit_context(&ctx->vctx);
+	free(ctx);
+}
+
+static void mlx5_vfio_free_context(struct ibv_context *ibctx)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
+
+	mlx5_vfio_clean_cmd_interface(ctx);
+	mlx5_vfio_clean_device_dma(ctx);
+	mlx5_vfio_uninit_bar0(ctx);
+	mlx5_vfio_close_fds(ctx);
+	mlx5_vfio_uninit_context(ctx);
+}
+
+static const struct verbs_context_ops mlx5_vfio_common_ops = {
+	.free_context = mlx5_vfio_free_context,
+};
+
 static struct verbs_context *
 mlx5_vfio_alloc_context(struct ibv_device *ibdev,
 			int cmd_fd, void *private_data)
 {
+	struct mlx5_vfio_device *mdev = to_mvfio_dev(ibdev);
+	struct mlx5_vfio_context *mctx;
+
+	cmd_fd = -1;
+
+	mctx = verbs_init_and_alloc_context(ibdev, cmd_fd, mctx, vctx,
+					    RDMA_DRIVER_UNKNOWN);
+	if (!mctx)
+		return NULL;
+
+	mlx5_open_debug_file(&mctx->dbg_fp);
+	mlx5_set_debug_mask();
+
+	if (mlx5_vfio_open_fds(mctx, mdev))
+		goto err;
+
+	if (mlx5_vfio_init_bar0(mctx))
+		goto close_fds;
+
+	if (mlx5_vfio_init_device_dma(mctx))
+		goto err_bar;
+
+	if (mlx5_vfio_init_cmd_interface(mctx))
+		goto err_dma;
+
+	verbs_set_ops(&mctx->vctx, &mlx5_vfio_common_ops);
+	return &mctx->vctx;
+
+err_dma:
+	mlx5_vfio_clean_device_dma(mctx);
+err_bar:
+	mlx5_vfio_uninit_bar0(mctx);
+close_fds:
+	mlx5_vfio_close_fds(mctx);
+err:
+	mlx5_vfio_uninit_context(mctx);
 	return NULL;
 }
 
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 6ba4254..392ddcb 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -8,8 +8,21 @@
 
 #include <stddef.h>
 #include <stdio.h>
+#include "mlx5.h"
 
 #include <infiniband/driver.h>
+#include <util/interval_set.h>
+
+enum {
+	MLX5_MAX_COMMANDS = 32,
+	MLX5_CMD_DATA_BLOCK_SIZE = 512,
+	MLX5_PCI_CMD_XPORT = 7,
+};
+
+enum {
+	MLX5_VFIO_BLOCK_SIZE = 2 * 1024 * 1024,
+	MLX5_VFIO_BLOCK_NUM_PAGES = MLX5_VFIO_BLOCK_SIZE / MLX5_ADAPTER_PAGE_SIZE,
+};
 
 struct mlx5_vfio_device {
 	struct verbs_device vdev;
@@ -19,9 +32,130 @@ struct mlx5_vfio_device {
 	uint32_t flags;
 };
 
+struct health_buffer {
+	__be32		assert_var[5];
+	__be32		rsvd0[3];
+	__be32		assert_exit_ptr;
+	__be32		assert_callra;
+	__be32		rsvd1[2];
+	__be32		fw_ver;
+	__be32		hw_id;
+	__be32		rfr;
+	uint8_t		irisc_index;
+	uint8_t		synd;
+	__be16		ext_synd;
+};
+
+struct mlx5_init_seg {
+	__be32			fw_rev;
+	__be32			cmdif_rev_fw_sub;
+	__be32			rsvd0[2];
+	__be32			cmdq_addr_h;
+	__be32			cmdq_addr_l_sz;
+	__be32			cmd_dbell;
+	__be32			rsvd1[120];
+	__be32			initializing;
+	struct health_buffer	health;
+	__be32			rsvd2[880];
+	__be32			internal_timer_h;
+	__be32			internal_timer_l;
+	__be32			rsvd3[2];
+	__be32			health_counter;
+	__be32			rsvd4[1019];
+	__be64			ieee1588_clk;
+	__be32			ieee1588_clk_type;
+	__be32			clr_intx;
+};
+
+struct mlx5_cmd_layout {
+	uint8_t		type;
+	uint8_t		rsvd0[3];
+	__be32		ilen;
+	__be64		iptr;
+	__be32		in[4];
+	__be32		out[4];
+	__be64		optr;
+	__be32		olen;
+	uint8_t		token;
+	uint8_t		sig;
+	uint8_t		rsvd1;
+	uint8_t		status_own;
+};
+
+struct mlx5_cmd_block {
+	uint8_t		data[MLX5_CMD_DATA_BLOCK_SIZE];
+	uint8_t		rsvd0[48];
+	__be64		next;
+	__be32		block_num;
+	uint8_t		rsvd1;
+	uint8_t		token;
+	uint8_t		ctrl_sig;
+	uint8_t		sig;
+};
+
+struct page_block {
+	void *page_ptr;
+	uint64_t iova;
+	struct list_node next_block;
+	BITMAP_DECLARE(free_pages, MLX5_VFIO_BLOCK_NUM_PAGES);
+};
+
+struct vfio_mem_allocator {
+	struct list_head block_list;
+	pthread_mutex_t block_list_mutex;
+};
+
+struct mlx5_cmd_mailbox {
+	void *buf;
+	uint64_t iova;
+	struct mlx5_cmd_mailbox *next;
+};
+
+struct mlx5_cmd_msg {
+	uint32_t len;
+	struct mlx5_cmd_mailbox *next;
+};
+
+struct mlx5_vfio_cmd_slot {
+	struct mlx5_cmd_layout *lay;
+	struct mlx5_cmd_msg in;
+	struct mlx5_cmd_msg out;
+	pthread_mutex_t lock;
+	int completion_event_fd;
+};
+
+struct mlx5_vfio_cmd {
+	void *vaddr; /* cmd page address */
+	uint64_t iova;
+	uint8_t log_sz;
+	uint8_t log_stride;
+	struct mlx5_vfio_cmd_slot cmds[MLX5_MAX_COMMANDS];
+};
+
+struct mlx5_vfio_context {
+	struct verbs_context vctx;
+	int container_fd;
+	int group_fd;
+	int device_fd;
+	int cmd_comp_fd; /* command completion FD */
+	struct iset *iova_alloc;
+	uint64_t iova_min_page_size;
+	FILE *dbg_fp;
+	struct vfio_mem_allocator mem_alloc;
+	struct mlx5_init_seg *bar_map;
+	size_t bar_map_size;
+	struct mlx5_vfio_cmd cmd;
+	bool have_eq;
+};
+
 static inline struct mlx5_vfio_device *to_mvfio_dev(struct ibv_device *ibdev)
 {
 	return container_of(ibdev, struct mlx5_vfio_device, vdev.device);
 }
 
+static inline struct mlx5_vfio_context *to_mvfio_ctx(struct ibv_context *ibctx)
+{
+	return container_of(ibctx, struct mlx5_vfio_context, vctx.context);
+}
+
 #endif
-- 
1.8.3.1

