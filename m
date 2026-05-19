Return-Path: <linux-rdma+bounces-20992-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGebHh7DDGqJlgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20992-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:07:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7795847C9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08AC43076176
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32263B47CF;
	Tue, 19 May 2026 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssMCxKFI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EB73B813E;
	Tue, 19 May 2026 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221135; cv=fail; b=JlZZEMOGdrjd8Y8pRh4LQXpGPVHhZV/ApzbO4lhIJkz8BnVW17Udb08TEQsA+iXbgafmF5JehPd7QCiQpSYumJ6gzLZ5O+nW3dwLih6CVuKJa5YRHYQRcKaU3E7BVneA66AgPUuxFDGUP5a/XEmrarG6iCkTBS6ttFxR24GCoqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221135; c=relaxed/simple;
	bh=I2Py4SUCPKlbdgTLhwruqS632kO6DAPTt3uSMB8nsc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QQGob4YCZjORxvCmJKEISjoNw6/aiajxG1z7xBnKmEOKmb8fsteORXfB2kfS7/82E2rJlPhyKU+leDLLXWy46EbxOv0HDwyk9tqqV1O+FNz6S6GCLwPA8vfvojSuKqKVwLsD6hgvG3WZE0JOyJz5y8Wlag18xuQk+qDPDob6IqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssMCxKFI; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=migMOO8MgTcC71mbwaqWrlm+/N3UyagkA8zG0upIacyGTPjEn5s/RnWOnED2aOFDDFxGu+p79tL54JxasqsdoyiB3Ex/c/pNtvUHws3RrtQkV7lYTwwy1QgedLosTr4qL168m8FJ17B3gTRpsuDCZkFioXIpuexqgj0rqTz3qPalnljypturIy7hK9Abq9s9qKLOQasy7pIdtLBPWRdgHanVya7eKKIQS0tcDJ3lEmVC1GS2JD6xD6bUdCrnScSdB3InLBPQcAqZdq94PYvK0UoDAYNVMe9hzm7LNzt9isRWkwIlB4f9PsEyNqYKFTjnnpR233IVYURg4Jep6W6qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSo1sJG48al/p0RCqat5hrLmREpJK0fHQBw6yYISjDg=;
 b=NLrgdrJEqoN06jQgs0kFNxBdLmkKbYVzJUplhaNDAFqYjy6OGrmcjI3g8pzWNM7rWkhiDWBbW6LkDcC5afCusZULBo9xo+U/98c+rSz/G3LD3ZFDo0wVWy4BUZvQfgUA9mYvToJqGHJryFIYESgsjqvpF4C4Mey768Tm/2ohiIUpReUeIfsr/Zvx8vjFrG/0vLzpWL5B4c562QLkLh3dF4PyO3Nvc5L1moTCVNlafg5LAi3oJVCxuGf0ouyrdPtYLVSzY1bXxjw0SMDi7jwJ4OU2UILha7ixQjX96539DBdwqVTywXyqiyDquZ+1rXDOGEDmLzwycUOoJ6KdzWtmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSo1sJG48al/p0RCqat5hrLmREpJK0fHQBw6yYISjDg=;
 b=ssMCxKFIdSP41zt0zK2q9FKPkLnuB4BCkifjN2Gp9OVpu4CFduip0q5rDApH3ai5RUPw3NQa6zrNk4mC49r4tSkigJt70dOqTFwjQSDsPeKSdABsq8FszGOLPURHnCEg49hYimmpwayr9p2xbKoNu0kQ56lW7PjKCN/XByn/YrHREMDjkQcNUffoCw540x+Ryj05S5pYUjbp8IWNtui2LJUUkoiJRUeX0Kait9LoRdyXkemnNcJHJuCvUm/q4dqIOf6ZBRWtoRAM/V+Fe+G10iz46/GS5HxMdoPPIq0B2/DGxydYCVXN+K6R474yJ6aa1OCxjHmY9m+yOjjimc7sZA==
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 20:05:26 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::12) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11 via Frontend Transport; Tue, 19
 May 2026 20:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 20:05:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:05:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 13:05:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 19
 May 2026 13:04:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	"David Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V2 0/2] devlink: add generic max_sfs parameter and mlx5 support
Date: Tue, 19 May 2026 23:04:34 +0300
Message-ID: <20260519200436.353249-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8105a6f8-cd2d-4745-d288-08deb5e1f79b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|11063799006|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jz09JG/OxNhLNN4kViHYUEAikTJ9maSP7Py9mq4KaZ72MgSpi6eBK7AkX3e7oJ9q11sSiTscCkaTVZlL5TbXBcFTQtFurZwJfWftLHQQnPV9R3+gZCVtI1XGO/B1vUSPVOdGEw8aaMQ7g9hS3dKvrEZOgtoYi+aso+89XAsl/tXHxakTz3FfTBqgdNPzBuFd1ddiQzOM+KfG5VAH5D6f4x6Gx8tPCQr3QjXDdPil4WRacqMbC923mJue9TP5RNl9ej/AaWwAIgYVszJetSX9mXBCS+SK9jenMAfRs+DLVOCP9BnyuB6yuTxoe0CQqiKjs/ntvq6eklY8cLE0CAOQ34ypZ2FqrHDyIO+aFnFkO8Mm050xdcnl4Y/MMK/GNVVIyzuF0FF/OSLU9yzmPfOQiRNFuoqkyMj1dBjwZchKB88FQhCjhkLQyPtiX4EZiqgr6doV867351k9cT0dWFWs99qOAU/pXDnWXHWm6NwNyuorValoNGiqrWuFjXb6yWHDpLRBxU49wkpKZ9lmhVF3RKSVPp4MkPr42FEj7CCFrS6t+dEM6LwlnjyzubtM8hdlYG3lYag2OMNStsH0nIlGj9BVcHULKThUzyVFS4mUJiDnssh73AlC5gWBbkMKEzcPg2Y2bj6+okCwvJbWyNMKMW/hcalZekFTzB3vh+aENR90ggrrxVw4YRJmTbVkapaCHHrbRINK4/OXcMp73moRgBT+tlKK0O5/1WiB7gb576A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(11063799006)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EN6yehCfTceyAKa89sx/88PwUU0RSltCC+b+JSLqGBRx+6GnCWQ8u26u9qQoiZSaPrRlWM5mNlf8aSVXt9vZQ2+d5cY/Zzp98UlzseCs4mY/Rt68vl1Q7y5F1bBrd7VlDXZh6Gu2byUUCsBlfmy9zOT1ijRnFNgig++5pFL5cs65HrZBKU2jcP15mhtHE0C/cIdWvCxAeV8SFDgkthq1mGawFO2U0SRQnPSJ7aGqOb6mhRlWxhWL05khzZ+rzhhZJ7TrqGRGywMQlbkMESaNK8xfkekAiXywe3z47SO+VoVozTy94fcp/oyXv0GNV57uyXNb4etogK8XMnZwbhBViIw0OVZHvpI7rCSQPR0Rj7Zt78mOr9ToR4M5zYP+O73KXOVCXToniSZdkMb9Y6dufSkrCy9PJGsvEUtfkT36VITFyu4ExMIVV0qJPNzwAGSl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 20:05:25.8776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8105a6f8-cd2d-4745-d288-08deb5e1f79b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20992-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EA7795847C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series by Nikolay introduces a new generic devlink device
parameter, max_sfs, to control the number of light-weight NIC
subfunctions (SFs) that can be created on a device.

The first patch adds the generic devlink parameter and infrastructure
support.
The second patch implements support for the parameter in the mlx5
driver.

With this addition, users can enable or disable SF creation directly via
devlink, without relying on external vendor-specific tools.

Regards,
Tariq

V2:
- Add missing ` (Aleksandr Loktionov).
- Add review tag to patch 1.

V1:
https://lore.kernel.org/all/20260517112700.343575-1-tariqt@nvidia.com/

Nikolay Aleksandrov (2):
  devlink: add generic device max_sfs parameter
  net/mlx5: implement max_sfs parameter

 .../networking/devlink/devlink-params.rst     |  6 ++
 Documentation/networking/devlink/mlx5.rst     |  7 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 83 ++++++++++++++++++-
 include/net/devlink.h                         |  4 +
 net/devlink/param.c                           |  5 ++
 5 files changed, 101 insertions(+), 4 deletions(-)


base-commit: 9bf93cb2e180a58d5984ba13daee95903ff4fc14
-- 
2.44.0


