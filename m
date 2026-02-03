Return-Path: <linux-rdma+bounces-16414-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLRIFCWigWmJIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16414-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:22:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3DD5AA9
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE6D5302979B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179F3921F7;
	Tue,  3 Feb 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hd+HXA8I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272B36AB63;
	Tue,  3 Feb 2026 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103326; cv=fail; b=qLTeVOTKfOzOs3q2IL3wXkCDym/QZVat/QINY/eEq0FsVoPWSGJdQnuby+UjmXHEiMw8LNBSt4IQ22SUpHr7j7MVusLj+PPYsXqd7q1Cl73RPp2erwdNaOJip/iX3iDxdIJbNJlWUEL/kji3q0tx2mQO3r8IigWQxNfw+KMNoGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103326; c=relaxed/simple;
	bh=TIzisDnt4Hzb/q2xwmgYNLdlevtbzMl5pGq2h6PjTqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8hA3xTD+I4gJMhp9+Z7qC9ONm5KcGA2V8Lvlt/diKtZ4gB+hRYKnW8vOl+GBFGC96CyheQO8ayk70+75eRUtpvnFdQTZmoYR/kiD5OBYZEAarlnBG1rUsAxYpaWqkfj1DyEynhgyxiljHub494pvuyTfWTKPp8bpTe+NTydxe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hd+HXA8I; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BqmNekMqlQ9/HdtoRCaQcpy7wAKHwYc48CTJtH9nt57PbfQM1T8EwI+89A+tWsfZeJoaC+AON7JGCGZboB1Vqtx5GVJ2uGb4MeU3Jfe9u/ufBp7XasXNOE/W6H/q5FJzn3f7fFNZIinpWTObT2Pu//rIcRKd3ZAEbLqG01K49CvtPLhJkWPXvFi+HcqhhzcjSgJN5g5IvmIgwqSYNxFZXoZCseuU0nDTL0+xPbuRq3hpAaPgT747brw0e8FS+KSYkg3MZevgocIqpSloAmsTf8jabwb0E2BU3tshD3GDyukGXUg3plxYrYkRH5nnEZveIT+qSJXBfaDCBKoVUidIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8vLSyhBUugUE+CdFALRZj7F6f06kOn5+62gaA+RmAw=;
 b=Gn6atjG832C+HMrI3MQc18xDbddqin11YJ+vE+vJWllan7IT12JN4DTqmJMB8xKOzPQvrM5c7XP6mHdJweASSuAgn2tdXPTjZ9SraedZpbPg79VUoy+7L4mM/U//L6jp8zVjAgH3GZdwoBj9M90fHJ3x7Ch71ttH8lO24tC2Oq8xnnUqhtyx8RVDBW/RYANuq7SrVR2vl1insTBbRuX9Ww19HkFVGNTGdEpVQkE7nJOOvvZMq9BAaWvyrJB9TWQpkEtgBg6DTC3usPa0y/OhnxAg8lHETYz+UIBjagcf/MJv1DN+tv6TaU/ifWWnCg++hBqeq/wv9L5CurqTdX4bXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8vLSyhBUugUE+CdFALRZj7F6f06kOn5+62gaA+RmAw=;
 b=Hd+HXA8IFXqYW3n9iIupWhvI0w/UMpa3a68FV0fiGeG/j2RVEXTmz/mKWi1WV6OfOnlSrdwanJg0RE3Bl+FHamf7mJr5I9hW/3uFNn9YQdz9QFiIxMnnlPHKDB/RO8MaEKQ7jHkQHsRmdzzH0FaJAIafq6r6guXzgE0pmHPMJfmKGSrES3I3z1PjSV6LbTuyV7E1orRcIIxKU/Z/Qb0EIEixv860FNeSdefLiF7vgO39B9PtXhPyjjaLYca6HO3zRPD4cYQ3WT1949E8OkSxfpxD2YQ78HYGWQBVKk7GLUchb0dY9jbRRxmQJRdQwZiQAANeyK478cKTK4r8jiXgWA==
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:22:01 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::9) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:22:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:21:54 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 23:21:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 23:21:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V2 0/2] net/mlx5e: RX datapath enhancements
Date: Tue, 3 Feb 2026 09:21:28 +0200
Message-ID: <20260203072130.1710255-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: e44ddf67-f770-4988-d229-08de62f4ec6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tAkFtoT1Irw17IbHl63WEDOSwg/WBOQYocVbhtaZnknnUh0IEbPdsf+Hex5n?=
 =?us-ascii?Q?NKxLMr6KlQmObYx92Z/X9lsKki0MiMtywdlqo9+HQVB01h2hQ4stmefbYGTE?=
 =?us-ascii?Q?7kE0GwmbemmORXx7LuKkcHPHPeRbJ+CjWpSAuiqk74y8+DgW977WViV1a/kW?=
 =?us-ascii?Q?660AkeqopViAAlVY44r9UWfpqYz8TzkmHr7UEGgvcYhW3QFiyoA61xV2byWG?=
 =?us-ascii?Q?UfAV2ed0ozZmcWCZdUm8yEYTw6xVzEXuamUTSDF15UciOwv1ppB6uuGtA9Ec?=
 =?us-ascii?Q?i60EkLo/rR+eY/Z7FU9T4Gc2tr3c6MCeFTGVXIHKG0U8MwcP3+8jHutitwGU?=
 =?us-ascii?Q?KeDFd1I39BAUX5t/G1wy3NaWxcgAGY2ukSGV6/sTHfgVB8U92b3znpw6LiEk?=
 =?us-ascii?Q?xWsFF+9RJzDjrMd/v+LhggmQ67jW41HkFxvLhrf3pAIenIxyvrEADlSwmGz5?=
 =?us-ascii?Q?OvdE3gHLsZP9c5jmIDvaBn+oyvMSq0GfgL722z8YYZRrpEIHoniecB/SVFlP?=
 =?us-ascii?Q?vR4xbi6K3zaYOoW5qSSmHIx9jiC72UGO/L6ncDvvlO4FvuhikI7Gzg/bibnc?=
 =?us-ascii?Q?4n2TNaZQZ15LjGqnWSXdeiOPpqF4JrOKck7codA/FCNT02wb7Yi7a7qvElHs?=
 =?us-ascii?Q?lYVLYOcDklDbn0x9emT77t7sppbcba6FaJnP18kogXw2BiVBcv4wUe1SL/eq?=
 =?us-ascii?Q?edr1yDm4M8dpq0+Wimn3A0Exyp8zfZBlPF1Pk3pLS0xmuulsb57ZY1EtD83d?=
 =?us-ascii?Q?AP2AeByarXoQ9xXJtyMp0Pj7CFqNRmeFE8gP2g9QjYp2vAf5OdJ1ZXkGHX+8?=
 =?us-ascii?Q?geVzEy+ihpKF+m1X1hdJRHjqfBFyliIoZSadBoAHRqYyy9PLF2aSpnSQvNCK?=
 =?us-ascii?Q?SCGUcw8rDabAXmCS7XUBEmoyisnqsA+TycHIDUr/Pr5Trx39x2PFqiISsmQS?=
 =?us-ascii?Q?6jiuK0fBElf5Z3J/IWdIJAMPS9E8NF4L8OKkuLd2ZN0pFWf8MxUbaJ4psMMR?=
 =?us-ascii?Q?KMvUW0RuVdnOj3mHSwFjHDLbapup1IygADhZ0cY2RUca6YP8G15DmP5s15ur?=
 =?us-ascii?Q?AkRk32PbhEUL3a7QiRpb83XZQraW8VnrIymzSoDb3BeTn5mcLO5ygZiFDl7y?=
 =?us-ascii?Q?+n6nu1Dd653EUFEIOdE1nzdyoRsimX8iTglWHJkZETBRN08bVr09G3Mz/Mer?=
 =?us-ascii?Q?uSuYF5SG8Ha7XhIEAwUUL9n7LQ+2S5YciYDNs7RcB7KM5BXJH02nhSTVzO7M?=
 =?us-ascii?Q?IMYjog3DBrGEB9V231u+E0AReSUnKNsJzHzRA3r3ZdTPIE4WJ5c5sgOOcK8y?=
 =?us-ascii?Q?YOQ9vBmOTNGZvN666E7Jwla7UrG+4VgBRYwidRlkuP5DD9LIn3dR7olvddXM?=
 =?us-ascii?Q?FadTJOFGUSMx62YjeyPnwcZNr6f1NyHa5xd02o7TWIdgQq+6/jmZRhBcK4H1?=
 =?us-ascii?Q?jQxJfqqOhCSKQLmIf1urNqVniMXl1mEXEdtIc8BpaDljSE+kRW823qeHcTbK?=
 =?us-ascii?Q?McfB63WaFHVTE0b+JErtZTuJFNm65fQGLG6MAP2FG8EKXB1rOcHG4HnkTgnm?=
 =?us-ascii?Q?wc3Showap3YgJFviuqvJrpZIX4wqOLlW7yOUA4q2mWnUXRvfIuSDjINx80i5?=
 =?us-ascii?Q?AQKKr56ipX0umLHu7O4EclBWW4WHLhq3fHCd0QjOGlmb30yEQmHeByMdC+cA?=
 =?us-ascii?Q?50o5Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZNbiEP9i4/jZDPB6BeBQ8WK3fPEQT3itDm2ZAHJ2mxi+xOx3KH9VDaVQdD67y9j/0+ohwjC263Ht+qLxcJZixkN302ndWqRRSb/v7clZ5ltPT7EtwT9k81P2bSKVKEVsMZU2FHj+k/FBEYEB+5L/FbtekutEwCMzuFsj5BZgwrDa62frzm6dlxMcIg4v3OZuZ7vDM2BNs9C1bOnTUDr7xN7fB+rdQRSUWIqB2tLQVGWPjsKZzPdxOMkRkBl5yAKLUl/UdRC6AN8SHfyVTm67S4kBISqGMce7akov3L/W/9ldDW+/mIm75j9znH40T0cOYjxFmxFI2y5DDkVPyWu68WV62iXvIaGYM6lJWixDfBAVfAX8Osu8nbl3yL6ul2gs2Wm3mml0TH/3mw6xNC+IXejzTleusfzyfA/kgUs8kOmQmNClLWahpN3cNwOwTx6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:22:01.0897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44ddf67-f770-4988-d229-08de62f4ec6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16414-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EEB3DD5AA9
X-Rspamd-Action: no action

Hi,

This series by Dragos introduces multiple RX datapath enhancements to
the mlx5e driver.

First patch adds SW handling for oversized packets in non-linear SKB
mode.

Second patch adds a reclaim mechanism to mitigate memory allocation
failures with memory providers.

Regards,
Tariq

V2:
- Fix duplicate empty lines (Paolo).
- Drop patch #3.
- Link to V1: https://lore.kernel.org/all/1768224129-1600265-1-git-send-email-tariqt@nvidia.com/

Dragos Tatulea (2):
  net/mlx5e: RX, Drop oversized packets in non-linear mode
  net/mlx5e: SHAMPO, Improve allocation recovery

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 +------------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 37 +++++++++++++++++--
 include/linux/mlx5/device.h                   |  5 +++
 3 files changed, 41 insertions(+), 26 deletions(-)


base-commit: a22f57757f7e88c890499265c383ecb32900b645
-- 
2.44.0


