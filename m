Return-Path: <linux-rdma+bounces-3575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F1591D9F4
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A2CB20E10
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502A39FCF;
	Mon,  1 Jul 2024 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SQDK86af"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D210A0E
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822701; cv=fail; b=TiZKEHhYGKLX+JFkAtkUgo7iRRHh9YyR9HKHIK/M6QnNAsM8XNpzjIvnXOumKwkR4NWGlO3mCEKFMVJvCtVD16+FYa0nAzslEwmyDsHFo/f4bYRsLht+QU+FSk/ENbHGjYnxWnElyYQhYYmPt9R26YUjBVozRdc1bwHSaHmj4cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822701; c=relaxed/simple;
	bh=wuwv2gHuuJFkOULK6rrwHrbyHCXRc7Fc99VgWFNi53E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SFgoVSHpbsGXYpQe8bIiohR/z/fwfNnvPnjKplBz5Gwlxxa7JeQwaMEAUzP2wIOH8NVsRokfc447GxiBZ+C+lV3h/Q1CJL2PWgoiF/QEWx4zWwaHkI1FYeFF1T/jyCrXsMQ5bquse176rwArOrTorYIwGvUopuxSEtqR7rxvCQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQDK86af; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQRMCzYUdeNpYUK5tIcHXP7jiW34VP/bmtitPUKtmqkPf80pZC5HXE4j4LKJV2lEeZSxrResMleMJt6RxuAbhliG0LIZJewsuoBSnf0VVm0o3ocBVxJnupCuDbP5rcR9SJnU3xBQa5QCUfIkpH2NIHVjnsca/4+qzjT+KicwzxuauU5LmVlSBZ/yJqZ0cDPOWHWP2qw7gomrrZ5xRAbF0xEKKjeuJrnlYIK7EQHlotbFyYYXxBqntaD5GvF341U/gyoE0Qj1l9yZxYElz6A9g6wgQYj7CX37qGixmmCiTBC1Ur8XZblNnkmwMwkArN7LxF79LKaiJouF1UzTWrXJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oz5UYvvPon3kfnPi79D4W5EONZ1+gz3XDO/J5q4JMSk=;
 b=fgACKFPDP7PZRmsTdVrH8tNQNI4vabY8klU64R7KAxPImlMsOvzI3l4U4uo/+mAchkNaWUhv9+bWfcB8zKU20JzoS+zROIdjF2HZwiM2mJozmmWIKvIAxuJ5zhV5dES0CGic+3KGsZ2bxsb+pP2XrGQGao0x349c9wNDY1a94bbWdCqt/bfulFWlYGuQfhKOlJWIQPCeWpQ7v+cif3ArVgybUyeOUTW16/iC2ImJIAGT6K1Ozdq71F75efDJduW28uEwvK1vb1tjFaexZZTKnEGK3XPUv7ygIvNZgJEXooozPigQaam8klWUu2nguPHt/EIj4n3x1btn9Rs7CGi3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz5UYvvPon3kfnPi79D4W5EONZ1+gz3XDO/J5q4JMSk=;
 b=SQDK86af55JNcOuYkOE1W3Fy5epH8138fmqLizG9LfGrGXLLn8S9XNnXwdldZfoaNG6C7RvN6c5DTwgGbpyjbfNYev8R1Z/JomjCkwUNwAASnuEHgBGTmabfXV2tjkFUiHWWxcOwsELiPSCP0nAUFoH+PH5SpsF6/8Fe/C8TD3MHtisIMH9cWHvYsdQgGCKOGuYVJXECl6LnrZo3pWLXDCFji1jZ10MX3hCjEifu0B6cV5UHaeH8GVfhrXJyowh3QVZCDp4L6ranZtnqY9q4xqPA2vSLLrJL4iPEDcMhN0XgnfDzPlBgiY2Vn27yYWGsXl3gC2djaGUYhwYJDTICtQ==
Received: from BY5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:1e0::23)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 08:31:35 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::4c) by BY5PR03CA0013.outlook.office365.com
 (2603:10b6:a03:1e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Mon, 1 Jul 2024 08:31:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 08:31:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 01:31:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 01:31:17 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 1 Jul
 2024 01:31:15 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [RFC iproute2-next 0/2] Supports to add/delete IB devices with type SMI
Date: Mon, 1 Jul 2024 11:31:10 +0300
Message-ID: <20240701083112.1793515-1-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: c69568db-a060-4052-9c56-08dc99a83835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NSoE3Tb6DyXelWWd78Ctd/3SbzLoSKW9Kuy7NrbGS+6b1lqRTm6nuADBhDP+?=
 =?us-ascii?Q?X3/+5wRwrQSc6Z+1gypmMkIq+Rp8pPXrExuDxUdUTz+6TgWJ4ubA59nydq8n?=
 =?us-ascii?Q?CEXdMNrEU0T7ARJ5MWwTwKg4cAe25kP0BtNJkTch0ZMgZ+DH+IhtTtqVv7tV?=
 =?us-ascii?Q?R9+885pgIMICoLvRG5ZR7b+Xcccw4Q3h0de9Fv5SQzQoajcu6cPcsh2DT14A?=
 =?us-ascii?Q?nol/M/8IapiQG2WcDS6pdS1JhrDZ46FE6XpvPcZ0RTNzn5lmbmy70FOy3OwH?=
 =?us-ascii?Q?gFtTcxoLen95MTF0g5HKlZrI1ZYqx0EIsZEvLY2930oR4Y/t++BHpDFWUshU?=
 =?us-ascii?Q?Hv/Rdj1bv8eTJlFJMmch/KVEDfP56nGP2QsrvILb1YEwIVRftIcEF2ugK7K0?=
 =?us-ascii?Q?1IYhuuFLOhWp5DSgoac68Y0YXm5cydr2WJMvZm/LiONZ7OdFkiie6rl3JUdI?=
 =?us-ascii?Q?Bzrrqf17uu7Vzo54BUE59K+CZFt9Afy/NcKtzq0GgLaj/QYccK7a60NmTbcp?=
 =?us-ascii?Q?BiM+1B1fYC0y4PMvVdohIsntqU/2344X7E6w+vkugMnHsVHtx+oYcDXFSpJt?=
 =?us-ascii?Q?uFryuC0VbTcFl1Pm34c+H86SWOmFasS9jzFSMwP2LD4t58LJ5ChaTn6+hLIX?=
 =?us-ascii?Q?/SqACTi0k4TQKyeheeCn6eFZovJS/qDIdW35Rq6sGG+yBfTQRp0ZHjsN8yMv?=
 =?us-ascii?Q?qomLWN/94W1uCyXKw8K0SlN3SbGMnPMVnc//suhzBUxqRr15BPw3ZsNvZeC4?=
 =?us-ascii?Q?o7IPKgCPSAYm3CsFXBuDqZXKq+gpJpD0qZ7z2koAoHd56InYiwIVL4Ciwq0K?=
 =?us-ascii?Q?JNSyQdSw5VjrAuzMetqCcvzBnuVVBEN5biguz611wVusAEwkMCL7CLDpvc6A?=
 =?us-ascii?Q?cPOABI9VTnifvi2/9MPFyMpeAqTitTWAmWuduUB29NJFWyIO9zog/gGfXRI9?=
 =?us-ascii?Q?Kbv/cZlnB6aIHRz1BZ3qvUP1ciR5HoB27kHUe2FEEzpaaVJFhJF9clyj2DJU?=
 =?us-ascii?Q?eZ7za1doTTLzZvfWZSO+GnfJaUFFXnDUFie7bDR5YG29RdsaO3jzH+IJ/605?=
 =?us-ascii?Q?THuaxKfw4fjdnq91bIj8fqQ2YIFPivR0jlhUfuFnjcZQcr9q8Znwznl8SPLT?=
 =?us-ascii?Q?QpqG5i5emGv18l3dnpDfgRUKDaT/l/cHM6cc8SXEuC6ggrTKD6B2fWpXWxr3?=
 =?us-ascii?Q?5/rnSjaV+K02p1vBkJjXWuG+Hz6ZyUwlgyDzXvhM9ndJhwMpXNIafFX4FRjd?=
 =?us-ascii?Q?xyspweoYRCw0FP6UehAeLnDhyOhqMfISws7gUrNNcl/QXn/c1wOWiUDh2OpH?=
 =?us-ascii?Q?mRvNoFg6dbZ2g5IfUimw+Pwax9X1VcKg6kq1DUx4++vWM3xGszFfQaygCXlX?=
 =?us-ascii?Q?kST6y91ucgE0CnFsOWZtJ1Pf3zCcBNmZfu4HMEyiL9Pmh6ExAyQCLWtZwRLQ?=
 =?us-ascii?Q?F9Zj4iXuMva39VotXBe7MxLzSY9ZSlLg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:31:35.5110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69568db-a060-4052-9c56-08dc99a83835
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769

This series supports to add/delete an IB device with type SMI. This is
complimentary to the kernel patches that support to IB sub device
and mlx5 implementation.

https://lore.kernel.org/all/cover.1718553901.git.leon@kernel.org/

There's no kernel commit ID for the rdma_netlink.h change as the kernel
part isn't accepted yet.

Thanks

Mark Zhang (2):
  Update rdma_netlink.h file upto kernel commit
  rdma: Supports to add/delete a device with type SMI

 man/man8/rdma-dev.8                   |  40 +++++++++
 rdma/dev.c                            | 120 ++++++++++++++++++++++++++
 rdma/include/uapi/rdma/rdma_netlink.h |  13 +++
 rdma/rdma.h                           |   2 +
 rdma/utils.c                          |   2 +
 5 files changed, 177 insertions(+)

-- 
2.26.3


