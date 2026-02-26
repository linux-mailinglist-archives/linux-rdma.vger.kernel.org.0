Return-Path: <linux-rdma+bounces-17255-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB3EHjvIoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17255-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:24:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F71B05FB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6456E30D9835
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB5478E32;
	Thu, 26 Feb 2026 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTJW9A8e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639584508F9;
	Thu, 26 Feb 2026 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144438; cv=fail; b=no9h+CqqCWVXewbCwethjVAXotEjiC3pMc9pbzV0EwJFOuqvfSLnx1Vxsz5ITRBLtHQWlgHZe4AujjxwxutztlAK8vPaCyes8g+mgvd/Lxg1ognWWIP/KZELEXHgrrw6pKq/+BEnHEi1rQwYlDe+9d3vatQoos2cVg2RLYz5Z+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144438; c=relaxed/simple;
	bh=UTNNVyaLq53yezGWuMSjSODWXZgd16RmgaeyoeeydXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbM5D0Ia6/Clgf33qlP1jtX4dQODobhMq4J0IEKdc7NowjXkn13W/Cez4pMDY0mrGIiLTcpwBg6cTu7pxBiRQzYiSXfCjQw8UjSW3jyQ3zs7C+7irVVApUpsuUmP54gSgTRI2Ng7KTeUc6gnA8qw2Pid+caBI0vsld/hhSgeJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTJW9A8e; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlEFHJZP6NsVJbxgifjpwIydUyvdHAYfyOJr4QF2tXDwQ3q4NtFHWisPoxuOZ01GgpMGBvxtpb99+SOpT8bEOzPWKM86S0lnMiCQW2GYaYSZ7vz8wmfY3Vtzhk8vKtQSUnvSrHRXiSTB+Fc5kyylRb9zRbQQCk0/b3txduORYL0NCGBUHC8ijX5bcyfXJUZcQogrpz8ulTVUq3PndZw8kpwVB7VFiLsYk5u7tfg8fDykbsK36ixVyinqqMINv+9NE05mGz3h+LXateMteZL23Ac4YNuU1YndTZTteQFUYph8IjlCYnSR29ueCrypOppesRYUkJQ1hFFxL/UHdFR89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StekMdt5nMy9sRknEurYeYV+Y+cCt7CTtJzyAE3cKi8=;
 b=uCmCJpZDkElnOZqK1pMAQvpb9BEx4kOuAbUrvlTH17MwL0LJ7H7qz4EY6po4+eFaKY2eSeF3vxmYZFWFf21G3fSI4VQ9QjnFYqRfZNkw+EH5R+fpp27QTr3NSR3P4M95KCtuHQdBPCSu4LW/fD1R997/ho+RjnhVbjeIp0K4uNK0Ff5YRNIgCoxq9IgLbjLn9j3s3iT68ZidiI83FI3OUPIQ7obwnnbWTk1MB8Nk9gPJL9XYPR+O3Nmw7YmoTsSLlBL+/Jc+bU2hvjxc5qVO/NzPVasBfYfSKGTUd/ItekPVvJ3rZDtdFA9B6QzRykR3RXCEf8TBsS/4T9wTULLl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StekMdt5nMy9sRknEurYeYV+Y+cCt7CTtJzyAE3cKi8=;
 b=GTJW9A8eV8CwJpBadmxYkv8rsMMESOf/CANJLoiBmqS1g34K5WMlgqrPSVkqC7gaPd3+rZMXV1qlKXlKzVsH1z7iI+o6zT1ApFbv2zOJBrzzc54g5TvlOoz9xg0xCZsbNDkb0gbOVKCJZHXqbc6n+6YcnmZWeSDjY/fFmzNoJ5+C9+DKSzVsffWTkO/Oq39m02wnx+bREgeOUwCxSXrjlKg+tql6TNbQfZmCtjgoNqgfy693lz4pB3dhUnVAO2uZkp/KNOh1N4vw2oTA1JRRcIb0/gxEzNTEGo0Y/YKmk5BfEykF/bwEuPVvaAJww3ko25+2GACLESisiSpEfeZKIA==
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 22:20:31 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::49) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 22:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 22:20:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:20:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH net-next V3 07/10] net/mlx5: Register SF resource on PF port representor
Date: Fri, 27 Feb 2026 00:19:13 +0200
Message-ID: <20260226221916.1800227-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260226221916.1800227-1-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad633a0-3b93-43f2-2106-08de75854114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	vFHfH4UMFe8HNCMw+Mp8AQ1SnCdl2MfMPpR6LS6FwN0C8wCQygEqQoZBDX7n8CsjV3Mp3Z5twgSiT/eKpoSC2nXzRY94vJh6Jf5JQszEwMh7WCQ4BKGrr8Dgrs7eaBr9sqo+Z7+Md9AHdJpXh6uXJLGYkQbKPyDSnGGz76/pJmyNEH9kxSaWLiZDbXRrIP2BDW4Asp90dgVke3oPyjNGkah0X/bIX6PIIec1Sj60eI0e6UeW/ZLJkEEKpXIbffOfOou+tb+b+32REZZGRvX6SnDyvq5hE8GH33qKrRy+9p6HSN4SIzV0TLVFMwu0hFKbU0354zIJvocwFpzbTorO2zRSHjlwJ8wYkIrnHvMK1S3F7x6X9DDbkZZWYK2J+0qLoCm0fy0L/t4cA5n+rnjHUUdX33neNfo/C0uZBRq48m43utmdjDeOcVSxerOBVWqpHHPo+fGy0hyaZh5dZGNT5i/HIBy2luVtIbDL6/FZtUDMMjnmnDVwHvB3LiPtf+jTRZ0/CW/QZ5g1CMlU10iNPl563zwW+J33EQQe5+ifv/8kw3emxFsSOalf0KU565EXJ3y+Xf/Eegxy2ME9H/w7lOsLFV6HHkQW8T83NyVzwSDkWimINBb6wFrbPuKZF2PlHaLIZccYy/i1srjhnvrZT1O9yciUN3WgSnbLWQBOOK7ymadFe9cPjxwj25q9QJeSfWP8S/eW1jFYH2/8+rYHfi5IKRBkPDN9J5bmjhGD5ZCShAhObmS1Lq/fsLnWhN+q3jvped8xD6JNLuup1NxOdgIJDKidYu5CkdjN6157DTtwiYrxcCKtAJS0QXWCLq2u85zg2GjA21vRBMYCDGW/tQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9NozmT/l/IW7jFtCNLnhulhaONIvGYlukrMUH4qQSufVEaqJl4EEJpK4c+Uz0wo1/vkMRi/RmGXUVbLHUrJECyLwxPAIvLZ5z/MjYxL6IFfLuU/131rogGR2nIeeU+wwf8yLYPsWaPcbhrMHu7z7hY1W8z6+YxlV8sNQmHT6PY6Ryi2cGlDYjR9JfGaQiCYWjdUcT2Y1aMwZt29wVB6U4FPkFOLsQO9UOYdfWDCO1fQgDcyTb8926gR75XWJfX7/TLkH3bOQXh3imIhPeQmwXxv+VpQUTkkn6AsTcbx8v0xA5Pm29x2w9naSK0tWifYbWwKfqOWNwiGR5wwznvGCrgu4BgMBOKljllpQ7IoUke43VsN9CFxLgbhMvw2ajlHaHKMogNXJZ75OWgi3Gxsfa/Eu9FB3uhEnLmTruYCRjKYp6v9v5xP8NZxnd3sNCebk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:31.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad633a0-3b93-43f2-2106-08de75854114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17255-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E99F71B05FB
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

The device-level "resource show" displays max_local_SFs and
max_external_SFs without indicating which port each resource belongs
to. Users cannot determine the controller number and pfnum associated
with each SF pool.

Register max_SFs resource on the Host PF representor port to expose
per-port SF limits. Users can correlate the port resource with the
controller number and pfnum shown in 'devlink port show'.

Future patches will introduce an ECPF that manages multiple PFs,
where each PF has its own SF pool.

Example usage:

  $ devlink port resource show
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry
  pci/0000:03:00.1/262144:
    name max_SFs size 20 unit entry

  $ devlink port resource show pci/0000:03:00.0/196608
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
index cd60bc500ec5..9601eaace168 100644
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


