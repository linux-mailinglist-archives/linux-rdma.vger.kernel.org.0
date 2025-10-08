Return-Path: <linux-rdma+bounces-13796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98949BC386F
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 590544F357A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 06:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712232EDD62;
	Wed,  8 Oct 2025 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3wnm8Hl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013000.outbound.protection.outlook.com [40.93.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0292EC0AF;
	Wed,  8 Oct 2025 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906689; cv=fail; b=nitQkTGS8mJ9iwQ9Bxh9G2NHegTWSV1K7oxaUI+j2vjnkbgbKbvQ6w4dVwHp4VMhxMfO3gS71XUQsGME2oR8AdRCrhYkhKeN3WJOYRb4fJTQLq9lwZO63KjrjRYFHEs/9AxOB+oZlxkuG0FMeJSHlYutrUPVikYBZlJ1+cNYxFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906689; c=relaxed/simple;
	bh=MTcK5O0BQwrmHot4GY53bE5wVYEl3n0EYex3IizXeBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aSgXwFn7pVFzfO/fpd1UcyiM9qQp0iOU38Bb7iSIzBMFWMePw6Iw15rq5lGQUtNCl0zUNFTS3K/C4LZh+d+9ZWpVYXSqulgvzGanuMo0IP/upzr4nHgvs4u6sy3r6cSs4gpHQGAnP9cZX/pQKU+yYEtFh9VkcZwNdFRA7kg9SN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3wnm8Hl; arc=fail smtp.client-ip=40.93.201.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt0AXKS4zxvSZ39s3jEtgv4dfVNEiKYViIPIlDa0SN5BVN6sYPdiVcLxFC5WoriE8I2JWCvRYEGEcCxXEBE34+6D/5QG+6nVcgFcFkwyHNeieQUoUyy4zSg0lLlzv7fLlb4ADCFt3rhxyKHdcRsDp9sVHuo3OHREZ/tV1ZAlNsz5MKmpTAgOkEY5L7Oy2gRHqmsw3K5Gu7kVNplBtYJUGFFP1H/mAOIFTCddPa+LRDijDPt8FedcbHeac+5Lk9eRfa7UZ+qV7vIv9XQ2QrIIjGZja2/gx0SOWUuRok9TymkECZLXu50H2B3vJIFcZatRWUt5sae3dfLspCeMrqL3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8EWwZRb5rL2FHkyri3pq90F7vHmI9yzmZjnu1rA5ZU=;
 b=ITpuzpj9wAj2/Rrq/FWiheZH362AAyJhDfR+Th2PepWRuRpc+F3Dg/PPEk1776U4lgsHJCQI27ow4y95Gife7kaYPWvLUR/hs4CbLYU3KEhnS5/abNqntEroGJuTajqibXTH/i6nOrIip18tlnnWm7TrTKZXHx6h07S5tqq85UfSVy7mGpgTzIv7+oYz0brLYtKgXcQBC8a+8e7GJGesuhhwc8wnZA9kxVlhuZKwgt1JLrrIWU/9qvLa6uvpIgJKX6yTbi2Wsq78MRXyUZhSaQdywFSNW8LrSLX4erb7JgujYtyrTNh6/ixoTzWbwKq/3N1CB1cU4xJPzPegTUHvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8EWwZRb5rL2FHkyri3pq90F7vHmI9yzmZjnu1rA5ZU=;
 b=m3wnm8HlSS0epgCc4GimniAx5WBdsxQnTY/VJ0QjIdA88DKGOeTHyd+LhEbHtNKaQZwgY4vWZYg83QA6i4mSs5SackF9OD+8WsL2Dwj44CBYz8qR8J+OAfF1dKOJyUZ+x3SLxw7fJw1zD+0HB1ge+0lHCR7X1uzD6/dPS3sr95Eo6jzjf4nPcd/Xiq6er2ujmvFDanEs6BIqOGbs7ZG29qjn3RURwFfZQyW5ZEN9e/nkAzcxs84LD0lpMHw3MUyytMJH8ETUmGK4Z0DDVWFIrRknPzb4GoKBhTBGPahU/VPaUhwJrMW1GQoaCNIW7+St0/3i7FvQNjB4XT6a4S1tew==
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 06:57:48 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::bf) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 06:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 06:57:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 7 Oct
 2025 23:57:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Oct 2025 23:57:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 23:57:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH iproute2-next] devlink: Introduce burst period for health reporter
Date: Wed, 8 Oct 2025 09:57:18 +0300
Message-ID: <1759906638-867747-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 5740f105-e69f-41d4-102b-08de0637fdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHZLNE5xNE9CbHlPdXl0OVoyUFd2czlkRExXcTZMaktScFFDREQ3VnFOeEgy?=
 =?utf-8?B?amZTYWRvL1d5aDY3UUgrWC9WUFlLdUFaUXI3TlNGamlYMnBUSFFZQitkb2w4?=
 =?utf-8?B?YkZZSG1XNGxOZTdUTG5wN2NmM2I1cVpEK0w3RnhzNzVYdVk0d3YxQ3c2MWNq?=
 =?utf-8?B?TDluOHlleTJzcUVuZXU2T0FCaHV2WFozUUJIZWZldGpqZG5Qa0tNZisvbnJN?=
 =?utf-8?B?WXFvSTY5U0hZRnlGSkJkbmcyWlU1eXlnVW9nZ0pRY3pEMXh6QWFMWXFRb01Z?=
 =?utf-8?B?UnpIYkYvT2ZISGRiV282SjA3Vi9rQ3JCM0JyL1VublhJYzdBVVFEbEsrMzhP?=
 =?utf-8?B?TkdZcUROV3NYemxsNFYyUkltajZnVVZValUrbFJXdTJxbEJoM01nM3hhaXAw?=
 =?utf-8?B?YjFXZ0d0N1VpcUdzV1FlS00wK3RBUFlzeWMzd1UzZ2NUOWZyZ09pRUY2TjRC?=
 =?utf-8?B?Njc0dXVpZm4zclJqclc3OFVPbHJNbnlOSUhCSm9yMS90YjdzZlpiYytWNzVH?=
 =?utf-8?B?VU4vSm0yUllMRkFOTHdKZnVNSGg5MGgvRytrOWkzU2RCOVZDelU2dnhMeldG?=
 =?utf-8?B?alM4eTEwc1ZyUE5rZzY4a0FPRFo5QjZhM214S2wvaDYwTm9iUUdTT0hlUUQ5?=
 =?utf-8?B?SlVFMzBGMkI2WS9DUjAwV3RyL2x4dFdGMi9Dc09qcVoxMHV1NU5tNzV0NEZC?=
 =?utf-8?B?ZDB0Vkg0L1o1dG1KY2tVMitJclRUeUI2K0RUMzlqUGxxOWt6YWRndEc5bWhK?=
 =?utf-8?B?R242SmNjdU9MMjRYd1pNTFdOckVPWU12UEdwQ29Rck91U0N0VEh2OHJGZy9l?=
 =?utf-8?B?M2RyL0d2RGJjZkI4aXlPZmFDWEJMNi81WXFmeDQzVG9udkxZY3hKcFpZQWFO?=
 =?utf-8?B?dURMQkw4WDcwZlV2ZmpMbDdYdDU2NU1pdzJoMzdJbnJzS0FPSitkT3Zrd1l4?=
 =?utf-8?B?VWpWZ09BcGVVUnNTYmhITTFRL00zQTB5cUdOM2VTMXRDWTFMUlRabkJyNWNi?=
 =?utf-8?B?SWhaRXFaY3h5TW5zeUhMOUFrUTMvaHZXeFpWK1doek9UQy9YL2gwRmtYYU1h?=
 =?utf-8?B?ZnNDeFpDTUxKRkd6WFIzZUNNcGpqdGc3NHptMi9LZzRNN0RpVXNoME5IaDRp?=
 =?utf-8?B?dVBzL2ZIWHRvM1FjdnJSV0FzSEUwRHpKYUE0bXgxenppY3EybDRVNFc0L2hN?=
 =?utf-8?B?RXZ0ckJ2bHU2MHBFNXp0ckhESnU4Z3dMdUQ3Q21teE5OR0llRnJJQjhNdTFx?=
 =?utf-8?B?aC9hMnM3YnRMVVV0QzFSeU1HQW9DOHcxcG1NaThnTmJzOURnamt4SmxxQm1E?=
 =?utf-8?B?Ykh6RTZNOUUrS3Z6ZkJiUkwzU3l3anFPSlROOHp2QUYxdlVIUlFTZ2dBVnZ4?=
 =?utf-8?B?MkVuMVVDa01Iek5FdEVOTmxPNUYvYS9nTmxTakQ5RjdiOGoveW4zV0FLM1dB?=
 =?utf-8?B?c1N1cndSbEVtUTR3Wkx2anZBSWVCamt5aUIzb3YwcUZnc285MS8wak5nbkcz?=
 =?utf-8?B?SUdpYzROTE9VeXB4djFWVE1SdCtWN0ZXVGx3cGt6bVM2Zm5KM3ovWXhHN2JE?=
 =?utf-8?B?Yld6YjhJMDNodUFNNExsYnoyLzZlMkY4aUlYak1iTHNYdlg0WGpiTUx4ZUR0?=
 =?utf-8?B?U0xBYmNDNmloZFlyNUpZWmJSWXMvMXhwYjIxNWplSWZjazlVQnlyUVd6MW5o?=
 =?utf-8?B?NjdnblBqZ1lRc1JCeXJHVjhpd3dsM1Ywb1hRdTkyZDZpNXdNcGx5VnV2UzMx?=
 =?utf-8?B?UEltK05TMXR0dWkvcUxnMm5LS1hYTzAwaGg4TEdhY0xFVVNDWlBIc0ZoYjZn?=
 =?utf-8?B?RHlkRHlrWTJIcUlPVnRnLzlGdFdmV0xhNFNNRjNrb2pRR3NHc09JUWpEQmZD?=
 =?utf-8?B?L3A2a1JYdWpJVEQvcG1MdlFsRGloS1hQb0tzUG9JLzNKNFhhSEMvblhBb2V6?=
 =?utf-8?B?dndyVkJCRG16VzFnQWJHZzJGa1kzU0o2TC9yNVpOK2JKaGtqTlZmL2FyUE9V?=
 =?utf-8?B?OC9RV0pQb2NHcXBLbXh2V0JsckpjbmxPMzZjS2wrUWNhSFpwOXArek1KVEZp?=
 =?utf-8?B?RTNBMzlkbDNrM3FZSG5uNmN4RktiZm9selM3US9wSzFmbnlZQVRlczlWVUZq?=
 =?utf-8?Q?PuEk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 06:57:48.4117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5740f105-e69f-41d4-102b-08de0637fdd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

From: Shahar Shitrit <shshitrit@nvidia.com>

Add a new devlink health set option to configure the health
reporter’s burst period. The burst period defines a time window
during which recovery attempts for reported errors are allowed.
Once this period expires, the configured grace period begins.

This feature addresses cases where multiple errors occur
simultaneously due to a common root cause. Without a burst period,
the grace period starts immediately after the first error recovery
attempt finishes. This means that only the first error might be
recovered, while subsequent errors are blocked during the grace period.
With the burst period, the reporter initiates a recovery attempt for
every error reported within this time window before the grace period
starts.

Example:
$ devlink health set pci/0000:00:09.0 reporter tx burst_period 500

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 bash-completion/devlink   |  4 ++--
 devlink/devlink.c         | 19 +++++++++++++++++++
 man/man8/devlink-health.8 | 20 ++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/bash-completion/devlink b/bash-completion/devlink
index 52dc82b37ca5..c053d3d08009 100644
--- a/bash-completion/devlink
+++ b/bash-completion/devlink
@@ -792,12 +792,12 @@ _devlink_health()
             if [[ $command == "set" ]]; then
                 case $cword in
                     6)
-                        COMPREPLY=( $( compgen -W "grace_period auto_recover" \
+                        COMPREPLY=( $( compgen -W "grace_period burst_period auto_recover" \
                                    -- "$cur" ) )
                         ;;
                     7)
                         case $prev in
-                            grace_period)
+                            grace_period|burst_period)
                                 # Integer argument- msec
                                 ;;
                             auto_recover)
diff --git a/devlink/devlink.c b/devlink/devlink.c
index 171b85327be3..f77b4449e8c5 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -311,6 +311,7 @@ static int ifname_map_update(struct ifname_map *ifname_map, const char *ifname)
 #define DL_OPT_PORT_FN_CAPS	BIT(57)
 #define DL_OPT_PORT_FN_MAX_IO_EQS	BIT(58)
 #define DL_OPT_PORT_FN_RATE_TC_BWS	BIT(59)
+#define DL_OPT_HEALTH_REPORTER_BURST_PERIOD	BIT(60)
 
 struct dl_opts {
 	uint64_t present; /* flags of present items */
@@ -346,6 +347,7 @@ struct dl_opts {
 	const char *flash_component;
 	const char *reporter_name;
 	__u64 reporter_graceful_period;
+	__u64 reporter_burst_period;
 	bool reporter_auto_recover;
 	bool reporter_auto_dump;
 	const char *trap_name;
@@ -697,6 +699,7 @@ static const enum mnl_attr_data_type devlink_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_HEALTH_REPORTER_RECOVER_COUNT] = MNL_TYPE_U64,
 	[DEVLINK_ATTR_HEALTH_REPORTER_DUMP_TS] = MNL_TYPE_U64,
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = MNL_TYPE_U64,
+	[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD] = MNL_TYPE_U64,
 	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = MNL_TYPE_STRING,
 	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_MSG] = MNL_TYPE_STRING,
 	[DEVLINK_ATTR_FLASH_UPDATE_STATUS_DONE] = MNL_TYPE_U64,
@@ -2101,6 +2104,13 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
 			if (err)
 				return err;
 			o_found |= DL_OPT_HEALTH_REPORTER_GRACEFUL_PERIOD;
+		} else if (dl_argv_match(dl, "burst_period") &&
+			   (o_all & DL_OPT_HEALTH_REPORTER_BURST_PERIOD)) {
+			dl_arg_inc(dl);
+			err = dl_argv_uint64_t(dl, &opts->reporter_burst_period);
+			if (err)
+				return err;
+			o_found |= DL_OPT_HEALTH_REPORTER_BURST_PERIOD;
 		} else if (dl_argv_match(dl, "auto_recover") &&
 			(o_all & DL_OPT_HEALTH_REPORTER_AUTO_RECOVER)) {
 			dl_arg_inc(dl);
@@ -2701,6 +2711,10 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
 		mnl_attr_put_u64(nlh,
 				 DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
 				 opts->reporter_graceful_period);
+	if (opts->present & DL_OPT_HEALTH_REPORTER_BURST_PERIOD)
+		mnl_attr_put_u64(nlh,
+				 DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,
+				 opts->reporter_burst_period);
 	if (opts->present & DL_OPT_HEALTH_REPORTER_AUTO_RECOVER)
 		mnl_attr_put_u8(nlh, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER,
 				opts->reporter_auto_recover);
@@ -9309,6 +9323,7 @@ static int cmd_health_set_params(struct dl *dl)
 			       NLM_F_REQUEST | NLM_F_ACK);
 	err = dl_argv_parse(dl, DL_OPT_HANDLE | DL_OPT_HANDLEP | DL_OPT_HEALTH_REPORTER_NAME,
 			    DL_OPT_HEALTH_REPORTER_GRACEFUL_PERIOD |
+			    DL_OPT_HEALTH_REPORTER_BURST_PERIOD |
 			    DL_OPT_HEALTH_REPORTER_AUTO_RECOVER |
 			    DL_OPT_HEALTH_REPORTER_AUTO_DUMP);
 	if (err)
@@ -9753,6 +9768,9 @@ static void pr_out_health(struct dl *dl, struct nlattr **tb_health,
 	if (tb[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD])
 		pr_out_u64(dl, "grace_period",
 			   mnl_attr_get_u64(tb[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]));
+	if (tb[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD])
+		pr_out_u64(dl, "burst_period",
+			   mnl_attr_get_u64(tb[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD]));
 	if (tb[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER])
 		print_bool(PRINT_ANY, "auto_recover", " auto_recover %s",
 			   mnl_attr_get_u8(tb[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER]));
@@ -9827,6 +9845,7 @@ static void cmd_health_help(void)
 	pr_err("       devlink health dump clear { DEV | DEV/PORT_INDEX } reporter REPORTER_NAME\n");
 	pr_err("       devlink health set { DEV | DEV/PORT_INDEX } reporter REPORTER_NAME\n");
 	pr_err("                          [ grace_period MSEC ]\n");
+	pr_err("                          [ burst_period MSEC ]\n");
 	pr_err("                          [ auto_recover { true | false } ]\n");
 	pr_err("                          [ auto_dump    { true | false } ]\n");
 }
diff --git a/man/man8/devlink-health.8 b/man/man8/devlink-health.8
index 975b8c75d798..fd6818dfadaa 100644
--- a/man/man8/devlink-health.8
+++ b/man/man8/devlink-health.8
@@ -61,6 +61,8 @@ devlink-health \- devlink health reporting and recovery
 [
 .BI "grace_period " MSEC "
 ] [
+.BI "burst_period " MSEC "
+] [
 .BR auto_recover " { " true " | " false " } "
 ] [
 .BR auto_dump " { " true " | " false " } "
@@ -182,6 +184,11 @@ doesn't support a recovery or dump method.
 .BI grace_period " MSEC "
 Time interval between consecutive auto recoveries.
 
+.TP
+.BI burst_period " MSEC "
+Time window for error recoveries before starting the grace period.
+Configuring burst_period is invalid when the grace period is disabled.
+
 .TP
 .BR auto_recover " { " true " | " false " } "
 Indicates whether the devlink should execute automatic recover on error.
@@ -242,6 +249,19 @@ the specified port and reporter.
 devlink health set pci/0000:00:09.0 reporter fw_fatal auto_recover false
 .RS 4
 Turn off auto recovery on the specified device and reporter.
+.RE
+.PP
+devlink health set pci/0000:00:09.0 reporter tx burst_period 5000
+.RS 4
+Set the burst period to 5000 milliseconds on the specified
+device and reporter, prior to initiating the grace period.
+.RE
+.PP
+devlink health set pci/0000:00:09.0 reporter tx grace_period 0
+.RS 4
+Disable grace period on the specified device and reporter. Disabling the grace
+period also deactivates the burst period.
+.RE
 
 .RE
 .SH SEE ALSO

base-commit: 1f7924938884235daa5594f1d0f18c5b07fa9d74
-- 
2.31.1


