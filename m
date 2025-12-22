Return-Path: <linux-rdma+bounces-15154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB76CD60C3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCDE73016B88
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A922D3EE3;
	Mon, 22 Dec 2025 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYxz2blg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E442D12E7;
	Mon, 22 Dec 2025 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407317; cv=fail; b=AnOcX73VvZnJB4kpKvTD9ao5XeFgWKqY0AYQ3/hq1ZN3xpAh5zmSdvUsH6FSSPnOHqU0VhC7mIuqIHcUvpBTReipqep/lDwVKVrdblt6VsVgcaTNqLA5TjjVKDOnAYvTD+AWm79SGLAFcY0oO/Vnp5MQeNlxAAbP6gpLrJU0Ij8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407317; c=relaxed/simple;
	bh=gVsq0ci5JvyryAwIB8FZbu7GUiwIVh41Ennx7PDlcBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZHDqPcxRof+GgrkuC4y9bqhY5Q0zoTTYMP07jqb6ERO5/UshEmqvgjMLBwx8tgNrqpSGy5H77IFv/lAxcM1lS/IKXYd/WwFRh61HzWyIksz9qtiqIkx0mS0e8m0rGKCATdsCa1TNAMt8VTmoPZDC/PS3QMuz8LhR0xwrLbKNTWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YYxz2blg; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty/uOLaWy44uookuMU4ZeIRXByCNdxdWqTTIbIENQUtzvfC8++gvyBY3T4YIjuPLFRiC7Gp4jURknpTrWGnKVg+Xjf94RrGLwe2pPxkh4fm0/oUhBfB7K6Nt4L/ZUkr6JT1j2W7URdhtBycQSoD47GtISLCnCxPWffdiiIVAxyv0un+Fq8i6fsBBa7MFhSQbyjG3ZVahktjj8azdFneMiudhJlK1bOCQvMO1CRADeuon13uAdEqbBSF2n5UUv+UbBieNkJ4af8KmyjCcnL/01Pqoz77JbRrUQ0wSZNNyS44A0SpOyH0hEiTkSsGTsUIgr+gQ8LreIzMJB8h7jNx9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/BNhxrIs4tUBi9yFo6NtKK/VpLWKVH6+bCgGSgHlLw=;
 b=cYEskpeZx/XxMKDUMSPKIKz+GBTOnDi6JeQOCtrHqayJ2L9aC+P/R7/IGbmkAVgv98QjbGXf6Le9lm3R08KgTR24/QjDsyDcnbq5apnT4BfQEOZdGVQSGKfdY7vGF4MSMwj0V8UVCG5OQrryoKudJPIFomIR/b8z7T6wVfhW5bygPBO5ELc5YMpCstNqzW8f3QwxjpPlKNJ04+XmbSiBJPONu9OeXfg6YQ7PQcHXZumpT01lYa+0X2Cq1jRfNnbYv9kyZjRdh2VDgxkBxeLagznvx3TVw4piiACitkC44A1JkLKk9jEcKancYlmXKmWu2M+Kl0AX3dqRep2UxvaaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/BNhxrIs4tUBi9yFo6NtKK/VpLWKVH6+bCgGSgHlLw=;
 b=YYxz2blgeVhM6gWht55xmieyVuKhhRthxRqbUDZnqnuSSiTockllLOuZcobMnySDcfsUXez5cjmwcPNeScidzrGLCNAfMQXQqOJ4rMcnnk3NcufwWp/NbLtBcuEEE30ZZ6/hQsI5J30jk0nxh6owOOHodzorFrqwVPUDrFOhXOFvDj5YfFaMKhqahQIWErMVgiSNiF2FgYo/qVzWIVNL96a3Ta8ueuYxqJrmWIlFmHxoKFzYtbcelVG3TJLUWyK3cOWN21xuJAD8Pqr0b5PbDGmlk+vvS+2iAnH+9N0E9kJKqkgI8gHZLGzRsfggfOy9rdlNMlmmN0gHMfvmzTViaw==
Received: from DM6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:5:80::17) by
 MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.10; Mon, 22 Dec 2025 12:41:47 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::53) by DM6PR08CA0004.outlook.office365.com
 (2603:10b6:5:80::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:37 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:37 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:33 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:45 +0200
Subject: [PATCH rdma-next v2 10/11] RDMA/nldev: Add command to set pinned
 FRMR handles
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-10-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=5422;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=lRpPjhXG1A/Gv7d0oKJmLO3Ch4spMvtRIlLGkdnYVwM=;
 b=sbeY9ZC3WizBuKtEaDui8CBLOfmNGog/Jb9f4yulH8GkSfR5tepDkd5XFRGItaq3p/FGVm79k
 g2m2s4kd/PNBVOhphC7ujrCmd0erYAMUgrTOgv5JNQaC+etP7lO1RUz
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a16fc2-3846-442a-1402-08de415778b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTUrVi84blZudUwxcndOS29yYTJ4Uy9FY1YrS3dqRTVjVmliWFhnRzZ1M1J3?=
 =?utf-8?B?N0JBVjJUU0p4VExYTXZpZUozaVpVa2ZiMTBCUm95RzBpeGNVdWsrNWhGbnJI?=
 =?utf-8?B?UFE5V1RaUkkwcEZmNjRSMUQ5cVl3S1lJek9RTjFBWGNPWW9RYWxEQkNibkFX?=
 =?utf-8?B?b3FWNXYwQWdTRVc0YjBWUUp2dUw3aWxWQUNmblJFTlIwSFNSaXA0S2VPYjVT?=
 =?utf-8?B?cWl6M3FKZHk2ZStYaUtqRjN6N1dteFdTM29YVEkvWDhFemV1bkRvU1JpN3hL?=
 =?utf-8?B?NEp2czA4NHZxRlJGQ3dZbUkzekovVlB3bDhTK1AzWExtM0lEL0tMSUg3cGdl?=
 =?utf-8?B?c2VGL1k1VFVodzYrM3ZGTGlrRG1BUjdtQ3NhSk5pd1IwaGNoUVpRTmZ1MmVv?=
 =?utf-8?B?Qm1iemtXd2RlVEhUSDc0MzBrMHNUaWpMYUQ5M2ZZZzhqNUhSMXRLSDJVWHFm?=
 =?utf-8?B?MjdoYnBOUnYvblFyRW1tOGlNT1BFd1ZIWFVUTDh6N3hTb1dWdG1nY2lTK1E1?=
 =?utf-8?B?ZjFVZWxXeXpSWEJ2YXBwekxVNDF6UGZoaGUrd1dKaHNseCtHZkdHUTl1bVZh?=
 =?utf-8?B?amN2Tk8rMHdQcGpYQW9VUjFKTUtCRWRHc2JxMUdDVHRCMks4cHI2UDBaVS9C?=
 =?utf-8?B?by9kTExXZDhkS2p0Vm5aN1g3R1d2WGUvOXZZRTJ3cTF1MTJMMVJPRmdZeEcz?=
 =?utf-8?B?VHN5YnBWTHV4NXZuNUtYRFJncCsyVi9nQ0pTODI3WDNEaHhoRWlHOG80YUJp?=
 =?utf-8?B?NWdsTzMyYngvclRnMGRvQ3I5VkRXd1ZscGdPN29zamNCcTNhSG42amJnVkc4?=
 =?utf-8?B?dHBFOTJHa2FWNjE0Q1QvZGVjdnVmSTF1ZG5BMWUyb2hYekxFUTdmOTBGTVl1?=
 =?utf-8?B?cXZjSmhwYkk3a29mU3RZQTdoUE9DVWl0L1FGbVRrdFhRNStwYzZsY3ZXYkVu?=
 =?utf-8?B?L1JXMlgzUjM2dDFORkFET2JnS0l2Qm1QdDR6dCt1YVlwNWVFUzNrSEVtWllx?=
 =?utf-8?B?VXBSakZEbFNydmdXUndNd1lYano4VU9XeXE0b25udHpXS2pFM0p3Mi9oZzZ3?=
 =?utf-8?B?RkdWVVg3SEF6YWozRHNMNE5DOSt2RHFEa2xYU2YwbnNOTlRQTXl3U05LNUh3?=
 =?utf-8?B?MnllMkc3Z3ZhdkVYcCtuQmxmcTJPV1E1YzltUVBCNSs2WGhDaXF5YWR5YldR?=
 =?utf-8?B?WkVpamQwZW9jWExkWXowSmxPVTJ6L2RlK2ZxRnoyYkVuR3VWTWhTbHhFSnEv?=
 =?utf-8?B?NGpDVjdkT1BuVzdvSy8vVkxOQ01lcHk2dEhOWk1XbURKNTNLNVZCd2dOeWZz?=
 =?utf-8?B?Nm9jMEJuV3E5ODZLTVpGVnhLV2FMc2xSbUUxVVJZaUdYa0JzQkRqY21rWUxO?=
 =?utf-8?B?S2xxemVoaDFEVmpNUVd1TGVKVUFkQ1VQOFhJMEJJZi9ydGlCejhLaWhJUStQ?=
 =?utf-8?B?em80VDFXM1BNLzU3aE84eGtzbnY1dUxuL013VWlCUFowRmQ5MVZlWHJWWVpv?=
 =?utf-8?B?dzNlNGRoZDk3OER4MUF4RUtSdWhycmErYndGZ2p0cmJzelo4ekt0NmNQSDQv?=
 =?utf-8?B?MjdZbElYRWJxSk5PNitHQzlpSXRNenZnV296a2dTdEhkeEQwdlg1S1pvZmtq?=
 =?utf-8?B?SjFDR1BIYmJSRzM0S21zTHBXd2JvK2d3OSt6cmU4Q2lFN1RzOE9XY3E5cDE0?=
 =?utf-8?B?aVd2V2hDTGpUayt5V2xWREpya2FacStZcmNlRGhHUEU2N05wS0NXaVBvRjdp?=
 =?utf-8?B?TEZSVnlQcTR1dE9XNFdQT2NLY21zN3dJVkM5cTZtMEEvemhEczVhT01sU2lk?=
 =?utf-8?B?YTU0MU1PejN3eDNoM2kzQ1pEczMwa2FadUdHUzlCbldYSVNHdTJ1ZG9xUHIy?=
 =?utf-8?B?SjIxWGoxK0FZTTV0N1FNbUcrNVJDS1dqbXQzbVAxTWxxdnRvVzlibG81b0Za?=
 =?utf-8?B?Rmt1Q2pxQVhEOGNmTXhJRmEvV0ZaNFNxK09KSDB0dHNDV0lvNndqNkhxVmg4?=
 =?utf-8?B?dWV3MFByWHNveDdwSXZ4eXI5ZGFQWDhjR29tVVZydGwvRXJ1MnVQSVFjRU5F?=
 =?utf-8?B?T2UwRldmcEc0NVhvRUk4ekUxczVNUG9rbDM5VmF5L21ISEFPRloyVXphd3B4?=
 =?utf-8?Q?s/8VA6sQguoGSVs82HTwF3V1s?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:47.4131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a16fc2-3846-442a-1402-08de415778b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to set through netlink, for a specific FRMR pool, the amount
of handles that are not aged, and fill the pool to this amount.

This allows users to warm-up the FRMR pools to an expected amount of
handles with specific attributes that fits their expected usage.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 88 +++++++++++++++++++++++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 8d004b7568b7..0b0f689eadd7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -185,6 +185,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2692,6 +2693,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
 			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
 		goto err_unlock;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,
+			pool->pinned_handles))
+		goto err_unlock;
 	spin_unlock(&pool->lock);
 
 	return 0;
@@ -2701,6 +2705,54 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	return -EMSGSIZE;
 }
 
+static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				       struct ib_frmr_key *key,
+				       struct netlink_ext_ack *extack)
+{
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
+		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS])
+		key->access_flags = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY])
+		key->vendor_key = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+		key->num_dma_blocks = nla_get_u64(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+}
+
+static int nldev_frmr_pools_set_pinned(struct ib_device *device,
+				       struct nlattr *tb[],
+				       struct netlink_ext_ack *extack)
+{
+	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_key key = { 0 };
+	u32 pinned_handles = 0;
+	int err = 0;
+
+	pinned_handles =
+		nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES]);
+
+	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY])
+		return -EINVAL;
+
+	err = nla_parse_nested(key_tb, RDMA_NLDEV_ATTR_MAX - 1,
+			       tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY], nldev_policy,
+			       extack);
+	if (err)
+		return err;
+
+	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+
+	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
+
+	return err;
+}
+
 static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 				       struct netlink_callback *cb)
 {
@@ -2803,32 +2855,46 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 static int nldev_frmr_pools_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 				     struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
 	struct ib_device *device;
+	struct nlattr **tb;
 	u32 aging_period;
 	int err;
 
+	tb = kcalloc(RDMA_NLDEV_ATTR_MAX, sizeof(*tb), GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
 	err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1, nldev_policy,
 			  extack);
 	if (err)
-		return err;
-
-	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
-		return -EINVAL;
+		goto free_tb;
 
-	if (!tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD])
-		return -EINVAL;
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
+		err = -EINVAL;
+		goto free_tb;
+	}
 
 	device = ib_device_get_by_index(
 		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
-	if (!device)
-		return -EINVAL;
+	if (!device) {
+		err = -EINVAL;
+		goto free_tb;
+	}
 
-	aging_period = nla_get_u32(tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]) {
+		aging_period = nla_get_u32(
+			tb[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD]);
+		err = ib_frmr_pools_set_aging_period(device, aging_period);
+		goto done;
+	}
 
-	err = ib_frmr_pools_set_aging_period(device, aging_period);
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES])
+		err = nldev_frmr_pools_set_pinned(device, tb, extack);
 
+done:
 	ib_device_put(device);
+free_tb:
+	kfree(tb);
 	return err;
 }
 
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f9c295caf2b1..39178df104f0 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -601,6 +601,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 
 	/*
 	 * Always the end

-- 
2.49.0


