Return-Path: <linux-rdma+bounces-21785-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bo1OIgKHIWqPIAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21785-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:09:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C423640AFB
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 16:09:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=tk73CVFV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21785-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21785-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BCFC308D2B9
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB747F2F9;
	Thu,  4 Jun 2026 13:59:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC647ECFA;
	Thu,  4 Jun 2026 13:59:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581599; cv=fail; b=VmNQSplETBDfG7Mp338IYfW41tI+2PgsAJghtNhqAZ/xCWsvB4y5KBWdr+wx/pB+loeqYATJogBx6ejGmSLNyYI/GMZWJDhI1QD0gEm2QmZCewNR2ShhRoZ5aeado/yXfS0wSsDKvsXeVILmGeulimMzWgBivZRjZPaBonFGszA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581599; c=relaxed/simple;
	bh=bZ7U1uqJ4f0wl5MHGF0I6VPfG6bxIbiFW3NubV34bpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sowkwQq0SwUyl8mqfA/nCsI4G3WtIBB7jbU9utD4coxx2itv+vK6vGqP9h3sOc8dlL9d51nFp70RNwRI7NV8EQBPRmkGLb+h/oDOEp5KjoERSlkLR8PArwuxwzqEgi48xUPEJPfWaASH11nq7BFpJGY8zqs6FW2+JDWPLFVBM/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tk73CVFV; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dR93e1VKjD7W7p21Mu/hs/mEYmDGbiTQ3VXfwrAfZCyEOPOwoE0mf3PO2WuDcOGk78BzbCgfQXFwewKMwo11t+ZMg4NfYTuaqzw/bk3JpEFV8jOEkzn/gHwZt+fmQkK5dQN+/bp0zcWNzAP2ppxpau3e00ieJIgYmqo1FTXcMmYK/pyuHW2K3s3GqBGZgcFoFI1368RjLwlmypd2sqXiWa3Z5f7BMQVt0UgTYEOlWs8raE7qs6ik0cCLY1AdvHqQxHJlAywvfpyNdi3BSji4/4ga0oy5F5NT3AIFvPxR3R1q2L34I5Sre0bvYeMq7+FjGFXc3YIbTTOIXlqZAD39qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLwRGY8/UA3NBo9huKHE+lZWQmfJgAexx4Mqx8gsWSY=;
 b=fEi1HT+yZTyn4qXUH4mFOcO/dXIwhLp2DpkNO4GL9hGxvnGOEi89XCjqT6QXTv+ZZaWQGPe/KebAzRns37jgL8IrsBi7inm25zvCAdESxOnloKBVk3YCk6kZKp18TNQTGOlLzi1qeL7iu/1SraXux5c+nuPc/SFvVgxKqAkoxPFS46S+NhjCOxe7opZ1R8Cerre16fKva1VepCQYkkaP36ZiZX/CG0/LbHkK1TM0f0CyIAJESYpBaNc2NVaKcTheV0Hswt0drhp78saXUP3Jb7AMdIK4PXO/QBlCcHnaw2gTqbOYwb2hR4xiXv/Fdr44JtQRxn5yKRo9Z4lORYbeNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLwRGY8/UA3NBo9huKHE+lZWQmfJgAexx4Mqx8gsWSY=;
 b=tk73CVFVOAmr2iGSWxW8idoDdOzFSHC4De921E45+ep/Qq820TMDI2dmvmptEnMo0yeccDhaf/pcL0uWbUIz7HijKKWSsDPQ2mocx/UuXPxohwAmPRfjR+Y4DaLX5xnxYmBIBtKtAZRJZc7grYJmy/27vr24VB2/H/UBNredY75BqVkIDcaLudAcBdYr+VGF1/54G50RJipB+fTJIxjjbf0N1YfiRHBOCb0VzCWusjAZzUW1t+YIV9QrwMvee1ErnYcZngM9gu1zYpzqERJz//fd9tk49Nuth1DMVTkZFEJ8O/HM9SJqvxpbf2HKH/V+/dpfUa5+SLONuO9bSK9jdg==
Received: from CY5PR15CA0013.namprd15.prod.outlook.com (2603:10b6:930:14::6)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 13:59:48 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:930:14:cafe::96) by CY5PR15CA0013.outlook.office365.com
 (2603:10b6:930:14::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 13:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 13:59:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 06:59:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 4 Jun 2026 06:59:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Jun 2026 06:59:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Or Gerlitz
	<ogerlitz@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net] net/mlx5: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list
Date: Thu, 4 Jun 2026 16:58:49 +0300
Message-ID: <20260604135849.458060-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a264b9-cbd3-4b6a-033f-08dec2418a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lqyg3/NYrJ1WejJ/LlDsqrdgxZ7i/sASqMLht2bqYTMXvp/9KCT6tWnHL4QdIJAL4BaflNKPPdi1dSo1iOgGtx//4zJQzThVDKv8fKwZdY5iBFHi6GPafcbf1fp/YcSVAUCMx+P6bhs3K8e8iBjADbPtCr79l9XfHTaoG2NWWOdJFJDey74/W/pVcZxRYCJppuZeoWifgUNMzFiY/i+mObHjxvQq7f150slJIOMyWFAoEEx45x3zFa9k30Qn5UIXcbWF9SHYTNtYS8Dzgs2dd0jyRhf84Xl0hf8krWB0MOGxWht5SO8VgcsHCiuCr84nsTQW708RK60kPFFFSbM7xqrlVug46KaPMDxF1MhBCAd4kyRsi4VMwD3Gv8kt0x42tKggGgFROj7xi6scDkr4p1DP5dPkBvGk9F+FMtqa9z7yWh/SbM1wWraS4KL30+Yw1JoxH0h2sx3n9aTyi0VsXmyaiPSNjXfaXYsEWBKTR093CwHa5VQNaMVzMJeic4qU4Cz6J+jidbqzNlf4zuE7PiCjM51Gg5JuQp9dxq309aAjBvXsts7/0js3eUUj8pNGyKITmi6KzWUYi0z6VCNUqhPbZEo62jL5roFumwhn8HOoc4z+QUC8SQs9R0DWrS0IcnzW1N+PTaDShfWFruAa+zBv5xpa+Q+s5VjijeVtjbgbHcC2HuP/4aiEwtQMo6eHH3uqZOh1nQtI1kBi56Ieu4uQ89WkAbV7vvrqgdE5xZw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	54eg1Y4p4r2l6/s/eY9hZG6s5rYePGMzZzCKM7mIgmnOA5b9GM1wIipl/acQ40hOsYAEgMKYVMsZQAclNv6FXTbGgSegvUP+kj324zroPNVKK86DpDSiRu/WcQzE1YBE3HFe9KsCsJ+l7wQNaAMUPzYVqsadABi5+Yubxjv0PR5bSerllPw+xWMmxIuXIn2AKXr7zV1DWnJMOx3LfR5nF3RGSO8ZM899Ni0Va4iRVNJsMvaXO8B55CqFZm2dtPcrMUpJIxKIf5mWt75aIQMN35EyDeHpgEoM+4GpTrX4ZAWV5XWWfZtG/J6QZLPkG5tq0hC7Cm8mC+SnGscDp9gu01SF+YRv9sjmwlnlHxU8cN/QkvYAcxf+KlMSzgMwD1vCntLFj7N4ZW4TcjY8ICJ4zUWD9TgGG31c1GnpMWyOi052qYz4S9UtEFVACdyQ0FOU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 13:59:47.8560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a264b9-cbd3-4b6a-033f-08dec2418a35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-21785-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:ogerlitz@mellanox.com,m:saeedm@mellanox.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:cjubran@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C423640AFB

From: Dragos Tatulea <dtatulea@nvidia.com>

mlx5_query_nic_vport_mac_list() sizes its firmware command buffer using
the PF's log_max_current_uc/mc_list capabilities. When querying a VF
vport with a larger configured max (via devlink), the firmware response
can overflow this buffer:

 BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x453/0x4c0 [mlx5_core]
 Read of size 4 at addr ff1100013ffc8a12 by task kworker/u96:2/385

 CPU: 12 UID: 0 PID: 385 Comm: kworker/u96:2 Not tainted 7.0.0-rc6+ #1 PREEMPT
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
 Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x69/0xa0
  print_report+0x176/0x4e4
  kasan_report+0xc8/0x100
  mlx5_query_nic_vport_mac_list+0x453/0x4c0 [mlx5_core]
  esw_update_vport_addr_list+0x2e3/0xda0 [mlx5_core]
  esw_vport_change_handle_locked+0xa1f/0x1060 [mlx5_core]
  esw_vport_change_handler+0x6a/0x90 [mlx5_core]
  process_one_work+0x87f/0x15e0
  worker_thread+0x62b/0x1020
  kthread+0x375/0x490
  ret_from_fork+0x4dc/0x810
  ret_from_fork_asm+0x11/0x20
  </TASK>

Fix by querying the vport's own HCA caps to size the buffer correctly.
Refactor the function to allocate and return the MAC list internally,
removing the caller's dependency on knowing the correct max.

Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 13 +---
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 72 ++++++++++++++-----
 include/linux/mlx5/vport.h                    |  4 +-
 3 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 7c8311f41232..236f89a6483a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -533,23 +533,16 @@ static void esw_update_vport_addr_list(struct mlx5_eswitch *esw,
 				       struct mlx5_vport *vport, int list_type)
 {
 	bool is_uc = list_type == MLX5_NVPRT_LIST_TYPE_UC;
-	u8 (*mac_list)[ETH_ALEN];
+	u8 (*mac_list)[ETH_ALEN] = NULL;
 	struct l2addr_node *node;
 	struct vport_addr *addr;
 	struct hlist_head *hash;
 	struct hlist_node *tmp;
-	int size;
+	int size = 0;
 	int err;
 	int hi;
 	int i;
 
-	size = is_uc ? MLX5_MAX_UC_PER_VPORT(esw->dev) :
-		       MLX5_MAX_MC_PER_VPORT(esw->dev);
-
-	mac_list = kcalloc(size, ETH_ALEN, GFP_KERNEL);
-	if (!mac_list)
-		return;
-
 	hash = is_uc ? vport->uc_list : vport->mc_list;
 
 	for_each_l2hash_node(node, tmp, hash, hi) {
@@ -561,7 +554,7 @@ static void esw_update_vport_addr_list(struct mlx5_eswitch *esw,
 		goto out;
 
 	err = mlx5_query_nic_vport_mac_list(esw->dev, vport->vport, list_type,
-					    mac_list, &size);
+					    &mac_list, &size);
 	if (err)
 		goto out;
 	esw_debug(esw->dev, "vport[%d] context update %s list size (%d)\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 4effe37fd455..d63b0e8806b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -324,35 +324,63 @@ int mlx5_modify_nic_vport_mtu(struct mlx5_core_dev *mdev, u16 mtu)
 }
 EXPORT_SYMBOL_GPL(mlx5_modify_nic_vport_mtu);
 
+static int mlx5_vport_max_mac_list_size(struct mlx5_core_dev *dev, u16 vport,
+					enum mlx5_list_type list_type)
+{
+	void *query_ctx, *hca_caps;
+	int ret = 0;
+
+	if (!vport && !mlx5_core_is_ecpf(dev))
+		return list_type == MLX5_NVPRT_LIST_TYPE_UC ?
+			1 << MLX5_CAP_GEN(dev, log_max_current_uc_list) :
+			1 << MLX5_CAP_GEN(dev, log_max_current_mc_list);
+
+	query_ctx = kzalloc(MLX5_ST_SZ_BYTES(query_hca_cap_out), GFP_KERNEL);
+	if (!query_ctx)
+		return -ENOMEM;
+
+	ret = mlx5_vport_get_other_func_general_cap(dev, vport, query_ctx);
+	if (ret)
+		goto out;
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	ret = list_type == MLX5_NVPRT_LIST_TYPE_UC ?
+		1 << MLX5_GET(cmd_hca_cap, hca_caps, log_max_current_uc_list) :
+		1 << MLX5_GET(cmd_hca_cap, hca_caps, log_max_current_mc_list);
+
+out:
+	kfree(query_ctx);
+
+	return ret;
+}
+
 int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 				  u16 vport,
 				  enum mlx5_list_type list_type,
-				  u8 addr_list[][ETH_ALEN],
-				  int *list_size)
+				  u8 (**addr_list)[ETH_ALEN],
+				  int *addr_list_size)
 {
 	u32 in[MLX5_ST_SZ_DW(query_nic_vport_context_in)] = {0};
+	int allowed_list_size;
 	void *nic_vport_ctx;
 	int max_list_size;
-	int req_list_size;
 	int out_sz;
 	void *out;
 	int err;
 	int i;
 
-	req_list_size = *list_size;
+	if (!addr_list || !addr_list_size)
+		return -EINVAL;
 
-	max_list_size = list_type == MLX5_NVPRT_LIST_TYPE_UC ?
-		1 << MLX5_CAP_GEN(dev, log_max_current_uc_list) :
-		1 << MLX5_CAP_GEN(dev, log_max_current_mc_list);
+	*addr_list = NULL;
+	*addr_list_size = 0;
 
-	if (req_list_size > max_list_size) {
-		mlx5_core_warn(dev, "Requested list size (%d) > (%d) max_list_size\n",
-			       req_list_size, max_list_size);
-		req_list_size = max_list_size;
-	}
+	max_list_size = mlx5_vport_max_mac_list_size(dev, vport, list_type);
+	if (max_list_size < 0)
+		return max_list_size;
 
 	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_out) +
-			req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
+			max_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
 
 	out = kvzalloc(out_sz, GFP_KERNEL);
 	if (!out)
@@ -371,16 +399,24 @@ int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 
 	nic_vport_ctx = MLX5_ADDR_OF(query_nic_vport_context_out, out,
 				     nic_vport_context);
-	req_list_size = MLX5_GET(nic_vport_context, nic_vport_ctx,
-				 allowed_list_size);
+	allowed_list_size = MLX5_GET(nic_vport_context, nic_vport_ctx,
+				     allowed_list_size);
+	if (!allowed_list_size)
+		goto out;
+
+	*addr_list = kcalloc(allowed_list_size, ETH_ALEN, GFP_KERNEL);
+	if (!*addr_list) {
+		err = -ENOMEM;
+		goto out;
+	}
 
-	*list_size = req_list_size;
-	for (i = 0; i < req_list_size; i++) {
+	for (i = 0; i < allowed_list_size; i++) {
 		u8 *mac_addr = MLX5_ADDR_OF(nic_vport_context,
 					nic_vport_ctx,
 					current_uc_mac_address[i]) + 2;
-		ether_addr_copy(addr_list[i], mac_addr);
+		ether_addr_copy((*addr_list)[i], mac_addr);
 	}
+	*addr_list_size = allowed_list_size;
 out:
 	kvfree(out);
 	return err;
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h
index dfa2fe32217a..282ed5442282 100644
--- a/include/linux/mlx5/vport.h
+++ b/include/linux/mlx5/vport.h
@@ -102,8 +102,8 @@ int mlx5_query_hca_vport_node_guid(struct mlx5_core_dev *dev,
 int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 				  u16 vport,
 				  enum mlx5_list_type list_type,
-				  u8 addr_list[][ETH_ALEN],
-				  int *list_size);
+				  u8 (**mac_list)[ETH_ALEN],
+				  int *mac_list_size);
 int mlx5_modify_nic_vport_mac_list(struct mlx5_core_dev *dev,
 				   enum mlx5_list_type list_type,
 				   u8 addr_list[][ETH_ALEN],

base-commit: c05fa14db43ebef3bd862ca9d073981c0358b3f0
-- 
2.44.0


