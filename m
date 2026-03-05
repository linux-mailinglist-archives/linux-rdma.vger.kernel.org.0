Return-Path: <linux-rdma+bounces-17527-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMUpEE+WqWnYAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17527-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:42:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92238213B02
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15EAA31C0A2B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B63822BC;
	Thu,  5 Mar 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2rd9yTp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A824728F;
	Thu,  5 Mar 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720844; cv=fail; b=kmuaAjZtGgrhMRW8EkcIyhwuZwT4F+F0IPBRIhGQu7oeVuX3U9Y4wlvtTmz50RamQ8m/3T5yh6USkBg8uOlqgGvvlFS5kMPvJ/rVKGeODDGTNDzcTj39oZ/GfoxNkyOjbEMzNoNyGw5CsDo3HgsqCmCBIDMnardP9FhAtr6Wfss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720844; c=relaxed/simple;
	bh=rBrBCt4dlhazZX/9D3FzsjnCKDqXYVrpq/4moIMrhDM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmj6QnlWrWoDwWy7Hqp8f84ewAQwXF70bU5uT3O6wNiqIBW0GNP/RNLrqMh+mD+WM046FHrg33FSE0QRbP3SXQ8dDGT2OzBaKLBNOPQxVkdEko9KuyDxxyUui5/7jKSiL6z8Ul7Jyt5wd7oK/r00tyNdOEpfAyMigISo45ZNicU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2rd9yTp; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Biy8rvKgrPhdjLvEysn4BbHRI9Bvb9+1x7J0XHbKxl1VBkFGF9KjPtVoco16pIFUgZSWW99UEuvw7Hn9uvdk5WZGjNI5SToOS2Jm2dMbOMpcXVHj8ySV0Ha8U4DyZZ10Rl1+JzvHzXMMAtcUM5UIEsIb/Hru7Z14ty1MQM18ZfiudThLImf4vXQR+OosG8OyCrnzn2JinSTvJf3i89JEk+IhPoYgkoL1dbPSNQaXavPHCCSIiY0bTM2wSNPJwETlMRtSIKBDBhMirgkgx0WUxfPon4YjaKlwdB5NTiPD9L9FzE/zK3CeD+f1FTzlJLXP8xdtdlMMsx5n/nUAcV5rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5ZkACdNV6xFzBqFYQr0xfiCefbbys7nzOyGvW1j65E=;
 b=OW0CKRIWF8lZoB4tYnPKJKxquQX8dJKM4ogOV+lyX6zUa7rJMgO/XCQyDDjkitzx0/lmJZZkn+dk6WyNneQ82NdycUOHNGZ/XGV3mMXOEnacI4xXb1xcQzlIcfjwecrJcKgEthds06ULHQ3S75O4TibNNAYcDD6AiIvLE+zDKzF/kgifABDtqmQqviKELvrkfpImJrHqVa2NTQMDNr5GAJ/E0BCKvfFRafVRmeh3GVwZkWybRoztAtBw0GfwSV0TxCC4bbM44wPFErYJ6Ff2scMeJrP3553GSOtVi6vIePoGmd2NHXForSIVyZZ5MewtstwVAKnfk06TJXjNdQm8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5ZkACdNV6xFzBqFYQr0xfiCefbbys7nzOyGvW1j65E=;
 b=r2rd9yTp4MBAWdZZ0NmYuMJRfqPk/PrUOqrIvWWoYtalCLF3VFS+C9UjN3RJnkfTBWlI9OyVE7rwQ1y46nmbxBtGn4G1GJaeHPvehK3uwtOHC5CFCX7WXpeIZQAwyhgGNRBOX7dqhJqPr/wyiW1vvROLRns45CukGKPpqtupG1rDbWgUi+49gxCgsRFgtDPha00k8qSg+tcVYwpLXPdytVvOO1EselL9CyTRNlZcvFC1QgsAP7goz980rw0cW3tDyLllpCNBaUWcacX2fpG3iF+CxzKNHZl47nW2utgI+UFMksagJNHRSKY44D6GVViIiPxaiaNZelXeti1C9uXu7Q==
Received: from BN9PR03CA0502.namprd03.prod.outlook.com (2603:10b6:408:130::27)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 14:27:15 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::c0) by BN9PR03CA0502.outlook.office365.com
 (2603:10b6:408:130::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 14:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 14:27:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:27:00 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Mar 2026 06:27:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:26:54 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5: Fix crash when moving to switchdev mode
Date: Thu, 5 Mar 2026 16:26:30 +0200
Message-ID: <20260305142634.1813208-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260305142634.1813208-1-tariqt@nvidia.com>
References: <20260305142634.1813208-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: af290441-59e3-4faa-469e-08de7ac34ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014;
X-Microsoft-Antispam-Message-Info:
	s87JhMp3KflVtW0JYw8NXXMcRhF2Xw9FFTpM18GQD87IXhmEHTRBSQlXeaq+3C8MQnIr9d3wwv+XZsJprATGP2hFzCgaKCyqz43+3hiluygJLsRNoNemozZSEBKyRtVYPbMTqfu8xoEuVr44zCGqd85GdUXUSbh5p4wpDbRGeBRiTtrjbTd+164Nczw9flPx128E+LPC/bWEb64tkdv1tZ9TJHqMuSujqtUym/+oe9q4Ym+a7urf3injycz0DrPxAbwvU9CX6d99VkOTmeXIHj2esue1objd0fKlcJAW+ERfZFq1u9DnUTkGWKWGgZQE2ceBolnJ1I/nZpalT2XRSt5NW9OAeGDbXEzgKH0SPrFoS29CmNlxzHcDT+CNYpuwmhgeQdXRklcXbrJIlx4O4y/rVYnSz5kGXPuSrpeNM9dPVtLPUk31e4r2WPKsQprQ5UpiV33RcRV9vZ9JJO8Ln/xUjqqUFZ9rTwNPCcJ7SariTT3LAE/hDtKuL87wqXllNsGrIR4VNMuoTPWylKH0tgXxWG3/2lhV4Gc0/m3RmQQUUFmalHy35BtfQMFbbTy42QwKh/K4trxDS8JtJvMOmZQe9xyN7MUPfeqYWv/JC7nSnTfPFLs/xsAiHamXIU2OLbjEVy3hTSW1zs+Bb8gJPiV54+N4bjKhxMSnVIQ4Hbf6oIjKVXw/YvhjRovCIlWF4VwyGQc+1Bm3IaSfjCEkLT1CeunpoqonA/NVWR7Auv1FUwPy08SpC6FfMecgjYH3SEic5iESlYtfvDaXc9/Tng==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k0s/oiEmFTSOWr2X6gqCGQDY1bJeTW4RJ8Rkdf19+53sepxBq3C8sD2MS4Z+P7jG0H0o1EnFPUtbGOm7Al6TkQOkW8fOCfk92f6ypSElKKXSVxJxrQTs2wV1zigpHEwts0HcbNVWzfuXIfD1K3t8juYzoRr+UqkbRlXqfDZwv21+7tp90dSQfccKT5UghSqwC37hi7oeNnS0xCUQZAB+Yk6VxL98ngqmVpxl3mFZmzWNDF2Ecq0m/FWGihFENHmeanZ2IsiYEpPvHb2vvQT4/V2gzAamrjfPzIGwgN4hwRtPErZAVc3h09r0dUuM3rw4A70iSI8A20Fd0o2qny0RKwIpK5ZLiueQAYodxufJC6oaSgG+5egF1a1Gt8ygOpqcwnjPRfWqlNiTYGkVDOh9X4GdJZXugajT7kSG+Q0cOjZoL7J4f2Yt9CYo2vtIAHCf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:27:12.2937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af290441-59e3-4faa-469e-08de7ac34ac5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
X-Rspamd-Queue-Id: 92238213B02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17527-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Patrisious Haddad <phaddad@nvidia.com>

When moving to switchdev mode when the device doesn't support IPsec,
we try to clean up the IPsec resources anyway which causes the crash
below, fix that by correctly checking for IPsec support before trying
to clean up its resources.

[27642.515799] WARNING: arch/x86/mm/fault.c:1276 at
do_user_addr_fault+0x18a/0x680, CPU#4: devlink/6490
[27642.517159] Modules linked in: xt_conntrack xt_MASQUERADE
ip6table_nat ip6table_filter ip6_tables iptable_nat nf_nat xt_addrtype
rpcsec_gss_krb5 auth_rpcgss oid_registry overlay mlx5_fwctl nfnetlink
zram zsmalloc mlx5_ib fuse rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi
scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm mlx5_core
ib_core
[27642.521358] CPU: 4 UID: 0 PID: 6490 Comm: devlink Not tainted
6.19.0-rc5_for_upstream_min_debug_2026_01_14_16_47 #1 NONE
[27642.522923] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[27642.524528] RIP: 0010:do_user_addr_fault+0x18a/0x680
[27642.525362] Code: ff 0f 84 75 03 00 00 48 89 ee 4c 89 e7 e8 5e b9 22
00 49 89 c0 48 85 c0 0f 84 a8 02 00 00 f7 c3 60 80 00 00 74 22 31 c9 eb
   ae <0f> 0b 48 83 c4 10 48 89 ea 48 89 de 4c 89 f7 5b 5d 41 5c 41 5d
41
[27642.528166] RSP: 0018:ffff88810770f6b8 EFLAGS: 00010046
[27642.529038] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
ffff88810b980f00
[27642.530158] RDX: 00000000000000a0 RSI: 0000000000000002 RDI:
ffff88810770f728
[27642.531270] RBP: 00000000000000a0 R08: 0000000000000000 R09:
0000000000000000
[27642.532383] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff888103f3c4c0
[27642.533499] R13: 0000000000000000 R14: ffff88810770f728 R15:
0000000000000000
[27642.534614] FS:  00007f197c741740(0000) GS:ffff88856a94c000(0000)
knlGS:0000000000000000
[27642.535915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[27642.536858] CR2: 00000000000000a0 CR3: 000000011334c003 CR4:
0000000000172eb0
[27642.537982] Call Trace:
[27642.538466]  <TASK>
[27642.538907]  exc_page_fault+0x76/0x140
[27642.539583]  asm_exc_page_fault+0x22/0x30
[27642.540282] RIP: 0010:_raw_spin_lock_irqsave+0x10/0x30
[27642.541134] Code: 07 85 c0 75 11 ba ff 00 00 00 f0 0f b1 17 75 06 b8
01 00 00 00 c3 31 c0 c3 90 0f 1f 44 00 00 53 9c 5b fa 31 c0 ba 01 00 00
   00 <f0> 0f b1 17 75 05 48 89 d8 5b c3 89 c6 e8 7e 02 00 00 48 89 d8
      5b
[27642.543936] RSP: 0018:ffff88810770f7d8 EFLAGS: 00010046
[27642.544803] RAX: 0000000000000000 RBX: 0000000000000202 RCX:
ffff888113ad96d8
[27642.545916] RDX: 0000000000000001 RSI: ffff88810770f818 RDI:
00000000000000a0
[27642.547027] RBP: 0000000000000098 R08: 0000000000000400 R09:
ffff88810b980f00
[27642.548140] R10: 0000000000000001 R11: ffff888101845a80 R12:
00000000000000a8
[27642.549263] R13: ffffffffa02a9060 R14: 00000000000000a0 R15:
ffff8881130d8a40
[27642.550379]  complete_all+0x20/0x90
[27642.551010]  mlx5e_ipsec_disable_events+0xb6/0xf0 [mlx5_core]
[27642.552022]  mlx5e_nic_disable+0x12d/0x220 [mlx5_core]
[27642.552929]  mlx5e_detach_netdev+0x66/0xf0 [mlx5_core]
[27642.553822]  mlx5e_netdev_change_profile+0x5b/0x120 [mlx5_core]
[27642.554821]  mlx5e_vport_rep_load+0x419/0x590 [mlx5_core]
[27642.555757]  ? xa_load+0x53/0x90
[27642.556361]  __esw_offloads_load_rep+0x54/0x70 [mlx5_core]
[27642.557328]  mlx5_esw_offloads_rep_load+0x45/0xd0 [mlx5_core]
[27642.558320]  esw_offloads_enable+0xb4b/0xc90 [mlx5_core]
[27642.559247]  mlx5_eswitch_enable_locked+0x34e/0x4f0 [mlx5_core]
[27642.560257]  ? mlx5_rescan_drivers_locked+0x222/0x2d0 [mlx5_core]
[27642.561284]  mlx5_devlink_eswitch_mode_set+0x5ac/0x9c0 [mlx5_core]
[27642.562334]  ? devlink_rate_set_ops_supported+0x21/0x3a0
[27642.563220]  devlink_nl_eswitch_set_doit+0x67/0xe0
[27642.564026]  genl_family_rcv_msg_doit+0xe0/0x130
[27642.564816]  genl_rcv_msg+0x183/0x290
[27642.565466]  ? __devlink_nl_pre_doit.isra.0+0x160/0x160
[27642.566329]  ? devlink_nl_eswitch_get_doit+0x290/0x290
[27642.567181]  ? devlink_nl_pre_doit_parent_dev_optional+0x20/0x20
[27642.568147]  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
[27642.568966]  netlink_rcv_skb+0x4b/0xf0
[27642.569629]  genl_rcv+0x24/0x40
[27642.570215]  netlink_unicast+0x255/0x380
[27642.570901]  ? __alloc_skb+0xfa/0x1e0
[27642.571560]  netlink_sendmsg+0x1f3/0x420
[27642.572249]  __sock_sendmsg+0x38/0x60
[27642.572911]  __sys_sendto+0x119/0x180
[27642.573561]  ? __sys_recvmsg+0x5c/0xb0
[27642.574227]  __x64_sys_sendto+0x20/0x30
[27642.574904]  do_syscall_64+0x55/0xc10
[27642.575554]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[27642.576391] RIP: 0033:0x7f197c85e807
[27642.577050] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00
00 90 f3 0f 1e fa 80 3d 45 08 0d 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f
   05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d
      d0
[27642.579846] RSP: 002b:00007ffebd4e2248 EFLAGS: 00000202 ORIG_RAX:
000000000000002c
[27642.581082] RAX: ffffffffffffffda RBX: 000055cfcd9cd2a0 RCX:
00007f197c85e807
[27642.582200] RDX: 0000000000000038 RSI: 000055cfcd9cd490 RDI:
0000000000000003
[27642.583320] RBP: 00007ffebd4e2290 R08: 00007f197c942200 R09:
000000000000000c
[27642.584437] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000000
[27642.585555] R13: 000055cfcd9cd490 R14: 00007ffebd4e45d1 R15:
000055cfcd9cd2a0
[27642.586671]  </TASK>
[27642.587121] ---[ end trace 0000000000000000 ]---
[27642.587910] BUG: kernel NULL pointer dereference, address:
00000000000000a0

Fixes: 664f76be38a1 ("net/mlx5: Fix IPsec cleanup over MPV device")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 197a1c6930c0..329608c59313 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -2912,7 +2912,7 @@ void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
 		goto out;
 
 	peer_priv = mlx5_devcom_get_next_peer_data(priv->devcom, &tmp);
-	if (peer_priv)
+	if (peer_priv && peer_priv->ipsec)
 		complete_all(&peer_priv->ipsec->comp);
 
 	mlx5_devcom_for_each_peer_end(priv->devcom);
-- 
2.44.0


