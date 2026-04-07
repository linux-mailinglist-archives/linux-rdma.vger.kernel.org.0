Return-Path: <linux-rdma+bounces-19105-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKR8GRdf1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19105-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:46:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 098653B3F3A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3111330B1E32
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22023783C3;
	Tue,  7 Apr 2026 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmQbCmWe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C813783B4;
	Tue,  7 Apr 2026 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590965; cv=fail; b=gEBYlvps/3tp9bpX3ZmnxMx5RARfJWSy510HQ1sQXuRdSoHN09F62U+e3xaNmU0MlV19NlD7O4Dz10g/6yfCiTEe6rsHVdLo5Xy3KnwPPWInV3os6EEBr12KnFCnKt8Rafrck6KwyeAnxRjEu5TkLIuF1Cj1ikCbvRChVX6/QcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590965; c=relaxed/simple;
	bh=N+o4L9iMGp3b8ioiRRoL5M0PpKBHw+TELUz8AUOVeIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7si2CM3EHbgNKOJ/p91Osc8nmEtm9AyxjU6u/3eVMGfIYoxmTeMLnywTjp0+UUCEdxUDOoNkV3zPcPRKEE2FSwnCPSF190z3BCMJVWNEkTZSOanUzESpjQyIi27sdZfz6dO8RnHSP57r44KfH2Mfme65RDKznXj1WX3B1gdGsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmQbCmWe; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLSjDLVvjRgFAHTL/bgt6eCXXxzeHW4/gK9UVETkG+T+hmooeki3dESwTYgbFtgWyo4/XWjcXzuLcn3tUk9f/goTwWUEcWwalg/BBc9BcSgXDFIcQjmee3cng5eUsMe3g0QsbGYTX6JfueJwXB5G/sHh5c3AnrHwvPSn2LFVk2I6+K0kQE1FroyIwT0Uul2JYuuYgXvw0WW5vfopEcAWcBVfHrd7zIkAlJhkXkF8EzpQvWFaRVxdlZySaIjM+dxYEjDHihn7KZ4GdedqnQfRjd7DUDcPD0jdbmYHEdCdfcKd3JxnjdA+fXdlLpHZOPhubjZkyRy1uJg7DGoChvdceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxyqQA0ObwR48EcEw5sW1/9ZlBoyRj+hAe2CzzlRx3E=;
 b=ADDpw6YoAImPaLwAmTRWMG6P9cilgRrMJYpszlidC02RVqjkQ6dP1wVkNS36Y/STCvpyv2dn6MWSRHJFGPBP30Xxd/zXrTsnk3RJwFNy8bDgWangaa/MxauCQeRasRN5yXrLK6xvWVQ/EkhgdyzEPJwqqgwJEKh40Znt7KgWovWvWRrsIVIDcagJhBkMNmCFAFQSpFCMNw4yewetes6P1R+mWvUa5q+NaTmGDgpwX4BBtGCpZuoBdwlNODys9GUzUCZXCHMpizw0OYQ/twHCLuwrsq7aDQt7I9+YKdavZ1WHQjPFZu0UXcfNSvwhX+0WH4QerfqLfd3x95pTxsrLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxyqQA0ObwR48EcEw5sW1/9ZlBoyRj+hAe2CzzlRx3E=;
 b=rmQbCmWexiE9q/XGo2BOttFKOkS9LmY3k9Tty0OLKNyBsDMUJakalA+I48vS02BUtUDd8CkHuT+JGTh0n8O2CNUVwytM1GSKiwxSeCBUCwSKzl914qcNS8iiljs7ONweToC0cZgLaqRT45ZveQDKck2Owqll+0avfgXh4FNOmYknWpWQzLMtOmoMPAxF7XaSNDnJtFFBumaNWlNvhw0FEKH0OwAFIveOIixV5f9/BPfzDhVgNO+OkhvFgQmA66A3z8dyaY9Rs3+xWgUvf82cHcFOymaa5zvA7VSX+rhRH+/PQxkn6w79K1api+a6LObzqpMJsq6LxJEbSMx6DfELsQ==
Received: from MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 19:42:35 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::35) by MN2PR03CA0025.outlook.office365.com
 (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:42:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V5 03/12] net/mlx5: Register SF resource on PF port representor
Date: Tue, 7 Apr 2026 22:40:58 +0300
Message-ID: <20260407194107.148063-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ff7ee3-153c-4ef2-7e74-08de94ddd0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|7416014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WBXXuZv9qYc6V5mZfIwAUeyKParevzSO1kdjf9BPx9n/WbQ6r1PDOZWrjq+2zFmY7qfoxnpEgC0wbq8xYV9rrXwhYVxldP8fTrtW39VDarRXfySEFRA72ZDc4jqBGXHFFOG2XHmt9MfZREMFAYEYLNlZQWIneVbvsSsnQWhe37y8aaYwCHabFMHSRyfEVrrmfAg1IXk4rCTxBY/bUjteFLsqtU0XsgmVn/bVsewezAIANhvPzV68YyvZOF06ECF4z5/MicJDxx3tv1IqgnMytE8fQTeMcOwbTC0h8qLkLFyuOtQEGacG57xUUviFTMldUYegpTnvgrFULDKDBrCSnklsb6dojsUXN7xJuSx9+YC89h/V+jtEr3QB4WaTVK4+7klTybAmUt/8bbvOnnlsCE0HZDDlR2A7aepNWtOlq050J/Dm4e44LLHVjCgHXcXyBrfl517k+ZLRGjJulBo5wHMVGxpTXGJExSjfspuhhGkzq07smPmuNJJxVpCpwUmKTveJVtn1z/+4aEd6jr1AEt9oXvE7qKX3PqPCwAaPByPTrw+va0Uqgz2CYf4+ydgb2+2BvQwrgjFrCM3zebWm1eH5Ab0d+SgWOvR7uNphCtFy9DSBWCufqbD7xcnJFAgX71+YX0VkqxvGAbgaNU5xwsz5bv3poggzkCKjCN+05RF0aKNMJ2bGS6TW5lyrE+sS4+fH4a735/z9McEFW3dhTSwWQRKpYDmmeSmq2RKdncjv8bKQ/fxgMCr1/wfMN46rTuUNrTCz/D76cz2sQPFYzw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(7416014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ABegbgT8I21wedTHf6DGrt5JWQqUix11kVNpgWhGoCf1CoUem1udhsUzbmjdj3icIspmPaYPTzeR0zGSr2LRqQMsYvzn6MH6O4/XfGoLQgdrkeLuDiOJDOLwJtXz7OX8Iw6Zk3SZ19osKMtU85hLFbNbSdEzr5YLNFga7B2JtRA+XchOzoiFeY0NebreKXLR56X9U6kOMqem9thk2p+eVrXdLdLf9B5UKC81SI9ciwwu1zqYX6i0Pari1quGjLpXFbm/rI70yW13f+AKwmRBvb8lc9ouPTUrjUddg5MZ3jjGzETA2jpGIpZUu0FtsfJp9qUZTBz98MJJ5BmOwpccyoPIlUFLAtRe2WytxScCYMxwnWuIs/3683++30sgJUocTa8QRw7x8NEWSNkiACNAdDfh9T7PQYQbz/V65rFXf1Iorb4a3jS4uKnS2n+JMtoS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:42:34.5899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff7ee3-153c-4ef2-7e74-08de94ddd0f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19105-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 098653B3F3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

The device-level "resource show" displays max_local_SFs and
max_external_SFs without indicating which port each resource belongs
to. Users cannot determine the controller number and pfnum associated
with each SF pool.

Register max_SFs resource on the host PF representor port to expose
per-port SF limits. Users can correlate the port resource with the
controller number and pfnum shown in 'devlink port show'.

Future patches will introduce an ECPF that manages multiple PFs,
where each PF has its own SF pool.

Example usage:

  $ devlink resource show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry

  $ devlink port show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608: type eth netdev pf0hpf flavour pcipf
    controller 1 pfnum 0 external true splittable false
    function:
      hw_addr b8:3f:d2:e1:8f:dc roce enable max_io_eqs 120

We can create up to 20 SFs over devlink port pci/0000:03:00.0/196608,
with pfnum 0 and controller 1.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.h |  4 ++
 .../mellanox/mlx5/core/esw/devlink_port.c     | 37 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index 43b9bf8829cf..4fbb3926a3e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -14,6 +14,10 @@ enum mlx5_devlink_resource_id {
 	MLX5_ID_RES_MAX = __MLX5_ID_RES_MAX - 1,
 };
 
+enum mlx5_devlink_port_resource_id {
+	MLX5_DL_PORT_RES_MAX_SFS = 1,
+};
+
 enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	MLX5_DEVLINK_PARAM_ID_FLOW_STEERING_MODE,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 8bffba85f21f..e1d11326af1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/driver.h>
 #include "eswitch.h"
+#include "devlink.h"
 
 static void
 mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_id *ppid)
@@ -158,6 +159,32 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
 	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
 };
 
+static int mlx5_esw_devlink_port_res_register(struct mlx5_eswitch *esw,
+					      struct devlink_port *dl_port)
+{
+	struct devlink_resource_size_params size_params;
+	struct mlx5_core_dev *dev = esw->dev;
+	u16 max_sfs, sf_base_id;
+	int err;
+
+	err = mlx5_esw_sf_max_hpf_functions(dev, &max_sfs, &sf_base_id);
+	if (err)
+		return err;
+
+	devlink_resource_size_params_init(&size_params, max_sfs, max_sfs, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+
+	return devl_port_resource_register(dl_port, "max_SFs", max_sfs,
+					   MLX5_DL_PORT_RES_MAX_SFS,
+					   DEVLINK_RESOURCE_ID_PARENT_TOP,
+					   &size_params);
+}
+
+static void mlx5_esw_devlink_port_res_unregister(struct devlink_port *dl_port)
+{
+	devl_port_resources_unregister(dl_port);
+}
+
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	struct mlx5_core_dev *dev = esw->dev;
@@ -189,6 +216,15 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
 	if (err)
 		goto rate_err;
 
+	if (vport_num == MLX5_VPORT_PF) {
+		err = mlx5_esw_devlink_port_res_register(esw,
+							 &dl_port->dl_port);
+		if (err)
+			mlx5_core_dbg(dev,
+				      "Failed to register port resources: %d\n",
+				       err);
+	}
+
 	return 0;
 
 rate_err:
@@ -203,6 +239,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 	if (!vport->dl_port)
 		return;
 	dl_port = vport->dl_port;
+	mlx5_esw_devlink_port_res_unregister(&dl_port->dl_port);
 
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
-- 
2.44.0


