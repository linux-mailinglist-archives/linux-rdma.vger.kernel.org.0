Return-Path: <linux-rdma+bounces-13562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE839B8FB82
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79950420CC8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FF227F73A;
	Mon, 22 Sep 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SSDsxXwi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C8134CB;
	Mon, 22 Sep 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532763; cv=fail; b=EUcewkk+f4ESjOvAHkkFIrN5ZzYj8kjzwIdRfeBwhPb7cSw5Yn+ZdCbNEPJHHl87ge6J4iW92ogMFQ3pZOXmvS+QKTIvGTZ5G7ol0JFpOEQoVH7QoWnFWyr6RYOR0t20E9A8hSk5zsDZz5cn6Kai7rNKc4ImdOf1E+UnFCk5NAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532763; c=relaxed/simple;
	bh=QyK4OAwm2HLpLsZmlmFzL+yp2VERxIm1w9vQ6hup/P8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXJnmdvY8j0V2ADv3f8iDJilL5oNf3qdLdt+ZN6icWXsb6f0IbzQJVXD+omNZk038V0JxwqED6zpbeCZInbOWBAvTOlJ4vmvfcIrRssbwlFcF2rJgCqX/GEYDFmQWzUpq2skuG65sz9muDpviLQa0x+YEseZ26yQrwlyMakNn7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SSDsxXwi; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jog3YGaPkPsvIhsaaPBaELaOCzu0Qi8r3lTKrBn3pfr5rYOEjunAseQPOiumv+xSrZgj7ujxruPzVCjbAeSlisCEX3SJibMTamdEAPhiFouxokt9lpC2JXujqnkLYkllKg9AoBK7zzvaonPIxIxhsyeV1z7+cExJ5bz0IGMRFVKmxWoYp5Crx3nRa12rp3S6MVt+mxoo47pH9cxKY5mjXYUYjisoPXZl/TZPY3koYtsWBZd3QPWHfMEa8sQM+XRjKZXqWvkqaj6KOo0ozNbrJEanSoFjhRkRb4djgi0uxc323J/J81t2RGNFbXqxL1pPnDE3h62ZC22jFB/wU7Cg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWL31Bh8Jz3+ztCfHdD8m6fZS3uHkGavtjjONegBXC8=;
 b=XLxLFVRrXNFjltwm51ltNTyQbO7lHsPbQE7bGZCUORmaLKkKaT7QiDYUYX1IRbCDtR7csH4P5xtpsRich/bvucfXavft2XM4MTGTKSlmy1ohHW7muc3olssygsFVfGyjRhNKk3Hwg/WsfGmPjT73alUlgV5+iPLhm0S+ALN0chdK806gtDhst5Gly4Ae8ODoc8dezYHYY9sh0RBvslizUu/FOALD9Xm0q8cLDkbZCqtbsLlYMLQe3gXJwPdtHKiEQ65NelPgFx6RIPV9bwKzPcj88mS5IIeTvDuG8hJdZ1SkZM+CzrMkMxd4UuSzvx3w5wWsVRWV/m4UJFxwo+q1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWL31Bh8Jz3+ztCfHdD8m6fZS3uHkGavtjjONegBXC8=;
 b=SSDsxXwiOowxdrFB2Ot+8aL98OpCEbQ32lpydyB96Mle4e6GFnllImgWpRgnU5FGyyWifncP9aJBAdslXB4R0GFnub6WWJ2aYr3oLDeDpNZUu8vZszFEy2C64tnT9sRIsXT9Ap1RtNQftVOERsJ01dGGAjuyJCetOK7gDn1kpRsPfdP6maNaUZujkewpCO6J5wWOIv6CthJ99GvhE1f/FrI7TZdPB5NiEr/FJ/Ly3jmKoMmcm+Bo2dzLjfwwsuA9tgR1ycpRpAqOUCLd+FPzRBBbGhytnQwFV5qS3+PtL7nbeTzNG8GHCNnPQXKXEl6+vxw599PH7zugcLXmXQoc6A==
Received: from CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:19:14 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::6f) by CH2PR14CA0059.outlook.office365.com
 (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:19:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:19:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:19:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:19:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/2] net: page_pool: Expose size limit
Date: Mon, 22 Sep 2025 12:18:33 +0300
Message-ID: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: c80051eb-d218-4455-f2d6-08ddf9b9192e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nj0DMdO5iYXmTjwDzzQPJp3h8fz4KC658/J525F49lRUsi6tgoVxB0TSz6jD?=
 =?us-ascii?Q?uHK4LFrfxpS8UhXQ4wWVGW49TMWuZ7DWDkjUvbAsve8tLv4MeOyUq7j+Aist?=
 =?us-ascii?Q?FKcpXGPpmeIWCd07G0VLoC4CmoJzIVskxUlIvboTP1uecLUnmjsQ50KXfiKh?=
 =?us-ascii?Q?Cwkn4rwOTzj3E/JE7s6R1KtYyLkrqdalD9lcCj4E0391aiyGN9DbgJxNGXN8?=
 =?us-ascii?Q?CsjGp6hebgS9HgWII/M2aX+0qbwVmA5y0CTilh+NRbtamHmDeUVqqU7LqIHk?=
 =?us-ascii?Q?7oC/a2j6MsdFoM9M++KmyER/IdYNUcJUPm0Hl6huON0JNPimuJ0z8HhDhjYG?=
 =?us-ascii?Q?1LsdjJ5iR9EdPkLIFbHymaeRywIayae0QsggRS2KRKqydu6JOq0DdEtn+OSL?=
 =?us-ascii?Q?FhB8S+y9+2oydj9Oai+Q+Sye2Kq5f8HmoK7942Og9yX2TkmQ+aQFMzsBYYpC?=
 =?us-ascii?Q?mPB2EuzjBxGbnzixjnubnKd38ap2txaQGMsHI1dYIUY2q4znV4gAyl21fRnX?=
 =?us-ascii?Q?FSsrM8t7GJ4/ik84QwogPt07dkTZON848r52eix6pdy/Sojl69Tt6GX9TPg3?=
 =?us-ascii?Q?vSuWos88xWS5DfpHaybOAmDUbZcJM0/LLr9V1SzJ4NFfsyin2J/O7QzpHmV+?=
 =?us-ascii?Q?4LFmfXR8FEqzmPvdKnVZDFmQTF6zxXPP2KUqf9ph5rIU+4ufRp1nAQ2xE+k/?=
 =?us-ascii?Q?iPFHH2KBbzuhAjk6GwUWcR37iD0NPcug4yyzyz4Vg+H1+xGqdV3eedSbZh1a?=
 =?us-ascii?Q?EkLZHPwCWHxhJrHqmH3jpSatLxYbQLhrxU7pYxZ9dAZARYksV6GwMax4iOLH?=
 =?us-ascii?Q?PfytKHswLYy/fcdbEOfn+3FrmmbD+f5gRW/sSlors5DIufVaVLq+F38LY83R?=
 =?us-ascii?Q?IWDyDzjJ1C+BdsEoLx2yo8BAR8y8Bs638KRJ84wsInnT6ffnN7ocfYuYn8QR?=
 =?us-ascii?Q?trnEG0R/nKtPZd+SZ19PLN6ftD9spmG16SKqSNODEnJ/zXD6ShJRRsN/Xnm1?=
 =?us-ascii?Q?dW9sbSxzF6GW9M/j+v7NPypjxr7WLw48K0hoXavw83X8U/x0B6bro1P7uqRi?=
 =?us-ascii?Q?jushIkD3hfaW0c/j7uu23bcehAWaz+afhNGy+Jb2lIIQY4/Btl5P/zvu7pM9?=
 =?us-ascii?Q?jPhM0Wi1AWTGa8oe9Y+wpd9/D7YQFnVwLIPU3dYnwvUP88mRYoL/GvjiyazR?=
 =?us-ascii?Q?n+3HQmZ1lJUv1L1CxQA0v54AE9r4QeZBMeAIApSlIy/atZC3JTQc2FV3FZTM?=
 =?us-ascii?Q?Ht3dqRkzZ5WSHcYjoAlm1XZwtqR7LDCYAUsGZ8RsWfiVv8AnXYma1FM/GpGw?=
 =?us-ascii?Q?KMPtXM9DkaoimeWvJVAD7gGJIQuRHfvTWhinRi0JjIO0GpA/bqqixxbbg4/j?=
 =?us-ascii?Q?UUznnYole4jqGPr2xJgTOAO7LKQrmYxPDewc1g0o/GL61okY2yzMj/69xlQb?=
 =?us-ascii?Q?bkUKiF38jsMzmpaPELzJIdqVFkRSAdP46O5DnGjlTYxvlyS6p4axGk/0qAdS?=
 =?us-ascii?Q?CUzx8FRzNq9ou1bVFikT4sX4ZhjkWarz8oQD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:19:14.1771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80051eb-d218-4455-f2d6-08ddf9b9192e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639

Hi,

This small series by Dragos has two patches.

Patch #1 exposes the page_pool internal size limit so that drivers can
check against it before creating a page_pool.

Patch #2 adds usage of the exposed limit in mlx5e driver.

Regards,
Tariq

Dragos Tatulea (2):
  net: page_pool: Expose internal limit
  net/mlx5e: Clamp page_pool size to max

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 include/net/page_pool/types.h                     | 2 ++
 net/core/page_pool.c                              | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)


base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
2.31.1


