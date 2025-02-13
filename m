Return-Path: <linux-rdma+bounces-7738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 299FCA34CBE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2DE188D5BA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45028A2C3;
	Thu, 13 Feb 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GL58rE19"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5A211CAF;
	Thu, 13 Feb 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469738; cv=fail; b=TADJR1Wz0FEyFrm3dHqoFovTrcCCEpbZA+h2/HJkDHIAsoRkFBP234sLYpBoyPvaVYlZuVe9sveehafB8i5ClM4hCkJrqs/6OxKEeCSh+OwkxOhdqsHIHl06t4nrxqhmm/GiOvIdp0AoA1sYQx4Rd0PwECZVn8uyLwT/IZ/q8Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469738; c=relaxed/simple;
	bh=1fGJvh1uhf/6Q5tq5wYpCC7VpxdkntIcfxF2B+x28FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MAX85HPLpCG0LtUvPMrJvf7W2XQNNYg3zqq90HexLsqO86TTB7r+/XCXlPDXdoN9SCMcXbG/cHsqH6L8m+6HWqcWuaZ7jJHQ7EfmKgrYN4wRUEzFmgefImVRCTouDTTPZCvmIRttDi+ebBSSqu4GVWvjsE6MayGypwpWbYFgBxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GL58rE19; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5aTNOdO3WPsO0hl/cUQlvuAz+h0sAJasHNBiZEaL5Ah9Pr+N2rcxGASPt3n+1np/u3xpb6gcs0oB2tQj/roW72Pw5udJ1aH1WNJKb0FzwTmwDG/YH41UY1K9j8FJnOuO0UNVc+7DJpmoeQ58gy07oXUChRHnZdDgT5vBuUxosW34Ozi3+ZX7FptuHO8zg6exL/wxdvRuRAB9znrhxV0INd/rc6XJDwMW1NuWUpDCtOOzKgCZQ5fosDPJ1ht4Id8viMdT96WEa4/RhLJq3ZDJ6rlZpNW0mt3rQ2v5sKHq/aWahglr/ZZc+MYd3E53YWw3K2C+8k39gyD8XSN35x6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbnDKgYzH5WCaYH1sS9dPigx8TLd6RiHjCMgima4Egc=;
 b=VOwQ1wgsZhR6sDAARfyPCSN4x3rBcF0Z1WgmWV0g9NviqdutBW5+Qdhjcy01vRK5j3xV3Sl8yj7YGZSASiW1XiljNYjJr7TMATvFlJTQcvLepOKhCXPOPlDKBgsPJARUFD4gcqtJJX9M0Sw853xZjVAVCU/c2On5FC1jqWsSiZS2iaGvYJyHitSmoTsiIisv/0gaH3OiD1XNSvN+5NTFCIg1dHqFwvE+U8/3TQE7RztFtFkYVJmJNHUFEA5BaP+3mcFW2sV02EArEVD/A5fVGa+y4/7xnzlt1ejI8kOeSJH/qb+ISf/klsCOeuGGkYpIvcekI6zcc2/3kyZvbSF8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbnDKgYzH5WCaYH1sS9dPigx8TLd6RiHjCMgima4Egc=;
 b=GL58rE19NvN+JS9rpAA/qksKBE2OPdVdcY+BpblQK+4cLQsUmZPPTVFQY/7r9EjR8mqBJecwUam6mdoP1ptiwGTNptlM+QcG97qJO6zeN2NNvMkas+mCJAhJzXIwS2BU8onUebJfzMBmlMa9+b9nj+axs1zxDv0Nb523PThxDUhiN0dwL65IffS9XZoxPYYmQWQSeRnG8TXdeMka4D7VwFrQhJ60XlR5v1Z0+Kh8jKSvD/sWYrPw1Kx938FY+cVO4uubytVtiPvj+3khrd4MVmJsJejEE73g51lfIPTLf+i+rZvrjZofO6T0Z27ZxiCP4z261YbXJl0PmAFJQbRl2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 18:02:09 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 18:02:09 +0000
Date: Thu, 13 Feb 2025 14:02:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
Message-ID: <20250213180207.GD3885104@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <346ad61e-9cba-4915-8748-0b8119358d7a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346ad61e-9cba-4915-8748-0b8119358d7a@amd.com>
X-ClientProxiedBy: BL1PR13CA0319.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 3830383f-2d84-45da-48ac-08dd4c5888a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akmRlSxxkBe4pBYePXbc3E/kbprXb74KlRWNTY/O6iTxczQbCm23IfcMnZtN?=
 =?us-ascii?Q?A037IyUpi4V6DIDcRHHofmgthqgkfej93zs9/JueKzFSoiLqyzUQ1cV1xz+T?=
 =?us-ascii?Q?e4M6nh8GG3bRFjVXsUDUZJQKLbxgdqc2JlW8vFYD9TUD4UlpJMvdL6aLHt78?=
 =?us-ascii?Q?W70zlOPJSGzFQoWP0RmlJ8zpmkwBSfnaX7ENwvLYb1HPCWky/4gJ9reVRvFe?=
 =?us-ascii?Q?1w54EK2ZQJHw6oMLQWfLuTlAO//+/CUk/3TeaQMxP9NJzMgGdN1mFoKXZNWF?=
 =?us-ascii?Q?o6dVrWo7OiSgPqaQNcmcLeYMmZBDa3UQzyUEZbELzYJ8Pdw8/jgsufa0rmuY?=
 =?us-ascii?Q?/4o8t4W+AzvzkFQV5Caw3k6wcE49nfAWi4mJLOYOUNjottujobXGPR9Trw5J?=
 =?us-ascii?Q?yT7hlo281D/5pc5a0OJiekqnsEsCF1XzdeXH5EMXizpkulREHhM0z1/doI4/?=
 =?us-ascii?Q?iJmi2NfZq4RTzhzyRRb95Xh/edA3PlkLXdgShmphiRjnVGz8K6/SD2fDMwvc?=
 =?us-ascii?Q?frCjSrdtO/F9GHsh5uHf13KC5hc+7Ac8EJLoR6D945CNII0E4nYpzwu6TFPe?=
 =?us-ascii?Q?kcrcSEQNAGP8rB/W4DUkFBnaVpCx31u983WGvolg3D+CxSsfRELfF9wlVycT?=
 =?us-ascii?Q?7aM/GFrm6MFAHit9cgDwjnnnPI3OdX/XxMC9wV9O0DIPUfiN7h9T/ArLYtba?=
 =?us-ascii?Q?+17eezt6/xwLj7mx8RDm3GF1hTXRYqJncz8v/+lTtArBVujRO1rOSMgTQBiV?=
 =?us-ascii?Q?xikQAj/49+7wKaN99DWJlvmot/+uCSyf6UvqZuwsF0eyVNGZCUleRd3k+gz2?=
 =?us-ascii?Q?ocZQaFpImnXjF31gSBd61Jgj/hVQ9rbkerorRRK9YZwqvYtjnZp+ogyR77YQ?=
 =?us-ascii?Q?MsyDqMry4I3GT3w/wa+mfdtBf3j6BNLvyl0ntsQd+Q8jnmKVhM+wZM8CN3b2?=
 =?us-ascii?Q?iAE1H9+lkQzvxZFOei5aEnzjxLkWOsN8PT6uWkRK81CVNzp0qFGfoptDo+rv?=
 =?us-ascii?Q?FOLR/pwtjtGglCf4/INmhXsQWH+/SXGIreilXNyHzrW4QZU90trHKvLeiSjC?=
 =?us-ascii?Q?PC7Kl2I7OILyar7UE9An1sKPqX82pvDquSfajI84nSxfNgoMq3RGQYOZrcrj?=
 =?us-ascii?Q?/NY4RD+gxctxPyOhy6OsePLgxcCUdAwOqQ2fVhaa60W6HvnevAcLpa9ErXgV?=
 =?us-ascii?Q?lf5ek93ztekiEPhSCyuBGe8NWRPpXfLKut/NN11XInNeuk79iXGHM1hVYwI1?=
 =?us-ascii?Q?gAW27AVzbyZ/zRvgD3F5dmiCGFh8lbhYg6WQf3Jv4HnWZrLg33Mw8NygV1v/?=
 =?us-ascii?Q?VC14ch4S7DbwkipGc5lJbicwMZ8dc9vczjlXYfIYb/BLM/034ut890Yjoe2i?=
 =?us-ascii?Q?gQEFfhenlfG3ILDzKhSCsQS4BYHx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I9dcNsE9jhrfXNqeNs1JzQj+X8dIYAnE/k2WvHyw7M+yqfRvBkLgScPu22y7?=
 =?us-ascii?Q?wFfj84rHxEoMJW0SUBuG8cx6KfFy/vGAUI1hJJPxA+bj0stxiOXPvYSAVlAR?=
 =?us-ascii?Q?KPmzQnqMzcQ//kbpin9SGXxN1EER/PW/jl+N/C1tC9FjK8byaZTHhNOo9RHJ?=
 =?us-ascii?Q?3tG1hXk+GBIXjWEHBsd7TD2C9w6wODzuJatewJ9vPmjpAplSNFkAGywHYrLu?=
 =?us-ascii?Q?JN6kfhiyZCjLFMDV5Y1ONh1jUaAQ+B+weqXDObdRM43GzWc8HDJ3VD1Dp9B1?=
 =?us-ascii?Q?mzNHQGpYhCY+cgx7Y4LZz5voGATeYk2jpZUcedkBp6Zl+QmE2yDqUDm4jC+G?=
 =?us-ascii?Q?nRO4x9XHExjdYjjetTGXzbBVN5EL801VGJl+lp3ocHwoWZ9n0IQtso3YqzkO?=
 =?us-ascii?Q?17Wdj//sBcz+LL3P4KuJKvVgJml7rq2slvbyws22cwoHxiA88xYSN5o2R6D1?=
 =?us-ascii?Q?Nhyjx/NqO7C6XvCTUsnv6p2UVOMmE+LDKWxLGqvYQFRi3mfj5s8EEvYSkUK4?=
 =?us-ascii?Q?vGEFIGrMvQy9jRZMWRfcNuNnFXB+SFyZjIMA8xukOxgP9/E7hwLbBbRLCk2Z?=
 =?us-ascii?Q?0zQ/53PJr/4yHy7mpagn4Wqruly787TqXg8Q+QylYRrhAh2b2LVk4MQMHiaZ?=
 =?us-ascii?Q?Gk7vHfOqMCDCn1CiEsbBIWBbuoolNRvet0jVWyY6EmHKV9ozrEPbwC4LBX8u?=
 =?us-ascii?Q?HTDjuKeUkbnhs1CV6dX1lfuNnJ2+X35hjkm59H6J0UOfDTnmNPj5u8JwaX96?=
 =?us-ascii?Q?LWKhe4b6pe93Nv+nKELvGt4YTw+K5FJ+PEC8YXrgpDWCYE8WfjnFfr3h55A8?=
 =?us-ascii?Q?zlRPlxM8fZqW1uFrqnHKPwuNh1cuHnW8ZR4HxuAcFGUKxUzRlMyhRiAV+vS0?=
 =?us-ascii?Q?G8jnk3tRDTvtxZgWqwRdKSvN2B0RrR4Zm8uhOx24I4ymhgyq/otacyxF3/1U?=
 =?us-ascii?Q?iVaj4+7lWBkonJEc3s1h4wRui55YopZweWDiRPZ62mbjm1Z19PXeT5hWAj+F?=
 =?us-ascii?Q?uG9/5e47oQX7AOI2jvZd0yDSnuUMUyCmK2OPkjHy2CTBCM5KJp5ETENSxhRZ?=
 =?us-ascii?Q?JopZjmPMH7JAKjpTI1pNauy4oY69v/nmwmlmID26+GVIpy/6li18T1pZsw6t?=
 =?us-ascii?Q?ik5YkykFGXBNPy1xPdG4pUwfd/QwvSN1J+OYmq66RGlVzs0YBp2MRUwtMlbw?=
 =?us-ascii?Q?24vpV9I7weuBp+TkjjN1NPFi6oTKnudpVSnWmngvxeFv5R30Tn0wcaVn6ELk?=
 =?us-ascii?Q?vSi7ma/jEBZM50MiYFcMnII2jw26semOEUCMM2rYpQRZdQ5AlkAsfJjipDbO?=
 =?us-ascii?Q?/IY8lsqsryS0Zn5Y+WbkHzOYUnLzzzkFHsfOOWIVphFFkJdeJClbdVPlljd6?=
 =?us-ascii?Q?l6vPOK5dWMKXZeY3ZFoghFoIazXf4doJObXgsmXJng5DwZH0uKCJYFbcexBd?=
 =?us-ascii?Q?KXeaMuDVhPQ81mUzmNBMSKGVCfDRbBLGhTL/YnzzPpjIi3dQ0Q2I+9YSxScQ?=
 =?us-ascii?Q?djmLLpz73i24NLf2+LpIL6M8dK1YDVmP6O+BRm5OXWdA1YG2Mc/sb46RzXL2?=
 =?us-ascii?Q?TZw7wRMmDpFsk9iHzQFG/Z4LvK8jZLh1nos0MOEp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3830383f-2d84-45da-48ac-08dd4c5888a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:02:09.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juVdQBYQOfxFIbYl/b8F55FHjGNcZiFJdWLeChwxM4DOwo0gQh3lrdAjmlqURyva
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On Wed, Feb 12, 2025 at 06:30:38PM -0800, Nelson, Shannon wrote:
> We've been running successfully with an earlier version of the code, but
> haven't set up our full test environment with this version yet.  Since there
> doesn't seem to be much change here, you are welcome to my Tested-by as
> well.
> 
> For the first 6 patches:
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> Tested-by: Shannon Nelson <shannon.nelson@amd.com>

Got it, thanks

Jason

