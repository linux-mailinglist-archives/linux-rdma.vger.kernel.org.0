Return-Path: <linux-rdma+bounces-7529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6353A2CCA0
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8613AB661
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20E187858;
	Fri,  7 Feb 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JqtPLiNE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52038385;
	Fri,  7 Feb 2025 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956807; cv=fail; b=PxKNJVCcDHKL5BNk37ZgETCey3QUiEZKYr0CP0dGJlSARAweT7c6wZSQcmnIkbSaIMjUScFiTMlUYlbZDlMTPjxghjU9lMCZJO+Zd5uzwIyrqjdIVVcl7L9dWoC5dK4cb1f4Mcxobh/eYzcIS+1is36T6oa20K23fUbYiGZBe8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956807; c=relaxed/simple;
	bh=zZ/hhf3QM31uUjwFCxQVfo96ffV6mGrHeRHuF/YVG/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qf/hDkljBFjmKyJXrZCjWStmZpWdrEIL1BMQXJjgJ0K0mFeKFn/IY6vhFv7hADAKWQN3Bv9FOP+BdJsKLq2yuFFeht6gzdKsBUK6v3+9We5ZehLwccgnzFMyOWg9BGHdVddcaXxA5Nq78t4sofvu4KK9AN3791HBVj08FG5z3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JqtPLiNE; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prG6dbUOfMnB5E5MPaXfzYLP9F+hH/VCjjeoksWxUuJdzYgjs6RLx3x/qUddplYAvo0ljvSlOafeUSkR9gugxNPuaCmOndi0xE1Lj66pKLuNT6HfmMIfmPmEnprAhCUYovspMPOYVDjNu9upOds2udr6rgPhwOJ1qFXUSjId8bN8f8qkkt2BQyquXeK7lKkPcQMd9GPyUwC0RqQ2p2r7USJB7nJXTjLcXgBBL2+tQyWfBW9RQKN2f+cc9RbKaU+0MLtdgQi0QwhFNWZnzfiy6Fk0OZnJ8eE2oL4paFcTdSsg+poWbUPKtWQJyJBVK4sY6My6RC2qO9bm4x2QpK9DXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVhvN7zodc5cWRLpq1AN6V2FKb9eV1DRZa1HO+p1j84=;
 b=C4DXsMzldzNa1zqwv+V96Ui2Z51DypZm+GM/pZSsPynY2FUEuxnMxTgSG1DX8MV77lUxuezLstKjIvuXgoJjzVsQmMBwb2wv63vtvlHYtCMCzbC7xG718hmYTd7W+mDBIjPWc1BM2Nfl/nI9skMq7BHO4Me6TVfs5aNkOoAxo+fOWbpg3bl87Gq/5eQlgjt98i2NuctWWFjUfIvkyeDb/GKH9KMlwkCDqBkjITJ3w/KNYYWFAlV+9wsqlM7uTodV+kPxWI66nsTVzlnbIIC6ga9qAWCEbSlM9nmhdrHYw3siWpI/bCFTVRc+N+eMYyyxnkqF4wDrAD3O14djzq14ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVhvN7zodc5cWRLpq1AN6V2FKb9eV1DRZa1HO+p1j84=;
 b=JqtPLiNEVnzwl4MQnMIDq7qI3N3szBlbSecG2qVJQtd6be3fxaZnIa/8bOUl+ZVIgTbSCjk1tZiHRgO5hKErCgGIfcpX/eq3Thx2/O0j9kPXDvjDguVtw8VUOYjs7YMAR1Nr0MekQOGBVY92BQT7AtaG5pG7R0qFp74akQP6jSBgSxyj5n5wG1X6uOspy6DHcdNoveudZCGV+Pj1zpDZ1Pt8f576WU5MM/yYx6zKICOONPXYRhwmS/7QSu1g7V9YPt5Os7isZfT+I7ljKmiQ9pT5DHYNal4AwoidiKynZW9izX9MOcKlFT1DOv0MhN9utnLWiFwsYSnH0/+uWrBN7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 19:33:23 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 19:33:23 +0000
Date: Fri, 7 Feb 2025 11:33:21 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Talat Batheesh <talatb@nvidia.com>,
	Feras Daoud <ferasda@nvidia.com>
Subject: Re: modprobe mlx5_core on OCI bare-metal instance causes
 unrecoverable hang and I/O error
Message-ID: <Z6ZgAbyCsJzoqbZc@x130>
References: <CAHTA-uaH9w2LqQdxY4b=7q9WQsuA6ntg=QRKrsf=mPfNBmM5pw@mail.gmail.com>
 <20250207155456.GA3665725@ziepe.ca>
 <CAHTA-uasZ+ZkdzaSzz-QH=brD3PDb+wGfvE-k377SW7BCEi6hg@mail.gmail.com>
 <20250207190152.GA3665794@ziepe.ca>
 <CAHTA-uZMZ6qQZf_n55gNaTjQQ0j8nXdt1Yi_+8+-YUNhxcrs_A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHTA-uZMZ6qQZf_n55gNaTjQQ0j8nXdt1Yi_+8+-YUNhxcrs_A@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::12) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fd3619-52f4-4085-8561-08dd47ae48fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lFLyA87pqE01YLyGJD4zlAOoZHm7HtKfK/7E3kpT30fLRClOiY4ALWDaVKzo?=
 =?us-ascii?Q?KS1mrFk4Ao1a4HotIKEMZuRcxXl60xEkImA2IaTMdB4iRl+MJyihWA3rcz0q?=
 =?us-ascii?Q?iPfcWJmZnFTP+BH5pS79uOIFC5nOndtqMylNbovSP0i5UARyf6y9ELWezRqj?=
 =?us-ascii?Q?XS32jgmdAJR90CTUf59voICJ0ct+buw0BJyBknoXh4jlNMEWKVsThytjo6T4?=
 =?us-ascii?Q?V1VObjJ9Up7GZxN3VapOi8Zv5CvmZPDFSJ3rSOTIo8YScRKAKEEIZ7mmD0N2?=
 =?us-ascii?Q?9IPwXV6o/5NUWEdsso/hZb1I012TwBtEc9NJatFeT1/r5cv3gz7x0w0BLk8C?=
 =?us-ascii?Q?6eFQEvibNf2yYC1hEheE3x6iH7SyIWRfujb9fA7qUsn9vRVv61BrsqlF8BVa?=
 =?us-ascii?Q?j6/iDLUjonupU2dlnIdkxsNfXOT1fJ0llLEUU+FpNrJfjVWXeebsjMXQB8tr?=
 =?us-ascii?Q?KZNBgixcGLuQVouta25yzZvFHl1S5gDl8zzrJJOvha9E64s/2eD5AXfnm08t?=
 =?us-ascii?Q?4wFAjxneQJtF07UFkDNDWIrsYDMj2bVsyHPCc5WxRoD+zcK0+SXCtk5iwxLh?=
 =?us-ascii?Q?DI6/ehIb/m9OA56PyaESE9gNJZjrarHgfI9mt6Jq/6nliyqGJw0Jg58BSgcB?=
 =?us-ascii?Q?6uwxXH/mrqeiMZIe5Ne+oP7rQFlWlfDsUZTbdRGF/zcnWdmJ2VHhbn1n2ZNB?=
 =?us-ascii?Q?H/c8o92hucHDU0iTcB0VM5kED8w9WyqjFNI8KlmKtJCKMGsc/lyrrUzIo0hL?=
 =?us-ascii?Q?PrixDDIFLO4KgMpKqbYc+P3tOhf/nne8v50A7k90UqFmricZmAFOgFQiR80o?=
 =?us-ascii?Q?6pduz0UjE0K+9e8sVpojDtLkq+stSJv5BWxq64jvfJy/7wjZ4GKeLMmc3ibd?=
 =?us-ascii?Q?Ut1W9+CpP/P0z6iS8g0y84gxYNrpitdTOt35q0P1zvL70jS+l+AcJk4jaz/7?=
 =?us-ascii?Q?0PDe2kzt2rhq/jOn1eJltDL4l+aEF83O2Egg/K0B8Rq7GW6CxvPND+Aymcrr?=
 =?us-ascii?Q?h9eH485ErXHcFU2i/Rplat4q2wzI5+cjXAV8LDiWWIIJVYrTGw+2BUpKIDAx?=
 =?us-ascii?Q?QZ95X/A5MB9gZj7pj2AoBpkI070Wd2zQpvo7mRGdbIc+qRE4Am4/w6Srv5Ch?=
 =?us-ascii?Q?TAevocoXZztFvFnDd93cOp/sllhYnMxr5BzB4uIRX0JUOdjNWvXXXVTlJTdH?=
 =?us-ascii?Q?nK3hE+bg78OTxIPQPvZksAndxvUhnI7xkqkTIhVfMlDaSVmJp8HoymPeAB72?=
 =?us-ascii?Q?NP5oMvShGmyVj3eESKuq2+G/Ck6zke2SX3IO9EuotXc3iAAWuYpM0h9HRVFl?=
 =?us-ascii?Q?QozJPKDUeBwHQ1zTbJyWu4L+F4jlqMQrvaqA9KxEPJ+IvsTeog2rZVLd8JYu?=
 =?us-ascii?Q?6gPjDf2Bry6OawLUiJcXsNajnPbx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SByAnXxV8t70Q0ex9J4UsUrhGr2AJ/2YsGCqo/Igb9slJz0o8ibsFiXP6U+F?=
 =?us-ascii?Q?XyC7TlZPoxni3gqHA+7MP2SEwpFdWEy0BeJt0nZli4oAqVhYnZ295dj689U9?=
 =?us-ascii?Q?7snGMRKxw4GqDZK1KqOqMfM9tx02Juiiy69RTWOodg/TiBtfZtdptCkfqOdy?=
 =?us-ascii?Q?7C7x4um72x6cYNaEanOGdWiGboEQoD7AtBmzWxDmIY18URwDejinv7fxZzLa?=
 =?us-ascii?Q?ei/R7Hzfo0Y9jfmiJ+qjmO8LGPuHGq2sTOfjBhSnEmjMgEb1N/2VseCUoMf0?=
 =?us-ascii?Q?lnmMkxTYYP830AS1yuaDfzVmU/nIQiCPYXFntXySasaoYCsjXrn2M6Aau9Ru?=
 =?us-ascii?Q?6MVHcUouNyLZlmObLJqVDho8dv+yKJ0CHznmUarw8vak9goSEVg/+UpXJY/M?=
 =?us-ascii?Q?V3zfiNz+Lja11W++rvIDM3XFs+nz2006WRu/bQi1Op1B+51Q+sQTvnPbVzq2?=
 =?us-ascii?Q?JN1WiAWkKEJo+IS2dJNawDM2GNksxWMUoEaP/zYSc0NqE+iFOcZVX5nNeu8M?=
 =?us-ascii?Q?IuLjamU3vrGxK0VXPxniD28nH9cEdQhmJN8NCtXknKVe28gJkQtCECCgld3g?=
 =?us-ascii?Q?2S1YrzNIuzqBiFMHJoWPuq13BddR/X1bXGXvA/FifTyWU+g3uXilRLA0IdJc?=
 =?us-ascii?Q?OKuxbUPCnbhX4JxV103FqQ1UqkPo7dlyMH5+7yQUV2/uMAMwQHKpviqudFaH?=
 =?us-ascii?Q?l2qtmpXvQ7NQ/61Ju5PP6MOwXHMsW+lsndCPBnGBdzWF8B3qUJLX2rKlvMPe?=
 =?us-ascii?Q?ad4QHx4PxiB6zRQYY6kZ4BjptmUJle9xJbyhAkc0L+l9noJunjL61q72ldZI?=
 =?us-ascii?Q?pt5A+gpWVMJkc0mYN9jp42dATTbgeB65usVMtyUnb30bEaDhqTqb+T12KfHk?=
 =?us-ascii?Q?8kn/gnFIDh/s8UmkJw8D35ahk/4s+i83P0k1aWCK7E43jJY5RNW9kQm05NR9?=
 =?us-ascii?Q?KtvPoGUqUO8U6qbAhUMgQrqgFGiX9Hq6EQgfqwsy1kMEfKIAnw+RcVWK4Eod?=
 =?us-ascii?Q?wsyIsu8gh/x1Vd8e6rHA4rQ5HKvsCyUD0i8REvoQPUoalYVtdaRqMEdEZvFt?=
 =?us-ascii?Q?l/xmDkypkGbTxwZSitRHGEkFgyARYw8LEyIOKZcRSIkP39zFCSgkpwSKam5L?=
 =?us-ascii?Q?IJ0dkgpkalpBUGoGYnjjGW5caeeuXNmSGg71RwghMo6hhe1zV59YofoLyEV2?=
 =?us-ascii?Q?gsuuBZR0e1GjJbOtw2CO3TwDctzP7vrNoOrNnqFBbNGXRKG0P2hEHhExkdUX?=
 =?us-ascii?Q?TCHcJLVjZUGxUu0PSHrjgxDSj4N9eZ8v113dlNw+pANRQBlaa60iUAsbN2bB?=
 =?us-ascii?Q?A/vX+7xiJQtJxrSoDypZ4j8w8lTzgvGafQrh4VoYDMgmfIQ8P5wEU9TDzeLw?=
 =?us-ascii?Q?O/mOQ+N8HSLNRUWVk8dhtZeCTQun5iStT5D+QEKMhVWZcFP1oGkQPIba+F4D?=
 =?us-ascii?Q?DZe7fybjD1Fvnd2GIgjs/sZHr5MDYjZYQEb4jaikr7rMtWsmpbJ1IFCMDueS?=
 =?us-ascii?Q?EllELO0I5fyDztq1GHUk4z8ORIgjUgnh8LQrrDyE6mKwLW+CrPhLsyCTBr+W?=
 =?us-ascii?Q?wtYhLPlRJlYAemGb8HsfYTp8zxesJp8rDDY8+yph?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fd3619-52f4-4085-8561-08dd47ae48fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:33:23.3611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJoSDpoOT+ya2RVPwdVQbOPJn1tHH6EJL3MDs9ef8X9eTKEJL0DUHGnHNLKQGXkz4yHi7EGeB/7z/AtIOT1v5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268

On 07 Feb 13:24, Mitchell Augustin wrote:
>*facepalm*
>
>Thanks, I can't believe that wasn't my first thought as soon as I
>learned these instances were using iSCSI. That's almost certainly what
>is happening on this OCI instance, since the host adapter for its
>iSCSI transport is a ConnectX card.
>
>The fact that I was able to see similar behavior once on a machine
>booted from a local disk (in the A100 test I mentioned) is still
>confusing though. I'll update this thread if I can figure out a
>reliable way to reproduce that behavior.
>

BTW I saw this happening in few instances of virtualized environments as
well, where the VM storage is network/RDMA packed by the host driver/network,
when the host driver restarts (which is a normal behavior for a PV setup), 
the VM also get storage related timeouts and soft lockups.  Graceful
shutdown needs to be handled inside of the network backed block devices
IMHO.

-Saeed.

