Return-Path: <linux-rdma+bounces-18970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEXNC3+Ez2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:12:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA5392A48
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A827F308218F
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814D3845BB;
	Fri,  3 Apr 2026 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S/4YtNw1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEC23D7F4;
	Fri,  3 Apr 2026 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207424; cv=fail; b=BHdYbcLOtF7fVk1oB9sO2Go5WkgczvTOlvRdKErc5WcAjcP/rgplIJ4h39OlLJ6RwZTvbH1SMuOCi0qMd4c3PvYL+YJiFO+egi3MDUSN/lpBa2XFtQ0CvHNsHliJAyEM7boNaqvcK+IggmcdbueXBS2nz1Xwr70F9cbXzjpcRbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207424; c=relaxed/simple;
	bh=Z2xVnxoBnxt3yStri4QcQ/KcXrls1x8ofQiS8232Ko4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sMfEpltXriAVqnrMfxyOVDU7+zuku0R+bzP6sXxgeQ9ofbasUTFD5lkIkq3ve/8MHXsGjgv04+6+EzyCMSeEicxEhTelbKmHxAZjrycUQPp3HDv1w61CRs2ab9Dm48OjIz/s7XwuW4Nr0V0M44WafvALvPIdGAImfQE6VM0Jhi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S/4YtNw1; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwsAa8Y4J08WxZh/gtE+Ia4WUS8PBpW0+lpVclq7nY1nQXaXdIpW5E5idp8V2d6ZWNZKh63ZR7xbSqCENb1vk68gnxm9IZzYoJM7aeQO8rWP2ilh0i/6Tu+Zviubw0h6n9GRC5Uy2KdlxH3oG9CLysQeeKDx5LOlilfR7Mb7YR4ln5EG+kr/5qLN47n04jvvP641+XBv8lAfZm/XF/pKJx0tTUuJi/iiFAnaoZ5TObTq8Lo/iiefjjwkj4CmFekX6qKIC8yjnzy7HUm/tIUp/XeGUJ7nOBkt5onu6lkfjEd9ogOMLHLQ67HuEVHC4UminG6lBOUpf3BtbLhO3ceg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiA8xJR/CDWZ+rm2lbQPRSEHelCF83Y7Xz11JcqTltg=;
 b=MpHq6twHjgIaZDbRVAE9WsUaY4bTXP+im5nnOig220efjjgUPFaOLFp/vt7QbpxL5600Z2FI1LAbyMR6reZnsH3MWJk20/spfls2xuJg15N3bppEqT/592wvqAFS2FIFMOKfKI3gDTJzaL2tAYBVTaNd4vIzCBzuFO6YHsG3YiJBE/V2OkepznL2sozWrjzTCOEndWQFfTXLeUbtwRr9Vua002VVO/zzK7MM7vabClM9CH1y3QxX5+++o7qTdeii4ddZ2PjsRLrPpdqVDe+qZCqvfivpGp53SIhvcZddFobpQ3bkLKUcR/Pf9V2Aa3zfUGMPrqF8UKMuUVi+NjSCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiA8xJR/CDWZ+rm2lbQPRSEHelCF83Y7Xz11JcqTltg=;
 b=S/4YtNw1No73ozVhyt2WdPLzTHyPsbqgm90e+6p8vf92uqRB9tY1RXPk3d+M1PkDzsgfOA3iTMd9+odOb+Wh0ZWCeIP0mBubizPvBTwaWhdZQDlVLwZXo+WxF31p/i23vMHHEyhmqGeTk8pQtUlqJ62xiF421ZFCBRpARW8bQJ83kj8QcZRC4fzlBxC7NTCQHAcB4VXB2UtYZTdXYwLsmiFW9KYGH9pLglDMknLM8PNMGKirvYsISJpFfx0VBFE7C+JA9h2tNpqWIi7EmmMsCwFDyvNJNnoST+yrliZtV/7kkbknIPIApki+/DJoRT/f+Cs1xqY05h47OPJdf6ZDtg==
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 3 Apr
 2026 09:10:19 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::8a) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:10:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:09:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Dragos
 Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman
	<horms@kernel.org>, "Jacob Keller" <jacob.e.keller@intel.com>, Lama Kayal
	<lkayal@nvidia.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V2 0/5] net/mlx5e: XDP, Add support for multi-packet per page
Date: Fri, 3 Apr 2026 12:09:22 +0300
Message-ID: <20260403090927.139042-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0961851d-22c0-4389-96fc-08de9160d3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	0G0yQLkWUY6OkHC6iOtNfESaUv5iAebqiL3X0z69lKU03eaFdYhY4jkd9YJfkMotUTbOGe1UFrh/G3b6l0XFqJt789QlbtOnbeyT4VVQxhPKEWvDirRhuHFEiXXuO7Y5d1utMD8clYtyF4BitNgyV4rf4f6QsCnb6FZy+pppmPHReWeZR45QmzMgcAmzypPekr2Ld2QhuLsSU1kydAzd//Bg/HFqCtmVIkObMflbMZs9F4soNqDbUw1bT9plXHyfUhDxMIRIB5Fc8F+JlkX0ikzIJExE0uJX/YZRntwT3bhVDivRecBEtIFAhvyJdCoSeN4cPUOEpRrLjCZOPzH0Jma+OyH7d+iAQcTujv9C5GIqqh8t9FuKR0pC/52sodt+j/PSGrkCzVNvM5fNLaH6/SdqAukmOeiESx3YLDbZbB43MH4ssOU7VqsUqwUMBcRvYEpbBf046QgEBVC/zU2RMT4/DXwjP+zuu0mQEXqQF85AUv6xX1u3ElIBRLaZJBGjJkgdcu58tBt8w9UkiESLtrEwvJJg2he0oqd6Qi5GvNRZwCoG0XSLH26Z1AR6RaKemwqV3pvE4NsrddnLIduTMGGWSjjo+5huWCnsdzFswklIv+cixSeN9ZOiuoUmiD9eSWn/Kiv25KlEOAKfwz+WETqhABTXhtUs3oUuAUQtE/LlrcpyERmVUj1Ailf2GiEofVnNiIApOmSFXPt2KgAJBqj4OiTehX+dcEd9MXKL0DYDUllOKP9CG9Edr3iUkDE2KsHejxgfoDBm7+gAkyhyzA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6nl4ZT1caQ3u4mmeEl+PhkWUWvxjIIdH0Lx+g6DB1m4/1gFtXbi8bWnvB8L4EEphDNI7rr1rOUPftLKsh6hevXp2RWlwSlKWMlyHySlCYfwDRMzct4IZc0qBMwiRPPyataB14JZuv+gm9LGUD7jVJHGZ9ilwxX+qSHfcVbr8cszeOD7sCLNT1F/4jnGTbX/LtsZKnzU0X1qByDN45L3zOD0qfssPPboRt0YjIIup7EjmaL875kOIymlqSodq/Yl3Yu7BeYGjXW+kZI5PBXH5IWGY40Y9SEiapipDUD3s450mGBDtwn3Hoskp7BAEzfEjfJXJv5DI4p+lZJ9M62h3Rpd4qX4Y3/6uY/LpKh1IZH374GTS76D9cr2uHTVSfoKBjlIWfQXVwZWGN4N+Vo48u7+S94askNXJttxGoG8pT0h6ZKvm3fNEUTxi1aZdo2lh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:10:19.1434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0961851d-22c0-4389-96fc-08de9160d3f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18970-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C0EA5392A48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series removes the limitation of having one packet per page in XDP
mode. This has the following implications:

- XDP in Striding RQ mode can now be used on 64K page systems.

- XDP in Legacy RQ mode was using a single packet per page which on 64K
  page systems is quite inefficient. The improvement can be observed
  with an XDP_DROP test when running in Legacy RQ mode on a ARM
  Neoverse-N1 system with a 64K page size:
  +-----------------------------------------------+
  | MTU  | baseline   | this change | improvement |
  |------+------------+-------------+-------------|
  | 1500 | 15.55 Mpps | 18.99 Mpps  | 22.0 %      |
  | 9000 | 15.53 Mpps | 18.24 Mpps  | 17.5 %      |
  +-----------------------------------------------+

After lifting this limitation, the series switches to using fragments
for the side page in non-linear mode. This small improvement is at most
visible for XDP_DROP tests with small 64B packets and a large enough MTU
for Striding RQ to be in non-linear mode:
+----------------------------------------------------------------------+
| System               | MTU  | baseline   | this change | improvement |
|----------------------+------+------------+-------------+-------------|
| 4K page x86_64 [1]   | 9000 | 26.30 Mpps | 30.45 Mpps  | 15.80 %     |
| 64K page aarch64 [2] | 9000 | 15.27 Mpps | 20.10 Mpps  | 31.62 %     |
+----------------------------------------------------------------------+

This series does not cover the xsk (AF_XDP) paths for 64K page systems.

[1] https://lore.kernel.org/all/20260324024235.929875-1-kuba@kernel.org/

V2:
- Link to V1:
  https://lore.kernel.org/all/20260319075036.24734-1-tariqt@nvidia.com/
- Fixed issue found by AI review [1].


Dragos Tatulea (5):
  net/mlx5e: XSK, Increase size for chunk_size param
  net/mlx5e: XDP, Improve dma address calculation of linear part for
    XDP_TX
  net/mlx5e: XDP, Remove stride size limitation
  net/mlx5e: XDP, Use a single linear page per rq
  net/mlx5e: XDP, Use page fragments for linear data in multibuf-mode

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 +++-
 .../ethernet/mellanox/mlx5/core/en/params.c   | 11 +---
 .../ethernet/mellanox/mlx5/core/en/params.h   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 50 ++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 65 +++++++++++++++----
 6 files changed, 113 insertions(+), 29 deletions(-)


base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
-- 
2.44.0


