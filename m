Return-Path: <linux-rdma+bounces-22825-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TPUPAVX7TGrYswEAu9opvQ
	(envelope-from <linux-rdma+bounces-22825-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:12:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB171BBAC
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:12:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=TKWq1GNV;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22825-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22825-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29CCB3095A12
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3041A78B;
	Tue,  7 Jul 2026 13:11:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4241611C;
	Tue,  7 Jul 2026 13:11:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429876; cv=fail; b=JfCgQqZNEE+uM+YUmxG0FyF+8WuEIjK9rUOVHwBK0hhDVI0UJm9iqJkQ840I3E+6z4JdsDEmsrg2ilLOaaxn3UY+wsRd3ZZ7aOme7+KDXVimdiqYwxLo5p7LVKFnDLbUi9NlBP67a8NqDapraOLd5fPtYDdw75KVUprH4DEIwPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429876; c=relaxed/simple;
	bh=fxbiNJd8PQSNq+hP5U3iGcKMjlstCEyxewAi1gKWsdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdMmyO4JmVPBlkv7uaHMJj/u/fjV2aSgJ4ckof/xjuiZBVFD0o13vQdw8ra1tfvidDw86uA0nEBf3tauLVP042w0S42R2+ULx9P2V71ItFaErovsIVDS4hh8cc0yf+24JbJ41h9mXvQAJqLhg/dUeTU9dHq0oaSltBwoKeXsrjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TKWq1GNV; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+obkJBlJfYBz32YvpgvHzsmxw0jR12zgTWYt2TukRfF3aHi4keUmJUxLDIl2JYivozsiawN5O302r/yaUx+rqxeAhhbn/oWMLUTD2+E9AKQb4GM52uk4KkEfINec3f3VfW9YdnXU8aSLJHLwGwf8RmeNBJ0wWHn2ADBOXP+OVw5TOQYn9QXhu26/8Qo+5bID3etKfiBq6gdjaii/kcvUZ0pfzeXRYAADQeQBII2G2RBWcZqoN1t72ZEHdM+Orhh4P3Z24z2tX4JNtjfATuaC3WVgqfDog5/s+GDMa6VPHe8fiJ6xuNe+fuvnO9LcDuaxxE5a4y8WMZ+teEB6mFrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oSM8L9EzcNPwD733+1wF2j2R2RNHZ3w2c+gTP3jp94=;
 b=fIBzAktWEVGnTtE+/LkhbhcLvT+DjFe/bdvp0+3Ealx/sgRn+kHjyk0i5Wlryc5HRg6T1q4BLCyiwbshyTchc4LLOcyyY+7fqsTD2ux5WIxeoA7hiAVRZFJ3trHCgnwwmpqlha0V0m2F9BinuGYTBJtlkJjaaptETrYztokpSGEOUIidbY4H2UImWYRvxsiVwvOh3eMc2dMffiA9P0wBIRltsAKr/6UKwlRzrEWZTZY56FFJddBADzvzcKr7xtIwLMHAEmOIpN+XDV1jTyaoC0Cs9vgkmjemH3V0mLYX8F5UKB2tV39/JF9gwHhnVkdVkjPR/DqbHBuxt4Sml7hcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oSM8L9EzcNPwD733+1wF2j2R2RNHZ3w2c+gTP3jp94=;
 b=TKWq1GNVcTiZosSEQrTzJ1s8Zpua4h/zTqAGB/lLm88NwOh1lO7dglPU/b2Vw1nTzCvWnIVxA9Ga9ze3MRwrt5i3Zps1K9Iup75cnwWDK7bMUb8Gpl9SSEow6ilKtM3jQB0nkXcRO/AWQZUkQLDS673AMDQNu8xVK/yzqzOYPQC+pBv86Pn9l8p0L7fGooxBP4bPW4gOuRIWF1xO+FgTaQfLGoA9C1DpAgsTTD4Hm1G/XW9EiIRu9QPIJ4OUQ8QvwhLSryPYZM+APh74fQr5IYNpxDBzT5zflZU1gwB7+1dLDU5cV9isfR2OksMceRggY36IjSL0AUAd9PgZ7ljC0Q==
Received: from MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:11:09 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::4a) by MN2PR03CA0021.outlook.office365.com
 (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 13:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:11:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 06/15] net/mlx5e: psp: Factor out drop rule creation code
Date: Tue, 7 Jul 2026 16:08:49 +0300
Message-ID: <20260707130858.969928-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e0e9a8-d496-4221-9a08-08dedc2935bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FcmFlBQuaG3CxJZaFDBHVHR3oZgy6+b/hMVzebZ7IBs05eyQiNRt5Aus7mRdTk2QV+YkYWRo5SBEYvgKe4ZiirTS+NssnG0VrqDi29uPc071B7hWFIx7RbpVsHcwgHjnCojlyaJ8qLzAm6j1VWo+UPbTD3FvNb3xXavKAezOyb/kXeUEaKW9y1nR5rq2NnsVlhwY8t9NjlZBM8iD+Bjw0qzBq+/iCa9xOd+VliQJ600Rh49quW8RqCKYKNo4X2+ShdJgwvcdgeaP9GROV6ZLzKQcxxVxVRcCADQ3qHxik1r+g4Uvjo6QP8amIu/j5u9DAfrWqLt0SoaEneRuALtT2xPslhWieCB1H3d+xzf6SPZ9UabNS91lifoezc78RWifk38mcf9m6Y07aG15blXfYRqvOyMZBzr56Q9iC6nXo8HiTvnNNZod/1mtUS8MI2vPkoDB0oof5fiRNfU50W2trM6b34d3uWa52XP787A3F/ufqhTcmqTlc+UdVvaKGVutvYWRivT84JRE27Wo/2d1ouNwvzu4HOys311phzs+OX5IJc+IXde3Uf4MwWJmaj358pDNrSG42HiVwH/QiH8mPeJehddxkNkf30PEurSeyYLqjEveUpfun61mfL4MaPwwCj/q+qsbqrbKqt+cqkBhyB6PBFaiw6TKxVEYRqp4y6mnUjFfRLGtJvjN0WIRFMFYw9RSJN4uS5FeJQaX4WJDyw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wdVXarDdhONQP8kmhHYzrEWl6aswRVNi5WguB3OHJtZ7JEMi4G6vhgHHC6V8UhxatcZ3py5eBMuUpUAvaAuTKi1CyxUkm9yehhavqRvo82/GDco449ulruSc2YWkaB/Y1/OAWBuA+T6dNodCMDlg3QVVA2hB5N71mGKLmdB5FZpDe6Orl+zJmjrRRFtrqPqjnx+8Nv/mKeJ//GLCIxup+aUR7lBuHoQaJUFyahVgHpaZQlnfDGGRH9umhkfm4e5n0CrpCcLR6rNYmAN7cCxtbcQYTkncE+4yLXSA9vdAElhmJhhSedHOCMh7CB66BtBjb5wDabXCvxYJX7YEUYFzfhH4onr884ghVzGBxeLzkCBc0ZYeRpIjFZO3T9YfrCeoUFcW8uPF96hr/YjE37pOOicg8hVBNYGQGdOz9uasuAHh1Wpr4xbW9LZbE7YbNkYR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:11:08.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e0e9a8-d496-4221-9a08-08dedc2935bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22825-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EFB171BBAC

From: Cosmin Ratiu <cratiu@nvidia.com>

There are 3 rules added with the same structure. Factor out common code
into a helper function to reduce duplication.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 65 ++++++++++---------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index a1c7ca4ae722..bdf97e373b42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -184,6 +184,27 @@ static void accel_psp_setup_syndrome_match(struct mlx5_flow_spec *spec,
 	MLX5_SET(fte_match_set_misc2, misc_params_2, psp_syndrome, syndrome);
 }
 
+static int accel_psp_add_drop_rule(struct mlx5_flow_table *ft,
+				   struct mlx5_flow_spec *spec,
+				   struct mlx5_fc *counter,
+				   struct mlx5_flow_handle **rule)
+{
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	int err = 0;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter = counter;
+	*rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(*rule)) {
+		err = PTR_ERR(*rule);
+		*rule = NULL;
+	}
+	return err;
+}
+
 static
 int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 				  struct mlx5e_accel_fs_psp_prot *fs_prot,
@@ -253,56 +274,38 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 
 	/* add auth fail drop rule */
 	memset(spec, 0, sizeof(*spec));
-	memset(&flow_act, 0, sizeof(flow_act));
 	accel_psp_setup_syndrome_match(spec, PSP_ICV_FAIL);
-	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
-			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[0].counter = fs->rx_fs->rx_auth_fail_counter;
-	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 1);
-	if (IS_ERR(fte)) {
-		err = PTR_ERR(fte);
+	err = accel_psp_add_drop_rule(rx_err->ft, spec,
+				      fs->rx_fs->rx_auth_fail_counter,
+				      &rx_err->auth_fail_rule);
+	if (err) {
 		mlx5_core_err(mdev, "fail to add psp rx auth fail drop rule err=%d\n",
 			      err);
 		goto out_err;
 	}
-	rx_err->auth_fail_rule = fte;
 
 	/* add framing drop rule */
 	memset(spec, 0, sizeof(*spec));
-	memset(&flow_act, 0, sizeof(flow_act));
 	accel_psp_setup_syndrome_match(spec, PSP_BAD_TRAILER);
-	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
-			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[0].counter = fs->rx_fs->rx_err_counter;
-	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 1);
-	if (IS_ERR(fte)) {
-		err = PTR_ERR(fte);
-		mlx5_core_err(mdev, "fail to add psp rx framing err drop rule err=%d\n",
+	err = accel_psp_add_drop_rule(rx_err->ft, spec,
+				      fs->rx_fs->rx_err_counter,
+				      &rx_err->err_rule);
+	if (err) {
+		mlx5_core_err(mdev, "fail to add psp rx framing drop rule err=%d\n",
 			      err);
 		goto out_err;
 	}
-	rx_err->err_rule = fte;
 
 	/* add misc. errors drop rule */
 	memset(spec, 0, sizeof(*spec));
-	memset(&flow_act, 0, sizeof(flow_act));
-	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP |
-			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[0].counter = fs->rx_fs->rx_bad_counter;
-	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 1);
-	if (IS_ERR(fte)) {
-		err = PTR_ERR(fte);
+	err = accel_psp_add_drop_rule(rx_err->ft, spec,
+				      fs->rx_fs->rx_bad_counter,
+				      &rx_err->bad_rule);
+	if (err) {
 		mlx5_core_err(mdev, "fail to add psp rx misc. err drop rule err=%d\n",
 			      err);
 		goto out_err;
 	}
-	rx_err->bad_rule = fte;
 
 	goto out_spec;
 
-- 
2.44.0


