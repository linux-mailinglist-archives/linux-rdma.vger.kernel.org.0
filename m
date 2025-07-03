Return-Path: <linux-rdma+bounces-11892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2CAF81ED
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB7A3B38BA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9A2BD010;
	Thu,  3 Jul 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dGa5c45G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA3225A59;
	Thu,  3 Jul 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574436; cv=fail; b=p04at6OLwznhYV85ou+sV9W6TGEhyHA3CD2ImUkZmhMGMzpEC/J720G0ORaw2+ezn59SxL1iGMyv82DLbecfuBJyI/9PZetHW/jFo2CI4XwQq1nkdfo4uwPgWmzS50+PM0q8dPMUsy6zXLAF2LYBIqaOFdvTGI5ODn81sKN2Qhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574436; c=relaxed/simple;
	bh=rJq4WpJ12U+C4JjF8argAg+kph2ZFxiEobIFmmWx7Rs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VF9/S392s6rnce5hZ2t/PcXcNU2mWUneemwt9noHI1P1gMfXS8qP7Mmhn9bThuibUHHZQgf6NgrJQifUFRr6gBrlkyptAeYKQZjHZPl1OWRtZWp+WBlA7BMtF0AVph5zuzD/CbTS25ax8HoPaBtJgnreuoXlcvGsbeBCRaH8Ws0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dGa5c45G; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl7L7r7gFf9l6l4ZEHIGsmSywsEFlTnagwjvIIs5+a5jtPYNOkqKIIMFjvfGMPo8DN2RSQOK9z6s7abEhhZeUqhm8+nYhxSQFz9606xg24g4f4X0z2tT6nkv2bNTxRD2sNCW79DCZR0t5NnMNi0gLBajfku4poIP0RwwhQzPqxFnR06ZOEljLvp2ayH2G6GLWVaA2PZl4L9IlHd34tBuZt4V+V58N7zaY5p0aKlg52T4bESIQTDG7f9+YUOtrpvXqOy28h0lOBkCZOaGC0GzQOyLNvJSI5OqAxlrRWvQSD4xn9hUa0fVfmRae0inZEKOWuBk6h6OEV1UEBXQodQBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb9ZdrCCS/wDONGcd4lwL74BGmx54U4Uw/NAMEFWZto=;
 b=NRMl8WEpnr7dJefo00chrKWrgn2RSGIBQam4q8k6m+nI4TfIRLtUQqY365S+JJFxmTKx0SbVVTfM3zb91tIa5XtbGWcPyQ2rCLjQvB79ELmyu9Lp1f8XcCT+tuF3jA+To029bJ5Hxi9syB6FVaPQpM0Q1QGliyHvHny0S/XoiHgv3hcgiYudVpSC4cvGWKpo1rYoNNiIeLXyH4D4ygr6y/26dHzaniZ86uWC0RhIKdNhb/kco48LKbB1maAWp5iqP0OHQkowczCVSriCKK464vGDOIRxzvHeaNFXuv9yoXNMloaW0t4wqwE9d2dbuZnkdJqTmDNuNKUAOr53Xb93vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb9ZdrCCS/wDONGcd4lwL74BGmx54U4Uw/NAMEFWZto=;
 b=dGa5c45Gdl+s1oHzkE+yrrG3ZRUbz11bJyQKm3Aq+vt2Laq5pONw+WTIx/ZyOi9z/mnM6EPd4VDk3g8gbTb38Rqp0tNhzgFBdLDhVPYXU54Dr2tQ/I3vs7o6xRdxdFoCFYUCKeNuEV4tZIu3qIxQlFX0MlBTk4PrzADpg46T0yOCY9fw5HgUQEQVb6FGX0+1QiLes+gQ4dwsGWFO+bpmweFPGc0H+ID4Hj/zo53f+DxohYhVdDoQILtsF3insuWpy/ITqBx++rRhJHHp1QnIH5yjXj9w1YDyEAFknaDFF9aw2h6gUEkJfA9cfd6UomixoYA423Ia+tAF71SttoKYUQ==
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Thu, 3 Jul
 2025 20:27:11 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::34) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 20:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 20:27:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 13:26:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 13:26:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 13:26:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [pull-request] mlx5-next updates 2025-07-03
Date: Thu, 3 Jul 2025 23:26:25 +0300
Message-ID: <1751574385-24672-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: cc12e4db-7c47-40ec-5b15-08ddba6ffd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ph6Q1STFXJF1Bk90DlbVh6v9Qb6t6gb4IXwc+lc+TeoRP5j+1xA9gTDQ069i?=
 =?us-ascii?Q?rjR5UTeg7UlffknhuyZ/PPgsSKh0h9lF3cFVXfWivAr/Yuzooo05yHQQGzmX?=
 =?us-ascii?Q?kQ9YXNxgKwY+Klqad97Mwaua1xyiijDq/g3t5/W8yIAVI2hiz2q17j73owV3?=
 =?us-ascii?Q?SSa7j3J0Hvz3Cv9FALn+jSCAPwX2z7DAfD6eJMEDEAXJC81tveJ+cEIimWbe?=
 =?us-ascii?Q?LKQsaDDqEwhNVFpVNBr3ue6kH8YLxcpmQTkUM2CoqzPPZqtsOszA0qMhH35v?=
 =?us-ascii?Q?YKDcl+hOIY+rBsgkSrRc8Aob8+uxRJHAZJL3/i7YNgAPkgG7s+M4smGistGa?=
 =?us-ascii?Q?GI1C7UaBwChOFtsPLOptAkoGascHpZW/kdeI21VzHClprvTo/fsIzOmoQ7H/?=
 =?us-ascii?Q?fMcjwmljpP8fdoEy+LD5AhQIhtc+hc1arOvfaQeL9E6GN9kjdd2A0CjQZqnT?=
 =?us-ascii?Q?+A9x0MDYxsrJBU8kuJOn7HPdondqFHO2RDdz33HdIwuY3OP00nHHIlK3soFP?=
 =?us-ascii?Q?r4F9/g+2vLPTW0VjWKkTowqY/iYLzChsz8vwqKvtpglBHXBmmnNG4SQrlU5B?=
 =?us-ascii?Q?YyQyz8J6YHiR6VQQwoTg2ySqWP7wyyyIiHybrnGpLMnbUK4wuq5PptaNmC9p?=
 =?us-ascii?Q?GXBpixWMNOULCWQLfbWMpdZiismn+PoGPl5kyV4AGCtLEbei1LGC3S3Z7dCd?=
 =?us-ascii?Q?5nvXo5PIhy94g/zfMTV7d9p+faRrBG2fnxQFjTU/oPI86ooU7+vksNdq19UH?=
 =?us-ascii?Q?DSkhhkXVKInTKuExYfhQwkCGoqRBcVZH5U2xOeEXQY9EJFJotIQ8A6Z5bY+7?=
 =?us-ascii?Q?MPlFgixzemEgExs8PV9ZAuNRYg7m3vh3nOe6uCWCT69WBNbmFfDgFerdrV6m?=
 =?us-ascii?Q?nP7xFyQRm6DSmuLCFVGSBwNremYBu0CC1Ms3mArpTcFGuvCIJTvl29EeJOwM?=
 =?us-ascii?Q?mCmTLzi8Kl8GkGHFKaVjXWIMDWKVGAF3la2Dh+0WThzPUgPcr8tjnl6svd19?=
 =?us-ascii?Q?4sxCnKdrnaJR5guCs0fpC6d/Db24XlPjZAG47hHWQTTJsL4Puqrofkv5Kbra?=
 =?us-ascii?Q?R1MJKJBfFJ5rvpMkBKV3Df+kCltd24Ie4pIl8YmDe4yPlQU1rAeyRDtXI7kN?=
 =?us-ascii?Q?gkRFJaMh+vlKjQgwXfIrzUn545eeZYBDvErFrqQFd2icgP7YWRfAaNr4B1gi?=
 =?us-ascii?Q?SjA9kDAIOt9wzC077rTe7GPOdx54YCbeaDZfuQsmfxHwHiG1qdQlRdSMNlj5?=
 =?us-ascii?Q?drICs4yA4E96jvQ7IkpVE0ozbEbmL3zhz19MmIT1KtJAUAD2m+r+RfubrzX0?=
 =?us-ascii?Q?h5TKeBqf425UIF8qS2W82g364KHIv+gRQbpuhHmR7evEPIpgI22DIFUXXHkd?=
 =?us-ascii?Q?w0hhalzGE9C/4W4qbyB2F5LN7SO0pOjenH4j4I4n/kMbpsfEwjNexgaW4npJ?=
 =?us-ascii?Q?c/ibhKwl+exjyit/TzXqbCk8WpcIvBKI0WAVDKqExsUNyrOyTzkE+gr/Eivu?=
 =?us-ascii?Q?lyqXoR6+09Wu68d3JACSzaRajVFx+gvad/92?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 20:27:10.9632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc12e4db-7c47-40ec-5b15-08ddba6ffd51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git 02943ac2f6fb

for you to fetch changes up to 02943ac2f6fbba8fc5e57c57e7cbc2d7c67ebf0d:

  net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow (2025-07-02 14:08:18 -0400)

----------------------------------------------------------------
Dragos Tatulea (2):
      net/mlx5: Small refactor for general object capabilities
      net/mlx5: Add IFC bits for PCIe Congestion Event object

Patrisious Haddad (2):
      net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
      net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow

 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 44 ++++++++++++---
 include/linux/mlx5/fs.h                           |  2 +-
 include/linux/mlx5/mlx5_ifc.h                     | 67 +++++++++++++++++++----
 3 files changed, 93 insertions(+), 20 deletions(-)

