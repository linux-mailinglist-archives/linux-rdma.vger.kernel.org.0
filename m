Return-Path: <linux-rdma+bounces-22620-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HK2ABL7DRGoS0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22620-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:37:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49F6EAB72
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KzmhidJa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22620-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22620-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96B703030EBA
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7C3C061C;
	Wed,  1 Jul 2026 07:35:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AE3AE701;
	Wed,  1 Jul 2026 07:35:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891337; cv=fail; b=gjbgf4j8Yx0wxXHgybiZ8yp/1ev6PCa6jVM4YSq9+Uesy/DaDdETB63YVesKvN8lxy33Wv45LhgcyPJh12xPC2PtC3Lm4mBSQEqFEQWSdZjWM4NVX+/H1TnYlJhGzOoCStHf/gvmfM0UIeWm3v9wuEs9acELd/w1OkFmJ62Qroc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891337; c=relaxed/simple;
	bh=QGv54V7hK2CAIEzhn4H9m9sSyEkeF+w2Pcw2KBOTCGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUqrOSN+Xqw97DUuY8WcXEqk6OwDJbjnuTjjgtafWurrrZ26erypBOMsPuzwjFyi83652aSL5EVZAOUYFFwaDXJiVB6PpgJAT8uvI10bToqUYzfghSf9xR0KmmKshrDuPrYM5ctF9cK0b3XWcDsfytRRV1jXR1e0+It68oUOX6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzmhidJa; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmDLvgYoVjl2wT/K38ARiUujpizi6mw5NWeSYAWsG5qZmDyscVlg8EblcSY/xqkegqcue80sq+I5MbYCsc54m+qQpj9fylRRZaNGqUObudg7JPtCbRt9qjeVcylrA5cX61DlmKT3UN/Z+lB8Ew2jwhtyPmabdXTAjRfRy8Scw4VNuEOlAjoMFuvENt4EdzZwkqmAQCxbOfL7PPTyGBTLQLYNsOUfcMmrMbPK1+PVRSrMQhYN8eJtfvK6pUZwEoenXym5yrajfuAHH3XFyTSMml+2c7P8ydTex1SibKRD516by8ydtIbuB3l2g+MQUzP+R1ueTK3KyPVy8UOPxFxb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBUpjInFLVeZq4G9d5itiAaVZ/kyu9u97IT77qcsgbw=;
 b=OwUQPgHX43dJEFrhcCbp/Lyhlk9yFcr9+l/DUxxqHskWdrXF425l/XGq6Uoiafv4Vg0fvh66Q/WHU4bv2ybPuA8PNWbKBpwHRrnqEF5ni8kW1j074T3rCMl7PGlEfkppkkiCSEZyUy+Gd7cAgJBCPO+UXcxtrHnQG5ntwv1jSGy1aMnSmZ/azr0UX4m/KfqOgrCDuaDBNsD3+Y2mJcdclmv5srNfZBodtBkgPlDu1pgvtY8xaIVWWt0eGSdvYotPn15I0c7JcZlPRYR33lRiPLjAKkrADi1Icj/zPQuaPxPpwDuB+xrhpcsqu5pCqbKibQCkveM0kOXt6mr0AH4aBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBUpjInFLVeZq4G9d5itiAaVZ/kyu9u97IT77qcsgbw=;
 b=KzmhidJaWMq6tW+vNRq7eKiTMhxhERef4LyVrDwETEt9VJDidsGfQnWcOmUMeGFKnV4LLhuWgi1qL5/aW3vvZs1Ab6v1CAnwX5ymTWbFTg8vRs19wbiljCDAwG2YTPky3sCAi9lNl2Enk9bPVpeDOk52VTFXgAC+d9q+ebAnNaBYEu4Ba6zBXluLDAd5VLH04tdZgGSwjSUJ33fX63C7TKkL356esLvYfu9sjXttgBGgW249+vcRSaFlvyIV022bzYi23kP/MGyZ9PcIMDhmLi9VUvnD7KcvaY0vpgBzoYvNGLZ+TO+od+K4KJ5ffStCId7VHbluxw7fgJU8P4dOfQ==
Received: from PH7PR17CA0036.namprd17.prod.outlook.com (2603:10b6:510:323::20)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:35:27 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::aa) by PH7PR17CA0036.outlook.office365.com
 (2603:10b6:510:323::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 07:35:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:34:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 08/14] net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
Date: Wed, 1 Jul 2026 10:32:48 +0300
Message-ID: <20260701073254.754518-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
References: <20260701073254.754518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 7baba91d-cfd2-4464-e725-08ded74351f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b3crdXuU8quAqBmDTBxtT6jl3SYFlVuxuy7ZH8PPUoGgrNQpQ6dHOrk58ShVfjmIFn8aD10lqO41t5OPSZYu5Xbocith4nWGYHHy8s3dkrNEiEZdbrqTALo+Mr8p9WXgGm8vEpukhVkoGGdduTfBVQHeGVsvCL464k4SYUcnPWThQXJfVx7Y7ReKT7zycAc71XMExeJ9fWRPW8l/9DayGYl1bYq8qGytVIJhlbOc3CkNZwBNeNbYp2HRUpCxeEpA71B2flbDxA6sjFg1ja5pnuucoUEOQ5hyWqzZj5y/XbZZrJbrD2lGxojRUTvvcsHDgH15cX2NP6b6Vtku4bWuM7mtF6B3KLcFW26xUAoqAemQUDXZG8WGr3yXw2obRcmXNHByCwbQ7ZneMhI1pTXRifVrka26nxqwCC1G4g2DZsXLku62IGJDzglrmX2SE/rV2ZUw+Mg4tLtdX/GDsixtrR6/Au5gqiwYqugfmjcJhGMYpNWgAPvISByqIzjAZ3kzbGQg6T0qcQ5Gvq0sdviZYfwImB2MCbwVyjcz4O3xUAncUotyB0brzImM88MqJpvozkG8k4ju/VKxIOGtasd4dmKcD3QhY5HrCwVYkiY76F7r7eIHpiu9ok7kwgv5NDkQFUnYITxuDWVewhMp9Dp8pyGiZ++ODjonMfzJXStD2ZsIa63KxE5Uh4gezfQUw+dFygGPp3kkjBXotSKXUrKdMA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ERslEPKOGVZ7wQd+LsoPdFhtjgL6oULdpuLvrWt9m9v9H83sT9clCEustqRec8Uaiy86Q6+9VvnXseTuN1OVZNdTqqzQz8UdPE7qrmQgvjHid4A6KhYukMZRfQ86kL4WkkrmUMYviN5mB/a3KRTNR9g5l5xGbkfgQLZLOZFOQLnm92SfdtU3WsbXijtwwc4HGVZkMXxtRd3+6bB8MXXl5okkQhZ7qwuSooFDaQxIcNy59jRPZQpGndQaGftMB8Xe7CdO45iReHF/J+/QbEOsNmJBSGeH0nOtlxfJJlLpshwDvHZbM9ibHylACLZALk9/bnjO2pSEsIS2yn/46oXkfzXn9pl9aEdFHThow7i4A6Pi+Q316uwRpeFJu8luXXOMk52M+op3fR3iVqjLCEGoe6vhARQz5a4KDVuPWI+bU6YFXJ1n+zzB1C+QBbD6mTOA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:35:25.9635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baba91d-cfd2-4464-e725-08ded74351f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22620-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD49F6EAB72

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, the master device of the uplink netdev was queried for its
maximum link speed from the QoS layer, requiring the uplink_netdev mutex
and possibly the RTNL (if the call originated from the TC matchall
layer).

Acquiring these locks here is risky, as lock cycles could form. The
locking for the QoS layer is about to change, so to avoid issues,
replace the code querying the LAG's max link speed with the existing
infrastructure added in commit [1].

This simplifies this part and avoids potential lock cycles.
One caveat is that there's a new edge case, when the bond device is not
fully formed to represent the LAG device, the speed isn't calculated and
is left at 0. This now handled explicitly.

[1] commit f0b2fde98065 ("net/mlx5: Add support for querying bond
speed")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 36 ++++---------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index faccc60fc93a..d04fda4b3778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1489,41 +1489,16 @@ static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
 	return err;
 }
 
-static u32 mlx5_esw_qos_lag_link_speed_get(struct mlx5_core_dev *mdev,
-					   bool take_rtnl)
-{
-	struct ethtool_link_ksettings lksettings;
-	struct net_device *slave, *master;
-	u32 speed = SPEED_UNKNOWN;
-
-	slave = mlx5_uplink_netdev_get(mdev);
-	if (!slave)
-		goto out;
-
-	if (take_rtnl)
-		rtnl_lock();
-	master = netdev_master_upper_dev_get(slave);
-	if (master && !__ethtool_get_link_ksettings(master, &lksettings))
-		speed = lksettings.base.speed;
-	if (take_rtnl)
-		rtnl_unlock();
-
-out:
-	mlx5_uplink_netdev_put(mdev, slave);
-	return speed;
-}
-
 static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
-					   bool take_rtnl,
 					   struct netlink_ext_ack *extack)
 {
 	int err;
 
-	if (!mlx5_lag_is_active(mdev))
+	if (!mlx5_lag_is_active(mdev) ||
+	    mlx5_lag_query_bond_speed(mdev, link_speed_max) < 0 ||
+	    *link_speed_max == 0)
 		goto skip_lag;
 
-	*link_speed_max = mlx5_esw_qos_lag_link_speed_get(mdev, take_rtnl);
-
 	if (*link_speed_max != (u32)SPEED_UNKNOWN)
 		return 0;
 
@@ -1560,7 +1535,8 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 		return PTR_ERR(vport);
 
 	if (rate_mbps) {
-		err = mlx5_esw_qos_max_link_speed_get(esw->dev, &link_speed_max, false, NULL);
+		err = mlx5_esw_qos_max_link_speed_get(esw->dev, &link_speed_max,
+						      NULL);
 		if (err)
 			return err;
 
@@ -1598,7 +1574,7 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 		return -EINVAL;
 	}
 
-	err = mlx5_esw_qos_max_link_speed_get(mdev, &link_speed_max, true, extack);
+	err = mlx5_esw_qos_max_link_speed_get(mdev, &link_speed_max, extack);
 	if (err)
 		return err;
 
-- 
2.44.0


