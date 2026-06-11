Return-Path: <linux-rdma+bounces-22113-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4IFRG+y8Kmr8vwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22113-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:49:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D47672755
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:49:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=re62Fz4V;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22113-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22113-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C78030034B9
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A53E0239;
	Thu, 11 Jun 2026 13:49:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490130E0E5;
	Thu, 11 Jun 2026 13:49:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185766; cv=fail; b=YXEpQYnbMspoDrdvlB9aigAPEkoKsRh0jVwhQfCCEV6cbyaCwwXaV72WWUrTwoIAaSx1khyz4ldb6AAnrwVisve5MGWCpPDJ1HQQkD0S0Ad4mVwqXvF+O/ACichGY9+3W5F21QdYo/diyKT7StKrg4JQxMEoirGUq/VGWpDi0/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185766; c=relaxed/simple;
	bh=o+Fr8P4lYJ/YDy90N0ZjGN1IiQvkPEuVcq7B9NbebkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZQOt17kUbSM6ELRJONCzSIb4WxM2XnY8exLghLQoLPbViBqlaf4ROtKXu9bCgBa16nZLR1v1jtvJORykJTlapDu9cMuLPmJtA0/0tiWt8lcWDqhhtSgxXn/l6s2vx0H2a+VGwsIhwQGZ73+c7E2r5MnepqcNeOZTIf4HFTln+Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=re62Fz4V; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuMTejqi7R//FrUtWtdqZe6gEQX9Oyznq95WpG4FkRa6j+nShKh1DAefR2rpIfkMW9KiunoEvDQCrbhhA0cMdvzJ256GHuCd1czuqf0BZBXfEV3DRgWlcl9ZKFIk5Tu/lEN8YUPIkdcJzr1Qsluv67TI4x60br49jZcNP30xmnfX/PMHDx1Na+VLxsjRYGbeR0odEa6GfWWBimV429el/g7V38PwUqVdsT8gOuQT7AOKq6zDwRinHr9ei3s+JNJQDUVOiL1oY7RcZCMEU8JvFCgoT7revkdw/cAyc0JkYdl7hwv0afrMzuERDw7zppoF5JZQDAU24bO+Vv5ph0Kbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeG1dDNTBRVnH+p6dsf90ZEI1zR0KH39Mg0abtUNuOY=;
 b=IDkFwmT/ul/SoxPUW7zMD395lyW32f2QpGQreYratOjSn5j9RyqBPtvVtJMV3uiRXgN5HWKoTp3SXGbO8dG+bBKEMp647VomppSPzdulL6T9Fw0p7psA0z0NFW6gBIup25vuOu4QD0PcWBCOeOMhznwEZl6D3TyKVRKfxOC6t5dB5qyqOTZBHDQA8nlinOdtwMVm8f+DYyZgUX4kbhFR+4qfnB3RSpZC1J4cwIU/OmYPnw/rXsAR5YJ8YB2rMEeFruoi7utsNK2Zr7b2da03/MgF5WaWZJvPj7owtzF+M3hUDU3uemPC9jBi6gZB/PoPY5Z2NQ89MzcRs1upitJvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeG1dDNTBRVnH+p6dsf90ZEI1zR0KH39Mg0abtUNuOY=;
 b=re62Fz4VXrFk0BIUzPy4vzCGDy4vXQYb2yrgoxAhtELF0XAridRMkopVSNyW1CTX9ViDxdSgoonr+ZNvcfIgMGsalHWX/o/KBgZn/1VLqh9y/S7rtapqiMXYV2MyNgIUntVj2F2sjelDrpM9SLgPfSuL3tuF6OVfCZPS+q6saQOeD26j3YJXbH9J5Qyv2maSKXrp8F6jXaxGP+LKdFh4KwSd3+eqXKMz2y8Yfs9KXoQ6xCimi/2Xxum59VdJxIEPsHZHJGxfzO1rSxtv5EZEI2ezL5OWC+TUQftZ9oUreClvhn1x9Bv3eepwF1IyCOoPb/HB0Y9d7wiBqGqRa0HkBQ==
Received: from BL1PR13CA0294.namprd13.prod.outlook.com (2603:10b6:208:2bc::29)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Thu, 11 Jun
 2026 13:49:16 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::81) by BL1PR13CA0294.outlook.office365.com
 (2603:10b6:208:2bc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 13:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 13:49:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 06:48:53 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 06:48:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11
 Jun 2026 06:48:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Vlad
 Buslov <vladbu@nvidia.com>, Paul Blakey <paulb@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net] net/mlx5e: Fix oops from ERR_PTR in act-miss restore teardown
Date: Thu, 11 Jun 2026 16:48:36 +0300
Message-ID: <20260611134836.534015-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d25461c-bdc3-4f4b-5808-08dec7c03a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	tpGz4hSpPD4w3duk2QDygZwcht1aV2U+JSxLojW4KQ+iZGd7/ZP4xSIklWX6HlfVzx7ZteMvX2FU13dWGKsdZLpPpJD9CucamHCWmiVY5YlHKqara0fZvjRmauaIv3wCmO3lA1qn+ng27WD54xZG9Y2ztCORCHWfdyHlHdXl8pAj5OJtYusxeFE08n9tHIgwLLfiYdaReKw2rjxEafDHxEKsyXjhc418XN9n0QlxEXGWubc53B+fBQccV0G9Ly9btgUUMVAwHIjeQ1W+TYDYUR6MMCnQpMeuT7K1GUKWjHnzoe9Z1wUcEpJefLhBykg7KeaXvhRdQVWwyZiKj5C2e1Mh7Y+bMQNVwTY1Ogz1Krf0dnGtDpdI04bXJM0s3ghhlpfWckqWRrkcFerDl3lfMEQoHvGyqfoo0NdqsmJcLhUmYCoa1foJZGXupoO7gj52NIF3c2GWdiv8mgGUNpAeRna8lL0K6VOh4TWCR33mFTBHou3hPkwAj2b16bYaubbVi4RSBHoDQEf8Kcgk8cpjxEHmVTCEE3IMt5ofLqlBbrwjOutHJLwh97HbcL1m+hfidX0k+MP5nERJC+WgKpS0+Ff5wTI06Qm2U2RCx7DbRu+tYpSGTp9LFGhEuMmsEPwoftzu/p5MdZFsKtrR2VuuXcRbI8JwbOfYZ+XSqUFvk8N8RivSiZN5/dNO24yh8N3IJX63+odedNt46489Dxz0XfT8I6TdG3yaSnBCWQ04sg4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5jZ6Cuguopydb7engtFQ8wBGLrBMoFTN4npwF+HohdO9mvk9Io9BEJ3N8la8mynnNn12J++jSb6YOzrHupDSN1j9e/18p3Y/LmpF/JtphPKYXPW2ubQH5vnVTevIeJxOvvdxc2wwxHLp4++Wn+DQdj65MXg6KhM44WHaBsXFZ1nkRce3skzsCMv/pjMoJnXtOwbF9px5DzWr7oHgMTi8FbL4lAyWsIU+hE6mn9iYXMlSQDDKwOYlRp7oboUhV1f38pcfxS/ODS6+QiO+ZeCY8pRMVRf8qyIaUavbCO89kxh2dU9SaX/lOi5XdWGuZZ1dbAU0C2J5FTAHvuTA+gQYwhd3F9ifZoknBpfGR1XwEprkyw6uEwTFOtI8aAIynbkFutcrchv/SFIBW7kIvTy7aFBDAkEBYWE0NZjnP7vHCKmhesj7vcDt/UxSFr7DJmgz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:49:16.0753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d25461c-bdc3-4f4b-5808-08dec7c03a87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22113-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:vladbu@nvidia.com,m:paulb@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:lkayal@nvidia.com,m:cratiu@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60D47672755

From: Lama Kayal <lkayal@nvidia.com>

Restore-rule creation stores ERR_PTR(errno) in act_id_restore_rule
on failure.  Teardown still called mlx5_del_flow_rules() with that
value, which dereferenced it like a real mlx5_flow_handle and could
crash.

Clear act_id_restore_rule to NULL in the error branch after
esw_add_restore_rule() fails so teardown only sees NULL or a valid
handle.

Call Trace:
 ? page_fault+0x1e/0x30
 ? mlx5_del_flow_rules+0x12/0x140 [mlx5_core]
 mlx5e_tc_action_miss_mapping_put+0x49/0x50 [mlx5_core]
 mlx5_tc_ct_delete_flow+0x4d/0x70 [mlx5_core]
 mlx5_free_flow_attr_actions+0xd2/0x160 [mlx5_core]
 mlx5e_tc_del_fdb_flow+0x15d/0x210 [mlx5_core]
 mlx5e_flow_put+0x23/0x40 [mlx5_core]
 __mlx5e_add_fdb_flow+0xf3/0x430 [mlx5_core]
 mlx5e_tc_add_flow+0x2ab/0x9c0 [mlx5_core]
 mlx5e_configure_flower+0x2f4/0x620 [mlx5_core]
 tc_setup_cb_add+0xca/0x1e0
 fl_hw_replace_filter+0x143/0x1e0 [cls_flower]
 [...]

Fixes: dfa1e46d6093 ("net/mlx5e: TC, Fix using eswitch mapping in nic mode")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index a9001d1c902f..4c135858f297 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5863,6 +5863,7 @@ int mlx5e_tc_action_miss_mapping_get(struct mlx5e_priv *priv, struct mlx5_flow_a
 	attr->act_id_restore_rule = esw_add_restore_rule(esw, *act_miss_mapping);
 	if (IS_ERR(attr->act_id_restore_rule)) {
 		err = PTR_ERR(attr->act_id_restore_rule);
+		attr->act_id_restore_rule = NULL;
 		goto err_rule;
 	}
 

base-commit: 0068940907d33217ae01217f84910a5cde606c17
-- 
2.44.0


