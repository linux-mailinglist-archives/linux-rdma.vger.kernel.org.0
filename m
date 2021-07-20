Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4E3CF607
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhGTHiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:00 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:60960
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232249AbhGTHhV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPiT/pzCdDKxfTgcum9+YdmtzSdVY6XeeqTkm3Wsk5WfgKct1MAOqcz7PTpE1OSbdeut0/Tux4ItRQvtsPyWGOI/b+oekFoPcnjybsKMKFbH2p3nU8cc3NwGCoEtJbANAwWkjzIxHQpC6cMIRwDrO7yRFPcxWpY39qTrcG2dZmDmpk3tbb4NgYhYHfJf/iF7n5Nz86TIk8CGuy3wq0O4mJpCZmJCqujGzyWjRrkdKDmUz+uan1q52xd/J1k6zo6BRzc0cjxSJ4ObWl8rYIoajXtGCWn889JLPHBuhC+bpK4wTTNuHIaH/bfoxMPd/oIUOSeEXEz3UwA1P0QCjqU8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuahzllws/k702YZWUaIn0xn6rmnAKRbfh/G/Mbtxf0=;
 b=GmR5/jg2nIYONWskM1lGV6VDVvz0A9qxQ+HaYMq4+c+Va9Sp9KYrcS7yNV/2FnB30aWgDKchD8Vdc1j7e56zh/NbA16aezrz/hHNMTLVe/bQXcEs9KYcRIqZ/PAdM1r8p3WB18DRHiLF7w2Rx0icc51a10/dcRIlFRGDSPTnBy1D+/fDN8V5NUPvPV0Ivta/mafCQ42IM+eZX0AsnJcXrz7amyDZ7YCFB3mnKHTyrqbvRqjprLOK/DALBXU/bHuzJ7RbI2qxXQ2FxYcMKdS+HEydFpuNAP0nskJlKI6Uf5kPI36z8u49A3VORVLlxqQrW67SxyJWCSE2B584rv+Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuahzllws/k702YZWUaIn0xn6rmnAKRbfh/G/Mbtxf0=;
 b=JVQjldhxnwzPJPVbA+5L/rLTK2oRQVWeMKYf+F7GRHgf4SC7QRjOx2E4ma7D5N2iR34IFKzeaksmUGCn6VFc3tgfCkMHzH4qFjf8jX+6MLJeQhdxdZZcNCDKvdESSRfSycy5uCR0wRA+RYzLTrP9yS5mvbhNyHerPzmDm4WpliVjVSXmj/4njn/onmFcR1YYkiiQjRigGwR74iyTFKSFgPY0XnX53tsoIZ+WiggYk9JfJHaeC66Azyi1gJaYxc2G3Z0cA048+S2cii6Sc8+PKScKk1z37vNw4Fnp+jaPL+jZN114N+c76G9Dv8PSQadV22SlLcWACZrwll10uYLN4g==
Received: from MWHPR22CA0063.namprd22.prod.outlook.com (2603:10b6:300:12a::25)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.34; Tue, 20 Jul
 2021 08:17:58 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::5a) by MWHPR22CA0063.outlook.office365.com
 (2603:10b6:300:12a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:58 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:57 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:55 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 13/27] mlx5: VFIO poll_health support
Date:   Tue, 20 Jul 2021 11:16:33 +0300
Message-ID: <20210720081647.1980-14-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384d9a82-8dd7-4a7c-3f17-08d94b56e216
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24931517A7AB83EEC9693395C3E29@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ae1hcg40Kr7NWE6auqxHV3RatD0EVtkFcClcci+U4nxn0QmMwHIn0QrL2yXAamb+soAGMNpY3yxqRSDvJOnCWo9ZkeeFYjTFnRE6pVWdc2apHpIxG/wI38wJr4IUui9lI5IN1NlOzUY/ddNxOYTbBqGCCFg86xKMuW9puSIg6Tpq081UvB4UqVdcZRSA+OIEo5zzRGWx7zzaAhdK6Q6YQWfXgN8ciiX41W+jsp85g7ktFf8RTE/ydDdniEnEf6BJYv5maGyboSOk0cV0KdqSEWJ2tej0NbCG7F/NZOjvvqy57pcnbADcITbA+2Zop09wDo4EPEahqaN+0Iakv9F8vVeBfJHZL67unit1PDDU05oP3AqEluhFHDjvTU6ZDNJ2l2EZdHty+y+OSTCSWI3WPVwZvXFtvNsk8KyXpZTehBQk8IQi+2hS36uBRbrlP3J07B3jAcDdjoDZyG+n9p2rRfUrmdLNcp5HaCIAcRkfokhVx06/ycUFOYdOML/doiW0tMfr9vfFQ1J615J9IBHv/iEIz26DLa2VEglFDRUzZSERdBNblmXf4IyB1TYue3sUAA+3zyFvCsgPq0ibwLmSCG51X25YWx4PpjxepBaMgXr/wEydTUb24bIaWeW5FLc817zm6H993Kz0R3UDPCbJorgJf9/HqKqrAJz04LonjUSVdHCtu4QsMvV/WSiRAX70iHMPtCLzSYg6Cbc9JMnhw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(83380400001)(8676002)(478600001)(86362001)(36860700001)(7636003)(36756003)(82740400003)(47076005)(6666004)(82310400003)(2616005)(336012)(356005)(186003)(2906002)(316002)(8936002)(26005)(5660300002)(6916009)(4326008)(107886003)(426003)(7696005)(36906005)(70206006)(1076003)(70586007)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:58.0895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384d9a82-8dd7-4a7c-3f17-08d94b56e216
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Add firmware health polling support in vfio driver.

Such a case is not expected and we refer it as some fatal error in the
firmware that should be avoided/fixed.

The health buffer check is triggered by the application upon its call to
mlx5dv_vfio_process_events().

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_vfio.c | 168 +++++++++++++++++++++++++++++++++++++++++++++
 providers/mlx5/mlx5_vfio.h |  10 ++-
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 85ee25b..c37358c 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -22,6 +22,8 @@
 #include <poll.h>
 #include <util/mmio.h>
 
+#include <ccan/array_size.h>
+
 #include "mlx5dv.h"
 #include "mlx5_vfio.h"
 #include "mlx5.h"
@@ -1910,6 +1912,7 @@ enum mlx5_cmd_addr_l_sz_offset {
 
 enum {
 	MLX5_NIC_IFC_DISABLED = 1,
+	MLX5_NIC_IFC_SW_RESET = 7,
 };
 
 static uint8_t mlx5_vfio_get_nic_state(struct mlx5_vfio_context *ctx)
@@ -1978,6 +1981,169 @@ static int mlx5_vfio_teardown_hca(struct mlx5_vfio_context *ctx)
 	return mlx5_vfio_teardown_hca_regular(ctx);
 }
 
+static bool sensor_pci_not_working(struct mlx5_init_seg *init_seg)
+{
+	/* Offline PCI reads return 0xffffffff */
+	return (be32toh(mmio_read32_be(&init_seg->health.fw_ver)) == 0xffffffff);
+}
+
+enum mlx5_fatal_assert_bit_offsets {
+	MLX5_RFR_OFFSET = 31,
+};
+
+static bool sensor_fw_synd_rfr(struct mlx5_init_seg *init_seg)
+{
+	uint32_t rfr = be32toh(mmio_read32_be(&init_seg->health.rfr)) >> MLX5_RFR_OFFSET;
+	uint8_t synd = mmio_read8(&init_seg->health.synd);
+
+	return (rfr && synd);
+}
+
+enum  {
+	MLX5_SENSOR_NO_ERR = 0,
+	MLX5_SENSOR_PCI_COMM_ERR = 1,
+	MLX5_SENSOR_NIC_DISABLED = 3,
+	MLX5_SENSOR_NIC_SW_RESET = 4,
+	MLX5_SENSOR_FW_SYND_RFR = 5,
+};
+
+static uint32_t mlx5_health_check_fatal_sensors(struct mlx5_vfio_context *ctx)
+{
+	if (sensor_pci_not_working(ctx->bar_map))
+		return MLX5_SENSOR_PCI_COMM_ERR;
+
+	if (mlx5_vfio_get_nic_state(ctx) == MLX5_NIC_IFC_DISABLED)
+		return MLX5_SENSOR_NIC_DISABLED;
+
+	if (mlx5_vfio_get_nic_state(ctx) == MLX5_NIC_IFC_SW_RESET)
+		return MLX5_SENSOR_NIC_SW_RESET;
+
+	if (sensor_fw_synd_rfr(ctx->bar_map))
+		return MLX5_SENSOR_FW_SYND_RFR;
+
+	return MLX5_SENSOR_NO_ERR;
+}
+
+enum {
+	MLX5_HEALTH_SYNDR_FW_ERR = 0x1,
+	MLX5_HEALTH_SYNDR_IRISC_ERR = 0x7,
+	MLX5_HEALTH_SYNDR_HW_UNRECOVERABLE_ERR = 0x8,
+	MLX5_HEALTH_SYNDR_CRC_ERR = 0x9,
+	MLX5_HEALTH_SYNDR_FETCH_PCI_ERR = 0xa,
+	MLX5_HEALTH_SYNDR_HW_FTL_ERR = 0xb,
+	MLX5_HEALTH_SYNDR_ASYNC_EQ_OVERRUN_ERR = 0xc,
+	MLX5_HEALTH_SYNDR_EQ_ERR = 0xd,
+	MLX5_HEALTH_SYNDR_EQ_INV = 0xe,
+	MLX5_HEALTH_SYNDR_FFSER_ERR = 0xf,
+	MLX5_HEALTH_SYNDR_HIGH_TEMP = 0x10,
+};
+
+static const char *hsynd_str(u8 synd)
+{
+	switch (synd) {
+	case MLX5_HEALTH_SYNDR_FW_ERR:
+		return "firmware internal error";
+	case MLX5_HEALTH_SYNDR_IRISC_ERR:
+		return "irisc not responding";
+	case MLX5_HEALTH_SYNDR_HW_UNRECOVERABLE_ERR:
+		return "unrecoverable hardware error";
+	case MLX5_HEALTH_SYNDR_CRC_ERR:
+		return "firmware CRC error";
+	case MLX5_HEALTH_SYNDR_FETCH_PCI_ERR:
+		return "ICM fetch PCI error";
+	case MLX5_HEALTH_SYNDR_HW_FTL_ERR:
+		return "HW fatal error\n";
+	case MLX5_HEALTH_SYNDR_ASYNC_EQ_OVERRUN_ERR:
+		return "async EQ buffer overrun";
+	case MLX5_HEALTH_SYNDR_EQ_ERR:
+		return "EQ error";
+	case MLX5_HEALTH_SYNDR_EQ_INV:
+		return "Invalid EQ referenced";
+	case MLX5_HEALTH_SYNDR_FFSER_ERR:
+		return "FFSER error";
+	case MLX5_HEALTH_SYNDR_HIGH_TEMP:
+		return "High temperature";
+	default:
+		return "unrecognized error";
+	}
+}
+
+static void print_health_info(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_init_seg *iseg = ctx->bar_map;
+	struct health_buffer *h = &iseg->health;
+	char fw_str[18] = {};
+	int i;
+
+	/* If the syndrome is 0, the device is OK and no need to print buffer */
+	if (!mmio_read8(&h->synd))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(h->assert_var); i++)
+		mlx5_err(ctx->dbg_fp, "assert_var[%d] 0x%08x\n",
+			 i, be32toh(mmio_read32_be(h->assert_var + i)));
+
+	mlx5_err(ctx->dbg_fp, "assert_exit_ptr 0x%08x\n",
+		 be32toh(mmio_read32_be(&h->assert_exit_ptr)));
+	mlx5_err(ctx->dbg_fp, "assert_callra 0x%08x\n",
+		 be32toh(mmio_read32_be(&h->assert_callra)));
+	sprintf(fw_str, "%d.%d.%d",
+		be32toh(mmio_read32_be(&iseg->fw_rev)) & 0xffff,
+		be32toh(mmio_read32_be(&iseg->fw_rev)) >> 16,
+		be32toh(mmio_read32_be(&iseg->cmdif_rev_fw_sub)) & 0xffff);
+	mlx5_err(ctx->dbg_fp, "fw_ver %s\n", fw_str);
+	mlx5_err(ctx->dbg_fp, "hw_id 0x%08x\n", be32toh(mmio_read32_be(&h->hw_id)));
+	mlx5_err(ctx->dbg_fp, "irisc_index %d\n", mmio_read8(&h->irisc_index));
+	mlx5_err(ctx->dbg_fp, "synd 0x%x: %s\n", mmio_read8(&h->synd),
+		 hsynd_str(mmio_read8(&h->synd)));
+	mlx5_err(ctx->dbg_fp, "ext_synd 0x%04x\n",
+		 be16toh(mmio_read16_be(&h->ext_synd)));
+	mlx5_err(ctx->dbg_fp, "raw fw_ver 0x%08x\n",
+		 be32toh(mmio_read32_be(&iseg->fw_rev)));
+}
+
+static void mlx5_vfio_poll_health(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_vfio_health_state *hstate = &ctx->health_state;
+	uint32_t fatal_error, count;
+	struct timeval tv;
+	uint64_t time;
+	int ret;
+
+	ret = gettimeofday(&tv, NULL);
+	if (ret)
+		return;
+
+	time = (uint64_t)tv.tv_sec * 1000 + tv.tv_usec / 1000;
+	if (time - hstate->prev_time < POLL_HEALTH_INTERVAL)
+		return;
+
+	fatal_error = mlx5_health_check_fatal_sensors(ctx);
+	if (fatal_error) {
+		mlx5_err(ctx->dbg_fp, "%s: Fatal error %u detected\n",
+			 __func__, fatal_error);
+		goto err;
+	}
+	count = be32toh(mmio_read32_be(&ctx->bar_map->health_counter)) & 0xffffff;
+	if (count == hstate->prev_count)
+		++hstate->miss_counter;
+	else
+		hstate->miss_counter = 0;
+
+	hstate->prev_time = time;
+	hstate->prev_count = count;
+	if (hstate->miss_counter == MAX_MISSES) {
+		mlx5_err(ctx->dbg_fp,
+			 "device's health compromised - reached miss count\n");
+		goto err;
+	}
+
+	return;
+err:
+	print_health_info(ctx);
+	abort();
+}
+
 static int mlx5_vfio_setup_function(struct mlx5_vfio_context *ctx)
 {
 	int err;
@@ -2232,6 +2398,8 @@ int mlx5dv_vfio_process_events(struct ibv_context *ibctx)
 	uint64_t u;
 	ssize_t s;
 
+	mlx5_vfio_poll_health(ctx);
+
 	/* read to re-arm the FD and process all existing events */
 	s = read(ctx->cmd_comp_fd, &u, sizeof(uint64_t));
 	if (s < 0 && errno != EAGAIN) {
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 8e240c8..296d6d1 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -240,6 +240,14 @@ struct mlx5_vfio_eqs_uar {
 	uint64_t iova;
 };
 
+#define POLL_HEALTH_INTERVAL 1000 /* ms */
+#define MAX_MISSES 3
+struct mlx5_vfio_health_state {
+	uint64_t prev_time; /* ms */
+	uint32_t prev_count;
+	uint32_t miss_counter;
+};
+
 struct mlx5_vfio_context {
 	struct verbs_context vctx;
 	int container_fd;
@@ -258,7 +266,7 @@ struct mlx5_vfio_context {
 		uint32_t hca_cur[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
 		uint32_t hca_max[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
 	} caps;
-
+	struct mlx5_vfio_health_state health_state;
 	struct mlx5_eq async_eq;
 	struct mlx5_vfio_eqs_uar eqs_uar;
 	pthread_mutex_t eq_lock;
-- 
1.8.3.1

