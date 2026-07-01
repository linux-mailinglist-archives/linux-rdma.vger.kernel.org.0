Return-Path: <linux-rdma+bounces-22637-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bQy/OhcMRWpQ5woAu9opvQ
	(envelope-from <linux-rdma+bounces-22637-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA876ED883
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 14:46:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QXbGJb80;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22637-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22637-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D77335544F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ABF495510;
	Wed,  1 Jul 2026 12:29:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA648C405;
	Wed,  1 Jul 2026 12:29:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908950; cv=fail; b=EWPiVMj6XIVJA83QAoxW59kt7ya2Y3NCaGVFoXmaECX1D92b5NkRu54TY3E4oxsioDY05G2/9JEkRTN81v09UoBXS+wD677VnHJbEGMWbADZXi9WBbgXxgl5NA6Uh8BIPRj95nO2jRb5p6qnulpN3N7E+pTGRjEnZNxcqkT/Xgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908950; c=relaxed/simple;
	bh=G68jvPrxfaFe5dtkodvNh+eeXGLL7jMijrT08XoMd4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RAEW9grpmB9BA4MTwS5evVrOFV9tr1cv9j7AukReWD7QbeHOYFseiyBmrawuuefXv1vgYvWO+8fBmNIKuUb9zXKDYZ1n/X+jI4ML+b7rbhgLttwVhrtqG63EiwCFeJC9Y8g+UgB/M80wKQcSoC+omQGUC96PA+RrnTNKSIq78Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXbGJb80; arc=fail smtp.client-ip=52.101.53.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ye/NVtaE9IcvnBvCgtr2CIIi636yYBZcmsqUJ4GBuIQpCnePRtKbFVI9SFiHpxOebkRcH7U72G+l0tRGyw1TuqSEeIX9NaNB1Bf+N64VALRcnbJcrIh5JiLXj71ndIVGVuh2IS10YMJMO4Fmp1yuE4nz1zxncMFEzBFS8K0vGBDjDP/96wjdkchHLsE8mwlxRHN1e+iAlRBkNsOGh84OlqwPSDZf7yIwUZ/tK6wAxEVJCaHHftbTrhp1GdWjLPWZt/dC1s5y/OZOJsCW0ZJMM3V7yawDVBObFP9K2txVjsoatYgCOIvPnEG/5Q0FTvdgNlXrgGZ4ZdwscvS1eNTYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKhqwm2DpU7bXnSgF+DhtmXjX3MaFczDF2arQ0aO+GM=;
 b=GUSy8ef+W/qOLEjg+pZ63lpAkXq4NXMwsVjRRmOGeFzh1+vdlcBdg1YjK7M4KDnbwk2/yc8XaAYWIUGn5y5gkl+Ag12qdtLRZRTZUdarMkjY9dwKrpDfhDFvQtaocFRI2oSGcOJQKEUpTewUva5JOMBmAQ8fRwljtgbN1RdHm/97Voj0MJyYjV+8A4+e1fIBENxqcsyPagbu0yMkcWO1l4dVHT2mxoEBJjkCcw9ggPDOP25y2dR6jLYyka3dbIXS+ImCFR8Z6udDYpoCUQqjkHdN6wsuXMZHP2sUFa5P4YOyAchMXEcGGZrdUOFP9F54kpifaps+dKfekoKTEDGFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKhqwm2DpU7bXnSgF+DhtmXjX3MaFczDF2arQ0aO+GM=;
 b=QXbGJb80XYJGWYd+Jvt6Q4wBXPreyotu4STUkeAau8HeGCo1o7TExsBtjUK7YddB363ImWc5yW/sGEntq1NytFaVqI6MZ+xvbS0ZgQd8Mz7WwMly5pk7bk9wC2ikVwsnw+9Oqr0Cd25cJ9mIAsrzJy9kmmvEZdwfv5HBcY0R2xd2hHKz5xlYk3xjmdOYjp64Xd/5h8N8aYIHEZbqRr9cBGuzgUZjMcRq1m2G94SOm3IOgOjAixFF3MGg6EXJhmDLPFB8wxKiKzxSx+DDjL/MpZlu2WqokZG1Ku46cZ6/Kd4DL9uckOXoCEs1w/COeJIC/glmy4BJnBu+dCECGHghuw==
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by EAYPR12MB999133.namprd12.prod.outlook.com (2603:10b6:303:2c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:29:02 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::11) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 12:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:29:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 1 Jul
 2026 05:28:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:28:47 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:28:44 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 1 Jul 2026 15:28:16 +0300
Subject: [PATCH rdma-next 2/8] RDMA/core: Fix use after free in
 ib_query_qp()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260701-restrack-uaf-fix-resub-v1-2-c660cda4df2a@nvidia.com>
References: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
In-Reply-To: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>, Majd Dibbiny
	<majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=4122;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=R+TRYIhig8ZnX7DJg94i7NQ/zE9FbJqiLhmVMgk6PbI=;
 b=heAX0k3ekJBunDIn4PEGZVZK/E9V/1Q4Qh38EkVfh0I+OYyeXTCZKchv0wvw5mFgwSvZI1vpy
 u2RgQRqYJbtDAGYAPA6/hFVJ6FPMHyh1qy6ynTXuRrztl9ROAFp1LtM
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|EAYPR12MB999133:EE_
X-MS-Office365-Filtering-Correlation-Id: d65fca0c-f8da-4fe2-1c0c-08ded76c5540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|11063799006|56012099006|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V4PacZqmIZJ9cDL2Sv6L757bjqDU7q8nDf+82bzFmEwSFiNa5Kd4ohV6Y/iuNm9gkjBQOlYqn/vYEYbOZL4krJMd4SPrUK42lv6xe+wajLvVMoS0wlQJvkU4NUcj+D4vjPZARe6USYbn2TxttZ8uKu2fwpu54VOdix6wGI8ZSSizR3x5VKW7fvCFioWpfkb7BzE/LAQx0dbVbUThLvpFG176RPJMAyZLU6kPx0VuXzVpIDq50johUDtJZB1zXUklc2wdZFlOkex/c5OQsHpvb0Jj6e0ud0VbQL8tAsazy+V9rVBTiqE+3FYxDfDF339U5KALNg8hwaNI8627qFYPIi/rI36+GVXLLkol1ELeaLNWCE+ujuEJHXsah/jR1xnHmks+UK1RHp6bGfuE6FvKcoDD9Vf8jyxjfhdSkJHMZM+RP5nh6AEs8yN3t9lp+AVTAiYekE2ZlyGlrgAaxFCZpMDapWkvmf6BnonewJeyzJDQWK6NXMDCHtfoKvrJzXw4BnFRAL15g5tJ7ZJWkbU1SxWny1oCz2Lwn5Hl44zmnUl3EoQ2gGYxE0wz2Xg1rI8ihiQ8FvLvp5Ifc/D7rIt+/aWK362wImfde6iafkAcLOS7vtuagVM9SEKaUiZneGAVC6elaXO5ocuQqguRN9xZQmWjeOiES3a4BFQgjfi5v9AAa/305n5+PAGRTMiKnexZsNd3K6QCh9m9rF9MRfhmgLSlWNUJYbEqxUW6Efmg8K4RFszvtssKmtGa/aroOzds
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q2OHg7nJZ2DpkvBf8dlVLxTVEteiZU+cjDWdZbSVyN7ymdY+y6UpjDI92g6KKy9Y76v8mt1kZcsdjOtyGtQ/wGxoKTlho3iz/oieWYjSK5U4wbBqcFF7wcz/sFied0Zch6lU2DTMzdWkwYA+3z/MLv1NHxick89ArKrjP78E17dHAajsnvnDw8YIfKOiqwSg10TQBjrove8fKgyz1AHFGLfdjdu+G76uMarlMHN0MQISbjVbG06X+6qiG4dLj9H/BPTzhFZ9yI+Z76/mqNBWfUSfPgstatYEhZk4BgjUgzCRxBmPIaQvMkIaFP1LlV8CPK7xY8XhYz0P/l5pmqA7/BgFHQUXmrl2/E0WFO+6Zihww39bXXGkp6dOv3ObLP8fCnj5DCeLt6HvrXqN59Y8V0Cgz3WdFl/XgkrByKb+uRkVvSN4sMXtwihoyvNsy8rc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:29:01.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65fca0c-f8da-4fe2-1c0c-08ded76c5540
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22637-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EA876ED883

From: Patrisious Haddad <phaddad@nvidia.com>

When querying a QP via the netlink flow the only synchronization
mechanism for the said QP is rdma_restrack_get(), meanwhile during the
QP destroy path rdma_restrack_del() is called at the end of the
ib_destroy_qp_user() function which is too late, since by then the
vendor specific resources for said QP would already be destroyed, and
till the rdma_restrack_del() is called this QP can still be accessed,
which could cause the use after free below.

Fix this by moving the rdma_restrack_begin_del() to the start of the
ib_destroy_qp_user(), which in turn waits for all usages of the QP to be
done then removes it from the database to prevent access to it while it
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
index 3b613b57e269781e94e9d63ea75c7dcc46b1dacb..7abb89a4e6a019b965d36446d64609ed2c33d1c0 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2154,6 +2154,8 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (qp->real_qp != qp)
 		return __ib_destroy_shared_qp(qp);
 
+	rdma_restrack_begin_del(&qp->res);
+
 	sec  = qp->qp_sec;
 	if (sec)
 		ib_destroy_qp_security_begin(sec);
@@ -2166,6 +2168,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (ret) {
 		if (sec)
 			ib_destroy_qp_security_abort(sec);
+		rdma_restrack_abort_del(&qp->res);
 		return ret;
 	}
 
@@ -2178,7 +2181,7 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 	if (sec)
 		ib_destroy_qp_security_end(sec);
 
-	rdma_restrack_del(&qp->res);
+	rdma_restrack_commit_del(&qp->res);
 	kfree(qp);
 	return ret;
 }

-- 
2.49.0


