Return-Path: <linux-rdma+bounces-19578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDZGB9pC72lP/QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:04:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5BB47176B
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E1CF30440BA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B583B6BF0;
	Mon, 27 Apr 2026 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="apJHOGx9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3173B5842;
	Mon, 27 Apr 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287802; cv=fail; b=LuJek/BZ6OvKUf6R1XxjMC0jig27Xw3J273+w1QFjVC7OKlnI9GzA2ZOxFjMFnqeB/Vp1Kf3NXxQYTyyAewJU4unYqZsE2SGy36wHl5gGpUmFxZzW7WBTwGhxKyOztHXzLzqlczIXY/tX3JjnFMrWCu8cAzYgSozlfOH8USM9Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287802; c=relaxed/simple;
	bh=jG4K3gWAL+oCtETuW+eR6WjLnBjgrjVn5MCcyIZ2jJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GKreTEsdg8d4S0y+0Vno6cNm993603uBqllQpdjtnppfkVCg3mFwEH8fB1crvkTNXesI5hous0VnoeA4xtX6LTe+WC3wlIkXxKDGEYath1D8skczkPxx6z0rhJfF1jtDg0PxfSP8htLRx+iDYCL13upJQmMlo07XOYgAdRhs3xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=apJHOGx9; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQLqli2ZwXyedEm6TGXwBoMwj7PZjKlybpAi4JZ/gyJFTuq9z9FvBVexP82pPwSxM54kePmGenWZ0qrT/CVMh+fvb3dKMVMlgJJHwr/ypC9BqYFGNVhZ/JzVFDOQnURYx11iuomQynankbeOWdeCYj6VsYKvA2EEMOtZRF0rqPFhwIywXRUw90itRdtJU6+jxYbz0BEFkk8W8r0U6itZJAPkzEjIOXghIV4P+btf225lxnDvQ2MX4ijt2q9uAc7/0/yx1G4d8/OCuvvmBg24SV+5hsuuRn3HT15F8xFV8PzTLsGXzJeSQMK1ZJTvIth+wx/cPhszvqDAejzoobCf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+AoaXP3WdW5VKzHFnzRo7fdCCcgWzp6Tzt4YTymfF0=;
 b=qUFYg2VoPY5zYsqvoS9qxDqf90Bq3WpCclh5QlbHm3bEtVNLqA3e2RnLBS7XWDkFB+Y6Nmekhx2yV70hWJzpWI6Qj4DEn6wPkcQI4bu/jnhNDe2obcpUHNPSB83CLO1MCeGZy4DA6Id6ewtdYBCJp3yTEULp0GfRQU9poLMkXsC40hhezsFm4RuywISsvsi19rAOFwELZQtXgCk9pOSyHhOQA4HXOtsqmBFtUEdS9GKUABwBKu+aZly/EjihfJI5q8i1fZddA7Sy30J927UcdUr04eiJylC4fdgG9iGdIA6qGG3tDFVMEYvoi5YFYQreneBl8POpAh/aq4r/mcuR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+AoaXP3WdW5VKzHFnzRo7fdCCcgWzp6Tzt4YTymfF0=;
 b=apJHOGx9FB13azjIcE3VxHbyvpXDERbk1qMY/eCdckbgSCsGQf7uTt06HSvAQ8P4rVkh3oIbOcSY1xPbgWUFj9aK8x3lN9ABcYu/kiewRLp5zxr1bxBRGW71jGyNrhg6LRlsry4xhax5iycl1pcqCjSRc+i8zcZdMtkinOoc3nkzSfL94umnH6J1/V9gEXw7n2cbnSzaVlRX9tP88asXYVHdVTgM4n+kWFK4C59GCjxgIcx/tYYg7ZJJfLQZB1EQnEgkacmB5PPO+sSFxrfVipHZg0TEAoaKgMFfS5g1WWv76Dm29D7vTBqt+6b8D35Xm8MTEzJo2iYy0Us3hixU8w==
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by CH1PPFDA34A4201.namprd12.prod.outlook.com (2603:10b6:61f:fc00::625) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Mon, 27 Apr
 2026 11:03:15 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::31) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 11:03:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:02:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:02:54 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 04:02:49 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 27 Apr 2026 14:02:32 +0300
Subject: [PATCH rdma-next v3 1/5] RDMA/mlx5: Fix UAF in SRQ destroy due to
 race with create
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-security-bug-fixes-v3-1-4621fa52de0e@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
In-Reply-To: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777287764; l=3918;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=jG4K3gWAL+oCtETuW+eR6WjLnBjgrjVn5MCcyIZ2jJY=;
 b=Ls9Yk6SOm7N+Ohrof8i29jaqrahc3xCfTNVQfi1Uo69b6JVJN2tUHeEhNfsKW3xwODamMj6Ic
 NmDiBHTZBFrAVO80kVSrcdyH0R/3FZu3DmtOE9paFWUGT89kkd3ROV5
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CH1PPFDA34A4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 046b7eea-96df-4482-ddab-08dea44c948d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kekSu9Ap+sWFlUwOn0iZF0UiolZrFQ44axGQ1ihyOjGhWWmejvms0P1JnPySJfQi24L9O5syq5TI4lMQ/Vpu84TYtLzER14pvAsyox3U3fMFvkEyUzRkNre95ABOd57bwJ6hzbey5wmH+PVrAB/bohT7a37gsnIhYhzCsuLzb9jOy62kj8nVnW10cuYCuJCjUNeXVZbX6+rOzyI/tI4MVx695Hn/4r1y5dTUzxzOimzyO/h8rk4Pe0XuyL9JJbfUWzQkNV4vwgC0bnlVq1FrvewTqCWV8YsIrEoqrfYxWh6bI4wcQFPw9D1Db1VPVrpODt6Pg45Idj2T3azfrbggDUWt7S2XApYBqh+8RHsUfAQvcDcaiOr4uztGhMzBi7Kb5geQumKazvY4a2MQL5SlVDPTBFvwXgJPolXk/ZTG+5cqHqndWxBfZp8AarOu4Ayon0m0Ir9bztmpyETpA/SVdHZRze+DuLS7IJL+8wpTDXTlFeqdPZny5hswHCBpJd2C9x67dhAPGywUNhuxDyFegTRx8GpCQd9KNf65AzTv6Fa8OuVfKix/gYXjeLIWbKNuI/oTxiXZ33FcBO9xYQwun8C3kJvQOKN+6/jRHh6D4IAkLS6rIJ//FQhqPYiY1aloi2Hm9fHGzXMurtcMcwp9vnl6j/4I0OKcWyJBhlFswxrfY7+KA+BrNUKYs78sKyer9XBed8rcSpa/a8ZxDolN9iq7yXx2EN539xkYsa2UDJWYut+fNmpWmoJIdgs2ljHFWPJ5iSrx36XNjofB+XQ7SRSVCOQoczO8OzxrQll97SDtr+kFk0JaRDYNk9vFzrgo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rr35dxfo+rxJSVmN21aw0RJrJ6LOGBo5I4ChyYxXc+UtC7oyeWcHx32hrkIMyIiLECnZy7vqaz6/izIQEgs6QvZBEfYjIi+PemiI8GrZk6yx0KyjG9386GjB4t0Gz0s7y3WLEQ2d+KTL4X6eqjSYfAhEsMFeJABxWJrGc628XNu7LS8CfxlPtPaVBMd5GU0O2vMTZ2RqnqxW5aB0uhf0mbIwjGkkpwBPSVw4j8nYK0udf8tWXW2aVnKED4tPy/R6eGU+IBqTziFLYSVgcPPcUwAeah8KELME5FzE7vfWxTFbYexJEoYRp6qcYyrATRnqizLbYUWXWEuX8hLTJ5NZ6WattqDULjQK2BxSiUjyVujWbhpv0WeQH8KFixn20EC6e3Fd7mxXf1WaIKwNRpfST8xk5xLI6HN6iMbWlV2dVN+Gx7lqDuGVrbo1gRAWtOBe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:03:14.8865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046b7eea-96df-4482-ddab-08dea44c948d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA34A4201
X-Rspamd-Queue-Id: 6F5BB47176B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19578-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

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


