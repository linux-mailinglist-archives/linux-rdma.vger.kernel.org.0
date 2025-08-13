Return-Path: <linux-rdma+bounces-12719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E97FB2537E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD74F1C28489
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A45302CBA;
	Wed, 13 Aug 2025 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XrjSi2la"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB55303CAF;
	Wed, 13 Aug 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111413; cv=fail; b=Xk52HHgSHqWRJFS50fmN4+zvP4vPTqWkbihai9oQ/bUPgYayDLge4LD2SQYJcA/FQZyeZ/39Aw/bYbKtROKHGMyTdy4Y7efOk9I2x7mfYnUHR9ewLrEkt5A9KwMeH5oM3vv2limwtInCQ0nZjGBBf+USoM/TOQl1bEW2p0L9ONQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111413; c=relaxed/simple;
	bh=hOcT3c4U14m7QBRnK1+WUwEpnoXoyE9dTxkkzDPZ+Pc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDjjmJvGgfvGIg0/IczB73kitfID5ldvbikAywZ6z62VFOmmrgoElxJz2SxmfH35T4owZ+uYnCV+8j6YPvy9WQgBbHGd5Ii0Nxp5DjwRxYwnm4YeVzdbJ3Sm6ySlxc9mUYETwBmICxzOmH+MGuiOEeg062IwdBy7dn8KKgrW/Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XrjSi2la; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWFfciDlEvbOM0om715Bx2suOfNYoAgvl177BG8zPZV3PKMVCg4p5xRIOzohnX1fwrGO0BZKkDk0G0OE1lg8YEwyZGQDH+zYHkDPKhbSshMxw1CvOZPhJipVTVMUxpPNHn4490sWE29dcBIYh1nal8wS87Yx2uSzz/FHp7h7vaTgRZOOW3CgogXBPZzGMJ/gDsY2dmKOo/Wj6FoMO1sd36GI+ZktMU+e2nrIFBXx+XyBY5zBONtlPaTB9o6GQJP4VtcxzYJqBwIDDloXf+qRSPrdQ7FPl93AuwGCeXIhdD/okdoHBJjIGhtlaJiV89q0jp7IAhylvdKyCz66PNFcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6HeQbEZHW/ptNPBxaxEDH6AghcK2kDbxkI7r4hWHmk=;
 b=mDx6KMCfOXJMotee/FC4n8jhSJw19DC6WBji2vupFOAWCYutmEwkbGyJgGPx9G00Y5vCD4OEcBIdapSuAetj67MrbFunPYCW2kh6GnGKKix9q46Ojq+iBXBAtParA0l0Ize1WcIBR2yH5tETEHGqZmLMrJBTSMwHTawwLaQzWYBkFhT4QjjIajowRchPqV7X88cUiIoQyubatFAXDiQPQCB1P1LRORCZE71SZkRzxB3I1RTdER/AOoDOysDFxU9OJ2w3VhS1qqVHciU8WYYQAZ6Sd80Yy/EifJ7a/Mjh5KpjexWX3cmWS421aH7aD6fWMruDb/VknubozxHCgszI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6HeQbEZHW/ptNPBxaxEDH6AghcK2kDbxkI7r4hWHmk=;
 b=XrjSi2laBwfGW7xxc2hw2TPxmbsBAkK6Y8es66ule3TWQqUfMSUWTbLThRNgatyq+FtbG+XRSwt6pYGUA85uGW6IZ3VPwQND5VLP2Yihqq+I4dOCPijKJqSsLdBUaS9AVSn3l+A2aUevAsItgTaa3lpmV26yjWNGXFUkWOi12086MHQMHt3Y42dcrwBnlvl93XPxcjtpAMKUX8M8u+RCJq51DUZvkfJM33Cl1feokPeSfVgnBKBm/SMC8aSIhp3skqwGdlFwSvO71Gh9tCYudSKZBGvu1WI95BPtcr0XY6YCWxlOT43bqRtQudeNKK/LHQ8GtUkHTvlKFJKmnRCvWw==
Received: from BYAPR11CA0046.namprd11.prod.outlook.com (2603:10b6:a03:80::23)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 13 Aug
 2025 18:56:47 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::8d) by BYAPR11CA0046.outlook.office365.com
 (2603:10b6:a03:80::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 18:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:56:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:56:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:56:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 11:56:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
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
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Shahar
 Shitrit" <shshitrit@nvidia.com>
Subject: [PATCH net-next V3 0/5] Expose error burst period for devlink health reporter
Date: Wed, 13 Aug 2025 21:55:44 +0300
Message-ID: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: b51fd285-605c-4f92-9435-08ddda9b2723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clBGd01zQ1dsalR6bS9pRDNjNVl2WnFvV2tUK21NS1h1c01mOSsrU1lYa2tD?=
 =?utf-8?B?NDNacUwra1VicGF3TjgvZG1oanRCWCtSdWdYaVhHWWgyNDAvbGFGYXp5WEJi?=
 =?utf-8?B?U09zTzBoT3RTdjV6bHYzdnVLOU16ajFvMWxlanRJMmRmd0RMcmZrTEZydE5r?=
 =?utf-8?B?ZjAreU5zTGJGOXdLVElTMTdHWG9xSzlRNXl5VFQ0UW9ZN3VNSXI4K2xraVE2?=
 =?utf-8?B?TnltNGErak1sTzU1R1RYVFJoWTFZdnl5VWVNeXBnWXR0bnBYSzIvMDBMSkJY?=
 =?utf-8?B?OHErZ3BJSDBHWWtxMXlHeG5yK1UvQ3hocmNIRU96MUFDbVl5eDFvVmhLaHYz?=
 =?utf-8?B?R0R4bE40aVk4SWFZK29xTkZkVi9MNnhWYVJSaStiQXJPQkMvSGdhTkJ0U0tG?=
 =?utf-8?B?aEJ1S01VR2hkalBSbkJHSDVZZWJiais5TDU1SGVJMUlzOTNWVzBoWklkRUVO?=
 =?utf-8?B?Nk1pSENNQVVTcmdFMUtGRHRCUEw0UE9jS3FJUE85Q2dNakdXbXRmTjVqekJS?=
 =?utf-8?B?a1BrMFkvWmNWZHg4MDczaXNMbzdhWWZHb2hQZUl2ek5MQThIUkJIb1NKcU5K?=
 =?utf-8?B?am5vTytpY09yVE84UDFkZUVSVlpZWWRteUxZT1A0anlNZEJ4dnhPa0RpeGM4?=
 =?utf-8?B?V2pSaDR6eVd4OHlVcnlGU0V5alBPRlF2QWpDZU8rR3lyTG02UVN3NnVHUnF0?=
 =?utf-8?B?SDU5TmJDa0JSN2FTeEcrRjVwRSthWSszTWxXM3NUQWV6dmRtVXZCYW4rQjNG?=
 =?utf-8?B?NzBWSWZjUUNWd3hWSFU1blR5WHZld2VpcUFBL21BYVdiUk9DZUNPakx0eWlr?=
 =?utf-8?B?MzdLcjNNUDUrWE0rRGUwNUluUmhsemZGTEtDNDlUL2xGd210akNCUTRrd0ZD?=
 =?utf-8?B?YTdZd2lJMkF2MGI1eGJMNi9HUHNoWFcwdlUxL2w1dFlNZWFIeVN0dFFVQXMw?=
 =?utf-8?B?WVVWKy9STEtKYTF5dHNYMXBHQjJFSm1xenhrWEEzVS9aUmg1cDZ2OFZQZDN6?=
 =?utf-8?B?K1YyNjZVSko2b0d2UHhiaUltR1hqQnArZ21oc2FPUkdYNTFpdlZqMmN0Z3Zl?=
 =?utf-8?B?L0p0UUFpY3dSSGdPbGFuU3g5cUJod0kwWStZR2lKVHlRcnFDWHNhYncrTHJT?=
 =?utf-8?B?VU1TRjZqNENNSFJiTTVudGZhOWZxRjJZMVpLbDhFZitNckxjeWdkek50Nlps?=
 =?utf-8?B?MGNjMS9jWjhlQ1BZaVprY1dML1NyT1ZCbzYwNkRUd1cxRGtLWUtTckZBVXpD?=
 =?utf-8?B?U1RWdThOeWFVL1ZNa1Rtb0JzMVBtbXRRSEhDTzFscEhJQ0pEUVp6MkNDSEpB?=
 =?utf-8?B?amh6V0dwMWZXOWw2Und0bkJBNnE3aUFGTlhTejhSRDFHTVd4cCs5djlDY01y?=
 =?utf-8?B?dkdyUW82TTBCbXlDYkJNd1NadHVwRVpOTitabmM4WWFCZzNQZld6U3J1Um8v?=
 =?utf-8?B?QmdDd2dhS0hKVTFsKzE5ekduT1IvZHpnbW1pR0tkZHhPZ21hSWd4T2FiTHFl?=
 =?utf-8?B?bTlvbmN2cVRibm1BTFNzWHdYWkxSdmo4QXZFdGcwMGt2R1dhYnZYZUNydzdT?=
 =?utf-8?B?ck9BM3l1aGRCVHhOb0ZyY0E0WTRxaTBvZGdJTk94VzFjT1RZaEFQR1Z3Z0Ew?=
 =?utf-8?B?V1VDaEloNlF5SDhmQlI3clhsdnRYNWZrN2hxbkkwRHJpVzBKeFpCQkRJNkRk?=
 =?utf-8?B?bXMxTzcvYTdGSXZRc3U2cjRLUG02OWdLZk1vVVY1N3ZDYlgvaFZFc3RNc1k5?=
 =?utf-8?B?ZG1mVUkrMzc2elF1M0JEQ0t1a0Y5RHVLYVkwdFdqdmtmOStIUkwybnlZRzhF?=
 =?utf-8?B?NTJkd3lDRU1Ic2NSV1FWTFFOM1h2UGdheFpCcWlGRzExcWc5T1UvNXpEcFV3?=
 =?utf-8?B?aFdFSDhPYlFFL1Q3M2hsZTlacmZRYnB2UUV4U0ZxejNYOU1Dc3MrYmhKWXJ4?=
 =?utf-8?B?VkR6ckJielR0eGR1MHNYTG8rNjkrSjVZa2htNWhuVjZrcFZicWpPQzYxeEQx?=
 =?utf-8?B?VFYvc0NXUmtWdlZObC9XN05RV1JDbVR0QURRVXpLZlVHOVEvT0JlRi9Jc1Z1?=
 =?utf-8?B?aUR6UGplL0o0WURxTE12d1dITW9vLzdFcHRSdz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:56:46.7572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51fd285-605c-4f92-9435-08ddda9b2723
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160

Hi,

This series by Shahar implements error burst period in devlink health
reporter, and use it in mlx5e driver.

This is V3. Find previous versions here:
https://lore.kernel.org/all/1753390134-345154-1-git-send-email-tariqt@nvidia.com/
https://lore.kernel.org/all/1752768442-264413-1-git-send-email-tariqt@nvidia.com/

See detailed feature description by Shahar below [1].

Regards,
Tariq

V3:
- Rebase.
- Rename feature: graceful period delay -> error burst period.

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

To resolve this, introduce a configurable error burst period attribute
to the devlink health reporter. This period starts when the first error
is recovered and lasts for a user-defined duration. Once this error
burst period expires, the grace period begins. After the grace period
ends, a new reported error will start the same flow again.

Timeline summary:

----|--------|------------------------------/----------------------/--
error is  error is    error burst period          grace period
reported  recovered  (recoveries allowed)     (recoveries blocked)

With error burst period, create a time window during which recovery
attempts are permitted, allowing all reported errors to be handled
sequentially before the grace period starts. Once the grace period
begins, it prevents any further error recoveries until it ends.

When error burst period is set to 0, current behavior is preserved.

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

The error burst period design was chosen for its simplicity and
precision in addressing the problem at hand. It effectively captures
the temporal correlation of related errors and aligns with the original
intent of the grace period as a stabilization window where further
errors are unexpected, and if they do occur, they indicate an abnormal
system state.


Shahar Shitrit (5):
  devlink: Move graceful period parameter to reporter ops
  devlink: Move health reporter recovery abort logic to a separate
    function
  devlink: Introduce error burst period for health reporter
  devlink: Make health reporter error burst period configurable
  net/mlx5e: Set default error burst period for TX and RX reporters

 Documentation/netlink/specs/devlink.yaml      |   6 +
 .../networking/devlink/devlink-health.rst     |   2 +-
 drivers/net/ethernet/amd/pds_core/main.c      |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c |  10 +-
 .../net/ethernet/intel/ice/devlink/health.c   |   3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  32 +++--
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |   2 +-
 .../mellanox/mlx5/core/en/reporter_rx.c       |  12 +-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  13 ++-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/health.c  |  41 ++++---
 drivers/net/ethernet/mellanox/mlxsw/core.c    |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |  10 +-
 drivers/net/netdevsim/health.c                |   4 +-
 include/net/devlink.h                         |  15 ++-
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/health.c                          | 109 +++++++++++++-----
 net/devlink/netlink_gen.c                     |   5 +-
 19 files changed, 189 insertions(+), 85 deletions(-)


base-commit: fdbe93b7f0f86c943351ceab26c8fad548869f91
-- 
2.31.1


