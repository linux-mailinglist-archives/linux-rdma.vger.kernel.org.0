Return-Path: <linux-rdma+bounces-19020-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IuMCvV502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19020-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:16:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDDC3A284B
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63C89301C680
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080D31E833;
	Mon,  6 Apr 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b33bTlhL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673431F9AC;
	Mon,  6 Apr 2026 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466753; cv=fail; b=CCOWKVWDTEP5YIxVbMdwn6YIlkej9SeyaoCJWLEwB/Q3+FzdlQ7YJPtB4OdIqa0FGbVdislsBkMuDu2lYzGdeVBKAovScGZssjrnIjDmainyO1ftKEu2k2IG2aLF512LGKfNDKmGvvIwU+gnyWsZ0sbVq1io/ebmyxI7kLZnJBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466753; c=relaxed/simple;
	bh=pLtveQ9h9fAit3VeDerFBCBbRTBmXfUqieTZB5hUxoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BcW2F3vMwrgHCkud6vV9DU60Vws3o3v5on250qgp25RjjhDkFis5MkfF74wUVIHCufNEXWQ2W+q+AqHItBTLAk7vByGMULtGvGL/OQ3A4xSOZkPuR0QVDFOwO+DeOK+W485FD5i3sJLOLqQUyptzx4k1SRSSMkJF+5m2qEbH7mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b33bTlhL; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfF7npsRXuMHUH6jEtpI8f6JNBKpye3zzfMUwenFPG+SOzTpDiJPKSwLb6HntlThtL6W48QSedbqCfhLf4U2cifJBzwBfkQjNusdXk0KbbtylKR53Et4fARauuCyuBwgUR+K7G1DY8jUZ/s/5vMBBVmZZJ20uGRZAtxgS8/xfplV5PMMgk8CRMF0suMOdVimX9TomYvqyjf/eZO7vEDAbuMHzDrD4AiDJUnHjbRSNyf6c6SUsYBxtuEXYYNoMSVmO2g+otFHJmYWRIzieTOJ+or4/SO0qwtson/AEmo2ClFeFHpZzEi9qaf99RX7tQGiroumEq40cx5hkst8nQHZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTrjbWLFtoKEY6x9h5QzjWnLgD8OKYSUw/KIlOVmPO0=;
 b=th0i9lr6SQ33kKfdh+RhVx8nC6o5E9TeIBk+wGxRhY4Lh9H6Q2GJwwN+XWlPSc+7J7yWOtCN8rTYhcVzDalcC4wDa0ojJHtc1BkVB014jkgRh3ZPFHDGnS8/UBCzSyTYvpzW7qXFWSYzkk8iXxJZ2fNvsAcinvSR5RjNaVDinvrLQ1Y5z6zFWzFxGXhnuLfRlNOeA8OR7NzJGqY4as0hwdt1JBMvsn2j2HBgI4c8BB/7CW+3WkUfqZ8Y12yJWhkDGQQBTsdBcg/jEOTR8hoHriUwk/eg1leFljkYTF0yVEKG9F8bISJEbYKs0bprUz2i2hzngoEamjtnlC14T09W5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTrjbWLFtoKEY6x9h5QzjWnLgD8OKYSUw/KIlOVmPO0=;
 b=b33bTlhLHNkpc+smv0vaGGQOTzg0JWC96zYTBDm3itKRh14xZk6XHdQXJw3OOeJ3GUTy7AQEEttCWKIqQW1KeOxsLkCEkt2UCYS11kFAGDaS6eCzq+TLP+FQQCi5j5EbKj9anl2T3XQLnlOYOi/NJPKLHejB1fO3wqmWSh6HBbB2cWUrAf9IMWTcZ2P5FNX1rHwR1tf/FyMPQajb5miD0CfuOQiNaDf39O4VZQfeqZgyO6I2oG0361dDgCXJo8yWziEJ/WmvJ8geMyXAECTQO+M6kOHKgBx9FH/kmtkOBmTtQZnP9hkQ4goect7czXY8iB/1k4W/pLRCxl4JMr2R+g==
Received: from MN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:52f::15)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 09:12:26 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::e1) by MN0PR03CA0008.outlook.office365.com
 (2603:10b6:208:52f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:12:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:12:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:12:13 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:12:08 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:22 +0300
Subject: [PATCH rdma-next v2 11/11] RDMA/mlx5: Fix null-ptr-deref in Raw
 Packet QP creation
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-11-ee8815fa81b7@nvidia.com>
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
 Srouji" <edwards@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Maher Sanalla" <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=5376;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=JtuYJg/MOIrpokiPmX/qHe3Cu7+SE4t4BwgkYUAL86U=;
 b=S1er0muFvFA4eV44N1h8yJyvChMCTUxKrC1/Zs8PJqzsplMIyIobprwlp+v04W5HP1QG4gFeF
 T1ZZPTWXCM7Bp4CMr2JZFqsExuoefnYPvCG5GG3I7v/5czwljTQZusa
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cd573d-7af9-4241-5a9d-08de93bc9f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lhVbmS7QxxNPnEd2trSJPSdU8D20g/M8CpPGp/9NCQkSCATSpkgFqTeZwPtEe7pMe51hxeWXmFuQPLHOax7OlWXruIkUTR5tNZSSFRXwBL3tTOUgDMSevifmaGD+N35XG4qRbB6HXlHAp8/xhKVHv2SL9A+VGXR6hBV1Z201vRDSTDOnvSmi1yRiD+xIW+v630GLzerpraOb9uu6fyGOo/ehudAfTnRfZxTrmz6soop2PdVQ8+GbLfJhUY8nv9Q/sB6pNwgFn3oZdQC5YjJ4ScjT0oWsvi86NEITBWwrhITPFRweCsmKrQcsYF2rzJImEHikZ5Jp4AvNXEtnD2kLK8ItvhFmV7hmwtjHDwlnKjb4sHXxK7j0k/2pukVIgspjPBDj+Jk6/a5Z4qVCJC1661koNVkXUTbZKc9sh+7HL0wrfm4XQEpIbInMmw1LrqT4fcYC6yweaKe095/GKTRaBQAg3+j78FXleUvwWL2FANLdOe0y25s5cM0XbbtVGN2YqkVF2t8BJxG7CkgUnjkYxYKL5ehqf1orStxLMl6FbsF0RNXtD4HfivNYXS/FW/ixAI3datcDxB/p1Qs8eFhQadZB/yOZbTkr824AwqwiFr+6ullagYE0gu0QaHM/o6f1sg3JL74CT+Opl7KfQQdF2u6BUIdbaXQ/dKUhq/BgQBPYbAuZwOF9G2XIgVtpfiOrL2y77wIeYdiVDr5kFW85Nx90fQjGONwrerFcbZi/A3BrF8Zh02Ugu2VBMv+pLqvGz/UUUWeRMp3gDqalgdhYDug0Ogr2cTHxGzw8NIJbtExQ+pmhvGhJnZw2+bhuRqnx
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lQ853NCBt9OPWkLbzvurfn3UX+OGzGgUKHill50ZL5iXjwTt5X7G/lNRNyiuJcSrMPLcDqPG1shHcRJbGXuC46e6PuCx41e8Fv1+iUKAsUIIy4c4Up9DAbMSlDOhfXv67Vt3yK4a50+BoRsEtJnyXzhi6kDF9MjdRvrvRgYhOzzU0yDiNZ4TQD/OUaQSnxqv6+cJm51h6xVyCyJv6zSNIXOr+2W8SWbzfPSexx1NNg3+SPw5HlJ1gbqW2tk062ZmwGY80AHDqpnx/44gLmGabH33pRkvno+cNuHq5N4vnGtSnZ8FOW4ziFye7qU4Qqy1Ji0zlUuSJe7i1Fw6KxMOdGILOYM6DpwGngwAz2ukmwd0OTAKJ6auo45IhqtPciUn1betEKfMekHWy/3G03FtDMLulxV4276hsnnCyA52uKB3IS3OPn0sLZg5Chwsvhcu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:12:26.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cd573d-7af9-4241-5a9d-08de93bc9f2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-19020-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,qemu.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3DDDC3A284B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Raw Packet QPs are unique in that they support separate send and receive
queues, using 2 different user-provided buffers.
They can also be created with one of the queues having size 0, allowing
a send-only or receive-only QP.

The Raw Packet RQ umem is created in the common user QP creation path,
which allows zero-length queues. Add a later validation of the RQ umem
in Raw Packet QP creation path when an RQ was requested.

This prevents possible null-ptr dereference crashes, as seen in the
below trace:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
  CPU: 6 UID: 0 PID: 3539 Comm: raw_packet_umem Not tainted 6.19.0-rc1+ #166 NONE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  RIP: 0010:__mlx5_umem_find_best_quantized_pgoff+0x37/0x280 [mlx5_ib]
  Code: ff df 41 57 49 89 ff 41 56 41 55 41 89 d5 41 54 4d 89 cc 4c 8d 4f 30 55 4c 89 ca 48 89 f5 53 48 c1 ea 03 48 89 cb 48 83 ec 18 <80> 3c 02 00 44 89 04 24 0f 85 01 02 00 00 48 ba 00 00 00 00 00 fc
  RSP: 0018:ff1100013966f4e0 EFLAGS: 00010282
  RAX: dffffc0000000000 RBX: 00000000ffffffc0 RCX: 00000000ffffffc0
  RDX: 0000000000000006 RSI: 00000ffffffff000 RDI: 0000000000000000
  RBP: 00000ffffffff000 R08: 0000000000000040 R09: 0000000000000030
  R10: 0000000000000000 R11: 0000000000000000 R12: ff1100013966f648
  R13: 0000000000000005 R14: ff1100013966f980 R15: 0000000000000000
  FS:  00007fae6c82f740(0000) GS:ff11000898ba1000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000200000000000 CR3: 000000010f96c005 CR4: 0000000000373eb0
  Call Trace:
   <TASK>
   create_qp+0x747d/0xc740 [mlx5_ib]
   ? is_module_address+0x18/0x110
   ? _create_user_qp.constprop.0+0x18e0/0x18e0 [mlx5_ib]
   ? __module_address+0x49/0x210
   ? is_module_address+0x68/0x110
   ? static_obj+0x67/0x90
   ? lockdep_init_map_type+0x58/0x200
   mlx5_ib_create_qp+0xc85/0x2620 [mlx5_ib]
   ? find_held_lock+0x2b/0x80
   ? create_qp+0xc740/0xc740 [mlx5_ib]
   ? lock_release+0xcb/0x260
   ? lockdep_init_map_type+0x58/0x200
   ? __init_swait_queue_head+0xcb/0x150
   create_qp.part.0+0x558/0x7c0 [ib_core]
   ib_create_qp_user+0xa0/0x4f0 [ib_core]
   ? rdma_lookup_get_uobject+0x1e4/0x400 [ib_uverbs]
   create_qp+0xe4f/0x1d10 [ib_uverbs]
   ? ib_uverbs_rereg_mr+0xd40/0xd40 [ib_uverbs]
   ? ib_uverbs_cq_event_handler+0x120/0x120 [ib_uverbs]
   ? __might_fault+0x81/0x100
   ? lock_release+0xcb/0x260
   ? _copy_from_user+0x3e/0x90
   ib_uverbs_create_qp+0x10a/0x150 [ib_uverbs]
   ? ib_uverbs_ex_create_qp+0xe0/0xe0 [ib_uverbs]
   ? __might_fault+0x81/0x100
   ? lock_release+0xcb/0x260
   ib_uverbs_write+0x7e5/0xc90 [ib_uverbs]
   ? uverbs_devnode+0xc0/0xc0 [ib_uverbs]
   ? lock_acquire+0xfa/0x2b0
   ? find_held_lock+0x2b/0x80
   ? finish_task_switch.isra.0+0x189/0x6c0
   vfs_write+0x1c0/0xf70
   ? lockdep_hardirqs_on_prepare+0xde/0x170
   ? kernel_write+0x5a0/0x5a0
   ? __switch_to+0x527/0xe60
   ? __schedule+0x10a3/0x3950
   ? io_schedule_timeout+0x110/0x110
   ksys_write+0x170/0x1c0
   ? __x64_sys_read+0xb0/0xb0
   ? trace_hardirqs_off.part.0+0x4e/0xe0
   do_syscall_64+0x70/0x1360
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7fae6ca3118d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5b cc 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffe678ca308 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 00007ffe678ca448 RCX: 00007fae6ca3118d
  RDX: 0000000000000070 RSI: 0000200000000280 RDI: 0000000000000003
  RBP: 00007ffe678ca320 R08: 00000000ffffffff R09: 00007fae6c8ec5b8
  R10: 0000000000000064 R11: 0000000000000213 R12: 0000000000000001
  R13: 0000000000000000 R14: 00007fae6cb71000 R15: 0000000000404df0
   </TASK>
  Modules linked in: mlx5_ib mlx5_fwctl mlx5_core bonding ip6_gre ip6_tunnel tunnel6 ip_gre gre rdma_ucm ib_uverbs rdma_cm iw_cm ib_ipoib ib_cm ib_umad ib_core rpcsec_gss_krb5 auth_rpcgss oid_registry overlay nfnetlink zram zsmalloc fuse scsi_transport_iscsi [last unloaded: mlx5_core]
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:__mlx5_umem_find_best_quantized_pgoff+0x37/0x280 [mlx5_ib]

Fixes: 0fb2ed66a14c ("IB/mlx5: Add create and destroy functionality for Raw Packet QP")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 69914406156c448e9f1cafbc8165d04e120e36bd..95229fd3627447510dafcc798c36158ed6991233 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1603,6 +1603,11 @@ static int create_raw_packet_qp(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	}
 
 	if (qp->rq.wqe_cnt) {
+		if (!rq->base.ubuffer.umem) {
+			err = -EINVAL;
+			goto err_destroy_sq;
+		}
+
 		rq->base.container_mibqp = qp;
 
 		if (qp->flags & IB_QP_CREATE_CVLAN_STRIPPING)

-- 
2.49.0


