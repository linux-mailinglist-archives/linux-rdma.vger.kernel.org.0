Return-Path: <linux-rdma+bounces-15043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112BCC5B8B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 02:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1B62301637B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2ED15539A;
	Wed, 17 Dec 2025 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRTqQo0b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4820B22;
	Wed, 17 Dec 2025 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935956; cv=fail; b=Vva5AaGaLdQsIYTNIjRDHJqRXgZFjRHzJ/pJj6k32d4WaIVoPMMXeDxh885X9VcxWKgDdqSqUlqLmeHMzYXHefB6CDnrZCty+eUADBir2/beQSYkz3UyKoEOOSJEeTDwaf9gNnbWKUTw1BJxunt244Ip0hwcVJ+7Ghq0CKIYmgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935956; c=relaxed/simple;
	bh=uUpa0Ev9tpJRtVWWOHTaiD/xk9s5AAR5egZFhG10xyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mUkKjY9TKlftFQtPlh3qek5w75XAQ0hF7Xuj/PcOlljBIt/Pd1MEuUr9gekja+ASaZlOGgOmwNKrE+Z37E/BWYRU7/7kvxe+0VQfKj37UVcffUtfMZjb+/EMhvA0uuC0ZnhZugxur++/uQlxl2TPPICdFKv5JuiCU/rqaaSApXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRTqQo0b; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQHSJZshZeZKw1uTSets9B7YFJTNqRG+smgpnnZFb7cvC5FVTJ4ZS49o0T9DSs9cCJc+SvQlPINaHjt3juW2HvlMTEv9n4jcalEfAvVuajmdf9GhJrQsHDvLmNsSq4Z1d5dFQQ4hnDb7nkAvajhws8Tt3H12epBrNHlOE1IokHWonj2CJ6v03d/vzfFxEdg6S+dlhVssPi/ClVp/DWrOIWXjMYo01weSKlaK/0isM82wL89fa+OE6KetTBElTBM/uTBCPmtoV/7qHWonTu2cHysDJO8jiE4awP5RzY6DY2pGTJJIflTgycurh48uFOxNGexj0aUcOwFISJ3ZqZ04GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnmaiznT634qhnTejGLecdX+oPQPoVIcGg1x/2jOpak=;
 b=YfI1pU8eicDHFehEGDFmHi7sfHcAUn321c99jLbx/127LIoy+pI8dDuZBjz/+CaO0ZLvwg7LHASugQDHjIwNw0/qgneKqrQOOBONC7xH6DPwE4/FiWK38Dddf91p04FY77ejlrTLFlrgbwXu5uDGkVQUrakxvTZurfnitnILHgy988VSKSFcxGveQpg2dO4d7Gmshbu2EEJ14T19EJpltVpsOhjqC8r9UN7JK9Y7tYqpr5NWuw9As+n0LI7hhDYrhZGzVdzY6hr+HAx14Uo5YBiCpQwBCY+ovp8FrrqGO69Tk8BLKbk7oIz9eRy/x3ZrBE96gChxnv1yJVoCroFByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnmaiznT634qhnTejGLecdX+oPQPoVIcGg1x/2jOpak=;
 b=BRTqQo0bE6R/QXlJRLB+v3f+vDqGhlIgOIj1+pKrRH3IR58BuuUfs8cgER9oybemsQxB0j0N8cE7YyXSkr03TqNAnXdEu+f1fTdFKVkJvHHd67JU7PBIGArx7cpsQiU22bVj0SApETsyS9XLWf7rH/+8tXdHjDeD+VE1fXLfRaWyAssHkuqYf/Q3FKqwPelAJVzLtdJ6WZ5e1zk4jqsNWAsWTuKuH0gsY8mvhE/VIV2hIAXT4MK6x00GuS9n0NpLtuQl7XIlLrtsEXABLok+c5xu5Z53CwbXxHIAZwc6XuMF0x7sXNZj5ksodFhG8mtqCJ93aiBCQoazT2RSl4YADQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 01:45:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 01:45:53 +0000
Date: Tue, 16 Dec 2025 21:45:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: fix rdma_ucm_query_ib_service_resp struct
 padding
Message-ID: <20251217014552.GC148079@nvidia.com>
References: <20251208133311.313977-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208133311.313977-1-arnd@kernel.org>
X-ClientProxiedBy: BL0PR02CA0128.namprd02.prod.outlook.com
 (2603:10b6:208:35::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c08bdad-332d-45d4-3425-08de3d0e0357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Fe9YRXKQqJrzKmEola024VtbIyeyjJuzjMzg9RSFLIsnnZ7IBSMVPcqAyPQ?=
 =?us-ascii?Q?grVA3LZ9jc9Wlq/w5k8A8fFMO3HaajAAmtsMw1g/f0W90A4l4jr4UOpLWMZg?=
 =?us-ascii?Q?Is9N0pwk1NW1QrFTGIkrkfAarWZ6/AAMCUpBeqEQ7LTf6VPSmtX5vZtyCbqw?=
 =?us-ascii?Q?lxk0Ht8Q8pc2gfXVXbQxbOVOy7rVjA56C4p91aubGTjJrGXL7+yXyiVwyENU?=
 =?us-ascii?Q?Vrod5P00RYAy28ChUcfiH+hDYnVUydl7cgtBuZhEhUpVd9x4ZnrNcoUH1cpc?=
 =?us-ascii?Q?C0RYyZAuWYpttTGUb4fKOx2qsoZRNQW1N3oIttIXX7a8ggqLJh0RAtuz8cFJ?=
 =?us-ascii?Q?wdL60w9pxO764LvODmtlS4QC7ThCSt8ds08Fn8umOtGLZgMQnusxT5r+LYhU?=
 =?us-ascii?Q?yjfe8p1m4TuJMbdHR1oVq/hHXRmmjbSrSIJA8K5CCCZSUI5I2jEPMt13ecwD?=
 =?us-ascii?Q?x56r8rBrqUVytITcDClts/PA2xr5EvHN4/cMz7Njgvi6WSXjp8qSVENprBF9?=
 =?us-ascii?Q?dIBHzT7FducoW/pnife57NvgIikyT/HAJwraMAy5s5YRnvBphhSufgOt3S0D?=
 =?us-ascii?Q?syc/YQ0YhSiz4i7WEsyOh8HnUh/91t6lUobh7n7nuZueaV+UhVQhxCQsQvDD?=
 =?us-ascii?Q?TSvdxAhFM1uH+czRLIzfAbPpZu6Q+IbH0jDA4qhJ7VrCj/h8e1ihGLYG399t?=
 =?us-ascii?Q?HB7aTAckDNsimalAl3N1usC4Lg9vsGVXFzuMuAnFGPdUOC/NcqZInelIHBi8?=
 =?us-ascii?Q?5ZmV0pID+Rx1qkEhXY7E/ZLhvYLWEunoQR6W3S36C3o68nd379FCxbRmFXAo?=
 =?us-ascii?Q?/qWEX/m0pJvX3L6ZVZLJAMwMB3hkxb7UoN0CMf821uoUHq1AzbW86xCk1Wri?=
 =?us-ascii?Q?oaQeSM6Mbi3RHEHjbij9/yteYH+F4l4i41Rai1BDYR0lCuYp0eDdD/F63BtF?=
 =?us-ascii?Q?eYxghBi6gFROdiUuoy+3exEoM/VoS0TPO+rKqwqBuiAt8rRXucmm2d4cbMxc?=
 =?us-ascii?Q?++b5knjV/ABC3PGu8sDM51SfR0G/xyBKvJOzeh5SxjB2m541izV/t1lJyk8C?=
 =?us-ascii?Q?Lty7X3QsMO+r0cFs+MwAM1dKWjKZfjporhFmoymL0TyDalYuF7uog5CpLNv9?=
 =?us-ascii?Q?cDJ5MAepCldEISLkz6r6w82g2u0ojHNMIoLh9tqjCiLpgZxRUF21LUKt3BwJ?=
 =?us-ascii?Q?IwxktyJwcUftclxRvS48Bm4Ld5YDSh6/NmHOctIe2OsiBHcoTeZQEvhsEZP2?=
 =?us-ascii?Q?Ip0Wuc22nG1qBveaF3/1C9xU8aBDAHrPc3+R1a2+Cj5rG76leXawZt6KE27B?=
 =?us-ascii?Q?dAfqiyMQ8mqGMeUbMQyXI9Ix8inYwA7C3890t5s9Mskijn8S02SLCLiVPqSq?=
 =?us-ascii?Q?8FZwGwvzA4O85loCzimQrvh7GxVqUjaQnvIZ5JFT+ODE99ugs3OQ1KXSBP7i?=
 =?us-ascii?Q?oWu4EsGTjZWTma3N9LNG2fI+XNGXv0kd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jr9DW643Y98un1E7fqHTGLV6inpa79RB5DCNjE4fTUrfzbABJPgckREHuuN9?=
 =?us-ascii?Q?dlwiCF2Nsir8o9/dV1lpjjm1iJxiVLd7LmmlMnusXyG6e/eO/6IHckLl9ma4?=
 =?us-ascii?Q?6lh55vj3Wp5Vi2slpheT1Z3Z0phaULbcTelp/DPt/X/rjqcJwn+XjIf7j8qN?=
 =?us-ascii?Q?YHqBcuOtmtsigoBOusgUQbra7924texBTh8FAvf9VfeEO9IMbcpAPxkU9XAM?=
 =?us-ascii?Q?uywTrO9dMr7JhvgiLS1VwSpWqxnWLhESEJNVI/3WvDVtPSbdO9NvTx4FQiEQ?=
 =?us-ascii?Q?zOOWlgh4T7G9EPVdf6vRFvbT/mqUVE+fHU0wWsGpRi6rpIBuiixmvG+QbYP3?=
 =?us-ascii?Q?8wpagIWLA1oD8DtOtcl1jRkof1Pi6FeO1rVH4fnbxnlq8CdODEF+YTjsEDY4?=
 =?us-ascii?Q?UYKtCZlCpPf2XyEdTP0+P7tRgEvzASStv2WibO+aw3WTdpvIpjy+WgOKUyQL?=
 =?us-ascii?Q?SWZS6MvaH/MKAZfXrBezUwTULy5mo9bND4TH9wB64PW2k8iisIh3tfUkvQRZ?=
 =?us-ascii?Q?lPoI96clqhjLR3Z2GikeS6/8HglAd9KwBLSHjNTaD89VpmR4TtUSUm8iDLf+?=
 =?us-ascii?Q?Z/k342Jci0o4M0L2mINyiPNR9G3alJ7lAxw0/Z8BtFEzkPFLy1nTLHxrLfTe?=
 =?us-ascii?Q?EAcvVzdgm4t4lMyJHgZyt9ZFVjilDwriqqtZUz4AgAkUxcJi8AEMwbStVdXS?=
 =?us-ascii?Q?1CyJLrnkBAMMDwYdeCbtFQjxMPkWBP0GZn2aEUHoDV0QnoYNr/h3bHfSPxja?=
 =?us-ascii?Q?3BX+NOgtiRt/p2Bscsuq3Xht3+WIsgQZxurx4mgqkq4YxgeO6tncFCD1Zu8S?=
 =?us-ascii?Q?OO1zF1jRrXTawbdk0uPCfCgB+yErJc/sRtv/WKcmeqxp8nEaIxFJ/18rlb4t?=
 =?us-ascii?Q?SrLUvkHmnkcZ0tCE6Pbd6XPUu5aly/AaXTMGutemBuw5lqncc+lXj7OoF17L?=
 =?us-ascii?Q?3B5m1UHkKpE7FYQ6YqoVNKOZC0B3b775QvtWVHYTLRTamZv+mn0clMGbPJex?=
 =?us-ascii?Q?aB1xfs9E+4osjC4AzrKFnuSlKTiL6ncpgINj7RPOh+NlgYQzrE9F4a8bF9tF?=
 =?us-ascii?Q?yD95kjc/+OChXMh5jJQTwIdmdtDbPUtAH2UrsnfThStD3gqRtlxln2tMP7dQ?=
 =?us-ascii?Q?HnKv25Bm5/0uoM0QT6T3BSITj9ZxzS09/xk/+I79sUJmv4mS35kzV5g5OsLc?=
 =?us-ascii?Q?XkF84uzx3EnaVU+LUDWatWglaqIRKc0icsHzvnnyNph5doAjOm6IzdrGwN9c?=
 =?us-ascii?Q?KqaeN2M0AtNO85AdFtFRXxRXL3dHopgwNREgI4HHqDi8P5OKnR3Wb6Mh83/H?=
 =?us-ascii?Q?jVEVANaLMnaZtV+XFtt3RT9+PBCHfhZ7Ot3PSapGgevoRqNagUaUQ9rHUh49?=
 =?us-ascii?Q?xsQ4z4orpjWF34xgc62+qMd75Piua3KkS0zRSGaU9nwMa53NuTB4Ux1Ll0cf?=
 =?us-ascii?Q?Q5EThr3UZ1E5w0NikFrUwOAxf6e24UX35J9ChiIsVaiQ1ZRLUDqxYHU0DCim?=
 =?us-ascii?Q?maaikdYEiLuRVH2uzOKK4nCUDA8/0W3VCFDjIqw6tJrkPXOwt+zTOJCjpcJ/?=
 =?us-ascii?Q?ghTyNxYUNxKkVXxXg2o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c08bdad-332d-45d4-3425-08de3d0e0357
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 01:45:52.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6chEonbJvVI65B50W1eckZKP1b6QG1qZrTEKBT02+rS+YiHdM7dsv4MhsxhBBZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

On Mon, Dec 08, 2025 at 02:33:05PM +0100, Arnd Bergmann wrote:
> diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
> index 5ded174687ee..8e1d584f6633 100644
> --- a/include/uapi/rdma/rdma_user_cm.h
> +++ b/include/uapi/rdma/rdma_user_cm.h
> @@ -192,6 +192,7 @@ struct rdma_ucm_query_path_resp {
>  
>  struct rdma_ucm_query_ib_service_resp {
>  	__u32 num_service_recs;
> +	__u32 :32;
>  	struct ib_user_service_rec recs[];
>  };

RDMA doesn't use bitfields here, I changed these to be reserved like
the others.

> @@ -362,6 +363,7 @@ struct rdma_ucm_ib_service {
>  
>  struct rdma_ucm_resolve_ib_service {
>  	__u32 id;
> +	__u32 :32;
>  	struct rdma_ucm_ib_service ibs;
>  };

And I added the missing

 struct rdma_ucm_ib_service {
-       __u64 service_id;
+       __aligned_u64 service_id;

Again, like the others.

Applied to for-rc thanks

Jason

