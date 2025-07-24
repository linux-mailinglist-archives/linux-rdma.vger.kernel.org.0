Return-Path: <linux-rdma+bounces-12461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE1B11297
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 22:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B59A169D04
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFEF2E5B2F;
	Thu, 24 Jul 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PtwSpPJO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6212E371D;
	Thu, 24 Jul 2025 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753390245; cv=fail; b=OSo/18fTc+UusWyy8a5H2lhB486dKXH7SAreDcqfB4BpYsy2M9CIB5JKuYpvm5TblSv8V6rpfDDwduB8f+FbUgk+RAuyYMUvK2b8tKcDAfF0Y/te2K2YJgNjqnS+kqA9hqHANl7NPYlJCF9WWcbXwUoh4GZ2DOQpGwzRJIOR0Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753390245; c=relaxed/simple;
	bh=a/nqI0q0RQqvSubPWvTlDkXt5aohVqQN+T2Tk8EwoAI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3LCVQIUN8AvijG1n1lJhWVWTQE2Tx0dpQSR50YhQJxD7oex9SRlDLV+Mv4p/vPVO5gnFwzy3uj9eEHnSJ7FbaesSvR0sYgaxe0uUr611GitPhKfXnhZIynKkC1iYGdiSbi/0CCVF3J/0sv99tQuwhQZtYDpR2TPG7+pIn5wgeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PtwSpPJO; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9iEEF0vO7/0nF2jFUtorfw8pnNZcmRc6kePwb476zW8k/UCFolTKXXJbwSxykjFsuCI6pWChPMvrO9djdjCAcWYlnL/bYJtpZGkPMFnV0ZppLMwvAmHrcphUvxRWMWx/k3Ji0ci1rxjwEBjfRC3Bg1wXYkF6BICDsgoJkT1cCX3JvEd17LRbJY1yTf+FyzHVSDKYgLjP884rYC40YBlCjhkgwQ1KobK4QcrmvmUKfsKZhs2SXr9aqgZhTNjGxuKw8TdCej020uTXXYaZKxtF5irvp3Gsg0YppxywL7j2dJKD8yBYyQLvex+GodHLi+7iBmDNt0+QFscGdt2dNrBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmZIUH6Ox8b69qfqRnLk0n6ktL5XtZzhIGHfz+EkAYU=;
 b=AaN1woKYaaplydesxEDR+9PwRsanUErhF0J1rld9Ncjzm1OU3Eipw38fvZa5QJZLRJ9rt8PNDAG3uHF+4E4TRe3lawdOfNX9Nn0mpWi4R0IsOE2CIT7yhUnEv+nfibhwEsNY940dFbIOHGiNFovlJRKTxHTIL1Pk1fI4FQ4feb+mnR/deX8yFJRogyWoUbGR/ySGPV6ck68QzQNYyK5/0XXb1+fNx9wfYkSeiNs5wKGI5mVnAbXEn8gpTNoVMremoq03eeafah43Lm3n9zXR8Xl5+pE1BjUjg0hyFeJgWV+/sLsexa+2I+2ICAJcHQlAnwsoixKseX1De26kI0b4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmZIUH6Ox8b69qfqRnLk0n6ktL5XtZzhIGHfz+EkAYU=;
 b=PtwSpPJOAyUWHgD2IWZ5xTzs68Ja21goUAV5kmpiXf0PebcC1RPv5NOPIGwBdPrZxqKxFlZzgM6bBG5zNPKFGlLBlP+Qw0zkwyGczGpaaM57/hQlI3Egqebp3POJSqC8v7LUKXoFz/PDTaHEzWJfEUJ6A5gZN9/0fsjWkdGbz63vQkKr3SVD9yH9nWg/cDE480QAvTzaF8WVaygcRgSm3mZsUJJicJPBaXlOl4Z6f+BUUUY7qqd8oaEko67oT0mtR/9A0zz9MbI/HCOuElkmmNsAC6e1l2QNtyFI9K0ohl6WZRUYShRT4/U8iHD/l7zTk5Xq1kW+ih0MA/1Tlu2Vaw==
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 20:50:40 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::d8) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 20:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 20:50:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 24 Jul
 2025 13:50:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Jul 2025 13:50:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 24 Jul 2025 13:50:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Shahar
 Shitrit" <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V2 0/5] Expose grace period delay for devlink health reporter
Date: Thu, 24 Jul 2025 23:48:49 +0300
Message-ID: <1753390134-345154-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 76edf4fe-8cb5-45ac-1874-08ddcaf3bfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmE2bEVyb2QwNkVodkprWlRTa2FNM3JRS2I2SjBjTHRmemlSTzExd3h3VGw0?=
 =?utf-8?B?Y1VRaUdCL1Y4Umoxa1k0d3BIT0J3eEhCY2JHMTFzWVNnV2NZNWdQeUlVeENG?=
 =?utf-8?B?YUN2WjNGMk8wWGlhQkxDQjZEbG1DRzk5V2tZb1Y2MXgrRjUzd2FQOXY5NFNZ?=
 =?utf-8?B?eTZIc2lTanRsSSs2T21xWEcwRGNoQWtvcW5iSEZDMTFiZStHRS9Vb0YwTWpT?=
 =?utf-8?B?NmVCZGNTT1lwajZwb1k2M0c1REMrVWcwN1o0L1ZCTFJib3MzR1g5N2hLUEFW?=
 =?utf-8?B?Rk9pbUNlSlFNUGtiWmJjaVhqT2g5cVovOXk0aXI0SkJ5WVJML1krclV5ZnFa?=
 =?utf-8?B?OGJjZmI1OTFOc0NpU2ZIb3kwWFhRNkxhMEQ3RzdPbVBNT1VFaXp4ZXNzTSts?=
 =?utf-8?B?WkFmTTk0bTlRdWU0MmlYMGdqMVAvWWU5RFlJQnZ6STYxYVVyYVVmdFJjRjVE?=
 =?utf-8?B?Vis5NXVYd1p0ZUo5eXFocGcwOXFiN1lLTSszMWVWZkduRmpDK29Fc2wzWEJ2?=
 =?utf-8?B?TExmcXZrKzJNLy9sUERYMzZ1b0VWbG9rQWc1aGI1NU9CcXZnM05yMWc0c3ZW?=
 =?utf-8?B?Q3JpVUR4c3AzeHo1ckJZeHZVZDM5VzQ1ZmtjcW1XR0EyT3pUOTJRREhuV0xZ?=
 =?utf-8?B?QnpSOXZLbC9kWndRRFRCNWNQSy9CcDBiK3M0QTVqWHlvZlIvMVRHalRUVGEy?=
 =?utf-8?B?cFFKNFlDWngycjVvWHYycTNKVjkvMzJUbkdDbENjZzJMZW90L25HaTZmZmt0?=
 =?utf-8?B?T1FQbEJsTlhQdGRNOHVobS9wbGZpMVBDTVVCY0hlVXRFbjdKOG1ZRVJkcEM2?=
 =?utf-8?B?TG5XVDRNTHpoei8wM2hLdVR0cW5Tb0ZjUW0zSnBLTS9Na1BuVjVLYWxiQndj?=
 =?utf-8?B?L016ZGJJTkJmRjFRTk0xQUY3dGhJcC9Lc0Q4MWQ2MTg5ekFJbWYyY3g0bC8w?=
 =?utf-8?B?cFQ2Z2dyRjZrTnlsa0FXYTAzQVRhS3IrUW9EMDBKRU1ieFgvTVVBcFB4OHFM?=
 =?utf-8?B?WUZLdGZBRjN3VUlpYVU2TldUMVBreFVuUW1FdjkwMWNGaG9aTVpmUThRTnRi?=
 =?utf-8?B?aERXWTlXQjZIV0U3d2FUUE1wMzR2dHdvWUE0RGZaM3JrM1RCUUVCUSt6OWhI?=
 =?utf-8?B?KysrOHZ4ZTlpdGI0NkJIeXBhbTU0RXU0aU1YcE1ISUhuTzFIZHhGUlNFRVhU?=
 =?utf-8?B?SGZ4a2xneElIZHVJT3NGVnJFNThzdHZBZlhJUm9yaE1zbjRjRllKUFZYZjZI?=
 =?utf-8?B?K1o3WVhQTjdpeXloc1IrcjFqQ3VxNkE5ZjBvL21zT3QxS0xVckZnUTVGWDQ1?=
 =?utf-8?B?eldSOHY0YXluRTdLYTJWbjdXUUR4MHJmSUxNRERLZkxXNmJ6cGcxS2g0Nmwz?=
 =?utf-8?B?MTBsQVZYYVBFZmNHQ0tGRzdWVzJwZzEzdGQzaDA3eW1GeHdsNm11SXpabitZ?=
 =?utf-8?B?ekFxQWk0TzNhNmhKbndtbFV4dWVXRFB6TVRPczdKZWZvUUs1all1Vmd0VUZl?=
 =?utf-8?B?Y2hHYWM1c0MvbVZPRkZ4TXZjcHVadkh5RksvRFljNmhuSk1rbjR3MmR0NEVh?=
 =?utf-8?B?SGJERnk5YUVMeUxSN3pua1BHMElqYVRtTlRBcEQ1ejlhVUF2SHRFV0h5eFR5?=
 =?utf-8?B?L1lxVE1GWk1EZitva1RPR3lCaFNZM2NXaHVGTkR6RkxYdU0xYkZTd1Jhd1Av?=
 =?utf-8?B?dk4yUGMyanZPbkZHbXVPS0trcEpZSTJ2ZFpXTnZNczZSa0Y5UHYwUlI2MVA3?=
 =?utf-8?B?NExSTUdEQlJLOFR4V2ZBUXlsemVnczJ1VUxMRk53YVNvTStCYTR4aitiT2t5?=
 =?utf-8?B?akhhckJ4WXBwOGFaSEI2aDJVNDNka1hFK1d0TnhKeW5UM3JnSjVoWUxiMExC?=
 =?utf-8?B?QzBHUFRjQWNzVUtLcFBNWGczSGlZTE45VUQrK29zNTJETmwzdFA5UDZCbk03?=
 =?utf-8?B?M0Y2ZHpuMTdwRExVbDA4bUU3OGlpZnFNTHM2TDRZUmNNMkE2RkxVN25jTitM?=
 =?utf-8?B?Qlh0TWRLVzRlM1NGL25naysxZWYwbnhNUDRRVE1xWCtySUNxK1J5VHkxcGxj?=
 =?utf-8?B?MEdKWkIzSnY1WXI2SUJBNnpxZVBTaTA5WGo2dz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 20:50:39.6764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76edf4fe-8cb5-45ac-1874-08ddcaf3bfa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

Hi,

This series by Shahar implements graceful period delay in devlink health
reporter, and use it in mlx5e driver.

Find previous version here:
https://lore.kernel.org/all/1752768442-264413-1-git-send-email-tariqt@nvidia.com/

See detailed feature description by Shahar below [1].

Regards,
Tariq

V2:
- Rebase.
- Fix long attr name.
- Extend the cover letter.

[1]
Currently, the devlink health reporter initiates the grace period
immediately after recovering an error, which blocks further recovery
attempts until the grace period concludes. Since additional errors are
not generally expected during this short interval, any new error
reported during the grace period is not only rejected but also causes
the reporter to enter an error state that requires manual intervention.

This approach poses a problem in scenarios where a single root cause
triggers multiple related errors in quick succession - for example,
a PCI issue affecting multiple hardware queues. Because these errors
are closely related and occur rapidly, it is more effective to handle
them together rather than handling only the first one reported and
blocking any subsequent recovery attempts. Furthermore, setting the
reporter to an error state in this context can be misleading, as these
multiple errors are manifestations of a single underlying issue, making
it unlike the general case where additional errors are not expected
during the grace period.

To resolve this, introduce a configurable grace period delay attribute
to the devlink health reporter. This delay starts when the first error
is recovered and lasts for a user-defined duration. Once this grace
period delay expires, the actual grace period begins. After the grace
period ends, a new reported error will start the same flow again.

Timeline summary:

----|--------|------------------------------/----------------------/--
error is  error is    grace period delay          grace period
reported  recovered  (recoveries allowed)     (recoveries blocked)

With grace period delay, create a time window during which recovery
attempts are permitted, allowing all reported errors to be handled
sequentially before the grace period starts. Once the grace period
begins, it prevents any further error recoveries until it ends.

When grace period delay is set to 0, current behavior is preserved.

Design alternatives considered:

1. Recover all queues upon any error:
   A brute-force approach that recovers all queues on any error.
   While simple, it is overly aggressive and disrupts unaffected queues
   unnecessarily. Also, because this is handled entirely within the
   driver, it leads to a driver-specific implementation rather than a
   generic one.

2. Per-queue reporter:
   This design would isolate recovery handling per SQ or RQ, effectively
   removing inter-dependencies between queues. While conceptually clean,
   it introduces significant scalability challenges as the number of
   queues grows, as well as synchronization challenges across multiple
   reporters.

3. Error aggregation with delayed handling:
   Errors arriving during the grace period are saved and processed after
   it ends. While addressing the issue of related errors whose recovery
   is aborted as grace period started, this adds complexity due to
   synchronization needs and contradicts the assumption that no errors
   should occur during a healthy system’s grace period. Also, this
   breaks the important role of grace period in preventing an infinite
   loop of immediate error detection following recovery. In such cases
   we want to stop.

4. Allowing a fixed burst of errors before starting grace period:
   Allows a set number of recoveries before the grace period begins.
   However, it also requires limiting the error reporting window.
   To keep the design simple, the burst threshold becomes redundant.

The grace period delay design was chosen for its simplicity and
precision in addressing the problem at hand. It effectively captures
the temporal correlation of related errors and aligns with the original
intent of the grace period as a stabilization window where further
errors are unexpected, and if they do occur, they indicate an abnormal
system state.


Shahar Shitrit (5):
  devlink: Move graceful period parameter to reporter ops
  devlink: Move health reporter recovery abort logic to a separate
    function
  devlink: Introduce grace period delay for health reporter
  devlink: Make health reporter grace period delay configurable
  net/mlx5e: Set default grace period delay for TX and RX reporters

 Documentation/netlink/specs/devlink.yaml      |   6 +
 .../networking/devlink/devlink-health.rst     |   2 +-
 drivers/net/ethernet/amd/pds_core/main.c      |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c |  10 +-
 .../net/ethernet/intel/ice/devlink/health.c   |   3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 ++++--
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |   2 +-
 .../mellanox/mlx5/core/en/reporter_rx.c       |  13 ++-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  13 ++-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/health.c  |  41 ++++---
 drivers/net/ethernet/mellanox/mlxsw/core.c    |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |  10 +-
 drivers/net/netdevsim/health.c                |   4 +-
 include/net/devlink.h                         |  15 ++-
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/health.c                          | 108 +++++++++++++-----
 net/devlink/netlink_gen.c                     |   5 +-
 19 files changed, 189 insertions(+), 85 deletions(-)


base-commit: 8b5a19b4ff6a2096225d88cf24cfeef03edc1bed
-- 
2.31.1


