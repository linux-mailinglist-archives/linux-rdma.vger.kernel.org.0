Return-Path: <linux-rdma+bounces-10427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E33ABCB09
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 00:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3FA8C3CA7
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1138421CA1F;
	Mon, 19 May 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NVv8Wjd/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE227453;
	Mon, 19 May 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747694284; cv=fail; b=MQ0m2Fwz5PRXNgEVTocTdhym9FdmFg4PTlVpe8Ncj/N410ZEOvEWkssL48TpkHwbzMDZYi+uqfsjV9nHiZxefH1nJzek1qa/adn3h3o8+CPEeYEfKM2wHasc+9Me8L3ZSM4zNXVjnXlkFjkemJDVeQas7Q2A8Pyct2kWcrUwWdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747694284; c=relaxed/simple;
	bh=OA4kSsyH48SZKRLTl8o88TF+X3S65efgqaxIA2u6Uc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FXIdtImiupYasNWwxjNta70uo70KbWuOXfxT5EznlJHLDz+NcWaHez78RlqJsUx+PbOwRrtEJM+mvx1Dobz3sluHrD7kIel3KHdEMFWs/pK0lqSkyce/YIMLC+7JwJheEMcSRFwjKMuKjeEpoQXStvtrPuwpYPwsNV9u+caAu4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVv8Wjd/; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdrM8a5ya/EW0cvvdwae/16MjJUBN3fFuMJjX/YFpO/lWwO3XtMWVaPqPe1Ec5MRgQcvNjcWf0mnDvc90Z6krxJ6OQai92XFHeNTzBm60S84NDu87YaV59v8mTiNNSRqum83F/BmLxgEtqyOqzBKGRBoe8vcnjMm4MPTCO5/IsMLX82fq2C9QRNZHnU6AVz3eGmxi38Vt1QzTPPTGlPVBQSjuRsp5ydcead08qedfPrmFs5EoFaLdtOAME55UuO3jom6erSWXeg50OKTQ/EhGq7EI4pK3Rxl/rSn/QFmWfhVEd1DdBpVPg9b6S4ZAqSaV7cJuhZezOlSYPdq+22hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWy/TMFefiMHQGw7mJhHsmmilOpC+WCR3FAqN8HoSjE=;
 b=QIxcq5/z78uRUr7pRTcm5kXXwAykCDOkVLSBv7RIXRig0bonVGSUpjg9Lwdcdma4qdiYSRPXCT7xUg7E93T/pKtxKKR9NCkNKMDSL2LjnQ7+q4TjBPrwUJnlM1HbZqy1JMDEjow/9LuxTNLmgEjSOgPjNTii9nXZeX2dEWtyojJWODWAiEnS4tATn8u9nyAJ1XdgWusVWkrComW++a+fQ8GE550MAdy69zN7ZVZQZWQy/vg8H8PdpNYTedPMIfwlPsK7d77VxhSqJKL8JNhUNpzveiHyKxXs75TnyKJHxH6ATZmhIiOMAb/W/TzukYEVJDxzM0puHq40Iytkn95UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWy/TMFefiMHQGw7mJhHsmmilOpC+WCR3FAqN8HoSjE=;
 b=NVv8Wjd/NJatRej2mFCvGMB/sfCcfIeSR+kPLowrAWWHhjjw5eGzoEHPuWG7kVNIjE1KMYIoN+4CCDlwEUIB1ZAdCeeqMHdNBdwZB+2/17mHQMwlE6ji7uSz9nJ92BsCf1/JaXj95q77YVtAQQxRVemcCanAisTvTs+Vc2qdtgRK9DAQzIw2azWcur3dzxoZTuMExYHImtfEb2B0QOHCdq4ReGm4pJxFyCoREQlVqAxsuYY6xNMm1FImDuX/gcFbxJAXhi7JbpPirf0LVTvQCdRvGznZubS0B3sNp3xwIHwax32/awbctXFWYmqO5WySpfEtarLc6RAjDzwuPNArcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 19 May
 2025 22:37:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 22:37:57 +0000
Date: Mon, 19 May 2025 19:37:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, leon@kernel.org, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <aCuywoNni6M+i07r@nvidia.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
X-ClientProxiedBy: BN9PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:408:fc::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d660cc9-1a2f-4fe0-18da-08dd9725ccc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4h9m/e1l3cN3DmqIrumAcD/3XvaZs3mstqK+RhdrtelUdXyHqZXcoWi7beta?=
 =?us-ascii?Q?ISjcvFucNunnBqnUPyLBvb6wBF0vqUMDkPWWGz5MySWGOnZqOM1KCU9cGaOm?=
 =?us-ascii?Q?CBDBEYpzhMjgaLVEGxfo36YC1GU352ygBhD2NlJBQRlfa9Y5gz5TwnSaP2Ig?=
 =?us-ascii?Q?z5Rklnw1B4L/zc+wgF7l/cBDjhBjG7+numLGFwqJTyzXpCHmXoE2EoAizbg1?=
 =?us-ascii?Q?DDdgcyYuvVDTWzgtofR0qo9OXnpoWK25MkuDIiJmwoFfjlS0Xmlk0F+5BeRp?=
 =?us-ascii?Q?KqKc1IAHZRxEYQI79yrLfvRT15ReLDAB93syP6FU+y4vvQFjm3wyjnSPEXgg?=
 =?us-ascii?Q?NwSUaewGOACBsXeN2n0Slzz14lnu5eonCE620zdzNHK/n28gCWKnuPGBaWC+?=
 =?us-ascii?Q?OgwzaMdpNiYFe/iENvNfYwRpuVqd156wxtq22AshK4cKueon42qUWXz0JhFP?=
 =?us-ascii?Q?QZLByCxYhyRn3D2YUMVUOEwgH8ZcHMljj9vYqmPffWlIdJjESYKvEhzwqxGG?=
 =?us-ascii?Q?eu3Kz6KQNqCk2rpuQ9wpTaN/qLs3scnvH32F9HTa/H42x28vYgFuTUzVJfWI?=
 =?us-ascii?Q?e9erfVihKhJLUDoFL98SKyYBBpg2+miVeDgm+ij4gVCR1kgwtILms16CZekf?=
 =?us-ascii?Q?kxAICm/uX+3HEcFQzX5vsBquTjqCkVqsk68b3YPkNcuNwlRKdhGTQOccQFni?=
 =?us-ascii?Q?pgr83tTQi7iK7Px4HJ99CwrWZsgk1JZ3attByGrUvwnTwIQx6lMHjvnTuL9Z?=
 =?us-ascii?Q?jjM2YyPT51HDe8PfBCz7YmhrSFQNQ+3aswB6kqbLGALmOco1qkGtrVr+hts6?=
 =?us-ascii?Q?diEcbM2RHFxOlRfrsOPOB0LnFoU/wu07w4NfY8kSpjXr6lXNyCJJK/RVPiBd?=
 =?us-ascii?Q?pz89aY7nDS2hsdzKHGzFHd2lRFRrzCc+Oh8qTEyPkdaZ6+K9V+6wcM2+gU57?=
 =?us-ascii?Q?kR/36llXTfTyyjbJqVyTHUP59DTRZeGmCvNlc8/MQvWTGPMVXD1j0ToR1+p5?=
 =?us-ascii?Q?//cBg9FVh9fsnvhQsXbrSn4YimQ/9gwL8FpWLaRVt8tfo7UxJ7O4ldSJD4u9?=
 =?us-ascii?Q?XASD43jjbwDmo3gATQkQABQn9esvzaj+dHEN57N+oinXA//KObLuZUVPG97H?=
 =?us-ascii?Q?MjANHq+7uL8C454h4urgylKhv5r7vPzUClI0HDY4VRpc/6LxUV0B1GkpKLMi?=
 =?us-ascii?Q?Vn9ZiQt0kchgSHwEOsg321FH9nxUuYhuO0+0g0Zm2buXSsncFopbCQh9jnMv?=
 =?us-ascii?Q?Up+rCAhf4NTb6IdsApTerK/kkezniwEv8Lq6l9ZkK/IcCbg/c3igYtRdk5zO?=
 =?us-ascii?Q?AoztxX1gsn9Ya0q0Dr0B3PQnBI1rlspwCtaXufYJ6Nj7EUTkHnrbiwWxyj2K?=
 =?us-ascii?Q?E64HUAtcp86rCeGtmtnBPKZ6ScPUr66dadcbiiVPw954STtsJTXFW/wsI31p?=
 =?us-ascii?Q?tuEWrn3LY/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EdJQNqEPjcLs4TZ1+NIYLyiMyH6DqutUf2o2KkkvL/D5riXM0jaXP1kVMIfM?=
 =?us-ascii?Q?iw5qcLvW9NrJJjgH4qfgbZVZyx/tD+ZYhW1tYqnh+/dQDO9OjgBYpEc5VvWO?=
 =?us-ascii?Q?SJG8+os49htaRa/KQPvtY1kXqjsS6ZT2AWtFaAARyMl0mpLKOaN0WnKdkPV9?=
 =?us-ascii?Q?xHFPszoDS8v7q9A3C76tdCDubGwHLf6XGit4AlojBbV+7uNB61jsJQ63vn5S?=
 =?us-ascii?Q?+5u4nS/rLTVnpx0J/SxxDMR+A+uEkiTcos9XU6NjjaHKQgCipWthei/TmF1H?=
 =?us-ascii?Q?VWLqiNaXgqE4oXfLWXfFehavwlN1d5I3Y3iTG9/bKr3HO/Qq4zmHDTEvWMBb?=
 =?us-ascii?Q?lmLM+ul7Yk+bx/gZctrORDStEU7ncJaHNPGZFzH60WpsfsDMTIzotXblzhYu?=
 =?us-ascii?Q?8sQHwwr5OtDqeF+c2QVcrR1/CJrnfLcAOxTBMRC3q2LAqHUUY/+p4cYTSB9C?=
 =?us-ascii?Q?pKrn0dRQmxPPRwLojB9c6OKzMgpgvMfZW4YxRQxIS2XLg51luoAoSGoO1MMC?=
 =?us-ascii?Q?qmV1//fMSQxBWEfKHU09VJ8MFlLJL8n1qRVDQzGJhcaYbXhVNRQJn3XKa2n9?=
 =?us-ascii?Q?Ac++FMxVXovXK1zRoHlO3Bz/vi9D8Fb4wD4Y41tl+F0SA4HLPd5y37kGpoK/?=
 =?us-ascii?Q?QcQPrk5/EU+A6Us7Fb4/GvGn+Gcail1ojdGbSuE5Dhx2oRtWmEi1byPqjmm8?=
 =?us-ascii?Q?VsbEOBa/aMNas/IyumEnbdo/tULQtpwT2ag7aG07Ulax2LFZStLy3cke/znJ?=
 =?us-ascii?Q?2V6XYOCBp8PIPQcqdzMDhE/MZQDKAYz1FM9XrSYD6d66w4+s4UBPfxjvxqJk?=
 =?us-ascii?Q?D7Jm9txMCIl/tCg7rFrvRveN5EfAZgWYNufF8rknd6St0+ephyaI3tf2UB9W?=
 =?us-ascii?Q?mWLPZCURfPMwkBCHW1x065dR7gwKjJ/eEeEY/5R5VrW/6/s2RYJK1439wBxt?=
 =?us-ascii?Q?Z2Yet4hCl9kKfR6rPLyP0hPoXzoulgWokwCUsxJZfNTxSH2Som7fhYsE/6ut?=
 =?us-ascii?Q?gShZ05nTmKbWZd49GcmMbLPZ1Wve28QdD4CpEQGjIWhiO+EsHrlXrRN4btVo?=
 =?us-ascii?Q?2f2oAV175Xpk+TxZN1ac31xQIyS0gQw+jco0nGPVEvSUKbZCEFj9yP4z+HzY?=
 =?us-ascii?Q?ZQLohpTjrxj1wnHmyCRqAVWDJ+Pls1JzJTHlHZX3xaOQIcmPwq468WkLq8ZC?=
 =?us-ascii?Q?Zd4Bj1R4jAj1zvpISuWW0BOthAk/qQebg9KPX19zogJYYb0kPPwAIBr4stpu?=
 =?us-ascii?Q?qcTU5bBtuG/fJFwNi++pvi0iyiu7OimKLSDLnw2wuoBpQaO2joqtUa8KHDF/?=
 =?us-ascii?Q?CrS0u85KLgl4HzV/sXEorsuEr3YFLU7YkO/7YkKXIcdDAkEHRE5No+kUq4yE?=
 =?us-ascii?Q?pq/KgBwe9sGo7vkXOLbWp6jNnwhFoi+gy5V/1U6GTEScLZhaT3CafVn9absy?=
 =?us-ascii?Q?zmpR5qbBD+Zu65NPHX2RFDoGK3LC1yHCLUFI1X5PGtnOM6mul1ptVdd8hJwV?=
 =?us-ascii?Q?VjbNgM6v4wIr8AiKwni9riFwqct++l9E7sj8WEHgTf/KpXiPGkCh+Ovdvkey?=
 =?us-ascii?Q?EHrLv/lvPRhUR/Hg3kgMXUpYUY0uOKJI5wvWI54G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d660cc9-1a2f-4fe0-18da-08dd9725ccc3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 22:37:56.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEV1byKGTXITecwIewTuyeVa+laPwQGZ5KyKvtVcfGSAwYdMGPBibjeIXaPUBH8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109

On Thu, May 08, 2025 at 10:29:43AM +0530, Abhijit Gangurde wrote:
> Abhijit Gangurde (14):
>   net: ionic: Create an auxiliary device for rdma driver
>   net: ionic: Update LIF identity with additional RDMA capabilities
>   net: ionic: Export the APIs from net driver to support device commands
>   net: ionic: Provide RDMA reset support for the RDMA driver
>   net: ionic: Provide interrupt allocation support for the RDMA driver
>   net: ionic: Provide doorbell and CMB region information
>   RDMA: Add IONIC to rdma_driver_id definition
>   RDMA/ionic: Register auxiliary module for ionic ethernet adapter
>   RDMA/ionic: Create device queues to support admin operations
>   RDMA/ionic: Register device ops for control path
>   RDMA/ionic: Register device ops for datapath
>   RDMA/ionic: Register device ops for miscellaneous functionality
>   RDMA/ionic: Implement device stats ops
>   RDMA/ionic: Add Makefile/Kconfig to kernel build environment

I went over this and I didn't think there was anything too unusual for
a rdma driver. There are a number of things that need fixing up but
overall it should be fine.

Please be careful with types. I see alot of just using 'int' even
though that is not the correct type. Try not to implicitly cast things
that are not int to int, try not use to signed types to hold unsigned
values.

All the use of xarray looks ineffeicient to me. I noticed some things
that show this probably hasn't been tested in debug kernels with
lockdep. Please do that thoroughly before sending it again.

Since it is so big I reviewed the entire thing applied and made notes
inline in a editor. Usually I will go back and turn these into proper
contextual comments, but there are alot and I think you will be able
to understand the remarks. At least it will be faster this way than
waiting for me to break it up. Perhaps if a discussion is needed reply
to the right line in the right message.

diff --git a/drivers/infiniband/hw/ionic/Kconfig b/drivers/infiniband/hw/ionic/Kconfig
index 023a7fcdacb88e..60e8f42e4f20de 100644
--- a/drivers/infiniband/hw/ionic/Kconfig
+++ b/drivers/infiniband/hw/ionic/Kconfig
@@ -4,6 +4,7 @@
 config INFINIBAND_IONIC
 	tristate "AMD Pensando DSC RDMA/RoCE Support"
 	depends on NETDEVICES && ETHERNET && PCI && INET && 64BIT
+	# select should not be used on kconfigs with a help text
 	select NET_VENDOR_PENSANDO
 	select IONIC
 	help
diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index 72daf03dc418eb..bdaefc0a98c4ec 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -110,6 +110,7 @@ static bool ionic_admin_next_cqe(struct ionic_ibdev *dev, struct ionic_cq *cq,
 		return false;
 
 	/* Prevent out-of-order reads of the CQE */
+	// similar comment dma_rmb() ?
 	rmb();
 
 	ibdev_dbg(&dev->ibdev, "poll admin cq %u prod %u\n",
@@ -132,6 +133,8 @@ static void ionic_admin_poll_locked(struct ionic_aq *aq)
 	u16 old_prod;
 	u8 type;
 
+	// locked by what? Add a lockdep assertion
+
 	if (dev->admin_state >= IONIC_ADMIN_KILLED) {
 		list_for_each_entry_safe(wr, wr_next, &aq->wr_prod, aq_ent) {
 			INIT_LIST_HEAD(&wr->aq_ent);
@@ -374,6 +377,7 @@ void ionic_admin_post(struct ionic_ibdev *dev, struct ionic_admin_wr *wr)
 {
 	int aq_idx;
 
+	// Probably deserves a comment why it is OK to do this. The ID can change before anything uses it.
 	aq_idx = raw_smp_processor_id() % dev->lif_cfg.aq_count;
 	ionic_admin_post_aq(dev->aq_vec[aq_idx], wr);
 }
@@ -406,6 +410,7 @@ static int ionic_admin_busy_wait(struct ionic_admin_wr *wr)
 
 		mdelay(IONIC_ADMIN_BUSY_RETRY_MS);
 
+		// cnod_resched?
 		spin_lock_irqsave(&aq->lock, irqflags);
 		ionic_admin_poll_locked(aq);
 		spin_unlock_irqrestore(&aq->lock, irqflags);
@@ -589,6 +594,7 @@ static struct ionic_aq *__ionic_create_rdma_adminq(struct ionic_ibdev *dev,
 	struct ionic_aq *aq;
 	int rc;
 
+	// Not kzalloc? Why not?
 	aq = kmalloc(sizeof(*aq), GFP_KERNEL);
 	if (!aq) {
 		rc = -ENOMEM;
@@ -669,6 +675,9 @@ static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
 
 	local_irq_save(irqflags);
 
+	/* Second time seeing this pattern, given it will need some commenting
+	and fixing to work with lockdep, suggest you make
+	lock_all_aq/unlock_all_aq functions */
 	/* Mark the admin queue, flushing at most once */
 	for (i = 0; i < dev->lif_cfg.aq_count; i++)
 		spin_lock(&dev->aq_vec[i]->lock);
@@ -703,6 +712,7 @@ static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
 		read_unlock(&dev->cq_tbl_rw);
 	}
 
+	// Weird to see the irq restore outlive any of the spinlocks, why? Add a comment.
 	local_irq_restore(irqflags);
 
 	/* Post a fatal event if requested */
@@ -720,6 +730,9 @@ void ionic_kill_rdma_admin(struct ionic_ibdev *dev, bool fatal_path)
 		return;
 
 	local_irq_save(irqflags);
+	/* I don't expect this works with lockdep turned on, does it? Please
+	make sure your driver passes tests with all sanitizers and lockdep. Be
+	sure to test unload too  */
 	for (i = 0; i < dev->lif_cfg.aq_count; i++)
 		spin_lock(&dev->aq_vec[i]->lock);
 
@@ -781,6 +794,7 @@ static bool ionic_next_eqe(struct ionic_eq *eq, struct ionic_v1_eqe *eqe)
 	if (eq->q.cons != color)
 		return false;
 
+	// Since HW is usually the thing writing to a EQE this should be dma_rmb()
 	/* Prevent out-of-order reads of the EQE */
 	rmb();
 
@@ -798,6 +812,9 @@ static void ionic_cq_event(struct ionic_ibdev *dev, u32 cqid, u8 code)
 	struct ib_event ibev;
 	struct ionic_cq *cq;
 
+	/* Weird to have a rcu protected xarray holding refcounted structs use
+	an external rwlock. Usually you'd use rcu. Didn't see a reason why this
+	needs a rwsem. */
 	read_lock_irqsave(&dev->cq_tbl_rw, irqflags);
 	cq = xa_load(&dev->cq_tbl, cqid);
 	if (cq)
@@ -843,6 +860,7 @@ static void ionic_qp_event(struct ionic_ibdev *dev, u32 qpid, u8 code)
 	struct ib_event ibev;
 	struct ionic_qp *qp;
 
+	// Same remark about RCU
 	read_lock_irqsave(&dev->qp_tbl_rw, irqflags);
 	qp = xa_load(&dev->qp_tbl, qpid);
 	if (qp)
@@ -1055,6 +1073,9 @@ static struct ionic_eq *ionic_create_eq(struct ionic_ibdev *dev, int eqid)
 
 err_cmd:
 	eq->enable = false;
+	/* This is backwards, the irq has to be stopped to make it stop queuing
+	work otherwise the work will still be running after flush. Furth since
+	the work itself requeus I'm not sure this works at all. */
 	flush_work(&eq->work);
 	free_irq(eq->irq, eq);
 err_irq:
@@ -1072,6 +1093,7 @@ static void ionic_destroy_eq(struct ionic_eq *eq)
 	struct ionic_ibdev *dev = eq->dev;
 
 	eq->enable = false;
+	// same remark about order, except here enable doesn't really do much since it isn't locked.
 	flush_work(&eq->work);
 	free_irq(eq->irq, eq);
 
@@ -1210,6 +1232,9 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
 	struct ionic_aq *aq;
 	struct ionic_eq *eq;
 
+	/* Something needs to prevent work from being queued before cancelling
+	it is meaningful, couldn't tell if that was happening. Add a comment and
+	probably a WARN_ON on the thing that prevents requeuing */
 	cancel_delayed_work_sync(&dev->admin_dwork);
 	cancel_work_sync(&dev->reset_work);
 
@@ -1218,6 +1243,7 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
 			aq = dev->aq_vec[--dev->lif_cfg.aq_count];
 			vcq = aq->vcq;
 
+			// Similar comment here.
 			cancel_work_sync(&aq->work);
 
 			__ionic_destroy_rdma_adminq(dev, aq);
@@ -1231,6 +1257,7 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
 	}
 
 	if (dev->eq_vec) {
+		// Locking? Add a lockdep assertion if caller is holding the lock
 		while (dev->lif_cfg.eq_count > 0) {
 			eq = dev->eq_vec[--dev->lif_cfg.eq_count];
 			ionic_destroy_eq(eq);
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index cd2929e8033545..2ca41c64d963ed 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -151,6 +151,7 @@ int ionic_create_cq_common(struct ionic_vcq *vcq,
 	init_completion(&cq->cq_rel_comp);
 	kref_init(&cq->cq_kref);
 
+	// More xarray weirdness
 	write_lock_irqsave(&dev->cq_tbl_rw, irqflags);
 	rc = xa_err(xa_store(&dev->cq_tbl, cq->cqid, cq, GFP_KERNEL));
 	write_unlock_irqrestore(&dev->cq_tbl_rw, irqflags);
@@ -432,6 +433,7 @@ static int ionic_alloc_ucontext(struct ib_ucontext *ibctx,
 
 err_resp:
 	ionic_put_dbid(dev, ctx->dbid);
+	// just return directly above
 err_dbid:
 err_ctx:
 	return rc;
@@ -465,6 +467,8 @@ static int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 		if (info->offset == offset)
 			goto found;
 
+	// No goto like this. Not kernel style
+
 	mutex_unlock(&ctx->mmap_mut);
 
 	/* not found */
@@ -473,6 +477,7 @@ static int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 	goto out;
 
 found:
+	// Don't do this info thing. Use the rdma_user_mmap_* API for all mmap stuff
 	list_del_init(&info->ctx_ent);
 	mutex_unlock(&ctx->mmap_mut);
 
@@ -491,6 +496,7 @@ static int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 
 	ibdev_dbg(&dev->ibdev, "remap st %#lx pf %#lx sz %#lx\n",
 		  vma->vm_start, info->pfn, size);
+	// Don't pass NULL, use the API properly
 	rc = rdma_user_mmap_io(&ctx->ibctx, vma, info->pfn, size,
 			       vma->vm_page_prot, NULL);
 	if (rc)
@@ -887,6 +893,8 @@ static struct ib_mr *ionic_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	// This seems strange, shouldn't this do something? If you don't support an all address MR then don't define this op.
+
 	return &mr->ibmr;
 }
 
@@ -927,6 +935,7 @@ static struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start,
 				       dev->lif_cfg.page_size_supported,
 				       addr);
 	if (!pg_sz) {
+		/* don't print on user errors */
 		ibdev_err(&dev->ibdev, "%s umem page size unsupported!",
 			  __func__);
 		rc = -EINVAL;
@@ -1002,6 +1011,7 @@ static struct ib_mr *ionic_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 offset,
 				       dev->lif_cfg.page_size_supported,
 				       addr);
 	if (!pg_sz) {
+		// don't print
 		ibdev_err(&dev->ibdev, "%s umem page size unsupported!",
 			  __func__);
 		rc = -EINVAL;
@@ -1080,6 +1090,7 @@ static struct ib_mr *ionic_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	if (flags & IB_MR_REREG_TRANS) {
 		ionic_pgtbl_unbuf(dev, &mr->buf);
 
+		// What about dmabuf? Check the mlx5 implementation
 		if (mr->umem)
 			ib_umem_release(mr->umem);
 
@@ -1096,6 +1107,7 @@ static struct ib_mr *ionic_rereg_user_mr(struct ib_mr *ibmr, int flags,
 					       dev->lif_cfg.page_size_supported,
 					       addr);
 		if (!pg_sz) {
+			// no prints
 			ibdev_err(&dev->ibdev, "%s umem page size unsupported!",
 				  __func__);
 			rc = -EINVAL;
@@ -1454,11 +1466,15 @@ static int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 static bool pd_local_privileged(struct ib_pd *pd)
 {
+	/* That isn't how it works, only the lkey get_dma_mr() returns is
+	special and must be used on any WRs that require it. WRs refering to any
+	other lkeys must behave normally. */
 	return !pd->uobject;
 }
 
 static bool pd_remote_privileged(struct ib_pd *pd)
 {
+	/* Same comment, except about rkeys now. */
 	return pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 }
 
@@ -2440,6 +2456,7 @@ static int ionic_create_qp(struct ib_qp *ibqp,
 			qp->sq_cmb_mmap.pfn = PHYS_PFN(qp->sq_cmb_addr);
 			if ((qp->sq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC)) ==
 				(IONIC_CMB_WC | IONIC_CMB_UC)) {
+					// No warnings on user errors?
 				ibdev_warn(&dev->ibdev,
 					   "Both sq_cmb flags IONIC_CMB_WC and IONIC_CMB_UC are set, using default driver mapping\n");
 				qp->sq_cmb &= ~(IONIC_CMB_WC | IONIC_CMB_UC);
@@ -2457,6 +2474,7 @@ static int ionic_create_qp(struct ib_qp *ibqp,
 
 			mutex_lock(&ctx->mmap_mut);
 			qp->sq_cmb_mmap.offset = ctx->mmap_off;
+			// NO, use the rdma_user_mmap api for this stuff.
 			ctx->mmap_off += qp->sq.size;
 			list_add(&qp->sq_cmb_mmap.ctx_ent, &ctx->mmap_list);
 			mutex_unlock(&ctx->mmap_mut);
@@ -2514,13 +2532,23 @@ static int ionic_create_qp(struct ib_qp *ibqp,
 	kref_init(&qp->qp_kref);
 
 	write_lock_irqsave(&dev->qp_tbl_rw, irqflags);
+	// GFP_KERNEL is wrong, this is an atomic context becuse of the above. Should't a debug kernel catch this?
 	rc = xa_err(xa_store(&dev->qp_tbl, qp->qpid, qp, GFP_KERNEL));
+	// Poor use of xa_err, more like: (same for other xarrays)
+	ent = xa_store(&dev->qp_tbl, qp->qpid, qp, GFP_KERNEL);
+
 	write_unlock_irqrestore(&dev->qp_tbl_rw, irqflags);
-	if (rc)
+	if (ent) {
+		if (WARN_ON(!xa_is_err(ent)))
+			rc = -EINVAL;
+		else
+			rc = xa_err(ent);
 		goto err_xa;
+	}
 
 	if (qp->has_sq) {
 		cq = to_ionic_vcq_cq(attr->send_cq, qp->udma_idx);
+		// WTF is is? Needs a comment, but probably this is wrong.
 		spin_lock_irqsave(&cq->lock, irqflags);
 		spin_unlock_irqrestore(&cq->lock, irqflags);
 
@@ -2826,6 +2854,7 @@ static int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (rc)
 		return rc;
 
+	// You can also check that xa_erase returns qp and warn otherwise as something is corrupted.
 	write_lock_irqsave(&dev->qp_tbl_rw, irqflags);
 	xa_erase(&dev->qp_tbl, qp->qpid);
 	write_unlock_irqrestore(&dev->qp_tbl_rw, irqflags);
@@ -2903,8 +2932,14 @@ static const struct ib_device_ops ionic_controlpath_ops = {
 
 void ionic_controlpath_setops(struct ionic_ibdev *dev)
 {
+	/* This is not how set_device_ops is ment to be used. It should only be
+	used for things that are optional based on some runtime detection.
+	Always present ops should be hardwired into the main op. */
 	ib_set_device_ops(&dev->ibdev, &ionic_controlpath_ops);
 
+	/* This is old, drivers should not set these. Only a few special ones
+	need the driver to do anything. The core code computes this based on
+	what ops pointers are not null. Same for all places doing this */
 	dev->ibdev.uverbs_cmd_mask |=
 		BIT_ULL(IB_USER_VERBS_CMD_ALLOC_PD)		|
 		BIT_ULL(IB_USER_VERBS_CMD_DEALLOC_PD)		|
diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
index 1262ba30172d77..ff6cff06c8575b 100644
--- a/drivers/infiniband/hw/ionic/ionic_datapath.c
+++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
@@ -21,6 +21,7 @@ static bool ionic_next_cqe(struct ionic_ibdev *dev, struct ionic_cq *cq,
 		return false;
 
 	/* Prevent out-of-order reads of the CQE */
+	// dma_rmb
 	rmb();
 
 	*cqe = qcqe;
@@ -639,6 +640,7 @@ static int ionic_poll_cq(struct ib_cq *ibcq, int nwc, struct ib_wc *wc)
 	int cq_i, cq_x, cq_ix;
 
 	/* poll_idx is not protected by a lock, but a race is benign */
+	// Use READ_ONCE and WRITE_ONCE then
 	cq_x = vcq->poll_idx;
 
 	vcq->poll_idx ^= dev->lif_cfg.udma_count - 1;
@@ -1411,6 +1413,7 @@ static const struct ib_device_ops ionic_datapath_ops = {
 
 void ionic_datapath_setops(struct ionic_ibdev *dev)
 {
+	// Same remark about ops and uverbs_cmd_mask
 	ib_set_device_ops(&dev->ibdev, &ionic_datapath_ops);
 
 	dev->ibdev.uverbs_cmd_mask |=
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index 2d9a2e9a0b60cf..0b58cc66d04573 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -974,6 +974,7 @@ enum ionic_tfp_csum_profiles {
 
 static inline bool ionic_v1_eqe_color(struct ionic_v1_eqe *eqe)
 {
+	// Don't need !! when casting to bool
 	return !!(eqe->evt & cpu_to_be32(IONIC_V1_EQE_COLOR));
 }
 
diff --git a/drivers/infiniband/hw/ionic/ionic_hw_stats.c b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
index 29f2571463ac3a..facc015b970295 100644
--- a/drivers/infiniband/hw/ionic/ionic_hw_stats.c
+++ b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
@@ -464,6 +464,7 @@ void ionic_stats_init(struct ionic_ibdev *dev)
 
 		xa_init_flags(&dev->counter_stats->xa_counters, XA_FLAGS_ALLOC);
 
+		// This is the right usage since it is conditional
 		ib_set_device_ops(&dev->ibdev, &ionic_counter_stats_ops);
 	}
 }
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index e292278fcbba4a..a8a8fc015c0e1e 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -26,6 +26,7 @@ static const struct auxiliary_device_id ionic_aux_id_table[] = {
 
 MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
 
+/* Why have this wrapper, just call the dispatch event from the only call site */
 void ionic_port_event(struct ionic_ibdev *dev, enum ib_event_type event)
 {
 	struct ib_event ev;
@@ -332,6 +333,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_destroy_resids(dev);
+	// Should WARN_ON(xa_is_empty()) to catch any bugs.
 	xa_destroy(&dev->qp_tbl);
 	xa_destroy(&dev->cq_tbl);
 	ib_dealloc_device(&dev->ibdev);
@@ -387,7 +389,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 
 	addrconf_ifid_eui48((u8 *)&ibdev->node_guid,
 			    ionic_lif_netdev(ionic_adev->lif));
-
+mmap_off
 	rc = ib_device_set_netdev(ibdev, ionic_lif_netdev(ionic_adev->lif), 1);
 	if (rc)
 		goto err_admin;
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 803127c625cc2f..4d966c27c2791b 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -137,6 +137,7 @@ struct ionic_eq {
 
 	struct ionic_queue	q;
 
+	// bool due to how xchg is used
 	int			armed;
 	bool			enable;
 
@@ -226,7 +227,9 @@ struct ionic_cq {
 	struct list_head	cq_list_ent;
 
 	struct ionic_queue	q;
+	// Linus has been known to complain about multiple bools in the same struct
 	bool			color;
+	// Why? This is not ABI?
 	int			reserve;
 	u16			arm_any_prod;
 	u16			arm_sol_prod;
diff --git a/drivers/infiniband/hw/ionic/ionic_res.c b/drivers/infiniband/hw/ionic/ionic_res.c
index a3b4f10aa4c84b..2d1559b42de537 100644
--- a/drivers/infiniband/hw/ionic/ionic_res.c
+++ b/drivers/infiniband/hw/ionic/ionic_res.c
@@ -7,13 +7,17 @@
 
 #include "ionic_res.h"
 
+// None of these types should be int. Use unsigned long/int or size_t as appropriate. For everywhere.
 int ionic_resid_init(struct ionic_resid_bits *resid, int size)
 {
+	// sizeof(unsigned long)
+	// size_t not int
 	int size_bytes = sizeof(long) * BITS_TO_LONGS(size);
 
 	resid->next_id = 0;
 	resid->inuse_size = size;
 
+	// Use kcalloc 
 	resid->inuse = kzalloc(size_bytes, GFP_KERNEL);
 	if (!resid->inuse)
 		return -ENOMEM;
@@ -21,11 +25,13 @@ int ionic_resid_init(struct ionic_resid_bits *resid, int size)
 	return 0;
 }
 
+// All ints are unsigned 
 int ionic_resid_get_shared(struct ionic_resid_bits *resid, int wrap_id,
 			   int next_id, int size)
 {
 	int id;
 
+	/* Are you sure you don't want to use an IDR? */
 	id = find_next_zero_bit(resid->inuse, size, next_id);
 	if (id != size) {
 		set_bit(id, resid->inuse);
diff --git a/drivers/infiniband/hw/ionic/ionic_res.h b/drivers/infiniband/hw/ionic/ionic_res.h
index e833ced1466e89..1aa9118db25fbf 100644
--- a/drivers/infiniband/hw/ionic/ionic_res.h
+++ b/drivers/infiniband/hw/ionic/ionic_res.h
@@ -4,6 +4,8 @@
 #ifndef _IONIC_RES_H_
 #define _IONIC_RES_H_
 
+/* Missing include files for header self compilation */
+
 /**
  * struct ionic_resid_bits - Number allocator based on find_first_zero_bit
  *
@@ -24,7 +26,9 @@
  * remains bounded by O(N^2) in the worst case.
  */
 struct ionic_resid_bits {
+	// unsigned int
 	int next_id;
+	// size_t
 	int inuse_size;
 	unsigned long *inuse;
 };


