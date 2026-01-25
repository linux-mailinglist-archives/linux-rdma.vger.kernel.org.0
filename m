Return-Path: <linux-rdma+bounces-15973-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMCLIgMAdmmMKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-15973-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:35:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E28050B
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78F27300AC87
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B002131AA90;
	Sun, 25 Jan 2026 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ODpVQfuA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012045.outbound.protection.outlook.com [40.107.200.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10E31A545;
	Sun, 25 Jan 2026 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769340829; cv=fail; b=TNbyIVk48vcHrnwvPLuhFjzZTm5IviJoLHgVl8LinLV9WZpkxYKTPv6jfVew/+pDYdoc4xXbzWGB6xOmbdqRRgzeCCPd3QIh/4vbImDX2tc9SEn0PuIhod7T1FkPfEsxOlL6W6CEd0IZ0uFPYilPJR3NZePJaXStIOZG3v1bRE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769340829; c=relaxed/simple;
	bh=dDt9BtlPGaZGxVw/fv36gBeZ8JsS+F1QvBTlCGfN4Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgkbMxr7ddamPKCahZFglqN0j0u/8w5o6NsI4tuwXmZIu3UXhVshQ9Xe1D0Mfigy2rnPTdmxfyE7IwzvXYMN8yzixgG9/TmWFSFmybhTxSACuLfIf2njkXeuoxDrse7xYujpPN20yRyFXJ9UFEgZihV7BF0ovSgzK67jr6h1VgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ODpVQfuA; arc=fail smtp.client-ip=40.107.200.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iK3KxNdWCX0X6ZjALRg+Y7Mx3F/2aes4YL3I7w2QyKljUV8If0h5ZEK7rjomX155vtiT/Tefj/TMCYnT1hkacpIuvKGrktOLK7qfd8FzswHSL4dUXayxek6YKUuGNJAu7BxQm7QPuc4pg+LAXGS+ksOvikNqwsNdxb1kOxU3ZoKHXkQNshJcxQX/UdGmRnYmwF+7D7t1+IJ1rG2PoxFDVUONkVsKO2xherQcLsmBL6yUs5QbnpMQ0I4ziMRQSv/9knm6kmkdOeoKHbpXX94CwZT7RHRJgmUFibuRFNF2pDB7DyqmPUQoCZL/PGN4/R7Okl+PepgKdLwEj6vI/LffRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBopCbdZMXrlN7jvepFQb1H5TLbacss8xEID02R5R2c=;
 b=PHnjvZhRKdU/VP5WUL/ZFc/g2cV/na923+pPXat4V80A0r6x8f92cNcgXexxktEFgOgI9zsaUfCtkLEtZawQcyStstd4Ml76YOVVHUMaawbzVnT34Tj/nrGwnXO7JAwTFuMIMDa8ibgIy6kSn+oUYwSpr3b/pcTLTGRrYo+6EX1ZIugXNZ3fw8atX//Ijhsgjwj3X7e67wCU6aXB0jeDj+XKsL9dpLBD5XzfpX8D3cEE7BPTcOh3sEJPiQXuyzCfQRuiN4ZmEZaYOmGHAE+Vn8NvgjZ3oekywusFdjuFuvJE2J7w5COMFFp67/JoLIf5gFt87jWDCsx2rjoFldTXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBopCbdZMXrlN7jvepFQb1H5TLbacss8xEID02R5R2c=;
 b=ODpVQfuAzxX+viMdqSrC4k5G2YIhKi3CBharYRu0LOO/IVm0sr44ZNYZI50uEllV1PhXoQ//RHX64TW0yN5y1J2rOQNQ6s47FvRHTlVNlQj+V5SSPalHG17oK18XVUTW2KLwUy8UKHy4DSpim1ob8Uo+pJE8yL2Ak5it9eqf8+I2uJ7l+i01JihYfP3Auqo5/luezuTnq/eaiRqNj/i3dUq1SKHLEJ/nhVIwClsUkL25XkQ+OdAbYDeNwcTOCnxLARzrkd1eUt6cHudbMvbRVlCX7EXws7cZYTEgyyfWt7fszFKBGnrgX2nlIhVLSCQBmfJcgMS4RgnRfRZpr5sFTQ==
Received: from SN6PR16CA0072.namprd16.prod.outlook.com (2603:10b6:805:ca::49)
 by LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 11:33:41 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::cc) by SN6PR16CA0072.outlook.office365.com
 (2603:10b6:805:ca::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.14 via Frontend Transport; Sun,
 25 Jan 2026 11:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 11:33:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:31 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 03:33:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 03:33:25 -0800
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
Subject: [PATCH net-next V6 08/14] devlink: Allow parent dev for rate-set and rate-new
Date: Sun, 25 Jan 2026 13:31:57 +0200
Message-ID: <1769340723-14199-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cfe9d5-74c3-42b2-4c4a-08de5c0596d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H72WOHz2VD06WgeaeMVnKI433ybqYK8LXl9DWVVS6bUZFYbMBBZDvZcKuIj7?=
 =?us-ascii?Q?z/pesaW2w1CqU0dFEN3B5FYfIQv1nlHIEBvXMWRM2kACz5HZl/bMILx/ZgTC?=
 =?us-ascii?Q?MF5rQzVKhst2cklP9xU4PmRM1m4Vnsrk2woACbq1cRg6UGk36l7roaVMmtm/?=
 =?us-ascii?Q?S6GVX6PSRgJuy+Of1OJilm2GlpG4BGmj8pf2a6Y7wibClQK3qTNBuqi9Yl1z?=
 =?us-ascii?Q?XqYkLUa9GjP9hn1vkOKQVBabLvxGP2biRBac6tFnqHHfWiwu8D1tOnBbPABh?=
 =?us-ascii?Q?RuP8qTcsh6hqaRF/6vKAgUGOsrcWguTeD4HnDS7eSkJzFR6kFiZVSsUqbhGq?=
 =?us-ascii?Q?NuEck6iOAeoxeoYXbNIlFMtW5N1HJIVccVXPb3e43o7SmFJsI0Zehe4b8vuy?=
 =?us-ascii?Q?B6oLtB1s/n/kyZPbhoTS+kMaFmd8RGEHJ2en2dji8DIKmiVhqHI0cheziFY/?=
 =?us-ascii?Q?K2tW4tQIM9XEylu+5exkKaKMBb4GGDL5oBlmze5Qxd2j/vMYPmXpLEPOD+Ca?=
 =?us-ascii?Q?RAqJwpynQm5b3n91OGbOiwNxVUX9KAggzV/N9EPzE0eWVuUh/QsjurHQPTk4?=
 =?us-ascii?Q?3mTvXyLCnvEnLlrDO0zKQ/yDZXJw/fq4ji70Lfdatqdtvscvdh2BB45HtN31?=
 =?us-ascii?Q?F4Qlq4ncC3omX/O761LQdsGoAIwqJcxOvvApGeqYZCRUH9Xt2vWpohfkzZac?=
 =?us-ascii?Q?k4d5KcToOCwhVSCXtHh+hiHzfGEhNh8qQoSkRpU6RnFrXdIrBIZhY9hJDgzh?=
 =?us-ascii?Q?PZEUEunpuf6wNfZtmGXBt6v8ypqZTRxRCK8gE3I+GMPbw+OdNUSzbf5RQOw1?=
 =?us-ascii?Q?PcUqBRRZzWWl0v1oPTYuNtz9Pn70GZ+4fUCRMkzFDcSFkBzFUzX2YClLJ7Je?=
 =?us-ascii?Q?2XrvUivy3cyIUeZmvmBKJ/rz7Rxc3GdcJ0V/Kz2A/Q7N8GNXG6n4JrZfuI24?=
 =?us-ascii?Q?foAZcxA5fFOPZTPt+hxGeqxOt2z+kDc9Et9bpq5vCKaA5x7vzGvx/WPcDhKK?=
 =?us-ascii?Q?9so3yj6Ryzjng9z+r0OX5QSNuU+7Y7Rek9d22hkYjEeWq6ZpVDRdGQmeHDDp?=
 =?us-ascii?Q?CJy1kXENApQjjL3nUdHo8W/Apn7ANh7Gttzvmxr7shv+caa5WQ1O8o1fzPdK?=
 =?us-ascii?Q?oYSliT5GxbTQHWk/S3HHpdsxkT7t+KS/WfaX9pmk3AEP4mj6NaoaGoPRjX9b?=
 =?us-ascii?Q?gDUSGv5U+R2UgaLjqGFuAH5N/dgUCGEgcyzJXuoqc8APAwGMVRYQbjid3G33?=
 =?us-ascii?Q?QQkYL0P+QZwHvQvCGim1niA9ef/CFKUBDPW/KVkQrBAuNzsRx6gftNt/Fx//?=
 =?us-ascii?Q?DvWno90tGgXbB0OzVEJjFYgddTsvnLGrUjrVSwDqI+baIbzCFXToS7l/ocJn?=
 =?us-ascii?Q?yrZO18n5JMRpJqm0I7zCufVycKV33/C8Z/EqOEXBTyGGF1CQcMGqGcKFZsUP?=
 =?us-ascii?Q?ZCQ2PwFsJ24z0LgedzTJW30/KaCJ1W2EjMXbNNa1VTnQLwXWgxgB4VbrkK+Z?=
 =?us-ascii?Q?HyEVQ46JwQcSY0fBOI7GRLPap0CXpDPs9jfT0OVcD76z64kiOEnkgQff5GRj?=
 =?us-ascii?Q?un95TTVwRuMAFRsHU7sA0jERNl99Spn6jmTMGr5HuBQzy4perAq/Mn7U1rBx?=
 =?us-ascii?Q?brmhQHJDbFcUuHTQCUU1OFxBdhqr4WbPQovMCTiT55xkXW97F94UJOzJuoBV?=
 =?us-ascii?Q?5egXKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 11:33:40.6976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cfe9d5-74c3-42b2-4c4a-08de5c0596d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15973-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5A0E28050B
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
 net/devlink/netlink_gen.c                | 18 ++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

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
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 6b691bdbf037..f82656d6d7c1 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -536,7 +536,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -546,10 +546,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
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
@@ -559,6 +560,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1202,21 +1204,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
-- 
2.40.1


