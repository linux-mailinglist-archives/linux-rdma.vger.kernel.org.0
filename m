Return-Path: <linux-rdma+bounces-13642-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81FB9ECC8
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375FB4E03A0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4702F6175;
	Thu, 25 Sep 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3dNbmOj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B922EDD4C;
	Thu, 25 Sep 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758797185; cv=fail; b=WgYH1Z65tMaRVeWA1B8Jlnq6Wy8hisDbKSohoJYubC0YPTLBRh+9R99X/ebChr+j5EhHIuQ17DLYTUCOOK3FYeZEB4p5Gz3yLU0BgIYf/5zjedQ2fCX8lQqVbmw2+9IETwp2MIujJZEdfiHRAaBTRlziWdkAfsPyIYY20hLWvao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758797185; c=relaxed/simple;
	bh=RKNpbtWgisuaIbhKaRosIe5M1vWKNd0RW99AMJYaLG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOyr6e26u5AsdmD48wcMdFb2XNfzF7/mkKiBvXLy+MPaAko/0kVXAcomLywJNLGWeSsaZYqcyZaaPRlPsInrnft5XMkRzgt+L4CBrWxJvzMFG/fOMAgIicIU84Z41+o+73yEAgBV5nvjd8vMh89+mfX6R940WVbHf2NwYhWz3bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3dNbmOj; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2FXi01F9lhvqkC91NL8m/2r5ls8wuGllkd/kVKTSzA1OSp9qCkfSX+KaoARoLaVbkrZeeqehotdgbdLpPRUVRwhSVQSvXZhN/COcTPQmiJjcKQe/ZiprKt00q5nmIDr1SjRAr1ebRpQ1DxpWLZVqjHF7WIng2F0mIkMKOd7iQru5apHdUTFqjdJ2BjC/kfRIuyO/3vUavz3H9Nb7K64CGp3sj+WnOVA3igT+1jIm2T4yGoICJ8fUSFaM3d8gK84AH8WbYFN1CLEZhi7g57FutHlj3Z52O4Ftp96Ky+L9eL6QurY2LCjQqQfhzj5vElwSlYC3JX5MOIxNtc19J02Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nQDlgiDAytdd+lSxsQjQzcQyOev/zMJtjKwYo6JUUs=;
 b=wJdmsYUxh2WvdGzvwfdg8+C7Uh1soSc/li5nPTLh18FD76gc0xfLTJ5ENRR2KDc8jjZjjBEDrsBTsVw18QpTcROoFby3jQTCuJHM+bxonLj1BUu6CM6usIJbs6W/DaOvHT413U8hVuV+2Ty4V6f5a45M3Kd+rpXUCvlEncuEhDaRCDWnOTTuRbxEtvR49sapnDlq3mpqcGSOZH0/sxMSQagRYPEi3y5w3tbSh5547PBpKNyKLgDFUl6X8cUBJz8jwwr2fORoM7kvUbPHbpr3K7BNuMXL69Wz3/cwh/3N5+anjZJwSvmE2pv8rHoul9XahaBCqe63FwGPKDBoX/gtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nQDlgiDAytdd+lSxsQjQzcQyOev/zMJtjKwYo6JUUs=;
 b=F3dNbmOj2LRWDT5PeBK6BmZ0XVEOSx3QnBnXRAMt6Ni+uSpVTB1RdcnqoDV7h0MqKMBIyiEEm0UoRqcQAbFGijHPjA24+ZA8Yr3bIEMPuIQunN6Gfhfz9+dQBdWNEfFqG2IKaGyHItgqZkqJExxyNjAVU8npkW65k+UWdSBHXdZEKmFdkfptdT+zWQj4h6HaFXSQUUEF0mncdCms1JkpMjNZaAFG33utCjTzKvnWZVaGUq2yq43aeY45EJ7OgIvjpkT7WcMqFyQ5AGMhONUsSlWE90HndAN2FOpF3vRRKKM9yDYINQiMDfbbWgscYnfs3wGCw2PykvyQePLw/kfepA==
Received: from CY5PR15CA0231.namprd15.prod.outlook.com (2603:10b6:930:88::16)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 10:46:20 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::e9) by CY5PR15CA0231.outlook.office365.com
 (2603:10b6:930:88::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 10:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 10:46:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 03:46:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 03:46:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 25
 Sep 2025 03:45:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>
Subject: [PATCH net-next] net/mlx5: Expose uar access and odp page fault counters
Date: Thu, 25 Sep 2025 13:45:30 +0300
Message-ID: <1758797130-829564-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c244a9f-9767-4e9e-c0d1-08ddfc20c329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eeo8KwECGrym9oJffGi3i1lMqbrkQIHhnYGsYG7UpYf2zUSq44/u++90yuF/?=
 =?us-ascii?Q?cIvbCvzHmsBG5n4ic8RBTuBDN6GMAQSfzPbUHPxS2RcSBNYo6tro0+d0y4ON?=
 =?us-ascii?Q?WeQHfWWO6pAQ/dWj6kC8X2Dtc/TuVT89bqvazy/DG0CdcZPC9lMRDaUmVcvo?=
 =?us-ascii?Q?TVoXq0w1KskfYEfGUYZbZMKAfQwR//sIQ51D+hP2FwpWlL+OAKAtpuvh8d6L?=
 =?us-ascii?Q?69vusZ6PdeFKbLbBMe8431Wah63FuYbV56Jm+QHB62IPOXdjnGBYSAf8/w6R?=
 =?us-ascii?Q?v+B/4FYT8KKY98s4i4KxF6Y1DjgiaYvVi3AnSnXeGyU0JVI6nqP+SPZvQLgE?=
 =?us-ascii?Q?dHNpE3D4U9ElvBeWAZVomSkU46nlUTuSIOqHiM+Vc803Ptskckxyc63yGOqH?=
 =?us-ascii?Q?FKPRSjvtqVAO5WabPRzukYrpAIxsEGAeu7138iybgwF/G0mGdXYqRWe7gaRG?=
 =?us-ascii?Q?QbEy9NzgrdqDw3V2tRbAuy2wSzAiZzEm7mKrFbklqXxsDrJKktxaD51yQ7xc?=
 =?us-ascii?Q?KgtUDLsbx6SwWNJd9LxjBb8sEFf0u7ErjkRMi6dIeK6a8fb3WhPi+Nrjp+Ce?=
 =?us-ascii?Q?U4VSwCqniQ4z9FLhziGX2mib3p8DihTfNQk52iyAgcZyeaV/NkBcDBj4yw5q?=
 =?us-ascii?Q?xpA8tWebmV44IIvTPDnTTSwHccDIVBbnrpgVxvBrNDAAdI4wYzaf8xoxDJqt?=
 =?us-ascii?Q?NeBhcOkpzyG7w0CtSHXiQsl4zrocqO8AlbV/cprlotNNFkITyKeLWHrnnCYp?=
 =?us-ascii?Q?k+pT7/9qVcCDG2YTXnddK8K+ubz3eVoVDTNC2eNbZ6FarXZYQU8p5/pnc4bo?=
 =?us-ascii?Q?wYuxKc/bmw92gEytJh9jaO4wYkfdSCvgIoGxbwRdd56dvNWPFTzABRbKfVrQ?=
 =?us-ascii?Q?KpoRx93VYl9D/4mDxbclUqc+eEaHX8x7Ro+NYLuqFyJ7N0TiTJZpW+IwEvaS?=
 =?us-ascii?Q?lhXDB18oxbG/Lvb/J6cTCx8igWaQ4Fgs0JJaOMgLR+St9Swoeg1wp4xTNygy?=
 =?us-ascii?Q?5WzZ8qrKutR3/2Ma4fRpKBlGSM+gisEbu1MQ1oXEelc2o/Kk3hR1S1Ii/t1U?=
 =?us-ascii?Q?3onnXabZTj1SIjejwfQD37ZS0SLEQ9ZS3GjXN28vFh0NlAUpTm76eDxdViws?=
 =?us-ascii?Q?sNspsm3xSRJvXV8IoSY5hHemEVWTAdYEEXSzWiVvuugUHrL6jKPMwDpXd946?=
 =?us-ascii?Q?4dqQnTxGxK8S+iCUv23NpeTOnejHrTeP/PViw0ZBiPNTqcEN7DD/dWpQGYD8?=
 =?us-ascii?Q?HH+PXJq6gxuyfsA5UKfQO+oSN9LqMySuQrUCh1pLkDmAYKiGbO4Ex4Xxjybu?=
 =?us-ascii?Q?D+0N6IapggEUhbM7n65OO3oN+kt5uH6tEjgrJ/J6f4qNjd5uWnVwnXr3Vje+?=
 =?us-ascii?Q?TBNUFne1OcKNVLfyqpdvj+R0vxsOw3svyizGzcC8MtzaQ3yqfMIuoNfjqfMP?=
 =?us-ascii?Q?Hbx48Dmv9jfXhHwqMnw1m4BicRkv2kfUg5uSZ00CVRTWLIDnI/Ih95NtMEvI?=
 =?us-ascii?Q?/WQP1x3O7kTOHpmjhY4iKcrK9KVgin864nud?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 10:46:19.8639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c244a9f-9767-4e9e-c0d1-08ddfc20c329
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778

From: Akiva Goldberger <agoldberger@nvidia.com>

Add three counters to vnic health reporter:
bar_uar_access, odp_local_triggered_page_fault, and
odp_remote_triggered_page_fault.

- bar_uar_access
    number of WRITE or READ access operations to the UAR on the PCIe
    BAR.
- odp_local_triggered_page_fault
    number of locally-triggered page-faults due to ODP.
- odp_remote_triggered_page_fault
    number of remotly-triggered page-faults due to ODP.

Example access:
    $ devlink health diagnose pci/0000:08:00.0 reporter vnic
	vNIC env counters:
	total_error_queues: 0 send_queue_priority_update_flow: 0
	comp_eq_overrun: 0 async_eq_overrun: 0 cq_overrun: 0
	invalid_command: 0 quota_exceeded_command: 0
	nic_receive_steering_discard: 0 icm_consumption: 1032
	bar_uar_access: 1279 odp_local_triggered_page_fault: 20
	odp_remote_triggered_page_fault: 34

Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst                | 6 ++++++
 .../net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 41c9b716699e..0e5f9c76e514 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -385,6 +385,12 @@ Description of the vnic counters:
         amount of Interconnect Host Memory (ICM) consumed by the vnic in
         granularity of 4KB. ICM is host memory allocated by SW upon HCA request
         and is used for storing data structures that control HCA operation.
+- bar_uar_access
+        number of WRITE or READ access operations to the UAR on the PCIe BAR.
+- odp_local_triggered_page_fault
+        number of locally-triggered page-faults due to ODP.
+- odp_remote_triggered_page_fault
+        number of remotly-triggered page-faults due to ODP.
 
 User commands examples:
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index 73f5b62b8c7f..172344734b8c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -107,6 +107,15 @@ void mlx5_reporter_vnic_diagnose_counters(struct mlx5_core_dev *dev,
 	}
 	if (MLX5_CAP_GEN(dev, nic_cap_reg))
 		mlx5_reporter_vnic_diagnose_counter_icm(dev, fmsg, vport_num, other_vport);
+	if (MLX5_CAP_GEN(dev, vnic_env_cnt_bar_uar_access))
+		devlink_fmsg_u32_pair_put(fmsg, "bar_uar_access",
+					  VNIC_ENV_GET(&vnic, bar_uar_access));
+	if (MLX5_CAP_GEN(dev, vnic_env_cnt_odp_page_fault)) {
+		devlink_fmsg_u32_pair_put(fmsg, "odp_local_triggered_page_fault",
+					  VNIC_ENV_GET(&vnic, odp_local_triggered_page_fault));
+		devlink_fmsg_u32_pair_put(fmsg, "odp_remote_triggered_page_fault",
+					  VNIC_ENV_GET(&vnic, odp_remote_triggered_page_fault));
+	}
 
 	devlink_fmsg_obj_nest_end(fmsg);
 	devlink_fmsg_pair_nest_end(fmsg);

base-commit: a1f1f2422e098485b09e55a492de05cf97f9954d
-- 
2.31.1


