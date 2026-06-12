Return-Path: <linux-rdma+bounces-22165-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1c/AJjjxK2rLIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22165-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9D6790E8
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Ki2fW77j;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22165-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22165-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBA203223932
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C713C3C01;
	Fri, 12 Jun 2026 11:40:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C491279329;
	Fri, 12 Jun 2026 11:40:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264437; cv=fail; b=sHuCR7zd+b0Zf9rBu8vbx+HW0PS3rL5P7/MU8OmDTv5+B/8GFu4MRAoR5P1P++s9RlhFHEBaTYGh7vUINuuW6TnbatO+LKRQIymbRgPgwA4fm7VTBrMeTiHQ5lRxxKCWhmRiu1dtt+1BQGys7daA4c/2UTMh5G5gBAkntbd6fT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264437; c=relaxed/simple;
	bh=5U/qx2xtZZ/1Uz/d3uT7fm/SSv1SOTp1C4knwQ3t9uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFLGnK0vfaEW8/99XqBALEECBukyZaIgPdwM3GWvI+nNXX4EqBhsBKIC+8Rv4Cv++9FjaqPMhWtbTv8+rH3kW7Gk3IVdmhGvhvVhrnGeXb4ExoArhxnB5qC25+ucMZB6X82Nwco/3uVUhAdVdn7wYtDHzLMWnZfRhqa7rbTFxc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ki2fW77j; arc=fail smtp.client-ip=52.101.56.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahUnsZlH5X+bjF0MW8jQf5EZ9+Ehu4E+tZg8ts1WU3hQNP+3zzK3dCOjRvnBUt9bfy3aIEdWFc7OTeTbGEiorNHCyqI4niu0nStVKbNxyTd8O1Y/qOPddvinWq2CF/8ENqLfWFxkeu7SPe/BXNfvi40yRM4jNJ8N2CK95Z/4bOae7IhhIIDhspETXsQxhkFKccdvqbKZJJm7WPR+es3mR3vyZIaAwPNHzkZXUTCTU0nuQOojZTYVJt8Mv4DSNyCufOW6H4XT4kEpiRuD4Xo/8IFVOFsx9QW7VOpyu/ONxD7g6MEC03mGa+Cv5u2IU+3em4yRRZ5Ak3TosCv3Tr7QvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmPQa5sRlhMbW8kBspHhD/kKJI5i8GeTXI8HA0I6exE=;
 b=KO+5k1j8AE3VF/CnWE3w4S7Yz5vBCPCo6ulxXJlwl9LvtRnnaayelLuBNdjPS6GQW66uhjBGwKeEnEt/lm69WOUWl8NMa1cOvEuM8zxStBnQDt8SVlZDimLVWEWYuxOPbFhlC8iR6zCwwrr4c11vSOBwauUrDl0XaXHlap7+NNZQBbHyGV/YaBT3wv+aSNuYrsKy66LsFo+9gxeisNHwb1hC3lh45Gn3jRjlM0DkOfyMnubxk80OceezQX/QZ0q1LR6w9uuqMp3mXmRbpIIcSenKP7Dap8e5nZoigMfiTOb1McA1/Vt/TU1iaxK7zADz1wqjr5jzY4LXvsFbrACI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmPQa5sRlhMbW8kBspHhD/kKJI5i8GeTXI8HA0I6exE=;
 b=Ki2fW77jqxtP4vT+Wl+HX4WocqnGwJfV1g/nOtmiEu9aAJRYyV10Mx3yMGJe0cH2lMOfJAKKzEltm5KxhHswQqK+IUb5DqUYP3zMtcUgO+TDbzl6yl6Ny20KObcHuVtnRjs+jTGJne/GxJPilWWjmUvBGkT3p1hZyQ3pZeoXikgbL16Kag3kS0ka01cTDDFH+zmqPMBRpRNsj9pOMhwK7igCcBVz5kC8QUSI7XNZkQk/0qbY+b+S5r7myjcQJQbXxDnscpHA9Mr6EpEfypaRUlCCVhPYvc68Z0FnfndlwQhyU4y3xkRAJpGMBEMpfKIlatbQHYvdvaDWCRmnb0f45Q==
Received: from DS7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:8:54::21) by
 SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Fri, 12 Jun
 2026 11:40:30 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::3f) by DS7PR06CA0051.outlook.office365.com
 (2603:10b6:8:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 11:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 07/15] net/mlx5: SD, support switchdev mode transition with shared FDB
Date: Fri, 12 Jun 2026 14:38:56 +0300
Message-ID: <20260612113904.537595-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2003f323-5c34-4705-20d6-08dec8776803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|23010399003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	crBBpkDQ1j9s8uKXp5E/wgjIEYpdDc/R3H/Gw3C+Ic4yZZPFZm8kktZ1kj9MC4E3hHKBEYSCLhlBcNFGukNIneHTAzCOqCHYLKdn8OqW1e9oquGfTfOniTcRZNBx3C0Borxa+FUfXCgNUQtcod5ffRKczbyUlS7foz9ZXk1QN8HW8oXKLWDHU0dJb/nNcQ7b/LT6znuYl3B/9VhV7PLvVzwnTaD3QRjf80InUQQzYJ18EO824JhF/5lHyazxSA/VI4gcaa+R2xoj1eFunViLZk3UqIAy/SzPjU+BZkUfN5LEBIChG/D+E5QMQm7spT1iH9LfHsiPgnNMgwmBFMybG7m1G4DIE40NE7R46oyxlaAzfEVhjWcNeR6wU2MTLsZsBFotKtcRtueGQn23po6lxSEAsQhbpvlbDIIbKEIZAlj5F3Am0lc5TzEYu/4lVbwYu3j1MsNYSkHBsBMH2/7WuQorUSyVPV2L/lzOyaaOWqyQ0bt5WHgyWtXWx1XGSfap+NR56+RoRO+pdWgviNc425RUoCQmnq47RoAUAUDYul6wmYc0HIafo0ERLYsu5zoeBaUtalfHik0p1qTD4g5cF5wWL3Mxae2fa1ChwiOrgAw13dOdBLnTUMamA0eWqXTBQXqXhhcSS1f5TOWECWQC4iQsNJOfw9Ps3MxvltFwAqYiDxIV18CVVv3Va7io9z2adsbM/MzBKfWywLquouPdYE/Ds5Q93dCCYdkzV9K7Tjw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nsKxHR36J1ogbQvvV9AxDpc5CQTUhYFgaN4luibd8MqoltBB49jB0oU6eYED8GLQqIZ2A/Wlo82eC8V7ckD490KULzyLPBfT7JRKm3FS6tSHFrbIiGivht0X3xZu0qrgkaur43pSACtJMN1Fr3szGiAk9QW7LRfNhE+lmzN1sApT8sMrKfn9qvbjozNlzg0Tt6lxS+2hJl9/TiV1hrQzTRlSzHLnrSshwyuzeJjrjtNysWP2ncK+DY6hHapBdpZ92kAC2Hn4LCUSYthb/b1yVkDSX7CgC1N3Oy2C3E0qWS2AS8YW8fTiW390Z/e5ip7eHeP0X8ID8uoHwX3qk+ju5qwuip7IJxxZpp2r9+wvJITYLiykmZpys48cgizQB+bHwL4tEHMICCExTsDbHVuqjVOS2s9wLh0TPjuDv3C11CSAxsnnBmovtBClqwh7qOev
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:30.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2003f323-5c34-4705-20d6-08dec8776803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22165-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DF9D6790E8

From: Shay Drory <shayd@nvidia.com>

When the eswitch transitions, propagate the change to SD: secondaries
get their TX flow table root reconfigured for the new mode, and when
all group devices move to switchdev, the per-group shared FDB is
activated.

Shared FDB activation is best-effort - failure does not block the
eswitch transition; the next transition retries.

Note: the existing mlx5_get_sd() guard that blocks switchdev for SD
devices is intentionally retained. It will be removed once all
supporting patches are in place.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     |  12 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 138 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   7 +
 3 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 366531d8ef02..915571a1586c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -46,6 +46,7 @@
 #include "fs_core.h"
 #include "lib/mlx5.h"
 #include "lib/devcom.h"
+#include "lib/sd.h"
 #include "lib/eq.h"
 #include "lib/fs_chains.h"
 #include "en_tc.h"
@@ -3164,6 +3165,9 @@ static void esw_unset_master_egress_rule(struct mlx5_core_dev *dev,
 	vport = mlx5_eswitch_get_vport(dev->priv.eswitch,
 				       dev->priv.eswitch->manager_vport);
 
+	if (!vport->egress.acl)
+		return;
+
 	esw_acl_egress_ofld_bounce_rule_destroy(vport, MLX5_CAP_GEN(slave_dev, vhca_id));
 
 	if (xa_empty(&vport->egress.offloads.bounce_rules)) {
@@ -3182,6 +3186,9 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 	if (err)
 		return err;
 
+	if (!mlx5_sd_is_primary(slave_esw->dev))
+		return 0;
+
 	err = esw_set_master_egress_rule(master_esw->dev,
 					 slave_esw->dev, max_slaves);
 	if (err)
@@ -3401,7 +3408,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 		return;
 
 	if ((MLX5_VPORT_MANAGER(esw->dev) || mlx5_core_is_ecpf_esw_manager(esw->dev)) &&
-	    !mlx5_lag_is_supported(esw->dev))
+	    (!mlx5_lag_is_supported(esw->dev) && !mlx5_get_sd(esw->dev)))
 		return;
 
 	xa_init(&esw->paired);
@@ -4306,6 +4313,9 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	mlx5_esw_unlock(esw);
 enable_lag:
 	mlx5_lag_enable_change(esw->dev);
+	/* Shared FDB activation is creating LAG which is changing reps. */
+	if (!err)
+		mlx5_sd_eswitch_mode_set(esw->dev, mlx5_mode);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index c670ed1dd63c..b35795bac098 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -5,6 +5,8 @@
 #include "../lag/lag.h"
 #include "mlx5_core.h"
 #include "lib/mlx5.h"
+#include "devlink.h"
+#include "eswitch.h"
 #include "fs_cmd.h"
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
@@ -33,6 +35,8 @@ struct mlx5_sd {
 		struct { /* secondary */
 			struct mlx5_core_dev *primary_dev;
 			u32 alias_obj_id;
+			/* TX flow table root in switchdev (silent) config */
+			bool tx_root_silent;
 		};
 	};
 };
@@ -672,6 +676,29 @@ static void sd_secondary_destroy_alias_ft(struct mlx5_core_dev *secondary)
 				   MLX5_GENERAL_OBJECT_TYPES_FLOW_TABLE_ALIAS);
 }
 
+static int mlx5_sd_secondary_conf_tx_root(struct mlx5_core_dev *secondary,
+					  bool disconnect)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(secondary);
+	int err;
+
+	/* Idempotent: skip if TX root is already in the requested state. */
+	if (sd->tx_root_silent == disconnect)
+		return 0;
+
+	if (disconnect)
+		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	else
+		err = mlx5_fs_cmd_set_tx_flow_table_root(secondary,
+							 sd->alias_obj_id,
+							 false);
+	if (err)
+		return err;
+
+	sd->tx_root_silent = disconnect;
+	return 0;
+}
+
 static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 				struct mlx5_core_dev *primary,
 				u8 *alias_key)
@@ -691,9 +718,11 @@ static int sd_cmd_set_secondary(struct mlx5_core_dev *secondary,
 	if (err)
 		goto err_unset_silent;
 
-	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id, false);
+	err = mlx5_fs_cmd_set_tx_flow_table_root(secondary, sd->alias_obj_id,
+						 false);
 	if (err)
 		goto err_destroy_alias_ft;
+	sd->tx_root_silent = false;
 
 	return 0;
 
@@ -710,7 +739,7 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
 	struct mlx5_sd *primary_sd;
 
 	primary_sd = mlx5_get_sd(mlx5_sd_get_primary(secondary));
-	mlx5_fs_cmd_set_tx_flow_table_root(secondary, 0, true);
+	mlx5_sd_secondary_conf_tx_root(secondary, true);
 	sd_secondary_destroy_alias_ft(secondary);
 	if (!primary_sd->fw_silents_secondaries)
 		mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
@@ -939,6 +968,111 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
 	return &primary_adev->adev;
 }
 
+#ifdef CONFIG_MLX5_ESWITCH
+/* All SD members must have completed esw_offloads_enable (i.e., reached
+ * mlx5_esw_offloads_devcom_init) and become eswitch-peers of the primary.
+ * Until then, mlx5_eswitch_is_peer() returns false for the not-yet-paired
+ * member and shared_fdb_supported_filter would reject. When all PFs transition
+ * in parallel, only the last one to finish satisfies this gate; the earlier
+ * ones return 0 silently here.
+ */
+static bool mlx5_sd_all_paired(struct mlx5_core_dev *primary)
+{
+	struct mlx5_eswitch *primary_esw = primary->priv.eswitch;
+	struct mlx5_core_dev *pos;
+	int i;
+
+	mlx5_sd_for_each_secondary(i, primary, pos) {
+		if (!mlx5_eswitch_is_peer(primary_esw, pos->priv.eswitch))
+			return false;
+	}
+	return true;
+}
+
+static void mlx5_sd_activate_shared_fdb(struct mlx5_core_dev *primary)
+{
+	struct mlx5_sd *sd = mlx5_get_sd(primary);
+	struct mlx5_lag *ldev;
+	struct lag_func *pf;
+	int err;
+	int i;
+
+	ldev = mlx5_lag_dev(primary);
+	if (!ldev) {
+		sd_warn(primary, "Shared FDB MUST have ldev\n");
+		return;
+	}
+
+	mutex_lock(&ldev->lock);
+
+	if (ldev->mode_changes_in_progress)
+		goto unlock;
+
+	if (!mlx5_sd_all_paired(primary))
+		goto unlock;
+
+	/* Check if SD FDB is already active for this group */
+	mlx5_lag_for_each(i, 0, ldev, sd->group_id) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->sd_fdb_active)
+			goto unlock;
+		break;
+	}
+
+	if (!mlx5_lag_shared_fdb_supported_filter(ldev, sd->group_id)) {
+		sd_warn(primary, "Shared FDB not supported\n");
+		goto unlock;
+	}
+
+	err = mlx5_lag_shared_fdb_create(ldev, NULL, 0, sd->group_id);
+	if (err)
+		sd_warn(primary, "Failed to create shared FDB: %d\n", err);
+	else
+		sd_info(primary, "Shared FDB created\n");
+
+unlock:
+	mutex_unlock(&ldev->lock);
+}
+
+void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode)
+{
+	struct mlx5_core_dev *primary;
+	struct mlx5_sd *sd;
+	int err;
+
+	sd = mlx5_get_sd(dev);
+	if (!sd || !mlx5_devcom_comp_is_ready(sd->devcom))
+		return;
+
+	mlx5_devcom_comp_lock(sd->devcom);
+	if (!mlx5_devcom_comp_is_ready(sd->devcom))
+		goto unlock;
+
+	primary = mlx5_sd_get_primary(dev);
+
+	/* Secondary devices need TX root reconfiguration */
+	if (dev != primary) {
+		bool disconnect = (mlx5_mode == MLX5_ESWITCH_OFFLOADS);
+
+		err = mlx5_sd_secondary_conf_tx_root(dev, disconnect);
+		if (err) {
+			sd_warn(dev, "Failed to set TX root: %d\n", err);
+			goto unlock;
+		}
+	}
+
+	/* Try to activate shared FDB when all devices are in switchdev.
+	 * Shared FDB is optional - failure here doesn't fail the transition.
+	 */
+	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS)
+		mlx5_sd_activate_shared_fdb(primary);
+
+unlock:
+	mlx5_devcom_comp_unlock(sd->devcom);
+}
+
+#endif /* CONFIG_MLX5_ESWITCH */
+
 void mlx5_sd_put_adev(struct auxiliary_device *actual_adev,
 		      struct auxiliary_device *adev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
index 7a41adbcee71..cb88bf34079a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
@@ -45,6 +45,13 @@ mlx5_sd_get_devcom(struct mlx5_core_dev *dev)
 }
 #endif
 
+#ifdef CONFIG_MLX5_ESWITCH
+void mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode);
+#else
+static inline void
+mlx5_sd_eswitch_mode_set(struct mlx5_core_dev *dev, u16 mlx5_mode) { return; }
+#endif
+
 #define mlx5_sd_for_each_dev_from_to(i, primary, ix_from, to, pos)	\
 	for (i = ix_from;							\
 	     (pos = mlx5_sd_primary_get_peer(primary, i)) && pos != (to); i++)
-- 
2.44.0


