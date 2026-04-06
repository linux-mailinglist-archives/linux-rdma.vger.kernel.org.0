Return-Path: <linux-rdma+bounces-19016-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG3nL25502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19016-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:14:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 552203A2817
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96670302D5A2
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F0327C00;
	Mon,  6 Apr 2026 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gt7C1TVj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D932720D;
	Mon,  6 Apr 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466728; cv=fail; b=gBWaor+f5V9gonOXf745ngWy0NG7TYJphGpusFGcnSCZ8hM7699q14bDbPOcZ0iCODBbX3lIk61WMTm1+Xwl0nD0nRKjWefHXkJ4SnwKI8NfLRKBKsCRmGsWB/E0ziyIa9B6pA3B+t9ceJMHLDOICfOQbQ+0oKZSGphS8zX/vKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466728; c=relaxed/simple;
	bh=jG4K3gWAL+oCtETuW+eR6WjLnBjgrjVn5MCcyIZ2jJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rMrJFHARoSOQE/S7LCxOOJE252sq/iw7N1MN+3oYXjSQilGdQIpuUU1XCpykWoi95fX3WLKjd5SQCdxo7CHzB+eTJqPiiFN8G/rdxjCR9SSUAUXEmpq7lzLKiI3Tun7ED2QqFuOmHI2YwZ/Gw6JAa1L8J+/xQP3bLdiUDChzT9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gt7C1TVj; arc=fail smtp.client-ip=52.101.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiSKgaNP/WYMrg8NDbQSJNEIrbCgrJ1TNp4Bl+yMQtaJLwMPbkTYKc9FKqu1MvtM8eemRHldhesRg4TVuhIuDeYQ5Zy52LsBO1A133X6orLSSPLyfgLbiNeYdtKVHHrmW+cUVcqXkGGQZH76sYey25alD/SRkKG/BRUYgtGXivLsBo6AP6Bw5fzABzzu/wWsHUnLAevHj3ENW+kSgUKyHoNYS5P/EFIF2hPAPxan6qOrkc+jve2oWKnOloBWWjU3DN0GCOYXUjPgWAVqIFb6du6MxlHjZVX2KVnQS7SOtfTBlQobb9DZE5iMOvZ+iP46fOXQAco3uAKs+q/aB7f0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+AoaXP3WdW5VKzHFnzRo7fdCCcgWzp6Tzt4YTymfF0=;
 b=QtDgWInjgBEXCFkFfs2eYV8r78sWBvbcJzeiCs1LzAWuvCEEkN5iI/r6H9GMYfjcMrxIFwZ/bBntcgi7Y15QrvlBn9o7mOBCT60afX5iSSaYmF7D4ApnxW9fb0v7ZmA3Lg8wV6fC+Atiapjr9nv/AzFuaZL0tD52UX2B7/IACFHiBzWkHinGqsVnssqZv/AuApyK4wIX00Jbqfai7oN0EEufyV1x9vBw0LQ2Ssc/FrZtXhsyrN0LnG91Td1lkEK6n08b0VbQog8Dl+RcBa98+36hZHkBnW81uNaHmnFCIIp/ST/weGsew348hKU/3GnSSwNfPyGkrhAy8AlQQrwoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+AoaXP3WdW5VKzHFnzRo7fdCCcgWzp6Tzt4YTymfF0=;
 b=Gt7C1TVj0uubkNc52WTT3TIy49vz/7I0XwYC0AaRrI9UURTmhCebOKIN7au9nD9eWtRc4+4f4qP45lmHeDETl33I2fZcKLajKUcEz+aXS4SnGNUqvIO2HXLWq2EDeBSrVsJeyi1Xf5bLkluRhkJOFHnFNYi6oW+56FTOI2BCoub23Ba4cWJoEj9kAB9UeXJ4V2aOziv74O3sBaUpLvfIW+oH/5+YYWqGzOR9m9FIzT0+PO7YMhJvSzOjICjJ1ly66l8RM3CeP5h7sM1y9mvZqJBvQVdk6j7OXdXzpR0s+hWO+aap+hNKEoAyM7lEytF6XyaBGWYhbuP7nEKsLceCYA==
Received: from MN2PR19CA0052.namprd19.prod.outlook.com (2603:10b6:208:19b::29)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 09:12:02 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::dc) by MN2PR19CA0052.outlook.office365.com
 (2603:10b6:208:19b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Mon,
 6 Apr 2026 09:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:12:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:54 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:50 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:18 +0300
Subject: [PATCH rdma-next v2 07/11] RDMA/mlx5: Fix UAF in SRQ destroy due
 to race with create
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-7-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=3918;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=jG4K3gWAL+oCtETuW+eR6WjLnBjgrjVn5MCcyIZ2jJY=;
 b=M0PfixREI0nfmwwOq98EyF1A6J8jUcH8xKS7I0ti8rbcJNbjiadMUSqGtl5vavk2oxCxQ2bYR
 PZyrQto8sU7C7tXrBbQH07CaVTg4B4YnqkwUwez2LFVINugUs4Rqrk3
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: a249e83c-65d9-483b-bdd2-08de93bc90cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/qqTXhn/bpbOEXXBCc+IwtGkoeXaDk9tDa/k7gigoTzNI5XIxYn0zKfOQ7/E2AF4OJd1hJ2N+0ZUnSox7nYo/GIE9PzOLRMxFWfhtYt6YmZWFIPj4QkvmvrMsv+dQZhDMNRpONmPgPXSILbyc+yB0bmBIpJYR4OfdcaTMgpM536kicYbuSjePtsH3QcucSlT4r+14C/tv4YblWZdrD64JYWh1WbEyMc0si7DMwCRqzNOQYG8XDvJglnAR2izpFL9Ed+oZy1H1CI3Vmquh/7Z43ASG34HFm+iXUHsRPYS4jGNt6ovTevzuZlgg/ykRl8DeZjE4u6RqqV9XZ7h0EKdr1edUGhwbsgsVp5iwiSaZGmavTfHaVUQb30QXH9uKAMPfToD86EO3X/V67/cNK60NFUW2eoUgqeIUR+UxG9yD405+qHRxUmFnWW73Vk7j+azkCQfxH1tDoV2T4wuVtCRfkUMq0/fakgZrNT33rZvp30qKb3NRUhuTpGuUJ9Yb1344p5d2cNDgMlpCoo0Yte5ipbbFhtvQKNUna/KJOX2GSTAWPnjwKWozp5K7kQnRzHgp84L40gIS4041LkDIWgtjQq8pYPZbgJ4xupurojM611v9qw+y8QUZlmCS5rasjeWmE52NGNbXix6WGZLZjMVqY37OxYM4aerMLEOfjtkPrHVEBd6z6RFl50HGynVxMX8GN1Ls/hp6r2Xx32wLUVqS98sOo6RGusiNI3k1PzQbRdZ2W3/ZGVgcaCms844PIQCp2Jwmx7TGAanjA/mHQ4XW0IZgrjxbcVmrfGLm6DnhiC/YmJOhb/F41qleXRhCW48
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iQmnT56KHXmlvVLggn/iTI8hfnCwOoIV+8PKOD4PbxL7vXN0OkoxLjkkjhNi7CXmzkXvmSpSY0LC8lxE6s6YB9EUouu2fnEN5u+B6Iq36WtuhfH/zrYU6Jn8EsFlBWk1Bztf60ByUKL79Nx2SlooZMfEXXjIjKw51E3hyNOuv/IaBuFqS27Dizfi1Q9DKckmhyWJXHTjoVBY5UdTUXoIQzo3dlAXUhm3/I8ivGZgDLDU4waiQ+NPzpVzOw+nRpdzM8Tncu0VyABKCyD3slEjaMW3KidB7YgEPqO8LB9zrgL2AhnS3zPrXwoHH1OdJnwpmg1fvdK3OOeV+ubK9Sv9JqrxKmopMgdLxkn6sfckqq3bNkCSifQo//1U4//Xj2/g0f1aJvstI5lQyiptvi5yl3iyZdZO28uzGZtrJQlJ4jfWDORT+tUW1w8do+9gD9AO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:12:02.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a249e83c-65d9-483b-bdd2-08de93bc90cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19016-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 552203A2817
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


