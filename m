Return-Path: <linux-rdma+bounces-15980-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SODoNNYJdmnYKwEAu9opvQ
	(envelope-from <linux-rdma+bounces-15980-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:17:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E43807B5
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E3D3008212
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793ED318B8B;
	Sun, 25 Jan 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rY3U6hgg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA322CBC6;
	Sun, 25 Jan 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343440; cv=fail; b=MLsKOeErxGUyfBRKa1OUszZoVE/+cA88V0wuJIL8CTXqaZ7Ozkxl7De4Dln8xqeLo10Trm2GZb76E2/yENx8EEfqG87FDFhe8X3JaVDj9pYf1lY/+5boBGzkvQvHdKltRFurBlHMjVI1cxmiBd2teMNvkwTxtmgAO49SqIp4gE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343440; c=relaxed/simple;
	bh=RTq//P85vpSk/UtminMHlTqIyK7EJUKpWLcN5GxIQsI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwTyZtuM1REePuKUvbzXcCdn1lKY45iU79LOepoUQQTpnQiw27x2hN5oNcTn3K42wk0MOAyQQUiaUiVgXP50eJygf2vHDXnTrKM/7PPvDYbb73eWosGlBYp/UEX6eOjc8qet2MO2JV1Y+CJee7/Qme4SX8nMddsIEdB8/kXfQRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rY3U6hgg; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoDRPfH6qbf94MFF25CoO+8XjR/P+rKpGQRuBgs45tZuaObc8Q/jLNOUOoxZ7LQIStSirKGmwxTNx4V2lNIu/6Q3ts8XVb0vdQf5L7x3qO/5Qmp5mt1z19Jl7HEQXwfVW+iN2CIT5ojq0aBGnBWgyK/6aZMsoxv4IjY9fi0XQVbAcXLG1ayRri3175LtvAvOWL15f/ujztHm1doQW/wdN4MLGS0z9ac2H2a5iCUic71sT+UsE7ZWMNk3QvpJitXClr/dF5LpH9y7JqYfx7z0zX8NET0ZQPGRWC3VNCJnCcTGkR4Zcd3Jg13km1Uti5daiSaN3+V4/kA+OpfJAzgH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9IYKWz+aql+20Xb6xr8G7VRJwRJN4Jg/sN9ufNwxq0=;
 b=I2xuDTY4pOsKEaKNdBwlhoQNo9VM6CffLgWTc8fWJZgZ8hoMH3+5eKz+AD1q6cTw2yP77KevrOLtt2ACKUDBdWh8TgFu0cIO4xpkizyOFyBbPawhUZ54JQQ9TN1eLn/BVl2BW2D3yPTuQ0HmDQzJMZJDhmEuVhGqd0m44I/WjnPMEej/fnXMfoz0bli3lsFSI7o6J04LVtuAoxEyH9K1G6d4kWzKHPGVKPKeS43WSR3VtDa/kawtcyZy4pv41EsSJ79p3pxYkYC9E/yLZ6QhRS1JHHqm7Chpq4dJujsG/SbZTCGyHY34nto+bB3NGhu00y1n616hGT5jITSzzUBG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9IYKWz+aql+20Xb6xr8G7VRJwRJN4Jg/sN9ufNwxq0=;
 b=rY3U6hggnDNhQk5BaQapXlcsDC3GmnE1mkAvdX4ZMwcrAaQTJzHHd3jD8i30Q5nRA5t2VgcfPfKFvmR54eG5oSNT15eVTphs9CCKYO2fUYLZkeX0+svvzehX0BNrWDko3dsLnf1RhJCvN7ah4tOFaepSSQuGJsF+K8vdCTSCK0R++gQ5Gv9syqRQ3e+jyxYrvZN/5Oi8VlGU0ySexXXcl6nxTzMXJCmOL4D4hpBhi82HUmhIVnWYnCxYOFfJk0I0v/w6pSWigErPa87QyuslRecdvGa8+x4unbGskA67WCjS+zq7DfWhbhCXk+056erlyyxwZRnF7dALn6AlnVk7eQ==
Received: from MN2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:208:a8::27)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Sun, 25 Jan
 2026 12:17:15 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::f) by MN2PR12CA0014.outlook.office365.com
 (2603:10b6:208:a8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 12:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 12:17:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:00 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:00 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 04:16:55 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Igor Russkikh <irusskikh@marvell.com>, Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 0/3] Single MSS length in UDP GSO_PARTIAL
Date: Sun, 25 Jan 2026 14:16:46 +0200
Message-ID: <20260125121649.778086-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 42de47b3-c204-497f-0d36-08de5c0bacde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zx0EaHiNOyMF3qyvhldILKHqEjrPRvtMPyjWqzBR23yj9hg2KMX9NDYk7DBh?=
 =?us-ascii?Q?Mte1A/BdE/IFfeBjwK7xR/P1VSkDnMz860HDQe3xVOSmMZiyqFg/d/HOyyBS?=
 =?us-ascii?Q?b+GPWH0ChYeJ4A4EMuujRhViF7amRh2NDZkESwyVJgOlcjtZmSeucroRzBDm?=
 =?us-ascii?Q?7vxk8ltNorEwx3Kt2Je59CO9ZUWZ24YwQLgrFNDNV6tNTUm9tlq0mfe+mZ3N?=
 =?us-ascii?Q?WNkxd92yjlDQ1KSFzuDyYtimP6x3xrcFIcGUgmYp3t8Z5CDlrIMK4oVZ97pT?=
 =?us-ascii?Q?qBRarfV0uUjMRcJVulmktyjasTj9Skq5rU/0LL3dGWTzsOtR3P0IYJ98mKK+?=
 =?us-ascii?Q?euCBB69D6QLzXWX+Q3zOJtcadFk59sFFuREdUSRVh1EzRUO3N87gTjT5TkYp?=
 =?us-ascii?Q?H4HEtyzRyoJkGPahk1YSsZN80shWYeHD8HTKvJSVGHGIQD0CNumVfzhGJL3V?=
 =?us-ascii?Q?/hsDLBMrQdmjy+6SqzmPX6jYvsUwTtvuYnMueD/l+vDqTFlCjFHe4Y6BYJ9K?=
 =?us-ascii?Q?/8vuQQwZBJ727+viV9Ed1cPU2DgRyrWctt6khllcgsXwxeKelvXkHu+dM04+?=
 =?us-ascii?Q?wRoRXrSNmPMHMmIjuiCApUmXE+D0iXHjYrj481J6rku/VBLugR/cz/TYeFJh?=
 =?us-ascii?Q?Lp7oNJDb31NCKveEdGqMTnCfmj9oybjkJiE7MIo7WU+BORl2uI3uwtCS1/JN?=
 =?us-ascii?Q?OXDjI3KbWK5NaZFE5NabzuMb5MLGclir/uVSHJHFmoIS0ewblFbZfcOS2kbp?=
 =?us-ascii?Q?xjdxiiY82APpsamXQ8K97xWSykcodrdF4Q8BzvTw2b7QI+RZbKzJ8nYGHyGR?=
 =?us-ascii?Q?gYSmVGkBKxpJM50BFaVR6Rk3nTea9dDIJP89q6+rTwt7aLNKhgmljdLOf433?=
 =?us-ascii?Q?mqxm6ajoAdjFYN3BNtcrLXTykUbgLkDUcOYsUermphpJrtY5N2+Je+yM7pn9?=
 =?us-ascii?Q?2JuLBITQLEhfAIfyq5caiGW7x3tfZHvuVaxCoMVpug5WeFzhZJNRVCU0RYcW?=
 =?us-ascii?Q?37xZhGaMmDun4a7334TSWhLFXxpx8QaNdxJ41YUJCjPq4kdonrZDxbYGyH6t?=
 =?us-ascii?Q?jlz378KcOIJGXdnCJ97uwvVXNZAbC3C3mwiGG1q+k1dHdpMZ67HHBzup+dZm?=
 =?us-ascii?Q?w8hyrocZfv9uHBTbvWHMjdKBMfFvMsAMbzq/a/V9/2JcVHka0Akjn61xZHDM?=
 =?us-ascii?Q?FZrAFxtsRDQA3/I3kyvMTxYB/OZQ0pr0zdg5sBAbVqmPUeTFinRgGp9WTQSU?=
 =?us-ascii?Q?i3KYP3l4ZraUQxOh4EzqzvOvg2Z+JgNthL2bQXw84mxjgy1UbIFJG8Ghpvs9?=
 =?us-ascii?Q?rHR1Jf4naJcEyYIcpKP2KGHBoB6zsniFruVl2xNhK8O6uX8TvZxGuaiTh/pp?=
 =?us-ascii?Q?X4K5Mat4WwrLjSn8Dmc9/gi5VWtTB8qVqpytTA0zx+Lkp+CZA3OGveB/rthy?=
 =?us-ascii?Q?SOuAK5Ob0/3d2LnZOCGCrSzr7d6/ykq2smsP+k5qMSytqUSG+3FMbnqLFAyy?=
 =?us-ascii?Q?nOpxG0F6N8hiuqOzS41DuTqCh4cwe2+Zf0s29245dXHSm8dl0oU3XfnEOwt0?=
 =?us-ascii?Q?CblfYorgWPTAbMK9OH9vhFAcWM9uC2K1XR9IICp0dxva/VMb0L2W6lkt32u5?=
 =?us-ascii?Q?k9QqPsCDk7IWnDhjnqbnSGXM0gQL/hTF9XTsYRIAUhBpAUPUudj7n8CvXI7y?=
 =?us-ascii?Q?Sgd5KA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 12:17:14.5964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42de47b3-c204-497f-0d36-08de5c0bacde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15980-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 21E43807B5
X-Rspamd-Action: no action

This series addresses an inconsistency in how UDP GSO_PARTIAL handles
the UDP header length field.

Currently, when GSO_PARTIAL segmentation is used, the UDP header length
contains the large MSS size, requiring drivers to manually adjust it
before transmitting. This is inconsistent with how tunnel GSO_PARTIAL
handles outer headers in UDP tunnels, where the length is set to the
single segment size.

This was originally suggested by Alexander Duyck back in 2018:
https://lore.kernel.org/netdev/CAKgT0UcdnUWgr3KQ=RnLKigokkiUuYefmL-ePpDvJOBNpKScFA@mail.gmail.com/

The first patch fixes the core UDP offload code to set the UDP length
field to the single segment size (gso_size + UDP header) instead of the
large MSS size. This provides hardware with a proper template length
value for final segmentation.

The subsequent patches remove the now redundant UDP header length
adjustments from the mlx5e and aquantia drivers, as the core code now
handles this correctly.
I couldn't find any other drivers that support UDP GSO_PARTIAL; idpf
supports UDP segmentation, but it does not use GSO_PARTIAL.

Gal Pressman (3):
  udp: gso: Use single MSS length in UDP header for GSO_PARTIAL
  net/mlx5e: Remove redundant UDP length adjustment with GSO_PARTIAL
  net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL

 drivers/net/ethernet/aquantia/atlantic/aq_nic.c |  3 ---
 .../mellanox/mlx5/core/en_accel/en_accel.h      | 17 -----------------
 net/ipv4/udp_offload.c                          |  6 ++++--
 3 files changed, 4 insertions(+), 22 deletions(-)

-- 
2.40.1


