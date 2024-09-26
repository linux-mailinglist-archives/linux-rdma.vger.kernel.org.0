Return-Path: <linux-rdma+bounces-5119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA3987B2B
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 00:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70C21F21EE7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54919D8BB;
	Thu, 26 Sep 2024 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIwjDkIN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDEA19D897
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390047; cv=fail; b=IGbeCenOk9chhY5mfV4eIWdJxAZNrfW98rP7pb97cV3pmWC5r46tdOzaasbzQzm75+w2XVxyUtW42kGz9dzHhBvFUrkRzBUWy2HCpj8vCM6stx7BkaWo6ACSWpT6QsRIGYkAxMw54qchDel9DdpueP8Y72JQ59iy/IYqDoADD1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390047; c=relaxed/simple;
	bh=fI1k7U44hjO8PVUCK51biqFpncJ3HdJKLZsocuPinXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nT2S1NoeU4PrE6Qq+Y30ywItAiU9TGrJJWWY3QPe7fpioQTPZztC5xwMwF9OWlFwWzolxP/ks3AOUOnJOBzpiOo2ENtw61110w1joAs4cQ1mnUPs7kmdMZqg1is4w2vcUel+Kj469VnrbwWuNfB6fzNVh3JIGrroRanApkA6PfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIwjDkIN; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AA2Y/SRXQ2q2ZEaKPc+VCv3iCynhiIhWMLigqS4UA9grksrnF6l7FO49lHF0BSd2s0oUaOyVr8dLKmmwhBaIG3CHJrJtYpuyKb0a9WOZvtWf3yeBFqAUSAF694bpVUkey+0Ucu/1Xf7J/hrRUOeF6dEsA+VCtxXkj7arrMZsY6FtzbZ8ywRkfKhQCraapVhGkDMIVoGTcbnCC/YuvGikQ74rU0kLI/dLIX4HRjZlP+zEJ6QHW0/IFD45qTGWDFkBO4blt0CdrrvDnr6cyWXifs4s0vi7EdF/IWSaiqOj/cPH24bzs0gE3qxd+t8lruU2BNVAX52MIGHN8ol15iVgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD617UVRScVv9AyZYOwxV8m+tE/7TShfvb1hMLv3g2k=;
 b=P3n1sHRkrGpK9/jOmCQPnPvbWCMlW8IlwsxUUDvl8pXEAfxdHcTboqzbt2wEaeMzWIHG9e+gweyCdy9tuOZFlV9qfg8esxGi0JTpJl6Z6WH2HV8J//EJTwMGjcyH9F47bybp72z7N0o91lgQfEhRIeNZ1pDmSyvEBNyXEqYnjAhYd1s8QpOnO8exCMLC5gNwxwZzhZ3MblH5szgpzdDz8KaxqfJGl0j+/LhD0t1khMGvJcqFykrqv/rVx3P7XUI9PzpkLEl9lTMm9ZSGra9Ff06vxDfzO+ZF4HMC1SD4IQh/bBhCOPsHTaxyIUv07ShMMfR8KLC+UVqMn7GQLqAyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD617UVRScVv9AyZYOwxV8m+tE/7TShfvb1hMLv3g2k=;
 b=cIwjDkIN2HxClOlHUhmQ4z5BLgeKDfAZRFgMdWbaV3eaQpH5HI55Mqgq14MDvsHjgASlVeQMwGrmz/HLoIdwHmBcd8MXBMhulTP2pXzgbxglKwiNjd70UUPSXEKt+4ilANo5CpvOknWb1ngy3O4PDZ+iTaptM/cKH29FjTZHPwKuO9EthoUBo4uoGSYWGC65DWuF476dg/K7hCN8TEYqTyDuac25WP55K23qMMDAxHroH69LGmRWcdMwL7CMOSjrwzDZQcQdrJCXpLgex0t/mkJkzQ0Aza3CH9NL5NFbEonQaI9hYWpODDvQxctvPWISQH83HiSqQsZ77zWflOaMdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 22:34:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 22:34:02 +0000
Date: Thu, 26 Sep 2024 19:34:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	kernel test robot <lkp@intel.com>,
	Yehuda Yitschak <yehuday@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Message-ID: <20240926223400.GS9417@nvidia.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
 <20240924180030.GM9417@nvidia.com>
 <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
 <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
 <20240926145423.GB9417@nvidia.com>
 <08cf6d96-02f0-4974-ac69-b9a5184bfb20@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08cf6d96-02f0-4974-ac69-b9a5184bfb20@amazon.com>
X-ClientProxiedBy: BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: 23868ea0-1ba5-4aad-be83-08dcde7b5203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OiRyQQQoIBtuAJv4NpIjo/lrC4V/1Bt4xvZLWI5tPc+wsJrozoIOomDOc75N?=
 =?us-ascii?Q?IbselMRoHEEgQNpkYijT9CW5UyA6t3HL1kPsmQ+ez0rZu8cTVFamExo4GM0C?=
 =?us-ascii?Q?U4XgzVM6I3I0vJxqF0792DecwYllLlEISxFbtjOEE8zPAYSbUWOtApbz2y9l?=
 =?us-ascii?Q?BxHwH9rj2Msm63zFcoN3w40Va37+fRkb7WC6Qn78JH5pTaOIQgka00NUhpCV?=
 =?us-ascii?Q?SWqXeV7T+odE0zDDA7RPcgByj3sCI9tpeXpSyznSDB0vJxMvA4I6DWRMdmpp?=
 =?us-ascii?Q?jrVwutFZjzDuU0Mb48Cy4hbFYiQ+AgCbi/u6y6g/esepF0i5RQJ+Jv7Z0W5K?=
 =?us-ascii?Q?2hRGZkLVOkfA8js+5B0CbyxNPfjUtiSUoAtGCYKidocVPCcyqP70KI9Z1CZ/?=
 =?us-ascii?Q?e9+Ize7kgM21nL2kihgs9pm2eLtxFYhusDHRg7zUsEAjJ91V4qFCTsOzuKwn?=
 =?us-ascii?Q?dK1Y+Cc03NsfJMMtVlyknmn72jSFC8vhdsc5HCOyKhmkExdgs9nuCAGScUGj?=
 =?us-ascii?Q?XhOsnX1kxz6kIIjtp+ZC+RfwdjoxQvCdd7eVxpzgBYYjaQA1ey4YWBsuDEcz?=
 =?us-ascii?Q?KFP4Hp/ImJBuxlhOGG7Kd5T6OLUop7Jij6fNeMDEDFZZaQ9688Sgtz/7DMkW?=
 =?us-ascii?Q?Hkioano/IXJAEedxLBo4/5ELTqnhOQkWedrTNLkAeQ0XWd0j1nLYlLCyA7lL?=
 =?us-ascii?Q?mMOW4++ts4dXZrwSDes7o2nLWOAmUu9TQ7v4hC5trLqxgjA6WGKb+Yrxrahu?=
 =?us-ascii?Q?VseUnD2gw+Cmbx0y/vqJ/BohSY+PwHRcBoe8BbD1VRt7/Qupq4nucSFgdn7H?=
 =?us-ascii?Q?ewXvuK46xE9i3GaJE5ilOonaGINwC8rmiPVCxQRAFdGMoI2OiuhUwlI8V+0P?=
 =?us-ascii?Q?xEIsh/DWt/ylzpAVc6HddLU8sEqCk7gjzXapcQdD+D9Cc1YCWaDs2hsrW14/?=
 =?us-ascii?Q?lIt97IRmYtIsQpCuJ6P01jYtZcSbrnLzCeAy1/yPXyLfTonPliXLVz7Qhe+h?=
 =?us-ascii?Q?Rssw7wltD5HjXOj3xaTp08UoBP7EQ/bYMOqvrCh0jVzOsnbXTMLa6mckPZkr?=
 =?us-ascii?Q?wTlsI7YkOnRxzalnjGRAvLQPM6+9oJGo9XPaFnriQv6O5fAxJpM7ZQ3yrStC?=
 =?us-ascii?Q?OqOmMdVitzELphL0Wykep+qM2POc2ITOQeQIeGkLJg8GrCHt0oqKLtAhHfbO?=
 =?us-ascii?Q?SvT0aE9M2AgkPELJ8EAFRLkjUS5wDexZoDGYbFc+aB0j1mol2e6ca0wXs7+k?=
 =?us-ascii?Q?eB8fjF0wql0xomh87RPbwRn4JDRjrjAhqs/RVkt2rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ehtgFVdTfnVQXLsRNdd9KquaajvMSn2T8xpeXjpUsumIogKPx4wVw51RWkXJ?=
 =?us-ascii?Q?Z/8eJFT3FQKY2FYHLFfLSESK5HaMM9TuKouYZ7Ahs8AE5ZQzXt0t66pbMWTD?=
 =?us-ascii?Q?2MGk/EOqW8Ckl8cPtIKmmxoGAMhOJKRy3DmELLLDGElqxgHgd0Gm780TaQLE?=
 =?us-ascii?Q?+mrA00hwCU9SNBeeZLylD75mF2bHRdQSwfZHe4BzwaDmIpebPYfIF74pgq/7?=
 =?us-ascii?Q?RQEjbKNgNyZNoyk+u7/AybyCbaA0sO5CBCiKEQtSnw9UbT4ThAioHYYz0NQe?=
 =?us-ascii?Q?E1SnAPu9Y3t4FS/1l2kRkvlBK0cyYjz11hfV8KV9TFi3cdnPSfylvGpcn9PY?=
 =?us-ascii?Q?uzYuPFH3jvkg2PlmtfUYzgGMdTZTrbaH+I3DH2a6UcmaLMqdLSoPjfU4swZN?=
 =?us-ascii?Q?NnowZ+VLTn84mC6D9NkA9bE3ExAdBOwqqIJDcD21Zl1afNQ+UGoCEKJfxUS0?=
 =?us-ascii?Q?F9qQ/ORt0SN9bRiB1oKfSa5AnWPJGZCSzCVQusyMv/FgCJkkrJP7PcUgmk1j?=
 =?us-ascii?Q?fgzA+YuwR6bFwaowAKuyAo/dGC0mswrgllDorp7ngP9aOZ1d1BbT89sOd10z?=
 =?us-ascii?Q?HzuhNbEpkvi/AG8ao8o4v/dRGy5Y6Q1/EOpGdk2Wxhe2uRIFUe88Hphw8BaD?=
 =?us-ascii?Q?9je7LWemUTnskN+3MgQ59GpAqQgbBr2mD+u8DZP0GUEQJ03lhe0n1PWtbCIr?=
 =?us-ascii?Q?551fkZSGs1lwzIqtEmddq23ZjRecl1BQO88XUmtdAkMXP3XePs6R+aY/mXFI?=
 =?us-ascii?Q?jBfcsEFpo/o9b73LUoR8SDFPxtFqYr5kLj7lthOOJpG6ZEt6o8HCJukYO877?=
 =?us-ascii?Q?HDcOtw+uatj24woQjJjci2yJJgY8o5sSyRlLKKPksj356aibyxaXAhJTScfv?=
 =?us-ascii?Q?vULDBmb2mIW9eFzIQbJ+oTqDpGAEpIGlyS50zKQZZElr7gXDea0swrhJ0ZnO?=
 =?us-ascii?Q?s/Lz2oKEiB5FkHHh698bhojLBrN0HSa1L8pvPy0PJoG+mEYnj/vjR5FCtwvk?=
 =?us-ascii?Q?PLZjVhevBIcR8GwuODQI29jkmjY5eZlvh8e333q8xyWd1y/RLYLMp7YH0jSk?=
 =?us-ascii?Q?POwA0BFDFthVtBwX+0i1I3KJz5oYgB0NEenlZURvBUMHmRFG4Q0oKOV9y8Po?=
 =?us-ascii?Q?6Jgvd/sMmGpJfjokLx4QxlVBzLklExwQXlFy5JxuzbOVcXGa+lUuMROIoEKK?=
 =?us-ascii?Q?0dSK06rssCgfTbnyrqSMiQT1Rw2z5hvBH2REaT3c2FHDpcNkCn9Lb9GoC0+u?=
 =?us-ascii?Q?ulPDntEtL3rsFAzpBNn8VDN5HJED9dvxRWFFWm8AIUWPebDIPughtgqppyKi?=
 =?us-ascii?Q?0gdI7YQWX0z7urmdeDWYHuOn8TshtPTotLcZaRpOHOZ3i11CMohJ1C6rmziU?=
 =?us-ascii?Q?/6cIPWhEZkcz1zU8sdndTbVikg4ZnRF3wUEAgwebSHGg/h4XNUBbyjB/uJcA?=
 =?us-ascii?Q?KvmvkqAKdLVJzwC0yB0HhN7kjSAQ1hBg0SMEZ9Nowg4k2ztvqWWWMVa9ey01?=
 =?us-ascii?Q?D0EhzTpBo+cQkbEBcs8JqonZJIj6EW3h0lzalUsIAasxnfijVJJyForNlDLm?=
 =?us-ascii?Q?49XYTwcX8b+p6ycCbpU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23868ea0-1ba5-4aad-be83-08dcde7b5203
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 22:34:01.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48R4m7I72aHOUXNczZMGXc29zpPlltstZ1wIwCL/qHIQlXGKi6KEvwj1BGLhftg1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493

On Thu, Sep 26, 2024 at 11:03:57PM +0300, Margolin, Michael wrote:
> 
> On 9/26/2024 5:54 PM, Jason Gunthorpe wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Thu, Sep 26, 2024 at 04:25:19PM +0300, Margolin, Michael wrote:
> > 
> > > Actually that's wrong, the device always sets guid in BE order so no
> > > swap is needed in the driver in any case.
> > They you just mark it as _be64 in the struct and there is no reason
> > for the __force ?
> > 
> > Jason
> 
> That's probably the most correct way but I prefer to avoid introducing
> kernel specific types in a shared interface file.

?

what is a "shared interface file" ?

That doesn't sound like a linux thing

Jason

