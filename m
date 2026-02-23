Return-Path: <linux-rdma+bounces-17080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFyDL569nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:50:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 536AC17D323
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CAF6309AD4F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E70378839;
	Mon, 23 Feb 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="auS2705o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAB3783D8;
	Mon, 23 Feb 2026 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879529; cv=fail; b=O2Xfnl3M/4S1rejMYywLR9BeZ0wE8IilVItpQj2OGzQgEwhgpgTiSfsvO2uYEc3Q3ZIIwOSVLnuUrQpSjg2pDmaELDinmQ3uPGi40EnRvwO68/hSvJbbsUzoYAsnpNq18pff0M4ICN1Ge2lJoQ/p6LGE2HF9iwYl+0ZRDUH3XC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879529; c=relaxed/simple;
	bh=TUb2vcVowvElvizgjk4KSP67zDnmAFNr85hzThY+ZYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZO39RkLe/DxE7HtMBl4cgfUL4BORLTbZTeuYBqXopq3jg+6VMnzFpOWkmamYW+QvU3p6G8LmaDe3oyYQyw+5iXWJMBSTxHvCKvy6TflgaibjOAqLk8VytZtBOCTAQVyu8mkYQsAdC6/qSZzjlYaoFoxy1WywAZJWiNyBxm2te2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=auS2705o; arc=fail smtp.client-ip=52.101.43.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdyKCxPP9Oj12uSPlDWHna30Zx8s4Edu7FpIyFzIhzFbrF/rUi0YsMztpuZJypOp0Og8cOk2VyiaAM/QbLMfYyfmm508Y9x8ZQoYmFCPy81uvOSfR51u27MryGWt8O6aghX/edF8oUR9OkfHanpDkXj/r5gUlVDzbFU++2u11Pq/niYqldWiShSFNKjOaNl2uZ3MvJkrKEP52P1N3Xp1FoNOfD2B+Z4MlckC0om+xpA16F2z0lSszXPQSE7G+Zel2fAp0MopXDqdkgsrO4a8WIMHgFgeK/Ytpnz8gXbfcij5fnY1XUh/sFcueLSg2VEmuHlaDeh9qm4uRh9HNZX43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RTM0HWWyf6eXM4FTWrhFONglPW8XPribfnbm2vWB5E=;
 b=enEQIvz7NlSLG+K2JeFz7cxXNFfpPYD1gVZ19F8hRA4pVL88OuGHCTmAbzQLT+OIwqSy9hhvGZbonwYjwo1YLyZ2la2wKwtCQZT43E9bxJRHrRpCgF0kIXsQLoFk0UGhp5+8SKs3+gDAUTQc39Y16FVsx5+ItFxbr/xY7ApJsGUSrs/KT+D7bQy+rd3ZURJns6PywOP7Iq7rb224ZtWpp0GEwgoLNfTEPPjZgL4Gn4jJW5e1xHF3B/SVI0X5FgJKpL33uc2PJAYDJSPR/+zwdjo/2fMqKODb3KRS5qGE4u9E4GdhDplJ1NZeAzkr0ui8JdQHUoZvX/9cyoWGOcuwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RTM0HWWyf6eXM4FTWrhFONglPW8XPribfnbm2vWB5E=;
 b=auS2705oXSMbCkymJykBjpE6bf7xMaYcatdZjeIvBs4AHm/sssRObruSWYO3EMStMVDAt0nglADor/1HXpRDFmOoGGVYv+nTi6ewzY4Yk+Qz9ACobc1VFLaMnc80K7Y+68UZsh4oXazm8lTVbuS49ICPcQYQ03Hvg58fZ8iTtZK/cIewyomGHJ6kZsttnbXV8Es/MJaDoLdBH9NCO6cn0aXxK+LVL6+nipem9EGoez9zTXmcsKaES/yobI27gkfm7dCTOSgWOe087Op8L6txL6dH5N7RxLw3MOc+cYljNMf20w+mOGkeI3eqSq+Pq3q7Xo6L6h4NeCCFHDJHiIXTRQ==
Received: from SN6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:805:66::45)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:44:09 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::81) by SN6PR08CA0032.outlook.office365.com
 (2603:10b6:805:66::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:44:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:56 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 12/15] net/mlx5e: Add queue config ops for page size
Date: Mon, 23 Feb 2026 22:41:52 +0200
Message-ID: <20260223204155.1783580-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: de71a5d4-8b68-457f-f594-08de731c4b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RG/hbTcEHDi6mlfv+RrS8xXRdpsfcqFkoFCrd6l7yXWpUK8/ONXEAfInrq9d?=
 =?us-ascii?Q?b7dBkC9987jaJHHUyAttaBa/7XP1sF1mOqgaPI/b0INmUCSV8uaPn91y/U/X?=
 =?us-ascii?Q?0APCx0S+fHROakBdVjRn2828/s9wue6H3IikTRFhXDEmgr75q9AzGhZODyyV?=
 =?us-ascii?Q?MOuInX0uwTQ5uJ4i1L2BCF/pzbb3vuFp1YtL+Ym41vlgxO520dRb7y56pIpy?=
 =?us-ascii?Q?0b++mPMicfJe0IXr1UidH+YzHtob+RKnri07L8d6M5NbXCw47CJsttG3nJHS?=
 =?us-ascii?Q?4OTgl7xDx8X0LASDDth/Re8c3QaVdCr9PKmU71+y7ONiq2q795uzUVpx6CtH?=
 =?us-ascii?Q?DBeNSIMaS02ZyT4a5ZsD/NE4+Hyj0FLupIPTOLqZVcorUflZJLAENK/58Cxg?=
 =?us-ascii?Q?jd8qluK0K3g2NH+lwNqQA00Id6txQp+OnQXFRgjcuoJzk7cBsXSwy6wy0waG?=
 =?us-ascii?Q?b3aQhbOB7h5QLmCPJQp4dLTb5JjN68J5PgLnBgsR/dHG8L0udPhxM4KYU4Cy?=
 =?us-ascii?Q?823GoALgJc+cT5W5+rVX1ZU7iqKwmJWjgwmEFlPPQeG3py/99JgTD/knPeRo?=
 =?us-ascii?Q?oC7l4Wmr+HRRx1O+HFkUI7FQgQYrq6bj608fHaEd5fyPHNt7f1bR28Yxfsta?=
 =?us-ascii?Q?veQVikRXhcg6yyydLfE6dikBuDmd3ZXDdPtuanNLraBI8XeWrZ9S6absXQ/F?=
 =?us-ascii?Q?EYrUCuucoyzCLHcNB9wj057MiNMjX+tD+pMxeb6rdd84YBphc86IKVnNc0Hj?=
 =?us-ascii?Q?kCZ2Jp4EA2Yq++u6iJ0aymRJ3IOLVpC6Pa7NJY9qKW6LvOiF7Ga7x7kSM9J/?=
 =?us-ascii?Q?ry8dym4SN9cCGd5VDMRIDDuFsYbwZdz5Sg7hvwxMbj9qh7vqDCYAXdPyrnpM?=
 =?us-ascii?Q?QrCoBGADfHBxY4JrqR2/NaGb4O3lDbe60bJ3smcY517wawc0N0ZUCwqsNHWh?=
 =?us-ascii?Q?Em3mupKgIsabWIdcC3dpjHGiDyt/ju/skku9WAhvxoPikVGGn8kWjww37oNb?=
 =?us-ascii?Q?FY7YzqNv8I7/n8RiGM6H8cQnqlXrknP1BpRO/y9C1nxUJClRANX1HbNH2gIa?=
 =?us-ascii?Q?IMDbIm5eJdJn6fRDjJoaeK/lghZ4Y76vFRty9EbIfwTTE+K/L8NleMinIlu/?=
 =?us-ascii?Q?VzLbQe8x6wvBT8qKX6DIn9ebbZBluB9BOHAKP8aG3CocsfOj1ryCnComcKOq?=
 =?us-ascii?Q?t3QsSDiW+BhNU+Y0NovOBfvvEPGTDQ9A95/QeC5voMRKuqSQ9kwiDl9jP5uY?=
 =?us-ascii?Q?4w/c0xIiube/ZTUFH9l293aujiC204dMPQtCauqoelNqTI9A6fFxufmg2yUm?=
 =?us-ascii?Q?UrNd86J1zm9P5+cPzIekA3MQiei3/oKj4K06Hfs0LwqRMiIsuQvGNbsa6DyL?=
 =?us-ascii?Q?sJevWB7bR9DItoePCIhZLyHSYo0P8wjRbciSoxCJvYZuLX36lXA7vVohTINs?=
 =?us-ascii?Q?iohVkAEoTFf4Za/21OTr+v8KHGpvKRRIVoEYEvSTOvDnCwjX3vA6+xS14BNy?=
 =?us-ascii?Q?6QpI4Azdof9D6uQChN0/2c2PorX/12iqOzGsRxcQNtnVUx8ImUVvTBGvBPli?=
 =?us-ascii?Q?aFuukzEo8B1KdZWEOukb9vqyWK8D6AeUVhX4pKZilWwjqW9bmfmsZj3eKlvG?=
 =?us-ascii?Q?hkwB353zFz+Kqt4Ja1cRH6Za67bvw5J6FtuquypERuuBU1j/vuTbUF2yijUR?=
 =?us-ascii?Q?8BklQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k+RMuad3BTF5+t2HZcIMSdb1fLTbk5Upse+SgREDP4Wh3zSklX6aqZ3cAyXgDfOqRPOlrLB13dT2GUkC1At57xPttnLfGZbVV9FBRIVzILWV1F/4ZU3+9Fkc8IdaqshNogzjwfV9AFv966YXCZ/4LfWhABtrokZrxAAUnUxmLo9AiL+X6lRFQ+95s4/ZpgbWV8kNIuUDbCm19/DzntrezmoK0r1UolrHYRA6dUL2zjMDZ5feB9t1vlSzFBEhqjWmRcwCQZz+CrDJMkpWuY84K/1BS7YVIzniuwKD+ZNwHoOPlIsqUm/Dd6I8GufzieX/mtF8n40hwyjwpbaMdKbYJPNvEf7vU5fz225eFvquQS47ALXUlYhJMaEskEZuROAcB+aQUbevQxJ1Xlg2JjHwYmQSvhxt4FVdiIWpGaBjOA1CpoAALoiEzXPbCZ0TO6aX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:44:09.3461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de71a5d4-8b68-457f-f594-08de731c4b6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17080-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 536AC17D323
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

For now allow only PAGE_SIZE. A subsequent patch will add support for
high order pages in zero-copy mode.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index cf977273f753..336e384c143a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5572,6 +5572,22 @@ struct mlx5_qmgmt_data {
 	struct mlx5e_channel *c;
 };
 
+static void mlx5e_queue_default_qcfg(struct net_device *dev,
+				     struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_page_size = PAGE_SIZE;
+}
+
+static int mlx5e_queue_validate_qcfg(struct net_device *dev,
+				     struct netdev_queue_config *qcfg,
+				     struct netlink_ext_ack *extack)
+{
+	if (qcfg->rx_page_size != PAGE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mlx5e_queue_mem_alloc(struct net_device *dev,
 				 struct netdev_queue_config *qcfg,
 				 void *newq, int queue_index)
@@ -5682,6 +5698,9 @@ static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
 	.ndo_queue_start	=	mlx5e_queue_start,
 	.ndo_queue_stop		=	mlx5e_queue_stop,
 	.ndo_queue_get_dma_dev	=	mlx5e_queue_get_dma_dev,
+	.ndo_default_qcfg       =	mlx5e_queue_default_qcfg,
+	.ndo_validate_qcfg	=	mlx5e_queue_validate_qcfg,
+	.supported_params       =	QCFG_RX_PAGE_SIZE,
 };
 
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
-- 
2.44.0


