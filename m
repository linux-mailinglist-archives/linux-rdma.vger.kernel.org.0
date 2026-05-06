Return-Path: <linux-rdma+bounces-20046-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CU5CIjB+mnRSQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20046-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3C4D6171
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5773023DC0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 04:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A082F3C0A;
	Wed,  6 May 2026 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="INMspnjZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE27299943;
	Wed,  6 May 2026 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041204; cv=fail; b=V7X2G76GedubCUR+hcu7N5/p/EwALvmUsEhittNv04nu4hN2kHycaJ7A99na+Jfayp65otfpOrv0NgAnQSxCaVBMs8LAVpboZlvQhnCohp8/eM5hFkPAgH9S7yQWODA+MlOqYPLg9S9xq7BqlITaazzGRXIpBHUxwsqWDbb7qiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041204; c=relaxed/simple;
	bh=ISkGucHQIKYycHPrSOKHVTcqzDMSpWE1KLA6lRmoErg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL14hVVJ3PvlbU4y29CNG9h3nrmxRc9zqeqnOIoEGDpjeBN23Epgm7VV5NuKenGZoUVZQcMLl0aLg322TihI0o9nF2WhBauEzYoEGp/4WfywwX9JRres/FUokPnw5hGqw5k2Xt89XtM2Qu2Eyxz8b+2nkGNt1MNeZrllCZcZJeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=INMspnjZ; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amoGwlWI1Qzz/YrCreR9D4JScPz0VXPkCHI8mbObEQry1C8D1olujNbBWoNZvZgPMOqdrJI7yVtVbRH/QRrceIj/w/p8aRyEdM7fc1W56XtyuB7CKwfpsE5zh12K4GjRnZWsu1I+ofdYEHnU1bWWG/K/XFem9DomBAAcPbjyQsPjpzXsWgXgzg7IsCPbwP1LPdBdgFVSZIW/l7zg3qKwGNbwmf2Mf9Gk9PFWEPVV8M/xT8O+qltYyTqBlwfL+mzxlAjaMwGKrzH5dyGv0Oon3F9pgg51zKkc2OKAOisBiBiC+Xj54izS4f+/5pceA8TkO8aNA1JTUKn8aGqgrjeSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKYDoFR5HFeyrD+5Are8uKepBTc6Ql0EQo/DWwy4Tlw=;
 b=Bq7j6LPsVj6MqtiWguub6EMZl8ZZPF3AnI4ZbcpDoqcPyKCO3O0MZrLxn4L4N5F9DHRKU3A8VWoANqk4NmYpNsTCmV7FYg1WqRBuNXd341ENtrQTCZKQOoPj1G3Wfn2I3HG0hFa7cYu8H37C7TaIdk3+9xoRLQcGlDIg+ZbUShoQtu3uHmZ54ACILXkpXxb5IEzZVXUyrNzRDOHwHPGWhBZmhuyNHZfXSCsXeNqtTColQckCXbuUIoSmlCMjH1rO9GFLtKekZtgaSr+dc3snp6U2tMUGhFKR5q5GtxA+uISKJHjT5hF0obnvjH0LmN5y6t4U9N/Px0M5QyCXWhNCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKYDoFR5HFeyrD+5Are8uKepBTc6Ql0EQo/DWwy4Tlw=;
 b=INMspnjZbSSlSNHOraLGYQhtzxCFztdjaKwn/aQnQy5+FsOq8kRJci9Nb6I9uF5Jw4vVZQGkc9Gr/TEva9TyFMcZbQdtrGMVJ3GQpVeA9dUbZm2wE4hMYFrOednNDsoUjMts+6S+zwy6eYTb72dHeQ0io6AkNHFJrchJwvWpOIs=
Received: from PH7PR17CA0072.namprd17.prod.outlook.com (2603:10b6:510:325::20)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Wed, 6 May
 2026 04:19:57 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::ca) by PH7PR17CA0072.outlook.office365.com
 (2603:10b6:510:325::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 04:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:19:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:19:54 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe
	<allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 2/4] net/ionic: Add devlink parameter for RDMA
Date: Tue, 5 May 2026 21:19:33 -0700
Message-ID: <20260506041935.1061-3-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506041935.1061-1-eric.joyner@amd.com>
References: <20260506041935.1061-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bc29a4-e9c1-42d0-f95e-08deab26bb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rr081CKt+QyGiZU0lh/y76bps21FbTEWdERYeY7B9Lg7NcAd0sBuN1+GxhxW4isM9hKVMo5cXmuy7aK4Cl8DT9+JFTsxDCx78erBd2bix2RRpoaJjx3lB7Jtd/iDinSa49IAwOX5MJhtIiTRr8AFmIyTzMK++tvvGN2oI8mcTDHeF09dJYXlNihBG6fxmAcYvr/ff80wJ9D9LpQbvAOUbY8VxgxXaIN8BoOWN9HRnzmndGMV7loyziwFaevr6ZZgNN9lStxEEHY+1+zBIgTgw2YtU/e94P3QBXPXV/Lid10FKrkzoZzPuiUCFTaGcehk4Fv4ycBKrWgslU56jINnRXF0tkeh90hgUF0x7D5KNuskbXXvXlg3rG72JAIxiarcSpxX1cXmBGWyJWZzX9Sz8dozJM/H3I+SuNU3Xq+ChxSp1qRF6715D4unt2WITdUnmVSnsEK1oZEh/bZolJ8x5nxRMXVZU7L/JW5DEJk7c7DEkNq4vTDgKJyG8AS47V8rKTVEBbfkfH0+ESowu2mGRxY2jujkl/Q3/JnbCiGdXEKTMbkUYA4/kW9ptnfoLoFT3+z5Zs1XqTx5CGvZovYjNLtvHsGn8bxEz/foPBGajFdCSq93nftQF6mXt4Z4lq4NL26gsfO3DjFuRuzx53//jM91KLryls/aQKQxFjOtGoJ4tfCDJb9CLjY9WB+p52MVTLYNuAISPUckLO24evlu0W6C6Bl5c29e53WobGqnZbA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YiYKDWHH4OH2t746UJKPZARqDlaahCdzUFa38GLW4PzBTMaXWJNRj5AsLJLRUWOnC5nQDqpqwQKbaRqTHJ7d22lodnrNnNm0qeHrURTG9eYt4AkckcA99ozi+Btgupb3290yQf4SUluz1pb6kmeH6pC3NZ5X8j3dyRbvEfjhGGhpMOKn5pB4uJYWV3t3pCV08j0P68C+cNGeMGa5wakKNOKmDZYcMRtAezZpg48b4stuVs/PmawTGlfBtfJHJgX/hV0ULYiBFsPEvFcmVfd9Abh0kvGwjNqRWfu0ncXg6MxF/Qb4SBjeQ8Dw3tDrB26/yxE9gDUmljtEyDhmrrxnw4xbkVRXM4yASVBPtfMm2dx0O4+kLnKn18rYIDVGqdYETdiZG96RW8ISqevLyLB2r43Q1nRIyP++iYrPLunknyEPOpwztUcqsaRiUpOQ7nM/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:19:57.2232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bc29a4-e9c1-42d0-f95e-08deab26bb53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
X-Rspamd-Queue-Id: B6C3C4D6171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20046-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Abhijit Gangurde <abhijit.gangurde@amd.com>

Provides a devlink parameter to the ionic Ethernet driver to
enable/disable the RDMA feature.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_aux.c   |  3 +-
 .../ethernet/pensando/ionic/ionic_devlink.c   | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index 4f193d0ee87a..689624f19f45 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -23,7 +23,8 @@ int ionic_auxbus_register(struct ionic_lif *lif)
 	struct auxiliary_device *aux_dev;
 	int err, id;
 
-	if (!(le64_to_cpu(lif->ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
+	if (!IS_ENABLED(CONFIG_INFINIBAND_IONIC) ||
+	    !(le64_to_cpu(lif->ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
 		return 0;
 
 	ionic_adev = kzalloc_obj(*ionic_adev);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index 4ec66a6be073..ab4f6a37c7f8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -8,6 +8,7 @@
 #include "ionic_bus.h"
 #include "ionic_lif.h"
 #include "ionic_devlink.h"
+#include "ionic_aux.h"
 
 static int ionic_dl_flash_update(struct devlink *dl,
 				 struct devlink_flash_update_params *params,
@@ -56,6 +57,72 @@ static const struct devlink_ops ionic_dl_ops = {
 	.flash_update	= ionic_dl_flash_update,
 };
 
+static bool is_aux_enabled(struct ionic *ionic)
+{
+	return !!ionic->lif->ionic_adev;
+}
+
+static int ionic_devlink_enable_rdma_get(struct devlink *dl, u32 id,
+					 struct devlink_param_gset_ctx *ctx,
+					 struct netlink_ext_ack *extack)
+{
+	ctx->val.vbool = is_aux_enabled(devlink_priv(dl));
+	return 0;
+}
+
+static int ionic_devlink_enable_rdma_set(struct devlink *dl, u32 id,
+					 struct devlink_param_gset_ctx *ctx,
+					 struct netlink_ext_ack *extack)
+{
+	struct ionic *ionic = devlink_priv(dl);
+	int err = 0;
+
+	if (ctx->val.vbool == is_aux_enabled(ionic))
+		return err;
+
+	if (ctx->val.vbool)
+		err = ionic_auxbus_register(ionic->lif);
+	else
+		ionic_auxbus_unregister(ionic->lif);
+
+	return err;
+}
+
+static int ionic_devlink_enable_rdma_validate(struct devlink *dl, u32 id,
+					      union devlink_param_value val,
+					      struct netlink_ext_ack *extack)
+{
+	struct ionic *ionic = devlink_priv(dl);
+	bool new_state = val.vbool;
+
+	if (new_state &&
+	    !(le64_to_cpu(ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static const struct devlink_param ionic_dl_rdma_params[] = {
+	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			      ionic_devlink_enable_rdma_get, ionic_devlink_enable_rdma_set,
+			      ionic_devlink_enable_rdma_validate),
+};
+
+static int ionic_dl_rdma_params_register(struct devlink *dl)
+{
+	if (!IS_ENABLED(CONFIG_INFINIBAND_IONIC))
+		return 0;
+
+	return devlink_params_register(dl, ionic_dl_rdma_params,
+				       ARRAY_SIZE(ionic_dl_rdma_params));
+}
+
+static void ionic_devlink_rdma_params_unregister(struct devlink *dl)
+{
+	devlink_params_unregister(dl, ionic_dl_rdma_params,
+				  ARRAY_SIZE(ionic_dl_rdma_params));
+}
+
 struct ionic *ionic_devlink_alloc(struct device *dev)
 {
 	struct devlink *dl;
@@ -82,9 +149,17 @@ int ionic_devlink_register(struct ionic *ionic)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	devlink_port_attrs_set(&ionic->dl_port, &attrs);
+
+	err = ionic_dl_rdma_params_register(dl);
+	if (err) {
+		dev_err(ionic->dev, "ionic_dl_rdma_params_register failed: %d\n", err);
+		return err;
+	}
+
 	err = devlink_port_register(dl, &ionic->dl_port, 0);
 	if (err) {
 		dev_err(ionic->dev, "devlink_port_register failed: %d\n", err);
+		ionic_devlink_rdma_params_unregister(dl);
 		return err;
 	}
 
-- 
2.17.1


