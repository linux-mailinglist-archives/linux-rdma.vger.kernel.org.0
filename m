Return-Path: <linux-rdma+bounces-13618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6ECB9A044
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 15:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C31116D122
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEDA3002C6;
	Wed, 24 Sep 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b/i3PbXB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B61A76B1;
	Wed, 24 Sep 2025 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720103; cv=fail; b=TTo2sS4IGvNo43WhUSuO5DU2iAbBHvn6Uw8pcyHDOsJGkrVr5sNNPEFGleVKlwnPFoicpTd2T7nuASMRS8Nt4JOCmShfDRVv7jPIsA0gXckdf8tceqEojt0Z6B/WLWd1FKYN3ksB9sCvNrOvaoxoMpRH2VC/xqhmQyS31978eiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720103; c=relaxed/simple;
	bh=6cyzcjqjwWqShkFK0r2ATUaS/k0kqtQTY5SYc0hTvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UW51KlDAVG8huY1abpESg0q/Jy3ovwInv1rqhPuxF2ZRmmI2O3jkz6yYTmrvBJyANQ6SZB0/lb8xwomeX4Xmg8gGllgIXCpCUGOLLPFs7FrzYC1GM+UWU7uPbiQsOixRSgJFNURmSjQwZalRClUOJadOExydUSiP4pw4GwqGyMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b/i3PbXB; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMt3KMV/1ZZsuHfhUMviQnCvxGgsbWRau+rvsdNrJz1DoHtXmdBamJU7EuhKWXu9BQEzHQt6ulNltbLsylIQxol5/Pczl9RPlZAYZUa60iAfeVrKuMC2eL7GGsgwLagP5Roo49nAnirF/xb3gTX7tpCuvdu1z9FXD5u2AzvAT02pyxhxD+1JBansSHul7Ztb5O82vvv6lza1gfvhXJYrxnPca5bCL8VuBPjxcYWdN5Z3HHB9z+pgTURQaa+f4Tpl9nKdtnchRUwmNNy8h7VDby2RorOtvsmR3iPBd7rkTJrjh1pc36TgvvNHWubDbJRSLfnTBQEiaDE7UnuX9s5CCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCXwr+RWrUTMvr/UypLHPn2YvR6B31nKjA6ygTkUh+Q=;
 b=Ew844hjrer8KjVhBydTXNQssJ5CjxEP/yUjyUY+pygDrcDy4VROglh8vtYl6HguIw9Pjxfijl73NtRqe1ySRz5dy+T6+JsuNEE7aI/2J64MDlI8M61PmjzZ/Zi77dcZuKXe/KIRAGQp02TpE0+Ca5JzZIkmX0buxcmhJuAtJHakqZQAu4j89b3/N27b0Dk7UtooBd4Pr8j2DDjgjVirgsqO2xxQMRbPgrnPoKDHb/xHwr8tWR+nI+xSO6LX7bpbKRrCoZ3xM1LU+q+lSmS/m0fKuc/9z2NwH3YfPEXwUm9sM+aGjMS6U67uB5SzmquBkucsYiVfeNf13Gnl2aJiNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCXwr+RWrUTMvr/UypLHPn2YvR6B31nKjA6ygTkUh+Q=;
 b=b/i3PbXBKSm8bh9kqruZ6IB2KRTNupEZhRNv2iAisA399GpHmD60z3cyzj5Dg2uGBcyr2/vsnY6fmub1F2sLmFtevhJeZuFJiEeGVTFb4AmeflVk+M6O8JVkxNi2dzyOzldZ4mFKl92PFKGdpN9VuMndcQRAq5SwStob5JajjMjYr6jV4nrsIFWX41HQ1XQDwDk/TuLa4ik2ynW7RjxL2AvAmQDwxdy1sdkD+TiAOikR1onNrQvEukTWAXh3Jkr+fjxymj/ey4HNKsjIudd+7gy/s5Lh8tl1GI0mI3iHlazgXNw+OvY2IeD0czZ8GI84tCXyTESiwhi2+Ibmb//GCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 13:21:37 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 13:21:36 +0000
Date: Wed, 24 Sep 2025 10:21:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding
 cq->cq_lock
Message-ID: <20250924132135.GA2653699@nvidia.com>
References: <20250822081941.989520-1-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822081941.989520-1-philipp.reisner@linbit.com>
X-ClientProxiedBy: MN0P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 2794fc9a-4df5-48d9-7df5-08ddfb6d49e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U51lQhuQpD6GacDkAHnF4BO/Fh+VLkiTIkKbUruyxPmi0tEsjHux1XunqZRW?=
 =?us-ascii?Q?ktD+iP0E/uFAf5U8bQy3j3zUXBkU+eNCRIU5qGFxKuCRqMv4PGxjj0hcAplN?=
 =?us-ascii?Q?p7+vPcTM6xIYhwqoG7WHnXaxY+iWV3XGLv9LVTYg4POaPCKwQSkoyDPEhDF6?=
 =?us-ascii?Q?MqL1aJuW6x/AvWJL7I7v9JIJgciqH9DKDeuFe6cdVWTfep6c7RAe8+q8z3EM?=
 =?us-ascii?Q?tQfDNWOB6vOD9Qz5yqtm7UDixRfSv4EeCaj8Eby8pjq8AFAv1y5yS36+kXiZ?=
 =?us-ascii?Q?kk3vy29h7Qa9a+9L/+G5GqKE5EsO3XjlDyl+olXfacOTJJYXIUZvx5OeUL0U?=
 =?us-ascii?Q?MeC/ojf4SbBZ6gRIjY2eboi0J/T2/UHPJRcZEj4HDdKf2XUWxv4X+1DMPeO6?=
 =?us-ascii?Q?6feH05TGesBcVS7xdc1IxqYJ+FNvi0WhdS2ItyYIYV7WGVkfKwlSw5eOzMOK?=
 =?us-ascii?Q?gXlETpkfZcERHpTBnLeeZeszOcZE1At7zedgLo6CF7JsMkLgEYnw+EaMUqAH?=
 =?us-ascii?Q?AoKvD4sQmAmnrPQxd+fjYP7wlv2xTncYe/pONDF4xPzietvjIK1O5tEp7swy?=
 =?us-ascii?Q?uFeA56iLBpAzpc0qr5VUPs47KU6i+9z8HRHSaangMfOrc42+8Zbg1hjq3FJ0?=
 =?us-ascii?Q?EwA20+YRyxrjgoPqiiGYHziYWaoN4FsnEycUHANFMiuine5fB7q+JoetWhrg?=
 =?us-ascii?Q?/xndMhBMDpoux5P93+hxXl9zHJjmzIF8ncb0j8kvtR/t/JDGlGzGdtQbmOa3?=
 =?us-ascii?Q?dxMWnLfDbk/a4zfaYnIhhksIxGE3Nbxph+N/Gx+rJmvFhIEa7vdHGX5TkrAG?=
 =?us-ascii?Q?RZP6ByEjczImVTGJPvhmctfFx3Pp/G7uRhZA4eCBeSmctA+BEO4J5nwZ50qh?=
 =?us-ascii?Q?0QuZs0Cq3CHvW6Rifz1CaCK6PkqlBjCRDLPsdlN4ivohyTfp4xUDNyw65M1l?=
 =?us-ascii?Q?uBagkRbk7rlXoIyNqWkGRVlL7RY8usgRY0GG7IAVSEQ2fNXR3eT9zmOaaJXT?=
 =?us-ascii?Q?36nToc+7Z1vlxeD1hsx30BAc3pl+rsPL4UrAr/VkUR2aPxjnUCy4V45wLtNy?=
 =?us-ascii?Q?05jTKA1z2ZAjg6yiR1oMUlxpDN/WpyYnsGMeSrBDpuThoNTsQgSlgAvCSCZJ?=
 =?us-ascii?Q?/9jJJIpIcin4c98190tJoQFPWBlYJe4xM/b9TXy/aD2z749l1Ck9curcLgUd?=
 =?us-ascii?Q?L+mb85Apz0nPgmrRVo9RZmD50mOtALDly6RmlbN2hVAlJ9xqm7gYdP5wckz0?=
 =?us-ascii?Q?GC/XS3phclYLP3ZhZr4ZoY9RlXUm90vCgISy+rqM5bUxYOnYKegr1eA9iGc8?=
 =?us-ascii?Q?bi66NdP/rOhY/C+FmCO0iolmzaVpUI97pN7EDq5NpUUY46SSEANzSxGidosd?=
 =?us-ascii?Q?25b/iPiHbcFlqaWOQ3ME/WpVqaMMiXuE41zYYBuQB75njlfoq/sDlcQ2CMOh?=
 =?us-ascii?Q?n0iRZnXrz6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0wN0yeMvyXCsv6i3DYel4gd+NCdlTjZqUzciwbudZqVwM4aiot1ZjVD0Sf2/?=
 =?us-ascii?Q?M3lARCeJepiPsFGeDwZwboOQJRCGm2m9mGNxWE1LDWuIYBdiAaXkFCYgYwrZ?=
 =?us-ascii?Q?m5i/VSm/SQoeJTQtY2DJPdFmcrryKKS4X8xn0WtuE9YZN2p1bbtaVbKYVW28?=
 =?us-ascii?Q?CUrl4Qivt1A74fXgZm35p1wg55Z12PfVhgFr9+ti/Dq9L7u8YLtPmSCEb2Wf?=
 =?us-ascii?Q?GzhabbzOfxKuGuSE41P1sagR0ZvF9mHBgqUKZ5V8OBeHapwCzdtcD1IWbZiB?=
 =?us-ascii?Q?tq/WHn4ife+wuxYYBIGJ2Y3lfm+qkvxU/WkVN3a9n+iVMmUCMRSVP4AAAl6w?=
 =?us-ascii?Q?s7p7U54sPoSJr1vwuDMFoA4w+jxI0ElB2lN0Xf9WRHeymLp2d9Tg3dNzxYO1?=
 =?us-ascii?Q?Rknk+EBUJvZtqwpVmAxTae5SuPWfamITmQZNeY+dy1njwAUoQ/WzKJAvNAQL?=
 =?us-ascii?Q?NdmCalo/oVkB5FCCyLgkCZtgEPq6aKHGgMhE5TNn2W6vW71DOPABMITD7+fs?=
 =?us-ascii?Q?MUW2DGHog7WQ/CW1ecX0cdOVTSXl1KTC2HU1K0R191Of3F8pi/JVhsHaFyAX?=
 =?us-ascii?Q?mcBPWbwgiA9fbhOdXAQ3xiHRCeV5poYc6TZ6oYrhaMq/3FArnZV4lSDkJ68D?=
 =?us-ascii?Q?yFH0qgX4YmAhgJt1umWHwt2ZHg3XYUKZ4kf4hbDUzmPfjDQp4mQERjCx2lDn?=
 =?us-ascii?Q?lCNCwrDHyjUU9ny4nffrJy1vjlRU5mPJqTqlQDsxuUGJ6XeXntNZT9lB3Iy4?=
 =?us-ascii?Q?h8LQbTcSZdChd3nmFvhKjvTFm3oonyrui1bLkg4jAH73DeD3Fj8gCBgobGpe?=
 =?us-ascii?Q?5ig1YOKg3lG7lT90xT+jppHjZNULqnBe3CS5ZMg4VDGdvr54/vdVy/jjWXo6?=
 =?us-ascii?Q?XPJVhVkNe4ErDWMzlkWTXwsNw6ovXueFAxfhGr0Wo2y+9vxeoYS25S+0nX8X?=
 =?us-ascii?Q?/dT+YY4+gsf2LFht2XdyxPZ0gStYNHKWoT2/+zDDkjpbuUgy/sWhlIWKubHP?=
 =?us-ascii?Q?IBkTPtkjw1wt3ErSEYZsZf41R4BHfDQ4i3JmpXq0wMrjo1GDUH1nOuGvyHng?=
 =?us-ascii?Q?ewvqE29t2EIWcRAWfRg5F+kS8w9AEtdS/1HMXjp2SYDjRhEs9Nz5WYJ/kN+e?=
 =?us-ascii?Q?5JX6GgMRmpn/uIdL9xXvZCE63yFVZL9ZK+Sv2EjT09TN7np6hsGreRw/MzpA?=
 =?us-ascii?Q?sjDsU7S9E2E4isvNYnpEOYHViypJSjLOQzQJmgVZPQ2BrjgRGpVODYfUJ9zh?=
 =?us-ascii?Q?gion3WXcdmdRJLs4SFDj8ZR4fhbvE8xGhWWz9UErlP9UfEpzZdwCNE9BE7Mf?=
 =?us-ascii?Q?4iQg/BXZoAKOT82r1UrGxIknISGgfJY+sXkmlygsHaxhAwWVcmWqluS8M1Et?=
 =?us-ascii?Q?B0yxgfFwZkZCspZvDN5YLqPCO+xBgwQ5E3+GAnEU4WeyD5eLWArc99qb1OMA?=
 =?us-ascii?Q?zVFKkU5qYx1a6JEfZfvy93Qs24RzZ8EMRGWi3TQX2VfmqiEQx90W3ZTKETSC?=
 =?us-ascii?Q?hTJ0WxVBEeiFVKWRtUtubcizNHdS50P2U7Q2hyshvBIJ3EbM6zQ9BITwOA37?=
 =?us-ascii?Q?wnuxknSANuTd2wu1OXBNDaKizIsfxVkyYdqVDqEc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2794fc9a-4df5-48d9-7df5-08ddfb6d49e3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:21:36.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6G1efRhrKFVcZT/J2KUGd6GVewn0SNwOg/LrlGMAn+VyQqX2DEjAWtGUSK0+uR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> Allow the comp_handler callback implementation to call ib_poll_cq().
> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> 
> The Mellanox and Intel drivers allow a comp_handler callback
> implementation to call ib_poll_cq().
> 
> Avoid the deadlock by calling the comp_handler callback without
> holding cq->cq_lock.

I spent some time looking at this, and I think the basic statement
above is right. The comp_handler should be able to call poll_cq/etc

rxe holding a lock it used to push a CQE is not correct.

However! The comp_handler is also supposed to be single threaded by
the driver, I don't think ULPs are prepared to handle concurrent calls
to comp_handler.

Other HW drivers run their comp_handlers from an EQ which is both
single threaded and does not exclude poll_cq/etc.

So while removing the cq lock here is correct from the perspective of
allowing poll_cq, I could not find any locking in rxe that made
do_complete() be single threaded.

Please send a v2, either explain how the do_complete is single
threaded in a comment above the comp_handler call, or make it be
single threaded.

Thanks,
Jason

