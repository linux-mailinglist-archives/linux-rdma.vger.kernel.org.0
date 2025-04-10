Return-Path: <linux-rdma+bounces-9359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C9A85022
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 01:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36FE17C656
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87506213E83;
	Thu, 10 Apr 2025 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJ7QwCNJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50CF20E33A
	for <linux-rdma@vger.kernel.org>; Thu, 10 Apr 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744327846; cv=fail; b=p58NkcDRwFP/gm8NOjs7bWXeaBYtNpbpIbdnAvIgKb1PjeNhqRn8PfHT8XNuaFQiQOL2QU59lxDYXDLnRja/tVDGa+IwI4JiUo36HRNRXqbqKXZxEophMrMq9bxUKaUu8LO9y72NSlKoIIX0Rinngc4chAi6swrmzxxUVlwhJZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744327846; c=relaxed/simple;
	bh=mI/PEXeOtYo9S92E9tsfi7m4B209RPVemqn7LzaIWoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VdGvhSa5cI1jQvasm/X9OnLhym2tYpBd1aWRlsCpUwjj51EJ92NsF8yPhxLwJO3QAAm2yaal2HJVsUP15B8arNAa0Lu9PJANQrjYtnlRBLp0t/AM57L4hLcGoS0aLZO0AwCmM8V8uBcoa+GOfITK+As/t6EChbbdepK0X0tvheg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJ7QwCNJ; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrZengRtrSL8vqRycbEw2ddlOkzgJzpcF/inAyRf2wpF1D8QA+k8GYLEWaIex7XxX5Vs99GdwlbCLdGhHPl7SxQopxqzGwI69+UjaxrNG+tbFbBo/GNwcVwyo8l4q63ZGfNGykefVs66ysACIxoGVxtG4MqG7Vj1waBma0JbWf6dCcKiPrqUBVLDQzgcYSZocG/8lm1JvcdPY6C3hUvdGBxha/flmfnOydgMiuuWqTzO+x2G4o2EAW2N6c8kAhfWBv9Vgwg4eqAtvANr8v2ONBJ9JYLEi2LXNI6Xivd/7fB3HjemBmdhFNwe6rBJcYZz3CcxqNawexYCnlQSgKYwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7a8HiYs/RgM4Q8FfAutSQvznEr/0NRKk4h1kw6Bdzk=;
 b=lI6LnMzR0pm1rjugA9u8HGhgK8gbQR+aaPWoGwWG/lJ9+Sjj2UcmRyC5YD/1f9r195P2EN7thihHLVVcb/I1dJsBxnpd3GjCbR++0AiAxlKwjKm0npuq90eTR5gR9xs1dxeTHHnrrozX28fJ0FNBbNKxykjIPrv/ub1NjuvxaA3mhtQy2fKOwPXEj2wJyHLDGeUYfdWbpDfPn/ZNbsxlh/1PhY+vCCUimUiS7BjTE7xV4uIk5jhv6nGejn0BpLwbOFtOoUUa4fOCHm/yOjHRIgbdyU1bIgUglsjUnGYC7yIT+g+x/36BUWwSxu9YrWkZxiDCvrZJ+5zgEdXYgnk30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7a8HiYs/RgM4Q8FfAutSQvznEr/0NRKk4h1kw6Bdzk=;
 b=sJ7QwCNJs4+ZVC23Qk050n4ZnE/LLFIVotMjp07YsaYv87RvhnRtuEBL6WcFlQ+Y23ODRC697ILxQPKUB7YGdvEe9L8H5fDpclXDA57uZYguyQqo7mz15NxW+YVTIE63LeOVxyUf/QRXKf2qMnc6LH4Vf7LjMzTTCLEQu36Oman0Aiv4SmS1BTmAPNiaRu/x4P4TT+WYp06FZNUMC29ivShzIrnc+pWmBWusRRiRHz/HSdDfBTrbQmglnlGcK9e+dCIng2Cyftn579v4WQDjP/3LzxFK1NaZu07MI4MeBGqBR0ZygpZ2XHbuf2PzwdUgiAlVkYGV9IOFBr7EWcd32Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 23:30:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Thu, 10 Apr 2025
 23:30:41 +0000
Date: Thu, 10 Apr 2025 20:30:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Remove unusable nq variable
Message-ID: <20250410233040.GA88221@nvidia.com>
References: <8a4343e217d7d1c0a5a786b785c4ac57cb72a2a0.1744288299.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4343e217d7d1c0a5a786b785c4ac57cb72a2a0.1744288299.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 559ae462-f574-4f2f-8d22-08dd7887b512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8HhLJcZKCcJMaIVPKXG2oKy+0ku7lRil15mc0vMdFKPWGUiS9fu46uo6U8Bd?=
 =?us-ascii?Q?XNjrU5kFulgmI8q0+ItGAGtgjGRZcJSENlOQRMB+39BdsjX195HfrgxcE29+?=
 =?us-ascii?Q?DjoBR5mZHw1lMaSK0x4SQM8WdXolVqOKO1BTamUqHW7gfewIoP+kydq1g81h?=
 =?us-ascii?Q?6JLIIbswyWg2aisOyt+SRcTN02bgAUnAMoHYHtxrdeL+si9vTaMmcV+eYUai?=
 =?us-ascii?Q?fPp7bc0P4sofqjgaqLaVPO6j7HcTj4wuOqI/Egq3FfhTgurwLuYiDHbJHYt2?=
 =?us-ascii?Q?dM+o86K2ZT3inX9gZGLnMbP6tAJ7lJZ7UdUHzozdFL95dFWubj7z6SpM5bQ1?=
 =?us-ascii?Q?AfpE/Cm6KiE87AQPaznnvcbEaYOXKJWNU88FfDNcndcWYzZz0pFTNmn/Y18z?=
 =?us-ascii?Q?VA1CxVz0lJmzFjPx4F4hF+LKO/rCyMWRCDxc8/1HtzRvKuPdWfnYKMdOelye?=
 =?us-ascii?Q?A9ndPaxLR5TPZjpmJnFMz3pA7LyGJz6ELoL04jFO0FE0+fNYamoNzKmYixQ2?=
 =?us-ascii?Q?L0ffeiT+7WmXo3S5hObvuWBKOlwyFjDl3bEBWLY7W5rykWJ8MJDGmszjfcFa?=
 =?us-ascii?Q?Eyqk3d6Nud4xUvYzdFzZtFNUMdanEvVUkAvPY17cvzIHDtVsq7WeNi+Z8Dks?=
 =?us-ascii?Q?clf0RDr/n9cRXZsE5JHhI/dTDeQdHnQrqZtFKohkOFPK9loEJy8BTDohRHSy?=
 =?us-ascii?Q?KNeFTduBQJbJx5gy/Vd55XpBcfLB2ZnqKePi2XIev2FeyDT3AFxuV2OgZeL/?=
 =?us-ascii?Q?tDoleFmjzHsUxlwquedVIJTkJPFzQa54fUxp/qk7ImmAll9sZ6RYVNBcDxHu?=
 =?us-ascii?Q?QbOnaz9Yj8AggBmuVn1LvNUHPJ3y95i9mZK1P8fKI3b+e98YHMQDY40bafE5?=
 =?us-ascii?Q?v1j4PGPOOtYC9+Zj99+Cui84osh+V/kS6yWVRZUSpC5usa+gm/xutlmWWQxp?=
 =?us-ascii?Q?BV/J7ntya092rYe638Ar+jgmw1K9WiwWRP0bubXEla4bjfEIx5V5/IpxunqI?=
 =?us-ascii?Q?OzGCH7PKr+AIkhVcNvTTu39mXS0ZZVvU5uklDxYZu1PGAeW1cOM95cp0wt62?=
 =?us-ascii?Q?Q3ZNL9SIQXR5stHQuqqXmr8Fsak8Rv3axPsMAIKXCi90He3W/Cc0J6WKAJT5?=
 =?us-ascii?Q?Xy2gWnK9F8fu4GwVeqY7763qTNXRiG+/cLJj3ZE9wq8I1iuJBgfMqXFv496h?=
 =?us-ascii?Q?E0Q+1A4Q/F8Q55LXwgR5kb8TflV7VqjJnrjCDOCwFUyRew3S7BSGzeZRfR/b?=
 =?us-ascii?Q?9fsgcJIqYt4GQW8sBGNrursxZf5Bph18WD93mtq3Um3qiCH4arx0Gr60mn/k?=
 =?us-ascii?Q?3TUG+hpVT+g9Yg1/Ybn5tV6sFkd67m1ehUFYqOXhlcX7/oq4/ULtV2TEvfhY?=
 =?us-ascii?Q?bdDg5Mm7VlpRJ6k8dDzTkk3lSmKVsg2+6kXSPOOdVnXw5sExv9OwmzzpzkMH?=
 =?us-ascii?Q?YQYwc+vVwBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P0xTpZqFzAGx4uSHCD99wIQCrrMrc4vKynza1neG7by5I9PCZdpxWfpp8/h2?=
 =?us-ascii?Q?9FXGwbQ4D9IHsLgMzeG2KWJk5bEKE0p65bPkEYEoIYw93IEZ+yIyraxcAA3x?=
 =?us-ascii?Q?655E+VTwgxK04sKrRBYsE6J5OHpXyaDYuvO4yMYLzhj5CXLjWL+qDHCPxw1p?=
 =?us-ascii?Q?Wv4UKdfzru7BvD8NnAtO9QbjZbUsGS0286FISyhWZO9s9Qyt2p7J45VkMENh?=
 =?us-ascii?Q?Q4NpDLhrPZ5w4ScBeaPNcKp6s4zzzUJUHQYUzSA1HpwKLruffUgfTkvKicAa?=
 =?us-ascii?Q?80MQSF5s09ni4Y0YJses+x6leV+VtHicIS79RKR0LoIIx2S8vMC6QLbmTlV3?=
 =?us-ascii?Q?cBDhmZRhPZFzJBnJPCHAxhzQ0PL1MdUWTBl+JYHVj4mr6EMNqozHye+nCn5y?=
 =?us-ascii?Q?DvsNCq52yFc46j+Sz4jzANLmkuuS6cH+g5CF24WcfdrLyU4Xiug/f/ZHswhA?=
 =?us-ascii?Q?Vvi7kTvKBKr8IIYuLjkg/od+OXcZfeQT6Sx9evYf8gUta0Va8fcsl8sfHD1K?=
 =?us-ascii?Q?m72HBk/ML6SwyjaFXFo1tVHHEf2W5hgeaHWjPkFdiFsKjBGDnavmwqpWkq7z?=
 =?us-ascii?Q?qWEqUtSy4lyfdr3mnlEKAurVQgU7fa0V4pvIV+O6+Xx9mJWneZfdb6c4tC+4?=
 =?us-ascii?Q?k+6K98qmAh73/i5bQ1FpoutTl3aU5GWFvlt/qrfWWxxj5fSSKDhUBJ1FXd1W?=
 =?us-ascii?Q?qVJKEr6z3uVmOgcdWM1UE3mbr9qIe1hV/b27MuaIlEr6GZ34X25Zq/tjABjB?=
 =?us-ascii?Q?ZqmXyPdMeuofbMZDLlTtvefG/s6dm4Lmted9f7lEwy+gpw9gEdV4J8kBR/Uj?=
 =?us-ascii?Q?y+GIsbQH6/8Nd4QG+yz7SuiAQSJGRx5G5uwRSQUpEiPwZG3N+tpUl+L7xhX+?=
 =?us-ascii?Q?wcXTyEwTyIr3FQHm3PPvbLxZcqbGpAGBkndUV8Vn32gDBKqbyyw4Vt9tsjzq?=
 =?us-ascii?Q?yfVdOZ5p7M5sLuXXBi9qctEB3s1kzgjzJYpTarupPOrakFrA8QK11htgunXQ?=
 =?us-ascii?Q?rnLiaCxDtImXw473BkiPQEMsmjZoy1TjVzK5JjVkIDoKOavZgixXRDXPdOWi?=
 =?us-ascii?Q?4W0iHhEg/4KxK/jUgULy8rIFEwhHCvVjXApayVDjicGigt5AvEyETVqoffB4?=
 =?us-ascii?Q?6fTSjYnxqFHwMRkrX0LO5bq2MmZ2AMsGwbVImAx91bhdn6snh8DihDHiMkDe?=
 =?us-ascii?Q?Pf1g2IBBDN56662nlkBISq/LquzbT1OAl1j/FrKs6ulaFliPIID4SYAVT/GV?=
 =?us-ascii?Q?huAwxzsM96+Oq1dv7Cr+C/Iz9F64G4hX3Aiqffksg0e8B7LLuCl/Jer2Obxp?=
 =?us-ascii?Q?TrGQnmbQ0kEcn3QhCW8Eb8GGNIoPJYaTJIzmKK9YWl7BM5gUXVBBrQdsXu+r?=
 =?us-ascii?Q?ImkZBZYTAdjPLCsujUeks3BNatBKHmefsY4XKv13ElOj/uXCj6Lq7dQcW0m3?=
 =?us-ascii?Q?iawLKE1uhlwqlmJvRnFvZF44XLmgyqnK4C6m1JvTcotL51uLApFZGUdtYhLG?=
 =?us-ascii?Q?HHetv70iPEPSGJUac5XL9VT+t4W+OuBzHgctXoAH+4TfkO+nlLHar65tfF4n?=
 =?us-ascii?Q?dFVyEV16SncoEcikeTYyHYGGtJl6Kd0hr/InyQAd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559ae462-f574-4f2f-8d22-08dd7887b512
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 23:30:41.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhkno3AKBL5LCTvZeqarfV8tjfh1rnZJZwq5wMqre4HFJRCYO8BEGhIQhZne1NQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193

On Thu, Apr 10, 2025 at 03:32:20PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Remove nq variable from bnxt_re_create_srq() and bnxt_re_destroy_srq()
> as it generates the following compilation warnings:
> 
> >> drivers/infiniband/hw/bnxt_re/ib_verbs.c:1777:24: warning: variable
> 'nq' set but not used [-Wunused-but-set-variable]
>     1777 |         struct bnxt_qplib_nq *nq = NULL;
>          |                               ^
>    drivers/infiniband/hw/bnxt_re/ib_verbs.c:1828:24: warning: variable
> 'nq' set but not used [-Wunused-but-set-variable]
>     1828 |         struct bnxt_qplib_nq *nq = NULL;
>          |                               ^
>    2 warnings generated.
> 
> Fixes: 6b395d31146a ("RDMA/bnxt_re: Fix budget handling of notification queue")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504091055.CzgXnk4C-lkp@intel.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied to for-next, thanks

Jason

