Return-Path: <linux-rdma+bounces-17765-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDDrCOOZrmmqGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17765-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:58:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F71236A8F
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5033D3034654
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D83859CC;
	Mon,  9 Mar 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sC10SmBR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE11385504;
	Mon,  9 Mar 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050151; cv=fail; b=KVyM06wnZvLgpU7H5N018JcIWjd/kB79ojCsjf4hyzu7OebeX7muiqmYp43N3jh61Aw0IQVsyzLard167UFhLJLUHGLP5DP4pifj/46+TFfjBrMzG4Jw/CwejBD90rLKTvQ9UIwk4qwTElc34JqxIMpP1BlhFaiLKf4f72IVWO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050151; c=relaxed/simple;
	bh=1O41SHcC4LvyAQDLBSLdRGmU9ot89RbTX/D2TMCIBxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPEKZ1/dptGGahBmZhg/H9LqUq23jfaYeTH8oT9WPE9uQa+zjX2ALWTnZZkC8Rt1XWoDmm1FQr2b58moPkAiffRHeaN/fSzqNY0ZqpzWcArL+RHPp6TEGzFhVFF7VNYeObfYvTco+znk5W0xIofx2or+mCJu4hqQOoSd7RZv91I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sC10SmBR; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BirunzxhqKE+CNM6ok6SLlOPiz9/c9YM6sFInGTCcfkzyfkYVCYzoFlplm/l/HmlX9lrycNAhVNR0lMcKilsiobPpX0JPRGXYkgA+h0LEhGUdnAgrF+waK8rm7rAIZNTEThzzIXPC1YVxonBo3AyRDgcgDRwuA4eIw0Y0O2rOEo1VJavbTIJuPYexyWyu35d4gXbcCxdqa0rwRmflLmEZpINyU3FOyTOkEQWXWBhAQkHcEP3rmhiFMT5a46Lg6+5pVhR0XB2gg3yGtDJnoHyeR/uQGepXEnc9faomrHybTEeIFdgRsMxEASQx6h0LMBVmI+xMlmdM1KiLDG0fZ29EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92Icpa6FjW3DQPJ43H6fnA92LMMaAZMg5Se354nve6Q=;
 b=HYMA7XP4f0eFo84ZYPRlmIvQq13TNV40ATziDuwOzlaPnpJew41ZOgt9xEIRKw4mWb7XcIpAe6QdWk6XwaG12+9Xhq1RZaC310bQBla/hYLSpfb5aDsrnEkqW6bVwf0ypviVvKok679y/hxBtEYxaKWTVqTH84yVNaWu+9tudYahH1PXH3dWjgOARYtvqf9kSCxI9976UygPo7aHo9EdMyR76JNp+Uj8mldLsbRxHdx2eL61UW5VHtzJ3YZrI+mwyWXCG0ApsNRw+ydHwpVAs+7c37QLMTwok96kRY91bwjYPSOUT7F4Mm2nbeWLhVrf8MRniqgLZJaNHmm8Yz2edA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92Icpa6FjW3DQPJ43H6fnA92LMMaAZMg5Se354nve6Q=;
 b=sC10SmBRStL0jEHdnLhHuuV4bTLHescMYL4xSNDS7v7/z+Grs2vpHpheSCxln/PNs4I64OHfC8ZIbqveNYEzwJnm7KhVSG9lbHwZZ9roHv8jQvLCj73VSfJPe0owgXfPqT00GD/wks+S659RaV9810VYqk7gmYVcdgiOkHFMz4q/1axcw7b1bWLisQt3rr2eYbWdyiCExpIgjPjQStcytoZXaY+c4qS/IJkRLF0BGd8lmNHmZ4E4B61XqS1yAy28GOoULcoytoDIFeN6OTSuzLd7yDmL3yFhLFcyuk9HIg5ZTLlzmiv820+c9sC70p+zzjIouQWoHrIc+7V7P6iUDw==
Received: from BYAPR11CA0051.namprd11.prod.outlook.com (2603:10b6:a03:80::28)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 09:55:45 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::12) by BYAPR11CA0051.outlook.office365.com
 (2603:10b6:a03:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 09:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:55:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 02:55:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 0/5] net/mlx5e: Report more netdev stats
Date: Mon, 9 Mar 2026 11:55:14 +0200
Message-ID: <20260309095519.1854805-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 19389320-02db-4672-4166-08de7dc2086d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	44VWZlrRWcsBxXbxziaa9mIsto7Nkup3oJAST4jXezuScBVsYAvAjD8Iee9cGOxO0jkYtf/uaBrk0JWdOBSQFn0M1NS1M2PW9/X0WZztbJua41P+2kZjxgxUUSC8jD8WLbUE6pE4bFDPxGYY4QFBKL+23Hvdu+rO4kjHB1Ly1fU7TXoNqw6yhTV298RJ5DewE18E/BnSliJinLitT9LedbaQVfTILzcZRZf1o4G0Zy1X3fQiOCAXPcWFed+1Nh56pCHv2xpzygyEYWAcxJpow5lr5DPTk5v5VQLgMtJyeYVHeSUL++m/qUx204MhmD0FdSaR5OZZzlnIvjcRXv03bqynxUxWTlMoQokfd2fjyz7TvPPw/ZbsD7BGeqC7N5UtsHW0AbTwzwxcTimAd5wOhrsDnLbVb9vfEIWIPBaRYhKX+Lb5oJdKigAnBBk8kbXDo+c1DIV3h2HfZ4cbLfUzjNUaVPEUUQlDI1sZp+858HDYqu3LsN79JZLtxHA8jOx+N8RyGvozqVwxnlK4EPXB7FHegXCiEIzzfMvrkUe2UNT4o+1iM8lGgjbe0aJ+YLbmiX73NASRg+0LhHnVd+TTQ8Hcp+E+NyhikizLCzpiEG+J2ZkWsn6yvRPb2ASF5c6yP0RgU/x8AXKLAUS2IiUzxWzZpzt1ltNgr9ucF/XvypTC4b53leJZMUhRQJXgaMD5oSFcUNZugogPoopiRu4sajKn31jQbNfeVr38ey3M4wRJJOBoxJzmSZ8NoluOaJy5xEGxF4a0hshdinfvTYkcRQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rHOBhHnGo5HsCUcx5QR0e2p3ZuaXwlWQsi+FroAjmm5rVXYYP2/4S5oqhgVPZWoJbtCJOvD6Qq3MdMDMYc3l/YYWKd7ul53ggUNmyUJpR/ENtJSgrwT0xO+lC0OPfQ8ilqbR9rZwS07Em6zcw4OghoW63GxBww9dN4MPYCunpbuPYo+takzVifr3b0rAPPfo86HAj8mfDIxO4VAM1HDluk10bA2/TI0vz8bJDb1veToBf/cMHPu/fPG0ZrG7WFfZuPBHhLafGwlnDI2CA60oY5T6gzGU6dcC8MEeY2Oas3zzX4uk1MZt8wH4/6giZr+7tCHadqPvFs5goPx4dKQ+GJZxKdb5x4IcW49aqu5MfNKKT3f1Bh2KnzPpvgGM98qlLLK1AYebkj6Uh10eU41vQR+BrsrdN7S1WK4nIz7cWSFV7kgaFzoZLhrdICpxfxFY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:55:45.1399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19389320-02db-4672-4166-08de7dc2086d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
X-Rspamd-Queue-Id: 77F71236A8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17765-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series by Gal extends the set of counters reported in netdev stats,
by adding:
- hw_gso_packets/bytes
- RX HW-GRO stats
- TX/RX csum
- TX queue stop/wake

Regards,
Tariq

V2:
- Link to V1: https://lore.kernel.org/all/20260204193315.1722983-1-tariqt@nvidia.com/
- Fix GRO counters of patch #2.

Gal Pressman (5):
  net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
  net/mlx5e: Report RX HW-GRO netdev stats
  net/mlx5e: Report TX csum netdev stats
  net/mlx5e: Report RX csum netdev stats
  net/mlx5e: Report stop and wake TX queue stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)


base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
-- 
2.44.0


