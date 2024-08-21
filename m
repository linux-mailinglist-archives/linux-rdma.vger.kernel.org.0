Return-Path: <linux-rdma+bounces-4469-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60F95A480
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70E92836BE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA31B3B20;
	Wed, 21 Aug 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sO+M4j/B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614721B3B38;
	Wed, 21 Aug 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263879; cv=fail; b=H7x/KTflT/DRzU5OJdNPU35Mz3etgTyT4Nyqb1rgWirUvGgUUhIhN49IDCekBcwTmoHE3ICCb0AljsJkkix26r/aHE+llkpJeW+d3G9e88xfNRRL63SftdTswBifd1ax+fY4ZZhpfldifOtGdZFg/OQ698LCbtmhJwPro6+ExKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263879; c=relaxed/simple;
	bh=USlx7YBAbBV3ZbwmRWo20Jf9Zxz6LnS7OFYdml5zYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbONeJB0Se0VpkdqMUVVM8yYf4BgngUqOvN1rgkDo8GM3zeZY30KUpg0VcLZTg+vYGGsFtwqPcL/mySnseTsE/KWT10EAZj45f3QGeH7qkJD7zITH5XNRd0mrNdf48WPkhutKaR989VoVDZM0XRtnV5bOL66B+A2ODc8lTuetQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sO+M4j/B; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgfTdFm/v0VxmEzZZAfOf44XaQW+I7QGPSPJi7op8C0bdkOmUOBxcSy7JOdLqwaYQECMAHYd434FnytYI4zcjuqqxqkBHHxncu7IaweaiyJ987dc7g87mhFEakHK/PWVgEjhWVqs87X5N7WN26HsbJaNGQVgBkzq5jbh6ZVHGbxnemnSiOdePdSVPu1BLOrkvnV1ZmsNYtdGNsIenLQfQ8zvGHEndSw4GHUOfnft6rCdXJ855gFXpMd7lKW3VcZOP0OBNlCr64ZkFPosFIC1T3e3ItOlHR29X4e4gFmKzq6S0IDarnPKQuJEJLppBxuiTwWsxNbEfGdpLxw+h+YYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIt3ge5f+/l3Iay/sGuncebBG61co+3+9bM0Kcnrt0A=;
 b=PdCNf9fpa1fm6/SFf0T1p/77Bud14iiEBRWK5QQr5QVRd3b1Q1Ak/iOPZzVC5TukEOd30w7EBwu9xDD7yxhhdZ8LZQtHJzeJFyIcL+uX1jErBsMFkQAlo+PXGV8/ytqbWdThCrlU0TlxiwFXD1bvZXKGFSkC0PfYPXgy/YnZ6RFAa6SPxXm3DTy654n0lXpql/DYjc09PT48i1WKxMQi/Yyv3ChuPwv5iVy5ztNX/rX2/K+E2XSg4mIYMkaPv/IvoXd1/l68fPP15vvwMKiJ9qGBTyh5eNiVCsIu0clQlW21en7RZ73wlWNZBbZaGIJVBobfa1YBgYEEt2m+/y8SUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIt3ge5f+/l3Iay/sGuncebBG61co+3+9bM0Kcnrt0A=;
 b=sO+M4j/BoEOLIz630vNSzhyNo1+EUA3RSP/k3EAXEVXFpcW2ZZEOfgvTW31YjOsMkTpOgPknV9nS7BRFwwiTvuUc37t/8MyhgfKtSmARpY23UVTcGDTcIBnZVzytGOfbJfdHAxzNHiHgIhgKKuXePLidLEoZxxoAxyH2H8USmWkHXZNm3NJdjf0o0Pal3AmVt4UFfcxv3yiYZZI0QYeG3DzOyHJq8Q6MuimL++V2PHDmsug6Xw6sYD8Y2F4w5aNugUijiTZ6Op8Qytrl3xuNiEp03gf0+Xo4W/69rvIuErtqds/GuS5U0z97FZrF17EuFTWeHEhBg0clu6sgIScsog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:08 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:08 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 10/10] cxl: Create an auxiliary device for fwctl_cxl
Date: Wed, 21 Aug 2024 15:11:02 -0300
Message-ID: <10-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:408:fb::10) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0859e93c-ee97-4f6e-2ae9-08dcc20c9ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gibgDFBjITM/pMtZUvWDAsaAH96fCDKD3o5Yp7FeFLcjjaHbobblI8t89O9p?=
 =?us-ascii?Q?GYXveab3H4bC7kMa6iyVEpv8tZzCzvO02Ic7hOtjX7K6PSgt2ygEyLnafsxZ?=
 =?us-ascii?Q?7JEFQuIllFGTUQ/SzaGnH7cMn11/40X3TvpLIeFfHlTXJua6ze8CQXQqxsuT?=
 =?us-ascii?Q?QvwE1y6eeGSIryRh/5fcitRgPUkledfX05Z7ud6az9dj8+4Ft5g9dSp6OcDN?=
 =?us-ascii?Q?qdWMIbqWTMmEfqvcIEmdoxzCfEmBsNAfzmsZIDSHtXBvXw2dJxWPxR/xGa4N?=
 =?us-ascii?Q?Wl8B+CuwtlNMOZdEv6S37zwLK90hO3LZOPEKARAaeDYl4DnD8j7F4QPQoZfi?=
 =?us-ascii?Q?HzgqZd295V2295OUuOLrDKNknEWPMgBW5ZPfEcBPC/Ja9AqSW8ekGLlh11mw?=
 =?us-ascii?Q?aoGNaaz+3cgyaUFpHkf3Zp8QtFVYdzRZ1FTh2JcX63zDQh3zqbOTK1UtZknl?=
 =?us-ascii?Q?pdcTgbzwMbVheeBys8SavkSqZ4EVzCcRMnniIu2yn5PEkEt9gKQPTqtSRmjb?=
 =?us-ascii?Q?UKfI4vMVCzkfizP8NLHhKZmOBdPjRIizHVVVfWbbsFx/WMJ2D4rQA+QqRPRR?=
 =?us-ascii?Q?fKmLONhmMBV1Q7vQEGC+UETyuC4YDCk2pLDOKWHXANQ5dFeFKshO3MfnVxWU?=
 =?us-ascii?Q?Ku0Z/VsBCGkYG12CNHBdIpWKqQz9q2QUZq/k3+mTBM+GtmIQq3Te3X6F6Plt?=
 =?us-ascii?Q?MN1DZxY8gH7k+bDVxl3nTxsunNoFSoiLy+AvAlPjK9lHaJ4FTGCIbPt3XSWW?=
 =?us-ascii?Q?Q4jWZ90SBF5eUI26bLExhQGkXTQSr7EZZrqNT+g+eYltyiH1rmM76hBuzicw?=
 =?us-ascii?Q?z8OMk0RbrOkx3HAelaFgJbd7xt9ViG3nzNT+JuSRGlpvRgv5GH0DfOK4v0uv?=
 =?us-ascii?Q?LpGL+l315BaVcNN118T4jobwFw26T35rCXibzZgMFM051HK0LYcHCLTENHN2?=
 =?us-ascii?Q?csp6UjNi9lxdBFFcEHsnGOCA4GAOZh8XpiQf+9H8ViNpJDVrnPrFPJPOGSku?=
 =?us-ascii?Q?HHQpJrtIcGEEl7NpCmf3flhoGoVhyuZHRnC46rrfQ7wd9XAN1kO0yJGF95wR?=
 =?us-ascii?Q?wlU+Lz8NVmR8pBOnTsjCuworUxjOa1WBEYKwcE4LlwoqVylPgi4WmCGUGjmz?=
 =?us-ascii?Q?clViP9zI2nu3kxOwc3eimQrPUTjZD2+MKkNaliRmqh/qH/laZhITAiXpIg9W?=
 =?us-ascii?Q?ZLo8qzP+LHDYLuVhnH0UlXecr5ER4NvA8pXDxFELhbV8m+o6Ukm8FCXJkdyk?=
 =?us-ascii?Q?UsmaalGgIVLoFbVHGYe81pD3R6l8BRLt9U9rqaRfFyusyr5KLo84GrDkGeOA?=
 =?us-ascii?Q?QoKim5hj9ezAXcNjAkY7dDLHxBygcKVOuxAXlm+HAg9WQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0gSzONR8mc+X5Ev/L0ZxhAYXmty3JHgMCcp3T1FYfh8n51mfrxnjxaZXiHD?=
 =?us-ascii?Q?ogoYBpD/Z4dJB0TyijtLHpCH51G7zeZ4JpUk01QSx+Ak34Xj2eiqb5GGsX+y?=
 =?us-ascii?Q?ui6aUwJByPD7IMWBGy4SJEq5+AMsTM/mXdhwlKp92CZI1uBh3+hib91sD61B?=
 =?us-ascii?Q?1WP6Hxd53iiq10RdtX6wJUCKHS/+ud23o6ygPJsGEUx2HinmVQht8fuZ24wq?=
 =?us-ascii?Q?LyFvEdSPjgRComDbXzH0uh1bz76kSGiuo9FIFo3365LW/hLRtLP3AcsTyF+I?=
 =?us-ascii?Q?sMccn60JN2UgyL7zSw3GlBrMMN2YL2JXSpiiYam41Sefrjw+p+jghgrHAzPW?=
 =?us-ascii?Q?Mce31cFg0FMe1NbxMnmR/+RpT1QZk/rRcrZkx5TrQpCnPZ5TPIQC8N6EeAgQ?=
 =?us-ascii?Q?SCqnN7kMjXnwJ9Vpm+iEI0ycpRGDXpEXY9KjinvFKed3eeS2F7mYtaHPcRZR?=
 =?us-ascii?Q?LMSDblNDG2dr7A93Ao2zjfmRopEigkOX5YmreEAubvt7OSnha4vt60kRfna1?=
 =?us-ascii?Q?ITjYE0gem18fxiZ+Z5PI2v4d9JNW5oEAFyi189ySvuTGoyMl+hUT91M5pK/S?=
 =?us-ascii?Q?Cb61i2S9/FQaK6n1kjz6S9WBc424sGGbfKw8iWct39k4L4ayZh/3wCFhtepT?=
 =?us-ascii?Q?FGzBtX7PdVMmthOnDbtEeAEfh0ivexLaD4rofKTc7d8Smq7hQJeNtxSAmvH3?=
 =?us-ascii?Q?3gP9KleEoLMfVn16Rvlr+0MOZJpPYYg/ZZyZDYHEBQCrThEbYFKFaYTdIIuw?=
 =?us-ascii?Q?4s63s73Tklh92IDJVs1EQ1E8VRcUNHvj8SITELS21lVsLD+iPgY0DVAvnX9d?=
 =?us-ascii?Q?Q+GWGSuIiUt8Ia3fbXlBISJUQKaZX5Wj7yxsQOKKm60nn67M7ROyNroxk3LY?=
 =?us-ascii?Q?9E8LWalOIz5q5QiVLJoWGYKLtARsPe5LPqO9iTeHIqHhUyB+SV6s1HM0umeH?=
 =?us-ascii?Q?Ud1Ls6YFvShlp/fazubJdz03I/LVI/ZCa+3/LcXGgXPuEVSWu8Jn2PjvJz1h?=
 =?us-ascii?Q?QZeYIVc+LEZvWmi8VeUqjB46iFH99fJdsqEgmskhXqwenJwMjIgW/2baHw/w?=
 =?us-ascii?Q?vnSbnFE9MyQPvk1deai5bx63HqzYdYVugPOWCD2StTDXkQhTr/jQBg3EluKf?=
 =?us-ascii?Q?QD3dllhhcL3kZ/BG0WsfZA7dkZdv7yAZUB38UeFFXJgtFGyNGZcs3ukDwN8X?=
 =?us-ascii?Q?RsDvBklS9ZKhMpvV1Uo+jD/lOz730FWkaFz/PxjYonZobUaPSo1NlFnxZRF/?=
 =?us-ascii?Q?09dWyn7mK7fEJqFuAzNuAboYg7n18u5TNXk3IgWK5vl/zERNOUV5uo4hdPHK?=
 =?us-ascii?Q?UeiIgyyihaVgDRmRKZAiTGFj6U8+aYOfdr/3nq3OwaVGSZdVGOLCzkOXciG+?=
 =?us-ascii?Q?qln/I/r/e02DOY9QOZBtTFeoE10dhtrvblu9ov1I1FQmX3S42T4WXI0eWihJ?=
 =?us-ascii?Q?flD2Qm9RF744RWHF2Sk+8SEYGPNRJY1nklxOLVYwGhxTpy6tXEKR6jPO3LZA?=
 =?us-ascii?Q?VQawb3zE28HZHlK9lVEcR/aO1KXDySf/592JAASM3AsGLqhYDX3OcxR9pKYI?=
 =?us-ascii?Q?LOJLAFRUyFTadkyZlBWjtk3GZUyW0Ves8M3biJJ3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0859e93c-ee97-4f6e-2ae9-08dcc20c9ef9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:04.3465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBPfCgoAKpiB1MAXkmqNzflanCKQtUFqlOzFDuHBbYayNf6gsb/ley2015Gd6zDX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

This will link the fwctl subsystem to CXL devices.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/cxl/core/memdev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 15c36971fe43ea..f6f33f0f733741 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -13,6 +13,8 @@
 
 DECLARE_RWSEM(cxl_memdev_rwsem);
 
+#define CXL_ADEV_NAME "fwctl-cxl"
+
 /*
  * An entire PCI topology full of devices should be enough for any
  * config
@@ -1030,6 +1032,7 @@ static const struct file_operations cxl_memdev_fops = {
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds)
 {
+	struct auxiliary_device *adev;
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
@@ -1056,11 +1059,27 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	if (rc)
 		goto err;
 
+	adev = &cxlds->cxl_mbox.adev;
+	adev->id = cxlmd->id;
+	adev->name = CXL_ADEV_NAME;
+	adev->dev.parent = dev;
+
+	rc = auxiliary_device_init(adev);
+	if (rc)
+		goto err;
+
+	rc = auxiliary_device_add(adev);
+	if (rc)
+		goto aux_err;
+
 	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
 	return cxlmd;
 
+aux_err:
+	auxiliary_device_uninit(adev);
+
 err:
 	/*
 	 * The cdev was briefly live, shutdown any ioctl operations that
-- 
2.46.0


