Return-Path: <linux-rdma+bounces-14666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6416C761E6
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 20:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39DF43596AF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADB1302743;
	Thu, 20 Nov 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thVUQy5K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B512ECD28;
	Thu, 20 Nov 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667993; cv=fail; b=I2u0lHfNtjskp+Wtkr9fB3NLlWADsC/AnEVYCwr9y7H84o/U77bXpUQMqoShk1fJmquKlNRFyVhATYWIHc3JHLb40Z1mxIL8Sq5zEU//E1sjiE7PGpQnEzNHR1sSjjwmvFpVBzxg2mcK6jJQoMWRoOc9opnGZBb3M74u3UFJHH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667993; c=relaxed/simple;
	bh=BbHJP+qV/jtMRBuUu3bPQiSTHf7cGImHdnm0KWdEamg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REyU1izUGdfuzFhP0AGELeTKqN0+pUMQiCBYHveBFZrLrknlwUuSKpop7hpsxbmbfzr4y+Z4yo3JyqRGX8u6pNtCoYN2xxqadnGZGnJOjonIHhivnvkv4x4SXIuHny/HdzcYh4cRK5VQ8FoDzsBxwMKrDCdTtPsFa0A6FIZnKEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thVUQy5K; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1mdcoxMFYxkP45uIBq64fzEgU8nudtZLcq6cvpb9zdn3mqxZRi2PWE78kJf9Bz9WT9YnSVET5uykYpLAja6e/dUjzFwUTYVOEI5t8Gs9nyaRihpk1uoxE3so4VHOu0KNUzwXT0u1a+HL79huzuB85fh1miz9lOj6+p3vUSZ77x0rZns0Fsfkfq/rGpdPp4lksg1tbz+fyjo2qIc88V3niHa62B0VxJIHai4wh5BORt2d14kUYhisfWxW0cpG780zF7inQ3mjJMJO5OOCGMUmxChIVlire1tV4Dm11qPc77JeXcZpGqcOta7e6dHQi+08VycMIzAyab8fkxMiM8ZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBcI8fJ7pSO3kvEaeZGqBjP65dc71xIgYON6aI3pnHY=;
 b=fUEWFb3dw7f1LqE84abv89XQiQ24BneoHmhmeRYx6rzvWpsUIb+XK3cYe54/ZRHtWt1AVDZrMqcuQZDwiCT7OZECTHP+2XZbGWpIjLolbRveOeqUZa8Gsb5ddNoFPuRGFiSDLoZeo3RXFpTxTZQJBXjx3i4T9bnV1JRt4ltwAM0Tf9vPf6L1TdCaY6hvg/P3NDg1JVaihFM/6n4eEOUtUL1k+pLs03uFNp6JFQSSM7L+1WJFgoNHZZZE6+5hgI1trorGm6x+L3tieBuL/nnakXhW4dPUzTj1DEb26VMGarUqXz8r91Q9MKH9jVNKFGT2kE09TAWPxcI2YQ88Us2Jpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBcI8fJ7pSO3kvEaeZGqBjP65dc71xIgYON6aI3pnHY=;
 b=thVUQy5KHouM2jcSNUKj27hWp4kNcqWugQVwpHei1z/9geI3LWuUZPSxrP+jpF0Cf6vYHK0TbC80IRE0Gr3qGbaZGZlm2jp43PoOVit/Mcv2TCxDpYEmOtCyP4YqJ443doZJLdVTMTGKR0KYHD4O/UWEG4IMhSuG8Ac7QoHOj7poE9xK5VSCBan7JUnUQKLe57+Nh5w/pCE+Uqqn0+/NQGkw7FGAq9SVzi1OAB/F1UwxQJrMujxvdqGJv7qmqK8daJ+040HhH4DMXUyfWlCK2z5WodR9YffKZYdQ2eE8KMMfMI+yrcz8Jl5x8w0EExa+NMPiW7AglatlYp9W09skgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 19:46:27 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:46:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	patches@lists.linux.dev,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 2/3] iommu/amd: Don't call report_iommu_fault()
Date: Thu, 20 Nov 2025 15:46:23 -0400
Message-ID: <2-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 34aae8dc-92cd-48b3-99ef-08de286d7d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65WBDMgqqVAxZnVT01bMGM8KdydzV7gTMizu0QelHI5S0H99G0ByrV94gFN3?=
 =?us-ascii?Q?hzeBtta6VibAtVYzNrITrdajQPlrm0684H272PkeL884rg8JJ4ahd7PpgtKk?=
 =?us-ascii?Q?jcrtCI5LMVQP7oqXWSPJPKHs6V2nDft4cNu0aCrkLDWXxmiB1AnAKFjIpG0r?=
 =?us-ascii?Q?grtjkKTW/MJG4L0u5kx98welk8hos960+/7C4JiGvJj0fdhnZ1t/JTZndMcz?=
 =?us-ascii?Q?ttC+0oiKQIfMG8FOPoLCL3lOcGBHRUggAbKKEENtzxo1jbwAdtUpv+EQWB17?=
 =?us-ascii?Q?esa70rOVRs7i7T18NZRZcP4qXURR82+Ci8HRdXPGssFWwV4ujgb+A1AUAw2O?=
 =?us-ascii?Q?+VgJtZUZHZW4g9McWjXQ3ZFBRzh8ph93xelRRoFlAHVarywduSH76YS5ucYD?=
 =?us-ascii?Q?dEiqUtZQl1tLsBi3Ph8nkIqusO9pYY6fk8Bos+BcBxcbh2fqfAgp+//QnorS?=
 =?us-ascii?Q?o/U64FNQQYRg4hTCEvAvtmgA7NyiINi/462lv2Aq8qOxbOB61EM5Co+sjphJ?=
 =?us-ascii?Q?YkBFpCTPHwqGAHoslMwSGMUdfUlNBU7F4HjH1oHPyJ4PIyf4N0M3ApFtSAOB?=
 =?us-ascii?Q?04YjPOdsoWYPnzEB+Uj8D82tQaBcNkPJNmDlEjOXYNO/WXOS+NI98h4hTr5C?=
 =?us-ascii?Q?vvU+V3jbmEOufE6JWh1bFXi9oFLZh615vkvnV2RYQdEj8QBVcH6+Y9wCuiDc?=
 =?us-ascii?Q?hTwqEyj5m+VqRpk9Q9OXntE6V1VIerRb/RKpl3wU5lOr3Bxh8v5mM8A8uOz4?=
 =?us-ascii?Q?Ni1J6BbnXbRnTy6advkBfChfVrGQRwwOU9rSb9pT+YSzD+t99JvJlafwKTpK?=
 =?us-ascii?Q?Hvc9gmBl7EcXkG3f8ebolWifJXB+crt893R2qOcJM6xVMDQXEaAHa05A0ME5?=
 =?us-ascii?Q?I96ycfvPuxDkk7ilJvTL2+6+gugRbl+NGC6m30RoqforPfUTTx+7oz4LBQz9?=
 =?us-ascii?Q?5ZchrksuMCcgJtwBd4YTLHLmMGvKbzlBLVf5Q8EK2rPtjPE+Mt+RT6Z7PyiE?=
 =?us-ascii?Q?MqbcEqF/mL+5G9s/4+AhbEhoz9J9of03C6zC0Ao6bBmgQxLftas0sj3v57Gc?=
 =?us-ascii?Q?PvK4srA/hpYZDURotvbWG1mcQyl2IsfxVpK89n9632auwJiFLbKKPkZCFLka?=
 =?us-ascii?Q?yFnyDv6ehwVn5bWKa+Of1lEqu9N1LneEFYtyLDQZsKCvk4DFFlN5IdI/aghj?=
 =?us-ascii?Q?vbgTIKtvDAHh0FFfbpbQYPMO4iPEhI3cWIq47VDXlVwLYoqkhL9rAZRQlJk6?=
 =?us-ascii?Q?67oGo2oG5G6oI8sNS+zwN8bdoHX/o8UK7SFvWIc3LY05K2qDlPQGv4gQiCBr?=
 =?us-ascii?Q?w3PseqeZu4gqn5NscVMZhn8w5buX+9XwN1C3XKBR3rFGI5a9KAc8E0S0DTFx?=
 =?us-ascii?Q?2zwUZtA2vK/oOdeiMnzDVKPY+zNyhdiIjPrjYgvtOO4hTCnc4QpkABC4kcyZ?=
 =?us-ascii?Q?Jg3jvAXPXkOxEXychLWR/1JyaTn6QpveoO4+6hXYwVNhDuhMWjf9TQboRz8L?=
 =?us-ascii?Q?eyL7GfDFpUUW3pU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?snkVGmDfxOTIr24J7weG8L/S32SYsKFi4c/knUOwI6WdPZr/12vcqdf8oA/G?=
 =?us-ascii?Q?355mTavySO5GZEWQyLsblrZ6FiVJYVodxK2ChkaoiXxs3VXHDqomxPElFL3m?=
 =?us-ascii?Q?nbLlD7eQX5uRr8mhUVlZAqmPgfUjRtin4xC8tD6R081dRj2e89BoGcZRsk6V?=
 =?us-ascii?Q?KsZFztV1l0bD/iSJGL1MWFdPzVRFiNlRZp8kHaAB/hU7oOICIc/yKeOH32Ir?=
 =?us-ascii?Q?LCo1l8PMp1kS+qVNfnbEoX/xp9WoQfZeDGPDJzBi61rmObiIF5/nwohkvRar?=
 =?us-ascii?Q?uhGlmxM0FNvDhVtv2tErf9Rzkspt81j/oWvqYN+6KK0RPAcWHAkk7ZTDMQt4?=
 =?us-ascii?Q?D/SE8G03n7jAfHlsa4jUOv4MHo303wcpdcPutuNsMc+fqs7Bc38FAWzJ+oe9?=
 =?us-ascii?Q?zidDxcZMYb9vM9eW/F698nHAQouDl7YKFMT/2q6VxE6A7hGV5+dyl4hZs889?=
 =?us-ascii?Q?7pEjDBSnzCs5pnhzdpaRWzm3MkFot695Z1SIznHhzPYYLWhhtCL91u0qwjSk?=
 =?us-ascii?Q?/2JoWJXnGUzSKgULbdkbeojbkAEd55aW+MUKxZvc4k34XBYm58oFwclRdPNK?=
 =?us-ascii?Q?bIo2Le+KqxQSgaKpPYMnQmUeph3ZL19WKECzSFkq8j7OWCHMagnIG32012Iw?=
 =?us-ascii?Q?Ep1Lv/7UAWybwQ1zgPVMt2rGo6deGn93y9ThT3LHsBNLP6uCcZq7/kgSXlV8?=
 =?us-ascii?Q?NZGWc4SrEPY13tZ4sJeHD61g9gI4ifq6Ois6DTKYCndwKTpLuPSShdriWOUV?=
 =?us-ascii?Q?E6r7rMKvnPlWl0SZ40/Dn+bwne2XZ82cxmHQClNyX8ui2r5D0Z/tle9uDQVV?=
 =?us-ascii?Q?AzGCxMb7rzUKQYt3nMGKiJLtCiLX5NpPf0eL83rso+Ykeu+FlK9CZmKiEbVa?=
 =?us-ascii?Q?NwhwBKnQshqcwNLu2ZfBhlE/1pfHGkrOqw3M1CsmDwnSZEjBJxliAsOATOrm?=
 =?us-ascii?Q?rxFfk9FSsXTY4ZEjuHAJOZvaljwTOWaSZ5l9q0X/YBC8I4Abrh3mgUDVNasz?=
 =?us-ascii?Q?XrhV2sbofApqqP6CKy+KVYis++tYBat/1L8UQXxJALcNWY/v/rJFi/HlYuLw?=
 =?us-ascii?Q?ET3qbHGWMq7WJOgoUlejDSwF1Dl+pEmtdZOVww6bZjn8/1+pwtVaWM5ozUZW?=
 =?us-ascii?Q?Uw8kUnwed6xJ6QBx1/WHXgkI+gZLPcASfFVkYH3ozvA61nQeY2xCvZkrsf+f?=
 =?us-ascii?Q?mj2LAaPxBB2aIv08YV6H+AN6Lg7pOWYzhZ1mmMiT+0EORNDb+SI/PyDcs6S1?=
 =?us-ascii?Q?G5ximBD05ameSpRQw0V1j1CySzDmYsb7Sw18mwwVS+Hxjz/EfeFyLk6rTEwf?=
 =?us-ascii?Q?cr9pwHP2Ad+hADUdS+83C+3nr6of9d9Moi2CrFGsxTqV24443q1LCuv55SJ4?=
 =?us-ascii?Q?mpBB9UNCZ6Y2l+aQ1Gjfc27qeBfT4r5Jj/rKamgzi0E4372rl/Fp/OP9Zf2M?=
 =?us-ascii?Q?y4GhGlKOVUra4+jyCcTL0hoPDW98AIewxfuOuN6b2U/vHrx64MxKOptBiUnz?=
 =?us-ascii?Q?8W9pheSYAZ4fv7wAlmvHTQSXFVHdwNNQPnBKU3AoxGRMEoS/pulJao84JEtS?=
 =?us-ascii?Q?qbfmxGBaiZWb0p9gtoE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aae8dc-92cd-48b3-99ef-08de286d7d50
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:46:27.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHNec6i9hVUVCQocpadLPyw5PwiZbHq45EnfkOSdAQH3TyTDBQWEroZnDXmzXi+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

This old style API is only used by drivers/gpu/drm/msm,
drivers/remoteproc/omap_remoteproc.c, and
drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.

Remove the dead code to discourage new users.

Also remove the domain == NULL print because it was intended to protect
against a NULL deref inside report_iommu_fault() which is no longer
possible.

Just always print the fault in the same format if it could get a dev_data.
There is no value to be gained by also printing if the domain is NULL. In
today's kernel when the dev_data is populated the domain will be made
!NULL very quickly during iommu device probing.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1cee8..072c80bb2c2b3a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -840,29 +840,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
 	if (dev_data) {
-		/*
-		 * If this is a DMA fault (for which the I(nterrupt)
-		 * bit will be unset), allow report_iommu_fault() to
-		 * prevent logging it.
-		 */
-		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
-			/* Device not attached to domain properly */
-			if (dev_data->domain == NULL) {
-				pr_err_ratelimited("Event logged [Device not attached to domain properly]\n");
-				pr_err_ratelimited("  device=%04x:%02x:%02x.%x domain=0x%04x\n",
-						   iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
-						   PCI_FUNC(devid), domain_id);
-				goto out;
-			}
-
-			if (!report_iommu_fault(&dev_data->domain->domain,
-						&pdev->dev, address,
-						IS_WRITE_REQUEST(flags) ?
-							IOMMU_FAULT_WRITE :
-							IOMMU_FAULT_READ))
-				goto out;
-		}
-
 		if (__ratelimit(&dev_data->rs)) {
 			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
 				domain_id, address, flags);
@@ -873,7 +850,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 			domain_id, address, flags);
 	}
 
-out:
 	if (pdev)
 		pci_dev_put(pdev);
 }
-- 
2.43.0


