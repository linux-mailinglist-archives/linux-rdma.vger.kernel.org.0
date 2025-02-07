Return-Path: <linux-rdma+bounces-7496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DD6A2B708
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701243A7BFC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C040C03;
	Fri,  7 Feb 2025 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCopeUKv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311E946C;
	Fri,  7 Feb 2025 00:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887231; cv=fail; b=q5apvWWYJ6aMbmc2tPpL0bJmRBUIfv03I+Xm7pLebXAQKLope1oMc4Xm+IGERW69jwvvYH8LIjg20Q0kALi9pwKwCCGIbAQmLoBMF6wNbFLxRxsJ1Vm65s1kuqIb7cHt/TlZNjO3G4B+LvXDjdWgFA9yWCDvvW0wA0rXhjz3RhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887231; c=relaxed/simple;
	bh=Z5Aw4wBTMv8MGkvVDyjiRF0SmAR5gxRFS/6bfShGojM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7DFqKQdQ6fD+npDZ+up0mOEm/NYW5Q9sK0Ric0kCXLFXoR0ZX4WdkwVxcsoZPEyWMtTYN1T5ggRiMgT6aT5NUzLeNCEbtnWPOwV5SDGwTNBoU5s5Bs2xHx9rPPnOnbSXvYTAMmgWm1d+70Msqt4QrozryYHAHz8LN4kAeiweNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCopeUKv; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyhwsQ1ecq5aH9HeUIX77RP7lWtUVFVtZXNCTCy4VkqnNWNtWboTvQUo2w4Q61iYv7hZgrOhgaoVBIuTpBeHY8u50VCXJc/d16Ipx8EFynAY/QkdQSn1L9mQ7WOlNDcy1L1NFOFMNatAP16lBGGP4PQZI4aDJML05zpOn2j5tEHQ8h/a3HSFQ0oz2j3OBoZT+YQ+4C0NfckPuNDok2EDxapQg8HIqXRPtlpPbvrzMWKlx8isvxMEjlUn+WNQif5OFb2yyA8lnZp23XngbeQ4zf6BplcAyj9cCt0jHn7Z7Zd2uFc6DfGcdrBjAYqv9vKblytVqJhVKMS/y57NgoQyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9wbkuGvqVbCw5Tr4oH5HrhEEdWED0ffMbEFlt8mTIo=;
 b=dEYPvo/0lbQxgRh3wOBcIWcZ/ARLACvayti2YCAPdBEmJZ0Aiaxs56GaDBii2YTCREgR22p95kBLwQry+RaIgjhjyw8OViDXl5wFd3XO2csGFKd+TsRz/Zb92K7vAEmS975Mg1WiTrh8iwlwloM4Ukbm0a7uro4obmmlbcqMpo4sVOE3wSL8/TCcQ8AYNYrx6qjXhEi0R6KsPjXAsBSAkyDD3jt0jR8vvDwCpy6pAMHqL0L4FHagRxkbRV1xSQjj6p9YYUYueiU1LKLg/veBk+COnGJZg51vmheTCNjPG+VtEtMuTKWczTGP8W2KMigCWm7w68XdVDw/mHJCpXdO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9wbkuGvqVbCw5Tr4oH5HrhEEdWED0ffMbEFlt8mTIo=;
 b=HCopeUKv42Nw1fdtsJFQx636zsJYd2GWJyRnrvrKbN+AXM1gZp5m80afP6G7RPisNUlzokk9DEUwbtTwRDSso/1kIK61tpsF4PB5OllEcM9P4CyRAor0IBuHUR5L/0u2UktO7an1i8X01QWfWxz6mhWIS6DR34wRTsa5jAEk6vxkMcFIFykCl8pnFr/5PEJdKcOaZBuSZMYe2KCV/gAZVbgDfFd1u+wmoxXP5NQAWFK8GjUHXdxxMydCc5TajSYlavkSCXDo57xNbum5JMoHbtsk3EHRKXSF7SvKSlcK1lEQ3gCaK3VyglupJrETtX2Yvq0lTDehFx8a21nzpDyirw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 08/10] mlx5: Create an auxiliary device for fwctl_mlx5
Date: Thu,  6 Feb 2025 20:13:30 -0400
Message-ID: <8-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0305.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b8df41-669a-4f1d-817e-08dd470c4327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?72djyVL+ijOGChZH2N6FlFfOWkCl2KFFaQYgytRz3cpS5nZ3pA/wGsLhW5xR?=
 =?us-ascii?Q?aaUEG4TjkVf27AugSUQi0dluPbAo41FipYHwsK3OLBk0lYJCmkgRk9F9UjKx?=
 =?us-ascii?Q?NPcLUONw3EaeTkKHvR1h0hSWZvNWnkhvDDMucxgwTXLds6rduu6WcoRSFt22?=
 =?us-ascii?Q?q9ukI6kzHihVkvf78tx01uqCeJanq2ScrYXgFma9y7uw68vBjSR2eX4c92Od?=
 =?us-ascii?Q?83jWVKMCryEzW66icfrcRSxrNevbpvqGc5APAjHozRvX+8Ngrj3lVZwB8XD1?=
 =?us-ascii?Q?n4QXKVyePgK+u4+9zhYfxMOFYOAkdqKlW3NSVevicryjlOdzw7jXblsY6ioy?=
 =?us-ascii?Q?RjspyMYwvQY/gfj9nD1r1UnphK0hezCKg3nj1x6xgJMmpGhqVBbeINqch3JR?=
 =?us-ascii?Q?0dW1vO7KBqKqZwnMOEKMxReWDX2CY9zRdL+V1DWRMdXBD5PjZmIVjQIv6hQ1?=
 =?us-ascii?Q?RmNJ4G3aYQDps1+5MwuGUrvt/k68HFdwk+XKvCVwEfm+I14sr8E+a6fqO3vJ?=
 =?us-ascii?Q?QnrFoZljviC+kpXfBqbBw2Ap+7j6uDqGFAGrsVQ4T8Sjs+Pgs8N/sSeVY9qW?=
 =?us-ascii?Q?jrOdRfYhmdr+EcbkBLRs8S91RsfUi0o/3SkOjMHS4XWaOHqAPb9Qwdk4ix3q?=
 =?us-ascii?Q?T6PCnPDl3QzEibnp9tmGfGVP3SOwJb2EYTtpVRtbg2nOFLwXL8U3sGYfClgk?=
 =?us-ascii?Q?+nGa47iIT9iHXBQdY66lwXXTFNkFz9/QTMvCWh7jDx9jr9pQ2I7DMrH/aE5l?=
 =?us-ascii?Q?Dhj12/6FadOA0TBBhpuQVmKZwf0W4ljrneXM4XtLjQYNBXOaebpgemDniUi/?=
 =?us-ascii?Q?l4qYdswMtR4uUtFuXxV7wkNhGpdILwmy02nle1q0F9VBvElVsOhCXOqDSum7?=
 =?us-ascii?Q?bLrTtL0jd/3E8BiIW+/WQCjieoDW+9AZxX0hAyXe9HTiD02duvvjMUKZ7ABi?=
 =?us-ascii?Q?k1Xolgjs/kPAKs96EYaFLMo0auXziiAtjHwi3LHzsqcWW9vorbgvfBXCYbjq?=
 =?us-ascii?Q?r0c66PfSXSZNKmckjVj/V14BQlMxvAUGoNzanwqbbkNYPp1XNmV2/MYXB+2t?=
 =?us-ascii?Q?teH1qUXczanT+7f2eiynxpTLotU1lWLuCJaeP5ejWyCgdC1pNUwoyMzVJNv9?=
 =?us-ascii?Q?Pjgh8nyEpXNfCHNcreg4ZBV2T0uZ3091P2to0u23vyLpKcqg0jhxiRvb4lam?=
 =?us-ascii?Q?GaNoVMj/ZaYp4dlJuXh/yAPeZ2rm8bjwVp34/3d04aamvGhGMETi7HM/88xl?=
 =?us-ascii?Q?47dYNouhUZD4BkYQ/B6N2D/nv5wfowurVW0VXdX/UIcK31+wvXL2I+Nltz1U?=
 =?us-ascii?Q?xJiOMIVXQevvESjJkf12YnXTHoGAxyApXRWke5ZMU0XMhDlvtxeImr+HlJso?=
 =?us-ascii?Q?k3H+n4zFY72LGg4csgsFCKIJajQC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tID0pAlb5e5A6lEinoDFbDX8bre9QfE9hiqjxZ4qzo4xQyG2OuWfw9SuO/8l?=
 =?us-ascii?Q?iBxvhvIxDbOpEL/OQXfIEfp98R4jyViy0Slg+0tu72pdxP+8OnXY5sbHwKYe?=
 =?us-ascii?Q?75vXgfrwfPtRpphx5Hw0oJEK+4embA8OfB2vlnSyyG9CFnXSpNXDDQbstq9Z?=
 =?us-ascii?Q?er6c04+JlwjBZmlgQWcHHM6GBj53n0UPJXZQUimeGtghPmT4sfhZHCfSxgX4?=
 =?us-ascii?Q?BeEuexXAGbFWgVZV2Bcg+4e1nLN2ObxqzmZ/mJ+hYtVCUq4b8OnYghOuobbC?=
 =?us-ascii?Q?vQS09Ron+O7/dQ56WZm3cQk08HxHYPLIjaZB6SnX3QTcimbOo30ugeDtVdgR?=
 =?us-ascii?Q?6ii1lSKdQbCtbvKihRS+FLWzcd7+vCC5OXGWBZ9A+dJ64jHtm1UiGmx7SwRE?=
 =?us-ascii?Q?dYrhVt2eryhi8Z4kMAFmnR2ai+JJPAuNP3ZkhIDWDI3uXIPu+aG0/xvOWdPo?=
 =?us-ascii?Q?k0bA5omk0C+7JtOLBhh7OU30ofCqHRmxUYdfQEH+a5EQLF7+xMDHwv0vkE1S?=
 =?us-ascii?Q?aFboS60lTv/npq9p63GkrCa4xUsxao/ROgycHa0m8vk/dPe6m7s3wruJfDk0?=
 =?us-ascii?Q?PNYalyLlSM/kPG3QY6PufvK8MivDtb34T+Z/NMJqyo0UzXSPpgDojcapIGCr?=
 =?us-ascii?Q?WppzQPdZ8DLH5GQqxTZX+yFPKWryATRfke8L6QM/cTHM/g7yWAQWH6LnKSOi?=
 =?us-ascii?Q?U4tbml4TFmf7T3OYX2kuHSxzZSxe6kBxdF9S/zYwRDIWKIfU07qgLOFa7bl6?=
 =?us-ascii?Q?vn1hOjiRFgvZdEHDnqUGkcTtqoW3kC1vj3ilTRuxop+IhvYWwYDuK8eGfHPw?=
 =?us-ascii?Q?SejkwQgQuPqgJ9h+oCzK2VCTQXXzQACVmT8qlX6kgHdVe604ILqUQDvWppiJ?=
 =?us-ascii?Q?wDgQELtwqkJJBAJfGGq0B80lwPPIQL7bdXeea0f3WburSRe2HDeeaU9zW2zm?=
 =?us-ascii?Q?wm+pZ7te3mzH9L0n+WeZSXcwKnB+/lZR6f1o/qdKMde/aR7DbePkQAWZYohr?=
 =?us-ascii?Q?Iokf8LtjFhzQ50+lsmNe4O2vZdvEvDNllByeBIEfJkAaphVe0HymFp3wqDka?=
 =?us-ascii?Q?AV2G2MsHmTpCyH/h5AX61MjKuQv1oOO+sczoMs4gduKi1JPZyak7jJLlwMD0?=
 =?us-ascii?Q?RR8MnpNLczkK4OzxQUWQuadat6j5K2yESp3LMi3pQvvXPmwKcM4kuJtZuP/C?=
 =?us-ascii?Q?JxfkjEaFWd+e8V2JToGjGqPKRp1Yu/9rgW3TX8OO8G7D0gV/SUDBjn6R5RRf?=
 =?us-ascii?Q?iuTuFsmYIPCtN6sUjr+6evmHvwP5SYEe7f2HDXnJHWP+lZ2DHRyf+r5VaIkl?=
 =?us-ascii?Q?31Q+PD5cDiXa4EEMpVvKSNEz2GFzf565jS76N+iHVmmVVo4qsAuFa1/5LLGe?=
 =?us-ascii?Q?zLWjN4kLWIhMTIeQ+39lnvMiCG+zemSfL95EiHo5RjYRrXOaEPY6zWj47AEe?=
 =?us-ascii?Q?CdIEbqxTEFHr+/BqNdUANKAW7n3TQ7juP/xWx0VqAlP3MBalZ9XxJ2YGW+j2?=
 =?us-ascii?Q?6IbqXBny18Z3KKRbBIiE7WgTHbyO4KU9kXRFe1boEypjv9Rj2hTrRhWUtlxR?=
 =?us-ascii?Q?Hlq7WL2xFBx1z7oeqas=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b8df41-669a-4f1d-817e-08dd470c4327
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:35.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhllSIMGzYFIJhBsZy1Jda9b/PaYdMPdY7FyKn1N5/1eiDS82i5XxuuA6ItpTF9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

From: Saeed Mahameed <saeedm@nvidia.com>

If the device supports User Context then it can support fwctl. Create an
auxiliary device to allow fwctl to bind to it.

Create a sysfs like:

$ ls /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -l
lrwxrwxrwx 1 root root 0 Apr 25 19:46 /sys/devices/pci0000:00/0000:00:0a.0/mlx5_core.fwctl.0/driver -> ../../../../bus/auxiliary/drivers/mlx5_fwctl.mlx5_fwctl

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 9a79674d27f15a..891bbbbfbbf1a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,15 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
+	MLX5_INTERFACE_PROTOCOL_FWCTL,
 };
 
+static bool is_fwctl_supported(struct mlx5_core_dev *dev)
+{
+	/* fwctl is most useful on PFs, prevent fwctl on SFs for now */
+	return MLX5_CAP_GEN(dev, uctx_cap) && !mlx5_core_is_sf(dev);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -252,6 +259,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_FWCTL] = { .suffix = "fwctl",
+					    .is_supported = &is_fwctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.43.0


