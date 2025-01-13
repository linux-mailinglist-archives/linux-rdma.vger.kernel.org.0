Return-Path: <linux-rdma+bounces-6992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF0A0C1C3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 20:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A954F188923E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 19:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008C1CD1F6;
	Mon, 13 Jan 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4tSuyGy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737901C3BE6
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797675; cv=fail; b=pkj4bL9ttS6H+2TlljU3Ia/R4SiSsiwLI/EngcMJ23LFRsvHzATXm5MpQEaQJYC+TRundoTddj2XavC+Dkn7TGM0OOHrzQmtfG/XYlysUVCrCVofgNhaHPTJf1OdzG7IvF4QPD0FO0w7byRMhW2+iRdnE2LUUxo/JBiaeTp8FGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797675; c=relaxed/simple;
	bh=NkfuACiQppdjda0z+QDYOgbv2TIQ901bsUfsOYWGFwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PnNLlVouK8Ehfqq2tQ4B1wiHhitBgPcRf+bCZbtpqaE9rXgynh0gmw/AkMN2APCe3BBTVFb/UFTX+nFJ0t4qeskiilm6C6IgvveSZC9/J5U0s5bpjkG4btF4dBcKdfcuTNc+MNJomIEx4IgCBoDCzd0mS3PvShUMqD378Xf1UK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4tSuyGy; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p71t89ZcL+pZBHR5LrcvbdcMDkG5TsK6i/wQeiPzNmc/rxRQr0/wkz94u3o+QjyCGn/Eay0nHDEryccmaatrbbxbDHNapSDQBziy4g1bcwwSWJOnM9fum24f0v2xu7yC0uK3W17f5V0Kj9/ZPb0rPc/dwVEI/uL5jIjxZLMnOw8gb1D7B3pdO8yxZcEpZzmKJHixQR/x22UynYDdUWP5qwGou9n6DwLhl0LaRJ6+SREFP4Oa9XjfpBEFBVQ/GjY8UhEEva/8mIyN6Iwm4tx4J2jpIge4S2nRHqq5qOrEMcbTxl55vTwOfiqPnyoykvkiaeEBfCj03o30j8bZ50izww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRQzTgMu4K/E6IVVlJnbzei72EbEd4P+HglgzGZ8Khc=;
 b=f0OzaCwXYaZGhf/iDidSzJS8DWnpYu1qAF8OT1UEer7p5AaKN4bcJptE5Dwa1WE6oJN5AnuNU1E/BZLMjJJcY7Opo2K3N+/wRJGnf6NvRA2FnTGr/SlUfIb7cOVtOPFD+vV7EE5x2+s/+W2QI2r0oRBM837C+LLrxRYyKzY2W4Tz66cPDKJDnCswbgheq6dd7WgLXzoXZFnGyH1QixCN2rr1dQiq4LkFutCYwqbN8bhHdlm3jePNMcnVcZf0zfznuVekcld25FH97hIb2BBHJqg1crx0M/5h/YfoxO2WXi/5mnb+34kYpgxPViW5ctGC6TMzU1rtBxLgOx9BGmq+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRQzTgMu4K/E6IVVlJnbzei72EbEd4P+HglgzGZ8Khc=;
 b=Y4tSuyGyuXaA61CPpQRNXxm+0tYlPM8z/I5XVB5Ylf6tYJrcb5VkNwfAZwDLWTBPX69J4HfBkmJbvUGcLomeTFt5eY+8kn/Fs0hSbVCLETD9rROO1pvs5sNR6IYMxN1KuHFSyzt0UdCFmJXe+9lFsW619ddpPlJkrLbP8rTYMdS2dooKsFfTnL5P2ZHndORuF9b6k6ha6ElYv5LJxMxXzWlMsXgWJakU0HlBZRY3QQyxHaJbtP0eWjgK72+7yT8ZVDtDDqDMChwoxjKdj0aebs9Piq4bz9NHfBQegWzOGvh9k1U1bfMw744N/GbRhtMFwkAP6JBIWDOQLkJLOHTmnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:47:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:47:50 +0000
Date: Mon, 13 Jan 2025 15:47:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix implicit ODP use after free
Message-ID: <20250113194749.GU5556@nvidia.com>
References: <84ecb15d9f251dd760377e53da0de9eb385ea65c.1736251907.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ecb15d9f251dd760377e53da0de9eb385ea65c.1736251907.git.leon@kernel.org>
X-ClientProxiedBy: BN9PR03CA0462.namprd03.prod.outlook.com
 (2603:10b6:408:139::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a77e583-f64d-4c9d-6c05-08dd340b29a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxTkEOdTUX3YXmK52crRvM288w+KejHtjW87Qh6J78G/cgktM/DGnDhctH1S?=
 =?us-ascii?Q?26qaT9KYYkQkAloRc14SMLq20e1Dn/R9rebeGoC+dNYssEtvHY88tUvRbVFE?=
 =?us-ascii?Q?1FaIfeDkkheRYXfi9z6+oXnJ+1Ee5h40PL6YJK9KHqBEqzwx/2NoSH5bMGlk?=
 =?us-ascii?Q?QJ6gIzjMZC7Iej+iITOVnXl4X1w2POiVv9fnGGdB/ustky9kqWX4eljOYjoe?=
 =?us-ascii?Q?1V6eQd3DcV6Htp/WhhgBTDpgbfgRqccEREz1+MkllVe8K12FnIRCmpSi1fyz?=
 =?us-ascii?Q?b9YFKlcl+8Y/MrQjxXIx2/w73OBM32MY6urT08YuOVwoV0En2+KUWD7KBe5x?=
 =?us-ascii?Q?YS3aOWCXy/4X3ILxrTE0DH0YCa3/YJ9iHtC3SsTszFleAbD2rhlnZ11TywwK?=
 =?us-ascii?Q?AsbeASp0cMT84fzfmvUQV2N8YHjXsFy6ZO0Fb3en/9VaU8zlVQuL2njJzMCx?=
 =?us-ascii?Q?0BO1yFOvG3xSBA83iPaq+OC2ujHyLSJugjyhvl+ewUFYQTlcQXHyM77pbsVz?=
 =?us-ascii?Q?h+gb5rFuHYMV98IHkjbv1RyyxAFNzzfF96ZwtGDBqLfrdFIWF9JUzotgCyOU?=
 =?us-ascii?Q?LehI1MflzK0sakvyO5Baxdh1jBLg5D/+qH/OB9pofzsXkdq0opkOsYBIX0WS?=
 =?us-ascii?Q?OkqGptLD79y5ZKPD8ldncYs75/fvRb4j/D0evUTPtIrsGAwzt+qdhJoTVntL?=
 =?us-ascii?Q?sjlVVIUTFerBGDPSTfGy7CKDdkfZdsty3dOUGYg5obFzobKbGFZVz2vxXK3C?=
 =?us-ascii?Q?ZBlUYeq/9h3+QV8U2JA76u0wR2GmnHdVruS0FIGbZ49dDtkMnjDa9wtRsrsb?=
 =?us-ascii?Q?XGPREYP2hZ9fdkBE7A2conygJ1Yc2IS65FeASGu4rSSFdBVc2TqegRBj0hdN?=
 =?us-ascii?Q?9gxzMpS79m7EtQilTWRJ8nWjU9pvgndl4Bhe4/OwjNvvvLb2x4w1oAL4VSUc?=
 =?us-ascii?Q?MOwtPKZsM0opNPQ/yrRXragn3DrlnUmIPmmO9U6KsbETR0bk3+/B+8LOE9LY?=
 =?us-ascii?Q?Y6L1NOnEC38VyD4tdxV7Mffq4kYszuPj2wHX0IsJNdDFnnt/f45ppPOI6Y0R?=
 =?us-ascii?Q?iV313vumBgx+KPnQForRLp+nyExHEVeygzfH0gt4XHG8KxVM0oO/Vpbw9UmT?=
 =?us-ascii?Q?bXq1zKosfHquNhxWPfyTH1NDm2Ki1cXoVIIOAbAssNESlrxDcD/ohbEleEg3?=
 =?us-ascii?Q?RmL1gwEi0EIlQhLFCCYLUx5l/e3UUaEUIEw6nq0XXFfpNYS+HYGF+ngHnN3y?=
 =?us-ascii?Q?i/oCdToZ/M4mHDXFLxZE1sSRO0ALJxzzpsyDtTM60tEXs1gyvSPp1eZwOOMs?=
 =?us-ascii?Q?QR2Msj+lMRUBvOYBq2Pnm+Ra7sWP8ZsDrRJcEJgKbMwDtvTuHXtpPwmna64T?=
 =?us-ascii?Q?enwWOS3k/va8M4Q7LGVPu3ODzMsn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A7peeAtvV/EEz1M8cGlJ9eA3e52r1D7/7HnYx0zxceEWs6EhGo4iar6aM54+?=
 =?us-ascii?Q?I7DRlmikFFDAosZP6ycW7bEyq4lE4nbtYpaQSUqvXLC6VAh+0ZQ/6fMnQSko?=
 =?us-ascii?Q?0SzDqyKJd5JLT0plwmsGE5ytmHW3odm9uN6OezQhwH6yT4rDtvGz/8B/TvIp?=
 =?us-ascii?Q?v36Iexrs/IWsBwneY4yWjz4iPW27d/dX97E8MJ8reg0KGz/DFsiFQEl9xW9D?=
 =?us-ascii?Q?grd1QHFhfiW6s+rVvc4wokOZ97TgGT2fUQE0A9iWlGe1eIbQNwZBrj52PnXG?=
 =?us-ascii?Q?6Yzx1W5gUpUxvYysA3VXEi2dcT7Z8ykSzvQZrvBz7Bg0WRN8scEZKCJfUkRO?=
 =?us-ascii?Q?3EsMZTnzkWjyw1Ys8/XtpcZgxFFOYfLZz/ZJ2clm0Z/ocAk40yYlrLYkUIvw?=
 =?us-ascii?Q?tminyGwABfDdZIU+J2MlEZMJv59Laqha+GMnSaqFTg2LI94FWu9cEuvlKAO1?=
 =?us-ascii?Q?aIl87NgJT4E/Pf0XFP1qeOdztOI9/G85na5AKU7pB36Zea45AhN1QAEMtLRi?=
 =?us-ascii?Q?h6RC3hUZPwx6pntAKC2w6sUrEtHe48vOVAziNq7YM93INoap5vhW6ghV44BN?=
 =?us-ascii?Q?IGu4auR5oGV00gsfmAnEIAlqn3He5IH6MqpNpxyEM+K2k19QuMnMXhw7aDhx?=
 =?us-ascii?Q?gUctLQrKdyFJVHuM8Pe7DNwArPxo6KncZnyiVqW80gQyqG3bdJPg+QsRYAvm?=
 =?us-ascii?Q?Frt2cXsTTv8nIzbTuURlnM0e8h2qaYtxODc+Sv2L4NTlfAFoahmfaXzvfUbD?=
 =?us-ascii?Q?VX+5ad9CoLFITK/j/ityzEhqqcEuh4+RGJGCm3Su1FoCc5z1UdGwGwd4G4PG?=
 =?us-ascii?Q?UtddE2BMgweMYFIlk9H9sAhtg4+BaIkw3tjhAKSy3W4+7/SBjQJ2/8BMhoPy?=
 =?us-ascii?Q?FSTw01SZNHa4xadZbuNmVS/T9+s1+3/v+Ekftl+ZTMYbaY4HRrhusTqCMHUR?=
 =?us-ascii?Q?wWN07FKOUaN205780F0IUUhLFxIPc1T6h2CLfERmXK9IjxjRR/QnjjALhSbF?=
 =?us-ascii?Q?riVPgmbALNpTouZsvZn9Jv/S8FUo1n4wcrOuUDLW5DWguUtpRK8JLRpxHY43?=
 =?us-ascii?Q?wZOYYeuCC2Yju22bD3ePTO0lBuKArkFx0U0yF9q3QvLPBYUImONzLWMMQZ5p?=
 =?us-ascii?Q?Rch31QJVILd38oPnaNGaXKAmjsGH2XDgteS7Lp1ir5BnXtlo068WBo0riI4M?=
 =?us-ascii?Q?yYlj8eyx7FJCKQO27UZsVl70E7B3gltjfYwj1gJ6pfPXHJLzo4MTbpsNBw4T?=
 =?us-ascii?Q?T2Sjee/fZnvleNn71m7pguErBoKY/hR3tJy6N64QWG6gBRX/4VxyHHaATWpk?=
 =?us-ascii?Q?ekXv/CSANpfTzyw0or6kg6qu6nIhgbp9z+4dNZsfxd7ncXggbEtJH4VwUdHw?=
 =?us-ascii?Q?6VfFLsidqSX1CAD0guJsBLSVjFB5N8j//ZZ6BXxVfsW7Sr1MNaR+MEPB5iCt?=
 =?us-ascii?Q?MJzlCwSmHbv6VPAk5UlHzSoCns++paBuyn4fsIJaT6WZA3Cm0x1F277w6gQT?=
 =?us-ascii?Q?m6dsV1YlggEnv/AvmhPfiJZTbG21+KRK6LojCOLbOHGS6aTNnLzi0eCzeGeC?=
 =?us-ascii?Q?Ovrssult1FXUM/+HRcM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a77e583-f64d-4c9d-6c05-08dd340b29a3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:47:50.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oXaJ9VE4XQTn1b543B65TDXp0sdFWWN4Jd5MmsZyoz8hJ23oBLzQbl+ypqwlIXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

On Tue, Jan 07, 2025 at 02:12:53PM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Prevent double queueing of implicit ODP mr destroy work by adding a bit
> to the MR indicating if this MR is already queued for destruction.

I do not like adding random state bits to structs, you don't have any
locking protecting these bits, it is probably not safe.

We already have the xarray with its own locking and tracking, just use it:

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4eb03fc0d30228..858a35a335dff6 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -228,13 +228,20 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *imr = mr->parent;
 
-	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
+	xa_lock(&imr->implicit_children);
+	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_KERNEL) !=
+	    mr) {
+		xa_unlock(&imr->implicit_children);
 		return;
+	}
 
-	xa_erase(&imr->implicit_children, idx);
 	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
 		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
 			 mlx5_base_mkey(mr->mmkey.key));
+	xa_unlock(&imr->implicit_children);
+
+	if (!refcount_inc_not_zero(&imr->mmkey.usecount))
+		return;
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
@@ -500,18 +507,18 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		refcount_inc(&ret->mmkey.usecount);
 		goto out_lock;
 	}
-	xa_unlock(&imr->implicit_children);
 
 	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
 		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
 			       &mr->mmkey, GFP_KERNEL);
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
-			xa_erase(&imr->implicit_children, idx);
-			goto out_mr;
+			__xa_erase(&imr->implicit_children, idx);
+			goto out_lock;
 		}
 		mr->mmkey.type = MLX5_MKEY_IMPLICIT_CHILD;
 	}
+	xa_unlock(&imr->implicit_children);
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 

