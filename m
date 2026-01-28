Return-Path: <linux-rdma+bounces-16142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENnPHpLzeWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:31:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E4A0747
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A91C303023B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426E34FF4B;
	Wed, 28 Jan 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SucVZX3U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28934E761;
	Wed, 28 Jan 2026 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599710; cv=fail; b=luwYF8YPV2imXUnw2ODzQk6Kh9+jU2D2F8jS3WS/6uwtcgXAr/RNd0lNEkP+rOuiEkqqtVUyKCvftVMo9OxdH13KGsvaMFLwqQ26IEIaGSoSfZZTZjwhMJttqNHb+u3ehVmqwqpAZ8DLnwgjqkuNsAsXNuaMLnzAXKxbgCr4dho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599710; c=relaxed/simple;
	bh=CTDZfTiXyxvw6Qi971Y0UNZxHZPJDxdrDC+WW3Xcd74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dW4sx9Rqhmpa34nAAk5Efis8YWuZvO1jaTFT3AerNhbLuxvqzU8UXW0yt8BmPpGehkFnKX3Gb9FfxJRvWg+Hislj1u9qU0bz/wu0yFzTW5dfAi4fsBh3F/3AnGeuN3AOx0zr1F3DUnfgwCkU6qv/JQhGI36ZciXd7CQbB1oxvno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SucVZX3U; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFEeE8EhiXXiXcYM+BanIwYDTCCyKRtGAgfXsVXAJsc+upuuXc/GZ2VeflZbzkhzT9n7qpo5xzcsvlxFQO7M16MM0IcF5HPxsoKPr1qUmZDGDSPRS+0t1XqTonXEoiT+rL74mUJn9hpKT+vKQjfoYDY3jyqL1U1+KTaWfcPY99NyeC8kUxfNA415YGheCjuAx/6e16RX++YQjtjs1rbf1ytUVXxu3b8iDC5ss7g0Z1+jhAoRoh76s0l5+I8X0boN7hpVsYwwqasDJRjsh0d0aL7hlH7DaMqufmvtvJ/WtzAm/ris/4TjLV8Jomd9n8/Glzbh3r05wHiqabkhAvU2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBGV6UmqcE9JfxNh53yF/0VNqem8tkyC31UNBH614XM=;
 b=oPFClghigE7B+0mSukWX4u8HjEh9RTwY/FC7kxU66h7sqgHq9eTCq0+4qXqZ0Qsg4O5Umsu0esd758+ma8ZCz9dRb0qoQr96BIYc8qXDrTm+dJ05hI+1WJfPZzWe+VUqA7FgVch41OwsGPH1rTuVL6euSaX2hGqwkG4b/VJnUa0RkSwrSweDudehr3Fj7XfGFTFc4jBze65YS3JlI331KE7fkHzCsEfWJnR4m9NnvRqERK5hz07k41T8PaPub661t3GRLBG6RJPOxJvE32VakyZ9dFtDaj7pUAsBto8h2DpOgAHraK8IRgknkPMynUWMKP8IUCbtFk7R6x8lscxmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBGV6UmqcE9JfxNh53yF/0VNqem8tkyC31UNBH614XM=;
 b=SucVZX3Un6pPrmplPVhVNXWqv8iHN3J1T3IPM4vMhuGyG1YAvTOL9zbUKA2T8+D6uWAUQGjxUIHGJnJ2w2Ul6NOwmEEpBA9RhqzkdySnLFydXPqQl9sKg+t42Qq5xDmpc1HcZexkjbr4ymBQqkc2HSYmKnwNCrp4IU1JvWjuuf53jr7PiYJJpA/bwSkvvtS0c+foMHNqeBRiQh75tY1p5iyNwV3kxYQd8oWxxNDoRU4vOdcGgCydGh2Xn341eW0NGTQ0B0ucPZAbRKJ4nhACsH8HJZAS+J1Qt0BNsqnT4wzzYnIRPyNcEgdROYdfQacPk+aQGHFkp1qxZVekhWrb+A==
Received: from BN9PR03CA0741.namprd03.prod.outlook.com (2603:10b6:408:110::26)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:28:23 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::b8) by BN9PR03CA0741.outlook.office365.com
 (2603:10b6:408:110::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 11:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:12 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V7 08/14] devlink: Allow parent dev for rate-set and rate-new
Date: Wed, 28 Jan 2026 13:25:38 +0200
Message-ID: <20260128112544.1661250-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ee3829-1154-485b-b0ab-08de5e6058be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v0q6WmzDl+v+2+3zNNNdFOM5D/ohMzxh/43in3xqwO0gobFBErdioS4gV3oP?=
 =?us-ascii?Q?JSpmeR8DuXI4peVZPTfFKQzr1Gp8zlvUp9oMAaSGYdENKchY9e+lsF65xaWM?=
 =?us-ascii?Q?0cYl9XH7PM610+GtVQvnLc7KI8gq/NEN3eiRsVdEXgsBze2kUz54j8lu/AAK?=
 =?us-ascii?Q?vTaPl1unEyhKNWRyByk94uNEg+Jl8gwwjxlcOLGnGNGihw8/3a4THHBYXtuc?=
 =?us-ascii?Q?GhbXHLcfwZa4JOtKmMBOcTeNsBUAyu0QCriq1jhZSInbtjUMVr0FrNd3m48W?=
 =?us-ascii?Q?WklBwwLSR/jX0rPqBkSSZr6VCpckGZdf38astIe3Y7iuIPoujZZuTVSsersI?=
 =?us-ascii?Q?Lu6euNMtHIfZZ0Erw7FNa3tztNgjmyuQf40zY4NGFKdhVoiMgyjcKAfZUqQb?=
 =?us-ascii?Q?ci+u2pGutiBMuLWxESAyW3QuOySICiR1hju/Ui3utRxZXN0fkN1+QKSMC+qU?=
 =?us-ascii?Q?BINtB0Gwc4Q4Kh4+OZa0m9QWnMYOUZRdiTRU9UvM3boP/i/6t9+AaWuXatt8?=
 =?us-ascii?Q?dfdfDG1JMNcPlTYqGcHTnd9f3byMKjSAto95FfYwFNlmXU89JElfR9IMHJVn?=
 =?us-ascii?Q?MdBclfijGqBIb2tl7P9k46POIAZHTf9vU2R2OytYxcQINyXTYznFoCsLFXyc?=
 =?us-ascii?Q?ProS8avW6yAPqBb+BMVzPf1Q0nxlxxrUZibbUpc4AVQmK3ezXMKog+Mg2iZB?=
 =?us-ascii?Q?AJ4TCIHUbZ8P8706OsA6TSeH8iCKhGElDkfOxZ88Ay11dAItZIUWgHYICka8?=
 =?us-ascii?Q?QFtEIyHNOWMeMCgfxrSn+Fb7qmCtc7UxPG12GoTa9eIiJSeUuVPKS6VqEUjN?=
 =?us-ascii?Q?meF2D5nUX3Y7qIW7iTdUU8I/aevbd0alvFVtGAV+Mkxf7ZYybxm1HJW30BcH?=
 =?us-ascii?Q?7YwgXxvZ0s1OZLLO0Pu7MgCiKk3/0URECuFnAD3gbC83ur5+TnbFOAITp0s3?=
 =?us-ascii?Q?1jdjf6BwaH3gq6tVdJ42SKcZisq4EPLR4DcsPHakueJPtYmrME6yJKjjO09+?=
 =?us-ascii?Q?yWW+rydtuS8CNmtB0ml4ECMH+ti6QtY+PHKUfb5/o2d9H3CtzqtLbgrV9tE4?=
 =?us-ascii?Q?U5HLIv+rf0OAKrNv0i1iLgm7ZFRMTK6U3b7gjk3YFVqr2hv6FafN6vGZ1RaW?=
 =?us-ascii?Q?EgIlSLuns2Uz1c6zHaZOwbL/UDsDrBrBcpL3ITC9NWs/tFDq+ptJZdDjKJCr?=
 =?us-ascii?Q?MwDmynG+76dhXE20pMLLd1tGOrlo4hCwGpCU6GR45JI+5TBG2bJYmeBwob0s?=
 =?us-ascii?Q?NGmkt3CKXEgEPWB4wPEPkAwvmVzqqAalLwt648A9MFymp8SlQDZb1FpcHI28?=
 =?us-ascii?Q?wuJgv/BrfqaUzb99ZOzNkqBDSz4QHCaOcy/6hVx2T9i3Av+geZtLhIGZ5+lD?=
 =?us-ascii?Q?2ICIONr/cDThCsw2aa5RNBQ7CdHoxxWAO5WE3dcIgVAcCJdmMfZXv74zR7Iq?=
 =?us-ascii?Q?WVumIvIYECxE92BDjuamOWtc+/cLvNgorQ24lZuZKPh283lDSflmGgskzcPH?=
 =?us-ascii?Q?yysIKfzqy/2QwLmAInCya4aQ4TeekfW/AJfJni1C+/x4yRMuw0w3QvM9/wF0?=
 =?us-ascii?Q?MMlkpoZWeYX9VDYB6R+BbMso83O3Qxvfb7CGEnaeLRXcmmbhMeN+x/PwkJv9?=
 =?us-ascii?Q?bZx7lysV3q+4ftBvHst4bSUrqtweGGqXsEeAJU9lQxSBpv7rgzSN54WuvDR2?=
 =?us-ascii?Q?3/CRZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:23.0120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ee3829-1154-485b-b0ab-08de5e6058be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16142-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 641E4A0747
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, a devlink rate's parent device is assumed to be the same as
the one where the devlink rate is created.

This patch changes that to allow rate commands to accept an additional
argument that specifies the parent dev. This will allow devlink rate
groups with leafs from other devices.

Example of the new usage with ynl:

Creating a group on pci/0000:08:00.1 with a parent to an already
existing pci/0000:08:00.1/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-new --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "rate-node-name": "group2",
    "rate-parent-node-name": "group1",
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.1"
    }
  }'

Setting the parent of leaf node pci/0000:08:00.1/65537 to
pci/0000:08:00.0/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-set --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "port-index": 65537,
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.0"
    },
    "rate-parent-node-name": "group1"
  }'

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 10 ++++++----
 net/devlink/netlink.c                    | 18 +++++++++++++++++-
 net/devlink/netlink_gen.c                | 23 +++++++++++++++--------
 net/devlink/netlink_gen.h                |  8 ++++++++
 4 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index a8fd0a815c0d..c81c467f144f 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2218,8 +2218,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2231,6 +2231,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2239,8 +2240,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2252,6 +2253,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 72897b19c372..781758b8632c 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -218,7 +218,7 @@ devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs)
 
 	err = nla_parse_nested(tb, DEVLINK_ATTR_DEV_NAME,
 			       attrs[DEVLINK_ATTR_PARENT_DEV],
-			       NULL, NULL);
+			       devlink_dl_parent_dev_nl_policy, NULL);
 	if (err)
 		return ERR_PTR(err);
 
@@ -301,6 +301,14 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info,
+				     DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
@@ -330,6 +338,14 @@ devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 }
 
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..f82656d6d7c1 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -39,6 +39,11 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 }
 
 /* Common nested types */
+const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -531,7 +536,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -541,10 +546,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -554,6 +560,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1197,21 +1204,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_NEW,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_new_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 2817d53a0eba..d4db82a00522 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
+extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_DEV_NAME + 1];
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
@@ -29,12 +30,19 @@ int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
 void
 devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 			      struct sk_buff *skb, struct genl_info *info);
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info);
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-- 
2.44.0


