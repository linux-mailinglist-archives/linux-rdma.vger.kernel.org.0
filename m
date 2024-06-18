Return-Path: <linux-rdma+bounces-3247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5B90C028
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 02:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FF01C20C5C
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 00:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820DA3D;
	Tue, 18 Jun 2024 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJOyJzxr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAB139E
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669465; cv=fail; b=LzL4QHSHa0qirplOEm/T+xy5AcpdUUmnVuDDIzf/yoV2SAQCrpRV3hU/9LCdE/c41Z3J4AgnKcapra89n8oZG4toSHSI7W7kGBg660cJCkrHw5aJovcsdH04U2sdf83u3Hy8CoNK7cthMAhueF09T00wiFo4Es2XfhcmXYEjtfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669465; c=relaxed/simple;
	bh=chif6iVeLZUwe8ejbU06jNF/GrF41gMtwl/HRmxGxm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYkxKPO58/EHG0TqiTqye8y2k881NHytfq3htvmGIl01u/TZhAFplSAKfun916/fPa4oACeqQDUMiT8HMVyX4z2x+wIvgUFl6ulYNWFjM94zFthX15a4r/Z0K22j0HZen43cPZd/aWhnsbe1IYIjV1iGblrZJxAeDg7TAen366g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJOyJzxr; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmdhKvGpbUb6Q5eT3/KoDws9/VB9RzwLYztadW3c+PuoIDRktBSbeUtMULMmtdD4QARVR5P3hxe6m7U+MerRzmHVDoetYbzoRIKqVMHiBvoNd9kE0Ma69eddqtG943BQW5n6unxDWDwcG72JGbZuNtp5NpG2ElvfZ6fso9OADeNivXUc0GtJqdLEovFNQBrnzVTElrdHsliXChRV3Yzz1Z0OM4yZR2LDCWBDsbjTkuVD82qfIgkz5sgdKNME2q5qADO+kq7Axep85neXk060NgTHpHmCUvqaBgh9zMLVVgcjXSnPup0eEDjmqjWcFy+hlYBxwAt0rf+E/LrasvoURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7ishIMx0oTwH8R8aZEU3m1gxjUxnldxqZIna8x4s2c=;
 b=Czhf1Hd8i8JfpLqDerOyWQclHzKOI0uebDMC9bSK+3o2YLrcGtDNaLJ/7mRoEqgKPoYJ/2GERjcB8+y/4CYFL7dRzxlATDUHwiDCjLBvqiv0h5Cz9wP5Ec2E/v4xsvM1PdimQXw3T2b3ioZBuvCCEDEhdM0f1Ek1LEtog1LxdeOjXkOKs4wB+733+eNwGnLUNs5I0D6Y/8mi9Xqq0bmoEg9nL0tdD7FU2T4Dd3Znzk1epFi6ncNzl1wOcBIlZlgiaMaXPyTTVRSzXEbMeVS06HZULFYIBi5BpXpfqp8mV60EBhPZwEwaGlHlMJbJ3mqUQLPbyxxmAfxi22bgV81s/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7ishIMx0oTwH8R8aZEU3m1gxjUxnldxqZIna8x4s2c=;
 b=IJOyJzxrrPShDaaMxKbGSBAssXFj1yPzbYA8UCUMQejvIS0h8mXoIKKQx2euYit7HSKrYsuEel5QYZQ5dP3uZjuS8IygYhqS2QxtB7tjx0o3yYI7lzTOnp209S7OAcVzNOOuYAkbQj3UiycnA+dGb4uDYZmhgQY/Mq03zZAXoxSrIXQDpjZ/PBxX495fLsf/Lzr+ACWBBkn4nRwQCtbtBKjAXuIwnWzGEmi3Bzojb3e1OsN6JnL2xIWevvodJpnOIcx5Xptu5A5JBJl25sMUU5HNKDmpRays8iuKm+B3ueT0tCcS3Tx81piwBwe7YijLbxaSkQVOpE3IY+I9zbz43g==
Received: from SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::32)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:11:00 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::27) by SA9P221CA0027.outlook.office365.com
 (2603:10b6:806:25::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 00:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:11:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:47 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:10:43 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/6] IB/isert: remove the handling of last WQE reached event
Date: Tue, 18 Jun 2024 03:10:30 +0300
Message-ID: <20240618001034.22681-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: bc75635a-849b-49e0-29c4-08dc8f2b2257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?96lKbYK3YoE/VD4cuM2RGxNAaEMeRpPUma+KjuG9Saf8T9Ox1PDwsDDN8b1p?=
 =?us-ascii?Q?c5SL6dwbzaCtwGfoRDHNM1+ZOlLmi3CUo9QeMx/h9vpLO1UweMk9hE6zgjSJ?=
 =?us-ascii?Q?ejew2I5087xi1K0Cvzhdm/6e/3NoIrIUcNRtksB9gmTjkCuwdgPFLard/JNe?=
 =?us-ascii?Q?Ds1t2WxZ0PeyJPydANqxLWD/x11nyedVc0xBQBe7Fd4hQ4Q40RMMvn+6Lwd7?=
 =?us-ascii?Q?yT99amjJDVEcVjg2Pmc/ECKJSFrQbYTBZ6xZb5YrUHGSiu2DL0Mii4Zw5rlQ?=
 =?us-ascii?Q?yKxKIel9e7yKKa5OvPgZZFlKpQdTj4hPQEGHvV634yi9FnIjDuvtIucpfFWp?=
 =?us-ascii?Q?5gi8963p6KFeatfAvoUmiqmI7X1QVc0AsmJpSRhxLWx9T0z+5YxyG0L/kqAX?=
 =?us-ascii?Q?AelVVZ0TkxLoBulF28HjcWPhnSiUGJHTPIZkf8sULV38vR0CqcYkGLbuUqC/?=
 =?us-ascii?Q?qd2AjlKde9Ccj+EKxsFcq7DIUjJAMLYsSrXsz+j/Rgz1L9dB731YqdZ/dRsa?=
 =?us-ascii?Q?46FweLBFqHRQM2GYT0sjc71zcTfQIftxoxG64YwRfcPRCS8gj5r11iLtimP/?=
 =?us-ascii?Q?zjQyq3KYbvboXEGJYT046VxiXg0aWnT2KkZdGITbnk4G0mylPLsNizc/RmCj?=
 =?us-ascii?Q?jy78HBHMT6iivq4OVicQReQhiOGv/N58Wa2HUY7atAs4HYUZG0jTwGpCRe1H?=
 =?us-ascii?Q?25Gt6Is5VKgIwXxhxbV/EqmYdGqUR+ICfEnTlpGUzbCAcpgwPKHnTXgMklid?=
 =?us-ascii?Q?UhEQkQPT0Bd7ee4LO0wCHwrpvYHsIzeK7HX0zpmIV/yxNIFFhQXywxwpEc0H?=
 =?us-ascii?Q?dM4ENJWOEDRON0d/Y1xY1eYH2+PaDnslQHbt+0Vdbq1vVVZo37DVdQJSHbmt?=
 =?us-ascii?Q?AcgYp6pQ2w5edTKGCA2acD+d2vfypANaBaxcSf6aWgZairTkuUC1LA0yLd2S?=
 =?us-ascii?Q?HyYrtxDW7qVOr/JCS/QZSqSMFvbpBnRoDFoODv4Z6DugRoF07kjxj2rYDVRw?=
 =?us-ascii?Q?wZdZPn3pHXEustYfZg/wgC4IuwEIO4M88Y4LCgJ6GOv+9eqp7cX1gUXsApPL?=
 =?us-ascii?Q?Rn/SbOJdV5mpgtuGqEpJX2B9Cmrzj7rwZELZ37YGOihem15WMMMZvDSlokQu?=
 =?us-ascii?Q?wlkIy36W7QAzrJL6D5HbEKqHkyHjx0TBbMEv0eVf6hfuO7bpi/eKd7bd2xvV?=
 =?us-ascii?Q?WxBQbPvBQIv8lw2n68QBpdV4M4t19MOx0TFYSMuY+Tj4rmrz7VpKbqNuJYBf?=
 =?us-ascii?Q?QjgcN82dw1iYd5A5d66rWxPHncV6bNJP+WS7zz/InsTBcWA9yn5AmC2nX9k0?=
 =?us-ascii?Q?E5vb6khdTrO4KT4+qAd86bEc1W5tP+ECnQmOlaQdBLQ7itK+gwoM5EDSD2Za?=
 =?us-ascii?Q?PdCE/+vZRepdV+pMkfvZC2WrNbfZT60/WjDha3upitE7TTykGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:11:00.0708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc75635a-849b-49e0-29c4-08dc8f2b2257
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

This event is handled by the RDMA core layer.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 00a7303c8cc6..42977a5326ee 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -91,9 +91,6 @@ isert_qp_event_callback(struct ib_event *e, void *context)
 	case IB_EVENT_COMM_EST:
 		rdma_notify(isert_conn->cm_id, IB_EVENT_COMM_EST);
 		break;
-	case IB_EVENT_QP_LAST_WQE_REACHED:
-		isert_warn("Reached TX IB_EVENT_QP_LAST_WQE_REACHED\n");
-		break;
 	default:
 		break;
 	}
-- 
2.18.1


