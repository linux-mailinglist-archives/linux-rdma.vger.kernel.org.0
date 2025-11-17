Return-Path: <linux-rdma+bounces-14571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8DC66528
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA73644FF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BBF34D903;
	Mon, 17 Nov 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k5gQDIEF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C534D4F6;
	Mon, 17 Nov 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415798; cv=fail; b=oiJX2IHjiwf9j7K6bWkV23fv2XHS3be1YDG/I6k4E7JOG78e/DUqdU2TVlvWteTr8wx0CK+8EvfBGpIAoOMEJltDJV9VaaPD7GAIGctK8+FykCMP5jTsc6g2Smf2mDl75QFg5o6SoKpzCJo5+aQ2mgCttX3fOtYe/Mn3H2caa0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415798; c=relaxed/simple;
	bh=mBzenU6+UmtBTZgWnPg79nrGY7MaJW76iY3OSjAcb28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riQoXELSkcAFTAEIo1N0B3jpi3aU+PO1ur28RK6yLsEdmuIW00+3ZcbcHuEQl22x3gbcaLJ8MReve/Rea50z1sxtV8lJZ/ztNxwydlEI/aMVdSUCPELgg/8IsjnKXrqNpA20ipif71sdC+ecnZ4jyyTI1IO4yS+bl6BN4dDRSuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k5gQDIEF; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHwlcLwB9lv7QwO3JIVkrikaq7Ka9uPddftVsrOCRxSc6+J0DUM1hqB3EnB4vjkCxKT6EXblvRGnagDp8hU9O6Rl6Tx6+RwwI3ZpTXWSkFM+uEXsvCQhWl1gtSn+RNFqwEUaOkEVL3ppdJ2Wx991sUlGr2d9hbOINObu4IB9m5yZxIW+SDSl7PZ3Sj/LKbojysEjFPLDv/cf+qZxyJe/p7QQVGWAY32dmhfvc77yw6xgrUQAnXVyatrJQWVzhM5Cqy0A0UCKQ9RxXvWeQQsAmaGlEIrb6oOh8VmwvoTNZL9h7jrVX4wjHwCfbEJpNFbs/O/HijKk3BxFH4oeWaiWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WvAqr7BUrrbqovFddm0f2AKGgd9UEed4IsqEoP4RZI=;
 b=lmI7eWTP48Hxjs7uPIWJhd+ARfW5+/ybVqsGYRw4a7vjch3Mnxc0XUdjQD35Kj/jZn32k+vSMz/mUoDfqwkaKOD+bTT8HYu5d8GasGihsV7ltCzoOaDsPqzzo7hMkvTW2YiJTk4qrDQSEryKg6kurekzbHLVtFWtdUHGOZ3rrlvILrqCCHrjlW2EGUhkrkYbAkeY3GI9h1AK94ej1F7eEJPdYWDilu55omu0wCKp+aVv4BkDmRNV8gDVZkBIIKrSTBgUX+gTGzEupyH3aM6li0aaODpbHwVFtleU1uqPVxbDLf53je0rxno0Nfe3WEF+P+kFFJD16HLxEmNGJj/8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WvAqr7BUrrbqovFddm0f2AKGgd9UEed4IsqEoP4RZI=;
 b=k5gQDIEFkUnzLszp3YBtA2gXFB5BVy7grcOrigohQ+3l9DPzU2nNydf2ESW1lZOlch+5M+fz2eLS1wnv1bbhYKB36VSVTb8DDabfBpDNcZ/2kUYz0znv/l8Mv0WHIjvJQB2F5uf/K//AFh4GDPFoyKW0tgFJImO1EzZgM6iWu5Y0kTfpV2ik1CsFJBWCLlscLpiuRqQkcckW0HOKBqFS9S9FSLrR/34x84CGoYFuBJMrgJ//bV1QOEc/9jrT5p1trOgdWZn7CeenDBtseEpvwNBgeMsPBmlo5qfc7hin8PuCXvBm+F7OOgqz/R2Mvm87h6g3K2UUfN3HmngNm3FgXg==
Received: from SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::6)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 21:43:12 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::86) by SJ0P220CA0030.outlook.office365.com
 (2603:10b6:a03:41b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:43:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 13:42:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5: Abort new commands if all command slots are stalled
Date: Mon, 17 Nov 2025 23:42:08 +0200
Message-ID: <1763415729-1238421-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d35d66b-a471-44a0-167d-08de26224e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYRif6fawsdSFsfhK3XK0sx7acQLbNqO/oRi6Pkm5Nt7TZruaZaZnyxQAkHJ?=
 =?us-ascii?Q?ZrfPlPH5SbbVfWkhYdyZPHFfXgAKXGmaFotPqOuTiAhekt6kSRdvx8J0cenw?=
 =?us-ascii?Q?6/DYLklPkB1WHTAawDvOo3cBabNJ2bEOLX8jmdV4CgGKKqQvjS7wyT2g/ik1?=
 =?us-ascii?Q?23xee7jLWmraSlOOUj3kbtI9CX51lMbwTNZ1wEhkvG0tw7AQiCKccz9T6WKn?=
 =?us-ascii?Q?wdJ9iulhPsFEhwKAaqat72CUNC4ptIfMRfT20ODEX7Xl371f43fmw7LBK1wd?=
 =?us-ascii?Q?2sqWmkk/ClQMV6AdrfXpi7Fk4kxIoiCpoIZIHW466hgFeSvvfytnUvme8IL1?=
 =?us-ascii?Q?0KI3QY/6UYeNGCF1F1gkyZQ0GNERjZdR2jCN+7ChbJg2t6JK8A0UvCzafFU5?=
 =?us-ascii?Q?p8RqeEJjTEjyHWEla2qNSqYd/3qiXil0qN+EJpwVrd+NYJ0W78dtnc4JoAI+?=
 =?us-ascii?Q?7FKtJ36EZAybYn/tYpOT2DKbDjkpl7MUI5HFKxd9/pUDU8nTx0lCaGksyaUZ?=
 =?us-ascii?Q?j5iiIHJ5r0r7DvM/+4YTzZpHjPUB4eZBCSQv5LfPVv5UID3506lhMNlilyhT?=
 =?us-ascii?Q?uX6rbog7xzP/A/ylfialOWs9gtsZqaQviAW8SRRR01mUru1y6F2pH5aHf4aC?=
 =?us-ascii?Q?IhMd0w/STwfnh2RHPHUoUwzJ/x2npkQYtu4D4a90V9XoYUrt5eOSkoPh0TMQ?=
 =?us-ascii?Q?g1UzcCYWuQkGuKy/QPybKGSSIwy54JvHSItp85jZ5P9ZaxhyBdPqAD84yqhb?=
 =?us-ascii?Q?g4rwnylFd0R9AjdoTUIlWaEaYf+V7cVw5h7Bxx3wrMefrTLuV1v1M/ZhSYxh?=
 =?us-ascii?Q?HJvqfbmhR5DLwzKgcxzoQMJWw4/u0fcVzu++MDqjozCLZawkbtYPLrkRFzJe?=
 =?us-ascii?Q?OJmPVyzT1xvmGLz3/oe2QyGNHs2vvyr3wX2KWe/dzLVTcpHaw8Xb+yGgPIPm?=
 =?us-ascii?Q?L9bjHo9vEn5IkvbYZGLPmbfEnbV4hgO0pGuK9MdYH5GiKQMT/RP1rJKDgomk?=
 =?us-ascii?Q?jeQyIyhTC/1odEfXzG7iQq0Sxj4fJJm0ZYDJGfSYR5hJVCMEa2GvZObTyfJS?=
 =?us-ascii?Q?pL4gn4Pih9bUXQ4kEAn51lOda5uZTHUjE6F+OYCu4UcmD2aGaBuXGTMcFyYa?=
 =?us-ascii?Q?yoIa/eVhIx4XieI3ERKJ//DPhRLxgCY1BtfiJRYQNhegSmLk3ICV0csSWgxG?=
 =?us-ascii?Q?Ps650vS6e+MbAS71J7TLO2L4pKWNySU84X7NziFRBbB/iDSTo+brmj/MYmmY?=
 =?us-ascii?Q?7K4ng6CHfMOr0m//mERMrmVNgKUkvN0Ae17Sgl79JHIjfh2nJMErJfjdEN90?=
 =?us-ascii?Q?J+gvee/VJznddIFk1CKyeWMeon1Jmpy5gEG5wjGyJgrziCI4VvhQAt4HyHhU?=
 =?us-ascii?Q?GVE6U0rUG7ka2k6KyhVw7N4pERh9eUSUE9D5AukQ02LpT/EjW31ODEfNJkMd?=
 =?us-ascii?Q?8AB70pNUTgSIs0H4ytBomU7/sC04xuRmllb1TcQ0U+gE4wLH1P9id6AgccSh?=
 =?us-ascii?Q?80epiCbfquOtfdU0KhPYKtYKFyFJ8bGxybz6WXNMyXXezcjqwc9BS1ZWUM2n?=
 =?us-ascii?Q?AQwMOoO+1disVU4hINk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:43:11.9284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d35d66b-a471-44a0-167d-08de26224e6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789

From: Saeed Mahameed <saeedm@nvidia.com>

In case of a FW issue, FW might be not responding to FW commands,
causing kernel lockout for a long period of time, e.g. rtnl_lock held
while ethtool is trying to collect stats waiting for FW to respond to
multiple commands, when all of them will timeout.

While there's no immediate indication of the FW lockout, we can safely
assume that something is wrong when all command slots are busy and in
a timeout state and no FW completion was received on any of them.

In such case, start immediately failing new commands.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 55 +++++++++++++++++++
 include/linux/mlx5/driver.h                   |  1 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 722282cebce9..5b08e5ffe0e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -181,6 +181,7 @@ static int cmd_alloc_index(struct mlx5_cmd *cmd, struct mlx5_cmd_work_ent *ent)
 static void cmd_free_index(struct mlx5_cmd *cmd, int idx)
 {
 	lockdep_assert_held(&cmd->alloc_lock);
+	cmd->ent_arr[idx] = NULL;
 	set_bit(idx, &cmd->vars.bitmask);
 }
 
@@ -1200,6 +1201,44 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 	return err;
 }
 
+/* Check if all command slots are stalled (timed out and not recovered).
+ * returns true if all slots timed out on a recent command and have not been
+ * completed by FW yet. (stalled state)
+ * false otherwise (at least one slot is not stalled).
+ *
+ * In such odd situation "all_stalled", this serves as a protection mechanism
+ * to avoid blocking the kernel for long periods of time in case FW is not
+ * responding to commands.
+ */
+static bool mlx5_cmd_all_stalled(struct mlx5_core_dev *dev)
+{
+	struct mlx5_cmd *cmd = &dev->cmd;
+	bool all_stalled = true;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&cmd->alloc_lock, flags);
+
+	/* at least one command slot is free */
+	if (bitmap_weight(&cmd->vars.bitmask, cmd->vars.max_reg_cmds) > 0) {
+		all_stalled = false;
+		goto out;
+	}
+
+	for_each_clear_bit(i, &cmd->vars.bitmask, cmd->vars.max_reg_cmds) {
+		struct mlx5_cmd_work_ent *ent = dev->cmd.ent_arr[i];
+
+		if (!test_bit(MLX5_CMD_ENT_STATE_TIMEDOUT, &ent->state)) {
+			all_stalled = false;
+			break;
+		}
+	}
+out:
+	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
+
+	return all_stalled;
+}
+
 /*  Notes:
  *    1. Callback functions may not sleep
  *    2. page queue commands do not support asynchrous completion
@@ -1230,6 +1269,15 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 	if (callback && page_queue)
 		return -EINVAL;
 
+	if (!page_queue && mlx5_cmd_all_stalled(dev)) {
+		mlx5_core_err_rl(dev,
+				 "All CMD slots are stalled, aborting command\n");
+		/* there's no reason to wait and block the whole kernel if FW
+		 * isn't currently responding to all slots, fail immediately
+		 */
+		return -EAGAIN;
+	}
+
 	ent = cmd_alloc_ent(cmd, in, out, uout, uout_size,
 			    callback, context, page_queue);
 	if (IS_ERR(ent))
@@ -1700,6 +1748,13 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 		if (test_bit(i, &vector)) {
 			ent = cmd->ent_arr[i];
 
+			if (forced && ent->ret == -ETIMEDOUT)
+				set_bit(MLX5_CMD_ENT_STATE_TIMEDOUT,
+					&ent->state);
+			else if (!forced) /* real FW completion */
+				clear_bit(MLX5_CMD_ENT_STATE_TIMEDOUT,
+					  &ent->state);
+
 			/* if we already completed the command, ignore it */
 			if (!test_and_clear_bit(MLX5_CMD_ENT_STATE_PENDING_COMP,
 						&ent->state)) {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 046396269ccf..7aec53371cf0 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -819,6 +819,7 @@ typedef void (*mlx5_cmd_cbk_t)(int status, void *context);
 
 enum {
 	MLX5_CMD_ENT_STATE_PENDING_COMP,
+	MLX5_CMD_ENT_STATE_TIMEDOUT,
 };
 
 struct mlx5_cmd_work_ent {
-- 
2.31.1


