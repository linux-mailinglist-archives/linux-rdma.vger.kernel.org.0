Return-Path: <linux-rdma+bounces-15061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8ECCCA0F9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 076E23021E49
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F127703E;
	Thu, 18 Dec 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yw+G5tBr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2762274B55
	for <linux-rdma@vger.kernel.org>; Thu, 18 Dec 2025 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023655; cv=fail; b=L8iu68xR3s+GcQs/XlXVDUSkY6A57xQmpoX0LKUmhXa5cjt9+ML1wrXSXk5f1HgLQvya/yDUolINxrU5OOWX746KSUZshIIOt8UGwWjPPGApa01zyAkJdvtyOuHpSXZL3szFDF3YACDIAsLcVv90SYvwS9FQrhKZ7CfzyYyXVOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023655; c=relaxed/simple;
	bh=Y5l+mnXGeLIJvrEYyQvAQkU3FvUIClJrWAqZw0++4TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J9SkabF9CoxxIYMYeo8gAemRRXopSQ01Ta6KGQJVDvws/jPpw3pT+VwCy5uWHDsig27vl/OGPTcP0WG3dnUzZrsRKG7PCFpCTBOdJnJ7LjADj8DyHetUSyyRlRqD9vGe8kN3C9pDDjbxXPLD/R5BLnCWMv4Nq0h3KtlKAT/Jwhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yw+G5tBr; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9OWbdeELtXXXYlnYBVdWXTrHPuT38T+/QC4g6ytN0TBm9emxa0eum9zquJHPtIlPbxMCT+rZ1NJzZ7mTfkXW4jZyqvmD1uX+dgw82PHNPC1zJWgLPhKETqHHaOUjbLpp9clRULUUr8rU3YeYJMw/3MlOt3nXh22nxnRd52ro8GE+cccLSyTYAq+UcYALVVUPNtCDd7DgTlJlkCO/DxVxCZxkYocij3aE5U89HWIsIJ9ehrIeAMgmwN35JTOyrBmPEe5vVtLVZLqFdlBV3cU6fks2XLA+2bXP8le7c3niijq4GiRvLJosk3CMlpu0IsZDnLsN8/t1eQ0sH/Q0X1Z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg+n1xL21YoecvdaRastJQl/GHTCCDeNkxZAjxTULfg=;
 b=c/vJFTc6DOyniUuuwi2H8NY11ifrIfcx736vG4leAWiG/3j0/xN6DIFDLxguJ7VWgvSXmAdOuzdh2JmKwicxNzPZjjelM9sppcN7rvOewWcB/1KhNFgvoE3fDwCt5LMvKCWArNxwO7Ftv6mdeweSbTJ1QOIpib64KdSg8Dqb7Ld/abNQ26+oclr31nDZbHDS1X6zp0cmnmlk1S6icEfQFil5aLbkLe1kTwvY/nf+/2Cx9X7+ka8iAMFtcK3wUvrKQnRYongLioxG0iDX2Z1V62nnIFCOn4O7TlGGjjhmMqK9h1wSPav/k2/Kz3GNXlVP/Hh4VuP2Fhjcw9zwdur0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg+n1xL21YoecvdaRastJQl/GHTCCDeNkxZAjxTULfg=;
 b=Yw+G5tBr9yzECtA0PJI8NG1+dily/8ixk8V6vJZxztpPq4pTKLqfphgYcFHFyrVqEp+NEAI2Az3re2mQPFM3gSlIJCddkJdpM1c7Bf0LWAXhCcmjCruEQYitoQcj2Woh/DYMMuAixT3CyWx0lPadAnF7K+tp3LlpuiOk0apyoczluuIgYkc5/j7unlSe/BKlui2n6j/Cqi2333gh02Vea0ey3nH+DMDzaenlK+yLipjxpxEgL2bE1HHQEHwHNcn156wb6uRw2K4FPzh3RQf28kedB5aE1zj+zAXB1L/HwPlMFtHDRxQHoUqyw49tsh41ALhx+7Cld+ePqTJ20g+gBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 22:33:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 22:33:27 +0000
Date: Wed, 17 Dec 2025 18:33:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v5 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20251217223326.GC243690@nvidia.com>
References: <20251129165441.75274-1-sriharsha.basavapatna@broadcom.com>
 <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129165441.75274-4-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: BL1PR13CA0244.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: a277ee4c-11f6-4777-9f60-08de3dbc4c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?NL4K61egUhUAOXLfXf4ME3QxTKInA5tO6rWiMaf5nd1u4rJwGMDHSk1J5VdD?=
 =?us-ascii?Q?jYw6h6oMvptYCENfhx3Wi3z9vUcOzRLP4IQcPnRVkbUXCQlwQ/K/s9SxT+CO?=
 =?us-ascii?Q?iTRJgPMw1ebvpRsUOuJb+vN3tKkYZHizgQIVjohc7IscHQ7LL0ZbL/of2VVs?=
 =?us-ascii?Q?sMSyBrOrLi9wunoqkG018aeB2O+OdTtpNUUZTYi9ZmXZTpNYRpvhhdJRUVLZ?=
 =?us-ascii?Q?wIdFnMoRYK3iQyhYAHFlpm37a+oJD5qufTti2Z3q+inlqzsRRkGzZq/dR+ye?=
 =?us-ascii?Q?NubTith/gppnG9GZzZt/z/8Ttsu32IHGJ50Ba3Pag/TngiGAXfhVCBBTgFli?=
 =?us-ascii?Q?tasI2P6t2SDzxjWA8gU2oHXYcVt/meB8XEbym2DMmgGb8IcFlaLbZ+Cxa/HB?=
 =?us-ascii?Q?WmrwO7U5tEU7nbaS4m4ZPEerUm3yqXReN8G1ibD/CtRWrBAKuEmRB9rMkvgn?=
 =?us-ascii?Q?rsw1X+xw148Q2mP4Cf7S+FgOaIrQddLmCNcXwL+pm2MDZTKuhH037YeewTmb?=
 =?us-ascii?Q?64bfv8VwRAUi3Q9sh5tJLuRun/sKn2vMj8naTUBCfNdt5AK55yTF+AktRWJl?=
 =?us-ascii?Q?5Zv7nMfa4tN9Elh6hH7MX9C9SX+TSFYzL1vuAdH8ikHkJcMF/Y9CJKed0Ix5?=
 =?us-ascii?Q?NpbOKB9A8YZObPAqfbf9+88axwl+HG6PW8x6J5zPssnbaqF825rCnSbO3MJp?=
 =?us-ascii?Q?MBbizhxMFAJ71Nn9RcCsLcrVqd56TwQsEqO74UlPzMsNEJJmCWkiccKz3Gnf?=
 =?us-ascii?Q?nmGJ0bscT0ZIu8ubUp6ph5MbaXtCE2GxukEb4UK26cEsaoCaI5Vgkyb+A9cA?=
 =?us-ascii?Q?DiDrAsxuAu8SXkuPl3GbvpAcKYdhW9LVhY/jhisaPFr1yrIPeKw1Rh8hTAOa?=
 =?us-ascii?Q?1JdJNYtX1fNESYXjeBSzMn2rauhX0djph6yPM/WVt2MQpY84yyhm+lsxyVW6?=
 =?us-ascii?Q?A8vYMBaZTgHnL2KTl/M7kkj3bUjvPzOYtT3pZ1VjGfmOE7LZ0GzecjMZ+CgZ?=
 =?us-ascii?Q?yfKgI4FvgtUAvEOvQRnNvXLgACWnNiAlrhWoG1TPCg6WjrIhsB+LuSEotvvK?=
 =?us-ascii?Q?WLv3RIm/pql7SPdfmwQ6X4ypO255kEf2yRyG8Wrpy5UoNmM/XxPSOhYB+vIo?=
 =?us-ascii?Q?UerRpbJp80LogfKL/6ESgZBfw3StE0X3pFBOETkDFKT4VpRIi9Sq/y2XrFBG?=
 =?us-ascii?Q?/M7rSowjBiLOL5yxdIIZ2cU2DSgGWkSLRUOKuF7iNXaNYFSZ3J4vEuyplFgl?=
 =?us-ascii?Q?RfGKlh6fHikYmiG5aYjDmFp6tvsVIEWJmo/z5bJzcOYjd0YwKaSQEu4g+kOZ?=
 =?us-ascii?Q?Lhqfy1K83VCRE6ZI2dplW3dPkdFtEqvuxUpcakMIfrcCr49nNC1T/mYehySr?=
 =?us-ascii?Q?n53rGk4s1LRXyRjrCaPcYVeNRj9PBNginKk69LgYf1Ti6VdmzIBeTU6gy1so?=
 =?us-ascii?Q?5F5TfJLu99qQ9OUVMnAmHp5HtqMFSfO/?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?CpCgJeusuiJaHjI8A9Fe324lK2VUqPB+pjuA67U9Hsdi7YhpyOu6beOrLf9n?=
 =?us-ascii?Q?IfnA6i5nQG5mPO9ehOqyM/VI9p1s6SkUhgijR6j3EllcU4v0zBPh6DrUZ4v3?=
 =?us-ascii?Q?4yMnzEv1V//vmN/1agbUwZ5z4GPBLCbvR4oyeIq/1JI+XIIgytHyCeMLWdJ+?=
 =?us-ascii?Q?+mzN/lv27sFTlDDp+jIAZkrj9KKKEch5dlovnsdr4ahhEDz930S0/4wWfofi?=
 =?us-ascii?Q?PDQUz5JdoavpStBG99MRg11xUnxJLMRyEap4Sp2aWSgip3FT+aHz/pZjAaeH?=
 =?us-ascii?Q?6egguqZRjQpky7pNm18xh29AJw7IdNlhgXR+vna0R63yA2mCt16hZaeNZMq+?=
 =?us-ascii?Q?jze0O35RQ36XGA/icQ+8kc4IhMia+0Qk82mC2UZNRFs2i5Gj2a/rGdH66XkF?=
 =?us-ascii?Q?FjodHTor+VcODN5PU7WxDawGsfG7MhAQh7NlDNQM3eOufWAJSS9XKISvJLaQ?=
 =?us-ascii?Q?/KZeUT3uLKwjkuiF1XDCRiA5emQjc1DSrzH04kB3XnvoYyqxBP9q+8FcfpQm?=
 =?us-ascii?Q?peYfmeG1hgFABelaLG5G2vZMPTo1UkqAFMNOh5K9rY1ML43TGBY+nTBxU2fZ?=
 =?us-ascii?Q?7Sm+vMXYbr722k2HN2wUqO0HTB/5Ttlg3b1/teOxYvnIOBDJ7A23Qtmsw2LQ?=
 =?us-ascii?Q?WBZGTKib5eveXa7yEEYgi4Vy12bS7mC9IwQStX6v8aRWFX01RDE0kGCx/qdv?=
 =?us-ascii?Q?t0+J1nYU5QAAEkiLv80dBu8X5HWUZMvz5XbnYzuOJ6JyQcp50cu9G4511UTe?=
 =?us-ascii?Q?dY8oNrnc8SjgAT3clWNxpINEbueRQlP3gKJpfuGwtD1CrjM6xIGXt96QYOqW?=
 =?us-ascii?Q?54HSP+oOYRmEqxLFhtPu+j0m4cSws/vy7VEV1ET1npzf9dPEh/5vz2Vxr3zu?=
 =?us-ascii?Q?XUXfcvbBKb79yhyNQ3Hplg8h6wDoGVKd9qbxE7sQe3kJVfSPSOy8vX/KqJ5K?=
 =?us-ascii?Q?c/idTp7qNmNCQaS4VxomO2jzmSPQz3BlwFgWqNb7+E3mLpY/PtJ0aKIs8w0R?=
 =?us-ascii?Q?cAaKgB5AZt91eOWCVML61G+AkMJWdutQ+DUAJtsWQuLSvPTGsm2Sp+Jl6Y7B?=
 =?us-ascii?Q?zBwb6DwvpTsSa5/SetU9KTvfnxCcKivFH5vEFGH+0tUgs8bSCyWoP9oINYA1?=
 =?us-ascii?Q?uf20vnnNeFEJsYrIsoW+f0N2e8CWB5ek17NK6ZMLDhJpBR0fItcyyZ2LsFUx?=
 =?us-ascii?Q?IcccoIsmqbpknQXDzsJZiaiz604btnQex/G1G2lacRF1B45Z8Fuj11MH4Bi0?=
 =?us-ascii?Q?X+4LVb1YVskIgHE5ilmWxH6w9BgDtsPSOsKq6dNoXKSut+/lV54ryOj2UlXk?=
 =?us-ascii?Q?SKe/SJsFhXYJa7I0CF3/ngMl4iZFLsV9mp7TME+nzYLcJXAI3hcwOhB+V7Kp?=
 =?us-ascii?Q?boceO6/aOr7rUJFOQpUFpkomEI3Ue6M9JPkVmBXgIrFcU1Ays2SbGFRL2c5m?=
 =?us-ascii?Q?NyjtQ5RiF40hsR0AKP/Vh0SrcfbUgbrv6I8OMgfuKBBkAY/kGnPqTOHRadtw?=
 =?us-ascii?Q?r3/nhZ9lDapY2Wek+TevLGHQQ6AgbxuEhsaqYamVYHLpb6w0aNwTObTul/0/?=
 =?us-ascii?Q?ZdbYeuNzYO+Vr0v+4Zc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a277ee4c-11f6-4777-9f60-08de3dbc4c45
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:33:27.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crsyroWf42aJpVNe6z3QF58p6Caic5wpwJPNtcN9BeB9taOdrg3xFKdL7G/7XVOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054

On Sat, Nov 29, 2025 at 10:24:40PM +0530, Sriharsha Basavapatna wrote:
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index a11f56730a31..70891f8243b8 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -113,6 +113,7 @@ struct bnxt_re_cq {
>  	int			resize_cqe;
>  	void			*uctx_cq_page;
>  	struct hlist_node	hash_entry;
> +	struct bnxt_re_ucontext *uctx;
>  };

Why is this hunk in this patch? Looks unused

Doesn't even look used in the series?

Jason

