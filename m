Return-Path: <linux-rdma+bounces-22005-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AlO2OcGnJ2rz0AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22005-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:42:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ADB65C813
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:42:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=N0KYp3+b;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22005-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22005-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EE0A304CDD5
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD173CD8BF;
	Tue,  9 Jun 2026 05:41:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FA3C3452;
	Tue,  9 Jun 2026 05:41:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983709; cv=fail; b=GKd0dvi6eXmMsy0D7tCF7F5QCZDdQIgRef0PzOpgktQjig3e2TI+vhd/sF76TLxAZ9SM3xC9WTMgVDORq4vnLaImPErSHupoABF8+oGyUjVH7hbiX8T8VFjrrFH6XOs9ito7avRMrRPUviXLIJjR3+Tc1lwt02ttGiVOqXHY64g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983709; c=relaxed/simple;
	bh=v/f/cTfjgdX+CQBbrgaEkk6lKIzXZRLgqHpGBgR3rxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrLyKnM5se7fSuLHV0QrEIHEBAypnMQnWzaZFxdg8Y3B8GttqdlQ0eQCVE/Ggs3qJJjmDuCK9g6TsTTuCFAcbHraZfrk5/TG9xYE90qG39j3MlCapC+RyPGSQ4+OC+L54yoLjlnN7ncRutAoMkrR1w1UU96lXJ8tljL/DCTEWd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0KYp3+b; arc=fail smtp.client-ip=52.101.52.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLSJfK8ORmzu2j1HbyWBRzul+8dDJJM6ESDCCjioCeZPY2Bd7tEax54w11atCeNNR2Mk7XLeVGRlfgmH5NhZoIo7c8bTJ/fAT8aQy3cxnV+RI0E8DMCJ6x83OammcsHa9/oliLO6M9PD277oE35HpgJg+0+Xr7xF/0TcWnWj76omZMBG2RhIjkmKkiLu2LoBvt1l7EPN7zqClmDdK92yx53f4xhk8/hVA66FdJa7jMiM+c5zvrxtpdCwrMGbKYyCtxBiv8yE6ZgnBcL4LEfHarDUREvKcOBEZZb8qPHfN4+a6Xb6ewlIev1tCEYyQfMA5ai2XT1vSqCXdXf4QVPDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX+vszT5aj/CuFJkK1PkypNlygYmEwhgIKpU1HQCxmA=;
 b=DMFvjfWEkiMD2v1tyMmTDkkWf/S4U6zECERXxLg8xKG7Bo2ChDDY9U7Z6h316w+Z7W/o8kRUxi5sQvM4hqAPifUPaFhC+HgqGiG5GoPlczcpzKTqcpn6khZsvh06PrIxxHxTrB39KKIKKw0MddF/kmsb76vXJsLD142B/5e4/XWkKCxaYthMAjGXTL8akBCXhQRyMUuID88XSNetpAArYwPNat0qGLVV55iwTTs3M30oYwkXbki3VBhAysMpj9eXiPedm8QZ+C9UdevGdubUUas8lapGHoeMNdR3ciFw1azgB/efA+8mPqMNJTwsD6bvIAa9hoxBfHlOI+HolUmhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX+vszT5aj/CuFJkK1PkypNlygYmEwhgIKpU1HQCxmA=;
 b=N0KYp3+bKld0aW4DajBlPinNmXx8mRZGX60KVui+QyC1C8hrgPc31pVASkdx0q0aaeE6L61CNp1sGm+8W/mxQL/q9FhEpO1Kq+aSCWMRYV4xFK1AljEPO/eYa5ZuZQyerw99n5msVb7ZGyZ5MsBI9MjsUG8hxEGS888Y63UTjz1gy7a/qHVU0j1AQqJkH5YJ5O6Z9MnX5RdX3X6Z6cn1bTrF+sYn44uCQwYTwA9If9IERpltB8IUTOGVa2ZZeixxnu9OeF3pRwhshuM0x2ImrmBlxTwC7DromGuGS4sO39SCu/Vi0SrXLo9SVtPAhbrtNZpR2CIp/O4F1KpJbuMYfQ==
Received: from SA1PR05CA0012.namprd05.prod.outlook.com (2603:10b6:806:2d2::16)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:41:43 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::60) by SA1PR05CA0012.outlook.office365.com
 (2603:10b6:806:2d2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 05:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:41:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:41:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:41:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:41:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Or Har-Toov <ohartoov@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Kees Cook <kees@kernel.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next 5/7] devlink: show port resources in resource dump
Date: Tue, 9 Jun 2026 08:39:51 +0300
Message-ID: <20260609053953.487152-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260609053953.487152-1-tariqt@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: ef599c78-a2be-44c0-802d-08dec5e9c990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|56012099006|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CLwUvMq8sMtY2DWPovEaWRQCCEQODhPyUjVksje2zDiaPAN6z2j2TrnIvktgUDB4Od6nvHxIBf4fM91iKd4iKrwNGuK0zD/ea8iwfeLb61IYAUOPhE0Xy8xIc8OwdtEngjF/d/c/gugy/sDwIgVkEbQL9NRzH8MZbWuKe5zW0K0n0GRES0t9rLveImyBX6KxCamNwQweTE3fDeTIZgPhKSYegpcGKjNsd8REpdM9GoHqn0HPyBT6+qRIN+ZdPzXwX/y6J+Ge29pGspQ64WMlMEpQoGdg42FOMqhdQ4MVwVg2AnCEYKkGm5jq7pTabqAKgN3zQnlNoy2kFxW7CgMjIC1U1RjdlLjcqxLNwS33AlwRlOFesn16iGOVwf05ahna8CBUStpfK8fnSlqYHOmlbESaZBpFQt/W0BOb7uL7nnSQTwFPpW8C1SKAjakVQtfklHNLgr4iL31zb2BgIiG22wA/Jupqix0UpOLU0xpmABeVwXJmNvRWO/B/xsRSn3dVrZsTPwOmVtLdCPZsAvmE25byY8dLqhLd43OEDbkOzqJYPkFQuyeY+4AYOeHuERZgx8yMfecH7oNe/43gowf4B1tXmVaASv+uk751REVRkjM809MPZyTsmhZVMSOcNcDDVFOOAl0n/H1FE169337NpfG3f8ZwGKTGymnS25gRIU+sg1ha2I2acm6JbTubFkuiBqZLg8maKuvqto9c/1WPqVHcah52oSjT9JZqEtCYtdA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XhK1Z9h8ZUR4Jifp0FxG8a3o6IjR6I9QrIsqemVGrpum15W5WomcxGVzMtiFUNVLpLf59Hp+3nK8gRUJVmFwBt2Oil4qNgVH4W4iqrlxHwTZSJG8rsBtjBxLoAKBc3eh/I3U9BzK8zsAf7dFQR3EWLUg6avNnVkThuBaoILpTzMWpU8x8Nn+IvUWTD77CG7tvf7q+1F3EkHT1le3o7Cp0mga8si1gh5a3q4DW9Cd42lYtzxAzfJcl3Wo5kiJufeU4HG6Ji78LtJVNHBfOYcWcdNrf6CKzAKtDAKIV7loVfzooid52omYu6nHvefSFjLU2aL6WDHNvg9UFfdBVrbxfLPnUepDd6++0I8fww9CXjmcXJT7vCvmcY0izMJfyPJdHZzFHxVJYIAsQQR51RjoS2LeJ4wYbb1AkRim/qxN+Gv7YnhjwaKwU1ul++MZi/V8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:41:43.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef599c78-a2be-44c0-802d-08dec5e9c990
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.
 com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22005-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85ADB65C813

From: Or Har-Toov <ohartoov@nvidia.com>

When the kernel returns port-level resource messages during a
DEVLINK_CMD_RESOURCE_DUMP, display them alongside device-level
resources.

For example:

$ devlink resource show
pci/0000:03:00.0:
  name max_local_SFs size 32 unit entry dpipe_tables none
  name max_external_SFs size 32 unit entry dpipe_tables none
pci/0000:03:00.0/196608:
  name max_SFs size 32 unit entry dpipe_tables none
pci/0000:03:00.1:
  name max_local_SFs size 32 unit entry dpipe_tables none
  name max_external_SFs size 32 unit entry dpipe_tables none
pci/0000:03:00.1/262144:
  name max_SFs size 32 unit entry dpipe_tables none

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 0962ffd861ad..737cfc7437f9 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -8954,18 +8954,23 @@ static void resources_dpipe_tables_fini(struct dpipe_ctx *dpipe_ctx,
 static void
 resources_show(struct resource_ctx *ctx, struct nlattr **tb)
 {
-	struct resources *resources = ctx->resources;
+	bool is_port = !!tb[DEVLINK_ATTR_PORT_INDEX];
 	struct dpipe_ctx dpipe_ctx = {};
 	struct resource *resource;
+	struct dl *dl = ctx->dl;
 
 	resources_dpipe_tables_init(&dpipe_ctx, ctx, tb);
-
-	list_for_each_entry(resource, &resources->resource_list, list) {
-		pr_out_handle_start_arr(ctx->dl, tb);
+	list_for_each_entry(resource, &ctx->resources->resource_list, list) {
+		if (is_port)
+			pr_out_port_handle_start_arr(dl, tb, false);
+		else
+			pr_out_handle_start_arr(dl, tb);
 		resource_show(resource, ctx);
-		pr_out_handle_end(ctx->dl);
+		if (is_port)
+			pr_out_port_handle_end(dl);
+		else
+			pr_out_handle_end(dl);
 	}
-
 	resources_dpipe_tables_fini(&dpipe_ctx, ctx);
 }
 
-- 
2.44.0


