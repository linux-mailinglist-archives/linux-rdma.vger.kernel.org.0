Return-Path: <linux-rdma+bounces-13368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F070B57AFA
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F9E162276
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDBA30AAC9;
	Mon, 15 Sep 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5PQqkKG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AE30AAAD;
	Mon, 15 Sep 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939141; cv=fail; b=qDk1WAYAkmSU9TuJMEVosXw4Bs+0CWga9SErWzv55SC6EHNS3qBxD0KtWHiU77eCMIv8v0tVp6OhksX34LcraD7YRw74YpMYEdN0/rHx2mBNGnNX8kVvY3IaBvoiDLAPouQCGOWLmcLxWOsdsum1LFy/q2d6GKzszivOJmvRsZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939141; c=relaxed/simple;
	bh=8iMdjiDBOiAuBI+kw4ghl9QJPiyTf6p4ohKfnYg8eKw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WE/ZKbIz3F2MllW7tYw9BQRJ9xDz9G5l878gzLKhTMTQoDXaH24br9VyNHeg5GDBqzziLtAyg5rz2Yj5vtsFEu+SfkvGGt30eGwDss5BEd6kwaJ01YrxDVJsaz4ifjKqAJ9Fqmp6/GIzMmNWNOuKpUz5W8l+Gvz2sBNxk03EqOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5PQqkKG; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjZyUhhof3pLMM/IJqYRYkEuIsmLXqELOHtdWV57A4QbG89b9v0hLYj7SRApwp1baHOIGZy1mCYXZVOIBnqFnXF+jlwagKI9TiW9STfaCM4UTn5KNJ+vibWpRI5BkKbhiX/LWgaCqJsac/gAgTj7ZyRTsyeVh58De7GQiM6qiNj7m7zJf0fRf2WAs3lqssYse4K+r5BWbiZSsAkaays0U29FKUWIhXWfqAAiL1qXDenJilPVRVLyXnzD/3eIHtCViBBmcaqkT7mMs3eTz16nTxBITU16+NvNT3bMDtYrn6DDOMQwr5IOeAwj3to9Nr+Hx1NaN76MNFW6/xo9znoKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB/3nOm8kY9BZ0ik4InC+hvpDLmo4l0voE2Y38DFr+A=;
 b=b8xwiVIDWrc31iuMEbqQ5bkz2sgmnTLs9iIQM1L3vvOilve7i3ZUddw1stAcGHQ6e/EWbzY+Jckas22fRnE9ifFKYtatsh7bElpJASgH/+UWuo4agL8rEDfyej/v90s+ZP0K2mD2USNk6NpmGUvxBdvDOkaf/2Igd9dEnSpaO+jfprk9ynowqZbzIuF0mKZZ6wUemJYksBEwRQGn3+6B6TNkgvZWyskzJ2ncldWd7Whu6mQuREMQDOzL/NUyGjsfaNZNPp5mEAJp174yA447vhle3wn+mXoyZUxNHByHWoKkt/GNaXYGXTnDSsw3KAnv33AO1X+YW+CTKXXuBBd6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB/3nOm8kY9BZ0ik4InC+hvpDLmo4l0voE2Y38DFr+A=;
 b=I5PQqkKGYX6WE5BEW2G2cD6abaxnKNjfliVGa3yH84kfB3VXu798jKomRvgcfhv2qF0B3YKjzkwOEhvL237ROGIs5gNHIgQgX9H3UhPRDwBwSmp7qbWQEnXTngxNZw+5z+nKgg70rA0nFsf2+1ovRCUGl/i3XNju22u7sDlE4/+jeisf35wiO9XGZmqNDgSDss0Fr1WOszO8zHomiQHlYjODLqkR4fJxygUQy90qhsBnHliPPJF35tlDIDFQb4Rppwj9DkEcWOal06+4lmFrkKRELg+mHRAlK9ESFz30bKsdzrW1dtptHDiYNY6dadQlIXZb7fNzOJyUj7N3S3Dzeg==
Received: from MN2PR22CA0013.namprd22.prod.outlook.com (2603:10b6:208:238::18)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:25:35 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::7f) by MN2PR22CA0013.outlook.office365.com
 (2603:10b6:208:238::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 12:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:25:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:25:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:25:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 15
 Sep 2025 05:25:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net V2 0/3] mlx5e misc fixes 2025-09-15
Date: Mon, 15 Sep 2025 15:24:31 +0300
Message-ID: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bcb1e9-d901-4ff4-a653-08ddf452f889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXODMGl+jd1lPvZ+AoMlAbO1w+5e7Fxu1WPzTeG8WBlQrLuZwhRlNzJsSXdR?=
 =?us-ascii?Q?/q3CWQnDzdQ2GJxsIDgeebfXyd/pMKXefnPh7/R1+0G0XxwpAUMnpGQo2xEJ?=
 =?us-ascii?Q?WeISntK2avb5xid+Dk8NOoecKa4u4JrCQ5C63JaDa+WbdsQL+ZZE4kwd4/Yt?=
 =?us-ascii?Q?jyZ4OB0l1z0ivFGORDEaTYPx/1cYduw6yhbre6s6taE9IHmzRjDlVxCwpckp?=
 =?us-ascii?Q?ndOX3L200K7NaL7xFoler7EGv0deYplEUOcL0tjKAbtirojGvIKUuJTpW99I?=
 =?us-ascii?Q?7u+88g7eleA4MboOcSbsTwKsu0wxIC5aY5uLjEqtn+fkfwEiL4gYmvusYUFf?=
 =?us-ascii?Q?RmGieY3tIrcuG6NGGf4R4IEu7+pvVaAo8PstQRdDOrwZpDXjDw/tWXgClUT4?=
 =?us-ascii?Q?gyjtMCEnqacSVlYNGQxckPromLBqpZ+Ul79/kZnb0o5BGs7ISXTMUUTeUMB8?=
 =?us-ascii?Q?wOwLgkcrtm62H0KPHv7OqoIK+3EssOLIifKoKGRtqymeduyafnhV7XN5RYpi?=
 =?us-ascii?Q?/bRXwFeaNsfP9YsgSwABRIwAXEAu7dVDYnfAX5lucgg6wHcwsLNIg1s7JOpX?=
 =?us-ascii?Q?APKrqmLGBIrP7oenvMOiU97gZwt1KucKfDmwidWS+ZjzEWJ+LuYj93uODgwe?=
 =?us-ascii?Q?wVwCBY0ES5YPwnCvHaIaAPLBPEpcX4s//9awWmu01vLC1u7Zp7KVmrOxTbSY?=
 =?us-ascii?Q?AfEZl6mPOlGHo+gjQACrtuNhNQQrqpJ4Bl/wjiCzvpPd4Q4iS6AjoOHu+yWp?=
 =?us-ascii?Q?VsWJnZIzHfDameJPz7YmSr/Pb4+Mt6rad5Zx9qxm5IEq5N61PzAH558/WYA0?=
 =?us-ascii?Q?NVOpmnYiKEJ4GTjt1Ua6hZO/ihgf2LDuB6mMcMLTRRy2c5r1TJKaPtTwpQ/S?=
 =?us-ascii?Q?jLjLkEo+mE+Z+K4AKFwLUn40VbunQMEgUEM+9h8h1Z5yXJNJwcpcC/Ao2UQm?=
 =?us-ascii?Q?QpQ3dng6ybxi7en38HCxmlVOS2z6HUJXMMJ4LMgKIFKohiT3gh2wXp/RBYOn?=
 =?us-ascii?Q?oaCpjixgnbfaS2oJ5XGTRR46l14ZMY8cA9Nh030F2KEEKQ/C2KnmbInBixAR?=
 =?us-ascii?Q?QIF/xW7hYX0LBgFjyDXK1dW+1tdnZ+YtpZeJnDE3CKED2Ajlzd97K1xNY151?=
 =?us-ascii?Q?h/zyA6ZdOrdFP7ATI9+0hRFe3tMJTNR1e97BS2Y8pKgOhbopmjQ6IObtA9qP?=
 =?us-ascii?Q?MFs3gRsIY8HCiGTts6YTifAqxLcSN30Cl3mAT6aFphUPHo7cb/a2ihC9+qms?=
 =?us-ascii?Q?ajjMyBMboBVUmovVf6HhDlnbh4a8Lt/lB3h3gBUq9fOOIQE1SEoPSND2TPD4?=
 =?us-ascii?Q?7f3uG903CPJgncdfKPN4I/nHoOSh+2PzqlI8jVssOST4YhzYXpe+B6fnaLma?=
 =?us-ascii?Q?x0xivIgrDi8Wg7ICr1uBSr5Nu7HwF6Ywzq0vup/ZyiGtzADjirzxOLEd12Q2?=
 =?us-ascii?Q?jKmGNNIDeVqCP1nR3HASLVEdRCqYqARyO2vdrGZQiLOeFyKLg3xf9ll7ffoh?=
 =?us-ascii?Q?xJCN5sNrH6tOvuOUmPAF3oGbbcrZi8yHPfCeDHi6QBWLKsKeQtMPwWA5qQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:25:34.8896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bcb1e9-d901-4ff4-a653-08ddf452f889
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

Hi,

This patchset provides misc bug fixes from the team to the mlx5 Eth
driver.

Find V1 here:
https://lore.kernel.org/all/1757326026-536849-1-git-send-email-tariqt@nvidia.com/

Thanks,
Tariq.

V2:
- Improve commit message in patches 1-2.
- Move local var assginment call from init when the call might fail.

Jianbo Liu (2):
  net/mlx5e: Harden uplink netdev access against device unbind
  net/mlx5e: Prevent entering switchdev mode with inconsistent netns

Lama Kayal (1):
  net/mlx5e: Add a miss level for ipsec crypto offload

 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  1 +
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 27 ++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  1 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  4 +--
 .../ethernet/mellanox/mlx5/core/lib/mlx5.h    | 15 ++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 9 files changed, 77 insertions(+), 9 deletions(-)


base-commit: 2e5fb2ff31730786c05e0f18949143b05efa1212
-- 
2.31.1


