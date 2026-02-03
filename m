Return-Path: <linux-rdma+bounces-16418-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oImQMX6kgWnuIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16418-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:32:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB4D5B9E
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7525D3050EF7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C16392838;
	Tue,  3 Feb 2026 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TqB+wqhW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62C2DF144;
	Tue,  3 Feb 2026 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103883; cv=fail; b=NEXBnzEQ5KxcRvtj/tOkrb74VY1j6RWgKgevVx8l0WqYUhDGQjpJzKBkj8D1U5iTOtLDKrYM4phyk0vCa/Z5aw/mf7oATmIEB8yImH9MyguknpaLJkqHPDRGNdTPyEIc9ng6Rag/iijGztpIxxyw/UiihFSTdPlpN8Gymyv1M60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103883; c=relaxed/simple;
	bh=ugYKKU+qAsqrCdkgAwydNnNKNrjcfYOtyI6LlEJ2JQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ol5qFBq6jjEXhpGH8KsRyfUR0EiYajVnhwirzZr5uCXisVcTQUSsEfDd3eahno7p4LTxUvaYy8WqCgMmHQ8GTPNUaY5uX/i/4o+XNs8h7/w3+irEhCHA2C5c/BfgA1y2hbPY1fXRSq8LR8JQ3FqyOuviKuprwp5SwDb7Wk3KCYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TqB+wqhW; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFFo0pBPuqzoG8usu0nc3bojEyoJ1tNzGgG3aiFyfE2CjbeRyMRyvt7zVsK7XrlRAHJ9MJwfOW5rBQoMtXKhJO2y+mYaYfilIM49xX5dJl3fjZ9WQHxBwHypNdnIqAZ48QRtYRyuRhOP+LEh8eb3Bjn+dMBewbRY2Ms75/wsPMGaHW2F+ZfitMnatVRqUCwRTaz44BI4aOyVy2jOCvefdUavFQM+zs/PxbNgVDEq1bOhJorvMxKzLohmP3w18fJ++jex53RYz+d78iXHpb1+CISGhwsJ3F4KSTHHzboEJZtWREcvQSuHU5zFD7S4qXVfDBXSdYNxFITMk7pkKsusiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htwyLpzhzWDnl4hu+U5o1v1bxCHYer5GlYA4+K1sHMA=;
 b=YvTJe0RKxHkcaLkW0WdXiKp6WFVAKh13plC9xPpoJrqDewNXB2l4pRRYtmLXC2wSSC2rfOIK2EZtkPiFrgMh6kdyr+qJUJ1g42ukUGzDAphuJoqqlxBNs8KS2lpkZfot/ycO1ii8rI4M0ZDcI55EKK5G9qPj1ph6OuDGPJSBBis26O/oASAcXRMwOsDa2ofP6rs11fhM6PD+HJ6y6jyOi+EJaLCsTaZAoqLKznGDh2WIakZT7KFmx6OgpiIHcchS9/xU38k5HlF4wimgW62m4cCLurSC4Tvj8lmH7Q2p9txsbVOuqQ4RsSmv4VW/KDJbuOwS+JzJKBAnrOpK2JoRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htwyLpzhzWDnl4hu+U5o1v1bxCHYer5GlYA4+K1sHMA=;
 b=TqB+wqhWJ/R+q+WM252G+SHqAzuo4qkuODFh60kqdR5sQWN7hfO/Sw1nXi+9owBrc86jtygv3smOc/SUeDNbs0cFwUgYgKTax7SjE77vVjpFcn1yHcXIV2mcWYxELsvDe48LRfeRpN2e2pzN59uMoQhs79ggli8evosu27bot8knvYbpuNnKobHqxJdc/fwwdnvPA1jhBHx54IrqUZ17UzkG1gpfj6s68eqVGXWS8kAn0+qt8kKwGvtLrDmT8v8d8N1Xom18LqnRjWEfbeuSnkiG2kjgrTfsq6ArDc0VlICcYBnGjeRWjOUO8djlzUmJewSBjJJSE1fDOnBspUwfIA==
Received: from SA9PR13CA0097.namprd13.prod.outlook.com (2603:10b6:806:24::12)
 by MN0PR12MB6221.namprd12.prod.outlook.com (2603:10b6:208:3c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:31:09 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::ac) by SA9PR13CA0097.outlook.office365.com
 (2603:10b6:806:24::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:31:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:30:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:30:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:30:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next] net/mlx5e: Extend TC max ratelimit using max_bw_value_msb
Date: Tue, 3 Feb 2026 09:30:21 +0200
Message-ID: <20260203073021.1710806-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203073021.1710806-1-tariqt@nvidia.com>
References: <20260203073021.1710806-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MN0PR12MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: ba031f97-298c-4911-ff14-08de62f6335c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cjm1myVCNQYpbFj7zLeNZpuKp5zWd2j6Rmzy1ZP6tquswjCEn3MI07ezkudu?=
 =?us-ascii?Q?MuDvDhK3RPdqRROK+mu8EMplWQS5qTO2iHOfQRtRI3hVdUPJR9a784jlow7F?=
 =?us-ascii?Q?m9/rM4ANqmkjXGEYhIAEqfjauUpShnvX7/uBJK8K+4DTx4Y7XNCFRC1AO68U?=
 =?us-ascii?Q?Jof5o6QhmttePfScbeC9CW1oA3ECllWhHZyJRJfVYQuqFqBt+IshNSsMeMXI?=
 =?us-ascii?Q?deC5nActCip+PtuQcAd6L1WhLqHwnrabsSUSGQOY3nBFYIrWpr+Or0qYZZsG?=
 =?us-ascii?Q?ELmS/ARwUaaacNmO2B0hnktt7cDYGeK6rhngxOggY6B07JRfUPrhfVdTsCPO?=
 =?us-ascii?Q?DC8nIxIT0HyyOLN/qJ15uG/q/KLmv20g2stGjaWfzYofjp6C2VeHtqh+dxWX?=
 =?us-ascii?Q?vB+nt4SouK+FpvzJrRHZE0B0V2+UVzA+r0IgqRruC0jmmF1gF430ef89Nv1d?=
 =?us-ascii?Q?EzyeDCIshAEiu9Y5n1MxCVlUOzKjs9oGAyoP1knTlvV5xHiDyIV1VJfdOXQT?=
 =?us-ascii?Q?/R/gqe9smaVxRQWxLJnw4QAlV5tovZlQ3TMRn+ppk2mIlT5aqzAMV/NIML2B?=
 =?us-ascii?Q?5IiHZdnPmixHFDV8G4/KsLiEugxFj7lRXnuI0ri7z+/pMv0XZDhBRXZN3W0A?=
 =?us-ascii?Q?tMjY8IISKiWfsQgOb9GOWzH5TBSc55yP1voDBNpjzdrcRWao/mK7Q5whl8x3?=
 =?us-ascii?Q?U+Gw0Vqex5tzUNbd6k/O870pzYLTdpqDusgZ6EEFikDVVlmguOMrkgUYmr6x?=
 =?us-ascii?Q?unbRGAuR8RKHSwfq+azhrL8XLewy7Px9F3Vwhs1pLjEwJE1c8wQYbHU7Okd2?=
 =?us-ascii?Q?e0TmTx06UdxGxEkSJzNSiwQccK/KTjxW9XgKhUN3ATirKGu2ZTlZRB3fgKqc?=
 =?us-ascii?Q?xLjXQV8TxVgzpoNyWfNNIGDY0ZPFmjreEbjj6ypFnndxZOny/EexGTqaoKI7?=
 =?us-ascii?Q?JGUGlio9OsvrDwJE+UDMy0YTArX/87ZrkifmX71UQ0DwSU0b+CmlfKAVxcK+?=
 =?us-ascii?Q?5uR4zMuZNxRBNnYd3iL913BGNIrowLC2ThK8VWdM2KFAD88FjpSPipdOuLN3?=
 =?us-ascii?Q?oE3i1DC6rtpTAkx0ylvIyc2qwETXo3P5PKHwdeOiq4Y7kp16Cp57Ep3sAXN+?=
 =?us-ascii?Q?cmzNthcpgvCK59nDyqfDF9VvAs2YEdkmKVZ3SH1EokcuHmiNFf4oOBBWqr5k?=
 =?us-ascii?Q?yeYH/Ie9Y+EejMBjE67zZkKz8kxDBUhVSHFZvVzDqb7KCANTWhVZChK2yrp5?=
 =?us-ascii?Q?opWcblCYA1mIrciBNFszNNaCWpqhlcnSfQX/2uz4xZoOJbjuVWRz40AvasJT?=
 =?us-ascii?Q?3P/x3WHMCy/NRyCdi+B5UFphmfG4BGtMh2aGyV8VIp0MAkPvqJqhXmQeOBpp?=
 =?us-ascii?Q?3vpJXsS0YrCzkmprllRjEn70u+GREQPVFGn4RR/jetGg/c0Xswwloj3EMLTo?=
 =?us-ascii?Q?GmJ74NFf4NQ9A0HTgI/hzyaP5ADrzlmoSvSTMvcviPgPT6voyiaQu8iKdGsE?=
 =?us-ascii?Q?v/DAo0dJHStrTA8ox3qnuzzMs/QVTOUm+d1H4YOAIrMedt2HpIz7qDpt1ffP?=
 =?us-ascii?Q?xtR0fyBmZBrbOqfND1wzmxM9qZHZWa4x+FTblsCblsYFFHB6+irhgX6AY+fB?=
 =?us-ascii?Q?uyapWv/57NdxbGl2qyNrzlpl7rPribouvZv8l8on1Og05EzrPrk662ZBB0pd?=
 =?us-ascii?Q?6Salzg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uodF/XBK3bXYsJ3+h7YNsQBtj1/FNeNfLiDRgTiJvgjrT9Af5KISA976cBUy8mb1516tQ7eZY2r5V4vpfFqG6DVY/lfpPiRqmroHMZPUuDqTuv4aAm8ouw+9AGxJ1dbOaZmE5bfcwAHtA42pfqX8mdu5S2l2m61DsxC2uA0y9ipPGtd9K+NpJL28EBxtd7dEIGYFcECZ7vOS169tExb2NmyQ+13BZm0k/4zrKhTOSLYTEU8mTkY7knXyRIw+1pzCPgNKDIsFV9/g4Itj//ZhfFfcSyqk855LzbGOAl8XfBLFKhh6Hc2WwRJgMiMK9VVKQfdNDWDESBFlQLWAmnEfiM44rDBrNWbZ9LzvmTBCjFo1u6JdU/5NVwiT2pMXdRoOh5TCt6R9Yf0ZjfKOe2x60RZpzPzNiG4XTMEFbpbavQkKzMF/7OGPDtVZ8n1c7nv9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:31:09.4974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba031f97-298c-4911-ff14-08de62f6335c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6221
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16418-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 71EB4D5B9E
X-Rspamd-Action: no action

From: Alexei Lazar <alazar@nvidia.com>

The per-TC rate limit was restricted to 255 Gbps due to the 8-bit
max_bw_value field in the QETC register.
This limit is insufficient for newer, higher-bandwidth NICs.

Extend the rate limit by using the full 16-bit max_bw_value field.
This allows the finer 100Mbps granularity to be used for rates up to
~6.5 Tbps, instead of switching to 1Gbps granularity at higher rates.

The extended range is only used when the device advertises support
via the qetcr_qshr_max_bw_val_msb capability bit in the QCAM register.

Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/dcbnl.h    |  4 ++
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 66 ++++++++++---------
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    |  4 +-
 4 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
index 2c98a5299df3..6bd959f9083d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
@@ -29,6 +29,10 @@ struct mlx5e_dcbx {
 	u32                        cable_len;
 	u32                        xoff;
 	u16                        port_buff_cell_sz;
+
+	/* Upper limit for 100Mbps and 1Gbps in Kbps units */
+	u64                        upper_limit_100mbps;
+	u64                        upper_limit_gbps;
 };
 
 #define MLX5E_MAX_DSCP (64)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index fddf7c207f8e..4b86df6d5b9e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -58,6 +58,20 @@ enum {
 	MLX5_DCB_CHG_NO_RESET,
 };
 
+static const struct {
+	int scale;
+	const char *units_str;
+} mlx5e_bw_units[] = {
+	[MLX5_100_MBPS_UNIT] = {
+		.scale = 100,
+		.units_str = "Mbps",
+	},
+	[MLX5_GBPS_UNIT] = {
+		.scale = 1,
+		.units_str = "Gbps",
+	},
+};
+
 #define MLX5_DSCP_SUPPORTED(mdev) (MLX5_CAP_GEN(mdev, qcam_reg)  && \
 				   MLX5_CAP_QCAM_REG(mdev, qpts) && \
 				   MLX5_CAP_QCAM_REG(mdev, qpdpm))
@@ -559,7 +573,7 @@ static int mlx5e_dcbnl_ieee_getmaxrate(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv    = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
+	u16 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
 	int err;
 	int i;
@@ -594,57 +608,41 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv    = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
+	u16 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
-	u64 upper_limit_100mbps;
-	u64 upper_limit_gbps;
 	int i;
-	struct {
-		int scale;
-		const char *units_str;
-	} units[] = {
-		[MLX5_100_MBPS_UNIT] = {
-			.scale = 100,
-			.units_str = "Mbps",
-		},
-		[MLX5_GBPS_UNIT] = {
-			.scale = 1,
-			.units_str = "Gbps",
-		},
-	};
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
-	upper_limit_100mbps = U8_MAX * MLX5E_100MB_TO_KB;
-	upper_limit_gbps = U8_MAX * MLX5E_1GB_TO_KB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
-		if (!maxrate->tc_maxrate[i]) {
+		u64 rate = maxrate->tc_maxrate[i];
+
+		if (!rate) {
 			max_bw_unit[i]  = MLX5_BW_NO_LIMIT;
 			continue;
 		}
-		if (maxrate->tc_maxrate[i] <= upper_limit_100mbps) {
-			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
-						  MLX5E_100MB_TO_KB);
+		if (rate <= priv->dcbx.upper_limit_100mbps) {
+			max_bw_value[i] = div_u64(rate, MLX5E_100MB_TO_KB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
-		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
-			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
-						  MLX5E_1GB_TO_KB);
+		} else if (rate <= priv->dcbx.upper_limit_gbps) {
+			max_bw_value[i] = div_u64(rate, MLX5E_1GB_TO_KB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;
 		} else {
 			netdev_err(netdev,
 				   "tc_%d maxrate %llu Kbps exceeds limit %llu\n",
-				   i, maxrate->tc_maxrate[i],
-				   upper_limit_gbps);
+				   i, rate, priv->dcbx.upper_limit_gbps);
 			return -EINVAL;
 		}
 	}
 
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		u8 unit = max_bw_unit[i];
+
 		netdev_dbg(netdev, "%s: tc_%d <=> max_bw %u %s\n", __func__, i,
-			   max_bw_value[i] * units[max_bw_unit[i]].scale,
-			   units[max_bw_unit[i]].units_str);
+			   max_bw_value[i] * mlx5e_bw_units[unit].scale,
+			   mlx5e_bw_units[unit].units_str);
 	}
 
 	return mlx5_modify_port_ets_rate_limit(mdev, max_bw_value, max_bw_unit);
@@ -1268,6 +1266,8 @@ static u16 mlx5e_query_port_buffers_cell_size(struct mlx5e_priv *priv)
 void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 {
 	struct mlx5e_dcbx *dcbx = &priv->dcbx;
+	bool max_bw_msb_supported;
+	u16 type_max;
 
 	mlx5e_trust_initialize(priv);
 
@@ -1285,5 +1285,11 @@ void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 	priv->dcbx.port_buff_cell_sz = mlx5e_query_port_buffers_cell_size(priv);
 	priv->dcbx.cable_len = MLX5E_DEFAULT_CABLE_LEN;
 
+	max_bw_msb_supported = MLX5_CAP_QCAM_FEATURE(priv->mdev,
+						     qetcr_qshr_max_bw_val_msb);
+	type_max = max_bw_msb_supported ? U16_MAX : U8_MAX;
+	priv->dcbx.upper_limit_100mbps = type_max * MLX5E_100MB_TO_KB;
+	priv->dcbx.upper_limit_gbps = type_max * MLX5E_1GB_TO_KB;
+
 	mlx5e_ets_init(priv);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index e4b0aa16c1d2..b635b423d972 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -345,10 +345,10 @@ int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw);
 int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 				u8 tc, u8 *bw_pct);
 int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				    u8 *max_bw_value,
+				    u16 *max_bw_value,
 				    u8 *max_bw_unit);
 int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				   u8 *max_bw_value,
+				   u16 *max_bw_value,
 				   u8 *max_bw_unit);
 int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode);
 int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index e8a0884ea477..9fca591652f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -773,7 +773,7 @@ int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 }
 
 int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				    u8 *max_bw_value,
+				    u16 *max_bw_value,
 				    u8 *max_bw_units)
 {
 	u32 in[MLX5_ST_SZ_DW(qetc_reg)] = {0};
@@ -796,7 +796,7 @@ int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 }
 
 int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				   u8 *max_bw_value,
+				   u16 *max_bw_value,
 				   u8 *max_bw_units)
 {
 	u32 out[MLX5_ST_SZ_DW(qetc_reg)];

base-commit: a22f57757f7e88c890499265c383ecb32900b645
-- 
2.44.0


