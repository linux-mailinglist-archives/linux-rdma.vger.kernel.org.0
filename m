Return-Path: <linux-rdma+bounces-20400-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGdQA7IRAmqIngEAu9opvQ
	(envelope-from <linux-rdma+bounces-20400-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:28:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A55136D0
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 868BA3010BFF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901744D015;
	Mon, 11 May 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cGfjW3sD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BB9371CFF;
	Mon, 11 May 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520489; cv=fail; b=HPlQqxZveTMkUYFBRJXWVkIn4Gl+H1/Uq39jE8h76sH4qMvl+dthGUuHIFueEaQUi9jsPji/HLbTqls52YcehCPIZxpGUGVoGuoCZSRMjAr7/xru+vcxjtC4AcpAEJAxZbWRA+i9OHQ9GBO9hm4zlLN/6wXTMfGxVkleGknpPp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520489; c=relaxed/simple;
	bh=7KKAKmtvzRE2Yd8i2ezIeW9pGjQpRzlsGUWTLIqMOoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HT61Gy2sPovuJRnPD/N9Ykkay0D2VsmoR08GqoB4qJYPlXcp7WCOmVuUnq4IOU7j0JMXRXJcurWUAU1wdW7Di5NQHNU04+B174N0Q95P/UNyclzYZD9gJaOK/B4geUTWhE9H6r34BCnDtQQbMbplhLKDyRFuk8/0M9vFAwMfQEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cGfjW3sD; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzPgUbYkrsllo0XLDKocW8St3JB8H8qkjxMlgfgtGbrsl+bZnPUbxKrLDwIuXbJ73zjMe3bxYAHTns4ElKo9EWQsqcF8jm+iow0FEds2t0VkE+hEEa74YFP1vP3Z/NB+ksVfNT0p8SOUL6VLQxJsBMK8F2yBBYsd2/N/QGH/e0hXsJs/HrOHJfWP6JkniEeHAZJA2BbnVDNYC3dXkaJTlUhIh8yBEA1M0W0ByxKwg9kTfb+nVkPOZopRjwgeLhy1E3iDCSuKI//QQWw5mroqiMytR5tW3710y5Zp+6XwFCrSrGDCs6tlOGySF6qGS1D/u/MOTOVydjJui6T+9vL6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLZmQiPzscBagT9iFDmvwtkypPTWOX2c+8Vh+e6qvZQ=;
 b=H4D5kjdrADNvZr7mjwCJ49dvk7b0rpnKa7IpgLz3YzP5Wi7Qw211JVMEhZ/M8IQjmONL/FIlUqOV2DKw5IfYSakqDXA+tmphz46xQRNSrkJvuJSX52/CIvUYmCu6ikIYdp9ZQOQkUPzqE3/NIKSmMVl5jPWWCtwvz/PGRzs8+7eC2fHuxawGINfxEGQqMkRZegOXv38lTzwlWfnQF5BSZAtmVReA08UTWvs9f3vJ+QKM/PYtIomQSENZWn0Xjh6CW4ywqBHMUrhuw09qdcK6Ua09off9BEv6rFmtqdVpcws46027brjTz19XsutQbD2hW0intfsUwY+37AjFeS9SSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLZmQiPzscBagT9iFDmvwtkypPTWOX2c+8Vh+e6qvZQ=;
 b=cGfjW3sDeJAlN7ATqgMdhh70o+nP0rNQcS9mlZrN0l+Mzbf5/WPz+Dm/j37ycqmNql1tD5YV0vnDqYbu+GlP1Y5s0fPUTu1ic/q5Ux+CnEmiXs3MY6jc2xp4WW6jYP7n8nuN1ryGKQymUGjfi9ysNCa+e2xOxDXpTyKxl/2QJ17s6KakV2D4EwSfFXPSTJ6qBKAZkpmrrf6eZTeIXxGk8eIfjA6WkGcuGHkMWVVW3VxTfSRYv9DdfGSiGINa7iNvMZRuLmsO+zZqt7kxSqzgoIv/6uZOWwJ2PSdJN+KdeTaHnsRuMBTkX/WBmPW82ZJCZrUA8UgGmYmd0bLW6OQ1lQ==
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 11 May
 2026 17:28:02 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::73) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 17:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 17:28:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 10:27:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11
 May 2026 10:27:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Simon Horman <horms@kernel.org>, Gal Pressman
	<gal@nvidia.com>, Kees Cook <kees@kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/5] net/mlx5e: improve RSS indirection table sizing and resizing
Date: Mon, 11 May 2026 20:27:14 +0300
Message-ID: <20260511172719.330490-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea85fac-404a-44a8-d227-08deaf82a733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LiWsgIoItlpEqAdNMLETK7/Zw7/G8CV9bLgX+cnf6a+Rm+zYdjTONDwSX9G1c24e1Q7B/Zn4Oihw8IMPN3PxdK6ZvU2HOcX+AVwVXv6GjFyT8TmJG2eRoCCJAruFsjsothZcuj/J2fJbqEzXnULH8QqbXlmdm7SMePkW0ARs0EDf8HODXc4dH7HWv+0eGd2VsO3lDKR24zMAdZSWDgwSjioTtB7bm1GH4HRVEcmt5LnUqTZRf3gwT9o3vmk+qnytmi/OHQp/HdkfklhywpEdvwHTY/8phS+bAc/gJkfOSVVdE7S8tSjgO3dkMsscqF+2gNvAVvCR/W79vlR6/xgxkqKGPmROFUazstE6hFT/G4Qf89vzWVjYT8nXuZ92r8l0Fnij5+JAziBzUzqNM1B21eS9JykoTv5J/h/3EiM+7xAk732ChnF7Kx+Fh0dDTXsbkc0JBWb7jRYCRfaG2NmUKhr+hnk7SdpgFKaFEiZrysAo7M/5fpKa+5eVKGEfwkiCffxxc1SlyYu5xRWhcOulzzWoTdenCao3pIbRmB3SZQ4snVUrD68ZirSfo21jp1+O7e6zCYrNu8tacTtR9+lsthtdMxyPOf7A/2TdHdgx7g/gDl1oBRGcv1xUcpCDWdwggX6BE6qOmSs1CoC/nFLL8KwdWJlPGVqbByBUR6NmvlYkHh57BKrE6Joa5ohsuVQskLsAd4zPDPYDEyp7AwIMVXJmsUo2A6m3k2e5cvN2T4o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eP3XQtV+1qvbRdUkU5HVkl6X8kzJ3n70cRbsfFfIhlEU2RU9VOKEWkXQ7whhWg8fQWC9YMU+QC6QGju3zuWIYDvjBZe4McxJlFq70VmoAEzV/o3UU6PyEGNxcDsquz0XmktFXaS1bP7GLF64RS5PO9x9kokJaP46boMRSGt2H4LQlpLjrQp8An7kklx6PobiUmYlNtb+PwRm6P5P/F3C0Di6PmYpWu7chO1R2VK7Y7f40nSQbxf8XlDeCWCHmWswtW+2WFC70c4iGAwKzeWyuuWZo8r9oUFdznynptDWMw5FUE4GlGjT/uQzhZJJ0SYDXTWfbtVKlv4St3u/hhvtDhn+ZtlOuV7oB5hTV7uL5/ZyDLvF0ko0lVlCDvc27VOEUTKJCntuzoDpKa+viRPi7zNgvkaW39zMPQI/p/y+0yNGyeqcD+hHUB0QJxAGqndZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 17:28:01.7535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea85fac-404a-44a8-d227-08deaf82a733
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
X-Rspamd-Queue-Id: A28A55136D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20400-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series by Yael improves mlx5e RSS indirection table handling around
channel count changes and large RSS configurations.

The series:
* removes the XOR8-specific channel count limitation,
* advertises the maximum supported RSS indirection table size,
* fixes resizing of non-default RSS contexts,
* allows resizing configured default RSS contexts during channel
  changes,
* and increases the default RSS spread factor from 2x to 4x to improve
  traffic distribution for large channel counts.

Together, these changes make RSS table sizing more flexible and robust,
while improving load balancing behavior on large systems.

Thanks,
Tariq

Yael Chemla (5):
  net/mlx5e: remove channel count limit for XOR8 RSS hash
  net/mlx5e: advertise max RSS indirection table size to ethtool
  net/mlx5e: resize non-default RSS indirection tables on channel change
  net/mlx5e: resize configured default RSS context table on channel
    change
  net/mlx5e: increase RSS indirection table spread factor

 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |   9 --
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |  29 ++++-
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  40 +++++--
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 106 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +-
 8 files changed, 112 insertions(+), 93 deletions(-)


base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
-- 
2.44.0


