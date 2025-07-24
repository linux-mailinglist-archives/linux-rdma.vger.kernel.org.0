Return-Path: <linux-rdma+bounces-12465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC35B112AA
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 22:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0620E1C2506A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA92EF2BC;
	Thu, 24 Jul 2025 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YALwO3U/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A02EE281;
	Thu, 24 Jul 2025 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390270; cv=fail; b=VKijuHPW91BLD+o0VCYMglm2pOTAyqFy/dmPIaH7WPx4j3jAKg9er5WCkjierxOWskBSKWPpvx4mYS453zj7Wkh8bsQ8pSmfrvLpST0o7lJBJ7L7Z7U8mld8O23sfIsYldiy1zVfrPM2tT+5cBCU5i2x96fNK1u8bpGyXgZ0XOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390270; c=relaxed/simple;
	bh=uzUjCrfhAPOPAwhG/9Vg2/PoIxgs9te4GCB2/EhoDfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVnjOtoM0xr3b4iz3P/BhSLakdX2m1dsbEyUazCoG4vRBMSXdWJyHq9/y8hW6yinK2MHd6wTdfIvblHm3ErRI++ekyzx6QrfMTcFR/F67T3XXmZwaTqt+dTnYTSW4SoXIVHiYWZDyA4ZHq6bYl/UPpJtp+rM47gLFoSVncL3rZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YALwO3U/; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrW227dU5vAne2yHM428ROrmGCWOMs7ZCMBAGXQwx2wR8JtHpixXPOp7FvLhveFR9YS8X0eJg2/Z3VAxj3s5z8wSXlfxAUUb2rzlg2wRNHYWx8FrLUQzQzkEjqxyoZrLvLCm/5aQR6oDHvuk/2EFDrmNjouCVXTuzfbu/9k6iX4XuFAcOVadNbZs9yPCVLgKPDX28zl3Gg241kMlMhzrqbdwMP+SNQmU/YdvTFRFRcdk+hZjvsTBgrCFlzx+y8rdqO4U1s74o3WhOLuBajtNRT1I+x4a/NEG9S/QIJ58HOTrH1TwJm1m8p1HLgCH6XInwcL/bKvTn7XBZpbkJSwmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqVEsIRDTmfGdODm1MzM6eyYNwTU7ioS9dtVataAO04=;
 b=jwM67jjpWgC3v3OLho/Ci/kNNtFQFX+8PULnbwfTzyy3FWYMY5BZb9c0oua8Mx2jHUIoxVXsFCWwIguefHsDpyB0sDZPnL3hTrqRz9Hd4zd7Ge5W1I2m/ZJJ1Eb3fR3yHx/GsDbsvWoL8R+HvSOEjoMlUxTKUBN9AQTGUVn6JVDv9fp72QXkYx3RsggGp+dXth5nUVSDnj42JbYSLxp97yAlydt/rZYMaIvBcsAxGq1Md9SqLvheAWsOpbE1H2fR2H+9sgN4G5ds3GfkgB75Sg3DfzshJztBnMLqDYVZseQyLPjyJr2DTDPtJng0DMOpYjDFkPht49oLJSeIc2WibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqVEsIRDTmfGdODm1MzM6eyYNwTU7ioS9dtVataAO04=;
 b=YALwO3U//MJ2oPE7tyZp4qeQgzbZ/SVi1/TzUSbA5RFqwQTHXpuuP1PzF0wXognAj6kj7HqBTd74Ov6IjS8H1iReSVc8qjUDYAF/11jgcnskPFc1hs0mfJYYZassqym1MH7pKZFqvgHU1i4pIRAdhOHQz74J/uV3vtjiHQmHJJXCLGrfg5lTe6keJ+67VTt2fE8wa29CDHpWTC/lpJtBBt6VKdl+W5RZfh9CGB4ROPC4wJ4nnBStfCuFo2wS3wChfZb/6s1MwY9aungmPkIYHM/kGy0ZXrSEF4wpb9Lh026eECz7TkZJwvgRcfJVVMszAacZ50+xDWtiwzLXcjaqxg==
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Thu, 24 Jul 2025 20:51:05 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::ff) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 20:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 20:51:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 13:50:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Jul 2025 13:50:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Jul 2025 13:50:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Shahar
 Shitrit" <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V2 4/5] devlink: Make health reporter grace period delay configurable
Date: Thu, 24 Jul 2025 23:48:53 +0300
Message-ID: <1753390134-345154-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
References: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: c1541bdf-1f10-44eb-b09f-08ddcaf3cec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkszSnB6d0xjQXl1eGZqdUZReXM5NW1DbTZxd2FzY214NytnTHZFVlZLUDBM?=
 =?utf-8?B?dzRFaTc0VlJHakw1R05PdXZ6ZmZYOUZwL041a2FRYThqaHhmbzNqRkF3ZVJV?=
 =?utf-8?B?REVzT05wdHlMK2Vvdi9UaHFWOUFFRTRMOG14SFFMWXZlb2JCYjJkZmhsZk9W?=
 =?utf-8?B?V2plbGtPZTNyTzIxUXFWa0YvVWl6d3laSWdsL2NmYUNMSlk5NXVSUjJaQVJq?=
 =?utf-8?B?RXB3aXdaQ2hzTzV6bkoveHVqME0zUWp5eVkrOGFNSUZkMEtlTXJrQkh6VnJo?=
 =?utf-8?B?ek1LaUg3Rm5OcytSaFRsa3ZkT1I2OElUNGhxeHd4aStIQzlCcG9acFQySGc2?=
 =?utf-8?B?R2VMM2RUMU04K2NmWnJhYUxOYm1TbzF0cmVGOFZFbk1Sb0NYTVR1bGt1bWlk?=
 =?utf-8?B?ZFN0c1BHT3puNyszSUdZM1lWazY4Q2Z3MUw2Wk5UK3lsd0lTN1UreHd4by9Y?=
 =?utf-8?B?dStmc0tva3VIUDdMS3J4NnFndVV3ZHJiVXBTYnhhWVZ1YlkvT2l2THR2YjZx?=
 =?utf-8?B?RGh5TUM3UTZvVG9HeWQwR3BsNS94UzNjSVZaTFZwZjBqQW0rTmF3Mzk0ZkJY?=
 =?utf-8?B?K3psVElrYTB2UC95bERTb3dtdzNsMml5WHFmQ25xWHBwcVFISmxnejBSU1FG?=
 =?utf-8?B?azZ4V2wxRjhhWEIwUUlVODB2VDdkNnBnNzdiYzBKTU9FbVpHYkJrK3dzWkFB?=
 =?utf-8?B?TlZUSGhwUjZWU1RXeFNQbFUzS1ArNnViOVZEd2FTZ005MjUxT085THlEUVcz?=
 =?utf-8?B?cXVaQnYxWmNrREIyWW1OTEduam95eWxuamF6Q1pkU0FZaFJOS2g0US8zRlZJ?=
 =?utf-8?B?UkdtYmlPSmpRTzZaWXdyMys2eHRhU3pudTJhRTdCVG5jcCtJOEtJZUxTME9m?=
 =?utf-8?B?TUZLTWcyNmtDQUNkVENiYVFCTmRLWDd3SitFK0V4cWpqQ2w1OHJ5SGpBeXdQ?=
 =?utf-8?B?amVDRytLU2pxTzVVTlg2ckFrRmVpZHNqS2tBd0IzbFBpczM5c0J0WTVNeE9D?=
 =?utf-8?B?K2NOWElOb0NtN1ZEVVpWVHdWdzd6dDQydSs3ZzMvZXdvY0ppWFZBQWdkcEFZ?=
 =?utf-8?B?cmN3cHNkRDl3UHJpR1VhcTJVVDdMRzhhbVpRZWtZVE1tZXE2eVZVQ0VPQVdj?=
 =?utf-8?B?SnJTZndJMHMrTWhGVzNaV0FaMGV3RlFpZlI3Q05McFlWRmhlNmVjUWhiN3ZU?=
 =?utf-8?B?QnlXK0Nuem5JTktTd1RpNFcyU2owVmlWVjlpMk5EU3NjV1B4dWtGeksvVTNU?=
 =?utf-8?B?cjBmSXl1N0w0TFBZNktFems4ekppdUlTS1JkeC9heElxYkdDN0pQS0RoN2p1?=
 =?utf-8?B?Ni8veGFHVlZLODU5RVhnQXBPd2VySndkZnlvODZWbDdRR0hmUEd3V2Q4K2VV?=
 =?utf-8?B?MUZsdFNDZUhIcEhMMi8vdEFTK1hUejJMV2kvNVVDSmVpZCtiaVJaNG13aGN2?=
 =?utf-8?B?U2pUYWN1YjNCSENLM2VNcEovYzdEMHlRaVlURUpSOWg3cW1HWFp3QzV5SXJ6?=
 =?utf-8?B?UDFuL3lobFNnUmpkYjZZNHdyUG1QWTVIOWwvWU91cm9hQWFqZ0hVQlJvejFu?=
 =?utf-8?B?dE9hSmxuMXEvMytvSk1VYVZqendNMHBvZG9MSzU5NnZuTDlsUnV3bDFIRnV5?=
 =?utf-8?B?TjBmSStxVHhBVTVuUERETVdhTW1sTzQwQWNoT05RNktoSmJVSjJwZ2NGZXdV?=
 =?utf-8?B?Z1IrcTdZaXJ1SmZ1N2J3cGw1TjQrT2dPa1FYUDNqWkgwRWtxaGJYYUYyTXIz?=
 =?utf-8?B?R1JCR2w1Q1d4eGxISTVCUnhPNm5wOEY3VGxLbWUvMzdGdEY5QWswTk1jZ0JM?=
 =?utf-8?B?YzB4UExTRGE4U0VNZFRnaFFNZi9TQ3FFVTQxTFlmNTZCTUdndmRtMHQveWIv?=
 =?utf-8?B?dkxMNEhGcVUzSlJPS0F0b3VYcjlNVkt0cUw5ZXpGNXEvelRmTlJsTTNLWko5?=
 =?utf-8?B?UmlTMytTWUlWdFB2ZGxKeDFkNUsvSER6VUErYkVaTW1yWHViNFBYTEhlTzNp?=
 =?utf-8?B?RFhQTC9mSVo0Vk9YcSszM0YrVllMVlpOQUFOSWVDNENVTUlvaFQ0dzlYeUgw?=
 =?utf-8?Q?LEhwNS?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:51:05.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1541bdf-1f10-44eb-b09f-08ddcaf3cec9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

From: Shahar Shitrit <shshitrit@nvidia.com>

Enable configuration of the grace period delay — a time window
starting from the first error recovery, during which the reporter
allows recovery attempts for each reported error.

This feature is helpful when a single underlying issue causes
multiple errors, as it delays the start of the grace period
to allow sufficient time for recovering all related errors.
For example, if multiple TX queues time out simultaneously,
a sufficient grace period delay could allow all affected TX
queues to be recovered within that window. Without this delay,
only the first TX queue that reports a timeout will undergo
recovery, while the remaining TX queues will be blocked once
the grace period begins.

Configuration example:
$ devlink health set pci/0000:00:09.0 reporter tx grace_period_delay 500

Configuration example with ynl:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/devlink.yaml \
 --do health-reporter-set --json '{
  "bus-name": "auxiliary",
  "dev-name": "mlx5_core.eth.0",
  "port-index": 65535,
  "health-reporter-name": "tx",
  "health-reporter-gp-delay": 500
}'

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  6 ++++
 .../networking/devlink/devlink-health.rst     |  2 +-
 include/uapi/linux/devlink.h                  |  2 ++
 net/devlink/health.c                          | 29 +++++++++++++++++--
 net/devlink/netlink_gen.c                     |  5 ++--
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bb87111d5e16..9b996d0abfd3 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -853,6 +853,9 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: dl-rate-tc-bws
+      -
+        name: health-reporter-gp-delay
+        type: u64
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1216,6 +1219,8 @@ attribute-sets:
         name: health-reporter-dump-ts-ns
       -
         name: health-reporter-auto-dump
+      -
+        name: health-reporter-gp-delay
 
   -
     name: dl-attr-stats
@@ -1961,6 +1966,7 @@ operations:
             - health-reporter-graceful-period
             - health-reporter-auto-recover
             - health-reporter-auto-dump
+            - health-reporter-gp-delay
 
     -
       name: health-reporter-recover
diff --git a/Documentation/networking/devlink/devlink-health.rst b/Documentation/networking/devlink/devlink-health.rst
index e0b8cfed610a..07602f678282 100644
--- a/Documentation/networking/devlink/devlink-health.rst
+++ b/Documentation/networking/devlink/devlink-health.rst
@@ -50,7 +50,7 @@ Once an error is reported, devlink health will perform the following actions:
   * Auto recovery attempt is being done. Depends on:
 
     - Auto-recovery configuration
-    - Grace period vs. time passed since last recover
+    - Grace period (and grace period delay)  vs. time passed since last recover
 
 Devlink formatted message
 =========================
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9fcb25a0f447..a47e7f413511 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -636,6 +636,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY,	/* u64 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/health.c b/net/devlink/health.c
index a0269975f592..1e9a2d0d0631 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -113,7 +113,9 @@ __devlink_health_reporter_create(struct devlink *devlink,
 {
 	struct devlink_health_reporter *reporter;
 
-	if (WARN_ON(ops->default_graceful_period && !ops->recover))
+	if (WARN_ON(ops->default_graceful_period_delay &&
+		    !ops->default_graceful_period) ||
+	    WARN_ON(ops->default_graceful_period && !ops->recover))
 		return ERR_PTR(-EINVAL);
 
 	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
@@ -293,6 +295,11 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
 			       reporter->graceful_period))
 		goto reporter_nest_cancel;
+	if (reporter->ops->recover &&
+	    devlink_nl_put_u64(msg,
+			       DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY,
+			       reporter->graceful_period_delay))
+		goto reporter_nest_cancel;
 	if (reporter->ops->recover &&
 	    nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER,
 		       reporter->auto_recover))
@@ -458,16 +465,32 @@ int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
 
 	if (!reporter->ops->recover &&
 	    (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] ||
-	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER]))
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] ||
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY]))
 		return -EOPNOTSUPP;
 
 	if (!reporter->ops->dump &&
 	    info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP])
 		return -EOPNOTSUPP;
 
-	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD])
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]) {
 		reporter->graceful_period =
 			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]);
+		if (!reporter->graceful_period)
+			reporter->graceful_period_delay = 0;
+	}
+
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY]) {
+		u64 configured_delay =
+			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY]);
+
+		if (!reporter->graceful_period && configured_delay) {
+			NL_SET_ERR_MSG_MOD(info->extack, "Cannot set grace period delay without a grace period.");
+			return -EINVAL;
+		}
+
+		reporter->graceful_period_delay = configured_delay;
+	}
 
 	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER])
 		reporter->auto_recover =
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index d97c326a9045..de3aabba37b5 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -389,7 +389,7 @@ static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLIN
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
-static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP + 1] = {
+static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -397,6 +397,7 @@ static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATT
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .type = NLA_U8, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
@@ -1032,7 +1033,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP,
+		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_GP_DELAY,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.31.1


