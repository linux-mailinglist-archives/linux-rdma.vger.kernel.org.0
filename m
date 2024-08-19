Return-Path: <linux-rdma+bounces-4421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98152957398
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAF284883
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C602718C918;
	Mon, 19 Aug 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mpspi1G7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C267189B91
	for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092708; cv=fail; b=B+Bg3Ay6xRZlCS2YpRfAXRfhlMA8fu+FIWOF5SMCOuGsWEtne8H7edsBnh5GsLNpvdcs81kKW8K594Pjgn80Q9FiM3h9LZ9TXBViPhbX+IYNtikdwrH9EMWUBJnSVHWnoQukTecqJVSplwnXF5RqVJp8USsEgeaeFHbxcqc5RDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092708; c=relaxed/simple;
	bh=nHMvX7PJtCH+AA7L5a+tlNMwPA05zu86vv3E6TRsidc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyM9pW6ZhWHwfdpZrGYQIRuGaZ6h18kdnTDxDxHoqyd36gXhxUn3JpLYgHv/Vhyw85L170gTuOeK2pS1tk96ikUuIg6aSxyxwwfQGmONlRBn6fIr10MxMdSEqG6TCbFhy/QacW8XDtxEkUSuEXzKQveVlQK5lvx+/G8Xrk0T8k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mpspi1G7; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkCJAQjZonQnhtXW8Q29gmTsehTBLiIUh8YesDzEaMjsovlKgD0Rd+M+XkPk/mZe5VYO/6aTzYjugMyh3J6JN+m4scPGRyUhsweWFJvGS06Frod82LyFPv042g9U6do3zQz2Ru8RBqmGRI/LmLG86lc4oMGSj23tVmW0NzlFR5cJwszYeNCErLTheG7r2OfoEz+dgvyxykA/oHcDGGsQ/dUxXltSOaOPbC7mcMSUVNfnTKtiMc4n2KUtDq4jLcwp2++gyJyxtp7cBfaJTcjOU/9wGBgKSGj5CUFCTe3bk9Z3QUgaetfKTC/dLLS9fqMgnSmLBaBbdBUpeRlyN0aYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHMvX7PJtCH+AA7L5a+tlNMwPA05zu86vv3E6TRsidc=;
 b=xtF4Xm/rmpo0Zhh56yxf22iRn9yn7mHndZ6tZRREEC+4ZV9IB0j7ITvVTA4VbvpPC4MlWfQ7Nl8ioIhOXT5Dg5K+dlhEgmloqNgoZsIIl0/GYIGHlQOS4v1Qm9rlFPN6zEyPtQ+JBU/nB20uQpSJfyXdcGFU5qrv1y8WtaHIv9FQ5UR6ri6cIjm/vVntyxtAliZlSWLCOqgF8d3Qe+aSNYw9A9BKNwhlJOqIYArwsVTlBPir9+AcxmUgOukqNlZ9PZ7GQyWarG5nYffT1doXVznWZ/G5KtRANzUpSYVbLTDM27YyBjtXzLJdYqcwcAcoSieRBigijmPEi1cNZMonqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHMvX7PJtCH+AA7L5a+tlNMwPA05zu86vv3E6TRsidc=;
 b=Mpspi1G71YTXiwjxi1abUdlXhdeE/9E/610C/TOwaQLSqx5khq+DFNX+YT1nC9WXDrBUqUjwXxcYvqKpogLEqmGA1S2fM+VOEOqkt6WzQnMj+uwSTI/kbsEnm1DjE2SVLudY+6ZKsuFYHr139BAA3+fkPYnkyzETdBN+oO+sLTVwwjCdy7oap4kfOAo9mgKfOuCiEtDKb2IXDE5Z9ODN/f6N/WgygPPTjZTPDQYRyuD4zgsrZ8xyJ8peVA6wMA28a96lMdd+OVAfVP9cVBhfy6O6J7H8z1pdLfiOZVC4MegcSARdzpb6i869f8GRTtRDD0syKkp56HZFMM7ivILM8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:38:22 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:38:22 +0000
Date: Mon, 19 Aug 2024 15:38:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: bvanassche@acm.org, leon@kernel.org, linux-rdma@vger.kernel.org,
	shinichiro.kawasaki@wdc.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] RDMA/iwcm: Fix
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
Message-ID: <20240819183821.GA3487760@nvidia.com>
References: <20240817084244.536397-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817084244.536397-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BN0PR04CA0138.namprd04.prod.outlook.com
 (2603:10b6:408:ed::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: b33c126f-b0d9-47cc-e206-08dcc07e1a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVuU/Nq6btW2J6oHZnvZ+cdw6E4zgneu4C8sYZzMmRCLDf7OVMKnmznUo8JL?=
 =?us-ascii?Q?DT+yiH+S9kVECHrdgA/DTmp87A6YQBXs08BGu0/kodmRP9VzmHg5qyc7Ht/v?=
 =?us-ascii?Q?fxecNjY4esHDh9iMJreeHecXUDgGNfPGQ//roCpMQQ08plhiUkyO+VPP9Vr0?=
 =?us-ascii?Q?ylTi26HpGzKxxwjAncmbGyjEZnHup7AjMAIdu7EHkJqh9/isCtfTakJMIr/H?=
 =?us-ascii?Q?AANNTk8pMWbC7g1jgCZfmoQ+oylZ58Xq4NQ7JgsMvwgOBdEDKNFJ2/SDjHb2?=
 =?us-ascii?Q?Q4TFDbNZSXRdSFo4Fqh1eMBZgmjpJKL7g25TpzWSl89kE6vVhPfglRUBzoE7?=
 =?us-ascii?Q?bEnCb54YDC5sY8gPGibtbhC/GQGISFWKT+l/6wZvzNaazmdvTEl6diQHt+gM?=
 =?us-ascii?Q?D8gpF//1zu3U2cfREvyfjEoIoNJRGM6y1OozfOc84EO3YYGMyvqtCE5mAeZV?=
 =?us-ascii?Q?iKdgS+axKuIY6vEtRBXMaJURKja16oolrOvN4sLn/mDZRGUQeF3MH09lmbAV?=
 =?us-ascii?Q?WTakikEpg50Uzu5JFb72/Tjc2OhViTwYaMJuupZYVz5xk5XLAScMFkXHAxTi?=
 =?us-ascii?Q?O8l37KSjdkDZOVc/0JVxJetnwU5Hf1FYl8Y0Ool2b6JfIc05WmmrM9eXOOIp?=
 =?us-ascii?Q?oaGxUJHfZEXJQfMB03daPLi2Bll2tfQ5ul7Mlcu7iGEA1Yf7M0nBVkNh8ryv?=
 =?us-ascii?Q?6ZVmC04lSqIlwbajyYEm9RmvY7dhVHrETlRdJ7Z0uYXwegi3vVikYKsjClg4?=
 =?us-ascii?Q?VW8XDVH3XJlNmIdm3hwbHPhBWlZchawcCKYyqTZzS6rc8iVXBmDcqXy4kXl0?=
 =?us-ascii?Q?avOuneHusKwEhhL5C2ZHM6vAzE6wz7OSTAjGQNzvXhI2povX2gDzxwFTCfzE?=
 =?us-ascii?Q?zU65rns1tR3WsXkACaXW8ssGixAqEviWZZ3iQb8tQC3i7MA/DDF9mSsFb2fq?=
 =?us-ascii?Q?Tc/PfZbDZPynHvywXSbWHTfim4/S5ZX1qkEo0NvsYryXV9IgBgeGfH5oC+Gq?=
 =?us-ascii?Q?aabJXeVgMc7JzSxtUbXudO9GNEVGClM+7e5+J1w3lT4ruipyLvqyEoZo8mEm?=
 =?us-ascii?Q?SFJhoo+5R34I/q5aT+xAtZoIa47NhIUt68gjSw/HHBI6HQQZ/UqCakbY/y8k?=
 =?us-ascii?Q?8Eo7AzD1mcGQwNAQhvZ+VchHoUTCCsWraXZfYSiXNLH6K28I5hUcHZNowGTu?=
 =?us-ascii?Q?vEs/2jOc1VfQ1FIt2jY53VBnbg3UA40Gmb6XuHmDqr+f1zoUPLdpKqq03TUp?=
 =?us-ascii?Q?JMmmmBGLemC2a2kkaBP+9+mcpeGGNzfXPwOOytILZey4ABr/9ueqguCait3V?=
 =?us-ascii?Q?WDfhFYIwfR7dZG/3et3H+243zsXrhZAUdqSG406k5EIpWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sjc3Gzr6X7HOVTjwNqH++T1LtjL5IVy6cI6cJn3m5ZLxTgKBjMVSUqpODb0r?=
 =?us-ascii?Q?IKyBUCqwLGYbVHjKCjLKyPXaYwoo1uf8YKrEWzPZxUXQMiUTwtz5cNs+t9ay?=
 =?us-ascii?Q?InGc4XefutC3qyZgg49fD3KG80Ru9/YyycNAwi8MqEgyz0V/4jPtiYi4Hwot?=
 =?us-ascii?Q?4IA2niCbLX+ZOvP6O/rKoHcITUyr/iF5b0QCYQULFREQiwzjjQCW0rbEhtgx?=
 =?us-ascii?Q?wyRy/PrYb2gp/CaqGL6ATnALyItrH/ZUbzvL25H52ELOPAOnPNy+FiTfrQqY?=
 =?us-ascii?Q?CXwzD2jcY0GKGqVQ2K7uyuDrxP5HGYAHwTOmgSAsBJth54T3iLhZJe8VPIL7?=
 =?us-ascii?Q?u8tCwvlqExdx2etF6BZ/F+CV+p7gWm+3NknudAA73ND4X5sfifYbzTPHUyTr?=
 =?us-ascii?Q?uGYrN5clnJEcVDyxk1Bb9EaiZOj08pTTH6M1zqaWZuU+AXQKNJJVCNP3jqJM?=
 =?us-ascii?Q?12wI+UIVdI3eqVfzRU+2cEVdYGRiiTOBSjTwwGoVEZvc62XsllDh3ATe+43Z?=
 =?us-ascii?Q?Ggv42xPWKenaJI6AXfqgwofs63wwnu9WaDaN5R2Lyb+AlaVZAu/O0IKSyiST?=
 =?us-ascii?Q?5zg+nQFzTrSDyfFYpD9+EoOmVxBgmFyQpNT0k/CgNEp8cU4z3+vZXxB91vcT?=
 =?us-ascii?Q?wRcOKMQb1OkYY0aYTo7L/P7ZWv6/jxWIsnsNgkDMGHgolKnEJ2A1NwG6wXvp?=
 =?us-ascii?Q?yksrGnee1Sl0EZhFbvZpjAvHLu7wiNwcoSBhxDLW+Fpyyvm39WCxWXzLzvBu?=
 =?us-ascii?Q?h8f5P4+Kl97ZNG07jnk22a+eT2BkJbA+Wd0/hJHGEMKW5SpUMlbYMnN/4yta?=
 =?us-ascii?Q?N8DsIIZVdd5gPZvCK76bMLpG1kPc87E+dOAVVL/7B4LzYy7APeW2OlJJMs7C?=
 =?us-ascii?Q?5DwxUC2BnpbyiFpYVsy6KRBsFudUqgG0U46K4MnzVIm8d/It3wSkTnXjdc2v?=
 =?us-ascii?Q?EqrkXH2LZhaUjPeECDnpmjXKWgy3aB71ErDw9+DpLm3YZzOrO4ub1v6KqoDw?=
 =?us-ascii?Q?/qwtognVbTJ5qrle+tNCru/ZmKnRJFFT740tMNFB12t+KazFGRxNPw40tk+n?=
 =?us-ascii?Q?83FKT+Eu7zA82FzrwhBfiFXg9HDpHJY2GyVoRpBgas7aNKg2LxSggr3EhFkw?=
 =?us-ascii?Q?7WxWgiFAIV4kDWN4AZGAX7C5AMyDBmw28ArcQP0Bn6vSyDMN0TMFSoCBvLVg?=
 =?us-ascii?Q?ZzKKiJ8F3gVwkwQfNMBVsfOFwwOYzixOESHVaxZvVRWDJrjZjyniEsO/Nsxk?=
 =?us-ascii?Q?M5eKqAmED8C6MhpkhFCqmNX+9/bZg2YKU19uM46PD2ZbSsE9reBkX1K3Q7TF?=
 =?us-ascii?Q?zlxzh9AFbfdB+HinnzUKrFQ+VCnkWWz9+RNkrcvXgP9KI6ruz3bYgDzl+gF/?=
 =?us-ascii?Q?LcC4+Z5d+9BdBIa2BWuG7MKo4adrhvn+w2CuZCx9Hp0OwlTH7rHtiADxt/og?=
 =?us-ascii?Q?Ztxvae00x5apU8akiDwnMyznBCtyYONPGSSFrxavLwPtbHkBNhD3Q2m8JLiw?=
 =?us-ascii?Q?qjhjFac+W7cyZSvScxLPVsiVcZ/ZgqcvTQICo2X1WsHpnuhZNwYOfKZDKoGm?=
 =?us-ascii?Q?2u3OC2huOkcVOmG6/vc+2K84m0dbwQHIdRDmpJu0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33c126f-b0d9-47cc-e206-08dcc07e1a8e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:38:22.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4f873PPJwrY09i03abHPmPkm0RkK+nZVTp5hgDoZLBx4MPmaPnz3S5ylLY0A2Vny
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700

On Sat, Aug 17, 2024 at 10:42:44AM +0200, Zhu Yanjun wrote:
> When workqueue_flush is invoked, WQ_MEM_RECLAIM is checked to avoid
> errors.

Include backtraces please, these things are tricky and we often have
to go back and figure out why.

Explaine exactly why it is needed with traces in the commit message
and summarize in a comment.

Jason

