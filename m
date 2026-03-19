Return-Path: <linux-rdma+bounces-18395-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNyiA6nqu2kKqQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18395-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 13:23:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B83C92CB1B8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78696301587E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422073C4568;
	Thu, 19 Mar 2026 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I6kRhaRt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010042.outbound.protection.outlook.com [52.101.193.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF232376462;
	Thu, 19 Mar 2026 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922979; cv=fail; b=E1RVB9MPLNU1jhArVAoDP0LtN8a9TQNtNhJkCvdQJMdTAJijlxcl3ie37IWiKj1i9blCrT6r0eSgzS6412Gg8Z/wvbyDw9kl5KyEIYjIZIlBdfvIsI5d9XiPg9By/YQw2cjYAtNm9Kn1wbQ66AZD7vaqqqaucRR4lH/mHa+qEHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922979; c=relaxed/simple;
	bh=I+ee1dqIADszhIU0zM5jh0qd4dlyggEnjmlNOgnSaRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoO1gwKAaqlNzY3R8cYfgoHlG//A+Jp+I0GXu3/Ea+Andubc/tG9IRh/l7fKgTIFifTHmgC/+lqftRT/cnE//Y7e73EtO8BXHvfROaiwj5r7uQtyQcIshoFl65gGShBFhpwsl2JClhjcPtwbEIx7ZsiIkHY/I+DJOFNdW9SqNAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I6kRhaRt; arc=fail smtp.client-ip=52.101.193.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VonHY8DUpmM73BBAHRASf5XwmzqoweABbkqPxDfiO8E3B6IB75UpDovW0XifPrj380sZDiJ/O7Um2hk0r+f819CKi6wL+J661NDu+QhX0yP9LjDuro8RwmtYp8i90DXuK1MjowU9Ia9fr4YzIITFsvpk561XwdOwO1E3IbgdDssoCteEQvEbogRwu3BLIN7dEyCBxGEJwo4K1o65lUuQ7yfWVamxTb7PJj3S2T0DVI3LNAdRvUGUuKOZVSDYdSDOt2RwOMzWfOMJMvkG+j5nTAKiDgDUwatjXzxIwVbOVsd1ixHNgi4/QBgzXkv5tSzwMMzwEYiHMWBnQoTlzw8YoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdh4E0wEcBwA5ig4mWXvoh/LscoURrp0jtqx4CpCBhU=;
 b=ZImJa095BlSFtvT3OfwIJEyLTSmvGZOzYUPe2VuFbWbrYs4fgrlICgGDjhGMOS8Z5bR4/oA171rjdPx/DRcjx7hU5DPWLJz3L4uNmWekvDmDhgbzkX1FlW8QMcNvGNdPzzarML7o5H+RWF3cXPBm4goADd+RwAOoDC68lhpwPKOSWF6PV1WUykqTVcNspinAxuqbiw3CxNq6Ly/4najsB2x/7ncgcShovjJ/q8ERW0OQ2oPLb+Y//itb4pwNPkb5GA+Q0/JFqV4ErOzKvblw4Zf21TY8/7GoSMPLiSUgZl1fEShGqMGny7klmaEP3Hpgww0X9dQAoIy45KGqwVTg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdh4E0wEcBwA5ig4mWXvoh/LscoURrp0jtqx4CpCBhU=;
 b=I6kRhaRtAphTZFEUALWy0aRiAFLH6JjNw9uVd0DUZIm3pKgAMduoexNAHVBx+UCqnv7hohs3+MWC3f69kIkX/o3pHIJq7tuFF6wRZe9UFLm4FHD8cuVI1JbihOZ1IToFjT4Ikm/QDoi1FK+xDqxmWQ7RWVE5fbLN7QwU3dFT43Ku+i48v4NLyD4vEfMTadwqWbdjZ7IzbyWDicH5xCTv6MuEE2fqW3u4e494z2rlaVXWCmZt9OosUqmz2ZOYNlTtFcKS/2xSSpkGoqLOE+EiCHg3BA+A4HB5Bh4iXDvxFALw4trSHqfxMs8EAuNk64n0AhzxTSmAxJas3oGBXveZaQ==
Received: from SN6PR05CA0025.namprd05.prod.outlook.com (2603:10b6:805:de::38)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 12:22:51 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::60) by SN6PR05CA0025.outlook.office365.com
 (2603:10b6:805:de::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Thu,
 19 Mar 2026 12:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 12:22:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 05:22:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 19 Mar 2026 05:22:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 05:22:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Simon Horman <horms@kernel.org>, Shay Drori
	<shayd@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 0/2] mlx5-next updates 2026-03-19
Date: Thu, 19 Mar 2026 14:22:09 +0200
Message-ID: <20260319122211.27384-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3175f64a-fe35-452c-9a18-08de85b23d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7RPI8eeNkUQ1cmbkSKhp5+S9j5thv6VtlKlb2xOJK0ymqCMD2sNhMf7FQY9WYCDs/PEe1HDMbSQs/hf7J+9IJqbQF0+xQazJFt1xPv7esmN6xNkzvfAPzDTWU/djmrB+zlnqqy9C8G92nMNeYTDGIi+E9jkgY10XZWOg7z1FH1QNJt4sQ+KaCsC3DI6mrpJ6cSQ6DNGE9rAQ2/W1J0KFz68AKB16Som5YOscVU2wUvnD02bmXRXODppU+vszbatMEt4n12GIc3/9b2NDv+teeXvMGbip1sZ13tgExVWxLyvkdGNdT6r5Ir6zTKHT8TfaorrOcjPRzr3mg5SBr7UayMebi41e6HISqTYGzqHslF4cWI+sbnCvqTT5yU2eNFJ9uFnebGtloBLzma8tVsLNuHU4Z8OgdQ35LF+9e+GYhm9ybUyCvuaS20T26yMGV0gI4XKMc6iuJZZ4sE7gaZWSNg9vsPBJlkuz4sus/ToUr7PpndljqN17hO7LZTnPI7BfiIY/bM2M+8L0vgpEILg0rFHiOkwLCbIhzh44TwoNIvagkzVVy+nTfZqH+akLwXeLTsb8vrmxD2ZZOC2unI0je56CIpXVHbmWnW1AcOVqjy7Eo6jo5mDDCwNbENY6nmvrghYI774PzgxX627uYT1kzK1T17COFQDR+0QqydC3ErxPCYuUHqIAx40OcX9AazFw5BToPSm2wYannmDdwuvbK8xbw0sOEtgvzy8R5jtIKJGqUSe8r0isI6R2XTbuV7IAyZFQ5JVW4KkSaBKO1aHVag==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vx3h09bE33iedl43Sb+GuXXyaGs8D/1gkX+Wph5QuhfQeB8DJaQj8ljSs9YU+1Csg3aiMBZbwVCuUGHVD5jq1NK5bzpfCuuM2l4uSMSnNcRdv0vUuvpVMQ2qTyJVngq2Z2NuHgdCCO6yhURFIICfIUGuXArLCzrYWyX55DtSEGbeJxC96Bqdbf1n9JzQDGP5qpmgwBHl49zfjca8w4zTGNJRHAtFjecOPzR74R/WgYTuBVOvstP6LGWklnjvgAeel56zsIuz8+GrNMObVhwyAIZ+vMklXAbmIWZ30ppgyHe/PS5q8/c6tykAzhVwWzRXZHdFkntjiBqyks0dBbxlQcGauS1wg41HXQkOI8f8q7B/1w5Akz9V9VjcnlXdkzEQ7f45TsGgM7CtFqv5JDU7Fj0v5/g45ls8d8bo8PH4rcBcnfP2xbCzSjQTXPtzCEJ2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:22:51.2380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3175f64a-fe35-452c-9a18-08de85b23d5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18395-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B83C92CB1B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series contains mlx5 shared cleanups and updates.

Regards,
Tariq

Parav Pandit (1):
  mlx5: Remove redundant iseg base

Patrisious Haddad (1):
  net/mlx5: Add vhca_id_type bit to alias context

 drivers/infiniband/hw/mlx5/main.c                       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c          | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 3 +--
 include/linux/mlx5/driver.h                             | 1 -
 include/linux/mlx5/mlx5_ifc.h                           | 7 +++++--
 5 files changed, 8 insertions(+), 8 deletions(-)


base-commit: 4dd2115f43594da5271a1aa34fde6719b4259047
-- 
2.44.0


