Return-Path: <linux-rdma+bounces-4591-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D096124B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB041F23C76
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33E81C6F5A;
	Tue, 27 Aug 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XqK4rfdc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E51C57BF;
	Tue, 27 Aug 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772438; cv=fail; b=AoF4/xNNH6VaTDE4Rfpn/5hNT9WgWsCTqe/DxaHGH4QzBMR1dOIqAZGcd9IcaOhs+jhF5x0l8CbQdoV9QFfpJJkilaLNSyabFu5UR5ttLSKLBbCKMabbA/vjKhiJp7B0Khcz92bUcE7BQu59CKsJk8mzRMjYyeL4MSV+qEDhkYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772438; c=relaxed/simple;
	bh=fM+yLGcBCxdkR/8J5tfpY4GUPrXMWtWxd63ijcEOHeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HZor0IoHR5srA/7/peOPTIkc/5GItrcztWWhJbJvdFgCa5nHsePWQuESlo0RV0kJ64aDxhQXknbjQdODCq38nLwTRRGk3j6x+q/yHjAlN6xCZVfJxvtl5w7eYVq0icEgbLIG6JljIVOWDgH1WQHRcTh9vuH1EkplxeIq7g+9LM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XqK4rfdc; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXSArjF72eeJidgkXCaDAQMjgmx+EsaBoQv+jBgw51lJzn4m9EoOTJPtV4MZcTZP16k3fQgrZnqTnvsBumyR0g1ovgpVrt06AKMdFPbyMe00x1NTbtGa/G3G3noDEkp4u2F7aR3O3tOOGDKE7/kvZHEqY5BnFAI2EEyS3PLFSxkKzLCNiVn32Qe08hOnuelQfN958kIEVQMJPl+yvxP6anBEIZWNxlSjUbT7+2vVsuJSq2oHJh/9v7kI5NBM8rRqHr55wnSRHxOwBw8QXgOo/NXb6l4LqBZ31dU64yykozO2oCXxHaL0B0YN0TBnNE9ROvUnVA1X7L8XhV8c8w3c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfA9Br57cGtkHYh8e3pUaA/ImwDJE1vSOteucsD6mxU=;
 b=QhtD7MkB+Xnyn1K6Dqyj0G7bvbXsMLJeCYrXk01xrRyqz7RUvCBA/TfBBQCiKlYDSJh6lDVJTBM9vbAV3dXXdd5l6z8Fxh6QL5UKWytYUrFAUp30FkPYNmErxK7NCskhJyChUXPyyhr+dGmowxDonZxbjCIyCbqvXDGInxxpVbhk5/r4/+k+NlKEcObQXVbXrUQ88vdhUtf/OUza0OGRy+kNO5BdP1N0+rmA++ECs/fAHqTg7d/5buP98+xI4dZdGtQa29TR/UXrk9nWaB7rhjhLEfnd97p/mwAlsBMZVe6QouIQgIIM4RXuT7xAxOuamhCqqG8juGu90xCnl6E8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfA9Br57cGtkHYh8e3pUaA/ImwDJE1vSOteucsD6mxU=;
 b=XqK4rfdcKhLRbiLKFRrn6jLQUHeZLXOq+ssHYGctwBPUWU32DSjXtP3l6TI/0asELvmZAzwpFw9+SMaHx/5lSi/gGZA16etDuFMshP+BWrDz2jU8CAAFwUET0kadN442ZSZ2UoODxgoyprnDgQb8riq5YV1b9wCucG0RxXkqn560p+KgGknqUoQubVcU4q2VWRuK1YRgEbcJ7SVmU7lNzKPEPZh+lEvZcKUW1R2STl/aUvv08sQhZk2Da71oYZXgVhzqKnsj+JU2cddXVvdxf9DmA5vikmOkQbb930DJ/waJqHp5NPf3VGUzrLvBFmyMr1sojYQUNtVsLDi7tsrkOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 15:27:10 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:27:07 +0000
Date: Tue, 27 Aug 2024 12:27:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240827152706.GP3773488@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <5-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240821164950.486849ca@kernel.org>
 <20240822001434.GN3773488@nvidia.com>
 <20240821173051.4c4bf1f2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821173051.4c4bf1f2@kernel.org>
X-ClientProxiedBy: MN2PR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:208:237::26) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 377422d5-7c82-4a62-9a4c-08dcc6acb675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4lOcq2nXUrMv+yktVJytqtUQ0BPXEvYxqcS6rTbS+oTT8dp4U4spoHxGr0P?=
 =?us-ascii?Q?ll3r8NWvBCSBuncY26rvLFpW+alo8fOkaaVgDUjkA9D6PQRg8pz6ks2YfbKb?=
 =?us-ascii?Q?i2Np4xShlA1nGuFl3m0iv5UK+IxMx+a4EIkqiFdL9hKzBeyPhR7mX9+kIQA8?=
 =?us-ascii?Q?uldZwyzPG2fRwzNI8YWBhvFQQjGWFuIohxELnB0mM+Bhfk3ufylA3UZqELhw?=
 =?us-ascii?Q?KCtJr/knYR6xdA91jNSNnelwAwTE57cDBsLRzr6SULsEwHl8vXjoNs7GGRJZ?=
 =?us-ascii?Q?yuvWXyLIzJWz/czbeN8ym0HtVoe9J/tBgeGrCuurX10GiyZsKTINGj6pAwnH?=
 =?us-ascii?Q?mB3WGuX9bjemnsPHs4iIPXbH5DphPTZV1xK0bPLqzAANyd1O3VKGzpQd+0lW?=
 =?us-ascii?Q?sWhzSLAWf+lecWL9nYSz+8XtbsVUh23G61KuSJrIa/tc61zg7lOTgPLjF32h?=
 =?us-ascii?Q?VgJoomAwfChe8NwBAcwPEkziGj1uXUJKc8bT1xWP/oXhb8EhogPNfpmI2zu5?=
 =?us-ascii?Q?jiJzp9zw253gkm6sHSX3Q/yDhVuLDh+tivSGGuXddGzKdMehLluTvq7D1Jqa?=
 =?us-ascii?Q?U/H2wAfNpEMvejTybU7aUJ7TuS6gCsJKa/eRLRscOCmCAL429K0ZreRXjxPG?=
 =?us-ascii?Q?To8NfyVUf84DJe2jMhdYXjd3RJuZuPOrDPk5boq3THMnZxxRJK7S3tgQQI+l?=
 =?us-ascii?Q?CTYRBMgrrekQgZlxTH1Z26EqiMvHNJJqO/PLmHvYULwtnKJeA7Ysuv95I0PG?=
 =?us-ascii?Q?W2dOXafP/IvxNnS6jWaFKVwI0uC05nTi6s3ZJDyfxAk90hAH6e65dE10MvlF?=
 =?us-ascii?Q?5nRz9kvszz9wdzccfvT9dZjmUnm4yP9gJEgPh9a7r4y2TYaL126rElyORa5v?=
 =?us-ascii?Q?Cq9fionher9j7MOcNESF5wLpuvVnff3KFRCe3fo1K8esVGsvmNC5N8Y5RpRx?=
 =?us-ascii?Q?WZjKoTJKsTEbNbvSxzciqicvYMEDBq97VTxNT1FggQ+EgFQ76FC1VUFCbvIe?=
 =?us-ascii?Q?Xt64ba2WP3XLMCwTcVUTK7iupMnuhJHodREt585gWD/3aJFnsWAoIp/qy2B0?=
 =?us-ascii?Q?rUiUWVNHhwdlS+GGEVjaVegxmhg2nvfEGsLGb0BTluaqwQobY+OYEievCqzy?=
 =?us-ascii?Q?X22gNmfJRR/aXZJt5jtnPfvFXP6fd4HWvFXZ+Hn0FeWOMEzFsmeAfVfJA+px?=
 =?us-ascii?Q?pIu+N11yLNLAD/c3D9ww1JqAzF76U0jXDb3tjlcD60RAIlNKHogR7Rusvqgz?=
 =?us-ascii?Q?FDLhTqx5OR8pcX7Buk9zj9s4yA3JSALoQ8c/ZqSxNeGsRdUZwIXJ5f66DYxH?=
 =?us-ascii?Q?PsMFQcAghyZDAL64O2znGWB4GZ+7+AsHkB+Tn7SmnXAE3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/PLA6r1U0sAO8I/HjNB8t77rlU3tsJR4obFR0aV/4PCMi6OM/ZkGmtoD/1y?=
 =?us-ascii?Q?s8PbGvL9TaDE/k0Y/BPm7lSbd5PE/wecyiee3vT3h2YZXyGmar1nyZJo4ofd?=
 =?us-ascii?Q?TIEKawcQJQug7lFEIY/fJ2XiOv3gNKdovrjnB1Xhyo9mfqLKq++FAfzHKjqN?=
 =?us-ascii?Q?9cttH8Ez8G/RDnbsCg8NPrpoS+UUTpbu9Cjo78z0RsWUZP9G5cUrZXJOO0cv?=
 =?us-ascii?Q?PTVaDHTzNAZudQ9Ju/TR6EMigsXEUnhRW+XUxmggY1UR32NDLFonp6lNvZ9L?=
 =?us-ascii?Q?pSn6fuSFMUjhq1Z/WOSp7B4m11yXgl5x+0rr4V1VfjfH/jnZBCcpphLSSOGV?=
 =?us-ascii?Q?EYr56Q0Kgls9Pn3w4eJEjf2T3qCBoVCRrK0jAothX75JHcLzdlGtPMAPh6W2?=
 =?us-ascii?Q?Bh3oRUvBSCLQpF2o/xnmRKYpAWAd5Ul/yxZqTK6LI7xPuUoQK5TC07KulGQX?=
 =?us-ascii?Q?OyxZb46yAdXD5FAryxbdZMPksAujJo6c74Bgo/ieWRYPkqRMvVzHSBCQm0Ri?=
 =?us-ascii?Q?y/2jUyMuu6fH/goGFvq2ZrKLqSQ8gfWcqfSwzeCnUQRT+axcItVXb2PWbgZC?=
 =?us-ascii?Q?8MR/8X4zxDaqf4Yum4UZNKi2CZMpqsPCobSJ2b0bppyW4r5nt/pJqMq6yjFw?=
 =?us-ascii?Q?w63F/7c0D1OqbDujjioKDIE1MWCCgKUGBuzL1DL6xP3PaRoZzYVE0/QKfvly?=
 =?us-ascii?Q?pOQOGU0yk9guuamJ2zaAUIgph/MSeKgPi6W48TnUQC1JatW9lLboRENob5V3?=
 =?us-ascii?Q?KKXfqsMS5/j9+wm/kYFEIBFppARG70tKVqRugmQw/A0j+mjlw7pnAlyBBfKT?=
 =?us-ascii?Q?k6sZYzXmsNukQj2AgsT+6SxQ9l3z1s5+3b94yu3RKajj8t0VfXbAcUlhxs0D?=
 =?us-ascii?Q?OmoZtj3tiVGpqKM66TyN0VfxPiSHEocg+a4K0ENSewpLnBlgjux6zZWpm4om?=
 =?us-ascii?Q?OG83LuQnj2er5WoF85FeDWXI8Fy38mfhZBJstcg/Ue71TsNot1ol8S/zh0yx?=
 =?us-ascii?Q?z0OpuPOslnMh2Pxug0znIa/mSs9qaVsA/kEUkQSXOq2uOUrMXXx0cPzwVYbT?=
 =?us-ascii?Q?2+9mvSgAB6bQw7mQm6BeNHLw3Hlu3H6ZBILgjtRotbyWymQCCrRrmcZ8Ax/e?=
 =?us-ascii?Q?N1XfbibguTda450ifpkTUuSbvDsRlT3YbPILgjg1O9GCh0AYsXp4KabD4Sjc?=
 =?us-ascii?Q?0q+Vd5YQLhC09zb1VcsKyzBkOIjrTgLJUhRAYNHfqfzQ+7MxW3WA3QmLt5Xu?=
 =?us-ascii?Q?1qY3ZKj+n658kY1ZVDdS4THmaRNTGUhmMIxql7lvfmmi6KKB3WbwtXgPR1S1?=
 =?us-ascii?Q?IBEAO8R03J7oH1AX5SMa4EHc1fHEAzDTvxg8I3HsM7BL5CMgCXi7+mmcgdoo?=
 =?us-ascii?Q?8hpHsehLNSAcah0RWzIEYLmDzyunQIg3Wou44zF2v1WQieiOsIwqw50kk5Vx?=
 =?us-ascii?Q?QhcI77NKiHbCqRQqVTHD2hyqRtXD07o1QBYgank3JxqhsM4QHlsTcspQp/jG?=
 =?us-ascii?Q?1pSe+aV2Fi61zuuEZSyd/5Dc0rJk62GRuce+bKllBEtnIGj3SDdw0B7i2uQK?=
 =?us-ascii?Q?C5334YYmUfKo72vZ4muRMDH0cl0lTiA8ACdaCc3o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377422d5-7c82-4a62-9a4c-08dcc6acb675
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:27:07.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaDjSPbBGa3Rniqxb4eWkhFsNAD9RJFom+G0WgWmP5oPE/tRmRmDoNL3I0DI8aBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

On Wed, Aug 21, 2024 at 05:30:51PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Aug 2024 21:14:34 -0300 Jason Gunthorpe wrote:
> > > Nacked-by: Jakub Kicinski <kuba@kernel.org> # RFC 3514  
> > 
> > Your "evil bit" thing has been responded to already and that isn't how
> > it works.
> 
> "Isn't how it works"? Please just carry the tag and don't waste my time.

You raised this before, it was answered and explained. You didn't
continue that discussion.

It is standard community practice to have reasonable technical
discussion before breaking out NAK tags. I'm definately not carrying
tags on technical patches that don't meet that threshold.

If you have a question to ask then ask it in a normal polite way
please.

Jason

