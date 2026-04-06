Return-Path: <linux-rdma+bounces-19014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHkxMTR502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:13:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 859483A27F7
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB69130234CD
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269531E107;
	Mon,  6 Apr 2026 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O9civfjG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D7131D75E;
	Mon,  6 Apr 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466721; cv=fail; b=E/xSzHwtbR9WWbYRjx4BcscdgImBUpkQctu2/IkXdhW0b2kmED75VkS1CXoWJWDVjoKQ1iDHylHOnZWvcEyzXJmhbsn3YWzr28i4HY9BMpGlA406PyVT+e85WK+kqANMGYOHJ2vE5QCkaUnyhMI9ue3l07XTpfDq3giYp2zqu8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466721; c=relaxed/simple;
	bh=grM+h8GRDnOD4JjfMVxqh7PYok2VkVzxVMjVCs+8eHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=t2s93snoVOjb+zZoqmAv32dDhMEtz9miIQGW3WC/NyIilkPhmhi/XEkemDMVrMMP/+VkFJcARXzBU+OGVe6KGE1yLALN80xK4mR8FQm7fzPxonMSrfkVxwvj7vv27KsMBBqY6kNX/DFxiZXoH5rS6yOwiiXDynk8PUp3JnZC2ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O9civfjG; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPm30u6wCThPMcIrmrAp6shMbmwgOws68PMNr8lTiqCVclJjFPPO7WtjE8YUVNh5WuJUHMwjYuj96P2eburlddcIopHIGDgD3F0LvlCQ1nDfw5JGSdwx6T49fNlkhUkTyKE8ZozHnh7WrjD/RffIkheCuyGbMauFeGKQlPVgUQmA1cLg4jEeHp25FlABk0lQl4EgUfr1wPlnbe8peBRWXm8VrlzZfkRWPH1yHpzEaHLx9V1a+X6p/aaIMCFostXFIW4o3+5XPjACn7Wkm1xNtBUasAwB2PKSojkeJKWirYLUkPI/ssZgKX/Py/GeuoqiOjyJKA3SX3fp3NYJAl0HGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8GRjYq//0NzG23dOsTx8zq9q1wRwikt2KBwkuzABrY=;
 b=Rnv7KKmOUtBNfhfXJpV+KPSIHGNVKRiMWfEKHYUxKFaDvHlqQqxK3ODPfhS29P1oTnOy7vgJg+yolkiGSrv9qgrWbFkFP/eeBAj78mXfuibPaCGZQQ5Vh19P75s8dr2kwuDSo1Un6yMc9/X8+GqNdWYOXPd+JisF+apBp0kpxA31NtpeLQD6HkDzQrR8L8oyvBWFuWYD2zb/0N2quspLG2ReyC3jRUZU2al1NS3aZHQtprhaUm4Fv4hiK0gkLhFL5qgAPxCNtI6MuY7DCQSN4jfv0M0yRcODWSO7gGkTf6DkneSmYeFjLaUjf/R93d51eWB9vicqoMiQMCE4fSnQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8GRjYq//0NzG23dOsTx8zq9q1wRwikt2KBwkuzABrY=;
 b=O9civfjG+Ra/kvsEfrjFo4T+HS/wk7VQ9oWrTLG+A6QhXU9IHzukrWx/cgh/rTP5c6pEd1HNCby0vBbjBHLcI02q7VkwjhRAsaLVxuGjXJ1CrW4DUfqTz3nzIZA+65hkXOK2pFDpMIOX0+/0Z7cWi68gvp5gNV4g4caSTl7DZf4ibjwyjbqs3hqrpjRbOqXtikX7UTNdu2LO73TBMi9ZsrAEUwUcCtNTI8HYw2FfKOMWn/fRicfj3/JUDVBp6GA1vr3XIY/SZYjbxvbfcHQ4yaoDrlt/PnreV13Jo8OaQnk6Ew5EQu4fGlD1gUYGmEw6q9ZTJss3INw5WClfrrcM2Q==
Received: from MN2PR19CA0067.namprd19.prod.outlook.com (2603:10b6:208:19b::44)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 09:11:54 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::2b) by MN2PR19CA0067.outlook.office365.com
 (2603:10b6:208:19b::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.31 via Frontend Transport; Mon,
 6 Apr 2026 09:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:40 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:36 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:15 +0300
Subject: [PATCH rdma-next v2 04/11] RDMA/core: Fix use after free in
 ib_query_qp()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-4-ee8815fa81b7@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=4118;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=2El8cr+cyAa9RBhRtC46e0TzQiWJ1QGucPstWX5Wtd4=;
 b=nh/CKHxzB4+n2klnWlzzA3oGBwqN4BhUh3JWwFcy6qc/q18tkfYS9UKDFr83M/Lew5SIoMl6f
 cKFfgTJo86VCrWMJjr+ZGiTG/9nxjq0gIH8XYDbzeIWKAYBr8oviNHk
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 005121b9-23b2-4263-c6bd-08de93bc8c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SKsWUwcg84Ru70EI2RT08WfsCe/UxVaYBR1iF5ijCeYOPY16smsmOMd5oEgBgT56HOFc5My9TsTfnzR6UMVPqPGcG4lIEmTFaF4LciS5YU4p1y3jyJO6KXAPvqBwSBu43u3hiQvtKTEIAMXoTjRNSDahGULWCTfz1z8uecaU0E6cFAnQsPuHjSsGWi5NxeoJqlc/0jcSlU0WeKg4O3QXr1ZalFADn0hP3ueoltO7RV6hWblv+d4H+r2rzqgeTUNR4u9Ayo+a/3vqR/2RlVPg2C8qebk8EkeqRY+h3fpAaaxsLMpSpUkxeGWYEhjO10Qb5yNAKgJJXcB10jG2GAJ+/bg89KXHCVqy6z60S+gU2GpzWigwGFh33ZQSQjI6LxNP8VZlqz4RJEjqLg9WcFH0784mn4ufkrgsxopJG4aqsEIZXMqoDk+uIWh0mtDt34iK9KvMhw8aYci0F+ig7Fr5mstSYO11eKtN/SY8kkuscWIFsUvkOCadyLdvGX4C47NLU6Tws3m0FQH3XYR2DohlG1Hi/V3By0tJkWXv0XQ8dhd5H5jyCZf2h/7J8ve1DOwwyayXhEXBGvMwVFF48PdW3YhWQod4DBabjF4l+hi+RTGHpu2Mop4AfrrF/appv5sTBOTJrxPl6oNWl4QLKJ5oJ9hRxhDojKoj38IiQcq3LuNRfkYSXwmde7kZogr/l15kp0l2YomyZ5z0cr0Tg1dr0gXuYDzFOrryUWkO+Osk4+PDnNBgUi70T2PT44Zi5ocID/9cSfJLcFHDJN2lTBJSwG15lgbQHwWR/8u4RwVXn/P0fMgzIX83fT7GPbt7rbra
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CgFDPtw5PT2VKVH5h+ivTX3adQLXsRh8nZCzvvNZdShVZ5swlg31qCfTMQfzeJBdbT17yn44iLjp6RM0TtLy96Tu9fc/SwubmV3o0i+qdumipIuliQHldNF+Dfkj9oYjEW5vHb2fgRcKPbmYjC+nsY/oG/LvpX1ojVAMPhc37oUEXGfNUGv9qIuMI/Wr/pj6HGI41IKWaEguRaK/kGQrtXCi4VCw1e3yoTMJGM7KzN84gWc513ehEHKcn86mdkB4nakM2xjHBlWFgTiAr65m9I9kCvol0SSBY9wMOGoPr/3vwclEoFQsZACuPASwXWXCSFBd10PssZzWFkTyRGG7O0tRqYZdnJlclMpwHkrY9+dYCX7IbmVtz3yNi6prA2FFMQaRGPUD9UjPoqAqAHBH14u0X/eoTUSPPNsQ8V7qe2lYoVRJ27cVIqV7SHdwscs6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:54.4160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005121b9-23b2-4263-c6bd-08de93bc8c0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19014-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 859483A27F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

When querying a QP via the netlink flow the only synchronization
mechanism for the said QP is rdma_restrack_get(), meanwhile during the
QP destroy path rdma_restrack_del() is called at the end of the
ib_destroy_qp_user() function which is too late, since by then the
vendor-specific resources for said QP would already be destroyed, and
until the rdma_restrack_del() is called this QP can still be accessed,
which could cause the use after free below.

Fix this by moving the rdma_restrack_del() to the start of the
ib_destroy_qp_user(), which in turn waits for all usages of the QP to be
done, then removes it from the database to prevent access to it while it
is being destroyed.

RIP: 0010:ib_query_qp+0x15/0x50 [ib_core]
Code: 48 83 05 5d 8e b9 ff 01 eb b5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 c7 46 40 00 00 00 00 48 c7 46 78 00 00 00 00 <48> 8b 07 48 8b 80 88 01 00 00 48 85 c0 74 1a 48 83 05 54 91 b9 ff
RSP: 0018:ff11000108a8f2f0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ff11000108a8f370 RCX: ff11000108a8f370
RDX: 0000000000000000 RSI: ff11000108a8f3d8 RDI: 0000000000000000
RBP: ff1100010de5a000 R08: 0000000000000e80 R09: 0000000000000004
R10: ff110001057a604c R11: 0000000000000000 R12: ff11000108a8f370
R13: ff110001090e8000 R14: 0000000000000000 R15: ff110001057a602c
FS:  00007f2ffd8db6c0(0000) GS:ff110008dc90b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010b9a7004 CR4: 0000000000373eb0
Call Trace:
 <TASK>
 mlx5_ib_gsi_query_qp+0x21/0x50 [mlx5_ib]
 mlx5_ib_query_qp+0x689/0x9d0 [mlx5_ib]
 ib_query_qp+0x35/0x50 [ib_core]
 fill_res_qp_entry_query.isra.0+0x47/0x280 [ib_core]
 ? __wake_up+0x40/0x50
 ? netlink_broadcast_filtered+0x15a/0x550
 ? kobject_uevent_env+0x562/0x710
 ? ep_poll_callback+0x242/0x270
 ? __nla_put+0xc/0x20
 ? nla_put+0x28/0x40
 ? nla_put_string+0x2e/0x40 [ib_core]
 fill_res_qp_entry+0x138/0x190 [ib_core]
 res_get_common_dumpit+0x4a5/0x800 [ib_core]
 ? fill_res_qp_entry_query.isra.0+0x280/0x280 [ib_core]
 nldev_res_get_qp_dumpit+0x1e/0x30 [ib_core]
 netlink_dump+0x16f/0x450
 __netlink_dump_start+0x1ce/0x2e0
 rdma_nl_rcv_msg+0x1d3/0x330 [ib_core]
 ? nldev_res_get_qp_raw_dumpit+0x30/0x30 [ib_core]
 rdma_nl_rcv_skb.constprop.0.isra.0+0x108/0x180 [ib_core]
 rdma_nl_rcv+0x12/0x20 [ib_core]
 netlink_unicast+0x255/0x380
 ? __alloc_skb+0xfa/0x1e0
 netlink_sendmsg+0x1f3/0x420
 __sock_sendmsg+0x38/0x60
 ____sys_sendmsg+0x1e8/0x230
 ? copy_msghdr_from_user+0xea/0x170
 ___sys_sendmsg+0x7c/0xb0
 ? __futex_wait+0x95/0xf0
 ? __futex_wake_mark+0x40/0x40
 ? futex_wait+0x67/0x100
 ? futex_wake+0xac/0x1b0
 __sys_sendmsg+0x5f/0xb0
 do_syscall_64+0x55/0xb90
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index bac87de9cc6735c5d25420a7fac8facdd77d5f09..f1438d5802a3e97e22cdb607cf90a097d041a162 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2157,6 +2157,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (qp->real_qp != qp)
 		return __ib_destroy_shared_qp(qp);
 
+	rdma_restrack_del(&qp->res);
+
 	sec  = qp->qp_sec;
 	if (sec)
 		ib_destroy_qp_security_begin(sec);
@@ -2169,6 +2171,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (ret) {
 		if (sec)
 			ib_destroy_qp_security_abort(sec);
+		rdma_restrack_new(&qp->res, RDMA_RESTRACK_QP);
+		rdma_restrack_add(&qp->res);
 		return ret;
 	}
 
@@ -2181,7 +2185,6 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (sec)
 		ib_destroy_qp_security_end(sec);
 
-	rdma_restrack_del(&qp->res);
 	kfree(qp);
 	return ret;
 }

-- 
2.49.0


