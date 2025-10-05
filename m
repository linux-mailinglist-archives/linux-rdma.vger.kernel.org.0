Return-Path: <linux-rdma+bounces-13776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5B5BB949A
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Oct 2025 10:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8243118985C4
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Oct 2025 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA01F0E56;
	Sun,  5 Oct 2025 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wc6DLJ9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE689187332;
	Sun,  5 Oct 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653052; cv=fail; b=GkQvDFypiHcLMGYjIrz0MD8Tglto7Y1VEypB6bOidXPSbkPvLnUv8bN6r1noYJnwXjac+GmHFsLhM5c9yKxq9NZSsDtYO3gVDKmA1QM0/1ruE2XfXai4C2jYuJ1JJDDT0xyTkvUZ29GLRG61lwFKwk2MdCciwSsIkqGu2BPG/Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653052; c=relaxed/simple;
	bh=4isaCLl6t5TtQ7zzquIwd49+MKEhW/iBHJ+kuEpaanA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NB/xJfaOvWhlrmb9+hY5B25eKD0AubmuzCtKV9hPYMpHz2hKqoM7kryFKXcQqFWbIICreFHDHIdMu3z5j9NJLM2PT8VrWw/W2Ee6Q4Acy2WADPvxrAsqm/jPQwHqM9Q5Wg2sF5mDn3Afi8N3k/iRwuB4Futt6T5bA0dWZgu+2yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wc6DLJ9a; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9SwsjO9CFXVnqM1HAMaJHqEz4Brt+mJD0XvnfT+6fioKdHCNvWyiqsgWhri/U/Cc0AF7PFOm9extnXFevlSZ7SNSDxIOYaDeh1xg4bzN31JgT6+isJByrs2AoheIKbGemUde6OfbXlZr6hjrqb0yfBN3u/6KlrvGXkh56RYZmL6qiTU1QLm0nrGRKnD19VujEcz6QBHeVhxogDztJuOEmZlZY0EYBjuffuKB3za9QcrY8z6rUxtkctGRRI41GsOyvKzdlWxrid6ENprsQrj7roY2Df8CeAHa91dToIXjkXzVSKdI3Xr92fvw9+lIzhmjs1znQyYDpapY23SU7aqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g35MD+I5ubKSKECDCL8h4aoauxxSm5NKYfUYbR7q/vo=;
 b=RDlukUiS55WQjDDGbuUwWvMvm5VpJKwCqS8GBs3ynEy+18Qvya1+/LQhxzJP4T+uogVz6tCcwXQ4Weguumc0AZwmEfkBqxXJOD1kHOZW46IoNkJX4H5xqNKcIVXB0p11T78xxoFulWqDaOOq1QemyOFhxCVbpNs0dJod+vrvVDEtqKnHVczGqjo+tQDZAL9T4DqrQVHgEkc9kKTozfurFGYuFVnjdyjZvU7gMURIrC4oheJQHqEh+e7REU76mjSdGfa96bi43ZlyTnlqR7rsTW8ZA+osNZDU58QOyieN8TUu2osopf/ApFp8ltAVoWlCRYR11BrJj0+YtdBBJOHGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g35MD+I5ubKSKECDCL8h4aoauxxSm5NKYfUYbR7q/vo=;
 b=Wc6DLJ9amWNNCdX1yECx7ncbcknybXZ1O1yH0lhA46Xpj4OVuYhnF+x7xVq1jKnGyGRvC5MvvUSM94C90HnQEU5jm1nL/dsdiSpguKdfR0mhOxsf/sNW1Mgtwp9mRBmbOpsY1nMrN4HHpRmwgTB3IMDr+7dnjjSRapMHhjlb3lRkRnUCv4rhtFCyXH+p5XM7EhRktv0PgSCjbH6zaNeijaFk4PBCI9orKQCd1dk1eckEMS2hEad0IdDzh14MAboGDT6Dh+CzA+K4+LIPoiuVxy2H87k4WAQEc0PpeBbhRQ1QoByVkVeZQV8OKcUOT8td7fmmXGjHFMqLsNcX72lzDA==
Received: from SA1P222CA0113.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::27)
 by CY3PR12MB9653.namprd12.prod.outlook.com (2603:10b6:930:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sun, 5 Oct
 2025 08:30:38 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e3) by SA1P222CA0113.outlook.office365.com
 (2603:10b6:806:3c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Sun,
 5 Oct 2025 08:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Sun, 5 Oct 2025 08:30:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 5 Oct
 2025 01:30:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Oct
 2025 01:30:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 5 Oct
 2025 01:30:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 0/3] mlx5 misc fixes 2025-10-05
Date: Sun, 5 Oct 2025 11:29:56 +0300
Message-ID: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY3PR12MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c59e9b5-d93b-4c27-b36a-08de03e97659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bytPYmUwbXkyN3c0OFJCcytMdGdQU01LemR2ZzdVdjAyZ1VGTWM2aCt1cDAr?=
 =?utf-8?B?OEFqZFd0TTNhbGR1NktBTHp0TittWjdvOHlzTmVmc3dlSEhhcEpyd0N4dXJH?=
 =?utf-8?B?LzZkaDh1dmZiZk5HbUhrTnRhb0dFTXloZVhHcXhxMEJGOCtFNFIyUjB5ZnRY?=
 =?utf-8?B?WlgycDZ0bS8rL2xIKzZTeWhodUgxNEFkdWRWTW9NQXJqV0FVa3hZQU5kVTk3?=
 =?utf-8?B?eGVMRDlBYk8yc094SVZxZXg4S01NZHlGdHRQVXpxSXdkU2RjUWJiblN6UDdv?=
 =?utf-8?B?aTd3TVFQNi91V0lEcGhsSEMvT3JtZjZ1YWNJRnZJVUJ6ODdrbGl4VTJ5TFk0?=
 =?utf-8?B?eDFGVm1mVDZpeWRyQjdUemx6NTNNakh6UVdEajNDMkdreTExdEMzVHRjV0Zn?=
 =?utf-8?B?VkFWOGluZjZEbUt2Mjk2N203Q2NxeU1QekFlbkwrdCtldkpOZ0FhRFQ1MkJj?=
 =?utf-8?B?Y1FFZi9iNlZpV0JtYlhVZWVmZXk5UzBwZHhMdGRwVEhocVdOZ0FIWHZiRFVF?=
 =?utf-8?B?WFgzSHRPQ2p6cGhlZ1hyTUsxVHJ3WU9VLzdYZHFuN0IxVDNHM2N0eEhSclVW?=
 =?utf-8?B?eGFIUTg1N1lvWCtTMkxWU2pMYTNqTGt2RXo4aDk1aklXMjg0MVoyVVI5THdM?=
 =?utf-8?B?cHJnU082b0FEMjdUaVF1aHVIYVBHRlVSRU1LS3NtNU9FUndGYjZ4SS8wRzAz?=
 =?utf-8?B?MDF6TEZHNGsyMmxlVVNRcVVZMGd0dkVTM2RZeXh6K3BpWTh0ZjFOQkxzcmgx?=
 =?utf-8?B?QUlQY3VHd2RYZTdRY0JRZWVRTE0wSDlYR0xURHNRdXpFVGNidEJmTFlzSSsz?=
 =?utf-8?B?MHpSRW1ubElHOGlob0w3Y3NYblB3dzhMUkJwTlZ0ZHdvQnd3bi9MdWJTL3BY?=
 =?utf-8?B?K0t4WFAveW5ESTMrQTRraTRKcnhkVEdtWTRBaHgrVUJ5b2RtQnI0bHFCeVpK?=
 =?utf-8?B?OW5uZ3RoU2hFSEh4TldSZEpxcTFLaWkrRy9mdnpOV1RqSTVEVk5RZi81WSt1?=
 =?utf-8?B?SmxYRG5sY1cxSkQ1aHVOUHFOb2JrSGxJQTlUZG4yRktMNlU1U3k3dGZucnJO?=
 =?utf-8?B?QUM0akRJOUtYbnRLbTQxOXhOMDVjbXNkTWROcTVTeDQ2eEFpajVhakR0c1ZN?=
 =?utf-8?B?SVU1YzZjeCtEbzcrckRNRHF3dmRoQlhVS0hQa3VLK2hCRzcrODRhTTdOa0Fy?=
 =?utf-8?B?WXBZTlIzYmswOGJXdnp6b3N4Rmp6YlhYYTFhMDVvN05sdHZoTDJGb1o5RHZw?=
 =?utf-8?B?SW9nalN4SkFoNnBBeUlNb1RYSUQ5ZTRQbWh2R3VzWDdPZ1BLZUVtNTBSSmhx?=
 =?utf-8?B?dmo1WWpxc0N2dWwweVFvQ0RwM0F6TUsxOXMwWVpSR0VuZ3BhdGJFN21kYlF3?=
 =?utf-8?B?KytIYXBSOVFjSkthWVlhaGwyTEVPZS9QQ1hLTXdQTlpQZC9QenlIRGNVMFYr?=
 =?utf-8?B?U3dVRXFUcS9vZ0tJSU8ydHFrVFZJelpaVkVWN0FyK3E2cnhMZ05SUUI2VFo4?=
 =?utf-8?B?OHJneXA0WDZxUDNwZEFaOVB1TFFYeXVUdjlPS2JkNHcvMDRnUGI3VW5oNXVH?=
 =?utf-8?B?UW5EZHNOeEQxMXJ4SGwyb0dMdUpIeUpWNmVSMGVONXd6elE5SWZBL2dNOG5p?=
 =?utf-8?B?cHNNVWE2ZERxM1Y3QjZWeUZ4RWEySi9vVldyeWR0QjAvS2E2NnRKUkhEdFNN?=
 =?utf-8?B?L2Z1K0o1VmxTenNic0o5cEpNby9Yc0pMaGhreURObkFpS01sSWJmbmVsNUU1?=
 =?utf-8?B?Rm5hbHgyUHExb3B1TEtXSFJnMy9zV3RUWmpDQlQ0N1g4ZkorK28wS2hEeXFW?=
 =?utf-8?B?SWFGZmlpcEoyNnBTVXBlV2VtUzJ6dTBMVzc4aW9MK2RmREtGZG44dWhNTHFO?=
 =?utf-8?B?MGtqRzExcGd1Q2VEUUVQcXlQTjEydWl5cFdNUUkwMUNPWTFnVzB2NUtRRW1K?=
 =?utf-8?B?RUcyQWpHbnBjVWh1bWNKUjdVNzRQbC9lSWZidmROVTNJeTJxWFRKa3phTStl?=
 =?utf-8?B?V1d4R1RxRzZUc1ViRVFmMFpQUWVmODYzMTd4Ni9UL0ZrUGNHcjUwQTJ3czAv?=
 =?utf-8?B?QzY1Rlh3SXVLdUJ6ekFxKyszdUxRU0lqM3VueC9QR3VJck1DdjRjMTN0NWVU?=
 =?utf-8?Q?NknM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 08:30:37.9867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c59e9b5-d93b-4c27-b36a-08de03e97659
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9653

Hi,

This patchset provides misc bug fixes from the team to the mlx5 core and
Eth drivers.

Thanks,
Tariq.

Carolina Jubran (2):
  net/mlx5: Prevent tunnel mode conflicts between FDB and NIC IPsec
    tables
  net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed

Cosmin Ratiu (1):
  net/mlx5e: Do not fail PSP init on missing caps

 .../mellanox/mlx5/core/en_accel/ipsec.c       | 38 +++++++++++++------
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 32 ++++++++++------
 .../mellanox/mlx5/core/en_accel/psp.c         | 10 ++---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 18 +++++----
 6 files changed, 67 insertions(+), 38 deletions(-)


base-commit: 1b54b0756f051c11f5a5d0fbc1581e0b9a18e2bc
-- 
2.31.1


