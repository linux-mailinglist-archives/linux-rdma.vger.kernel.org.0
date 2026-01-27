Return-Path: <linux-rdma+bounces-16054-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJJhGlN9eGkFqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16054-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:54:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0DF91544
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 347D13011681
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD62FBDFF;
	Tue, 27 Jan 2026 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXIDMLPJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010020.outbound.protection.outlook.com [40.93.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DB328B75;
	Tue, 27 Jan 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504047; cv=fail; b=HsPRUeR6Njhfvc19lsUGdk691eKSuoqq/kSbFo9GIl+RhMc4V5aIpW8VyUCzUkQrJYrMVO/xyR30MhMVf5IeONK3iSLD3dbfdaOaEygdAE7D4vrGk+WYfSrr904tYG4Gh5CyYw+txLfe5158pgAl9tcaLnx4cwItHVmXPX8JU/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504047; c=relaxed/simple;
	bh=r60zWTWNOZ03g63uwYUkpmnru7A//xnbfK39zF/OAHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bInQDCEZM6x13uXy3L7RKInAstx8CNgeGE9y87G9/4Y7O4qY3W7rRdipbnjy+N9E5s8FfA+xQHWhwPLixs2eVV43HgdlRtbavBuTDNl3MI26Pzu3Zib3Md1GuG3Mxof8Tz8PWx98KyYytxlHsRl13kxgpFB4H5nGgMRtU5+arOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXIDMLPJ; arc=fail smtp.client-ip=40.93.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jexngFItvVl+0YB64urmDRuWqrlSyd5jxGyuyQu+inab1lLl0WUkI5OWJw4BLNlbzgDPU+f4wg2IY51vkm6a04EBs7cKcKjf1lIBdLaGjez9zevENvuOuqBXYvvIuT+EeG+MhrD+jpXqVqN7KecQ4cXcROtVo40p6rkKXi7MrFQxrwuL16wpXcHY0pTdv6qsZIBjQkXyN57IQ/XAIds5SAIGcbEi/8+yeAtHWQUM4NQo/AscQX0V32HZJvCJUQBhakvhQrTQWyhJ930BqDNVbuD4Y/IzNShT/LkUE6eU6SlJ/W6nteQsPg83g4ysOmMEEUAEEz/AZ2fd4BNR3nqRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tteQeqELtDYsm+k9zaOjddEd4vVKRDzWSvF1MAbVUMo=;
 b=RhJk79F3awMaRLbVxFTcf0/omBVCBVxLUG8LzrjZGyhklaYfUNGKLalNDQObtt36ox2Os5HazogxwUU3o9Z9njvYYo47eyDUiA0QHYZww2Te1MbXf1bqSZ2UaeO5aTiUw8rV9RFqMt6jZX7GDzPszD0QLLrhWcALEdHKapOVBvYFVTtcDAmrde/UBygVEZFep+gQoNgDE2wk34l5nOUauUo+sH99QN6q27JYLkc+1rAhpCaYt2InZvZGtuSWYjXS2YkrTVbqyl098JquKYn2w3neNXB+blopJ0hOXVzD9wKO2E79V/QtQ1IO5t6s5RBNUU0B2OnmSfQ4HQ/rc0E5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tteQeqELtDYsm+k9zaOjddEd4vVKRDzWSvF1MAbVUMo=;
 b=YXIDMLPJSZm71s5w8Shme2mnmxx3bJst/jDeFvphPvEPkyyoCbz+3quS9domzHaDAYzOfGXuU1kJSLOHA0gTqWft/QpEF+V8qaK2DMKpcNpLGnosNWiY6vAwWo/G/PQ3Nx5l4jnUFMIEUrnrdWVc6rYZ6e5chw4bsBgx7YQEpJDrGI0Qvjsi4YwiGms+auUezz1z/b8w23ZWf4rDInyv0kLKhnTC82S4G84Omkq5VvYtvcY0q0NvfxyMKk+6AytpCE0TOWUal+OhvqjmsOvw7nDyAc1otYNNNlw5S1IyRlbHUnIf27TwAwv6KOKpbmaosk7nfTS60lUxx1K0mLwMWA==
Received: from BL1PR13CA0417.namprd13.prod.outlook.com (2603:10b6:208:2c2::32)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.16; Tue, 27 Jan 2026 08:53:57 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2c2:cafe::71) by BL1PR13CA0417.outlook.office365.com
 (2603:10b6:208:2c2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 08:53:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:40 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 27
 Jan 2026 00:53:34 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Simon Horman <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>
Subject: [PATCH net V2 3/4] net/mlx5: Fix vhca_id access call trace use before alloc
Date: Tue, 27 Jan 2026 10:52:40 +0200
Message-ID: <1769503961-124173-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 71adcd9b-fcf9-40ea-cf55-08de5d819b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?utg8hbvDMmJ5dTS5F3cW67DSYJ44GeWX8B+cbLN8ILtLCEF/EEl3hMA1yJUS?=
 =?us-ascii?Q?Owyt/wuUo5iYrzN+7Y5xkacHN79kah8/gi3gpd098KgnwtT8P3CjX4jFLibq?=
 =?us-ascii?Q?4B9Q0NlmhOCD5HzbLLobrxEhGWNwn8p/tyOcMiaEQ6rORCOfZzAIh9vq/XD1?=
 =?us-ascii?Q?uhPIqZK9sF3jX2+1MSiWv11rVmik8dLvsmQn514EtZHys+brPyGfB5ksbO9+?=
 =?us-ascii?Q?rvtJD/x9AKBnePJUsQ2o86vUPD3pgr/5Zx1KKEoR3QCBSuMRfsDv2+QeKQM9?=
 =?us-ascii?Q?UpjzkEMZ1kg053aZSixeN3ffhytLYSzVfYku2w9oJdfEHJ10qvZT5dT2RWWU?=
 =?us-ascii?Q?3mNLR8MfFTXysDfHNhSSA/RV3i+LZUsC7FxMQydlj+9pfpmxZnUwdCXDlJT6?=
 =?us-ascii?Q?+d7pmBJArMJVKlhErxL25bL/kWH4yWqdItXzhZERka8ue8lyJErqa1xN7NvT?=
 =?us-ascii?Q?+FSAw+swrMeq3EFMjjoM8ix2FcWcm/t/LUxv7MPEyqEVwr043KhkwbGYBNT3?=
 =?us-ascii?Q?ivu5CdC4umHr5IoE42tFYSzX0zXhWmE+GI6nLL9JheRXTN4//QgvsDbYQlwu?=
 =?us-ascii?Q?he7hDAhpBc7s8wS41zBsSxWTbqs8a90yjWv8Mxq03N6Ky45nUc61jVfAr/dV?=
 =?us-ascii?Q?qeyebJMOMKk4POEzEVX9nP3NHRz63wF26AnW9thI1RddM1p5Ax0vp7r3YygU?=
 =?us-ascii?Q?ltMeRg62A9u3jr52oEi09NJeBXpfp928VYtI7OGL8TpQwzYHxVNDnjMfYvcO?=
 =?us-ascii?Q?MCUviB3kiiya5uWuxwkH4RcJsl0EXd4LXuaf5eegDFrWOrIy6RnHRSMuvan9?=
 =?us-ascii?Q?HWzsiJIl+sFJ6D1gnWHDfDmD+zJgIZ84RBoJIZNPlhj3ZMQsvglVwehyYfw7?=
 =?us-ascii?Q?LEsQGiFstcBPlyMUxX/sjkxFIQAkRhB3TxmSXWtAJq9UZ7Wey92+6rsXij1Q?=
 =?us-ascii?Q?O3Nmo5LNRUoaQOG2Oj4XH/odDnIbKtPGkrhfRm3OksUQM6IH9pyZUQjiFRvd?=
 =?us-ascii?Q?MHjKEya3Z/IoR4qZ+r6rTDEopEstncYuTNd9ok83yR3wibZBLSsLp5X9OG8O?=
 =?us-ascii?Q?x4J1oLSO5eeBPctNxglOTP5/oD0yertbXgoNP5ntmGkDvw3OncW/v9a9aGpK?=
 =?us-ascii?Q?ew8DAtY+ApJFnG+kt46O0Yneo6Jn1S9/nM5O5JLro1yyIhGIYPENsYvzyCPa?=
 =?us-ascii?Q?tsuzXU0uIW9YS89LeVWfkVlR52uO07fEeOq4nfbOYTjFShxwgXIXbRrA+DC/?=
 =?us-ascii?Q?orAcwMsmSSQ47yJM1s2jPc8nsp+42Lig/mYrq/x6ErE92k2ZhJaGulra81EL?=
 =?us-ascii?Q?bZrVNcUvUeROK0Le4t91jkbAXCTKHF7G6bHNgh18Viv2qVK/KxaS9mZpXmko?=
 =?us-ascii?Q?pf8DSXXGxmhArqyFKMwwsD60EHYTW1Mou82xBrWJb2+Ur0AuUtBxCI2vpNuG?=
 =?us-ascii?Q?DYGo/pRoCgQFnOVn5csoARVYbkul2hbPc+XZ9O471OYftH+mzeTPYq4MFEio?=
 =?us-ascii?Q?K/65sOPYghXr54n2PCX9AUVEoJE7ZNzqRTtyA+qZUcBjcu43XlRkoYO8WadG?=
 =?us-ascii?Q?Gsv6GkTQbY0sfrp52p4ETb3PWXwt50Dt4M+3HI6nOwSUJS11nuVp3yzlYo86?=
 =?us-ascii?Q?9o26r1NE54vBTSRx4QcT79EPyvt/FrSIvVuqynLsIWLUoEVaOwJcQ8kofSw3?=
 =?us-ascii?Q?x4Aibg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:53:56.4227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71adcd9b-fcf9-40ea-cf55-08de5d819b05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16054-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DA0DF91544
X-Rspamd-Action: no action

From: Parav Pandit <parav@nvidia.com>

HCA CAP structure is allocated in mlx5_hca_caps_alloc().
mlx5_mdev_init()
  mlx5_hca_caps_alloc()

And HCA CAP is read from the device in mlx5_init_one().

The vhca_id's debugfs file is published even before above two
operations are done.
Due to this when user reads the vhca id before the initialization,
following call trace is observed.

Fix this by deferring debugfs publication until the HCA CAP is
allocated and read from the device.

BUG: kernel NULL pointer dereference, address: 0000000000000004
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 23 UID: 0 PID: 6605 Comm: cat Kdump: loaded Not tainted 6.18.0-rc7-sf+ #110 PREEMPT(full)
Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
RIP: 0010:vhca_id_show+0x17/0x30 [mlx5_core]
Code: cb 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 47 70 48 c7 c6 45 f0 12 c1 48 8b 80 70 03 00 00 <8b> 50 04 0f ca 0f b7 d2 e8 8c 82 47 cb 31 c0 c3 cc cc cc cc 0f 1f
RSP: 0018:ffffd37f4f337d40 EFLAGS: 00010203
RAX: 0000000000000000 RBX: ffff8f18445c9b40 RCX: 0000000000000001
RDX: ffff8f1109825180 RSI: ffffffffc112f045 RDI: ffff8f18445c9b40
RBP: 0000000000000000 R08: 0000645eac0d2928 R09: 0000000000000006
R10: ffffd37f4f337d48 R11: 0000000000000000 R12: ffffd37f4f337dd8
R13: ffffd37f4f337db0 R14: ffff8f18445c9b68 R15: 0000000000000001
FS:  00007f3eea099580(0000) GS:ffff8f2090f1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000004 CR3: 00000008b64e4006 CR4: 00000000003726f0
Call Trace:
 <TASK>
 seq_read_iter+0x11f/0x4f0
 ? _raw_spin_unlock+0x15/0x30
 ? do_anonymous_page+0x104/0x810
 seq_read+0xf6/0x120
 ? srso_alias_untrain_ret+0x1/0x10
 full_proxy_read+0x5c/0x90
 vfs_read+0xad/0x320
 ? handle_mm_fault+0x1ab/0x290
 ksys_read+0x52/0xd0
 do_syscall_64+0x61/0x11e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: dd3dd7263cde ("net/mlx5: Expose vhca_id to debugfs")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/debugfs.c    | 16 ++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 14 +++-----------
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  1 +
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c  |  1 +
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 36806e813c33..1301c56e20d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -613,3 +613,19 @@ void mlx5_debug_cq_remove(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq)
 		cq->dbg = NULL;
 	}
 }
+
+static int vhca_id_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_core_dev *dev = file->private;
+
+	seq_printf(file, "0x%x\n", MLX5_CAP_GEN(dev, vhca_id));
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(vhca_id);
+
+void mlx5_vhca_debugfs_init(struct mlx5_core_dev *dev)
+{
+	debugfs_create_file("vhca_id", 0400, dev->priv.dbg.dbg_root, dev,
+			    &vhca_id_fops);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 4209da722f9a..55b4e0cceae2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1806,16 +1806,6 @@ static int mlx5_hca_caps_alloc(struct mlx5_core_dev *dev)
 	return -ENOMEM;
 }
 
-static int vhca_id_show(struct seq_file *file, void *priv)
-{
-	struct mlx5_core_dev *dev = file->private;
-
-	seq_printf(file, "0x%x\n", MLX5_CAP_GEN(dev, vhca_id));
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(vhca_id);
-
 static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 {
 	int err;
@@ -1884,7 +1874,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	priv->numa_node = dev_to_node(mlx5_core_dma_dev(dev));
 	priv->dbg.dbg_root = debugfs_create_dir(dev_name(dev->device),
 						mlx5_debugfs_root);
-	debugfs_create_file("vhca_id", 0400, priv->dbg.dbg_root, dev, &vhca_id_fops);
+
 	INIT_LIST_HEAD(&priv->traps);
 
 	err = mlx5_cmd_init(dev);
@@ -2022,6 +2012,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_init_one;
 	}
 
+	mlx5_vhca_debugfs_init(dev);
+
 	pci_save_state(pdev);
 	return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index cfebc110c02f..6d41d2e5a278 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -258,6 +258,7 @@ int mlx5_wait_for_pages(struct mlx5_core_dev *dev, int *pages);
 void mlx5_cmd_flush(struct mlx5_core_dev *dev);
 void mlx5_cq_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_cq_debugfs_cleanup(struct mlx5_core_dev *dev);
+void mlx5_vhca_debugfs_init(struct mlx5_core_dev *dev);
 
 int mlx5_query_pcam_reg(struct mlx5_core_dev *dev, u32 *pcam, u8 feature_group,
 			u8 access_reg_group);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index b706f1486504..c45540fe7d9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -76,6 +76,7 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto init_one_err;
 	}
 
+	mlx5_vhca_debugfs_init(mdev);
 	return 0;
 
 init_one_err:
-- 
2.40.1


