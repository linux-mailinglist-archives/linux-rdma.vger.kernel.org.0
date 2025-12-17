Return-Path: <linux-rdma+bounces-15053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BECC973A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 20:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5453026A99
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 19:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E86F2BDC03;
	Wed, 17 Dec 2025 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QUpcdJnK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B024E016
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001516; cv=fail; b=btRhHZV4yGk6y+H7AiVrY9aemuqctzQL2SU0WdyFE0611p00D5AQz1yu2fbDTM6qeBGNuuUHviEaW4i1/CNyRN7R8WNGmflBVCIaqQWYN+z+1v3iJNLVdbBwyduurirNlhllHKkqxg42+SIApt4lOZrksXWn9YEb2zJ6nq3Jwc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001516; c=relaxed/simple;
	bh=FpP9doRlagcA1gM7QLdf8q0OMpUkaq665XJiHH1ldJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cThFPTz0FsybFPWutaGGMlOxPBhIuVPjNxL2gTx0B8icqiCytVWgJncd/NmRHoE9cIAotWd3IN8z9l6YGWoDoDQOsOW7SJmDuGiGGr4/3d8wd7VUzDfj3MzMAHO6f6AfhXW6CD6pZvzTDhlv+mWWKHsP9esB/lsTiT34ii7BjKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QUpcdJnK; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9Hi6kUtXmmlRZJoMdrt3f19WinuxQCkWEsGd/sasxiz2IxIt7894WtXeQLTghq30Z3nbJWkc9BD7ST9B6wKOmRGq15/uNW8LuUpRXzRcHDIYUy+qrZ3lTwoVL+MGtfmLE5Whrjm7UgtNIoQrx330Nud+aEVXgN2CMVlWEMxyGnuMOgTbbhemYNGM2SCnIX4zQ/WTcv7ipSdcXg5chOrY0/PEGAU4Wz8u1Hs+0wcyyQjP/4zoKkqsGk1AJ7YFSqrj9wZ3sarQrX9fY8vrls8uFS7fuj1AXjh8MH+191gELteYqBy4k6YT7c4CRWYgM8+7s6dOasny/6dCdO2WRzi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LanNTmSRI5vUpyETV3X83SslfSOrhzXUaaIbEMw2Pw=;
 b=baEV0JJrtMeFI8KeZ6QZaeEgthwID8KUGwKlWBOh9cDcIB5WdC1GzVzZdTjX91Aipmg5YFbwVFCYQnmt6zdDo0IJzJN1QR2Ii4yLeAbQAwss+INNylCra4/W3J2HQSTMRLKZXRFS7qeo92WwzUPiNnTQTUS9Yyytl0VcbXSwla4gq4rnKCZMl13DH1WI/uiqyp38x114gueihTU/+Smn6AjOSKIigIAucwPBgPc7JzmV7KuqubdXC4ABqYz3S3bBzj0ojNzvJva7U1Zp4FRwWZ15YZ0p9vuX6eT8D5g5l477SUy+W2BmDFT574niCWeJGAQgCvyBUcfH3FWanBEIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LanNTmSRI5vUpyETV3X83SslfSOrhzXUaaIbEMw2Pw=;
 b=QUpcdJnKhIrQQ8Bpat5NOnegd/JwkfAhfLyYsF92P6GU6NN7ZYzN4cEMTfcpzHLQJ83JkcCn4fsf0ToYY6hH2udErsFX10BQ8xzycmB+EvdEXBUK3h8j6oHHY6Urt6Jk0F/94Eb4F60LkovojpmaAB8zeX/1yLY/uR5NCWiabdyDrdcdJHAh8TktVVNQ1jJ3MYMvSeEV8QMlNEGa55M0uKjRgN6sC/YTpZHJ3djWbCLv8pTFKCBZtZM6ZgTCwK501k5MDczmMwDTYA8IOFVbYUtddlRVP53w2liUv+v1Wvhy23WLrDXemfpBXYPZa9A/net1hb0EaRYOwB7HHGBXpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 19:58:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 19:58:29 +0000
Date: Wed, 17 Dec 2025 15:58:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v5 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20251217195828.GB243690@nvidia.com>
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: IA4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 82425b9d-7d7b-4eeb-4752-08de3da6a60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6WlNl3jyeQ5PNEkowzXguc2zVbUbkBe0FoHGjTAiJt29Fx3QAhfN3ED5cVlS?=
 =?us-ascii?Q?dnZKVkRvjatz3oc9GReV3UNP7CXWf3fnQGPYPhfYGLOQUPwUCkZczlNSzxnu?=
 =?us-ascii?Q?XVfnL5OUNwdVshPZ9cTTNBQX/mAYfSRrCgmDvUt5DOBrhJp8qmarHqK5/anb?=
 =?us-ascii?Q?Dmh6B5iJkuabKX6BdePgFs53aOKTbvjG8lr6zIca5UDVDz1QMhkAmGhDbEsp?=
 =?us-ascii?Q?3Ke6XhuMc7e+IuuJl4QsQ6YDZoqFYEHJZYOMVBtRXmp7YDRymKtwXHga3Tm7?=
 =?us-ascii?Q?csn9I4o8V1yiFaaXiQajzwfGHpPjidr680g9to/GWpuYaJHKP/cD9RW7cSuL?=
 =?us-ascii?Q?lLkf3IcDXV9o8OSKMweCToY+/FHAzl5WWij6R5mW8ZjrYYHO8NnM3E4YiL/U?=
 =?us-ascii?Q?Z831OkLFxhfXlrmxNEg0jN6U51KUZGH2dI5yrDKy2QT0x32JfXR4GHRIABe9?=
 =?us-ascii?Q?MjOR95RbF0CdYNypMMN3UOISPkVybN1WeY/sfFIDVO4LRXuNw6vZLv2becj/?=
 =?us-ascii?Q?BlcB+FhrHJMnXxG1QWvtsHsMpCS/Ee8MrTp14RotGMiqdbaJrog8sFwUIpH8?=
 =?us-ascii?Q?/1p+XA6q3TCBIndq9fpXBoXySZsrELP2E+lJaj85dwA+/KObzcWGb+HRSRyK?=
 =?us-ascii?Q?XbwvvEyAkk93pmJ+45er6MeoXQwbzamYhWzOpAXFmYksI+zRuvc/UnH+x/Yi?=
 =?us-ascii?Q?8lGI4a00ZCwPfYoNFeRd9PLjhUAqpcFg6HJx8WstTmaUgO3IdizbN7X32jJt?=
 =?us-ascii?Q?HYpUlUZuvPprvaG5VOqolBOxAHIMl8DicDhnXBOg/MdVJqR3SOAnxlBXDOTc?=
 =?us-ascii?Q?ZHFfcBHqYGRdTFOwq9KSxFxphkUCIO7Aulc/kwNeK9gmx+7CzAM1OPOvzJ34?=
 =?us-ascii?Q?b4cbtAI4lU42ls6skPU9Xo78RrcPUunPgfxS8H426Fw4JJlLV7anD+1wqvC/?=
 =?us-ascii?Q?+3wSYfCjgUon8cfaQG6X0MP5vmDI52l/XBaDSXO53J68Ix6HuQjnGd182IhI?=
 =?us-ascii?Q?24ghgIvIuGoFH30z40wrnkVmYD3VDtpk74bWDqMfe1s94v3gll/g0YDCr85V?=
 =?us-ascii?Q?us1oTsdpwrhmWmbanGhtqzXM7xEjqks9qR1mEUZQMsbVDo4xxnZBI8kmpPcd?=
 =?us-ascii?Q?QZd11TblOPse1mpfokEk4b1MzyrWz4W5gd9LpjvON7G6EEYlDYO23qy+SDoN?=
 =?us-ascii?Q?L8zNcSKvUR2jdiBwCG70c8gsSZwD8VBXPqaPsPHT9npejX/B3x66GIb8TGtL?=
 =?us-ascii?Q?tGTukjwm0GOWm6oHIESx1ViTWj7JkXfTTX1FRTkLfi/Q2EVu4ntsAbKC0ilA?=
 =?us-ascii?Q?pKBHT/5XSA9y9ZsAHb09LOkjrBKJMcC7dTITa2O6b5FU5ve7M+p0IYoT6kuu?=
 =?us-ascii?Q?XTseaJUUzj4fi15iMcXSuiUhDk7h73RYTXDRuUfhvMumIIMH/KfzicB8oW7a?=
 =?us-ascii?Q?rPqZrJoan7bf7fx1lqXLqeXyD3Vm4NbH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGOxVDTA0cQGJaJJ0JHnE8h5J+MXWP34ICMYBW03ABIhlL3PUHiNT6bJrQ7r?=
 =?us-ascii?Q?m3H7WSLC7nRHBtCxKHO0vci34acYMOFP6lg/BMhrjWxmf60LNxOvKQC+iTox?=
 =?us-ascii?Q?4top3DGwXZrmosfHMMhoJf92SUA6hWi0DEm/8GaBpHkKqCQoNZbtkrEhsoMZ?=
 =?us-ascii?Q?+vOlxgdtRO1FGdkHhUN6KBMsIvKSEwJd1hc4vnwHfJu1yXfBUv2QbHTFzbK3?=
 =?us-ascii?Q?NpxYDn0Q2ouw1TW0KJLSnsJ5TjaAzmPnsbYu4cr3JBl9dScutvdCYEvorzRp?=
 =?us-ascii?Q?YwkRo82SbOYKyO0VEp/RNZCJe9EcAceTesM/FIJuM5myRJq17o3Mf4SuFjrP?=
 =?us-ascii?Q?ohPWtATmTKWneY5aRY+mPYYuk1MIlHeVyOUZkK3szUWDZjxjZvCXse6OYi1b?=
 =?us-ascii?Q?Bz7HRNBp+QcbwuKHxF+c1UoErIsnbngdhLNKXo10iJnn362+m8j+OtZx5TI+?=
 =?us-ascii?Q?QB3zOkUDpX1QL+BEDZlHFLp96cMn4B48i2gpt10ftzoedX3XBbHAU0qzzCFj?=
 =?us-ascii?Q?vozT6ZxPNPr1EcNTbwK22LkNZ9XmTqzJ21RGEzUb7g4SJLveGNHPESBiyIfC?=
 =?us-ascii?Q?IT8yYQixAX47zbmYTNNLmfKCdy36/AUgvzkq/OZuv+kHDXiIZHbnJ7ukawX8?=
 =?us-ascii?Q?O2G1AjSADV0z5FUHwrnHxM35hhKILc66eOGdxjffaMClqiV77QE8i5wm/VJp?=
 =?us-ascii?Q?DN9T7whJi0ImB+1QJwlZ2FdbOaViyGkt53BdhRG36hmnkqYPeQe0YF5lgAdd?=
 =?us-ascii?Q?D03u6KX0ouKuQvmY6BC9TtTRiR/fajcXod4Ul2S/MLAgD7Lac+DynwlH8ihS?=
 =?us-ascii?Q?NsU77CEgPc0NaTzbIMmwkcsfxA3NxRRWy181WyW0a5hRHPsQ2y+jxnrVnnzE?=
 =?us-ascii?Q?dkCiYOMT3xhkgzSjlaKSPDzQXwhnsMBJuxwDoGIa7wh9WoPQaSz6DMqoT1vG?=
 =?us-ascii?Q?KWxhoVFSn5ibVyIusWZd5kxlJa9xYu9nfS4vmRzxCVCzkO/1FCjedC9E6X5r?=
 =?us-ascii?Q?4veAtlPEDhXcQg7uPmE/1NdjOl+KNJw/pvUNrNtyRO5yY3uieTAJUYQe4hkM?=
 =?us-ascii?Q?1HDwTLeggi/KbHuHlqRXWJ5c3JlMXq+MnByYzN1bjh/EBu7qXqZat9KuQMRq?=
 =?us-ascii?Q?Lqw4Q0KrH5yZQHCg0VSPSBx//Bo2Y3snZi531itj2f7inJk4YFTAMgzpRf2A?=
 =?us-ascii?Q?iJzolavqsQgM+KxOLyPaqOVxC+k2HSXQaPblMNUzGroDZRF3bqym98Vi2tzJ?=
 =?us-ascii?Q?lgdlF2rkiQYv8zPdSTzwXSNpq/Vk4iKV7JdBMME1UGx7CUbPkIK6G8xtIcoj?=
 =?us-ascii?Q?E4/btBLKNZzbM3bsZGMr+vIrJgJIndaaZhhkHi+ebyEnXpPil254gpqHl7/S?=
 =?us-ascii?Q?1iwUhhUy68X5aTBWIQx3aqs1llSmey9/2vrHLp10sEjAdv/W1+EtbjbFiEIf?=
 =?us-ascii?Q?4PG92aRPxShTwgxGifzoah5EiioZ+O0ebVsgM3RGFoZ1BDaRDbZUWsKCJI1Z?=
 =?us-ascii?Q?BHImyPxDcbAfKYvWx2BhT2yZxI2BEgHLR32tWF6V8bjQvIAgOX1SqVSusqhe?=
 =?us-ascii?Q?tgZ6ejBypvCzzG9Bgio=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82425b9d-7d7b-4eeb-4752-08de3da6a60e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 19:58:29.4291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3z2Gucpr1sdHjuzapGipGYBz3EcBDGPbLulXlWpFasqSTcufnVVPSaw2VkL6Kr8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073

On Sat, Nov 29, 2025 at 10:24:40PM +0530, Sriharsha Basavapatna wrote:
> +DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_QUERY,
> +			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_QUERY_DBR_ATTR,
> +						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
> +								   dbr),
> +						UA_MANDATORY));
> +
> +DECLARE_UVERBS_NAMED_METHOD_DESTROY(BNXT_RE_METHOD_DBR_FREE,
> +				    UVERBS_ATTR_IDR(BNXT_RE_DV_FREE_DBR_HANDLE,
> +						    BNXT_RE_OBJECT_DBR,
> +						    UVERBS_ACCESS_DESTROY,
> +						    UA_MANDATORY));
> +
> +DECLARE_UVERBS_NAMED_OBJECT(BNXT_RE_OBJECT_DBR,
> +			    UVERBS_TYPE_ALLOC_IDR(bnxt_re_dv_dbr_cleanup),
> +			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_ALLOC),
> +			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_FREE),
> +			    &UVERBS_METHOD(BNXT_RE_METHOD_DBR_QUERY));

This is not a "method" on an object because it doesn't accept any
object ID as an argument. This is just a global function, so it should
be using DECLARE_UVERBS_GLOBAL_METHODS().

It should probably also have a clearer name that it is about returning
the ucontext's DBR.

>  /* DPIs */
> +int bnxt_qplib_alloc_uc_dpi(struct bnxt_qplib_res *res, struct bnxt_qplib_dpi *dpi)
> +{
> +	struct bnxt_qplib_dpi_tbl *dpit = &res->dpi_tbl;
> +	struct bnxt_qplib_reg_desc *reg;
> +	u32 bit_num;
> +	int rc = 0;
> +
> +	reg = &dpit->wcreg;
> +	mutex_lock(&res->dpi_tbl_lock);
> +	bit_num = find_first_bit(dpit->tbl, dpit->max);
> +	if (bit_num >= dpit->max) {
> +		rc = -ENOMEM;
> +		goto unlock;
> +	}
> +	/* Found unused DPI */
> +	clear_bit(bit_num, dpit->tbl);

Stuff like this should be implemented as an ida..

Jason

