Return-Path: <linux-rdma+bounces-2789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AC8D868E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1211C280FF6
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C595A13666D;
	Mon,  3 Jun 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hnQdhHdK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D25132124;
	Mon,  3 Jun 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430017; cv=fail; b=HyGZ1nwX+e/WlPmYU0sIHo04fJPYTRnabg05NfKNAV6yCbh6Q3PR+ILXsRyZQZHliyyZO2T5AWrHPj7/hoxB4qSSAOa8LtBoGY+sa49IeiMmuxN1Y4cdWlT9mYoHWegPx5dv6TO9tLfhlDQE/BjH2pUVBpJwrDpvmRsxKEDXIBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430017; c=relaxed/simple;
	bh=8OD2Hfx/2G14AFgglBk1QAzWsKVoply2tS4MrhiZpkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jvnRkTdVchFg0J3YU4Xtjd/cltMmSp9PYcadtAeS3aL69lCwQUZNW4EBK/RBQDEZvKIQCI+rnuGltHj1i6y25Nv1BtIImRGHm3DORo0xn1NGTEerjfRx6/XJD2vjJYeZkkz6IHQnORL5js0FCZ33tIe35bc2h330GNJBDZXvQKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hnQdhHdK; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVqPlOxP5f13fl+dwbu6Ro32C98W0v+cSlCr+pW88CJ4b2WK3nvgd2JU2A7NRtFWEG7zzjCbEXnWbjm01Doi6p84qMkd7TaLA584sc4xtxn55CrSJCxmemHZl/+05t1TgVEQhW3WBywmdGgrydxHVyVtmNN1q6hECYMnrJ026PuXjLUy8ODF/yU5c/uibu18xv4W93UWZgCrTyBzL7DmPBGFV9U881QdYjBwPWbFTJCmwiPxsNpi7vXC8ayhCOe55VZp8NmDqzbZWKn2bsZPhLce6yzpiY364Z4LzkuRGqfBQFTNIVgp+Nwk7V8mPBVrsAvioyGkHRKq43Bkqs0RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCI4chK7kbXXkpq7Y0mXZ5pHELGxM+ZuWnWxVCW7XP8=;
 b=OqzQ/xnveD/cEx1OFtAfUuX9PkEJiJCqdDsVrFLY4w2S++058lC0MdNd+hq2Q3HiALqZWg1oqHEIdWXCe0DPr7yosGJP2UvjtvByY/ufQa0ZwhuqcA6P5gPzvmXyy6T7KW4hHPI4/BiIKAD+GxYqGCFKAnw/ZnlCeRke1xRm+wzHhhU67qyL1uc4EgfCzO9gpCuQXH8wxVz0Z+YrFUek04LPHVd80jBN0AAHWeCAxb7abX1bK/9xT53DGmmrRHXpS6L65wNdPRNyK5uYicIfoqyU8a24DY1vaE/5OL95rNKL+xbVPHmnHjks06LihxSCEbrgEvsvleZzD6TUeBi6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCI4chK7kbXXkpq7Y0mXZ5pHELGxM+ZuWnWxVCW7XP8=;
 b=hnQdhHdK2/aZBRnfJ3fEpNpyIhuQMOmvYOCj1ulPTazgu7XkkdJ9mN9ij7ycqsJHI98OJgKPSiLb0fAF5m4fqpPj2xgc12Ete4kGkChaAHWaEb+SUUN2PxmyOlJ7QRvB7+2RdBg60Opz+CD2hY/KMs97wnif2QiQ0Wui4qrjErM5U0rBKaud0IZsPbyt/UbCdvshfdJ5oez1k/zxPCl1SNaSQhpKzLZnzAXil51e7lN1SvK14Bo/ztCx15cLBjL1re34+PvwXJDy6mc46bBmloh1LEUZ4T8OBV6/FK8qrT+pGebqQrvwjC+IGQpPNGDGw0ev7SdX3rX+enLNORy3Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:28 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 8/8] mlx5: Create an auxiliary device for fwctl_mlx5
Date: Mon,  3 Jun 2024 12:53:24 -0300
Message-ID: <8-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: caa30098-1afe-4d44-39db-08dc83e54edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMgqRTUyGMR98NSXW40ZtN3QbjJLZo7IcJ2Go4ySeMQ6iXiuFbCYKV2OpXhI?=
 =?us-ascii?Q?svoimvyjgD05uyCqE1o66Cyg4H7aP+QImh7vEYjpVrZsJxsD+DBsaZq1aMfw?=
 =?us-ascii?Q?3AYkTzAAflAbtjjQ6qoDshocbs+RKNnbyIAk69OV15Rk1aY13EwOXU4dNYfX?=
 =?us-ascii?Q?2Wfh8DO8E2lme+v2RrGrOSkre7CsD6X+laFCiZPp4ZQREJm9O3lZUg9nzMBy?=
 =?us-ascii?Q?7OYIR2o14rc9dZfuXLkRQg4UT888izSCNxx3rEdyApXVCOk+RQijTYCakw5l?=
 =?us-ascii?Q?zKdkWfGPY8u5/v8bs70ioxM8BzyHjb+NlrFn1Tc6V/LIq/WL2C2/XVlUJUdu?=
 =?us-ascii?Q?JPaKMRUL9ALCQAfzYeU+mxhNIkUGP1GQjGdgm3OeRgkyHq0WfhCYwRMnQ4yp?=
 =?us-ascii?Q?F/fPwFZ7ptmj2AA0URLm/a/nAvptcdszxY1jGbXeLbedF8XCceh6+WEB/TBx?=
 =?us-ascii?Q?V79e5slPuU473W7r1mI6EJL/UCukrMQtI1rbqrYRtCLf4962mT6Xa5aoBHWD?=
 =?us-ascii?Q?6r7TWj5DqGMM0/dkSqp9/azL1Pu/OYmMch9UxZ3NMu22/yjRcBizhpBJU5JY?=
 =?us-ascii?Q?D7Tt7P1n9SAP5viEVhFytDit34XNsw+RwPXUitm/tfQnDv7o9bjFQbNncbu4?=
 =?us-ascii?Q?bH6Wua5O2WwUyMDDmHGmCWpaBP8AeWoVUZzQmwh5eBZnBLR3VsgyOK1k9Vfq?=
 =?us-ascii?Q?KlO0yA9d6cHAyT4K9zTofjhSGZjOE2w3eS70b9AKdPc0HOQgSH2FGEL6YcSD?=
 =?us-ascii?Q?yVg9PnG2XxjlH5R1FBjyqQxTl8HN+SBAuT/5PwIRDWAv9YcVLur2zJ5Xhnkb?=
 =?us-ascii?Q?VVjbVdQSZKKSfKQdzQZT2iaV2EaX8THhVwzh23Mmr5yxQNLX4S2R+OLjRFrq?=
 =?us-ascii?Q?nlXPRmFgi22MrXpqGEDmEHL/2Po+WZFHzpk+KX+UOZ0KIVKpb0dfpK7xd7s4?=
 =?us-ascii?Q?jFTv6G0QfVHWA8YtXSoGKyvs2K1H3P0jv2PMsVeKOhxRrE9qAIjpZl1Odn1v?=
 =?us-ascii?Q?X+nkm0itJp5UrYVym853KuUutEX1ZMaWLT6Zhgqp9M6SYvFTAVHjeK0qVZs8?=
 =?us-ascii?Q?I2eAdXlRdo01+Tia8g6BdKJUCayI1opG1nRTHmKhgJw+03wtuTodk68Wes7+?=
 =?us-ascii?Q?BzdgXEYHLWW4Oo0E8dJQrxdB4o4aV/aAXmsDilJ4nDOHY7WP92kbzXWRIqQB?=
 =?us-ascii?Q?uRI/Ht2tEpkizdF4Wl1vdkq7GZJ83g1NkPcgJ2s6kCbdSHoO8+477yb+sqkh?=
 =?us-ascii?Q?CKL3S2K57Tr6j93DgphhtV9viMn/dCf/i5vVE35r2eaHF3+5h3Ind2jtlVKt?=
 =?us-ascii?Q?FoBcbY7rQ5XuChwmY0jZuU/u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WCCcGwGYT7RZJ9C2vHsHOYK/fJ132pdSsREKbLfI2uIxDJyxOyQN/i1pPqsJ?=
 =?us-ascii?Q?YrDnCfSRTk1+4ItXPKMn/0GKAWOJTkRJDcXuBdZxMQHzUIFHJIxkUs4cN1AD?=
 =?us-ascii?Q?cojf3uF0u/lwzGUETxsgul+LUZ0GaLvQVEMg/X5aYNhfvE+yqnsUNQ4tHv1y?=
 =?us-ascii?Q?ZoWvMRCg7/CrqH6N7mDMRofpc9fpOK34UZLq/81aHvShNrEoAj27sFu/TnZZ?=
 =?us-ascii?Q?whkg51GOlrqH6R5821aXVin8Cmolbrf+f9xYjpe3j6HVezr4R28uTIH43pNn?=
 =?us-ascii?Q?Z4g3TaWC1VS0TXPZbFfJoZhYwTglZ97oEeZzbl2bO7JuHALbA+KEfQbTm21T?=
 =?us-ascii?Q?4EKWqraz7RktVCjy4py9oiFHehaZRf0jmj4OQ9kL/0GWIdQEJW8MI8hcWuQK?=
 =?us-ascii?Q?c4djxCWTPvHsTbWXaP2N/VvUEhsOwtvtDCGqTRkx3IljOFfec0eq4JbFBuff?=
 =?us-ascii?Q?zxIxS5163anQgKFuQ7J2SHnbrpXuVS2svH0YyL+CHq7wY3HAxUE0/1TRr2l1?=
 =?us-ascii?Q?HbJx/Df3Py/OYocJNJZPYYVVSAVbyTt2kU6t0a/5Uf2VhXGtfvnjHCrC3WHP?=
 =?us-ascii?Q?v1wWyDRwTonIJFhoqzFFtIf08uaS7e6NMhyLm5cYvjJwKXBnBhzJCqEWfdZv?=
 =?us-ascii?Q?1/jAlXIHHsIXwWRvWqelPu0Rd+C7y+17VPp1gXKf4WPlexrf8KaHPjNV/X+I?=
 =?us-ascii?Q?ydQbEw6VpfimErM0JByxbwWBgyCat7YLzc2C3O9sYC9/Pw5ENvNyDdRpm1lv?=
 =?us-ascii?Q?3x02zr7peF3AeaZNS89U0ncWeRFDoj46Q38ywencxCL2xAGabS96iovm+eL2?=
 =?us-ascii?Q?9K87gC9Mohq+QMfg3XAqClebK0GNnkSi4cPaQmm01qhQVFgde1CNdZiTOLqH?=
 =?us-ascii?Q?675soQaq0pDKXkL2A399vJDjtvJpdlmgUx5LJZd6vL+RgzVPZHPCVSLeYDSX?=
 =?us-ascii?Q?IVPGMz5A0CqihKgoMmTQICCQEE2+Nodte0lbrngUFBN+HZhGy7muGK7Z0nDq?=
 =?us-ascii?Q?sJtVUbjZqgzGphgoyLldVXF0uK14cjPDHURifKwbdJiRQNpkybqgEe43h96T?=
 =?us-ascii?Q?qMiZPOr57ckzG3BxDSKd0qx99kkA72/Nhw09A5A4eqSW/sb9SKN9879pHiVs?=
 =?us-ascii?Q?+kDT/YVWEwlb/ObcmiAIsczj6Ca+Wv4Ae2pMWlUIHCsng55bNjxzJLMV7SsJ?=
 =?us-ascii?Q?QqzwaZ/xOYJ3fTrbNbN6yzs/HIPvTIfx1MrLtCS5XrDdvzQEN/fHkcw42ZXh?=
 =?us-ascii?Q?/3G1XwqCzMb3yBmnwV5Mx84pikGSR5hmG6OaCcZR/4jubSO3i5PPqz64aK5f?=
 =?us-ascii?Q?pZOwxXuXS2yuvwlwJAAFgpM7s7uGSaLU+CAOCQJiAtQPADbHttsEzDFi6We6?=
 =?us-ascii?Q?zBN2QnCLiVy/PlZez5Oit8MtPmzcPDu1er3lBjy9QKhs5n1xK822nKjkINFx?=
 =?us-ascii?Q?rBU05eWDv5LM6Jw367SGcbSB7KG6OwYuSldhSUrsTBcMkeKc11Eu8x/TNpwi?=
 =?us-ascii?Q?LvhICW4EWqeA363ZSPKo/mudGP5mbR7LpXHwlBaVPo8g4CTWEFEZMyYLiW6f?=
 =?us-ascii?Q?+F53lK+zCsfuRZAzMTYI+CL8W9iT97WW97Wer2nF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa30098-1afe-4d44-39db-08dc83e54edf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:27.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2k9YKqF/oop0NEkdguYs28VumxJonegN0Z5CiEUzlUlQE79VoUzXXaZjCa5vjgZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

From: Saeed Mahameed <saeedm@nvidia.com>

If the device supports User Context then it can support fwctl. Create an
auxiliary device to allow fwctl to bind to it.

Create a sysfs like:

$ ls /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -l
lrwxrwxrwx 1 root root 0 Apr 25 19:46 /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -> ../../../../bus/auxiliary/drivers/mlx5_fwctl.mlx5_fwctl

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 47e7c2639774fd..6781ddb090c475 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,14 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
+	MLX5_INTERFACE_PROTOCOL_FWCTL,
 };
 
+static bool is_fwctl_supported(struct mlx5_core_dev *dev)
+{
+	return MLX5_CAP_GEN(dev, uctx_cap);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -252,6 +258,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_FWCTL] = { .suffix = "fwctl",
+					    .is_supported = &is_fwctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.45.2


