Return-Path: <linux-rdma+bounces-4448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C665A9593E5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4764D1F23536
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36442599;
	Wed, 21 Aug 2024 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGuObAWW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2B15C147
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217062; cv=fail; b=Kfe0JMBRzhi9IcGGY5pc6b145vEG4GRaznU9X0Xr8KqexE1WtU8kSJWYAGe2I09NWMwJ2mzvehs10UlwTxMe7zfeXod3vYIa5JK4CYLbglZHJWiKwqbqwut9Od8e5pmKP85Y9U4yxzlleklBJxL2gAcZjwksQelpSUwidVNeogg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217062; c=relaxed/simple;
	bh=N5N9RtHvWbeo6ygR5laGlujSR+F9dMK8fFaVo/VU7vU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdCnoh88M/oztPURIeK9aFrvvb621JJcwpnezgvS7rwi/d10XZe3qIFbSUWzBWx1J2OGqkvt79XuSIWTy7DK5tRDr6wOqcWQBEI8Fhtdzk/il0ZgyERXx1fUuoyaFcX7RWYFeC1fZHqhndB1oU2LORkCvltq7VJPDWBAKj1omU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGuObAWW; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS2dclc78I69N+bx0m0KV4Bi/5X0Vdt3mSeBR2GblaUReGJkHaavXpDIPji8GdJfRnv5/d3DDaiusBY0mBjZQy24p5gj0gAnbyB4O1vdxdpyHzRytBWnTUnwAL0E17giGh+glXYprQivW6V6wbm8ZxCW6Xpf4vWE8dIoOniKGNAaiNsdZ2ep5XAyR/+kMhPobuKhES+WUG1ARXwLJKgkTbUWqMMheSrmhsc4hNK2rWMr+UNs2+K91bTSXd4L6OpBofYer8+qCToRjIyhkye7DSWklnhfQwrJLx+kkCiDNt9+fqvvmpM54pX61WaoYpIz47/noybCzXoKIelzNmxVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ25i+eb9lo7wV0+iYrzEvPiqzOfZKgJGs+Nv1lyJ/A=;
 b=TP4jMw0iPj1IbY0E4TuRZRP6o20tc2P1ZMKKD9nrRccT5YLYQrGXQlqvZSbc1IR/PvBYiyrf1pfO1UIY/QbXvsIj3jME2gWFJhMsY08D33LEaEpYOi37S2t2BEagYTSSUxC/HgXuKzEfSPDVXZ8r7VKYb6vPkVMCqflOOqpIm8uuh6rYBYAhhO4a2vY0QR7bL8vVBrsEJq8c2mh1l9egcNaecnjSB6i5h3mBsrz1Q7dfbvBf4xbYlN1oMC+D6i6JTnWZ7XOnbOwNEUEldYCwk4LjBq23Fui5FpIB+kfWmAXDqz7Zka/ibBu+9LmS0j3C9Ixd78havbakobuXOt5gsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ25i+eb9lo7wV0+iYrzEvPiqzOfZKgJGs+Nv1lyJ/A=;
 b=pGuObAWWyG26xM+wh94CjO0DZsAUTwQDb2SzBhPrL3XPz95bidlp8CqJATiwTeUywRJr5xy0ktlt8+Zkv10t57Qtaj35aGX9vb6SYbItuqmJzk7JIOZLngKf7Sg6qH7UnYOX+/5fV9TqROUQyHLvE8Hp55GzVBy9yWAHhXgl/85AjsWvuRx9UPViLFINpOxGP/zmK9RvSq0XKoTo0w8ELD8xNF9T8q7846QuI28eFma2S/aH72+sUN4Tsp/BuscEvZlYLTOjW8JgEmRXSpX4Ff1eyEyOs3wbckGITky4315UiPcRVB3ciq2npChfmZWoAEA8EtQSZhoGp6tKYHRGJg==
Received: from BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48) by
 CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Wed, 21 Aug 2024 05:10:57 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::e5) by BYAPR01CA0071.outlook.office365.com
 (2603:10b6:a03:94::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:42 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:40 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 7/7] RDMA/nldev: Expose whether RDMA monitoring is supported
Date: Wed, 21 Aug 2024 08:10:17 +0300
Message-ID: <20240821051017.7730-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240821051017.7730-1-michaelgur@nvidia.com>
References: <20240821051017.7730-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6778c1-ed21-4bdd-0836-08dcc19fa3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FB60v1aIGF8SMw2IRnVxmtUVChrtYPdEOJSnFXp3m83EZoIc0IdG1r+IR4sM?=
 =?us-ascii?Q?hL76kWHnn3ij9cAsuEQHrWG31Spg0EmKMOuWcoxttCRkkAGQbo6U5DAuykGL?=
 =?us-ascii?Q?tXQRbUgx1z1VjrQiKZdbGbf0NX7bO5LWpOYnaQ3/HDZb1C3ZdyjMz4CqdEl2?=
 =?us-ascii?Q?0Js0+OROur1LmmNPi8wZI0yilgUI1l6CgtLnJ3bJqAMupm7Mr3AMyD1BVuP6?=
 =?us-ascii?Q?KzLahak6xQaWlNI3+y0nBdprMbb6o0TBczrLi2lRSVL7PPg9SvPs68Dmnhhu?=
 =?us-ascii?Q?lbNvureuT9i+AUQB3B/MTRtjofB+9l8bSVa4s1p6MjSmvCD9tSe1SckcGNhC?=
 =?us-ascii?Q?7jQ5EPg1bt75qMIPc3+smRx2cxHezqVpwVT7rGV8DctiFijVgCHPR+p+L9y+?=
 =?us-ascii?Q?yXymyPYp+VdDShKbzv9U4JySbqdKjSXdc0xMCCc8skZK5MSrT6cqLQwZGXFv?=
 =?us-ascii?Q?DeyXOdDeSeDGY0/C0Wwn2gFXXP28epN1hnT48ZKj432H3qbFKripf6Eoe2Xw?=
 =?us-ascii?Q?qUlXQZO+7WhIxsJ0lHjO5LN2UgSOAWRl6i1+ADOyvlGHd1o5z8baNkY66CsB?=
 =?us-ascii?Q?Mqsq9lo5Fz6sgjiGcJbRF3a0AupdY0dIQjct2QjIJ61hl/qu+14rk0ybDK/5?=
 =?us-ascii?Q?4qWoAR93SiQLwTVVqCxXxQA+pPhFltKwxwmNlUTfcr6YFamXrFYJD+TphIj0?=
 =?us-ascii?Q?9SaojzkSbOwalbqyfDHFQDQvSlO7FLLImQIXB5TLMpq+1hgGwANN63fzcXvk?=
 =?us-ascii?Q?C2DQeQg1SKF5SDGyCDalGLpPuQaUMOdcqVWjm8EAN5YTs/v+BMKEWARd6Euq?=
 =?us-ascii?Q?H8srC6/A8evX4F4VN28rsztQwIlVfbMcxvyLCtxg1h2Hj6yciLCZzPPYw377?=
 =?us-ascii?Q?ZZuoO3pxWj4Izm7lfBeiiY+akJtKfiNPth8nTGHF9QN9+fcLODoxVnaekOYt?=
 =?us-ascii?Q?zyY2JpkpmORc2/We0j+GSXiieHw7uZyHt3ssyY3c2cfAvp8JvcCdby4x22yL?=
 =?us-ascii?Q?Rw9wNVf+7OlkO7Z1dPnLkW9OT6ORnBWn4qGZCmv2qMrZJmnWF4YoC3Zsp5hs?=
 =?us-ascii?Q?5el7izcQdCzpudJoGSBlLSleM7hhz6mGL40kApJvtwvmndY2Att/7BIvE2+N?=
 =?us-ascii?Q?eK+N5fggV+oVrZ1/wBkh6pbsbAQkkeggnFDEuJVvBOQesGXZ8YNIASXNXRyk?=
 =?us-ascii?Q?cCl7haRxYXgnjq1Wb6isfMKfTHX+XH7kqmliDH1WbdS7Lyxu/tqNLCygV6yW?=
 =?us-ascii?Q?6zj22sGoV9nnYyIBIXDS+43CvxCyOs/fHkUyyyKMhMh0g3GGDhGNfhxpybJm?=
 =?us-ascii?Q?hwodDinbvUDv5Uwg9h1EWglIXH8+eeo9nkbKS+tNCACTOVZQUPnEnjJM/k3+?=
 =?us-ascii?Q?yYLsIhfKBBancoBI29Lvye8WhwdyBdxWJSJ91v8jnbT/vwCOYBZCSSBPcYJx?=
 =?us-ascii?Q?6Pnh4tw/OvPj+8lLZQjiT5sYwwb6sSfh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:57.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6778c1-ed21-4bdd-0836-08dcc19fa3ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

From: Chiara Meiohas <cmeiohas@nvidia.com>

Extend the "rdma sys" command to display whether RDMA
monitoring is supported.

RDMA monitoring is not supported in mlx4 because it does
not use the ib_device_set_netdev() API, which sends the
RDMA events.

Example output for kernel where monitoring is supported:
$ rdma sys show
netns shared privileged-qkey off monitor on copy-on-fork on

Example output for kernel where monitoring is not supported:
$ rdma sys show
netns shared privileged-qkey off monitor off copy-on-fork on

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 6 ++++++
 include/uapi/rdma/rdma_netlink.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 5acbde242b97..f6eaf9c1fc05 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1952,6 +1952,12 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		nlmsg_free(msg);
 		return err;
 	}
+
+	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_MONITOR_MODE, 1);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
 	/*
 	 * Copy-on-fork is supported.
 	 * See commits:
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 5f9636d26050..39be09c0ffbb 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -579,6 +579,7 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
 
+	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.17.2


