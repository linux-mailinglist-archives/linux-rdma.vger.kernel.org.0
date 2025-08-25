Return-Path: <linux-rdma+bounces-12905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568EAB344B8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACEC3BBBB8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB4277C95;
	Mon, 25 Aug 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kcduTxiq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3BAD21
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133787; cv=fail; b=npP6GTfgJ4TsfvCn3gqXoDneomcep1pMSG6D+QqBqXDTeYs5UdHMVop4nRx2rEO1R/+J0b/rXC8aP1c7WEACwV5J5PHPp4KmmhkgQsI9sIUitOOmPiVHZG4ifL833qVnkG5L1TRasBfyXGAYfpqQNNKp7hQNtSh1Wj5bQUZQkbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133787; c=relaxed/simple;
	bh=4JHyBBjdCcKVMoqbAMuec1h7+zCBfLXRE/udYFcagxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=udzC4raMo4BAjiyougt9/Bh9ex3UwVjHCpaEm6HT/9qrBf4goLNq0yhSfbAYrLkf1v7Q/mcKLRynJoti56aow8TefhC22HnYh0diJbkMU7czC3lUyHPz+P0VkBZDOoLiSr0dh57hCMXL2UVSjm486rwTZoVC839qYMMwbuyzscc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kcduTxiq; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck2ca+mmzHzv+DhCXCzByFe21GHnmUp7L8baoQgRKIQfExNKaueCHpeyKZiZvAvkUoUznKGs2Iq01aUg55vNyg0XXLh5PeEfdXiywnjz0xdgomrAPApb32RFNCL8D/FD7q5hYLTC+IXJHXapZaZXmcSsCmw2KcIlVPei0a1EeZwWAo7IbtyQ+4qkNMtyBC3XuGSAzny3RFF9kpaPS0XBgkWAf2zF/XerOwQdLd+N7QV63xJJrvYoslu6c2YWzPbaW7QLoR48Vnv0uwmxqw4xu9Mwlo+lXy4vUviB2pQ1p99R4qaz29HJPJkhM/nChHRVmscWGCId37GUCIwgbcG/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwQifIgAalJfhk9NU0sQ51lNNtCFIn69Gzc5pKMVL5M=;
 b=knqq+QeR4tiQJJ2PXlVEQNKPBEBhvzeJl5QzRTrrMlJNvNCXj9Id/jS8iBfCii9FUJMQXwKOdNCGhzpdzTJGUjt2qQ3sSqB9k50hQT9YUWTMebJ8VYRPsYsIvfX2w4PLgkkoX6ktXhaF7EZkXmqnQiLGCoJZnHEoWAjcpuqljsmEnbGHm5aIunIK+3tRRPB42IwHtStGA3cGuHxuJm9na/ljkudfxPziy/9ANXWQh3/b+8QruLhfXEJFcTpacJ1ykHIohQBl8zcy9Wyd1WYvHHMro2/XEDzII15rSLsYdKkSKQZNx0diaf9TD3E9O2zFy025jmV/GkJWiDwE5TtNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwQifIgAalJfhk9NU0sQ51lNNtCFIn69Gzc5pKMVL5M=;
 b=kcduTxiqgPb9bf3WVqGWVoStZ5b2BjTqBcPt8azRfAESp3UXSDk+nxTVVFIKp18qbMIFo31zQWXH5KK/Ml2WRxptnZzLUqJEQiIILR1MOiB2q3nRoUYxBGc0OKKkgrV5mVZzuCDizfous1W3lg3+ra/GQ7ozOh6M9ssdUX6/q4g7UYrURTbVlvpzVnbBnZaXMj6Tn7MxU7CJDwC+pWRq8gNQkFi82AE4/rofzDb+2LlEiGnT6/yGX2B2EWo25WkQFth+wOakFKvA0so3hlD38/mNyYd71i6YSDmOH40D9xsnmpG6FKs7iNdISXyHNMpiG4G3JR9v+Q39+VTDCrkxHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Mon, 25 Aug
 2025 14:56:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:56:24 +0000
Date: Mon, 25 Aug 2025 11:56:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Message-ID: <20250825145622.GA2072201@nvidia.com>
References: <20250703182314.16442-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703182314.16442-1-mrgolin@amazon.com>
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4ab0a3-0a69-440d-48ed-08dde3e78f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGday7ex4U1Fqj+xK3MEnepW9HKEchGNEDKxRD/37RgW+jhh1PPur68NUBHS?=
 =?us-ascii?Q?TUtOjDoJU3U/u8RakwD+hJwi0caqIo8qh7zBqXgsvhyn3LoOB+FXDyPQANfv?=
 =?us-ascii?Q?YpEiFtZK80o0i3SodQe6uCzOqF3UJrvv+iRXYqXzPHVWjUVEL84W5izIkU/L?=
 =?us-ascii?Q?NqzuRtStrGAkF9WjxgCsi+zMHgTn4EluHNWaV1mb4RIRmD34H8QZxIaxog5v?=
 =?us-ascii?Q?LhH/hRWrkOKA6EO5ar3k8MbNFmswkERb+2TBnXFFnLZ3NQGpkdrD80It3U/t?=
 =?us-ascii?Q?Am/wr0VhXxUkiNq85wcL8tqO5tDY0qwOHOBkhGkUHuJlMG2lKsFc+OiTM1y5?=
 =?us-ascii?Q?OYbeAi12AfQz/Z/k6Ysdwu9Ktho7BYaPUEvd2nAy9XRqzmNjiI3pUDtZFJhA?=
 =?us-ascii?Q?6m7U5xUQ6MnMsihaFHCCs0e8nGuoBctsZy9QmPvY+yb2SZ5z/lyf/Q/2A24w?=
 =?us-ascii?Q?XpBe1mZW/SF8CQ146QhXqp7MN6t7OFRlpXeOiqZLaAk1itL3Kqfqo3hFxvQd?=
 =?us-ascii?Q?Xp5lP4GwmwsZkkebfKrnBOCAC8t7vzcF9GE9lavzgYs/29bnpQmrVxyqf5CX?=
 =?us-ascii?Q?NkUmuMzbtxIa0nVkrjEnPWxtKDLHxWS0/PSL9dPXtfxTf+stYaN0r/jGbf6i?=
 =?us-ascii?Q?FoEt0NHnHZaw+nGdqEcMI3dCVaFQUVnCD+6XR8nUYNA+k1DcjVr84S8SPt3K?=
 =?us-ascii?Q?iwO9hUPWgrBXbBYn0Yu46qS1d8uu2juqzVd20wChp6dkxiDExH5qK+dZCyXS?=
 =?us-ascii?Q?/dCjYw4XqRJZ3oztFZk2TISytr+7TIJENAm2yHGqxJni55o3qdJMsl+WYYpi?=
 =?us-ascii?Q?efflJWBImWZ0wcbIsZMFzhKyuqrrDGtdXaGbczUmDdvfZMXdKDd+VHUEa3Oc?=
 =?us-ascii?Q?HxKsuIMfjxbleuxeIL6GwqHKjYlKasoryXBnnnqqwI+MBvMyf0YL7p7sixEB?=
 =?us-ascii?Q?NenKyHBdn65N0Y7bgS318lo+2iz+ugcr7G1cPU2yH4UfFjqIZUS8vr5s+6LX?=
 =?us-ascii?Q?8rPC5IsOz1eGWz+ukLFjSaUHe8pBahjuZaARlXjvsWyF0EulSxkYDpHZpQfM?=
 =?us-ascii?Q?b7E7NM2tV+/pT2VKQmCWjAAd/Lb9bTedzhz+y/Gv4sebe5oAqwLzK2OVdFG9?=
 =?us-ascii?Q?OqHvrbQLlga5dW1AT+1wOtnir2iZZQzrBlooDBYJiLRgFK2u9WSKSOrNjVgs?=
 =?us-ascii?Q?n/h29Hu10xyH/9uX4khcLTB0up6fDwoLsMYy+IOz1akpsRMlrbNeQOiFI+hz?=
 =?us-ascii?Q?ib6rDkoU2kmKmYiyXG0kQBmDsr8YTp141ZakvsS++MKGxJIV1uJwY+TT17K4?=
 =?us-ascii?Q?pouWsbilgpHcOLHX4GW3GjC0XfiORZGKrxQ6T1hLQbjyKqHTAFHsachDVzDj?=
 =?us-ascii?Q?DyfwtTjmTcmsYvrmuomaJX/H0aR0xN4WgVcbXbA2G4d/mWY6+mRdhNzxg9xB?=
 =?us-ascii?Q?cWgiwJQXC7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+KrcrjUFU5xZrcwTIRZHNAdi+C/hFAyTp2+KRJEJOUK5eFqeuTUw2b4mHPr?=
 =?us-ascii?Q?YAMYJzfaR9X8jgHopwir/3FaD7lE/lLb/KlzHQktEh+X9PustIDCuJ9HoEE6?=
 =?us-ascii?Q?j/ChP0rqgnvgTOEV4Twdelf/vVLuTyYVUta2rr9Z8JiQF8zYoe12CFSGSwd3?=
 =?us-ascii?Q?hF7FnjN8m7oTijUliRNY135GFe1ybeCgg1LXvfpcGDuhg9hKWwGmg9E4gPdQ?=
 =?us-ascii?Q?kwK57FZx/k2eiES7/4hkZPiCKoEO3ggXWimtD5Esa3xps3k8FR10opY1DbBz?=
 =?us-ascii?Q?/p/71dKX54kfEpnxCNdlpsFMycaZ/PEiDexiNgat4ugjCklgVuvGFolm/qQh?=
 =?us-ascii?Q?uC6JDCh+qf5b2gWDwpbclZqunL3owv/NW9Jyd4lwBO4nkVtFbEiCAUju3kup?=
 =?us-ascii?Q?cjka38G+hZSxUuNVkktc7JoE+oLjANV01FNGu0mBIVq+muGqpnM43SpkJ/G9?=
 =?us-ascii?Q?QKxWrbuoIZt8r2p2bXFgTJlsvgzdUezE1/mQEbpHM5GG1fRTpA1kdQ9gxMX9?=
 =?us-ascii?Q?0UHuPVzksnuBnFk8f7ZAmM/YlT/2YZkGHHRC4OlljIFCu2VQFt6nkUu9kcvM?=
 =?us-ascii?Q?7l5E9j1FnZNTksQtucQNyvRLtuH5D/SmVjauzAYCkg1bXsnJ7qc/u7e1oO20?=
 =?us-ascii?Q?Dqc8dlKMEtuuGAl2+3nG4oMQ5+snw2BvJ66PO1UhSSk+pRibNyzojY3383e7?=
 =?us-ascii?Q?Jyxe+jDR0bzHCXOQpWqR3JLIqDo1SSHKAbfDFuQEMWcjRE9e/4TCLM/l0dxp?=
 =?us-ascii?Q?PoJtLLY0Dx0dfXKZxVcZ/fs3M1p3geDXN5l7Af95FNpBvyMKA8lDGVj4nrCJ?=
 =?us-ascii?Q?ONHsuQYxXusCUbxeZOQtXDzIKzFeF526Jcqx1o2EEqlEsHQjyaLi5rZ17tXd?=
 =?us-ascii?Q?5bwqB8SYDNOqwwumM+Aq8pRj0RhwahK7tMoz78bZbuiy+RtK2KXZpZy8bgFl?=
 =?us-ascii?Q?G4wtQpI/OY+a23pUyZm4jbtblcspCmXcIelOJBYICGp81DFwh5G1ta4q1bl0?=
 =?us-ascii?Q?JOexSXmZ7mgx2K+WYvDuOSBtCa3BsJmWEMrT1YWDORGULLTL5Nd4F5yr4kfI?=
 =?us-ascii?Q?DHuHTWistW2FQZ847/chKJD/LJd4L25kv/DIKPTRCZacEM8RTuGE0tX2uoEk?=
 =?us-ascii?Q?IwsEUXWclFA3XFx0oQ6jqjxBqYfz585IED3WW+iM4CMqNJ8KpG6Hbik1j3nw?=
 =?us-ascii?Q?O+tHB/0Mmj9ShKRpOmH+vEtGzyzXxHku77NY0rJ6MqUwHqbSjctkbkglVPOI?=
 =?us-ascii?Q?JX64Xm6+t0RwZxznwMQQ1+oZ4xJ9EZ98oWJDi2SmBwo3Mh51+fGCL93lZHBl?=
 =?us-ascii?Q?wDtN9KMm2UpeMsBVy7MeJbdIs5u1o8B6jn7lmQVcNbM7fJr3i5UjMsbSzhsa?=
 =?us-ascii?Q?mPimYd442DypKvTyiWeLVfLD3k5OUR8yFoL2pWy/Xc/0oJBYUuJHceMdsKz/?=
 =?us-ascii?Q?YDRoKPCuspGoRnRyElbBVBsaB0IaOnVhSqc7BlZ0hbBDt9MRyjrJJsetIbBz?=
 =?us-ascii?Q?G5wvMGdsFybX23KLpiI7UEzymlhDAMzblUQYPbBYLYVcoaQ5Gp6oliBPU8lD?=
 =?us-ascii?Q?MGgKTPI12y4Mzyn7E6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4ab0a3-0a69-440d-48ed-08dde3e78f5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:56:24.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdNm8LPcAoMIw7gLelwJ/T04Qy2A45lLyWGTSutPNT+5zErqsU/5HGC2MHM5jMfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856

On Thu, Jul 03, 2025 at 06:23:14PM +0000, Michael Margolin wrote:
> Add command id to the printed message for additional debug information.
> 
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

I picked this up, I think we can debate what level of debug prints or
traces are appropriate next someone adds them, but tweaking an
existing one seems fine to me.

Jason

