Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892303CF5F7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhGTHhJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:09 -0400
Received: from mail-dm6nam08on2066.outbound.protection.outlook.com ([40.107.102.66]:6720
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234253AbhGTHhG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrbOvY39Qrfjve6gXeHz8G113EAUmDvP6DfwYD7u2ox7WJX0o87njEhO8GmAxHw+LFSDYnsgWJWYe91EwxhMLQV9tatlQNWakPecCH02RMTbB58uJ3x8w/dO1pXdg1ADrcR1bTpGGqhD2maHyh1vxn8zsvJAIEO8cJ0GoACLVvt9iHOnIee0nxVhvZkSggfW5XESW0ConF4txRAWGp4OK4cpxzZgeB839KQxw9BMwAl9sfjkO0IKnRhDH3rbSwFZZhrynowBSPk59IeDR07AeuXUlyU8yfZH3QSyBdWq46Rr4AQvdneTvPyAJwfahoUY9aPXql1RBC5RpiVcjdUOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k06CyBp1cwxUARpRjRliB4/xDrlr9xsuF68UtAT+dCk=;
 b=ArJ54US8KOmoj2cOBvR/K2M70sG9FjGrxz8yCYFgLE+hbGMge/wvPzUtoTIMwvMTSsAx11ZthOWb1JG34BT0WMDNsE52ObK88TQb82DAndSaZhtYuC+tgAA6VI6sIy3LOf0qNSTPSQdLJEnQGINn7LvknGmTN6JUTKHj38sOnvQDp/K4pok/wFjKZbYdhkorofnZZymmv43GWqeHGFSofiQtDBNScrRjZbLWn6XQzky+xhtlLFNfmfIvba7p//t7eWOm9aQD+kDrAUJbuMBx4JEVempBAk6QwQySq5OsOz7atHSGnxUL7/slmD0y83jX1tJBDkxkHYsuGwOUxH+hTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k06CyBp1cwxUARpRjRliB4/xDrlr9xsuF68UtAT+dCk=;
 b=fYrkt9x1lKofuAiRIR7rSTN37/3u+k5PdFF8OfGXxEH4vKqKryoj115ZaIXX43DbuEWqTAGgtAIQ0zeQSBUC5a11dHW6XJzwTeYPjOLPSEgNcEORCKRV8j3DC5XCznF919ab6lRO10ascsHkyqn/YveKAhcBRV0gUyVDiRJffAlz4mWgraDNA5N51LzNj7awAjwfQ3MO8mcUCyd0nN/PA/KK0pqIhjczQQIE1jZsYhIlAQ6+2JS4nElJ/INYNiSnTXdTuglhxGJjYSaCV9xO/cZIArJFO9btyipVLxDQ246u+uaBmim61VWeQF6mRLqEcQE3m3WxTeRUwIR8F09a2w==
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 08:17:43 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::68) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:43 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:43 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:41 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 07/27] mlx5: Add mlx5_vfio_cmd_exec() support
Date:   Tue, 20 Jul 2021 11:16:27 +0300
Message-ID: <20210720081647.1980-8-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57db2c7-5405-4868-0aac-08d94b56d986
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23511AE4B2E5818346A775DCC3E29@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 947ZEYFGsnG2Ach/pfRYZCl/qsCuElJ63Ys5TkHLvgqsEW75/hZxSsYnTy4ljA8eH9YjjEQYeIjI3P7wwRr8/K8S1WPwetYNpnFImQyyDKkyHD+mzbqVqWUeCCQi3wa1bfhoFEePo8lM0BQiBlykdhvsjRIBdY4MbNtQeRpejnVnfYJbylzs84IeFTPegSOw9fArV1RxYVNEVcI7Fbc9qY2QE2B8FSxrYjXxy9oXM96S0WgHIsI3pQw8fjWS3YZp9VWFY6YVCtIXv58ySVcPs0GQiB4hSIMQyh06s5uJPAqti2i9a1qhzNtvwPSd77b91baIAFH4Qv2hfKl3LknCmR0ilq5g6KqpMn+oUf+6Ytk69IvZzXX238FKDFhAbLCC0zXaZQwmfGlFbXRag/HngHYNYPJpPWulMDwY4JwhCMDL1jRdvh+LF+7JP6ivdj+0Sy9Gy9tywzlQgREaZ9qqRAbmFwMF9sDZIQ/nymYJLFwl/McAbN28+/R2cH85wTDkOXSGfW94rS6T2CmMERUkqoi/UIJUz8CZcuB8/+9sUOXFaslfy0kMFHSFzP7/UpaUwIOdBqyRnLqj76hMma5iEqhSvZ/+yWIDxIsiDA53LCy0kOmYdLRB+rX1blhCaEz32voBCu7xVxV5eYd37xBJCTFJWPTEA9A5VXkqL9T7Rk27jrLzEXE+hyT5cvkTrlx85lChKFrjM+LnctbMnWQfwA==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(5660300002)(47076005)(82310400003)(36756003)(8936002)(508600001)(86362001)(2616005)(70206006)(70586007)(316002)(336012)(83380400001)(54906003)(4326008)(2906002)(426003)(186003)(107886003)(6666004)(26005)(6916009)(7636003)(36906005)(1076003)(36860700001)(7696005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:43.6727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57db2c7-5405-4868-0aac-08d94b56d986
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add mlx5_vfio_cmd_exec() support to enable running commands.

This includes the required functionality to prepare both the in/out
command layouts and handle the response upon issuing the command.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  |  38 ++++++
 providers/mlx5/mlx5_vfio.c | 287 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 325 insertions(+)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 31d0bdc..aef6196 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -73,6 +73,25 @@ enum {
 	MLX5_CMD_OP_SYNC_STEERING = 0xb00,
 };
 
+enum {
+	MLX5_CMD_STAT_OK = 0x0,
+	MLX5_CMD_STAT_INT_ERR = 0x1,
+	MLX5_CMD_STAT_BAD_OP_ERR = 0x2,
+	MLX5_CMD_STAT_BAD_PARAM_ERR = 0x3,
+	MLX5_CMD_STAT_BAD_SYS_STATE_ERR = 0x4,
+	MLX5_CMD_STAT_BAD_RES_ERR = 0x5,
+	MLX5_CMD_STAT_RES_BUSY = 0x6,
+	MLX5_CMD_STAT_LIM_ERR = 0x8,
+	MLX5_CMD_STAT_BAD_RES_STATE_ERR = 0x9,
+	MLX5_CMD_STAT_IX_ERR = 0xa,
+	MLX5_CMD_STAT_NO_RES_ERR = 0xf,
+	MLX5_CMD_STAT_BAD_INP_LEN_ERR = 0x50,
+	MLX5_CMD_STAT_BAD_OUTP_LEN_ERR = 0x51,
+	MLX5_CMD_STAT_BAD_QP_STATE_ERR = 0x10,
+	MLX5_CMD_STAT_BAD_PKT_ERR = 0x30,
+	MLX5_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR = 0x40,
+};
+
 struct mlx5_ifc_atomic_caps_bits {
 	u8         reserved_at_0[0x40];
 
@@ -4093,4 +4112,23 @@ struct mlx5_ifc_create_psv_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_mbox_out_bits {
+	u8	status[0x8];
+	u8	reserved_at_8[0x18];
+
+	u8	syndrome[0x20];
+
+	u8	reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_mbox_in_bits {
+	u8	opcode[0x10];
+	u8	uid[0x10];
+
+	u8	reserved_at_20[0x10];
+	u8	op_mod[0x10];
+
+	u8	reserved_at_40[0x40];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 86f14f1..37f06a9 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/time.h>
 #include <errno.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -18,10 +19,12 @@
 #include <linux/vfio.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
+#include <util/mmio.h>
 
 #include "mlx5dv.h"
 #include "mlx5_vfio.h"
 #include "mlx5.h"
+#include "mlx5_ifc.h"
 
 static void mlx5_vfio_free_cmd_msg(struct mlx5_vfio_context *ctx,
 				   struct mlx5_cmd_msg *msg);
@@ -157,6 +160,290 @@ end:
 	pthread_mutex_unlock(&ctx->mem_alloc.block_list_mutex);
 }
 
+static int cmd_status_to_err(uint8_t status)
+{
+	switch (status) {
+	case MLX5_CMD_STAT_OK:				return 0;
+	case MLX5_CMD_STAT_INT_ERR:			return EIO;
+	case MLX5_CMD_STAT_BAD_OP_ERR:			return EINVAL;
+	case MLX5_CMD_STAT_BAD_PARAM_ERR:		return EINVAL;
+	case MLX5_CMD_STAT_BAD_SYS_STATE_ERR:		return EIO;
+	case MLX5_CMD_STAT_BAD_RES_ERR:			return EINVAL;
+	case MLX5_CMD_STAT_RES_BUSY:			return EBUSY;
+	case MLX5_CMD_STAT_LIM_ERR:			return ENOMEM;
+	case MLX5_CMD_STAT_BAD_RES_STATE_ERR:		return EINVAL;
+	case MLX5_CMD_STAT_IX_ERR:			return EINVAL;
+	case MLX5_CMD_STAT_NO_RES_ERR:			return EAGAIN;
+	case MLX5_CMD_STAT_BAD_INP_LEN_ERR:		return EIO;
+	case MLX5_CMD_STAT_BAD_OUTP_LEN_ERR:		return EIO;
+	case MLX5_CMD_STAT_BAD_QP_STATE_ERR:		return EINVAL;
+	case MLX5_CMD_STAT_BAD_PKT_ERR:			return EINVAL;
+	case MLX5_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR:	return EINVAL;
+	default:					return EIO;
+	}
+}
+
+static const char *cmd_status_str(uint8_t status)
+{
+	switch (status) {
+	case MLX5_CMD_STAT_OK:
+		return "OK";
+	case MLX5_CMD_STAT_INT_ERR:
+		return "internal error";
+	case MLX5_CMD_STAT_BAD_OP_ERR:
+		return "bad operation";
+	case MLX5_CMD_STAT_BAD_PARAM_ERR:
+		return "bad parameter";
+	case MLX5_CMD_STAT_BAD_SYS_STATE_ERR:
+		return "bad system state";
+	case MLX5_CMD_STAT_BAD_RES_ERR:
+		return "bad resource";
+	case MLX5_CMD_STAT_RES_BUSY:
+		return "resource busy";
+	case MLX5_CMD_STAT_LIM_ERR:
+		return "limits exceeded";
+	case MLX5_CMD_STAT_BAD_RES_STATE_ERR:
+		return "bad resource state";
+	case MLX5_CMD_STAT_IX_ERR:
+		return "bad index";
+	case MLX5_CMD_STAT_NO_RES_ERR:
+		return "no resources";
+	case MLX5_CMD_STAT_BAD_INP_LEN_ERR:
+		return "bad input length";
+	case MLX5_CMD_STAT_BAD_OUTP_LEN_ERR:
+		return "bad output length";
+	case MLX5_CMD_STAT_BAD_QP_STATE_ERR:
+		return "bad QP state";
+	case MLX5_CMD_STAT_BAD_PKT_ERR:
+		return "bad packet (discarded)";
+	case MLX5_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR:
+		return "bad size too many outstanding CQEs";
+	default:
+		return "unknown status";
+	}
+}
+
+static void mlx5_cmd_mbox_status(void *out, uint8_t *status, uint32_t *syndrome)
+{
+	*status = DEVX_GET(mbox_out, out, status);
+	*syndrome = DEVX_GET(mbox_out, out, syndrome);
+}
+
+static int mlx5_vfio_cmd_check(struct mlx5_vfio_context *ctx, void *in, void *out)
+{
+	uint32_t syndrome;
+	uint8_t  status;
+	uint16_t opcode;
+	uint16_t op_mod;
+
+	mlx5_cmd_mbox_status(out, &status, &syndrome);
+	if (!status)
+		return 0;
+
+	opcode = DEVX_GET(mbox_in, in, opcode);
+	op_mod = DEVX_GET(mbox_in, in, op_mod);
+
+	mlx5_err(ctx->dbg_fp,
+		 "mlx5_vfio_op_code(0x%x), op_mod(0x%x) failed, status %s(0x%x), syndrome (0x%x)\n",
+		 opcode, op_mod,
+		 cmd_status_str(status), status, syndrome);
+
+	errno = cmd_status_to_err(status);
+	return errno;
+}
+
+static int mlx5_copy_from_msg(void *to, struct mlx5_cmd_msg *from, int size,
+			      struct mlx5_cmd_layout *cmd_lay)
+{
+	struct mlx5_cmd_block *block;
+	struct mlx5_cmd_mailbox *next;
+	int copy;
+
+	copy = min_t(int, size, sizeof(cmd_lay->out));
+	memcpy(to, cmd_lay->out, copy);
+	size -= copy;
+	to += copy;
+
+	next = from->next;
+	while (size) {
+		if (!next) {
+			assert(false);
+			errno = ENOMEM;
+			return errno;
+		}
+
+		copy = min_t(int, size, MLX5_CMD_DATA_BLOCK_SIZE);
+		block = next->buf;
+
+		memcpy(to, block->data, copy);
+		to += copy;
+		size -= copy;
+		next = next->next;
+	}
+
+	return 0;
+}
+
+static int mlx5_copy_to_msg(struct mlx5_cmd_msg *to, void *from, int size,
+			    struct mlx5_cmd_layout *cmd_lay)
+{
+	struct mlx5_cmd_block *block;
+	struct mlx5_cmd_mailbox *next;
+	int copy;
+
+	copy = min_t(int, size, sizeof(cmd_lay->in));
+	memcpy(cmd_lay->in, from, copy);
+	size -= copy;
+	from += copy;
+
+	next = to->next;
+	while (size) {
+		if (!next) {
+			assert(false);
+			errno = ENOMEM;
+			return errno;
+		}
+
+		copy = min_t(int, size, MLX5_CMD_DATA_BLOCK_SIZE);
+		block = next->buf;
+		memcpy(block->data, from, copy);
+		from += copy;
+		size -= copy;
+		next = next->next;
+	}
+
+	return 0;
+}
+
+static int mlx5_vfio_enlarge_cmd_msg(struct mlx5_vfio_context *ctx, struct mlx5_cmd_msg *cmd_msg,
+				     struct mlx5_cmd_layout *cmd_lay, uint32_t len, bool is_in)
+{
+	int err;
+
+	mlx5_vfio_free_cmd_msg(ctx, cmd_msg);
+	err = mlx5_vfio_alloc_cmd_msg(ctx, len, cmd_msg);
+	if (err)
+		return err;
+
+	if (is_in)
+		cmd_lay->iptr = htobe64(cmd_msg->next->iova);
+	else
+		cmd_lay->optr = htobe64(cmd_msg->next->iova);
+
+	return 0;
+}
+
+/* One minute for the sake of bringup */
+#define MLX5_CMD_TIMEOUT_MSEC (60 * 1000)
+
+static int mlx5_vfio_poll_timeout(struct mlx5_cmd_layout *cmd_lay)
+{
+	static struct timeval start, curr;
+	uint64_t ms_start, ms_curr;
+
+	gettimeofday(&start, NULL);
+	ms_start = (uint64_t)start.tv_sec * 1000 + start.tv_usec / 1000;
+	do {
+		if (!(mmio_read8(&cmd_lay->status_own) & 0x1))
+			return 0;
+		pthread_yield();
+		gettimeofday(&curr, NULL);
+		ms_curr = (uint64_t)curr.tv_sec * 1000 + curr.tv_usec / 1000;
+	} while (ms_curr - ms_start < MLX5_CMD_TIMEOUT_MSEC);
+
+	errno = ETIMEDOUT;
+	return errno;
+}
+
+static int mlx5_vfio_cmd_prep_in(struct mlx5_vfio_context *ctx,
+				 struct mlx5_cmd_msg *cmd_in,
+				 struct mlx5_cmd_layout *cmd_lay,
+				 void *in, int ilen)
+{
+	int err;
+
+	if (ilen > cmd_in->len) {
+		err = mlx5_vfio_enlarge_cmd_msg(ctx, cmd_in, cmd_lay, ilen, true);
+		if (err)
+			return err;
+	}
+
+	err = mlx5_copy_to_msg(cmd_in, in, ilen, cmd_lay);
+	if (err)
+		return err;
+
+	cmd_lay->ilen = htobe32(ilen);
+	return 0;
+}
+
+static int mlx5_vfio_cmd_prep_out(struct mlx5_vfio_context *ctx,
+				  struct mlx5_cmd_msg *cmd_out,
+				  struct mlx5_cmd_layout *cmd_lay, int olen)
+{
+	struct mlx5_cmd_mailbox *tmp;
+	struct mlx5_cmd_block *block;
+
+	cmd_lay->olen = htobe32(olen);
+
+	/* zeroing output header */
+	memset(cmd_lay->out, 0, sizeof(cmd_lay->out));
+
+	if (olen > cmd_out->len)
+		/* Upon enlarge output message is zeroed */
+		return mlx5_vfio_enlarge_cmd_msg(ctx, cmd_out, cmd_lay, olen, false);
+
+	/* zeroing output message */
+	tmp = cmd_out->next;
+	olen -= min_t(int, olen, sizeof(cmd_lay->out));
+	while (olen > 0) {
+		block = tmp->buf;
+		memset(block->data, 0, MLX5_CMD_DATA_BLOCK_SIZE);
+		olen -= MLX5_CMD_DATA_BLOCK_SIZE;
+		tmp = tmp->next;
+		assert(tmp || olen <= 0);
+	}
+	return 0;
+}
+
+static int mlx5_vfio_cmd_exec(struct mlx5_vfio_context *ctx, void *in,
+			      int ilen, void *out, int olen,
+			      unsigned int slot)
+{
+	struct mlx5_init_seg *init_seg = ctx->bar_map;
+	struct mlx5_cmd_layout *cmd_lay = ctx->cmd.cmds[slot].lay;
+	struct mlx5_cmd_msg *cmd_in = &ctx->cmd.cmds[slot].in;
+	struct mlx5_cmd_msg *cmd_out = &ctx->cmd.cmds[slot].out;
+	int err;
+
+	pthread_mutex_lock(&ctx->cmd.cmds[slot].lock);
+
+	err = mlx5_vfio_cmd_prep_in(ctx, cmd_in, cmd_lay, in, ilen);
+	if (err)
+		goto end;
+
+	err = mlx5_vfio_cmd_prep_out(ctx, cmd_out, cmd_lay, olen);
+	if (err)
+		goto end;
+
+	cmd_lay->status_own = 0x1;
+
+	udma_to_device_barrier();
+	mmio_write32_be(&init_seg->cmd_dbell, htobe32(0x1 << slot));
+
+	err = mlx5_vfio_poll_timeout(cmd_lay);
+	if (err)
+		goto end;
+	udma_from_device_barrier();
+	err = mlx5_copy_from_msg(out, cmd_out, olen, cmd_lay);
+	if (err)
+		goto end;
+
+	err = mlx5_vfio_cmd_check(ctx, in, out);
+end:
+	pthread_mutex_unlock(&ctx->cmd.cmds[slot].lock);
+	return err;
+}
+
 static int mlx5_vfio_enable_pci_cmd(struct mlx5_vfio_context *ctx)
 {
 	struct vfio_region_info pci_config_reg = {};
-- 
1.8.3.1

