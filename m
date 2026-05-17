Return-Path: <linux-rdma+bounces-20835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIVLAymmCWqpjQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:27:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D652560B28
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 13:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D6E3009536
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EB35AC0E;
	Sun, 17 May 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="blGBDOrE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410D8BE9;
	Sun, 17 May 2026 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017242; cv=fail; b=FMD05H198S20iS1vpHF1FtfRti8ddguztxvsj2dM+/RpqZUUSY+JlCumvzprF7jKCwPLyLYTqDZTKGv5cp6oaLrlh36k6wzja4MnBpvmezt+7XK1ujhZ5IHfshe6vIps6qAGGdNXTsry+kX+/JQhW7fLQK40KcE1R6LoaoFCHfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017242; c=relaxed/simple;
	bh=AxB9ypgjdsK82ef53sMCOQP6xqr7h8MjyXh8ED5z99I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bTMOI0Ef2rrhvSCns9CEtQzzaNkTnyjPLRo472xB5/UAH8VqlzPS4xqAqmULJPB8835p7ZH4KiZmglQF+tiRzxVlkvdTK4nT+Hh4aANULPXvZO9tabWXTOmoWCaCvoZswca8acTl5YWKUa3tXI+5V3nWaETMssl1K0F+ZjtdAnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=blGBDOrE; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWY2J/2R1ycB98pJ7Lfa4QKAfDwLQpSMk8wSLICuTctipvWkR8c//lo27k3hGwfDKAmaRKeBkWl5QnxTAVfLXzRYZ0dIB59pt4XFRycEXBZCHXEOxei6IXHvjeipeOSJljMPM+xh0zvfYS93St3kjTKqtdjtGSub8rV4H5+ukRTsoEkoFxCQV0iEMoC+NujWuBZdJGO52BM3Hesq6tr7oWQU7+6CTdVGTvREtNZDXoJm+eVKztoLF9Tt3TMKPbxoruzkKFCuunrTosF9nbK1LCdjUvKzTo9f52SEkAyEugXeiDpV5txyBFsGiVrnZ88tIF2QJDw7f8qrjI0SCAngag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akW2i+UQXFGZTAllVy9jhbLoH8bnjT9BDDuaF+/e92s=;
 b=QHVviFO8Rl7vO1HuuIl7lqdO7eXDUYEwiwFsiuXw1g23+blTzaqhTlKYXktORAaaY+ka9bA5/h/7cUJO+nBqXlG5j1aF310nqmC463/Gv41OZZmDMUiGQIE55O/53fdCOZ7TxuulaWmtOqmY71n8/XCXSKUZQi5d3fHgoJG0dasbLBnQcACMTw4P28lA+6MrC7MMhw5F3khnzYHpHb6e2fibJ9QIEUK2/G5wTq0JX8KA2YZ8dyZsXaPw/G1hgBOgcdpdBNjGi1r5WTTbp0o6VO894gUchspnpkFgYXaYyQC7aU+8e/cp8g3V5YZpeM7iOLF/Nbu4JYh6/l6g4vfc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akW2i+UQXFGZTAllVy9jhbLoH8bnjT9BDDuaF+/e92s=;
 b=blGBDOrEymvMYO2TjbWo+RLRtHj60CRdd/c1/9b7GN5o7soTgHxuOOh5wFMgt+x46UwwnMbbi6RY+IJ35WEIha64w+7+DaCOQ3kcg30BABP+tShYFCMwjs9oDwxr05NHlAXiLmgaLDTbUII5LUkGb/NZZdkpdYFinKyn6NyVXrF3N9yjve+lDZWDhrPDlLnOEFIyqr2i+nhAUg/i7hLL+WrAUc8AkBFhwDaOujzamLQt1HCNO4UaN7JTm2D+1K029D677KgLOQq74jg073R5nhHw7w/rXAjGgjk8mDO3OcATuQNGR0H6w4yd3pDXz9FO08HsA4A+qlTKKlMLImHzEA==
Received: from MN0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:52c::21)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Sun, 17 May
 2026 11:27:17 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::26) by MN0PR05CA0017.outlook.office365.com
 (2603:10b6:208:52c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.12 via Frontend Transport; Sun, 17
 May 2026 11:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 11:27:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 04:27:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 04:27:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 04:27:05 -0700
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
Subject: [PATCH net-next 0/2]  devlink: add generic max_sfs parameter and mlx5 support
Date: Sun, 17 May 2026 14:26:58 +0300
Message-ID: <20260517112700.343575-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f64013-678d-4f65-65c5-08deb4074050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Vw+WGOmVNy6OyiknQd9aim4y1bBegXFOrnNtNkQLQaIif4FodeFXZUX5lSzKOIHRHyaGnXcqda398rdTXOygKGgDLmceOC4rkG90lGX8bOKHz4VrIxwcz0XG0bhOjgoJG5VE31+ssPln5pH97tSDR+RdZaCGB0guePsalVjMY64Cu0CXF3BWkbZRjVyy3PkxjLg9ixrBIyPkpaqPqe6ikJBZ+EV9KX6LWrvMHgYz6e3b2c4XzRy/wTD6DHW22VEF0p2mjKI3NX9cg3QtuGSQI7Dun+Jzi5ZCiFGVHKMLDnTlmc06HkAbRnPKxTLdI3pA0oi4JDPJmmX8v0Mlb9rQ/Z/XSl7K0KBaMZEQiKMZDXctrKMM/nRRHRYXfFrgMEPGBgCpl4qIchF0ULNa8aRuVYybh+5CWZuutyx+zH0YYFK3t90ISla05gMHumFzmC1XCzWXKvGh/vkLtJG0mFd0BIrC5SkflIxf2ZN9R+ye7StyjhtTr6MyiM9JB0awU4A97tmezYSECWjP9VMTN+1QV9wXVUbRbsIoKCKOLGauB9L6GeUpKGdgukMTQ9YJboXAwiGFXOIgB3a+AcJl/qgdW1mKHStfYJCJwEYACMDDpQeuGSMWg5iSpLNL6hpGULQ7QNKo3TqlB7+tZQnlW4l98lpRhysQUOaAWWk1WtsTKUav5mBfMNAU84ydkprldtgsf9RBSbH4ODVgMdzCszVGklP/R0DSQuH/o57/DUqpmZA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GnPOx4Sr6i9BVECdF61xBPI6kqUFYIAI0fayFvVVUrEoevgenO8qMsbwYkYfy5HrSf6BLwgHm0IKahjfebuGDgFFVFBDNKQoamzOLLanpNOVrR79O69HGYre7TB6KDLKgIZgGNvDlJsZUG183SxzO8NeqdShcHgnOxR4vDnkUN9xCdmdlfuLmIgZmQ8o/gyeA6JguGFidgW0UieZSOMqSHgfHlgUIb1O8viUIKn99YeosSnLnOBKv/Wrs9UhpdMN0a/ZUXNc1Qi1a1zHIW06M7CPG0vhyHpx1Y3y4Sr3bOM6xhRcXFfhZz7ftaiG0F/xhtTfRZSKWN0BA4kfZ9+8juuWnzwhfvniQfz2Z6YwZen2RQRBqLcpeKNNIM/4tUeOTErj4/jV50RmyGJ1fy9U6yBMP7Lr2n+EMMaBrRyZdBms1f1JI7XlDod4uzOMNlKe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 11:27:16.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f64013-678d-4f65-65c5-08deb4074050
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
X-Rspamd-Queue-Id: 8D652560B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20835-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,intel.com,gmail.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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

Nikolay Aleksandrov (2):
  devlink: add generic device max_sfs parameter
  net/mlx5: implement max_sfs parameter

 .../networking/devlink/devlink-params.rst     |  6 ++
 Documentation/networking/devlink/mlx5.rst     |  7 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 83 ++++++++++++++++++-
 include/net/devlink.h                         |  4 +
 net/devlink/param.c                           |  5 ++
 5 files changed, 101 insertions(+), 4 deletions(-)


base-commit: 627ac78f2741e2ebd2225e2e953b6964a8a9182f
-- 
2.44.0


