Return-Path: <linux-rdma+bounces-10695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD30AC3602
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC101734A0
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 17:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00881F2361;
	Sun, 25 May 2025 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEuhPT/q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E0143C61
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748195535; cv=fail; b=TDvLKIeStOc5H/J5GtypRrcwDUC68vEBx0m6LEMk5wzCJWBKcWLGwGp/WkPqAx3mMgk7YFmfFBOsMZX7ve15eazUIsxY2GbZ/za17LVSNI0MPB9AL/rs3/zyuhbAKcyWcNlUjmTJISkdB0tZ5lO6kr737cUyBjeU5HQu9vxpR0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748195535; c=relaxed/simple;
	bh=Ih+fRjRURaBa6QBTzti9C+rnCUcpNhWw5TeOlJg9CUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AReGKw6uWgvvVsmFtOaGVIJtqYEYwt08deOkuUVbxFI1neiDX5c0Omca/YTKXmqM7L6gf5XMZ312Srycy+iN2h9az+I3ji+0wL6JRVXAGcVJ5vG1GNVC8aF4kYX+wAwBfam+rwX5EUfBB0qfNYnJKCxjB1RNqH2+ascvV+8rSfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UEuhPT/q; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj6c9EcgtVy681RZ9IVEf1GDgx6qZxu5dXeQNjyjtKW0l2LLafoplHRGt+DxV6VF95CwwTIMCmQzy6UL0jCJ+zYHU2MT3KXaVS677JBGnsMgLq0YZOp4x58UN3ZDVdZWSQ0IvVEhU3cpCI/RWQ87kahHTHOHVYjjP6Z/kjtzHjua7hhlRfG9UFVhlnah9VirZLzMuD6r4/azmreqOQ/Za1h5m44GLuCDKOiDrlJrw74X427wui7jKKcHJ3BwDs5+BnDZGikjB6GznZLxfs+y+1cAWM5F3q8L7C2vKLyBPSB+ne1WSsRnyXSGtNbgbyeFUlnoAZNqS88gBejnWm7dWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXFHGmFTKBRqQud2Z1L/Wn4AR3g2a8yUh8wnEJ2P36s=;
 b=Knoy1o25DDoHtBJuLKMFL09A4rma4F8/JUXZZHYfXwidJWlZ9ol6MX3rZsV/f8xfNqlG4oEwSfA5jaXG9rZei+HuJgVp3VsPPYyFxQZQeW6/RGSCgxCPRgB+UDOsl9zj4eydRG4KE/sgD09wsA6dwcVrutes8svLNIZvM9ICfc0CGwgPJpXC3+b5e02E5ke37Ar6aKi46OqaIEDMbAYHNkGTkZpKBKCG7SG9RGqAgZyLNT1WfcU/ynl8XsRNSwd1jckX0FFxg32ZI4F65rCcjDL6i2C8f8pU8KDQZsxY+Gj+ZHJSlOAxzr1oz5oso5OniHpW8PEnadUzSdn298i2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXFHGmFTKBRqQud2Z1L/Wn4AR3g2a8yUh8wnEJ2P36s=;
 b=UEuhPT/qD1dD53a1N8eZBw3q7wmS4Ss8ae/Y/XKD49IIdE4oM0HYa1HOIBRGEwphFb14ib6+ZARcqZ7zxbAzheiPy8mEBa18pTrvKciLd54rK6fGc1bh/MS/vB1hxWoBLfVebcjae+4q9zJQGLeRMYfC0TjcSurvk+Cy1GNgjuPZEqlnsZ9T+GMoBcFceM85uQUcBc94JCmm4g2SdFuXph+6a+csr8nP+n/gXq0FsE29b1J7vH5eyQiEPLKyBxJJaWULlZe6C2y3MCO+V/YtbUK/oszExU7norSajgbN4Qhj5a9sQiHls19jwbw0N4Zi81yb8il4W/AEsosyMCmjmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 17:52:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 17:52:11 +0000
Date: Sun, 25 May 2025 14:52:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add CQ with external memory support
Message-ID: <20250525175210.GA9786@nvidia.com>
References: <20250515145040.6862-1-mrgolin@amazon.com>
 <20250518064241.GC7435@unreal>
 <985b77cc-63bb-4cf9-885e-c2d6aca95551@amazon.com>
 <20250520091638.GF7435@unreal>
 <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae80a03-e31b-4f33-8900-541a27e30eac@amazon.com>
X-ClientProxiedBy: MN2PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:208:236::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ffc2be-cb60-42db-f931-08dd9bb4e006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ev5F/t6cmRJhZe4Bo43AB3N0Pomde7CF/GqgKghkENlX1+Z4rgl1G5LFdgwM?=
 =?us-ascii?Q?XKA9PMBAPTro+b3AC9bZqKqcenXyc8vV6zkhmCaVOR9dCToHkzOLP8/Ng1E+?=
 =?us-ascii?Q?gQ22eTDemW/J6hAAr1mOa5R8TdBAJR5g95EiPqmyT//75gt8OnoGphPoJt4U?=
 =?us-ascii?Q?SuvW/Rz2MZGTjcxJ8kRnXE174RQ0zWHULUWIFsyzR+V9e3olyXEq6H9CtMg2?=
 =?us-ascii?Q?IH149nwnn74TorGmYtlIKrCma07J73diHpB/QnTsVqtuRSscsMEiHrC/VEOf?=
 =?us-ascii?Q?sSCKz/XQ9GQYQg5+jOVlqhAoQPyo0H8CPPH3fuvJZc2vt1xkz65NoxxQHRln?=
 =?us-ascii?Q?2oD/X6iAdARXS2uOl7Ys4c4fyf8H4zhVUvV9VMbLPu9DGam7PFdlUsHUAPqj?=
 =?us-ascii?Q?qZ+/Ea/6d/pSxYCjmGMVTOIZOUQjw4XvBJjm7zmceOrR8QKkQhallOpHw6bg?=
 =?us-ascii?Q?XhgE3Fp3iRIZv7iQ6KluXhkGTEZEg0ffdD3QqwLcVqlURA4/fUE9b40/MQ2d?=
 =?us-ascii?Q?IsUGGIwDp4uZ9k+JFLGTs95aEdWJoOE+KBTM22PhX277pZDybGTUmnTnC6Jv?=
 =?us-ascii?Q?oXrQA7aDUjCzVEeTXN2XcyfQbFPyiJHwGyQmHAptw21zXXKGdStUnKTGZ6Hs?=
 =?us-ascii?Q?FVMVfFc89bhLejROWoyEhOF/uW39i77T4U5tY0dOZIjGbT6usPKWP2Gqdx/n?=
 =?us-ascii?Q?5hFqcVDvAbYIiOVSmN3lWgEAnnctLXI6wGJ7yayiG6Sr6G2ajIl8uscqFA4B?=
 =?us-ascii?Q?9iXsi81CRi0j+tKJOKpOmRVj6AdjLqG074VSP/WV+G2Gm5Wko+FtxjrGWVXI?=
 =?us-ascii?Q?rl5Vv0GYJ+9qkgEDuvFryHosyeQgJBHVsr7tnUk1/Q2r8CA9pi3wCR0E3KQ/?=
 =?us-ascii?Q?6NBEhH0FS5ZS63Cm0OmQLAJxWrb6RgP4MlXy0g1My/uDXh21suqGHDSn3VUk?=
 =?us-ascii?Q?jzuxEc3XfZf36oBuGEj9g5jF+QFkJgWfz5TqT7NsRuf8ia2nnpQIW6umvyBE?=
 =?us-ascii?Q?SyXNwCxuxFHGHp69dtdJqSJeIzBLMzPbt+Mu/c18Wy6lNW1urKQeSPTHiXOL?=
 =?us-ascii?Q?7TE6b0Gge2QFF8LT2NKrjWYsFD0wJoO3zYUuQKU94DOahcUlPDji/ZLpWHFj?=
 =?us-ascii?Q?A+da6ULjRDLYZ7dZox5RD9h45mVNWVHbFrAX1S7m1fT/pSbdCVIMW8rNS75B?=
 =?us-ascii?Q?2w08JZC7i3eVZi1Yn7jqOLBxtFk8xEyfZoFwsVzHido/o37zmaCCgYQ7XZs4?=
 =?us-ascii?Q?GeHROmBFi+ottOZyOtEwh36gFHLel4WgWDBZr+MxeBY11wKiF5qEXfNzBbyn?=
 =?us-ascii?Q?/bVLAggVCKLPXNqHq0gCuoXdUKgzZb3WYH9rHZ3+bkbOWvPLQlCa4/6diOH/?=
 =?us-ascii?Q?VjBfQvpOR024Ik3U3FejK3pE0+VYqg0OzI7y8ie88it/tIKmy8EMUI8H19jv?=
 =?us-ascii?Q?4mNuRHGuuvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dx+h0H9G/LTS5L24e2T19MqqGhyRsDQF1xjiOHZB21AUSHdnKj64TFuEXQcA?=
 =?us-ascii?Q?hYZNnIwrXVmSSDc0yd4NsrxXmjny5ENqakTX14qGokixEQtpZEQPd0ciBx+W?=
 =?us-ascii?Q?sEIvz1x5pkNPfrEl+N9n/W0T4skZ9HB2Lyzm01+F2t4WmGapxwQICYPhmzqc?=
 =?us-ascii?Q?wweboFNrLO7SZFCkV77CRopuM5RB/IYLe8aqCwoS7hk8KZWGhxIoU1/zkV7C?=
 =?us-ascii?Q?iNEChLE8NwNyVk+BMCMfOpcbh1IJ0f+0GOpXm23avFN7/HUEQ2tAyos1/bYh?=
 =?us-ascii?Q?udIEGpA9MLxyvbYymxxv8W2/RimW+DlBNkmqbUG8YsXAU1OsdVdRBVrfjSgN?=
 =?us-ascii?Q?z/jzkzojUs6Ng96uGpunIu7JfgHtyUzieVsGUa/EqBQ0dvIGaCQ/kUFlOoP2?=
 =?us-ascii?Q?oVVF8lP6I/x1r1FV+BNX0ssmCJW1lROSox0bmGz1YeXc6e4mMgCNJLH40YTx?=
 =?us-ascii?Q?ncwmI3VKDz/QB3U3g1IyXOunooRTgWTvNPcixTwi+nYyRKpAil5XKi5Tao5I?=
 =?us-ascii?Q?pEJX997J4a9IEW77Dj14Y+Ol9sqDZu6palinq1OsBcoTraq76Ikc5ByyqAmE?=
 =?us-ascii?Q?lKbCErTKXOCLAp5zjElgJsSoB6dDQNi6UUuUYrT0QfEDDo0qWRW+XchF8CTF?=
 =?us-ascii?Q?whCjJxDbb/lFxpk0USi65ga+COae4oIjV31JgwNP9NNHM4IpgGaEHShoix9d?=
 =?us-ascii?Q?pGslVQbEtvdikBtOT+1wvhYYDaikw+QCF7D9FDvUMZFo/pIoh6F1fS1ZAN4Z?=
 =?us-ascii?Q?Rdz65fkVHuDczzCbPhljxbxqvVmgqYAc7GRniYTqP1dwoORvp1Ugk7PV/Cgb?=
 =?us-ascii?Q?zHpC/Gj6zHXuDqDHGkCymAw++i/GROOfmaI3XmsY0aBKpwA5B+VuvgvfgEFA?=
 =?us-ascii?Q?IyweOzSTINXEkVgMpALSufoLZ4cx96lmIai1QhpPlqbI+wHHE76uNSSrO697?=
 =?us-ascii?Q?Cd8DRj4oXBV0eo+mLXZ02+f3OlJOUt27O1+AasbDik4Mj4ufxXtzx0SVF1Rk?=
 =?us-ascii?Q?bhhU3mITSKTXdYSDrJRxhRe1dks+MOjJ/EYk1vipI4+VRdV9XgbjbPrkKmxi?=
 =?us-ascii?Q?Z53uSkjVZTbUD5WaBeGTObk3Gf+2Mlp8oQX6RYSfMfzpz9BeLEbnoqWSfQs/?=
 =?us-ascii?Q?E+0iF8I50HfCnsotbUm5GuNCsO7/QSmbSRdqitRz3nkw5v2Cncath1VqKG76?=
 =?us-ascii?Q?PVRrQsmkGnuIIu+a58GI2GPXlgWmN77f6JWfs6QkuH6uOdjSP0aKrYQaS2ml?=
 =?us-ascii?Q?w1mKWPXC4GqRSfEKPfu3kHWsmBOFQ/TkPogYeG4WAdvONJHSEOQ6lc202LKM?=
 =?us-ascii?Q?lbGnA90Fy/VKSr19gpJK5q0dPti3Wp7TrCZ0l9e94g1D4VMsqdb8kHXi+Z1K?=
 =?us-ascii?Q?vaorUZ06msl15oK7vIX+mpzhh9Wp83TJ1hjDvQVnAaoK0RR8SieUr/1pqNe7?=
 =?us-ascii?Q?sFPRD/PTHzR3jM3Gkj67cWY0Ma41PLP3NmJjKS0xweyL5kL+VJV6nSzRJmki?=
 =?us-ascii?Q?vfP+/Ic6Gm8p5b/YgJwFGh1huv22Qxrb6xvrAoLeYXYWB9dEExXs171gCK2E?=
 =?us-ascii?Q?0QSM2Ap+RvPQ4PSdU/0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ffc2be-cb60-42db-f931-08dd9bb4e006
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:52:11.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz21FlPYwhF8bHEU6T8tSqRePQQdtqPlwDPxHVIFY3pV9Gy7zAe33nSJft4vQ3eR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

On Wed, May 21, 2025 at 06:19:51PM +0300, Margolin, Michael wrote:
> 
> On 5/20/2025 12:16 PM, Leon Romanovsky wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Sun, May 18, 2025 at 11:56:56AM +0300, Margolin, Michael wrote:
> > > On 5/18/2025 9:42 AM, Leon Romanovsky wrote:
> > > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > > 
> > > > 
> > > > 
> > > > On Thu, May 15, 2025 at 02:50:40PM +0000, Michael Margolin wrote:
> > > > > Add an option to create CQ using external memory instead of allocating
> > > > > in the driver. The memory can be passed from userspace by dmabuf fd and
> > > > > an offset.
> > > > EFA is unique here. This patch is missing description of why it is
> > > > needed, and why existing solutions if any exist, can't be used.
> > > > 
> > > > Thanks
> > > I probably should have explained more, the purpose is creating CQs that
> > > reside in GPU HBM enabling low latency polling directly by the GPU. EFA
> > > isn't unique in receiving pre-allocated memory from userspace, the extension
> > > here is the use of dmabuf for that purpose as a general mechanism that
> > > allows using memory independent of its source. I will add more info in the
> > > commit message.
> > I think that this functionality is worth to have as general verb and not DV.
> > mlx5 has something similar and now EFA needs it too.
> > 
> > Let's wait for Jason's response before rushing to implement it.
> > 
> > Thanks
> 
> Jason, any thoughts on this?
> 
> We can probably add optional attributes to create CQ command, but most of
> the handling will remain vendor specific. I'm not convinced it's beneficial
> enough.

I don't know how a general verb would work, CQs in non-dv are polled
in software in userspace and the userspace will have trouble reaching
into a dmabuf. Plus the entire point of this is usually to write the
polling code in a GPU language and run it on a GPU processor.

Meaning I think all users of this will want to use a DV interface from
verbs.

At that point, is it worth adding more common verbs support?

Though it is becoming a bit messy that drivers are all open coding
creating normal or dmabuf umems. That part might be worth generalizing
some more, and then doing QP as well.

Jason

