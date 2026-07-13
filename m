Return-Path: <linux-rdma+bounces-23140-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Ht9KLQGVWpbjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23140-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:39:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5D374D26A
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:39:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=sUBDUJ88;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23140-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23140-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D1273011C52
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3AE36402E;
	Mon, 13 Jul 2026 15:38:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF6E35202C;
	Mon, 13 Jul 2026 15:38:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957128; cv=fail; b=AmLgJZ1ZjLXMxOOkzWVQD6DKB4pfyb2UM0pa3FOFsBiWPyeL7H0Lj2L9aAJsS/2V00L0j+CMW7w0se/U6Q6Jb7fSZ6hnM+6eR3n9VkUm80ndoy/uPiR1Nk+n4QmHqskcAQ/u5oQCul78nU/+ASwTlxoeY7AvHc7JP8eUJlgNYzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957128; c=relaxed/simple;
	bh=G68jvPrxfaFe5dtkodvNh+eeXGLL7jMijrT08XoMd4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Zm0cQ4WS4uZuFzL8ikntyi3WEo/D1+Lws1u67uxXBF3eGtWRieZ25yERSouRmSmIjZGup8Y9FtDNLMDQ6vlPXk/0H53m9Ve979yuBfjF85C23dEyWZdz1Jd9A1A4H6XydMwkeArtf64qUGixa+Rypat6ANu1MfJ3bbVAz6auDZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sUBDUJ88; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeTtSqRPTfAlm7Ebgp+1S/sZ5X2ILr0CZ12WdaKmIf+FkzYMfYEXPPEZskcrHLoWxu1yjvg7V2cPQDyyJPp23+k8gxquMjnvj+QxdA17wqmZISFEWvEZIGIs8SWj+wT0QyeON+v7rjNkeG77UsWVEjETVwB2hUKqL2AGYP70Vx2tKQpPJmtivzWC3QPdyyVSTw+q4Ebu+AOdhacG8tmhW01TO2ivNB/gKSTCjiVpJ14/vs/oScQKkepIunhwLgHRTVT+BmL7rpZd5IV6A90zVqPBAoLE13klebIvdLhYYwkMl0k17xkHGrH5KTkrUceOqimSBXxjdMKKOIjLcv4WQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKhqwm2DpU7bXnSgF+DhtmXjX3MaFczDF2arQ0aO+GM=;
 b=EOPW0RQ3DO+kXcp6Gfr6RrEq4WksnbsSW3eMPJTCv2Ap86/Bb7wIsIZbaQl0CfSOHhoobNI0EwlrujYKXJw7MplTxI5klNbxQdWTFvulcmDReDKa57vOIRDCW6Os6QngCDxS5NZjJHdzcmFB9+5mwuVWBBd+1UTqCVX5i0Z26oZQZfyvMRV2J9IGlEcGa0y+QP1bm4EaXeiqPK0KofWamCAfEV1sdNnQN3qPXZ4U82X1TBqUuwJ+tFuPDU6UJy3XAjl8iYviwx0ksAX8TgqhJ5cPnHHC15ty16xmW89ctTo+LrZDjAk5rCBc1dEAXN4UjGyF2oBA9QeIAZK2IVWeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKhqwm2DpU7bXnSgF+DhtmXjX3MaFczDF2arQ0aO+GM=;
 b=sUBDUJ880qf1GU6ny4OgCq+UL0DssyU3GbYiULTl8/ZDN1SNvytxfnCMw+BmsD2sDEMP1yKSDpfAnixb3gEUs8SXys4sb/UmyIipQIfqL8hpCHdbBOuJ0p2ee7NpUXAckQegLA8ci58HKFfDm1R2oM+mzYkB7tsyJgUjLzvXzdI6xq3BzmGsaBZV5iYfkTOkh3Fca5vuddmbtMa4TtDBu7CYD1HD1eOs6yHsX2Wdg4QoTmNzXW6jTmaukbg3CNGVllOWf7N8nbDtdH7R4jTtUDsm/neE4PKmexOR24Wb+ZAmbM/p93mE0gFZZiOU0xOc4+byckm6Nla/ljeHhB65dQ==
Received: from MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 15:38:40 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:23a:cafe::87) by MN2PR03CA0017.outlook.office365.com
 (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:38:39 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:18 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:14 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 13 Jul 2026 18:38:01 +0300
Subject: [PATCH rdma-next v2 2/8] RDMA/core: Fix use after free in
 ib_query_qp()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260713-restrack-uaf-fix-resub-v2-2-bbe8bb270d51@nvidia.com>
References: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
In-Reply-To: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=4122;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=R+TRYIhig8ZnX7DJg94i7NQ/zE9FbJqiLhmVMgk6PbI=;
 b=rrRd1u/cSqO11//7Ps8QZ/8Ye7oOE0pKmdsRBGatqy33Z0si7+pLIv1E9MEHG+jAkpdWlfp1T
 JZngl4RQQREB5RlZ9Td8GB2uNA/fAFsF6/fXTUKhi4/4G21HSYgEhtU
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f26ee8-c247-41e6-525a-08dee0f4cfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|6133799003|56012099006|11063799006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IEdJMb3Ly93MtsidSWx912coPidCj9oB0vEC7W9Shi+LNxU3o0cCBNLCob0Qgqgbd/AhDjqrEdIL/qaz1GJ4by29v2uIx1ZSz6ek9FzZZMbDynMtQfF74Z/4w5T7vyQlJYnhm1T1WmQTYirRjc2xLLSVLHmCev6ePPOuKXLnR4YrPrBstVV8UC2e+OK7C9ghirJM+RoprJ/W+gnQcVL1oO2IdtkWaweer2jaC9ARrHzy/seAtyTjxbnwHYqiXktYa9fE6qwN3a2lCDALOCHZfIxNzXQ9KBVp6OeNf/C8MppGm4pfMRMijWMgf6cBwNqSB93/q5M/PbRhZptki3v8VYBsW/cHAGxWN9IkZ8yohBFDPf6kgh//toqTUk95c3djn07Dh9PzlForRwvxFUVXg0nq7sZwPAHZmL9o9J+LoO235O7iCSF470bZCwb/o1rMQ20UdoZMQOeJabTQz9xOxtV7Ngy6MxjqtlroQhnL8nMscxBRc4uw3iDzr1H/BKOuqRD+oloiD4YrIUrbldnmDhkpGbv47vF8DS3rhQkmyPJqkNn6OL/z8NJNmLDgJfUQTcrtkKcgyI+pboCXyVMI+nDLRsbMV8hrJbJuwwXG3+ZwXSroEccLgJFs+cjIT5bxhAAHmnU+KvLXrYeav4of2+G72rmzBFkW2FPXfwdDKbU8FQvJ63un/I+8UxBBgNZKxBi0xOcOLPeZagoVFdQCDkEj7qJKbVhBJcZe2/y0T1OSNgWCCEvNWEsaUmwS8tkG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(6133799003)(56012099006)(11063799006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NHkapIbrryDXDOoD/YAwuONGwc+jHR0dBUm7PZeKA2+i7P0SCcij2m0asIWVXS6lcP5QdtDvmpwS4gwT0H6ngHedzcOHngkr+KBK1/B7oK+TUib/7i6D9xDzf5aggLDjqvlCQf/bj2eV8eTQhkLnNRwkaWn7R2WyWEEPVUiGURP31DVnmO28BNCIzRftpTkoVAyLcdISciCu/gZbl/7tiBIGnPnaJYZPCZS5jledMABCVnfwbxr3rXfO9w+zg4ISrbpGFoZ519Jx7GY/bw6StWN4L1cz2/YcgUcPf+HpkoS74GUqJ4iRHc6KQWfKeWPY1t1gdqUMfdYYZpygRW3NdqcsoCzTSJVFhKO/UWcVtYH0RNMtoizuFdIpPUannRzkaq7USNlCuaGYoRilWR7NtC9RXCY+VXMwgJDLwZLvgFyJakaDSSYO4i2OSLt/beZa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:38:39.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f26ee8-c247-41e6-525a-08dee0f4cfc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23140-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B5D374D26A

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


