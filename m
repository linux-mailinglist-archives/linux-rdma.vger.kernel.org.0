Return-Path: <linux-rdma+bounces-18649-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMsmDJIxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18649-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:03:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBAB32AF89
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1DE8303CACB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A533B969;
	Wed, 25 Mar 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XRjxcezi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A63EC2F2;
	Wed, 25 Mar 2026 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465274; cv=fail; b=jQaqldisy9OdfXtAdR2BU3vhTaahSjoRgpmXAbvGqaGaXhIc9iGRVtURHF+Nrg2mhag6EpP6s/F2tqa5pWAmaKa9XdDExZlYDi+059NAEb7FRTdj6tOxAh2yzuT1hvgAvJ9Pb3WKMV20jd7mgGsY3SRRahpkts9m4RCfax2zX+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465274; c=relaxed/simple;
	bh=jG4K3gWAL+oCtETuW+eR6WjLnBjgrjVn5MCcyIZ2jJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DX5JqXPnEqfeF6Pn2teZw9/4jxCRepty2pC7Utnv2Zdhrwq0TTW5/yuoOpLuegYmlBzX0ecCPjd/PZhhHqGwaeIkN08PuF4/J621Z+2LivQTiIKFe3P3o6sbWOftvY2vGq02JJJwTNnAHjflF5sW4oETbYgLHlLhku97JRYAWIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XRjxcezi; arc=fail smtp.client-ip=52.101.46.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNvnLOvXQQWvougPO9UaCZ8hYhcue7jxnM/X+nnplnuI06AGdB/OI6RN+wIyNvGNtJqRqhLAx4B7soz7LjNYhCSIUjnTzpYmZ/ePxz51Q8uyb2BPCx5rS1uXnDachS8/kuTsB8FPCAo2ipCxU9oZOVtOyCggIy/OtKcZjE8yEtMqwvLKAicKlzR1qOhtR3vXse2Iw/RrZDtqgAXoyEof1IbmvjQINK/onMgSL/Mu9ynVBaPYzgrcfCjEr/JhRBk4/Zyond1a0716KD/YBxcAxnV6TezJ+XRtQKHgAl2klRYcJ/NZD9ROzvnZoL6YNKbszIjNBHn6cu7e+PyFGebLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+AoaXP3WdW5VKzHFnzRo7fdCCcgWzp6Tzt4YTymfF0=;
 b=hm9wmAeqZOKlOKw6IXIXTH94cn8FviNOmrlVBAs1dvIRZENtWZ+AVTn+WzL6RkPYNZKyFxxi5CAfprs5ZqhFQBlmJ6pB49QM3az42FrGHBWs/SJ1b33p+WbEfHamIe3TYByKRNXyC0bTv7q2ctKrKzQt8q4OW1x2EBL+onM0DzFNfHtpbflzpyITj4d/FrOICa0p7LDloe0eMkBfPJj6YpHdauRGSC16WoDT2A73Ek1J67pDLrNEt40uYd9LEX6790tH8o4az+T8v1hyu/n5okBEoQOEAFyg93XAkwjZJjeh4ahAHC7iiUYoGTappxFsG5LdZxAPa/zlqvucbZd67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+AoaXP3WdW5VKzHFnzRo7fdCCcgWzp6Tzt4YTymfF0=;
 b=XRjxcezisZ/DOfT6E4GWmUj0fqgqxgfotm6tvGhMW2YbTxYIRuae44MoTJdkuwpznp5l+oO0RS6aNzVCARDyYiEOOZ6ROD/IxXACpYjy9rTH6CBUbpr78POFNQ+K+RZP7upWlISq1zB9+z4fiEbX6qPNrd3JvAJysjpFfVnNAdrBka+W17dWN/zvKTnO6MnIBGgtTTrPtn9wRRG51FSeQ/AiCbguuCoae0s5I7USPxELHGd6PrOlBcGWkkFgy5SL7laHWJPfCeWLZyE9hrHeU0vDB7h+jB/aAzc49q5pCI1xZOKNyNgTbSoIKZ8roEbVtFHYWSD1kEWpSHqpaKScKg==
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Wed, 25 Mar
 2026 19:01:08 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::b5) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 19:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:45 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:41 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:06 +0200
Subject: [PATCH rdma-next 06/10] RDMA/mlx5: Fix UAF in SRQ destroy due to
 race with create
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-6-c8332981ad26@nvidia.com>
References: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
In-Reply-To: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=3918;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=jG4K3gWAL+oCtETuW+eR6WjLnBjgrjVn5MCcyIZ2jJY=;
 b=m49QOuxewFMfhZoPu3UkqQsQUSj97bKse3qLJaq058nz1k79/16uXSSnD0aEGAj64ZRUSIu+Y
 xbBjWRrWxU4DBSyAIvZOGK8Wt1uX+Ni1Jcz6Hn7DYT2z8ObKHgaWQYY
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf4a8c8-2ffc-424c-473e-08de8aa0df6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z34JLQ0/0VyZdsopNVVRTao05mPnVOT4sWZN8VCupZ7YRyubC02v/xsk1+5CKtZD/WBrWeQ5InE/RWcex7wtgj+HfmCheuH0luwRyXqCyOPqosmmgrVFljIK9Q3RC+PWXlo5XD1hEjZoyVQc9FC6y41h0ki9L9a/J9l9HdoHTClpqvJ1QaxYJmT7dc6ESKSxU+xLES/lVsKOa6yv4PTjzqCopg/uvbykdjc6fbsnu/C9VleXzzHCOoYFfS8RBvsQiZTH+t8bVtds4TnPpDWCJ5iei6jkclFHfNx0SPG/ODfJKwbrB3EPxUup8s6lZyzUeRSgUv4/XcJLvoHOBJB9+5IoGTY/6Nrzh7flUTxQHd4dMMuwLJsYGNWOrN5vJS9MjFAl2nhiVZ0t+IG0eueYazYkrxff6JL6h8YmW/NdUFI/H2GS9O8YSHYUY0Ot1EgfMdtX8+IT68ToAHs4o8WQCT7yGnPqkTVq7POCmGf0xjkOdA+E9F7SazcKAcFiJplCGBVtavVLMcdAonP17ksrFCouGJjrteBpKHoyiGd9sE2y9A7ZJTmbHWgYdlkYg7ORrMb6V6DXFCXqDTnKZeH6Qxb24zofWSae+DUmubs7ASjsFGmf/eGbZ8DSG5gzzA0K1wlBkbx/99DVg0pVwTZ3Tbgcz2+uxWbWnHkHP3FtHe7cqcpdNiPSVo00u50Sui2FANPLfS4P4e4HKHY08ZfQ5heXEHoojDTRIfti0QJ66AIYUW/P2VrDWdm5icdB1ZmrddkJ15geN1/u9ZNiCXpq7wkK6nEVRBDDvpFBeyKl1dVru5Wdq7IOYMxrAVaB2J+s
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U6XBrM36D1qs68t0XNkQ/g7j/IOnC7jTFLUkclN7bOmL2N/dmU50mMnN9J2UsXQZJtKXt+1RZA03ccHv+10Rbjl8CfwPiJVMud6cJej8ZuBz5jrz5Z/Zqi7Sy83lIkHbXUeRDb0RS/zAqks2PvVdkwLGLu8CKD73J+hiajygKhP8P/wZxZBF11tEAI3V5VdBohiAjcbCZy0YPpXS2WrJzO5RFIyfx8b2QkUo+cDOy1HNXps1MpvLdMgfm0qhMT8/IO5fzVEmRNEt5hss9LY811eoLCefmjK3isHlH/vqlrnM+MFJSV1bG5iafrALoJx/mT20FYWHVYbfMUzmobiCsMpat6Np6JhChihWxnQvbTcLlV22u0uzYgJQPTGBbFsbU6etAK+Ex46Tu/jFstZfun/PKvqHOhTcjC52+i8vHsD46DUK1ZbbqAwsV85B3+Ao
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:07.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf4a8c8-2ffc-424c-473e-08de8aa0df6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18649-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BFBAB32AF89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A race condition exists between mlx5_cmd_destroy_srq() and
mlx5_cmd_create_srq() that can lead to a use-after-free (UAF) [1].

After destroy_srq_split() releases the SRQ to firmware, the SRQN can be
immediately reallocated for a new SRQ being created concurrently. If the
create path stores the new SRQ in the xarray before the destroy path
erases it, the destroy will incorrectly delete the new SRQ's entry.
Later accesses then hit freed memory.

Fix by replacing the unconditional xa_erase_irq() with xa_cmpxchg_irq()
that only erases the entry if it hasn't already been replaced (still
contains XA_ZERO_ENTRY), preserving any newly created SRQ.

[1] RIP: 0010:mlx5_cmd_destroy_srq+0xd8/0x110 [mlx5_ib]
Code: 89 e1 ba 06 04 00 00 4c 89 f6 48 89 ef e8 80 19 70 e1 c6 83 a0 0f 00 00 00 fb 5b 44 89 e8 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f> 0b 48 89 c2 83 e2 03 48 83 fa 02 75 08 48 3d 05 c0 ff ff 77 08
RSP: 0018:ff110001037b7d08 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ff1100010bb9c000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff110001037b7c90
RBP: ff1100010bb9cfa0 R08: 0000000000000000 R09: 0000000000000000
R10: ff110001037b7da0 R11: ff11000104f29580 R12: ff1100010e2ac090
R13: 000000000000000d R14: 0000000000000001 R15: ff11000105336300
FS:  00007fa24787c740(0000) GS:ff1100046eb8d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa247984e90 CR3: 0000000109d59005 CR4: 0000000000373eb0
Call Trace:
 <TASK>
 mlx5_ib_destroy_srq+0x25/0xa0 [mlx5_ib]
 ib_destroy_srq_user+0x21/0x90 [ib_core]
 uverbs_free_srq+0x1b/0x50 [ib_uverbs]
 destroy_hw_idr_uobject+0x1e/0x50 [ib_uverbs]
 uverbs_destroy_uobject+0x35/0x180 [ib_uverbs]
 __uverbs_cleanup_ufile+0xdd/0x140 [ib_uverbs]
 uverbs_destroy_ufile_hw+0x38/0xf0 [ib_uverbs]
 ib_uverbs_close+0x17/0xa0 [ib_uverbs]
 __fput+0xe0/0x2a0
 __x64_sys_close+0x3a/0x80
 do_syscall_64+0x55/0xac0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fa247984ea4
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d a5 51 0e 00 00 74 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d
RSP: 002b:00007ffecfa79498 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000200000000080 RCX: 00007fa247984ea4
RDX: 0000000000000040 RSI: 0000200000000200 RDI: 0000000000000003
RBP: 00007ffecfa794e0 R08: 00007ffecfa794e0 R09: 00007ffecfa794e0
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 0000200000000000 R15: 0000200000000009
 </TASK>
 ---[ end trace 0000000000000000 ]---

Fixes: fd89099d635e ("RDMA/mlx5: Issue FW command to destroy SRQ on reentry")
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/srq_cmd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index 8b338539659933aef94a3e2c056e9400c3fb9bb0..c1a088120915c5741f37ed44fd2e8139bcb6802e 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -683,7 +683,14 @@ int mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 		xa_cmpxchg_irq(&table->array, srq->srqn, XA_ZERO_ENTRY, srq, 0);
 		return err;
 	}
-	xa_erase_irq(&table->array, srq->srqn);
+
+	/*
+	 * A race can occur where a concurrent create gets the same srqn
+	 * (after hardware released it) and overwrites XA_ZERO_ENTRY with
+	 * its new SRQ before we reach here. In that case, we must not erase
+	 * the entry as it now belongs to the new SRQ.
+	 */
+	xa_cmpxchg_irq(&table->array, srq->srqn, XA_ZERO_ENTRY, NULL, 0);
 
 	mlx5_core_res_put(&srq->common);
 	wait_for_completion(&srq->common.free);

-- 
2.49.0


