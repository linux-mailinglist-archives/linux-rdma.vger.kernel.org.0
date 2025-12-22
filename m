Return-Path: <linux-rdma+bounces-15156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87574CD6123
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0C133031A6F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398B2D837E;
	Mon, 22 Dec 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DYUtsu7J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902B261B80;
	Mon, 22 Dec 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407326; cv=fail; b=PP2/hVPL59NEzaqQ4k7cmpKF6PDoPZu5edHuDMlORIOmPaumcUcWzNzPmyhGcdd28pgquurJYTH+EMRbaZTHJEkl8YNDL8bnovCuVDj3QJaKwEcYPhehDUbKb0xgsr2Z3tl0uTZ6MXf41IMUECdm+u6V8AiN4mntM9+amVdkRmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407326; c=relaxed/simple;
	bh=JSwKEmFOSXPzMg6Aua6DFGbGBSOZqQH0LdTX718llTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fPrn0GmDiEH86cpFZoZ3nTKxZH0ubNZVnMbFdb0M+bzMQcsH/CMGu0LmwuUIhsgFwUG95+FO3pq1/Ef6d+/FgE4t0In7tRbdZHCBgJCPd1FYWlyhVhb2CO8j5CjuDvYvXJpwdLHM5MCD4fznBPBfjsHailabunJleqGtQK4qsvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DYUtsu7J; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGynee3TRCk2VQ8QkxixQT14fMkIuFJbiHw96eLsDowiqUZxbIVAVaTL5MFzBAvJXk/ZCj9GXLUTR9KCaM6ogcvZWUHqDL31jK+TPFZWDvkOLkGGpuEnSUCjrI0iJ7vz0iFH5kHslkGpp6C6/Bv7dCLZ8UF5Yeb7dpQTXZcZm2cwGal16fuGcZZk48g2dLkLrsZKejyh5Mz8Y02JPeJ08s91ksF6mwy9Q5HwP7iUlpKmO14hwLJBDXMtdyj+XCd0MFxDrop3+UwirMbfu7tyw/MapsWKQZTeH+4pQHDFJRX/hyYW3inPX50GM1L2BqAuvwvZnkjsR7BbXUehlxMR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BafZA3HaviQ2upObbts8XNgfftmjQ8d7QTAI/ZyGq0w=;
 b=oVvzhmVBQdK7XZzt71/qhItZcT/VF2jyq0kbPTr85G/GiDnyDwId4t7DTWb2QRHqVIXOnRTDQzmLlFbyNkKbrHaV7dvcivSORC94yLZ/QR04tz3QdeAM97iLP28tDKjDjDsJmLHsl7O2lBq7Ge1aPFzGA7hmee2f/q0rBA1hlzIkzDGgfDc09TLE3kXzwmwci4cx3YfoHmsk415S+j0pnGi5mH8QZQqnayq00c/0M1b0WFv6jZaAHfoa4bRRPacLIgVnPe+c3L1yPqfGXHzK2DRMxnCVeheuAMb/cX4l7V/KmTqoMxKM+5ONfIEyQOPutn38WyZABIYhrTNykew79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BafZA3HaviQ2upObbts8XNgfftmjQ8d7QTAI/ZyGq0w=;
 b=DYUtsu7JmOqy/HVvckSAeV6/aE/fylTqNlnw7gMq19lcZGKdUVLi5Lgp6sElSDds54tvUBrtYF7YSCcBcfqDOy/GW7drgu7jnFsfLAsctCn3XyTRUDXszuoUidh8frr/E+H67dkigWXs/U8sL/rnhXveNzwfvrrp8zbfKR3xNFcvCgks88Q22O7bZyhagLOm850I+UYWWS693ek7pPxJz00CkqagICvocqTW1xVRC659ViyjpW06z67RE/3BRpnklT3x2k4m2eOa9GpaYjoVWy7iOgg5L4qWTn97HHp0+Uk1AtXs2taw482cvwxyl6FKhY7IrSPbU4M+Qv9hVA2IMg==
Received: from DM6PR08CA0023.namprd08.prod.outlook.com (2603:10b6:5:80::36) by
 CH1PPF6B6BCC42C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::612) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 12:41:56 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::d9) by DM6PR08CA0023.outlook.office365.com
 (2603:10b6:5:80::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:41:41 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:41:37 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:46 +0200
Subject: [PATCH rdma-next v2 11/11] RDMA/nldev: Expose kernel-internal FRMR
 pools in netlink
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-11-f06a99caa538@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=4321;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=kG5ruq2pgQj9fxhQgU4KqzvS0DcL+ea/razhKhMwku0=;
 b=cC2P+hbCshqu2Hk4EesQnd1nN5xrF37+eAGlZ7n/8PmQOQeAjy5ZHtw3EUKUffp9B60UNjvKs
 FhU0YR8+6W3D/bRH85+P1xf8Fw4mhJalWLERwVRyKVs8ehMY0aRJiTP
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH1PPF6B6BCC42C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db2652d-b3d9-43b3-978a-08de41577db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlZJUHNFVDdXWEpldWJUZ3pjc0k1alFOM296a3EzRVNuRFFaS2dBOUZ6SVIz?=
 =?utf-8?B?MWdmamUrUEJIZ1VqbGY0SDNQeW1OSDN0YlhEei83TjYzU3FuMU8rb3Q2MVNM?=
 =?utf-8?B?Y0t0b05WdFFOTHIwQmVlYkxFaDFsMFZVUXZYR0pHOEI0VFJOdG9TMVRuSmNv?=
 =?utf-8?B?UTFwYTg3STJXc0xobWlsanlPZGVveHdISDk4VTBKWmdsY3F4dExvYnhKU2Yy?=
 =?utf-8?B?eUp6WGVYSzZWV2RyQnBOcFQrUDJwU1F0L0ZWYXFNU20ybzBuc2RQQ3JMSWJM?=
 =?utf-8?B?aURYTXpEcW1XVENkVzV3NmZocFJYQktNV3k1M1k0QlhBZnlLYTRqdGtTT2wx?=
 =?utf-8?B?azNvUjl2dUZ5TWhHWlpZVGEyZ3R0bzUyQW5QbHAySDdmVWJ0czZYMWk4a0xm?=
 =?utf-8?B?TE5Ua1FBUkdSMVJRbEJJR2hGakY4V09McmpqV2o1NFZ0VUlFU2ZpMXcxYTY1?=
 =?utf-8?B?NnFUbVVJZTVyU1c5UXIxRFBGQ3F2R0poOTA5NVVqdm14VWMvN3RoWFRucEtF?=
 =?utf-8?B?eHdRaFJIcGwrRENGSlZzblBVc1VlZk1pc3JZK1A0N0d0clNLWSsxdURtS1dN?=
 =?utf-8?B?SEVqRGpYMW1rckViNG5NWDREdDFWMmpXZ0cyc21TS0h3S3Z4alZUNUR1bFB2?=
 =?utf-8?B?THVDdi9odUE2Mzh2K2xJUENrelpOMEo0ZzlibXJXdkRBU2dwekxLNzFJNFBK?=
 =?utf-8?B?bS9DTFoxY2tORldSSGV5MHpFNFMwY29PWmVBd2JYYjZjRXh6NXVCSUZ1bU9P?=
 =?utf-8?B?TWxLZUpqY1VGSFNRMWZTYkp4eTgrN2NBaGhncmZYR2ZLbEJ1Mkc1V1Fmc3NC?=
 =?utf-8?B?M0NPTWdvdDdPOFNBWjRNZW1nYktkSmEzREpqcHk2QzlMcUcvVllYMXl1OFpN?=
 =?utf-8?B?SGNiUHJxUmNVaDBJWFVOSUN5Rm5jMVM2VUNnSVdHK2VlTWY5ZkluRERyczR5?=
 =?utf-8?B?WjhsZjhWZjRKM3FLRW5nMm1YRkNvSk9Uc080WFVJM3J2a3NvaTlTNFFFTW5n?=
 =?utf-8?B?YitzVHpmbng2WDcvRmVlQThQUTlqOWVJb2c1cDFlMEZrT2I2aDAzM0k3bDhM?=
 =?utf-8?B?R1Y1TkJBZUhKNDdvUFVZWU94ZUNHNG1INm1GVEozSEgxV3ZwRE9ra09FOGFN?=
 =?utf-8?B?ZEZxOFNXendvN21INHJNdkYvRXl1VkNBVTFxMFB5Ty9yeHMrbGhHRXJSQ1JE?=
 =?utf-8?B?SjZnWHI3TzZ4WWdkb1ZYandmdERJQ0x2T3RscVBtOFNLSE9Da3QrNWlWUmJB?=
 =?utf-8?B?SmxRd3BIdUkza2JIdnZJK3R4bHZjVGlkN3F2L1BBZXc4SVhhbVpYblNKdTQ0?=
 =?utf-8?B?M1ZLSGZMSkh5NkJBSGE5am9HM0hJOFJHeHhVeDZYS1kyVUc1Q25jbGwxaVFF?=
 =?utf-8?B?eVV2WFU5NWIzSS9YdmJFdkdBZGo4MjJSVk1BdnNkckxBVW0vd3ZzWHZ4S3Qy?=
 =?utf-8?B?UXhXb1JadlFYWHZIRjF1YWZvRUYyT05aNWRPN3BUNnZvQ29zZm9IMzFyeWdv?=
 =?utf-8?B?SHpncDlhaEJ2aWhKTmxlWlRLckZENjAwM0pEUXF0T2dENWloLzRMdnc5MUIr?=
 =?utf-8?B?UldEalc4L3VOR21aeWFtT2VxYjhWWndXSzBxTENXeW4xTE1KTWNaSE1SWndU?=
 =?utf-8?B?UCtzQWU3VlFqYzZBRHZrV3drY0NHUnNYNFplWXkvSXA4bEpwYTFWWXRrcXJF?=
 =?utf-8?B?c3FidXBrNFZhbHRGR203Y1NJWkgwdzBIRER5dDAxMkZQalBUT1ZTTFB2Z2Jl?=
 =?utf-8?B?YlFTcnhQRktTNnJMTmNodUlhZDlSZjk4VjBBQjQ5WmF3TS8xS29TTVBXMXRB?=
 =?utf-8?B?VXFWM3lEWm02YWV6Z3ZlVU5oa0Z5eU5YdDl4UkJ2WTYwK21NN0lia0x2bG5w?=
 =?utf-8?B?R1FlcGNObmpDalBSL2dLQ0xJTTdrb1VkcHpTeGFEK0pwUmZlY3ZscnBSdnE3?=
 =?utf-8?B?R2FXeDJVRDc1aGtYMHp4eVQ0eTdzSi9EbGtOeHNsVTZRQll3cW1VQzUvRXgv?=
 =?utf-8?B?bXFlTks3ZXdsdEVNczhrNkI3MXFCczJoYTRqRzMwZk55cVJZbVNCRnRSZnlW?=
 =?utf-8?B?TDhVenNYaUtLMm5XMVVOZDdtTlhUMlIvUVUrdUFwYmUrN2NxRWRpdzA0eHVD?=
 =?utf-8?Q?BDgPFLLaDJra6uuIAt2YthGPp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:55.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db2652d-b3d9-43b3-978a-08de41577db8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6B6BCC42C

From: Michael Guralnik <michaelgur@nvidia.com>

Allow netlink users, through the usage of driver-details netlink
attribute, to get information about internal FRMR pools that use the
kernel_vendor_key FRMR key member.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 28 +++++++++++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 0b0f689eadd7..80b0079f63ae 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -186,6 +186,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY] = { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2671,6 +2672,12 @@ static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
 			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
 		goto err;
 
+	if (key->kernel_vendor_key &&
+	    nla_put_u64_64bit(msg,
+			      RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,
+			      key->kernel_vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
 	nla_nest_end(msg, key_attr);
 	return 0;
 
@@ -2705,9 +2712,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	return -EMSGSIZE;
 }
 
-static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
-				       struct ib_frmr_key *key,
-				       struct netlink_ext_ack *extack)
+static int nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				      struct ib_frmr_key *key,
+				      struct netlink_ext_ack *extack)
 {
 	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
 		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
@@ -2723,6 +2730,11 @@ static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
 	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
 		key->num_dma_blocks = nla_get_u64(
 			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+		return -EINVAL;
+
+	return 0;
 }
 
 static int nldev_frmr_pools_set_pinned(struct ib_device *device,
@@ -2746,7 +2758,9 @@ static int nldev_frmr_pools_set_pinned(struct ib_device *device,
 	if (err)
 		return err;
 
-	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+	err = nldev_frmr_pools_parse_key(key_tb, &key, extack);
+	if (err)
+		return err;
 
 	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
 
@@ -2762,6 +2776,7 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	struct ib_frmr_pool *pool;
 	struct nlattr *table_attr;
 	struct nlattr *entry_attr;
+	bool show_details = false;
 	struct ib_device *device;
 	int start = cb->args[0];
 	struct rb_node *node;
@@ -2778,6 +2793,9 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	if (!device)
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_ATTR_DRIVER_DETAILS])
+		show_details = nla_get_u8(tb[RDMA_NLDEV_ATTR_DRIVER_DETAILS]);
+
 	pools = device->frmr_pools;
 	if (!pools) {
 		ib_device_put(device);
@@ -2803,7 +2821,7 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	read_lock(&pools->rb_lock);
 	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
 		pool = rb_entry(node, struct ib_frmr_pool, node);
-		if (pool->key.kernel_vendor_key)
+		if (pool->key.kernel_vendor_key && !show_details)
 			continue;
 
 		if (idx < start) {
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 39178df104f0..aac9782ddc09 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -602,6 +602,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
 	/*
 	 * Always the end

-- 
2.49.0


