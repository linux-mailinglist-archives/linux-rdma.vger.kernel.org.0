Return-Path: <linux-rdma+bounces-15079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8BCCCAB0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 906F330562E9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6C3624BB;
	Thu, 18 Dec 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJbs09Zq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF4364047;
	Thu, 18 Dec 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073530; cv=fail; b=pUFNPJSXrDQzVqWK/W28BbaiP5XM8UvqnYMvbIfR4E4i3DNMBIfyJG2Bq7O6b+FxBWPFl8dZsevHl6KeFyQEmyx625QHtN+L/rOfpo0tZmsB/qUgsAwfWVmNtEb/Lp8dY9wIjq6AauK8JNyRtbqCRzYBtWGoDXV98EJAYOsr9DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073530; c=relaxed/simple;
	bh=fbDu0S7POjJUczA8UcWd/xlHU6L/yJoQIWWA9eqsWPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUZG5ikLn0GXtaV5loWAMxlPV51rg75K8IrYwNq9kiO3PsxU81CVQKHKI1xkAK8RacHEQ59/UXG9Iv/qy4zn8zpVXseFyhZ42k4gioMzP83IONkw+dnjRXx1p7dKhpJOM+EBYBq1BrSspgOFgT2fho9dwF/fhwmK7a/0MatqRII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJbs09Zq; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5JdO38QEGPIPIMxRkEDmxh5ueqIswzlqfRi+sZ2nhnM42TybysWSxnZVR6OJ8jBXriM0xnugwAcoCaZyxtuwdwbf1vbM2IvEx9mZ4u8HHyfr8m1Ao9HDspqSy0IHzdjvYaEe7fKFGwK6Ss0sqUIfvG2Z9cFjISSi3eETg+Or/QocbTDMFdVvf7D1pgSZM83IuXP5K8ea+Rp4QARPc6/HiVGUa859uzT04IrAzFVim6oRNVJxZUGEI0xo7tv2nuxZ/w/lWX/iSHI051li5F5km8L8LhZW+yDSBZdU/gQY7ZPNh6J2/yFk4gU6tms5eZG9cEBPz+HCqMEzbM85qJ5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djO17+yz9cUenm3SB0FldHBhA5BeCBL7P20JxHuIQDQ=;
 b=k4hgBS8FpUShemV8PjVQsg7b7TL6FfSS9v80wnpELtJNi5QgjRyWysOcxRFcVP9gxPy14sIhA+GtEO1+6g5+zlf2egTitpxNGJ23ZxLknl7DivACax66N+T0rFapaln6RAqoWzK4ZGrkqa4LirbPD9ja5CrFwyOK6D0q2ssYqR0/KPkQ3B3b2c/ihQnAbCrzMzYCJHCRE7sjEyiPhTZatP4s3vv20mDk4Ey4P9vhk3OzDurX+3kksnd+WBMc6HPzPwG0R8d19EGllJGtDMMtKKuEhsqFhiKLRfH3VPMuG6yQ2Et/YS4zaL+kK59wvaRMp+fg0mbnfLHNTHTMabhhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djO17+yz9cUenm3SB0FldHBhA5BeCBL7P20JxHuIQDQ=;
 b=SJbs09ZqdRp7xEQroqHMKQr9jCSHbg25pnOeIk9QFI9zqj0GA9DKNsKdST7BzGtD8k9tU2TewikPU/adjp/0jptJ2I14UoYakQF147s+JxWeHdDaWwvxPXSyFlfkNtNfSwhVjyibEqx7wJhfeAkueE2Aq/pwTbhGNhWy3e7rTX5wtZA+Dj5KrhetKni7PZmQ+ItwLXebFOw1Q7KkcLJdynPeIDG0C1rxxWWvpO1bH1DFfePBiUo/FUvCHP35efJ4rV0lkcvpetfPv2qGMH38Hgn4YnZgEkH9vv4FCxoGHmZYbdAQWOxtSNzZewtkeKxDRBc6MyYhdSp2P0FidVikqw==
Received: from PH8P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::11)
 by IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:58:45 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::71) by PH8P223CA0023.outlook.office365.com
 (2603:10b6:510:2db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:58:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:31 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 07:58:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 07:58:27 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 05/10] IB/core: Add async event on device speed change
Date: Thu, 18 Dec 2025 17:58:26 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-5-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=1340; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=vRYdnneA8bd5HUCiwpeL0kp5mDnnbvhnpCSpmUChFUY=; b=YbqUaydBuAKajfjMFLfevCuTLfQ1HI9d/yERmNTsAKuNRKjxXs2xJ1gmbBNp8irLO4d+o23yG +jo+z6fOR76BxL3W9bRL+nvztqRsWpf+Ti3e+zOcQ/taLEIitbRt2rl
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b299925-beaf-46d0-d6c3-08de3e4e5297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnpFTEZXT1hiY1B2QnRYRmpuOGFXZXhHYUxyK01GcURscVJ3UmhuejBXRmdl?=
 =?utf-8?B?SEJQVFd2US9LVE1aNzQ3SHdQYzQ2R0M3RVNCV1VUTGM0L1ZnQTVZMUdHaERm?=
 =?utf-8?B?VFFBb1JoRk5wNXRmbUxOaGRscXhMTGRCemRpUExDQU9MSEh6T2dVZlU2OTBq?=
 =?utf-8?B?bTVmQ09namhxYmhQSktkcVU0TnozMElEZkFOS1BLcE1VYmhKRE14K3VIOWR3?=
 =?utf-8?B?MzVCS2E3TzJadDUyVEdVWi9YQzczazQvbk1kNVpVcmdZUHpuQTBkdnd4blhw?=
 =?utf-8?B?VkRSVDFZS3BxM3UrRWp4Wk9nSkRkSmpmUm56QkZIMHdFampTcHl1dVZKa2hW?=
 =?utf-8?B?VE0vNi82cDVuUDJiaS9Ea09jMDJFaHpjYUlLQWJMa0dNMDgxWGlxd3JBSnN2?=
 =?utf-8?B?UGlsMTdhVjBhZkN2RUc4S3BBdmcrWHNIcERlTVBsWEx1SXFnU2IweVZ0elEz?=
 =?utf-8?B?eWNPUjdsSm92NEU1VHNnNzduSGJiMisyL0JEVm9BRzhzNmk1MWZya2V0cllF?=
 =?utf-8?B?RTA2UzhwcVVXeFpZQnRBVS9iOWc3R0dEamNKbmZHb3lNR2J6TjhIRVB1aGZm?=
 =?utf-8?B?OVU1bjk3cnJQWXJkaXE0SkN3a3FmWG1CVnFqdHZ4TFNwRHZwazI4ZDUrT1JU?=
 =?utf-8?B?aXlGTUIrYjU2SHZsb3R3eGNNTmZaUTVmajdPeEJrY2cyQ1dVazdWVW5jTmFk?=
 =?utf-8?B?c3F5Nkd3cm1iNkpxZUpYWXFnZEdIaThMUmxaNkNqSCtJWUVVeU9Lc1VKOVVw?=
 =?utf-8?B?ci8xNGdFTWlQNmVPQStUMWRxY29PWk9EcXJzYVU4WGJPYUZuMWJFWXNDTFJ4?=
 =?utf-8?B?aWxGSWIrM3VGa1pOV1J0OGJsVElXZDJkYVRuWlBHYVl0dTJyRlVqcWZrVnps?=
 =?utf-8?B?b0tja0pNeVNZbUtkMUdPVG9iSVRQWldoUHdQT3NhWWNBQXoxU1RyZFgxcC8z?=
 =?utf-8?B?YVJ3Tk5yNS81Wm5HNXNHSGZVNVFYUFVqVlhhcE9DZjN3SDNvWVRkTm9VQ3FC?=
 =?utf-8?B?cDRqcVBwcTF4Z3BGRzk1RHcySEx5dkJOeFo3TUdveFZOdUY1NUJJM0svTWpI?=
 =?utf-8?B?Rm9xUEZFTmw4ZFJzQzhGdmpndmZXUVlSK1BoUGtYVVk4enFOcDNoWlhhQ21x?=
 =?utf-8?B?aVdDcEZ0WjZ3QXBSUGI1L3NWZUhvckc0eXBKdU9XNVVVZWlQZHhIMENFNE1Q?=
 =?utf-8?B?a1RVRC91b0V0Z2JBbHFlMUVydG5ZYm5zNjFnKzhMcDE1TWs1Z0Q4aWVLNEVX?=
 =?utf-8?B?M1V6OFRHSm9aVWZCaXhSdm1ZSll0citFQUZSN2tXTDNaeU1pK0dRWEZzc2ov?=
 =?utf-8?B?V1llb2g0eTYzWEhmK21SaVJGNVVHWXpmV083bFJuTThXbHRpdWJXRFFDaXc0?=
 =?utf-8?B?WlJyOEErR2NvWUZoR3RSMWV6M0REWDFyL3dZZlVmaVV2cnhhaitPaUJkRi9T?=
 =?utf-8?B?UXE4NWl6MExna3Z1cTZrM1doWXRJd2pXRDZFUVo4M0IyRG5odTdveWwrRFVD?=
 =?utf-8?B?ei9aRGZVUEs1S2xBQWszdVdqZ1lkMkcxcmlPNUNMSFNLeXR0K3Rud0hPNkp6?=
 =?utf-8?B?UTNTUkNCbnp0VVRYaUJYU3VQMFgya3ZrWC9VK0xLczU5Y01DaWQ4NVY0Nm1G?=
 =?utf-8?B?cW5TM2NKODZ1azRUaWF6RDR5MHFHQUJNaVBsVG40SUU3OC93TXVqaHd0ZGVQ?=
 =?utf-8?B?TXIwSU9FdU05NFdEVjV4TXIrVmhPVlFXMnpOWDREa1UvUjhoQ2hVYTJnaEo0?=
 =?utf-8?B?ZDBidjlHKy90U20wcGdaaW9xendReVBPVERwcit0bmhrc0RrWWtQWERFTVRw?=
 =?utf-8?B?UWRwenFaUjRNb09SOU5xbFZxb1d3UFpNMzdOY2ZDREUxOWh2ZHY0dUNkbTFs?=
 =?utf-8?B?bXpTZEVjVEhZUysxczRnMzlBNEJUcmFsUnBrcGNWY0NYQ3llNi9Ha0NUODlK?=
 =?utf-8?B?U21Ed1EzOXRVa2VzR20rQjZ0TVNyN05wT2F2ZHdYM2hUZGtzaFdDOHV4RHFP?=
 =?utf-8?B?R2dkZnRLbGNtV1cwK21FcTdsQUpzOFM3bU5sSHhHV29PNDFhMWpnOVdPOUtk?=
 =?utf-8?B?WUR5cTJHRi9zS2xjRzl3Qk1hcnZBVWFyM1psZ29QZkl1Nm5FeldpZkYraU9G?=
 =?utf-8?Q?CR+yoiO0gU7H6cCEHSBv0uqqt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:58:44.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b299925-beaf-46d0-d6c3-08de3e4e5297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740

From: Or Har-Toov <ohartoov@nvidia.com>

Add IB_EVENT_DEVICE_SPEED_CHANGE for notifying user applications on
device's ports speed changes.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 1 +
 include/rdma/ib_verbs.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 11b1a194de44..f495a2182c84 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -78,6 +78,7 @@ static const char * const ib_events[] = {
 	[IB_EVENT_QP_LAST_WQE_REACHED]	= "last WQE reached",
 	[IB_EVENT_CLIENT_REREGISTER]	= "client reregister",
 	[IB_EVENT_GID_CHANGE]		= "GID changed",
+	[IB_EVENT_DEVICE_SPEED_CHANGE]  = "device speed change"
 };
 
 const char *__attribute_const__ ib_event_msg(enum ib_event_type event)
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6aad66bc5dd7..95f1e557cbb8 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -764,6 +764,7 @@ enum ib_event_type {
 	IB_EVENT_CLIENT_REREGISTER,
 	IB_EVENT_GID_CHANGE,
 	IB_EVENT_WQ_FATAL,
+	IB_EVENT_DEVICE_SPEED_CHANGE,
 };
 
 const char *__attribute_const__ ib_event_msg(enum ib_event_type event);

-- 
2.47.1


