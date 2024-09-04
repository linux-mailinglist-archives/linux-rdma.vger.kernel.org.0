Return-Path: <linux-rdma+bounces-4757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DE96C496
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA191F222A4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354121E131E;
	Wed,  4 Sep 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGkEfWi5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498771E0B8A
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469144; cv=fail; b=YlDoCNdepOUnGJWK7eM6DMwpwl9DLO+97K4G3FH9xqsdjYbO+Xq0WBzjovy0FyZjIbWNQXw25bkfXD4jX3gvoBnoRouan2Ivu4ruApAyH417f7yinC3XUFRhrkwAhnjx97r+v1gaR1ijTHD1z/cbeLmA+lftPI3RNDsjyowtbQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469144; c=relaxed/simple;
	bh=gzJ2y5TBcAmHO6IjbFrFo984daLAyuJ7hLh81uvTcu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FpzM10SxIwAywDevIjSDmlrNrbpsG2s79iRCe2hoB1+gwxKYVRsSKCEJYp7gwuHo5nGZ+SrD/HoaQ4KlQAmMpkvGX1RWdnGWTYavuPIk7MSQ4U6HMWxowjb4/PuzjgXLLuKglVWTCuPOMcl2Z5jRUvIO+rLRi4pLuC9AlgaqlEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGkEfWi5; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGduDPXznnLXJZB3O/unHmO5pKdqqbqhqkladUwguu/tZTb7IjwMNRoWnW1CB5INiWca97aFZxOC4jwWFLA+Td9uKljNCfC5t+Tm+aVGFo8F7659cBQ60+soomr3gT7oIF1qtRtDdWG0swHFbuDW7192wb64Om8NrC/8tYIL25oKMh4WELbDsv3G46O/Gk5FXrWUHhtif8JlZr9V8PCjm2INtV77SB35LdOl+Ij0XgEBQpHc3gPem0cWyf/aoTH0RiORdFj19Aw+hlvl+pU3UTLkZfYAsKNFErZ/A1iQQ2pqkwSqf57yg+RA7fbgSir8wDSomQdpZEkUZUfKaS+nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9xsyPWi+xOWwn2h9Np3m1H1Wk+nCKYOVjNQjTxUDpA=;
 b=IlkRK6k6pyCLCRUbdmAv+KhQlyH0LgzGtCuunHbnbKokqHA3MDaX6Pyokgw+cp6UPxv7EVNS6CAUzQ/rRc9T5GtiAPKVfQFtpzu+brPSNOAiCLq87PrsWS3CGTKMi44if9uGDmaItOy6fJdlGkwGnXGQoPKR+R29zkwqqJ+nJz0e+eOY0/bJK8aDInRu1MfFCBQ6iu/BocSquclrxwSNxV5LpoLRajyypZK9PO5s6ct3goBJj2ZFmXWAv32zxeKWZehe+HUSpi4mFlwsxlwHNlrRiiOXY+rp/EZToGatMdqPMJre97TUxtg5Ncl2aMtHBJ4LyIBwLvGm3xtb+G01Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9xsyPWi+xOWwn2h9Np3m1H1Wk+nCKYOVjNQjTxUDpA=;
 b=aGkEfWi5pLJdxY/VQJ1Zyv8Wlnj/TEkDI7QJ5/xKnsCwVauaO6qzBm0womP2ohGYXGmC7tvJR7NSxbvhi0JiVc4X0WxEI2Z5GmdZtB0XPxQurjsYFwnyyss1ZV6eHVrN0AanMeliuRpZ8gqJOTxnejouQiak7UdnNUN3dU6PoeKSv/NVeBa/d5/BkXGcL2wkVlax2UyrAw1InQ63eICWsa2nbpgAzvb6Jrgm5p2EJmZYVynuK35F1qaeUF+dXrwKMry0p0x+cysLSfOJOH5guJ/Oa00lYs1F9dcnnQHlCYXSEgBT8n9vae/sIwPy2p9uATlVniv2s6CuD4Hw+hzrFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 16:58:58 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:58:58 +0000
Date: Wed, 4 Sep 2024 13:58:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, Gal Shalom <galshalom@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Enable ATS when allocating MRs
Message-ID: <20240904165857.GQ3915968@nvidia.com>
References: <fafd4c9f14cf438d2882d88649c2947e1d05d0b4.1725273403.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fafd4c9f14cf438d2882d88649c2947e1d05d0b4.1725273403.git.leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0429.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::14) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 4431615a-1366-43e2-3c3b-08dccd02de5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RZ27QkIoUyg/OhmxFzNj2h/S0rN+SryQkqsJfC+oYX0qi0jo1YKr5rJLoFaX?=
 =?us-ascii?Q?Rtt7pm++ROWXyLtUgwGBrvrYwZgKeo3c1AsTlFabyHO7MQBu0J0IpAdfp4tg?=
 =?us-ascii?Q?ZROEEBXFjGzhCaGFqaZo4k1dQjHU61DcPHrTUgClJya8sv7bSvP1ca8ZKYqO?=
 =?us-ascii?Q?ddroDvQkIjFyq3mHvho/u8GAl38GX5E4PtIjFI8lLXc4SwiZC4NAAZ2Oqe3B?=
 =?us-ascii?Q?akwCWpMuaFiEWYlaWA+Xi+r4z0nhzdTfPgxVmAfShfNkge8iTL2qGQNRKwWB?=
 =?us-ascii?Q?VtQmcZ6pjnVAGUdLU5p8453g7N5Sbx5noVlLNHS8X8/l1t9WYZKQf++V8Zw1?=
 =?us-ascii?Q?ukpIHM6g34ImVvlseBVBDqNMCQQ8kcKALaer96u/L0Kc+1vssnmHqTJZQPeC?=
 =?us-ascii?Q?yKBbGxjExBDBRueBY96bM5RY+a7YvNICoy+JBYuMMocu5G/k4V23uEZOaOoJ?=
 =?us-ascii?Q?YQ5Jo1GovQWMHHaDADUd1ECyJ7IsZOiQSevilEE7McerQJvrI6te623gbdzD?=
 =?us-ascii?Q?rjFFFFCkiixEh5ah4hodr4KLz4Rg184IdzmEWFfO3sgCM7AF+oUms29Dl62L?=
 =?us-ascii?Q?j4mhmu8teERMoDNooth0s+cp3mPUlgPoC6sJbNOnJYcV2aJuF03ncQqpV1qG?=
 =?us-ascii?Q?QVeCpTnkn9JA4ihcrUSOqYcNMdXXCIPWw/YgTiSjDpBXm/Mcome3K+PejP2Z?=
 =?us-ascii?Q?59xTvbi9ugK7zs6cmCjc+s8KXkI7wmtsv29a25dvFLrLZtQfLPMqflqhZZML?=
 =?us-ascii?Q?L/SA0ICBrVFWe8mVKxDq3vWHmXtNMT5N4VmsjBLziSOyN9br7Qd1w3kDG3Pd?=
 =?us-ascii?Q?zPZLCR2ywzOQNgAbjSAG+ugV2mZzaDQhgEsQbGDh23OATX69B5Av2//2vHpo?=
 =?us-ascii?Q?9sNLMpHbJ5tauijm2g6BFwaFX+Jid7LGVar4JC++XBT5QPHV6ruFvJ7ws6nE?=
 =?us-ascii?Q?/FDiNMPnoVIlYeuOwbNHceoO7IAg24yBTimM92R3+9RnyXq4dIdgWD+1x9gT?=
 =?us-ascii?Q?qB4ow0Q5nCtl0RqSwPg8u6pBH3a+7hXmk29UHbQxM3xms48pjrhV0XeZyDRf?=
 =?us-ascii?Q?10pQtJ18qByQ3zOK4Mw/aKqHJDPIF0QvkJ+Q4FD7EOPWcHDZnbC5xoAWflSL?=
 =?us-ascii?Q?/3C3PDA9bTjS7ovPpE5OjpBQBF75No78EDkrMCs0GXVOXly+pd1AxvejDJez?=
 =?us-ascii?Q?h4Jod4OAGm2nP5uRPw6kzGhT/Gek/BhpfRNtqV96yiDZoHmG2+kNKTbASiu0?=
 =?us-ascii?Q?v6WFm2OASReHn3hSDOPJ5xytmgOJ27JPOePSnN/wXgv48Y3ztieS1kIfZRE1?=
 =?us-ascii?Q?aPeaa87GUyXlP1VaON8FAbJbNUfZF3iA1kX81L9nBdh1kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/qH8nrrkBi/gNYUwN4OHBadLsfd1yheeI+gpsGI5zb9XjPXbVqrzBehoYik?=
 =?us-ascii?Q?DlwhiF+LDoClqnX7HPjdqNRSkFilPA5y4iLN7kNcDxxxv5CiZn+pXQfRwpPM?=
 =?us-ascii?Q?sB7i62ZtechCyUcIR7PXVtlG1JMHLPj1epB/7bWkrILdSDnKKLMXWuyW0zo/?=
 =?us-ascii?Q?nvfOkr9jPZAqyHZfd2pt0uvrT8Is/EMPkRq2ObbfQrF3Exq84Wd5DmNV9vGt?=
 =?us-ascii?Q?pGyRmyQ2B6TieJwCczjnM12zcYna5I8g4dFctocLGbQ1auYV1umr8RPE2KSQ?=
 =?us-ascii?Q?TgjpO1p5pwYq9KmeGmVS3wquns4AEwkIFHkbfzIpQ7FnVUsLMBXOXSO/7RMN?=
 =?us-ascii?Q?Oo1+rbt9afVs8RJs42aqbNBKszX5xpQvHnc+KPEwnG0MtcbaI+GFuV94XvVv?=
 =?us-ascii?Q?tNvQgH2XzvyX5RBOQ5veOXemwN12iYTXgmsdm3sRvRhYpB9P0PN0cKB81dTL?=
 =?us-ascii?Q?yuhPmvEXklreIyVopmPBsOR67sc+bs+aiX5bg3NLEvSGFaPT+LDuipKR+nxV?=
 =?us-ascii?Q?EXDaJ6AJtw4gqIpBYhYM/TRcxu0QoLhDfLa70eNEyEgQHg33VgN+xnkl8XPN?=
 =?us-ascii?Q?Wmo4IRKPDZVQ/OBZz+mno7+0b01TYXACX0xxRWREG1WCzGSlCfHVC6adjoYM?=
 =?us-ascii?Q?tJ0qU/VUgL9zXOsK+TseKujEKxmGB6NgWe5tg1bX5lxrJnHJ3diRUzwiwO7n?=
 =?us-ascii?Q?CmFM1nE5EpVieLC1LL5N6mnj4Kb3475vH/l0USP400nS4yJBUFW8NEQj+OFP?=
 =?us-ascii?Q?YkrRGKvIIOAHRHSSUupoeGpYpGj7jxh+NGsXcBbtzsn/+W62VoVFiwNeuIrH?=
 =?us-ascii?Q?/eInohrM3rGnHXx5KthkboNS6gI5QLpdVOptwTzpaYu5PL4MhDZTiPW+7bXY?=
 =?us-ascii?Q?pj54zhL1cx0jmpeOS0le833XBkyYy442Zrg6UKJE6v5bL12795c1uziyxaIp?=
 =?us-ascii?Q?+Yv3TdvvEaQWf5OgX2WGoUtZhntf/BYu//G8VipMV2LNQEMfTaZMeSMMo0G4?=
 =?us-ascii?Q?R9nlZ2XHIxXw6nQEkCiM2oGBSwWIV02Voi5QyKfVFwHPXdTKmOwU5YDB34LL?=
 =?us-ascii?Q?9jXpg6VYNujRBdx29pUIR/WIocMYeMsAws2OYih14428mL7K69ni84oUs7bm?=
 =?us-ascii?Q?HSWe7aSAvGsK4I2YqhEBRfrj5Xu3gh0/0P5djvZf7x1U3vVrVCOneRLLZxqR?=
 =?us-ascii?Q?Q8dNvBNJSBQ/RzPX0uBBmSe8l0iSHWIFSqJoJE9e3DH9/tKxafMUAha4bZCq?=
 =?us-ascii?Q?4od1IybNDsUkyuDX0arNL4HAwgDsyCtmJ1WXGIerwYcMhdFBNlGKYBBV/glo?=
 =?us-ascii?Q?URw75J4yBFN1lpQd+dAISk7zTYfoUXFjP9AYlci3j6VMeQl9pbrrgoIqpBm0?=
 =?us-ascii?Q?loxfjVZ53ZjH+ab6432sThhbm1/787NI5SznwW4Njluptf3co91I60OQBkag?=
 =?us-ascii?Q?OnKY91gLSeHfreEJZSy6wtSdOekK20OdMG97WpZkPIVJuZ1rx5bjKmuT5vUf?=
 =?us-ascii?Q?KGIXS79h7k09kJedvBun0FjBCPHroYPgACSKE6fLD+YQQ4vVaWb+aP4XOiCw?=
 =?us-ascii?Q?3CINh+yjbPvYqkWJISW7OC2PBP3+IILuB8fAlacl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4431615a-1366-43e2-3c3b-08dccd02de5f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:58:58.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi20kTadJbRTVJg9gcOWYdj+ZvYPH7gfEdUTQry4HIgRTXbUL+bQKxTBfoz8FKUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

On Mon, Sep 02, 2024 at 01:37:03PM +0300, Leon Romanovsky wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> When allocating MRs, it is not definitive whether they will be used for
> peer-to-peer transactions or for other usecases.
> 
> Since peer-to-peer transactions benefit significantly from ATS
> performance-wise, enable ATS on newly-allocated MRs when supported.

?

On the upstream kernel there is no way for a peer-to-peer page to get
into the normal MRs, is there? So why do this?

This also makes all CPU memory run slower.

> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Gal Shalom <galshalom@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 5 +++++
>  1 file changed, 5 insertions(+)

shoulnd't g
Are yo sur? ATS has a big negative impact if it isn't required..

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 3320238a0eb8..7d8c58f803ac 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1080,6 +1080,7 @@ struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc)
>  	MLX5_SET(mkc, mkc, length64, 1);
>  	set_mkc_access_pd_addr_fields(mkc, acc | IB_ACCESS_RELAXED_ORDERING, 0,
>  				      pd);
> +	MLX5_SET(mkc, mkc, ma_translation_mode, MLX5_CAP_GEN(dev->mdev, ats));
>  
>  	err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
>  	if (err)
> @@ -2218,6 +2219,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
>  				   int access_mode, int page_shift)
>  {
> +	struct mlx5_ib_dev *dev = to_mdev(pd->device);
>  	void *mkc;
>  
>  	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> @@ -2230,6 +2232,9 @@ static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
>  	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
>  	MLX5_SET(mkc, mkc, umr_en, 1);
>  	MLX5_SET(mkc, mkc, log_page_size, page_shift);
> +	if (access_mode == MLX5_MKC_ACCESS_MODE_PA ||
> +	    access_mode == MLX5_MKC_ACCESS_MODE_MTT)
> +		MLX5_SET(mkc, mkc, ma_translation_mode, MLX5_CAP_GEN(dev->mdev, ats));
>  }

This doesn't look right, isn't it re-introducing the bug I fixed about
mis-caching the ATS property?

drivers/infiniband/hw/mlx5/mr.c:        MLX5_SET(mkc, mkc, ma_translation_mode, !!ent->rb_key.ats);

?

Or at least shouldn't all the old ATS stuff be ripped out if it is
being forced on for every mkey?

Jasan

