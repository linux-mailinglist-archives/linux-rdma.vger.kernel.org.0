Return-Path: <linux-rdma+bounces-12683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A604CB22AA8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C41A5A3B3F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113B2EA48B;
	Tue, 12 Aug 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RpvaWafG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336228726E;
	Tue, 12 Aug 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755008298; cv=fail; b=vBBIng5Y77wHQizetRHY/XIj+Yjc9kFBjAtdUzulbusfWeZKRDL7BMwfCDW9bFlg8etSiNwXPPy3En6KpKd/DdUm1n1QENvVU/Lmep1vg6s/lP3EUYDhVMSzWmLczLzmgL1Gju9RVmCQ1rF1Qi3p32Q3YRujcq93Rk4D5z8DXZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755008298; c=relaxed/simple;
	bh=9d7OfQVmLUamsaQU8c8BnDiW+3nAdaw1gSvh2FhiceE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKPxhGfNlW4J676YkLg7NK48O3eeojGlyzhNDsR1wpsHXoNr66MgHBFPssMFS+eaiozzqgXsbMX6pGgGN8uoPtN+SZhvUMgrZe08i42gWj018f4JrOol/pTW83MeEWgzMB62tW9eOKv+EIrRB5xSuXpmiFEE1uldwTKCUew9AiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RpvaWafG; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnR3Cis/0SNS1FG9gvOnvq/vxjZ3CyT/J/43iGojK9t+jYzxYPtYOFAioATzRe9LAYgRj31slIEoXowd23T2Zec78gVYzOMfFMfwCug5BduLCOWFaI1w1e6OW19ORsbTRng53axZtX+P6DiP6NQrIrt7lMaJTM0bm2mj9OT20rUrcEcOOS/GOZYBx81uoUM1ofvKG2lCsr6X03twdM2N04bDOliFw7CGKNLiajuM73HI22MvCDHNiIk79866tz7atR6b/e+B/GlcNT/1LzA2wu7NzzbC8Kdb2qvNkv/uHU1fFn2n+lc9tyN7gOSJEIOEbv2oFF5Q6wEJxxzqtxrbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lhb6DAIku/B06uj46mo1VhG594367mj8kACn14NV8c=;
 b=TkrQMobV0xQArD2WsZenNkKX6ExnTG7eQsFBo/RwY3TZVDEjQmFt3+2oTucsa0D2PSHV/DUwDy61e0zi0KcPUSuZRP9S6oXgK4PjHpkHAL4ZqsKreo+TL7u4kSfzb34IAuxcSGSmIZYy3psG/O/Q5e4Xq7OVJY6nyx+45qwGqDeGawt0uTK76rTDYromDnvz8xuBgYNafuN9Mq/fXPenCwPZjv+2WTa3PN4SQPC1rXc2gVD92vCPJ8ZcNW1JJQp0MmWbmr1PCrMLI+Rei/8PVYUqIaP2dhUDgmTOXjaUM/YVmiDj6aKJ06sINoqe4uw+BeomaF59vI6KBvCIr/1rJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lhb6DAIku/B06uj46mo1VhG594367mj8kACn14NV8c=;
 b=RpvaWafGaz5OGhA6BSKf87fI6toEi+EOJn4SauQnu64tkQ4LGhzg7aMplP02Wxrle5irwmE+mDzxGZNrIL9f+uOj8jwTREd2h23kv84gk2KKRlM8yM0TsfCk3B3VHka9zn8k6r0lhdSvPd5dlettRKUUEFAyPXkPKpw4heNM2g/t87pIkkufKqx+RHLOr9OwEZPhIiMUL2WzEGmXVBa6Rv5Pm9iZNuTi/MINlVjj5eCoJuaj6oBrIzUv99k+ICfinnhlPSjjHmpsa75DgUlPsGulnakaQwlye+gtQmwtcPh4q0kqGW3dj0epVIASdomC0x+boO5UHo6WnnPnFKSTJA==
Received: from SJ0PR03CA0106.namprd03.prod.outlook.com (2603:10b6:a03:333::21)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 12 Aug
 2025 14:18:13 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:333:cafe::93) by SJ0PR03CA0106.outlook.office365.com
 (2603:10b6:a03:333::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 14:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Tue, 12 Aug 2025 14:18:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 12 Aug
 2025 07:18:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 12 Aug 2025 07:18:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 12 Aug 2025 07:17:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Carolina Jubran
	<cjubran@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 0/3] Support exposing raw cycle counters in PTP and mlx5
Date: Tue, 12 Aug 2025 17:17:05 +0300
Message-ID: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 315c6580-e992-4269-5948-08ddd9ab12ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEhWdndBYVZEc1VsRWZCNk5Ldm55WENrVVUxdWQyNHBrZFFzTCtvWTBjdjVN?=
 =?utf-8?B?eU5ORlZySXdyYnZRWXpBZE42UXp5RzYwMnFyOHNwK09oa0lPdG04QmNKVEFz?=
 =?utf-8?B?ZncrcFRDY3NSc254czdXY3RZYUxjdXlzd2prS2tTWjhMSWpZNXVESGVVYnZP?=
 =?utf-8?B?eVgvRXROQXo0SW1KLzlqMnlTNU1iN1ltM2o5SU1aWTJTRzZnVklMWWE0TnFs?=
 =?utf-8?B?UjBXY1VlRnZLSWRKYi9NWi9sYUxCU05BL25BMzFlS3g5TWYzZkc3cldkRk1H?=
 =?utf-8?B?SHR6cUtDRFZaL3MzNTRmMTMwNkZuYXF4M0xxVmZoTXZmVjU2SHp0elZpQVd3?=
 =?utf-8?B?Z0xPTDZjVUhRUjRQNVY4SzY2bmg2NzlvYjUyeGtZWksxTHQ3L0pKMy9nU3NM?=
 =?utf-8?B?RURxdzN4RjlHbThsdmg5dE1WWXhNLzRwZSs4bytVRXI4YWtpeDBic1lWcmM2?=
 =?utf-8?B?ZlpPT0h5RnJKUjljWS9nSy9NN25LM1VRMlI1U0RLdFBmTWxSeHIyd1c3Umlz?=
 =?utf-8?B?akx5d1pDdkI2d01rZnJONitxeWVkQk40c2VzTW9tVjdhOTVTckJxOHJYSGRI?=
 =?utf-8?B?elY1eWlvRGNUUWl3bktyeThFZzhYcUNOd1M0dlIvb2FXUmlNNkhiYWRpTWxy?=
 =?utf-8?B?eHRscDJ4YVNVTGlHTDJBcFRoOUd1TGVXeUFucGNCWjB1YXMzY0kwdVhUSDZm?=
 =?utf-8?B?cTVCcTFqMmpXczNkTDQ3QXZ0b1pzNWp4ekdqUHZoSEpIcXh2U2U0bCtNZEkv?=
 =?utf-8?B?aVh1SXR1bFBjRU9tVlpCa2oxYlF5SzBNaUJGeXUvcmhob1Bic2hpL3hieTBP?=
 =?utf-8?B?bS9USlhYR1QzUENXYSt0Y3A2cjBueFZhNU9HOUx0eDBjZ3VCQmk2TzFmcis0?=
 =?utf-8?B?NTVJNUVocFdoTUVURVJBZHluTVhGelRWTXRnNHg5NitsaGEyWDNUOU1YWmlR?=
 =?utf-8?B?N0pGT1ZkcGwxejNTRVJ0V1ZzTGt1V09UNDZocFdoSk52TzhGL3BDVnhPUHJD?=
 =?utf-8?B?S3dtRnY0anVidzZ5bHNLWFp5eExTTU42cUZmR1d4QUpvRnl0QjA3S09HTjJr?=
 =?utf-8?B?YlVPKzZMYXBpZ29ZcVp2dHdYN3pWS2ZxOVNheFVRKytUTDkvL2tuK1BKWlZF?=
 =?utf-8?B?dTU0ZFFiaWlZUUZ0MnoxQ3VSU3VjTTE1SkExTmJuM2R5ZC9FNEpUZGFHSWI3?=
 =?utf-8?B?d1NWQVZkdDk0eWNVdy9iZTVBSUliVDhLZXJteEZES3FvcG54OW16YUkyb0tK?=
 =?utf-8?B?R3k2ZTZpWVVCbmdiOVZKaHdKOG9sZVkvN0ROc3UzN2xPWE00ODVkMXlMMm00?=
 =?utf-8?B?MDlYeGY4REtGcFZ5cHFMOGVaNU5qWWZWbEpYVWtkR0Y2Nm9EbmJZaW52Tkpz?=
 =?utf-8?B?eW5hMStZU1dlTkdyTnAxMkpaYS96VnVHOTBic0hjNnA1cmdRTGVwQUt3ajdV?=
 =?utf-8?B?VCtaazAwZnNNamJ5bEkwdmZWL3dHSU90ekZTeUs4TTQ5U2llcENSa1VOWnZB?=
 =?utf-8?B?WDh0UXlWR3gwR2NVR1NMUlUyTERkZGxTY1ZCRExYZXFrTHV1aDBIaUo4c25B?=
 =?utf-8?B?YktSb3lUbGNYVFo3VlN6dXhZS3cxd1JzZ3dIOTd4RWNEdUZTVG91aU1ENmhG?=
 =?utf-8?B?Skd3bURHS2JXcENLY2VJWTNtNFV3Z0dVd21KNFI2dVp4akYvTitib0UvVm0w?=
 =?utf-8?B?TzZ1MXJTMUxTSlNUSFRhUHdOdFpGYkpIeDZ5SGRXRTY5U0d0S29ZMk5pUHNv?=
 =?utf-8?B?dEZpLzZrUHBCYWptanRvZEdSaThZSTJJQ0VYWnBGVEFRNEdFaFFML1dWTEc0?=
 =?utf-8?B?YzBUWjR1MlNlUG1EMEhpK1U2cDV5WVd1QWt3ZGFDKyt1dE9VRytsdmxPUEZI?=
 =?utf-8?B?R2k5cGlaSGhTWDZvMEUvdFFIa1dXcUVhNVBTNWtVZ3VKRnRqWlVoYmdyOVlW?=
 =?utf-8?B?a3FDT214alVsbGM1cFpkLzI0a0lOWUxlZlFaZ3dCMFZ3N1BjVzRNU3FsU3Nv?=
 =?utf-8?B?a2RYMGFJWXh5RHNnUVRYZkdnR0YzWnNqWWhHSTE4L21MV1EwZ2Ewa3d1Z2do?=
 =?utf-8?B?MW4yN09PeTE1Z0FFTTh4a1pPVDlza2hMT3Z1UT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 14:18:13.4462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315c6580-e992-4269-5948-08ddd9ab12ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338

Hi,

This series by Carolina adds support in ptp and usage in mlx5 for
exposing the raw free-running cycle counter of PTP hardware clocks.

This is V2. Find previous one here:
https://lore.kernel.org/all/1752556533-39218-1-git-send-email-tariqt@nvidia.com/

Find detailed description by Carolina below [1].

Regards,
Tariq

V2:
- Extend the cover letter with more motivation and use cases.

[1]
This patch series introduces support for exposing the raw free-running
cycle counter of PTP hardware clocks. When the device is in free-running
mode, it emits timestamps as raw cycle values instead of nanoseconds.
These values may be passed directly to user space through:

- fwctl: exposes internal device event records that include raw
         cycle-based timestamps.

- DPDK: retrieves CQEs that contain raw cycle counters, which are passed
        to user space unmodified.

To address this, the series introduces two new ioctl commands that allow
userspace to query the device's raw cycle counter together with host
time:

 - PTP_SYS_OFFSET_PRECISE_CYCLES

 - PTP_SYS_OFFSET_EXTENDED_CYCLES

These commands work like their existing counterparts but return the
device timestamp in cycle units instead of real-time nanoseconds.  This
allows user space to collect (cycle, time) pairs and build a mapping
between the device’s free-running clock and host time.

This can also be useful in the XDP fast path: if a driver inserts the
raw cycle value into metadata instead of a real-time timestamp, it can
avoid the overhead of converting cycles to time in the kernel. Then
userspace can resolve the cycle-to-time mapping using this ioctl when
needed.

The ioctl enables user space to correlate those with host time, without
requiring the PHC to be synchronized, so long as the drift remains
stable during collection.

Adds the new PTP ioctls and integrates support in ptp_ioctl():
- ptp: Add ioctl commands to expose raw cycle counter values

Support for exposing raw cycles in mlx5:
- net/mlx5: Extract MTCTR register read logic into helper function
- net/mlx5: Support getcyclesx and getcrosscycles


Carolina Jubran (3):
  ptp: Add ioctl commands to expose raw cycle counter values
  net/mlx5: Extract MTCTR register read logic into helper function
  net/mlx5: Support getcyclesx and getcrosscycles

 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 113 ++++++++++++++++--
 drivers/ptp/ptp_chardev.c                     |  34 ++++--
 include/uapi/linux/ptp_clock.h                |   4 +
 3 files changed, 130 insertions(+), 21 deletions(-)


base-commit: bc4c0a48bdad7f225740b8e750fdc1da6d85e1eb
-- 
2.40.1


