Return-Path: <linux-rdma+bounces-15161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BD9CD6279
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1317308E1B9
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48702836A0;
	Mon, 22 Dec 2025 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnoxHtQS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDA2E06ED;
	Mon, 22 Dec 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409982; cv=fail; b=UZVYEkKOP1aH8a2If26pueWsFrs9RvsGYUchKLNWL1eCqBNLs+KOwv9rQ0E3iD2FDhuQB6cx2LJuDgFzRbCLEJwLYcW1ZBi7xLd+wLWwYPuHjnY7BkWrUS0BrwSWG1X/dGZx8LF6WLgth536ffDv3xA645GER/x/sIO7Md51RUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409982; c=relaxed/simple;
	bh=5/Cv4BWF/xkPgqOt8iQ4iHpQcLKbPZ1VS+Wqm0bvhwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eucxi4BUMM1oKa7OjM8NGoQ38wFTfY6aoXl8fv4Fh5eB1i+mTpWjS1nJ0i3PFCdAopj1ptbZAVeMOBBhLHr3DV5vk9Wq9yumppSPjxW+U9BPCkzcd2f7gzD9jjW28VIi28DNkGCIQdEG/1GfB9bCkLLJ6KxJ78/oEUmynAsm62s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnoxHtQS; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuchW0Do7twqf+CrRaDxKebtHU+eQzKBtE+3zl/R19ambH7V6UUnmUle8VDKZvjUvh+zgAZzPWUW12dQz9IZgiyNI2qMbNVF6G/SyIm2aFF4YBAXQiFHgwYcT0OC+Jjv54xkikPJVAkpJpVEss6rwryrbD+VrvqHGKV0ilOLbmfX8RsOHc1nylSmO91vx4IaWKo6LGudk96Kxg9HEbRfXk50CpFGoFVOU1BolmE+de/H+/0HvOUykl3TF+ruOocIfb1IeR6p3v9Yg5EAfquNJuexJNyCnqtju7BOzaFev6o9jwcdoUrwR/0Qnzm4F/fshjkwNnPvH1q4hcrZTeH0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nELRkgxMNNjazezj4axGCWL9I2NvhiCFQlt0iGAyHJE=;
 b=LSTtBaN7sM5vMoPh2t8iQ6vEutb8aHTAG/71tz/Uj+66aCAFVIO9DDPRGCnIPRe/ypCvxdqh5GhsoPnNsXQjrTdeUQzNSHUZ9Z0aRVI0pKYCnpsPP3sxz43PUq8P2V3pv7I2PclzIsKtMbS+/VMsWShpXL4f4+Tr8bq/DP3DGJ+ps9BwvupWwI8bukZLWgvKB/cyLxe0jJzD80KHJTTBqOyv4v1KTcbqL8AlQIDCSI/W0gcuIvOhmaGLMXU6wSkcGOQIEuQ2HH5Pc74MQtG/Z9sIOwsWEurrELVF4KnxQAaK5dSm2Vb8t1ldCjZxa8rAWqjZB9kFqQ8jE5I8kve9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nELRkgxMNNjazezj4axGCWL9I2NvhiCFQlt0iGAyHJE=;
 b=mnoxHtQSFDLMQlA/DWGRyhkVi6Hvt7r3cY4cj0TrKxrQwnQSsZQ+bvNShh++YFUz0y/VYICIHsfK480zioVwjVQxrbSVJIvU72GNBUia73ji6H2XvnXur8UVt31wqDxeZMWNR+wU7I31fYHGuEJEE03AELdqzCkP0oTpL8Gul/SBkXxj3GFwU/3KJgz+NUphU2bfWpbWoEax3WKX/dDEeVIEv42FoStTzdPW6FwjMT6sDLm6bgGHmsIe/p061DeX7R50LQyLgsmByPTd7mcpK9lKfz9s98tR7gFSelulY+LnYUATomYbKl33iOvg+HrFXaPNhUOJEydGeiNcrMDmwQ==
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 13:26:12 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::d9) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 13:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:26:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:26:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 05:26:03 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 05:26:01 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Michael Guralnik <michaelgur@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>
Subject: [RFC iproute2-next 3/4] rdma: Add FRMR pools set aging command
Date: Mon, 22 Dec 2025 15:25:45 +0200
Message-ID: <20251222132549.995921-4-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251222132549.995921-1-phaddad@nvidia.com>
References: <20251222132549.995921-1-phaddad@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6cf5c6-ce49-4e4e-060e-08de415dacf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vpKEH5dZ9YwHFuadnhTfsnlItlh0s82ern6n1g5LiRLLv2wRyVZvRlafYD9i?=
 =?us-ascii?Q?Py9hyiFtsLQ4OT5ytIP747EJrSY7lcbXugR3A1icXFAX8LIukHwKo0jrFujA?=
 =?us-ascii?Q?YJ4lX2SBPJwnzFUubU5qaeHjmqbDSKFW/SNTUnJfyuR1PPeFky3NinYOvYt1?=
 =?us-ascii?Q?QP/7dy+5zdS6NBcZ+5DX2PiZ2jviUisFgvpOQ9kmR4i9CR9yvrxAGo7aImTR?=
 =?us-ascii?Q?isHLy7tD4ACaulh2Oy1EaVdQzpn9aqSjCU52XZCXvy2uAitpP44p8K+nHSA6?=
 =?us-ascii?Q?bAdE9+QYl+Du22U5lkj6L9BEMi4LFx2rhwOVOXvC/vaqo1ncFf85VCIlhNnu?=
 =?us-ascii?Q?fYYLgNVsS97+dxUbQYkrXkz4D3DCCU6zG/Mw3p5mODvPVr9qnVIMK3hYqrPN?=
 =?us-ascii?Q?NuMK2R0mGwfxjarIlds6S7k87nQKmyijRUMnRmJc3RKEmsYPhG56yjRrMjwo?=
 =?us-ascii?Q?PjLKETo9tf9XlPReIxsaOnfkNY5LMyakDrU9Ni+8/aekq7vb2rCjS4BWPcHy?=
 =?us-ascii?Q?5lQSsFxc+z1B8pw7n9zLgzON6WE9j3zHF3z4hwnq2KlAe/XAhvFgoni9+vZq?=
 =?us-ascii?Q?witdOUTeMDlKgvxnQz5Ly76nO7XGMTGdEpDgddMbkYS48hZZ7USyqOCfwJBj?=
 =?us-ascii?Q?Uu6KtPXVHB/B+NJN5Eyqx7nLBY4s5UsA3r2XhI5L/vqFldjVuIdR3om82TlO?=
 =?us-ascii?Q?ukq093g9fPoYnpPvHTto4K9vfMUA9Gc4R6mKVe3nd2tyxAmC+VJdxUeO6taY?=
 =?us-ascii?Q?OMk1mQXa6+8Vcz1LQyHKQnSe29iAgOYexSeiUlOyNdrbN7jEVZeoZrkLfbTS?=
 =?us-ascii?Q?7Lset+A2YxH/bv99DcBip/k+fsubtlnrOegFWPmu57NKqLW/8BVNQD+NCX84?=
 =?us-ascii?Q?55dpmKRICsfRq6qH6g8Ufw4RP/IQWtYidjDPGI0eXJxtGpdEifgCsiahKQow?=
 =?us-ascii?Q?n7vVuxLX8/oyyM8IGNdE+hZA1rWP/U4qNc1x8aSXAKB30mbegzRGK/aLV7rl?=
 =?us-ascii?Q?XJUygJ6NzGqYF8YmR0ogPZbYMZfAfUGVjgPgqMdk4t3A8f5uu+8dBAz6CYmj?=
 =?us-ascii?Q?BBusMGTsJy0XkdbDj8CldMX5w3ww/hUnvw1Tt5uxnaQN5dB6G2k1YACkZJ1L?=
 =?us-ascii?Q?Dvb6RS1lM/8P+Htcqi44LS7h33+55VYoxcpD58lUc4b9yjvUizkLHJdWawtk?=
 =?us-ascii?Q?VlrugE7MnZES9hEq5pSFu3vKlG6IMPWyFjUxleeJqvFnkKN59T7Qd7eK8IFs?=
 =?us-ascii?Q?dttxoSwQvLTr5FBD6dC+VluDKvlw4S+flnIvz6HIdN6eileKxj+djjespn5O?=
 =?us-ascii?Q?93X7FMZI/j9DO6ptBtHyONADCdZOsasft/bkWIkxdyZMqwV17S7O0uKFd0GB?=
 =?us-ascii?Q?6PMTKDNkEVy0SV6nmDgzoYRNvo4ADBvzbEkMniG1ak8EscpFgwJvLQ0v0wqq?=
 =?us-ascii?Q?nrkk1Oc6HyhWGLKeWepy3wc5HxCu6swZ2oQ+hhlWnCJpghr30zMZ3x+GKCdW?=
 =?us-ascii?Q?XV/RpVRPIY69LKajAPtEsWJcSNToqwjE5r3yXM4H6WlFQ/pOmZStG1mvTm76?=
 =?us-ascii?Q?iKlFIJ3DXq1D8On7SSs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:26:12.1673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6cf5c6-ce49-4e4e-060e-08de415dacf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to modify the aging time of FRMR pools.

Usage:
$rdma resource set frmr_pools dev rocep8s0f0 aging 120

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
---
 man/man8/rdma-resource.8 | 22 +++++++++++++++
 rdma/res-frmr-pools.c    | 61 ++++++++++++++++++++++++++++++++++++++++
 rdma/res.c               | 13 +++++++++
 rdma/res.h               |  1 +
 4 files changed, 97 insertions(+)

diff --git a/man/man8/rdma-resource.8 b/man/man8/rdma-resource.8
index b1bd0b3f..7b09f4cc 100644
--- a/man/man8/rdma-resource.8
+++ b/man/man8/rdma-resource.8
@@ -26,6 +26,13 @@ rdma-resource \- rdma resource configuration
 .B rdma resource show
 .RI "[ " DEV/PORT_INDEX " ]"
 
+.ti -8
+.B rdma resource set frmr_pools
+.BR dev
+.IR DEV
+.BR aging
+.IR AGING_PERIOD
+
 .ti -8
 .B rdma resource help
 
@@ -37,6 +44,16 @@ rdma-resource \- rdma resource configuration
 - specifies the RDMA link to show.
 If this argument is omitted all links are listed.
 
+.SS rdma resource set - configure resource related parameters
+
+.PP
+.I "DEV"
+- specifies the RDMA device to configure.
+
+.PP
+.I "AGING_PERIOD"
+- specifies the aging period in seconds for unused FRMR handles. Handles unused for this period will be freed.
+
 .SH "EXAMPLES"
 .PP
 rdma resource show
@@ -119,6 +136,11 @@ rdma resource show frmr_pools ats 1
 Show FRMR pools that have ats attribute set.
 .RE
 .PP
+rdma resource set frmr_pools dev rocep8s0f0 aging 120
+.RS 4
+Set the aging period for FRMR pools on device rocep8s0f0 to 120 seconds.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
index 97d59705..29efb9cd 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -188,3 +188,64 @@ int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data)
 	}
 	return ret;
 }
+
+static int res_frmr_pools_one_set_aging(struct rd *rd)
+{
+	uint32_t aging_period;
+	uint32_t seq;
+	int ret;
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide aging period value.\n");
+		return -EINVAL;
+	}
+
+	if (get_u32(&aging_period, rd_argv(rd), 10)) {
+		pr_err("Invalid aging period value: %s\n", rd_argv(rd));
+		return -EINVAL;
+	}
+
+	if (aging_period == 0) {
+		pr_err("Setting the aging period to zero is not supported.\n");
+		return -EINVAL;
+	}
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+		       (NLM_F_REQUEST | NLM_F_ACK));
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,
+			 aging_period);
+
+	ret = rd_sendrecv_msg(rd, seq);
+	return ret;
+}
+
+static int res_frmr_pools_one_set_help(struct rd *rd)
+{
+	pr_out("Usage: %s set frmr_pools dev DEV aging AGING_PERIOD\n",
+	       rd->filename);
+	return 0;
+}
+
+static int res_frmr_pools_one_set(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL, res_frmr_pools_one_set_help },
+		{ "help", res_frmr_pools_one_set_help },
+		{ "aging", res_frmr_pools_one_set_aging },
+		{ 0 }
+	};
+
+	return rd_exec_cmd(rd, cmds, "resource set frmr_pools command");
+}
+
+int res_frmr_pools_set(struct rd *rd)
+{
+	int ret;
+
+	ret = rd_set_arg_to_devname(rd);
+	if (ret)
+		return ret;
+
+	return rd_exec_require_dev(rd, res_frmr_pools_one_set);
+}
diff --git a/rdma/res.c b/rdma/res.c
index f1f13d74..63d8386a 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -28,6 +28,7 @@ static int res_help(struct rd *rd)
 	pr_out("          resource show srq dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show frmr_pools dev [DEV]\n");
 	pr_out("          resource show frmr_pools dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
+	pr_out("          resource set frmr_pools dev DEV aging AGING_PERIOD\n");
 	return 0;
 }
 
@@ -252,11 +253,23 @@ static int res_show(struct rd *rd)
 	return rd_exec_cmd(rd, cmds, "parameter");
 }
 
+static int res_set(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		res_help },
+		{ "frmr_pools",	res_frmr_pools_set },
+		{ 0 }
+	};
+
+	return rd_exec_cmd(rd, cmds, "resource set command");
+}
+
 int cmd_res(struct rd *rd)
 {
 	const struct rd_cmd cmds[] = {
 		{ NULL,		res_show },
 		{ "show",	res_show },
+		{ "set",	res_set },
 		{ "list",	res_show },
 		{ "help",	res_help },
 		{ 0 }
diff --git a/rdma/res.h b/rdma/res.h
index 30edb8f8..dffbdb52 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -203,6 +203,7 @@ struct filters frmr_pools_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
 	 frmr_pools_valid_filters, true, 0);
 
+int res_frmr_pools_set(struct rd *rd);
 void print_dev(uint32_t idx, const char *name);
 void print_link(uint32_t idx, const char *name, uint32_t port, struct nlattr **nla_line);
 void print_key(const char *name, uint64_t val, struct nlattr *nlattr);
-- 
2.47.0


