Return-Path: <linux-rdma+bounces-7739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D4A34CC2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEEE16BE71
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021F241664;
	Thu, 13 Feb 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUVyYBQh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFF206F0C;
	Thu, 13 Feb 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469754; cv=fail; b=I0p5MCeZZVa+eIhN1Z2xKqBs9YEFfxXQK7y1htILTJVzx+3nk6QYxhw4HcUdvrIgTsNGmRai1Y3IWZagl/x4IOitqQFDDGj60zXHkYjPWkpymlp+9V5DolIzaBMS76ik+i/KvE5+WbnwTWbwMXYxzizogY5KEOTuJiwiwYCXBPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469754; c=relaxed/simple;
	bh=RDy2Vrw/EnX/Kbv9ErEEpuNLS84HscdKdR0RN9zbgJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p56n9BawS5tIUOamwEREXcYI+qdrU+0n+JI6xaZjssBzBAk6qtFx4SuqCd5/UU39f9N3VZFQ4xuuJzone4T5dcGMcF20fzKmzE87OxbGrvqlyAX4a4Uc4MNCk3WVhXs3GMy3AdZ0BSJDHwjUqXliOzmGuBafNU09NFbxX1oKsNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUVyYBQh; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO1HLCUKQopIJN91Wqn74m2+F83ulsyfTOAf874RfrWlUI8GSJBAT7VLeRveQTjFt4mUXqXEMMbnSEhS+et7b4Rw6utK+fodTHn8NsBi6XI3FJluAIu5nLTpO8Z8J7dwCaSKnBAYIJzydCxBGASLIYm8CPLlS8t3NKsjRrz+L/OZ6YraWsJt5bmP+l8peyqdM4ZVfjjDF5e8Dbnu5HfxY0XTBoe5L405/DT+3N5se7gfyTCEWOEc4X62mmVhruzQPvxP9XWCdzb72oaWogxuv7MakOWr4teOTNXGDRAaKIhAFlnhMyIPuka2KcYzN8dyboOffkm1sVBHGDxwbyhMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BLvKQgTcj6/IL2ANvKAhtxLdujUdhXOzpJ5EIhupq8=;
 b=fw10XdijTlHnI6M3c7qlsH1W8rJE6YpzgIxlrZR6dQ/EcHH6biX8v4PiKqj7Jj21nVRpz9jwLqG+qrA3DQ28doz0sA0RVgvBtHC/HvHmfb7vSYZYYbJNNggzvTrvlcge1fVHR8AKBHb32EBf95r48/XxCR8lP8lzSaSFu64n0gXze98YPiVschjPJAYJfZ2Wq+dtGGvjDSWApHbrB3rMduC2BxbUKZulH3TB0oDaoCofGgN703TYx5LIsVd6zs0EbuV3vQWBRO8b5tnDeEYFuaGCECR86MDmv8+EyjQbKVf1Qo9sOtGS9AIZm8tqbMGGXMVgKoF8tI+uxZ7jvmH3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BLvKQgTcj6/IL2ANvKAhtxLdujUdhXOzpJ5EIhupq8=;
 b=dUVyYBQhpUCjU9NbuSvBWe6zDYoepNb9cH5+dPNj1b4Sr/k3aQOW7k0KeWh4zCw+HUMKtJl6+rFCSm9YGzS0uxUh0d835ZbK6MDAMJPAM0Ph5d+TT2fZ+1p+oBJ0ilgJRIwNC+owgeow3bb5c2ykWzZPh885xjuG3kApTeyd9RpFXkR65cuCed/+ui6zO2+UbqptJYfrwJ17hgG7SWnlGc0zPbZNJDWsxSRCqfiWNNgtz8tQAOYUN/dPgSS+2bi8h1jwoxQsZSTZxkoVod10jVSbZMbNMJk7QoYWiFoMz2kFk8nPbg+zD0KmAL5qxD/B3Z6ZQWFZycMCUxEHlKZ0LQ==
Received: from CH0P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::17)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 18:02:27 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::6) by CH0P221CA0034.outlook.office365.com
 (2603:10b6:610:11d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 18:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:02:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:07 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 00/10] devlink and mlx5: Introduce rate domains
Date: Thu, 13 Feb 2025 20:01:24 +0200
Message-ID: <20250213180134.323929-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 061454fb-6b7e-4598-c844-08dd4c5892f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T1uYlYxPNQMHvr7EK+EroFofB/tsC0Jm+6FGAmlruTMqHxTvDZEmvgVaXRmz?=
 =?us-ascii?Q?Y6dw/XJxRTPdslEIua1YOKCkxC+LAN0nJAAUhUKcIj7bHkWsnAFtZimSxwYp?=
 =?us-ascii?Q?eSBIQVTZGRRty6QS3a6N/qg7ohQvMoB9Ji2kBzClsEH1DaWOEV/8sOpRRZ87?=
 =?us-ascii?Q?dxSePjGc8oTBzUyLTKpble0tismqsaFkUJcB8K7cvtQIGtHXjKpTcaP/fOwf?=
 =?us-ascii?Q?CFuawxvPssxqP8h9xN8WxQIhEVOeNQFzSAddxRxlXURR2x8XwhNstznrK+t+?=
 =?us-ascii?Q?XBi/kxltt5gUsAzXzBDtj9tMhrHpUY53/cD599IbEOwMQwOW0ziwWuVBq45z?=
 =?us-ascii?Q?PHfwaLkyAQlt4x/dN/svfE835kAyBVF6Ac4hobwgYzkP8p8Q/akh9DgKA6wR?=
 =?us-ascii?Q?PGHxmZnodmdzJpHXgi6trZZEGbN6lPCrid9f+MvFbZPcbCEiZvvIDi1UtmVq?=
 =?us-ascii?Q?NCLlKyGaBTdr+Gdu+5S9Qh5i2BjZShsjb6V3EmTi8l1M+4RxD3aSBMxwZF1r?=
 =?us-ascii?Q?bexoAKPEX5MDI07QxGv70g9wbey8ZqAPsGCmHJwQ5kbLpj+3Eu51DVA37yQO?=
 =?us-ascii?Q?1VRM1EcjzmFN/ByVspZzgkzFYnxVR29kGuH+JBQkLui94lq3RkXDnJ3+rs4z?=
 =?us-ascii?Q?cXZw1aU2zwtkAzUnGmARah3pfFPgUu9/BvGXGP4iIw2pjrmbMLTpP2eQWTPa?=
 =?us-ascii?Q?GGoD77LCFgExP0IBxAI9kUk6VNMJCIRNSELSR9unjL+X2NJAYWePnOFLIM5P?=
 =?us-ascii?Q?MEAM9mXILyUkPq1QrWgv74u+W1DHhAoUYwhHkN5YWaIIe3waZLPTYW0XagPq?=
 =?us-ascii?Q?e/GvJMVf0Y4bIi9mbrkj4+W5gioNHOqLPGpJD4o3Rbpe63/tw8FLyHGiRAMm?=
 =?us-ascii?Q?6M4ITIU8uJOVIJnfiNyoSFHOJKCA5GA59fjT4bAbepLpq+laxdzvaaC/2i7u?=
 =?us-ascii?Q?Xg/G3MxPitDA1aZRe+pL8xw+r46QyR+N+MguWBoI7Ct3qieHAunfxunGEs98?=
 =?us-ascii?Q?I5xk8rnVT7oKX8vWrGLtiJb44Fki1WApRFpd/FYlphp7mfyzivih42ojfD5j?=
 =?us-ascii?Q?wGWf0iN7UzhsYlUxxD8ZHzZw0caEu4d04uzc4xdqcxBNitulR21YdsXtpCAV?=
 =?us-ascii?Q?dibifuCuhFfiif3R4wq+b7AS6poEZO6Mv7hLvBi49IdOzQOlpvAUvMoYUunF?=
 =?us-ascii?Q?s8MR05HGHB+KsNFChseXwG8V8lmvjByZbf56xk85EuXb1+i9HFwwmpqfE7he?=
 =?us-ascii?Q?0zD2gMtou9jGLQEUkmv9tj4YhtlaDq8oh+osRh+N5aoNyMWcWB1hm4V4AmYw?=
 =?us-ascii?Q?cxSVfBNgAJESPeLlr+aXYg3bziomLfTEnYHp0TidzuVY9aE0CW1ggWdCKkXL?=
 =?us-ascii?Q?Y+8EaZinNqiXq1/m1tGHrXpC8nNS3UbRqy7zH1NNu02Xl7l1Nb9LfOGXlwrB?=
 =?us-ascii?Q?R0r/fyucDHEV1ZG52jQPFNsT8I9JTlauEFEJpujJ2DYfAbrjVv6bbA9BOoJb?=
 =?us-ascii?Q?JhkCaB0k8whnsZo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:26.1395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061454fb-6b7e-4598-c844-08dd4c5892f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

Hi,

This series introduces rate domains in devlink and mlx5
driver. Find detailed description by Cosmin below.

Regards,
Tariq


devlink objects support rate management for tx scheduling, which
involves maintaining a tree of rate nodes that corresponds to tx
schedulers in hardware. 'man devlink-rate' has the full details.

The tree of rate nodes is maintained per devlink object, protected by
the devlink lock.

There exists hardware capable of instantiating a tx scheduling tree
which spans multiple functions of the same physical device (and thus
devlink objects) and therefore the current API and locking scheme is
insufficient.

This patch series changes the devlink rate implementation and API to
allow supporting such hardware and managing tx scheduling trees across
multiple functions of a physical device.

Modeling this requires having devlink rate nodes with parents in other
devlink objects. A naive approach that relies on the current
one-lock-per-devlink model is impossible, as it would require in some
cases acquiring multiple devlink locks in the correct order.

The solution proposed is to move rates in a separate object named 'rate
domain'. Devlink objects create a private rate domain on init and
hardware that supports cross-function tx scheduling can switch to using
a shared rate domain for a set of devlink objects. Shared rate domains
have an additional lock serializing access to rate notes.
A new pair of devlink attributes is introduced for specifying a foreign
parent device as well as changes to the rate management devlink calls to
allow setting a rate node parent to the requested foreign parent device.
Finally, this API is used from mlx5 for NICs with the correct capability
bit to allow cross-function tx scheduling.

A note about net-shapers:
The net-shapers framework is completely orthogonal to this patch series.
net-shapers does shaping for tx queues, groups of queues and up to the
netdevice level. This patch series is for shaping across functions, so
it is strictly above the netdevice level in the shaping hierarchy.

This patch series was previously sent as an RFC ([1]).

Patches:

Small cleanup:
devlink: Remove unused param of devlink_rate_nodes_check

Introduce private rate domains:
devlink: Store devlink rates in a rate domain

Introduce rate domain locking (noop now as rate domains are private):
devlink: Serialize access to rate domains

Introduce shared rate domains and a global registry for them:
devlink: Introduce shared rate domains

Extend the devlink rate API with foreign parent devices:
devlink: Allow specifying parent device for rate commands
devlink: Allow rate node parents from other devlinks

Extends mlx5 implementation with the ability to share qos domains:
net/mlx5: qos: Introduce shared esw qos domains

Use the newly introduced stuff to support cross-function tx scheduling:
net/mlx5: qos: Support cross-esw tx scheduling
net/mlx5: qos: Init shared devlink rate domain

Finally, update documentation:
net/mlx5: Document devlink rates and cross-esw scheduling

[1] https://lore.kernel.org/netdev/20241113203317.2507537-1-cratiu@nvidia.com/


Cosmin Ratiu (10):
  devlink: Remove unused param of devlink_rate_nodes_check
  devlink: Store devlink rates in a rate domain
  devlink: Serialize access to rate domains
  devlink: Introduce shared rate domains
  devlink: Allow specifying parent device for rate commands
  devlink: Allow rate node parents from other devlinks
  net/mlx5: qos: Introduce shared esw qos domains
  net/mlx5: qos: Support cross-esw tx scheduling
  net/mlx5: qos: Init shared devlink rate domain
  net/mlx5: Document devlink rates and cross-esw scheduling

 Documentation/netlink/specs/devlink.yaml      |  18 +-
 .../networking/devlink/devlink-port.rst       |   2 +
 Documentation/networking/devlink/mlx5.rst     |  33 +++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 144 ++++++++++--
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   3 +
 net/devlink/core.c                            |  86 ++++++-
 net/devlink/dev.c                             |   6 +-
 net/devlink/devl_internal.h                   |  34 ++-
 net/devlink/netlink.c                         |  74 ++++--
 net/devlink/netlink_gen.c                     |  20 +-
 net/devlink/netlink_gen.h                     |   7 +
 net/devlink/rate.c                            | 217 +++++++++++++-----
 13 files changed, 548 insertions(+), 104 deletions(-)


base-commit: 8dbf0c7556454b52af91bae305ca71500c31495c
-- 
2.45.0


