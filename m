Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB63CF5FC
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhGTHh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:29 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:13376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233602AbhGTHhR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRWaSrnTs0v/NtqPTmsayaLc7xSw4pzhAdFpc9PAow2ETjGVv6jGpWwaVTHUBIdwcEkgb2YMlUuzFNSH6rBSpyEY5UWaSKpL6Ozg00PMOlV0/ZIaalsaWfR5D8o7s5UY6aEG4YwKIdM+2zzUNFLrqSK5v51xxzC/iVduRZw7KYXujB3V6877o3+OlxELz674JFY8SPvSCBFzYA9kq8ac1p7/hU0H9GJ+Bpq//KVYa0KclTikEOaZ7CAUPrh5U9BliNMb3jap5GHg/6WmJR4sA6POYaUkkPcZUXqCwcsHSrdXZ7BeBjKZSfIniafpntOEqGszyLlUfTfVtuvLUVFDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1EVVPwdvlDyQvYtS6BcDXPtVaRbmKc1RYb+KZRzwqc=;
 b=GxkcPUByFPO8cgR0mohDG4WZ+VzByilrvta+8dLTBtOGM3O54sCV3D9Q6l1nfVYQZ1xSJmGMb+2ZDmDXwtjJjK/Ln5tMwgNyVnR+wF/dNy5qDNZLYlfk/aZzsCzvY8amrPp7oBhHZtgQ/vRDS+lfXOdZd3k0pNdjhL7pPrvM/Xfz/rv61vKSFCDDRDFb8mUXVa8C+TJF+CLWkY936zB68mIDArdl7JY4C5emc5GsLX4i1hKL3WQyMSZiNBMqpcogvO2vtIb62O4M9NbqIozM5hozNAH95b/jR+QhifNL6kSBegkQr0LRGwrIHaOUWUQfh+E5kixjthun1gVibKaIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1EVVPwdvlDyQvYtS6BcDXPtVaRbmKc1RYb+KZRzwqc=;
 b=VIE/gJwKKlawRELi27yYX3sF49o6mu2Vq9li1u2j+8/3IkvFJAK/WQSfRA93qLcEScxhIT5QWVMWRTE50THj2yiDX7FwCv5dWKy20ZgteVMCgsnwPsQdTk1e/lp+2zWGj3SZrDAmKTwmncVF1DFFtKOmmuV61rWkofM3noef8yeEKB0Bdom/Y6sprBcXMHZTMiIaiUAIZ3gl4AeqA3ly4Afu1pd/MfmMrNqg5DPwlD5JeOATjf1ll1JtMx1qig517pwH0OdzON6inJawIDpv9OJAy/5qDf8mhSO4yszJJw5dXGAUJs+zpA0UM7qflekj9P+zHs+I65ejNtWhLPbeyA==
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by MN2PR12MB4816.namprd12.prod.outlook.com (2603:10b6:208:1b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 08:17:54 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::21) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:53 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:53 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:51 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 11/27] mlx5: Enable interrupt command mode over vfio
Date:   Tue, 20 Jul 2021 11:16:31 +0300
Message-ID: <20210720081647.1980-12-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98ebbd4d-9ba2-4c08-e774-08d94b56dfa6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4816:
X-Microsoft-Antispam-PRVS: <MN2PR12MB481695C04A1B84EE20A1980FC3E29@MN2PR12MB4816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUPakPOrq+lYLfVbAJRQyJCqiDLM3OUV+R5bDX4FKA1iuX9RNk55jCvlheVQ1SS8eaOqZsJi82g9TI6P0En/hRRDLvauyYU4NhlVeOg4W3l2vVUjoiFVBTGVkEEylD5X/olOhK70Ws30nJEHvdddwwdemKeo7JXayn5S5lyohMwSpEv2eIPFZRT/LHfXtSYGtjLSwmaDNinmn7ak6aGLn+EgxOummOZTqANKKn8mHNlhhMa7mNlgdMcCeGS8PKm2zxIqjAKf/duwMqPKY6hcDf6Qw81tHue8zSLoKKNPTCUk3TOSSrxTf1SmIjTfj2NjiHOXxvBwcwo7rFZlvcgqCB/Vio+ljcpQEqtKGbXdegrHYN08TgkywpqynUbVRYiywNY3Ivow+NRJ0rey2RiNQv7qzrzUwhWxkNXK7FxZ2fG/LKgKEYdoSW9EpyOjJcCggdPcO/bDhvxzSX0uDnYb3MKX128Cq7Xy+YvXHLf+brW9MWPvQLTUmwaiiraRdgrmBzIEGMIAORhMjDuqFwI16G4u9FbdG9g2QhnW+J+eKfeTvOGIKdKMzNNnGKI204pk19XvQejO0m2Vdpoqeuap1jHTqNtTQAzrUDdTHb+KP+Fw7I2069r3N8N/UOcUtYsLfRaxC5nuaN4Xwqr0O0yTzxhHcnjoAEspCyIxKrxcM77uMjeJeVCQEvU3bbTTx4T17t86m3Aay8ohZNqv+BQaTQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(478600001)(70586007)(426003)(5660300002)(8676002)(54906003)(82310400003)(356005)(7636003)(6666004)(36860700001)(70206006)(2616005)(26005)(86362001)(336012)(1076003)(7696005)(186003)(4326008)(316002)(36756003)(83380400001)(6916009)(36906005)(47076005)(30864003)(107886003)(8936002)(2906002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:53.9015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ebbd4d-9ba2-4c08-e774-08d94b56dfa6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4816
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enable interrupt command mode over vfio by using EQ and its related
device stuff.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  | 150 ++++++++++++++++++
 providers/mlx5/mlx5_vfio.c | 373 ++++++++++++++++++++++++++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.h |  65 ++++++++
 3 files changed, 582 insertions(+), 6 deletions(-)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 4b7a4c2..2129779 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -51,6 +51,8 @@ enum {
 	MLX5_CMD_OP_QUERY_ISSI = 0x10a,
 	MLX5_CMD_OP_SET_ISSI = 0x10b,
 	MLX5_CMD_OP_CREATE_MKEY = 0x200,
+	MLX5_CMD_OP_CREATE_EQ = 0x301,
+	MLX5_CMD_OP_DESTROY_EQ = 0x302,
 	MLX5_CMD_OP_CREATE_QP = 0x500,
 	MLX5_CMD_OP_RST2INIT_QP = 0x502,
 	MLX5_CMD_OP_INIT2RTR_QP = 0x503,
@@ -65,6 +67,8 @@ enum {
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
 	MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT = 0x755,
 	MLX5_CMD_OP_QUERY_ROCE_ADDRESS = 0x760,
+	MLX5_CMD_OP_ALLOC_UAR = 0x802,
+	MLX5_CMD_OP_DEALLOC_UAR = 0x803,
 	MLX5_CMD_OP_ACCESS_REG = 0x805,
 	MLX5_CMD_OP_QUERY_LAG = 0x842,
 	MLX5_CMD_OP_CREATE_TIR = 0x900,
@@ -118,6 +122,15 @@ enum {
 	MLX5_CAP_PORT_TYPE_ETH = 0x1,
 };
 
+enum mlx5_event {
+	MLX5_EVENT_TYPE_CMD = 0x0a,
+	MLX5_EVENT_TYPE_PAGE_REQUEST = 0xb,
+};
+
+enum {
+	MLX5_EQ_DOORBEL_OFFSET = 0x40,
+};
+
 struct mlx5_ifc_atomic_caps_bits {
 	u8         reserved_at_0[0x40];
 
@@ -4434,4 +4447,141 @@ struct mlx5_ifc_set_hca_cap_in_bits {
 	union mlx5_ifc_hca_cap_union_bits capability;
 };
 
+struct mlx5_ifc_alloc_uar_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x8];
+	u8         uar[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_alloc_uar_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_dealloc_uar_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_dealloc_uar_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x8];
+	u8         uar[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_eqc_bits {
+	u8         status[0x4];
+	u8         reserved_at_4[0x9];
+	u8         ec[0x1];
+	u8         oi[0x1];
+	u8         reserved_at_f[0x5];
+	u8         st[0x4];
+	u8         reserved_at_18[0x8];
+
+	u8         reserved_at_20[0x20];
+
+	u8         reserved_at_40[0x14];
+	u8         page_offset[0x6];
+	u8         reserved_at_5a[0x6];
+
+	u8         reserved_at_60[0x3];
+	u8         log_eq_size[0x5];
+	u8         uar_page[0x18];
+
+	u8         reserved_at_80[0x20];
+
+	u8         reserved_at_a0[0x18];
+	u8         intr[0x8];
+
+	u8         reserved_at_c0[0x3];
+	u8         log_page_size[0x5];
+	u8         reserved_at_c8[0x18];
+
+	u8         reserved_at_e0[0x60];
+
+	u8         reserved_at_140[0x8];
+	u8         consumer_counter[0x18];
+
+	u8         reserved_at_160[0x8];
+	u8         producer_counter[0x18];
+
+	u8         reserved_at_180[0x80];
+};
+
+struct mlx5_ifc_create_eq_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x18];
+	u8         eq_number[0x8];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_eq_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+
+	struct mlx5_ifc_eqc_bits eq_context_entry;
+
+	u8         reserved_at_280[0x40];
+
+	u8         event_bitmask[4][0x40];
+
+	u8         reserved_at_3c0[0x4c0];
+
+	u8         pas[][0x40];
+};
+
+struct mlx5_ifc_destroy_eq_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_destroy_eq_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x18];
+	u8         eq_number[0x8];
+
+	u8         reserved_at_60[0x20];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 97d3ce6..dbb9858 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -19,6 +19,7 @@
 #include <linux/vfio.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
+#include <poll.h>
 #include <util/mmio.h>
 
 #include "mlx5dv.h"
@@ -26,6 +27,10 @@
 #include "mlx5.h"
 #include "mlx5_ifc.h"
 
+enum {
+	MLX5_VFIO_CMD_VEC_IDX,
+};
+
 static void mlx5_vfio_free_cmd_msg(struct mlx5_vfio_context *ctx,
 				   struct mlx5_cmd_msg *msg);
 
@@ -223,6 +228,37 @@ static const char *cmd_status_str(uint8_t status)
 	}
 }
 
+static struct mlx5_eqe *get_eqe(struct mlx5_eq *eq, uint32_t entry)
+{
+	return eq->vaddr + entry * MLX5_EQE_SIZE;
+}
+
+static struct mlx5_eqe *mlx5_eq_get_eqe(struct mlx5_eq *eq, uint32_t cc)
+{
+	uint32_t ci = eq->cons_index + cc;
+	struct mlx5_eqe *eqe;
+
+	eqe = get_eqe(eq, ci & (eq->nent - 1));
+	eqe = ((eqe->owner & 1) ^ !!(ci & eq->nent)) ? NULL : eqe;
+
+	if (eqe)
+		udma_from_device_barrier();
+
+	return eqe;
+}
+
+static void eq_update_ci(struct mlx5_eq *eq, uint32_t cc, int arm)
+{
+	__be32 *addr = eq->doorbell + (arm ? 0 : 2);
+	uint32_t val;
+
+	eq->cons_index += cc;
+	val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
+
+	mmio_write32_be(addr, htobe32(val));
+	udma_to_device_barrier();
+}
+
 static void mlx5_cmd_mbox_status(void *out, uint8_t *status, uint32_t *syndrome)
 {
 	*status = DEVX_GET(mbox_out, out, status);
@@ -315,6 +351,85 @@ static int mlx5_copy_to_msg(struct mlx5_cmd_msg *to, void *from, int size,
 	return 0;
 }
 
+/* The HCA will think the queue has overflowed if we don't tell it we've been
+ * processing events.
+ * We create EQs with MLX5_NUM_SPARE_EQE extra entries,
+ * so we must update our consumer index at least that often.
+ */
+static inline uint32_t mlx5_eq_update_cc(struct mlx5_eq *eq, uint32_t cc)
+{
+	if (unlikely(cc >= MLX5_NUM_SPARE_EQE)) {
+		eq_update_ci(eq, cc, 0);
+		cc = 0;
+	}
+	return cc;
+}
+
+static int mlx5_vfio_cmd_comp(struct mlx5_vfio_context *ctx, unsigned long slot)
+{
+	uint64_t u = 1;
+	ssize_t s;
+
+	s = write(ctx->cmd.cmds[slot].completion_event_fd, &u,
+		  sizeof(uint64_t));
+	if (s != sizeof(uint64_t))
+		return -1;
+
+	return 0;
+}
+
+static int mlx5_vfio_process_cmd_eqe(struct mlx5_vfio_context *ctx,
+				     struct mlx5_eqe *eqe)
+{
+	struct mlx5_eqe_cmd *cmd_eqe = &eqe->data.cmd;
+	unsigned long vector = be32toh(cmd_eqe->vector);
+	unsigned long slot;
+	int count = 0;
+	int ret;
+
+	for (slot = 0; slot < MLX5_MAX_COMMANDS; slot++) {
+		if (vector & (1 << slot)) {
+			assert(ctx->cmd.cmds[slot].comp_func);
+			ret = ctx->cmd.cmds[slot].comp_func(ctx, slot);
+			if (ret)
+				return ret;
+
+			vector &= ~(1 << slot);
+			count++;
+		}
+	}
+
+	assert(!vector && count);
+	return 0;
+}
+
+static int mlx5_vfio_process_async_events(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_eqe *eqe;
+	int ret = 0;
+	int cc = 0;
+
+	pthread_mutex_lock(&ctx->eq_lock);
+	while ((eqe = mlx5_eq_get_eqe(&ctx->async_eq, cc))) {
+		switch (eqe->type) {
+		case MLX5_EVENT_TYPE_CMD:
+			ret = mlx5_vfio_process_cmd_eqe(ctx, eqe);
+			break;
+		default:
+			break;
+		}
+
+		cc = mlx5_eq_update_cc(&ctx->async_eq, ++cc);
+		if (ret)
+			goto out;
+	}
+
+out:
+	eq_update_ci(&ctx->async_eq, cc, 1);
+	pthread_mutex_unlock(&ctx->eq_lock);
+	return ret;
+}
+
 static int mlx5_vfio_enlarge_cmd_msg(struct mlx5_vfio_context *ctx, struct mlx5_cmd_msg *cmd_msg,
 				     struct mlx5_cmd_layout *cmd_lay, uint32_t len, bool is_in)
 {
@@ -333,6 +448,49 @@ static int mlx5_vfio_enlarge_cmd_msg(struct mlx5_vfio_context *ctx, struct mlx5_
 	return 0;
 }
 
+static int mlx5_vfio_wait_event(struct mlx5_vfio_context *ctx,
+				unsigned int slot)
+{
+	struct mlx5_cmd_layout *cmd_lay = ctx->cmd.cmds[slot].lay;
+	uint64_t u;
+	ssize_t s;
+	int err;
+
+	struct pollfd fds[2] = {
+		{ .fd = ctx->cmd_comp_fd, .events = POLLIN },
+		{ .fd = ctx->cmd.cmds[slot].completion_event_fd, .events = POLLIN }
+		};
+
+	while (true) {
+		err = poll(fds, 2, -1);
+		if (err < 0 && errno != EAGAIN) {
+			mlx5_err(ctx->dbg_fp, "mlx5_vfio_wait_event, poll failed, errno=%d\n", errno);
+			return errno;
+		}
+		if (fds[0].revents & POLLIN) {
+			s = read(fds[0].fd, &u, sizeof(uint64_t));
+			if (s < 0 && errno != EAGAIN) {
+				mlx5_err(ctx->dbg_fp, "mlx5_vfio_wait_event, read failed, errno=%d\n", errno);
+				return errno;
+			}
+
+			err = mlx5_vfio_process_async_events(ctx);
+			if (err)
+				return err;
+		}
+		if (fds[1].revents & POLLIN) {
+			s = read(fds[1].fd, &u, sizeof(uint64_t));
+			if (s < 0 && errno != EAGAIN) {
+				mlx5_err(ctx->dbg_fp, "mlx5_vfio_wait_event, read failed, slot=%d, errno=%d\n",
+					 slot, errno);
+				return errno;
+			}
+			if (!(mmio_read8(&cmd_lay->status_own) & 0x1))
+				return 0;
+		}
+	}
+}
+
 /* One minute for the sake of bringup */
 #define MLX5_CMD_TIMEOUT_MSEC (60 * 1000)
 
@@ -430,10 +588,17 @@ static int mlx5_vfio_cmd_exec(struct mlx5_vfio_context *ctx, void *in,
 	udma_to_device_barrier();
 	mmio_write32_be(&init_seg->cmd_dbell, htobe32(0x1 << slot));
 
-	err = mlx5_vfio_poll_timeout(cmd_lay);
-	if (err)
-		goto end;
-	udma_from_device_barrier();
+	if (ctx->have_eq) {
+		err = mlx5_vfio_wait_event(ctx, slot);
+		if (err)
+			goto end;
+	} else {
+		err = mlx5_vfio_poll_timeout(cmd_lay);
+		if (err)
+			goto end;
+		udma_from_device_barrier();
+	}
+
 	err = mlx5_copy_from_msg(out, cmd_out, olen, cmd_lay);
 	if (err)
 		goto end;
@@ -608,6 +773,9 @@ static int mlx5_vfio_setup_cmd_slot(struct mlx5_vfio_context *ctx, int slot)
 		goto err_fd;
 	}
 
+	if (slot != MLX5_MAX_COMMANDS - 1)
+		cmd_slot->comp_func = mlx5_vfio_cmd_comp;
+
 	pthread_mutex_init(&cmd_slot->lock, NULL);
 
 	return 0;
@@ -889,7 +1057,7 @@ mlx5_vfio_enable_msix(struct mlx5_vfio_context *ctx)
 	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
 	irq_set->start = 0;
 	fd_ptr = (int *)&irq_set->data;
-	fd_ptr[0] = ctx->cmd_comp_fd;
+	fd_ptr[MLX5_VFIO_CMD_VEC_IDX] = ctx->cmd_comp_fd;
 
 	return ioctl(ctx->device_fd, VFIO_DEVICE_SET_IRQS, irq_set);
 }
@@ -907,7 +1075,7 @@ static int mlx5_vfio_init_async_fd(struct mlx5_vfio_context *ctx)
 		return -1;
 
 	/* set up an eventfd for command completion interrupts */
-	ctx->cmd_comp_fd = eventfd(0, EFD_CLOEXEC);
+	ctx->cmd_comp_fd = eventfd(0, EFD_CLOEXEC | O_NONBLOCK);
 	if (ctx->cmd_comp_fd < 0)
 		return -1;
 
@@ -988,6 +1156,193 @@ close_cont:
 	return -1;
 }
 
+enum {
+	MLX5_EQE_OWNER_INIT_VAL = 0x1,
+};
+
+static void init_eq_buf(struct mlx5_eq *eq)
+{
+	struct mlx5_eqe *eqe;
+	int i;
+
+	for (i = 0; i < eq->nent; i++) {
+		eqe = get_eqe(eq, i);
+		eqe->owner = MLX5_EQE_OWNER_INIT_VAL;
+	}
+}
+
+static uint64_t uar2iova(struct mlx5_vfio_context *ctx, uint32_t index)
+{
+	return (uint64_t)((void *)ctx->bar_map + (index * MLX5_ADAPTER_PAGE_SIZE));
+}
+
+static int mlx5_vfio_alloc_uar(struct mlx5_vfio_context *ctx, uint32_t *uarn)
+{
+	uint32_t out[DEVX_ST_SZ_DW(alloc_uar_out)] = {};
+	uint32_t in[DEVX_ST_SZ_DW(alloc_uar_in)] = {};
+	int err;
+
+	DEVX_SET(alloc_uar_in, in, opcode, MLX5_CMD_OP_ALLOC_UAR);
+	err = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+	if (!err)
+		*uarn = DEVX_GET(alloc_uar_out, out, uar);
+
+	return err;
+}
+
+static void mlx5_vfio_dealloc_uar(struct mlx5_vfio_context *ctx, uint32_t uarn)
+{
+	uint32_t out[DEVX_ST_SZ_DW(dealloc_uar_out)] = {};
+	uint32_t in[DEVX_ST_SZ_DW(dealloc_uar_in)] = {};
+
+	DEVX_SET(dealloc_uar_in, in, opcode, MLX5_CMD_OP_DEALLOC_UAR);
+	DEVX_SET(dealloc_uar_in, in, uar, uarn);
+	mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+}
+
+static void mlx5_vfio_destroy_eq(struct mlx5_vfio_context *ctx, struct mlx5_eq *eq)
+{
+	uint32_t in[DEVX_ST_SZ_DW(destroy_eq_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(destroy_eq_out)] = {};
+
+	DEVX_SET(destroy_eq_in, in, opcode, MLX5_CMD_OP_DESTROY_EQ);
+	DEVX_SET(destroy_eq_in, in, eq_number, eq->eqn);
+
+	mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+	mlx5_vfio_unregister_mem(ctx, eq->iova, eq->iova_size);
+	iset_insert_range(ctx->iova_alloc, eq->iova, eq->iova_size);
+	free(eq->vaddr);
+}
+
+static void destroy_async_eqs(struct mlx5_vfio_context *ctx)
+{
+	ctx->have_eq = false;
+	mlx5_vfio_destroy_eq(ctx, &ctx->async_eq);
+	mlx5_vfio_dealloc_uar(ctx, ctx->eqs_uar.uarn);
+}
+
+static int
+create_map_eq(struct mlx5_vfio_context *ctx, struct mlx5_eq *eq,
+	      struct mlx5_eq_param *param)
+{
+	uint32_t out[DEVX_ST_SZ_DW(create_eq_out)] = {};
+	uint8_t vecidx = param->irq_index;
+	__be64 *pas;
+	void *eqc;
+	int inlen;
+	uint32_t *in;
+	int err;
+	int i;
+	int alloc_size;
+
+	pthread_mutex_init(&ctx->eq_lock, NULL);
+	eq->nent = roundup_pow_of_two(param->nent + MLX5_NUM_SPARE_EQE);
+	eq->cons_index = 0;
+	alloc_size = eq->nent * MLX5_EQE_SIZE;
+	eq->iova_size = max(roundup_pow_of_two(alloc_size), ctx->iova_min_page_size);
+
+	inlen = DEVX_ST_SZ_BYTES(create_eq_in) +
+		DEVX_FLD_SZ_BYTES(create_eq_in, pas[0]) * 1;
+
+	in = calloc(1, inlen);
+	if (!in)
+		return ENOMEM;
+
+	pas = (__be64 *)DEVX_ADDR_OF(create_eq_in, in, pas);
+
+	err = posix_memalign(&eq->vaddr, eq->iova_size, alloc_size);
+	if (err) {
+		errno = err;
+		goto end;
+	}
+
+	err = iset_alloc_range(ctx->iova_alloc, eq->iova_size, &eq->iova);
+	if (err)
+		goto err_range;
+
+	err = mlx5_vfio_register_mem(ctx, eq->vaddr, eq->iova, eq->iova_size);
+	if (err)
+		goto err_reg;
+
+	pas[0] = htobe64(eq->iova);
+	init_eq_buf(eq);
+	DEVX_SET(create_eq_in, in, opcode, MLX5_CMD_OP_CREATE_EQ);
+
+	for (i = 0; i < 4; i++)
+		DEVX_ARRAY_SET64(create_eq_in, in, event_bitmask, i,
+				 param->mask[i]);
+
+	eqc = DEVX_ADDR_OF(create_eq_in, in, eq_context_entry);
+	DEVX_SET(eqc, eqc, log_eq_size, ilog32(eq->nent - 1));
+	DEVX_SET(eqc, eqc, uar_page, ctx->eqs_uar.uarn);
+	DEVX_SET(eqc, eqc, intr, vecidx);
+	DEVX_SET(eqc, eqc, log_page_size, ilog32(eq->iova_size - 1) - MLX5_ADAPTER_PAGE_SHIFT);
+
+	err = mlx5_vfio_cmd_exec(ctx, in, inlen, out, sizeof(out), 0);
+	if (err)
+		goto err_cmd;
+
+	eq->vecidx = vecidx;
+	eq->eqn = DEVX_GET(create_eq_out, out, eq_number);
+	eq->doorbell = (void *)ctx->eqs_uar.iova + MLX5_EQ_DOORBEL_OFFSET;
+
+	free(in);
+	return 0;
+
+err_cmd:
+	mlx5_vfio_unregister_mem(ctx, eq->iova, eq->iova_size);
+err_reg:
+	iset_insert_range(ctx->iova_alloc, eq->iova, eq->iova_size);
+err_range:
+	free(eq->vaddr);
+end:
+	free(in);
+	return err;
+}
+
+static int
+setup_async_eq(struct mlx5_vfio_context *ctx, struct mlx5_eq_param *param,
+	       struct mlx5_eq *eq)
+{
+	int err;
+
+	err = create_map_eq(ctx, eq, param);
+	if (err)
+		return err;
+
+	eq_update_ci(eq, 0, 1);
+
+	return 0;
+}
+
+static int create_async_eqs(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_eq_param param = {};
+	int err;
+
+	err = mlx5_vfio_alloc_uar(ctx, &ctx->eqs_uar.uarn);
+	if (err)
+		return err;
+
+	ctx->eqs_uar.iova = uar2iova(ctx, ctx->eqs_uar.uarn);
+
+	param = (struct mlx5_eq_param) {
+		.irq_index = MLX5_VFIO_CMD_VEC_IDX,
+		.nent = MLX5_NUM_CMD_EQE,
+		.mask[0] = 1ull << MLX5_EVENT_TYPE_CMD,
+	};
+
+	err = setup_async_eq(ctx, &param, &ctx->async_eq);
+	if (err)
+		goto err;
+
+	ctx->have_eq = true;
+	return 0;
+err:
+	mlx5_vfio_dealloc_uar(ctx, ctx->eqs_uar.uarn);
+	return err;
+}
+
 static int mlx5_vfio_enable_hca(struct mlx5_vfio_context *ctx)
 {
 	uint32_t in[DEVX_ST_SZ_DW(enable_hca_in)] = {};
@@ -1497,6 +1852,7 @@ static void mlx5_vfio_free_context(struct ibv_context *ibctx)
 {
 	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
 
+	destroy_async_eqs(ctx);
 	mlx5_vfio_teardown_hca(ctx);
 	mlx5_vfio_clean_cmd_interface(ctx);
 	mlx5_vfio_clean_device_dma(ctx);
@@ -1541,9 +1897,14 @@ mlx5_vfio_alloc_context(struct ibv_device *ibdev,
 	if (mlx5_vfio_setup_function(mctx))
 		goto clean_cmd;
 
+	if (create_async_eqs(mctx))
+		goto func_teardown;
+
 	verbs_set_ops(&mctx->vctx, &mlx5_vfio_common_ops);
 	return &mctx->vctx;
 
+func_teardown:
+	mlx5_vfio_teardown_hca(mctx);
 clean_cmd:
 	mlx5_vfio_clean_cmd_interface(mctx);
 err_dma:
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 225c1b9..449a5c5 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -60,6 +60,8 @@ struct mlx5_vfio_device {
 #define MLX5_VFIO_CAP_ROCE_MAX(ctx, cap) \
 	DEVX_GET(roce_cap, ctx->caps.hca_max[MLX5_CAP_ROCE], cap)
 
+struct mlx5_vfio_context;
+
 struct mlx5_reg_host_endianness {
 	uint8_t he;
 	uint8_t rsvd[15];
@@ -149,12 +151,16 @@ struct mlx5_cmd_msg {
 	struct mlx5_cmd_mailbox *next;
 };
 
+typedef int (*vfio_cmd_slot_comp)(struct mlx5_vfio_context *ctx,
+				  unsigned long slot);
+
 struct mlx5_vfio_cmd_slot {
 	struct mlx5_cmd_layout *lay;
 	struct mlx5_cmd_msg in;
 	struct mlx5_cmd_msg out;
 	pthread_mutex_t lock;
 	int completion_event_fd;
+	vfio_cmd_slot_comp comp_func;
 };
 
 struct mlx5_vfio_cmd {
@@ -165,6 +171,62 @@ struct mlx5_vfio_cmd {
 	struct mlx5_vfio_cmd_slot cmds[MLX5_MAX_COMMANDS];
 };
 
+struct mlx5_eq_param {
+	uint8_t irq_index;
+	int nent;
+	uint64_t mask[4];
+};
+
+struct mlx5_eq {
+	__be32 *doorbell;
+	uint32_t cons_index;
+	unsigned int vecidx;
+	uint8_t eqn;
+	int nent;
+	void *vaddr;
+	uint64_t iova;
+	uint64_t iova_size;
+};
+
+struct mlx5_eqe_cmd {
+	__be32 vector;
+	__be32 rsvd[6];
+};
+
+struct mlx5_eqe_page_req {
+	__be16 ec_function;
+	__be16 func_id;
+	__be32 num_pages;
+	__be32 rsvd1[5];
+};
+
+union ev_data {
+	__be32 raw[7];
+	struct mlx5_eqe_cmd cmd;
+	struct mlx5_eqe_page_req req_pages;
+};
+
+struct mlx5_eqe {
+	uint8_t rsvd0;
+	uint8_t type;
+	uint8_t rsvd1;
+	uint8_t sub_type;
+	__be32 rsvd2[7];
+	union ev_data data;
+	__be16 rsvd3;
+	uint8_t signature;
+	uint8_t owner;
+};
+
+#define MLX5_EQE_SIZE (sizeof(struct mlx5_eqe))
+#define MLX5_NUM_CMD_EQE   (32)
+#define MLX5_NUM_SPARE_EQE (0x80)
+
+struct mlx5_vfio_eqs_uar {
+	uint32_t uarn;
+	uint64_t iova;
+};
+
 struct mlx5_vfio_context {
 	struct verbs_context vctx;
 	int container_fd;
@@ -183,6 +245,9 @@ struct mlx5_vfio_context {
 		uint32_t hca_cur[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
 		uint32_t hca_max[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
 	} caps;
+	struct mlx5_eq async_eq;
+	struct mlx5_vfio_eqs_uar eqs_uar;
+	pthread_mutex_t eq_lock;
 };
 
 static inline struct mlx5_vfio_device *to_mvfio_dev(struct ibv_device *ibdev)
-- 
1.8.3.1

