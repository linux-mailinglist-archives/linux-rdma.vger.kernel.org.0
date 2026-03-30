Return-Path: <linux-rdma+bounces-18810-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEBGOIjSymmsAQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18810-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:44:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036A36097F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 21:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CBA8305EE94
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93D39A7EA;
	Mon, 30 Mar 2026 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAfJJaLJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973B39C657;
	Mon, 30 Mar 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899701; cv=fail; b=T6obDGKKd4v9hg/WCqsf+6uaPVNwwc5SG0rS/E192n4FIos9PX/LB6Cf5YLy/MopY4tlV3J+VqYB4IAbJv/tcJiPa4WkcJy+4Lk5Rz86TECIMQifseOpdzeI9JMtc5AmbhBOyo42xA2OcSbT7d1lpoQTLss5Z/1OLRmztAAeWt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899701; c=relaxed/simple;
	bh=3oLVVLGUTfyyl53Q/t4cBzCIcZnfl8DYPZt9ykD7yXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B71geMBfoO5FzJqRlPEBx3+fDrkRCrEDbB59gEtNUdc1nBHc56UELkFPGuPQdcGbG2UZBCc+uPblJogIYZFs0bYf/gSCEZOK0bFLJwpoP2ntNQluBXGx9W5F1J3BCA/Zozb4wE6tMq/BOpLoMPqD8co6eRtIUVUbsPd/pjX+hMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nAfJJaLJ; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHAQirv07Smk99nNDSvyxbEQuNmRtRbZB/lsqZRuangV16ecFiWNPrt7UfRQPMNe5aYmGvof3sZ1j0cVke4WwzqSO5sowiwiHrQ48Uha4d89hJgdZc9qJZGr4iEqe83iqGaLcq8r1Ah7CSAkJvXFwbT6ixDnmhHoqm7vo7zWCteW0veG1w8aH71VKLmNqfPpHcbxUC2dGqcOcFNCy7xanTBMYv3kyTvJeB8+uEFx5Fgk2ICJvbMcB0y+rWWl7YNa6/pjPBygBcJg4/rkxAm7DqU2kSavyjfOcmIkKVBc43+R23jCCLUGs4gfqLLt2+l2AhJuJNRgR6GXvD+A+VbSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM9auaHOrMZWp0CLBIt9tOkxvRY8sMgav07IBasu5Gw=;
 b=P4VRQ19Bxmg4XHbpfaR7kZy2IVIjro/v1+Be5USmJy4iSENXDyt+nrY9UGZt13jG4tl5UxGDme5GscnsmaRF12ccbndRG8nKkgbMVsEfERK3LySm7pM8AYYxdq/eUT2OH+Aq//ziwyd+tXqnFL6WMgu6OuhZLxe26T4lL8knkiV4MGDW5TwNqpBBE9xZj6xUICWP62PaYuY9qCeDxnH6KtHjaRXDd60fupsJ0Uar4/pk4iDg4Z6F5HVjQdJ2cPojyqi4O9XW0d9GFO3Svsjzj2AOC6Uzt1sM1gYSnbY0FnxVX5AW68LKjhVGrwzHqy89/bywN0CwYvBRHkRITkInXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM9auaHOrMZWp0CLBIt9tOkxvRY8sMgav07IBasu5Gw=;
 b=nAfJJaLJdOWovpdTQMW1RbCIfGl4xF7F6xy5TCs6YDF6Q8Q8R7pVU5l5aXfKsjm3K30WORKUQcZz6QopGI++/FZRJsvb9DqxO0iAGdX/XdX/G3RoyMOFjK1jumve8w2E+g72jtR9oDkj1UEYTwFljq3rXtVjf51L/JnHDb/mEzviOpofe8YXY23cuNXtnUHJ46lAD39ZDdIYsQhARyD9+/HuagguAz/nTakfLTvxyBmbD0EJ2cKVR6fZZqmcZjteteVyxRtQgFDuo9BDktUkb9t8l/1RCxFYg+RmcebKaWfppf30i6xzcrK0pRUh2sFFf6F4SidIZH6BzjuCNtxngQ==
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 19:41:31 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::b2) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 19:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 19:41:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 12:41:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 12:41:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 12:41:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Shay Agroskin <shayag@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Jianbo Liu <jianbol@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5: Fix switchdev mode rollback in case of failure
Date: Mon, 30 Mar 2026 22:40:15 +0300
Message-ID: <20260330194015.53585-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260330194015.53585-1-tariqt@nvidia.com>
References: <20260330194015.53585-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a8d3f5-3347-4f9e-53f8-08de8e9457a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xkpZC4yahJuD+S26tTIL4fsR9ZPrYkxXNTU8ZehhQ9mW1fXkErXpdSRKE4h79k9T96lVF/yk8QYIr/BVlw9qJ81iyWH4AxfRSAXP0WG4VJPtXz+gAUvYd0RXrpSOKUjyy9KNv4BwkvQsssBjINRE5ETp5kT53/4SmIbiWaTiuiSovYjLfTix2pLtiI4sy44BURtgzN5CELJr3WRcUnf+nkCQyQ0V50Qywi+Ue2INnI1I+6o+I6AEY0Qc8Rg+f/Abf+OXLQvnXWaK1Akkd+FI/bZ+vAEwOSbrYqBK2VmauKEa8L7Qi/k20a9pExf1/A/Vl+eaMQwnNPiKc+TXyLV/Z6bwqWcj3EBKnhpjaSb3JaCCYPbKbqNmOa92pAGcR5YUQVtNcUroddSboEGpW4N7L76wAiITxJmvhHOMYEDN3hUEEeKPepUkSb7eVAXm35lr3wwx0v56xIMRmIsZfrxP0NV6OiSnvANe384MoNpO+Zjlnkgvms+0ipLCb+kmS9ohplkt/nrD121Mhw53+QDKHjx5urh7GMoPdKCV8rYJiw9WJWf9sCVRElmTVRa+K5UDm2d6x1ebBIXdQuG4fPAZ0ghAdB8+8jYcPbkEwRy/7cEWOagqYZlP4HaIOtr3p2G2WlTfd06p3lQ+bPVKlLF5UZT8zpHx1E+lnab8dFiHx4x7DDgt3l0Vpy+MdvQn3qp0yMo51VrrAxmpjSXY1c7XvUVVNVqBlll5UVn4VISeF45PfhIlYHH0hG2G1dvyrQvlot+ADAP9nRQIsvUPxoJ2hw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wo9/r1vx3M3cKrNIFt+3zwQq2stpAPppbFqOPvxRvgWnybVAbst5naG4Om6vAA42UNcGTDNlNb3Lis8sG6AYFuOfNr3h+kpOlnxW4R0s+XZI5GOWFud97JdQssqrkBgj35RJwGXHIvc9Sv08+FH9LX37Khq3DkInvYX9QwDnIwX5LM+3qsLuu06FCvh1p0xX29/Y9HJPdrYPC1WKdMrlmYPypSWgKV06yjpp7gDO5VNsqkl2t7pqtu3/RTlKDez6vMo0Po8JorDSsFxTaRgQU1atpLqNTNAl2moRy16fpyldL+6UCCfutq6qZacpJHzmoqNrCeHsvZ3ar5E0yAODQJ3k+QZD31kHDue8gB2vEIPUXjlYxikuLgFgaesDYXB3ndgTSjbnFUyJ8F/pnKod/JR1pJ3uJTfNO+niipaZWiqdoY3n3353FBW4SGl0SdCa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:41:30.8470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a8d3f5-3347-4f9e-53f8-08de8e9457a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18810-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5036A36097F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saeed Mahameed <saeedm@nvidia.com>

If for some internal reason switchdev mode fails, we rollback to legacy
mode, before this patch, rollback will unregister the uplink netdev and
leave it unregistered causing the below kernel bug.

To fix this, we need to avoid netdev unregister by setting the proper
rollback flag 'MLX5_PRIV_FLAGS_SWITCH_LEGACY' to indicate legacy mode.

devlink (431) used greatest stack depth: 11048 bytes left
mlx5_core 0000:00:03.0: E-Switch: Disable: mode(LEGACY), nvfs(0), \
	necvfs(0), active vports(0)
mlx5_core 0000:00:03.0: E-Switch: Supported tc chains and prios offload
mlx5_core 0000:00:03.0: Loading uplink representor for vport 65535
mlx5_core 0000:00:03.0: mlx5_cmd_out_err:816:(pid 456): \
	QUERY_HCA_CAP(0x100) op_mod(0x0) failed, \
	status bad parameter(0x3), syndrome (0x3a3846), err(-22)
mlx5_core 0000:00:03.0 enp0s3np0 (unregistered): Unloading uplink \
	representor for vport 65535
 ------------[ cut here ]------------
kernel BUG at net/core/dev.c:12070!
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 2 UID: 0 PID: 456 Comm: devlink Not tainted 6.16.0-rc3+ \
	#9 PREEMPT(voluntary)
RIP: 0010:unregister_netdevice_many_notify+0x123/0xae0
...
Call Trace:
[   90.923094]  unregister_netdevice_queue+0xad/0xf0
[   90.923323]  unregister_netdev+0x1c/0x40
[   90.923522]  mlx5e_vport_rep_unload+0x61/0xc6
[   90.923736]  esw_offloads_enable+0x8e6/0x920
[   90.923947]  mlx5_eswitch_enable_locked+0x349/0x430
[   90.924182]  ? is_mp_supported+0x57/0xb0
[   90.924376]  mlx5_devlink_eswitch_mode_set+0x167/0x350
[   90.924628]  devlink_nl_eswitch_set_doit+0x6f/0xf0
[   90.924862]  genl_family_rcv_msg_doit+0xe8/0x140
[   90.925088]  genl_rcv_msg+0x18b/0x290
[   90.925269]  ? __pfx_devlink_nl_pre_doit+0x10/0x10
[   90.925506]  ? __pfx_devlink_nl_eswitch_set_doit+0x10/0x10
[   90.925766]  ? __pfx_devlink_nl_post_doit+0x10/0x10
[   90.926001]  ? __pfx_genl_rcv_msg+0x10/0x10
[   90.926206]  netlink_rcv_skb+0x52/0x100
[   90.926393]  genl_rcv+0x28/0x40
[   90.926557]  netlink_unicast+0x27d/0x3d0
[   90.926749]  netlink_sendmsg+0x1f7/0x430
[   90.926942]  __sys_sendto+0x213/0x220
[   90.927127]  ? __sys_recvmsg+0x6a/0xd0
[   90.927312]  __x64_sys_sendto+0x24/0x30
[   90.927504]  do_syscall_64+0x50/0x1c0
[   90.927687]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   90.927929] RIP: 0033:0x7f7d0363e047

Fixes: 2a4f56fbcc47 ("net/mlx5e: Keep netdev when leave switchdev for devlink set legacy only")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 7a9ee36b8dca..01f6aecc4fcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3761,6 +3761,8 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	return 0;
 
 err_vports:
+	/* rollback to legacy, indicates don't unregister the uplink netdev */
+	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_esw_offloads_rep_unload(esw, MLX5_VPORT_UPLINK);
 err_uplink:
 	esw_offloads_steering_cleanup(esw);
-- 
2.44.0


