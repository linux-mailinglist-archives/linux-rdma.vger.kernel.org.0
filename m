Return-Path: <linux-rdma+bounces-8360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC61A50099
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 14:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78FAB1626F1
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151B24501D;
	Wed,  5 Mar 2025 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JWBcn9os"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0A134D4;
	Wed,  5 Mar 2025 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181582; cv=fail; b=j1X6DXs1/rJjzimEK6Ou4E4tXeVppW4bKSgjqDdF9RaGMxvyZ59G1yhpNN9dhpjGUudMLKawWuVuSIOWdGjm3nOF8USRQABwSCRZWABvdtKdxTYsoLchrBq1/s5og08hfvqS+7UHK6cD8EKzEzyHITzbFDP1dWxFP9toy4VtFlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181582; c=relaxed/simple;
	bh=L7tubID7JzqhOX/HGnR9OvZE2JE3n/14EfbkGiumylo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIS4zApupYG6USQzl3bsPlJu8UTJfN5Oy8k/A3fSl8sKw5nfOHQhZ+3II1URvkqBP3T6gqpNF/G7COBqg4kUX7Uu9PNQhZruUGBoM88wiC6yYATjkqLozC8UzSXZFgtowMZFwJa/323j+GLZuKjORKYrEe/XyOjrgoTq6B/NGOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JWBcn9os; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrWdEvyXchg81si5i8pNKDcOv4GXDtqC/SJQYZroiZV9ujB8SYVHldNOx1z3HKZ+WfG/qlv04IK0BCggk7eXI2fLhd3S/VZx2THNZeSMOTRaV7N2luop7SHgLwqlXadPwvS4H//Q7orSVIJOLsVaWeeyZMDgHvXlEIIE5onAEvL9ZEQeazdOh+zcKsTEtxe0SW1Qz+4TlDZGpp8unFRJ7s4oT08C4+pmIyXaHWUY9FrDoInGl+TEFIF5xOG9hVF8sWcN1qjvSLdVCICriPb+J3Vsc1aETK7DaqjkgL5uFNFwlcFcy179KsccoFXv/Zk/fwIZ3R7I3AccUbPbqq34dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S7Dqk717M/ObJzyDAnglC+ODC2gK2h3zOEWlchfgsQ=;
 b=NX3D9MsFLao5XIxnJCvr9dyXUzzmUB89+nVJ3CvYHhUaJcOjS7aZlf1+V3LAkvtmxRatT4rCKOwcf1c6msNwMMwlmhbfKl6jqbrEg7iGFBJuw8UKyIwZ7PNLGor6r3tm7xvbwPoTWHesidMJcYwPvNWPi1L2rlEw8+pxt064QtKMqOcIRj4J3/BspbVkEpsgBjzS6TUxSJZj+judOXBEPFJ+vfBx1oUm3Zc4dgqaDA1znt9lpG0U0JbKErFJa0h70S4XHi1NV8rrj/y/2ebXD1SQk9QEVYzPzdjwRdaYseLlc7JZSDh9WBdJPIahvUJRvcW9egbNS5JUVWqGG4lXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S7Dqk717M/ObJzyDAnglC+ODC2gK2h3zOEWlchfgsQ=;
 b=JWBcn9osBM7sX5hYCFOCwgomiKw2JtUuBF5RO1ip1MTindI8UlXtZuw9l0WPArCKj39hGCnn+wa+cyPD1lXVDgLrwlezusAbodsfmtpR5BpocdqZXZSTiI0ExVk6LgP0Gaor/vzEI9PxjhOYooqRENQH0cxqJT662ArmSuUar3zDDw7OH/jCiYhJbuLWCMtwGLrgbEPZSLg1BjMFgWW/Wt02IZrAegpJUSOn66jD1FyE3oKYBVkwsaXCctavr3pigw81Gn9/o8FOauQORTjYCmc17AZJaDjvzTScMduuTxfl27jds2rZPm1Bwicq2xK0GCX5J591IrjKkS9y397Z9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 13:32:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:32:55 +0000
Date: Wed, 5 Mar 2025 09:32:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <20250305133254.GV133783@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304164203.38418211@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4904f7d2-b5db-4511-0197-08dd5bea3cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ef32AQxC2h3UfonQ3+HTNHz5w4h0H5fyvXbvzAd2gR7rU3yHSct835PtJRD?=
 =?us-ascii?Q?U6YvCmoV7o0NyNdrXPSOvy4XPE+Ro3WWXMWAuqEB6PAPWc6HOeyC88KjWYYn?=
 =?us-ascii?Q?ylkrsw5aGhkC8TLowrBqKOTkLuv4R3jIASCHom3KTwQNWWo0ROn78sMRBlwM?=
 =?us-ascii?Q?mWWX9mFXww3uEW4uL5R/C8hOv0FrUIaNCRI+q9qIN6OvrEUsCWyuKs1VOBIf?=
 =?us-ascii?Q?xbjmeqN5w7jt2nhsTZUhHeZFYDuLhovgfUp6uxFNojSII0fq/xT4ChfSCn03?=
 =?us-ascii?Q?MOoK0HCgZ0+sqZrNE55ftKfs4KBoRW2d7t2Us+vVMaazzRHkswiYJOJZOIO/?=
 =?us-ascii?Q?VVZBfUGkCO3I8zdaiC42dn9FFhNXwR0zTZZxu6cpQmBigIiNsgzqUSOQdXG2?=
 =?us-ascii?Q?QVkHD3D/EQzIPZPVwS75oRAusWEsyBzYSbdrH1qAeohqx7ENOc04zM8M/BBQ?=
 =?us-ascii?Q?veXbXLwqqDWJfrBVsPjcfhUvV7uvD1zEomLnKyh3ged7GTcXmi8KxonmJ2YT?=
 =?us-ascii?Q?cjVyrl4UobP3/wvODnyBHRMngsFaO/jL7Cd7sDOfRcACXl6kgL32IDZq6xoQ?=
 =?us-ascii?Q?jbJYQNg9veR3lKz4tFP80JYc9R6K+gE3ZZ3cf8H42DcOB5xcXe+2OR161oyN?=
 =?us-ascii?Q?JDh+uCstB8KSet7lGj0Wkvf00mZ1k5kw5veLMtqy4YacIQUkuSRnaFsCArEj?=
 =?us-ascii?Q?Vd+Bq6Ua8WVU9gvwkocc32kSJ5n4qrogO0uXjr67pFgSQs4d3K+vWWTlGukK?=
 =?us-ascii?Q?1BbNCvOMQwglFQWI2uK+SUT3TSsXjuR6Ufsd+/ROpQ1pcwynDrGiXMnt5mjx?=
 =?us-ascii?Q?AN+7RyOc/QGPUyUGCYtDSj9P4Auiy175rhgG1OP+HApbXUY8F+jkP+hyLatw?=
 =?us-ascii?Q?NW7Pe+SfhHHMO4KDcbPkBQIWn0h41E/VoHI79J8X0U7cskjue3ZqCgywrvY+?=
 =?us-ascii?Q?R7+yal/vRDfBrOH+45Z8u8HtrF6T6T1tJ8DVHwfBf0mPNBYkbGAXjlWK8YEJ?=
 =?us-ascii?Q?NO4HcuWBnizNNiANMxuzCcV50COXsfJaexYGFybzCI0xLWW1iZYDx11C0GuI?=
 =?us-ascii?Q?4w34HIiWhp/9XD5O3X9rSufS06PzmSDs4Els02M3MMj/4/mLewqyY7Qb/OTt?=
 =?us-ascii?Q?T/wr//J2DYMJfYZB0Gtv2H3DVsvWoLsTxT74qNoDy6n9rxq6OFRvjH3re5A0?=
 =?us-ascii?Q?rR34qpNXpIhqRk5oUArQ6tfF8zT4IftRyc/x9QDm2xOnwokrE85jJ7S3+9KY?=
 =?us-ascii?Q?GhxgVexARQ//D3iET8sFjFhUfoX/DR19g1FBH0WLDD3i0q8/W9X18b2cOT35?=
 =?us-ascii?Q?QN5GDtBgLoYP+sQC31Tib4wC7sgFijVjGRyC9ZfJpVucjmYyrFStrzcsDsP/?=
 =?us-ascii?Q?v0eKVmPzpG/pbiTHlpi8yITMi9x0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RbZ5vnV+3dxbJuaunisWcQI+F0xEqE33QDWLg83i3nLCyZtAMr+e/39dWLzs?=
 =?us-ascii?Q?obBZL35z/fiO7+eo7j0VRtpnr3mw/s2fKrMEnN5xeClFt4nmuOTz8p3mGRvG?=
 =?us-ascii?Q?A6I4Q8h8nUjdsqPnX2STFcqGYEpuLAKMRJFiV/pQNM/UbSAuB3La2LnMC6X6?=
 =?us-ascii?Q?gG3IvzSZ7coS0hxwIDEW9vXdrXVySz7q7lkRlZBan8ht8MF3THAT/GzhpG97?=
 =?us-ascii?Q?DtHH1aVtmyPCwZt1f3echcFlQw4/60F4VFePDTT4wJjWObS9PYEP3Qaspe2z?=
 =?us-ascii?Q?mrVtXKknmC2BJpICD6XHUHtADKc3fVXTS9h461Y6TdpdvL3OHYthYIICmuFN?=
 =?us-ascii?Q?NiVz0ozBi/JCaWl79hJHzvZMD2T30qG2GvLwrBob/jiJy24yCgmao2g7Q90J?=
 =?us-ascii?Q?9UHWyoa/zmHCpKuFTSxFgGQEb7Dno+APsXGHhYpzHo6CBis4WmWYUBezxQXL?=
 =?us-ascii?Q?Crxd4w+N0a4CevX7EmfIU9bQC5mIMA4kpxwAkwBc6/6e+3dEFi8SVomz9dZj?=
 =?us-ascii?Q?d3j+E7PeQ6vDNWEcGoyINTln0IqGC284ZiBmpMtXaot6NxIuVQEG3VVHxGts?=
 =?us-ascii?Q?UofEEkeEd8//avx9O3UTuOYdRk5u4cAXfTnxipfCT7Yq91Cy+OnRYHdAmBy4?=
 =?us-ascii?Q?s1Z/iIWR/uUnU9r8WKtXrS5kIoffKbqQ0WdkVq43Ti3XUNch3WexhNGMWRk+?=
 =?us-ascii?Q?nhj9FCgepOmu8sUxsjhl5lx6pyvUQsrOr6+ux9d1M2+MrCDUqZmzvsdSS+W4?=
 =?us-ascii?Q?fPvV5t9EAV9Ql7wyYMcaizT2VHTII5hQMuA/ix589QxppB6KlbhP/swSYeLj?=
 =?us-ascii?Q?RIjHZMKg6gml99+Sqy1N0FYkixmbudlC+jUwMAZk5oP77sNMx12TiycdmtMD?=
 =?us-ascii?Q?4yrXMRK0XtGc/1kXcQie/Vyvjki9p06KHjEPIDKCatQ++RbgGNQ7UX0PWRWL?=
 =?us-ascii?Q?sLDCGWUwZv/UT7hH2JKnUYu3/pqglHUvHKsjCd323UXqi2UJXLuCkyMhLlzd?=
 =?us-ascii?Q?SohFJtuLGn9vxQ51dnOCNQ528PKGWQzLyJc+C9j6HxMoWzWGAEmqc3VaKn+t?=
 =?us-ascii?Q?BMVOq2poyHCAP29cyB+ebIbKFho9AjNo0P2aEsHsGO2FrxE3Mrb2LqK/dOuE?=
 =?us-ascii?Q?AM/hB77Rr02cp0Q6uSvwA9aSS4sP31NtOMvjbn9Z2ecrbxdgpm3xXqTehwD0?=
 =?us-ascii?Q?VNePlzPHk8g5l3yf62ZDHJZCIvl+GYI/8Qgn+WILWdke+fPdEQYaAjsADfFU?=
 =?us-ascii?Q?PpY8l8POsiTbIK7IwXVMyGmJPCgE5SfDymtBTA14nh4yCIZ3DYuGF5X3NYcZ?=
 =?us-ascii?Q?fW/c1YMYqYpBN3023EP8RzAw2yBa9My49EKyO61rwNls+9dMEMSROaYJ7z+5?=
 =?us-ascii?Q?wVDvmOsQanrZ+2m+sxlJLU4fIAQYymrabG9RVu/sCjg4oxLxB9oiab3a/aY7?=
 =?us-ascii?Q?rIVsSrU6ExFdTy4iS8U2EXT9XibDTuRz0Oi3c51PdMgY3DmwyVFyQIqSq3MP?=
 =?us-ascii?Q?G5axDFmTbdoCnAI3nh0qJ3aKuF+80Fg3ZUNifP1pK9Vfx2mAzqxDTDHFvtH7?=
 =?us-ascii?Q?GPQIZnpzuESTdCVzHplAPNM0whQjKRaOVKSj1UqC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4904f7d2-b5db-4511-0197-08dd5bea3cb4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:32:55.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcz3WxfWDsFvooc9pZJ3riPBn1t3ehwk7A+SzUo23ylbPdyp5GSx6HKXJo6wszTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904

On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
> On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
> > I never agreed to that formulation. I suggested that perhaps runtime
> > configurations where netdev is the only driver using the HW could be
> > disabled (ie a netdev exclusion, not a rdma inclusion).
> 
> I thought you were arguing that me opposing the addition was
> "maintainer overreach". As in me telling other parts of the kernel
> what is and isn't allowed. Do I not get a say what gets merged under
> drivers/net/ now?

The PCI core drivers are a shared resource jointly maintained by all
the subsytems that use them. They are maintained by their respective
maintainers. Saeed/etc in this case.

It would be inappropriate for your preferences to supersede Saeed's
when he is a maintainer of the mlx5_core driver and fwctl. Please try
and get Saeed on board with your plan.

If the placement under drivers/net makes this confusing then we can
certainly change the directory names.

Jason

