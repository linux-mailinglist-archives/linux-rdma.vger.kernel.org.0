Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338093CF606
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhGTHiC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:38:02 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:20704
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234585AbhGTHhT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS42svFmYdfdKV9qUS1f9nV+gfJnvNNX05Hl5BD+EbDkpmjAowkJ0bleajaxjM6m1ptAF2j2vgDt1Xn89uJHcHQ5fFM4T8I9H/IMouxfyFGr+gp1y/ceBdSRTOP8yEIRF7eucovsSYGZuWc2kxttzjXLMvXo/Q/UJPbOvD8/cBf9s0AgJd7PzKs8XTFocHrUIbcGTqzaep+xyyAGn1btOkbDSVK2inj5bg92wPKtAxIrzWGW6oXKGK9Tt6dvtcea5U4bGVVE4MUIMxJQENqj3K+QKMbgmA+dsRPyDZbBLOvcnS2HVcsJRIb8VAekW3X8QHdMSwr2E1ThISdHQrcNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpRnYxL3YlRfIGzpKHwNe9S6Uw7wwHZMH5nzKs2yR2E=;
 b=OBS/2r2G+Vu2IMSLqIZ0xHVdSEG2zJ7Xu+htD6jUhZUF6UAyHu6f9+k4FmMeRFfWFgeSXFy4oIGNfl5Tja9fitVVYejr9+ihz9tex9lhP4gqkRuw5EycQC168gyjFc8K5mXSbreefI3PcIWiSPznc7gN9UDpd/+H6qbPtbWocbaBkbrvhcCxw/MGv9smu3PNxNFvpe/5Ktme3fsao+6bxAYunDi6bV0BemKIq0GCyqEOsq2FXD/xQqMIhxXZhtbFBaIw4qV6bXAh0m/2a+jomxdK0XUBWrWcQuX0WnU7tsqscwb6C1mryZ8dT5ZasPbNnMkQcuCCZW34Qu553H1c4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpRnYxL3YlRfIGzpKHwNe9S6Uw7wwHZMH5nzKs2yR2E=;
 b=kOh7mGB/F9/HT0MO9p5rrPgqZUNlrrm145pGQ5BseHR0nEJcw6SuOER86hx7jlMMSUXxaxCRXKa5921yIXQixdhTXCW88ZzlFMseL19Uv2f8oy3bu0HpOdGiK8Mmx+ui+yKj13JHPoml8Qn4Xow9fORSt8tzH5ysewsy9zxVi8s+Yt4OEJz2sjJih4POlMMYuIMiaYW3hvfSyraQTO1d9QyuZet374tvt/LemibNtXzuIeQKtbPu+xCzt23V2tvu4avDuDMxUMpGVgZC7HsxdicaI/cOcwZ3guYIe18zwb24jZW6Y0YdA/U/EfJzvNPeXlJqVvLGWiNMlnwG5GXZGw==
Received: from BN1PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:e0::29)
 by DM6PR12MB3484.namprd12.prod.outlook.com (2603:10b6:5:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 08:17:56 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::e6) by BN1PR10CA0024.outlook.office365.com
 (2603:10b6:408:e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:56 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:55 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:53 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 12/27] mlx5: Introduce vfio APIs to process events
Date:   Tue, 20 Jul 2021 11:16:32 +0300
Message-ID: <20210720081647.1980-13-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316f1e27-0c0d-40d9-2763-08d94b56e0f9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3484333B2B07CCD00D609B73C3E29@DM6PR12MB3484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:58;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pn+g/STk6lHiMuHHnsLMN7NceneiZtAlNHB0fFWld16o81pg6UIgAtrNtSi6RUQRKgSol54/eAuAT/L5z45h0L5kfTew31F2E/NPvn+usRPzDwaatztFv9EyWrRQTKSS8Nj6mAerW7MlK3pjcNzSVEwAIYXX6EEARQ8BGnVK0eQk+izJ73jnK/lWHMNIoTsZlbfHVCZNMOx6p+ONiiyRQEG/1frPJz4wFo6AeIq9RQqKcG2GpEomQ6nNbi0MWlRP94PwXyXpN3YgA0HqrPBN6rK5NQmK4X53FClsmrl668m990fysk2QBgY1rU10m6n3/kIgQsBkjY/YtS+ZFTT713hEKlWCD9gtHdhdeQ8ercIieZABXezer0XgfNsTV4Z+PBNWmkywUCMu11oUb5hbqXi1sINcrCE1H9uOqxVR6G1F27yktG+TnAxyx4WIgyjFuKNoe4zDTnbIXsQ0LuFNKnGZBc7UVwwgsTouXbnqu+QNrhd8aa0j9dwIl39GATPEVW8wWhySSR1HBBFN9TFLKln63WqwKEjKG730RBtOTRHPpB7WfW+tP2tIjo2L6u/7ml4l91qyRtUDS3gns2qQdNIc1w13YbT46AVZiLPHR6fv6xgLByJJuxQlt1iknFY59xFaCmVR7cE0elg6qOBKZr1wbgTJdhHNzwqE/hnyAu45qy2U0dsF28bjmbHKIh+PpTZZkHVou64/7gyK8C540Q==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(70206006)(356005)(86362001)(107886003)(8936002)(36906005)(26005)(2616005)(5660300002)(316002)(4326008)(70586007)(7636003)(508600001)(47076005)(54906003)(1076003)(30864003)(36756003)(8676002)(83380400001)(6916009)(7696005)(6666004)(186003)(336012)(426003)(2906002)(19627235002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:56.1702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 316f1e27-0c0d-40d9-2763-08d94b56e0f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce vfio APIs to process events, it includes:
- mlx5dv_vfio_get_events_fd()
- mlx5dv_vfio_process_events()

The first API returns an FD number that should be used to detect whether
events exist.

The second API should be called to process the existing events.

At that step the PAGE request event support was added in addition to
support async command mode to let the mlx5dv_vfio_process_events()
return to the caller without blocking.

Detailed man pages were added to describe the expected usage of the new
APIs.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 debian/ibverbs-providers.symbols                   |   2 +
 providers/mlx5/libmlx5.map                         |   2 +
 providers/mlx5/man/CMakeLists.txt                  |   2 +
 providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md  |  41 ++++
 providers/mlx5/man/mlx5dv_vfio_process_events.3.md |  43 ++++
 providers/mlx5/mlx5_vfio.c                         | 231 ++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.h                         |  14 ++
 providers/mlx5/mlx5dv.h                            |   8 +
 8 files changed, 332 insertions(+), 11 deletions(-)
 create mode 100644 providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md
 create mode 100644 providers/mlx5/man/mlx5dv_vfio_process_events.3.md

diff --git a/debian/ibverbs-providers.symbols b/debian/ibverbs-providers.symbols
index 64e29b1..3e36592 100644
--- a/debian/ibverbs-providers.symbols
+++ b/debian/ibverbs-providers.symbols
@@ -135,6 +135,8 @@ libmlx5.so.1 ibverbs-providers #MINVER#
  mlx5dv_qp_cancel_posted_send_wrs@MLX5_1.20 36
  _mlx5dv_mkey_check@MLX5_1.20 36
  mlx5dv_get_vfio_device_list@MLX5_1.21 37
+ mlx5dv_vfio_get_events_fd@MLX5_1.21 37
+ mlx5dv_vfio_process_events@MLX5_1.21 37
 libefa.so.1 ibverbs-providers #MINVER#
 * Build-Depends-Package: libibverbs-dev
  EFA_1.0@EFA_1.0 24
diff --git a/providers/mlx5/libmlx5.map b/providers/mlx5/libmlx5.map
index 3e8a4d8..d6294d8 100644
--- a/providers/mlx5/libmlx5.map
+++ b/providers/mlx5/libmlx5.map
@@ -193,4 +193,6 @@ MLX5_1.20 {
 MLX5_1.21 {
         global:
 		mlx5dv_get_vfio_device_list;
+		mlx5dv_vfio_get_events_fd;
+		mlx5dv_vfio_process_events;
 } MLX5_1.20;
diff --git a/providers/mlx5/man/CMakeLists.txt b/providers/mlx5/man/CMakeLists.txt
index 91aebed..cb3525c 100644
--- a/providers/mlx5/man/CMakeLists.txt
+++ b/providers/mlx5/man/CMakeLists.txt
@@ -40,6 +40,8 @@ rdma_man_pages(
   mlx5dv_sched_node_create.3.md
   mlx5dv_ts_to_ns.3
   mlx5dv_wr_mkey_configure.3.md
+  mlx5dv_vfio_get_events_fd.3.md
+  mlx5dv_vfio_process_events.3.md
   mlx5dv_wr_post.3.md
   mlx5dv_wr_set_mkey_sig_block.3.md
   mlx5dv.7
diff --git a/providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md b/providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md
new file mode 100644
index 0000000..3023bb2
--- /dev/null
+++ b/providers/mlx5/man/mlx5dv_vfio_get_events_fd.3.md
@@ -0,0 +1,41 @@
+---
+layout: page
+title: mlx5dv_vfio_get_events_fd
+section: 3
+tagline: Verbs
+---
+
+# NAME
+
+mlx5dv_vfio_get_events_fd - Get the file descriptor to manage driver events.
+
+# SYNOPSIS
+
+```c
+#include <infiniband/mlx5dv.h>
+
+int mlx5dv_vfio_get_events_fd(struct ibv_context *ctx);
+```
+
+# DESCRIPTION
+
+Returns the file descriptor to be used for managing driver events.
+
+# ARGUMENTS
+
+*ctx*
+:	device context that was opened for VFIO by calling mlx5dv_get_vfio_device_list().
+
+# RETURN VALUE
+Returns the internal matching file descriptor.
+
+# NOTES
+Client code should poll the returned file descriptor and once there is some data to be managed immediately call *mlx5dv_vfio_process_events()*.
+
+# SEE ALSO
+
+*ibv_open_device(3)* *ibv_free_device_list(3)* *mlx5dv_get_vfio_device_list(3)*
+
+# AUTHOR
+
+Yishai Hadas <yishaih@nvidia.com>
diff --git a/providers/mlx5/man/mlx5dv_vfio_process_events.3.md b/providers/mlx5/man/mlx5dv_vfio_process_events.3.md
new file mode 100644
index 0000000..6c4123b
--- /dev/null
+++ b/providers/mlx5/man/mlx5dv_vfio_process_events.3.md
@@ -0,0 +1,43 @@
+---
+layout: page
+title: mlx5dv_vfio_process_events
+section: 3
+tagline: Verbs
+---
+
+# NAME
+
+mlx5dv_vfio_process_events - process vfio driver events
+
+# SYNOPSIS
+
+```c
+#include <infiniband/mlx5dv.h>
+
+int mlx5dv_vfio_process_events(struct ibv_context *ctx);
+```
+
+# DESCRIPTION
+
+This API should run from application thread and maintain device events.
+The application is responsible to get the events FD by calling *mlx5dv_vfio_get_events_fd()*
+and once the FD is pollable call the API to let driver process its internal events.
+
+# ARGUMENTS
+
+*ctx*
+:	device context that was opened for VFIO by calling mlx5dv_get_vfio_device_list().
+
+# RETURN VALUE
+Returns 0 upon success or errno value in case a failure has occurred.
+
+# NOTES
+Application can use this API also to periodically check the device health state even if no events exist.
+
+# SEE ALSO
+
+*ibv_open_device(3)* *ibv_free_device_list(3)* *mlx5dv_get_vfio_device_list(3)* *mlx5dv_vfio_get_events_fd(3)*
+
+# AUTHOR
+
+Yishai Hadas <yishaih@nvidia.com>
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index dbb9858..85ee25b 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -31,12 +31,21 @@ enum {
 	MLX5_VFIO_CMD_VEC_IDX,
 };
 
+static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx, uint16_t func_id,
+				int32_t npages, bool is_event);
+static int mlx5_vfio_reclaim_pages(struct mlx5_vfio_context *ctx, uint32_t func_id,
+				   int npages);
+
 static void mlx5_vfio_free_cmd_msg(struct mlx5_vfio_context *ctx,
 				   struct mlx5_cmd_msg *msg);
 
 static int mlx5_vfio_alloc_cmd_msg(struct mlx5_vfio_context *ctx,
 				   uint32_t size, struct mlx5_cmd_msg *msg);
 
+static int mlx5_vfio_post_cmd(struct mlx5_vfio_context *ctx, void *in,
+			      int ilen, void *out, int olen,
+			      unsigned int slot, bool async);
+
 static int mlx5_vfio_register_mem(struct mlx5_vfio_context *ctx,
 				  void *vaddr, uint64_t iova, uint64_t size)
 {
@@ -259,6 +268,22 @@ static void eq_update_ci(struct mlx5_eq *eq, uint32_t cc, int arm)
 	udma_to_device_barrier();
 }
 
+static int mlx5_vfio_handle_page_req_event(struct mlx5_vfio_context *ctx,
+					   struct mlx5_eqe *eqe)
+{
+	struct mlx5_eqe_page_req *req = &eqe->data.req_pages;
+	int32_t num_pages;
+	int16_t func_id;
+
+	func_id = be16toh(req->func_id);
+	num_pages = be32toh(req->num_pages);
+
+	if (num_pages > 0)
+		return mlx5_vfio_give_pages(ctx, func_id, num_pages, true);
+
+	return mlx5_vfio_reclaim_pages(ctx, func_id, -1 * num_pages);
+}
+
 static void mlx5_cmd_mbox_status(void *out, uint8_t *status, uint32_t *syndrome)
 {
 	*status = DEVX_GET(mbox_out, out, status);
@@ -365,6 +390,52 @@ static inline uint32_t mlx5_eq_update_cc(struct mlx5_eq *eq, uint32_t cc)
 	return cc;
 }
 
+static int mlx5_vfio_process_page_request_comp(struct mlx5_vfio_context *ctx,
+					       unsigned long slot)
+{
+	struct mlx5_vfio_cmd_slot *cmd_slot = &ctx->cmd.cmds[slot];
+	struct cmd_async_data *cmd_data = &cmd_slot->curr;
+	int num_claimed;
+	int ret, i;
+
+	ret = mlx5_copy_from_msg(cmd_data->buff_out, &cmd_slot->out,
+				 cmd_data->olen, cmd_slot->lay);
+	if (ret)
+		goto end;
+
+	ret = mlx5_vfio_cmd_check(ctx, cmd_data->buff_in, cmd_data->buff_out);
+	if (ret)
+		goto end;
+
+	if (DEVX_GET(manage_pages_in, cmd_data->buff_in, op_mod) == MLX5_PAGES_GIVE)
+		goto end;
+
+	num_claimed = DEVX_GET(manage_pages_out, cmd_data->buff_out, output_num_entries);
+	if (num_claimed > DEVX_GET(manage_pages_in, cmd_data->buff_in, input_num_entries)) {
+		ret = EINVAL;
+		errno = ret;
+		goto end;
+	}
+
+	for (i = 0; i < num_claimed; i++)
+		mlx5_vfio_free_page(ctx, DEVX_GET64(manage_pages_out, cmd_data->buff_out, pas[i]));
+
+end:
+	free(cmd_data->buff_in);
+	free(cmd_data->buff_out);
+	cmd_slot->in_use = false;
+	if (!ret && cmd_slot->is_pending) {
+		cmd_data = &cmd_slot->pending;
+
+		pthread_mutex_lock(&cmd_slot->lock);
+		cmd_slot->is_pending = false;
+		ret = mlx5_vfio_post_cmd(ctx, cmd_data->buff_in, cmd_data->ilen,
+					 cmd_data->buff_out, cmd_data->olen, slot, true);
+		pthread_mutex_unlock(&cmd_slot->lock);
+	}
+	return ret;
+}
+
 static int mlx5_vfio_cmd_comp(struct mlx5_vfio_context *ctx, unsigned long slot)
 {
 	uint64_t u = 1;
@@ -415,6 +486,9 @@ static int mlx5_vfio_process_async_events(struct mlx5_vfio_context *ctx)
 		case MLX5_EVENT_TYPE_CMD:
 			ret = mlx5_vfio_process_cmd_eqe(ctx, eqe);
 			break;
+		case MLX5_EVENT_TYPE_PAGE_REQUEST:
+			ret = mlx5_vfio_handle_page_req_event(ctx, eqe);
+			break;
 		default:
 			break;
 		}
@@ -563,9 +637,9 @@ static int mlx5_vfio_cmd_prep_out(struct mlx5_vfio_context *ctx,
 	return 0;
 }
 
-static int mlx5_vfio_cmd_exec(struct mlx5_vfio_context *ctx, void *in,
+static int mlx5_vfio_post_cmd(struct mlx5_vfio_context *ctx, void *in,
 			      int ilen, void *out, int olen,
-			      unsigned int slot)
+			      unsigned int slot, bool async)
 {
 	struct mlx5_init_seg *init_seg = ctx->bar_map;
 	struct mlx5_cmd_layout *cmd_lay = ctx->cmd.cmds[slot].lay;
@@ -573,20 +647,62 @@ static int mlx5_vfio_cmd_exec(struct mlx5_vfio_context *ctx, void *in,
 	struct mlx5_cmd_msg *cmd_out = &ctx->cmd.cmds[slot].out;
 	int err;
 
-	pthread_mutex_lock(&ctx->cmd.cmds[slot].lock);
+	/* Lock was taken by caller */
+	if (async && ctx->cmd.cmds[slot].in_use) {
+		struct cmd_async_data *pending = &ctx->cmd.cmds[slot].pending;
+
+		if (ctx->cmd.cmds[slot].is_pending) {
+			assert(false);
+			return EINVAL;
+		}
+
+		/* We might get another PAGE EVENT before previous CMD was completed.
+		 * Save the new work and once get the CMD completion go and do the job.
+		 */
+		pending->buff_in = in;
+		pending->buff_out = out;
+		pending->ilen = ilen;
+		pending->olen = olen;
+
+		ctx->cmd.cmds[slot].is_pending = true;
+		return 0;
+	}
 
 	err = mlx5_vfio_cmd_prep_in(ctx, cmd_in, cmd_lay, in, ilen);
 	if (err)
-		goto end;
+		return err;
 
 	err = mlx5_vfio_cmd_prep_out(ctx, cmd_out, cmd_lay, olen);
 	if (err)
-		goto end;
+		return err;
+
+	if (async) {
+		ctx->cmd.cmds[slot].in_use = true;
+		ctx->cmd.cmds[slot].curr.ilen = ilen;
+		ctx->cmd.cmds[slot].curr.olen = olen;
+		ctx->cmd.cmds[slot].curr.buff_in = in;
+		ctx->cmd.cmds[slot].curr.buff_out = out;
+	}
 
 	cmd_lay->status_own = 0x1;
 
 	udma_to_device_barrier();
 	mmio_write32_be(&init_seg->cmd_dbell, htobe32(0x1 << slot));
+	return 0;
+}
+
+static int mlx5_vfio_cmd_exec(struct mlx5_vfio_context *ctx, void *in,
+			       int ilen, void *out, int olen,
+			       unsigned int slot)
+{
+	struct mlx5_cmd_layout *cmd_lay = ctx->cmd.cmds[slot].lay;
+	struct mlx5_cmd_msg *cmd_out = &ctx->cmd.cmds[slot].out;
+	int err;
+
+	pthread_mutex_lock(&ctx->cmd.cmds[slot].lock);
+	err = mlx5_vfio_post_cmd(ctx, in, ilen, out, olen, slot, false);
+	if (err)
+		goto end;
 
 	if (ctx->have_eq) {
 		err = mlx5_vfio_wait_event(ctx, slot);
@@ -775,6 +891,8 @@ static int mlx5_vfio_setup_cmd_slot(struct mlx5_vfio_context *ctx, int slot)
 
 	if (slot != MLX5_MAX_COMMANDS - 1)
 		cmd_slot->comp_func = mlx5_vfio_cmd_comp;
+	else
+		cmd_slot->comp_func = mlx5_vfio_process_page_request_comp;
 
 	pthread_mutex_init(&cmd_slot->lock, NULL);
 
@@ -1329,7 +1447,8 @@ static int create_async_eqs(struct mlx5_vfio_context *ctx)
 	param = (struct mlx5_eq_param) {
 		.irq_index = MLX5_VFIO_CMD_VEC_IDX,
 		.nent = MLX5_NUM_CMD_EQE,
-		.mask[0] = 1ull << MLX5_EVENT_TYPE_CMD,
+		.mask[0] = 1ull << MLX5_EVENT_TYPE_CMD |
+			   1ull << MLX5_EVENT_TYPE_PAGE_REQUEST,
 	};
 
 	err = setup_async_eq(ctx, &param, &ctx->async_eq);
@@ -1343,6 +1462,49 @@ err:
 	return err;
 }
 
+static int mlx5_vfio_reclaim_pages(struct mlx5_vfio_context *ctx, uint32_t func_id,
+				   int npages)
+{
+	uint32_t inlen = DEVX_ST_SZ_BYTES(manage_pages_in);
+	int outlen;
+	uint32_t *out;
+	void *in;
+	int err;
+	int slot = MLX5_MAX_COMMANDS - 1;
+
+	outlen = DEVX_ST_SZ_BYTES(manage_pages_out);
+
+	outlen += npages * DEVX_FLD_SZ_BYTES(manage_pages_out, pas[0]);
+	out = calloc(1, outlen);
+	if (!out) {
+		errno = ENOMEM;
+		return errno;
+	}
+
+	in = calloc(1, inlen);
+	if (!in) {
+		err = ENOMEM;
+		errno = err;
+		goto out_free;
+	}
+
+	DEVX_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
+	DEVX_SET(manage_pages_in, in, op_mod, MLX5_PAGES_TAKE);
+	DEVX_SET(manage_pages_in, in, function_id, func_id);
+	DEVX_SET(manage_pages_in, in, input_num_entries, npages);
+
+	pthread_mutex_lock(&ctx->cmd.cmds[slot].lock);
+	err = mlx5_vfio_post_cmd(ctx, in, inlen, out, outlen, slot, true);
+	pthread_mutex_unlock(&ctx->cmd.cmds[slot].lock);
+	if (!err)
+		return 0;
+
+	free(in);
+out_free:
+	free(out);
+	return err;
+}
+
 static int mlx5_vfio_enable_hca(struct mlx5_vfio_context *ctx)
 {
 	uint32_t in[DEVX_ST_SZ_DW(enable_hca_in)] = {};
@@ -1382,10 +1544,13 @@ static int mlx5_vfio_set_issi(struct mlx5_vfio_context *ctx)
 
 static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx,
 				uint16_t func_id,
-				int32_t npages)
+				int32_t npages,
+				bool is_event)
 {
 	int32_t out[DEVX_ST_SZ_DW(manage_pages_out)] = {};
 	int inlen = DEVX_ST_SZ_BYTES(manage_pages_in);
+	int slot = MLX5_MAX_COMMANDS - 1;
+	void *outp = out;
 	int i, err;
 	int32_t *in;
 	uint64_t iova;
@@ -1397,6 +1562,15 @@ static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx,
 		return errno;
 	}
 
+	if (is_event) {
+		outp = calloc(1, sizeof(out));
+		if (!outp) {
+			errno = ENOMEM;
+			err = errno;
+			goto end;
+		}
+	}
+
 	for (i = 0; i < npages; i++) {
 		err = mlx5_vfio_alloc_page(ctx, &iova);
 		if (err)
@@ -1410,11 +1584,22 @@ static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx,
 	DEVX_SET(manage_pages_in, in, function_id, func_id);
 	DEVX_SET(manage_pages_in, in, input_num_entries, npages);
 
-	err = mlx5_vfio_cmd_exec(ctx, in, inlen, out, sizeof(out),
-				 MLX5_MAX_COMMANDS - 1);
-	if (!err)
+	if (is_event) {
+		pthread_mutex_lock(&ctx->cmd.cmds[slot].lock);
+		err = mlx5_vfio_post_cmd(ctx, in, inlen, outp, sizeof(out), slot, true);
+		pthread_mutex_unlock(&ctx->cmd.cmds[slot].lock);
+	} else {
+		err = mlx5_vfio_cmd_exec(ctx, in, inlen, outp, sizeof(out), slot);
+	}
+
+	if (!err) {
+		if (is_event)
+			return 0;
 		goto end;
+	}
 err:
+	if (is_event)
+		free(outp);
 	for (i--; i >= 0; i--)
 		mlx5_vfio_free_page(ctx, DEVX_GET64(manage_pages_in, in, pas[i]));
 end:
@@ -1454,7 +1639,7 @@ static int mlx5_vfio_satisfy_startup_pages(struct mlx5_vfio_context *ctx,
 	if (ret)
 		return ret;
 
-	return mlx5_vfio_give_pages(ctx, function_id, npages);
+	return mlx5_vfio_give_pages(ctx, function_id, npages, false);
 }
 
 static int mlx5_vfio_access_reg(struct mlx5_vfio_context *ctx, void *data_in,
@@ -2034,6 +2219,30 @@ static int mlx5_vfio_get_handle(struct mlx5_vfio_device *vfio_dev,
 	return 0;
 }
 
+int mlx5dv_vfio_get_events_fd(struct ibv_context *ibctx)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
+
+	return ctx->cmd_comp_fd;
+}
+
+int mlx5dv_vfio_process_events(struct ibv_context *ibctx)
+{
+	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
+	uint64_t u;
+	ssize_t s;
+
+	/* read to re-arm the FD and process all existing events */
+	s = read(ctx->cmd_comp_fd, &u, sizeof(uint64_t));
+	if (s < 0 && errno != EAGAIN) {
+		mlx5_err(ctx->dbg_fp, "%s, read failed, errno=%d\n",
+			 __func__, errno);
+		return errno;
+	}
+
+	return mlx5_vfio_process_async_events(ctx);
+}
+
 struct ibv_device **
 mlx5dv_get_vfio_device_list(struct mlx5dv_vfio_context_attr *attr)
 {
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 449a5c5..8e240c8 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -151,9 +151,17 @@ struct mlx5_cmd_msg {
 	struct mlx5_cmd_mailbox *next;
 };
 
+
 typedef int (*vfio_cmd_slot_comp)(struct mlx5_vfio_context *ctx,
 				  unsigned long slot);
 
+struct cmd_async_data {
+	void *buff_in;
+	int ilen;
+	void *buff_out;
+	int olen;
+};
+
 struct mlx5_vfio_cmd_slot {
 	struct mlx5_cmd_layout *lay;
 	struct mlx5_cmd_msg in;
@@ -161,6 +169,11 @@ struct mlx5_vfio_cmd_slot {
 	pthread_mutex_t lock;
 	int completion_event_fd;
 	vfio_cmd_slot_comp comp_func;
+	/* async cmd caller data */
+	bool in_use;
+	struct cmd_async_data curr;
+	bool is_pending;
+	struct cmd_async_data pending;
 };
 
 struct mlx5_vfio_cmd {
@@ -245,6 +258,7 @@ struct mlx5_vfio_context {
 		uint32_t hca_cur[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
 		uint32_t hca_max[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
 	} caps;
+
 	struct mlx5_eq async_eq;
 	struct mlx5_vfio_eqs_uar eqs_uar;
 	pthread_mutex_t eq_lock;
diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index 6aaea37..c9699ec 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -1487,6 +1487,14 @@ struct mlx5dv_vfio_context_attr {
 struct ibv_device **
 mlx5dv_get_vfio_device_list(struct mlx5dv_vfio_context_attr *attr);
 
+int mlx5dv_vfio_get_events_fd(struct ibv_context *ibctx);
+
+/* This API should run from application thread and maintain device events.
+ * The application is responsible to get the events FD by calling mlx5dv_vfio_get_events_fd
+ * and once the FD is pollable call the API to let driver process the ready events.
+ */
+int mlx5dv_vfio_process_events(struct ibv_context *context);
+
 struct ibv_context *
 mlx5dv_open_device(struct ibv_device *device, struct mlx5dv_context_attr *attr);
 
-- 
1.8.3.1

