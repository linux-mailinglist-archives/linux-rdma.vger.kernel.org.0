Return-Path: <linux-rdma+bounces-6511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC49F0CB3
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 13:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF527188773C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 12:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29041CEAAC;
	Fri, 13 Dec 2024 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pseAWs5i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0001A1A0AF7;
	Fri, 13 Dec 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094149; cv=fail; b=RcxLswDxqoMMvdXtdAmO5rleOXRXsUje7yfP12v+XsiQKtxqNAO2JuUtVGDcn92pBCnFnSzIZrmGqzO2ohdBYCn1BGGkeE1hvYrhGcC39v4UbZVH05Xm7mfsmI6VBv5TIaMaUss+AIzW6W8Dh3rRVMIZyVlccJdySVopbrXnJh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094149; c=relaxed/simple;
	bh=8BdCSw4mOv+2a695Tbn1rmXzHusA+795Gp16J1+lPtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTBmKG3RS1VRlrNtH8bQvgU7Rr6gr6sJ0h0mUnxolKJZiEVrX91YSlkfnHMOmGvtrK2U77nWr4WCAQnV1q/4s06H262yhvS1wD1dUwKENIJnIsq7VELSUNI8XDPYWJQpQhtPq08+yQ2VZaHOcMM3CFr0SuzjzfKMCUJJTnQJjFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pseAWs5i; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRjbs6qyrklyHZyGvWKMO4tZ7oMWMKV0sbdNdiJQOHiqPFwFK/wsnQsM6nZt0+lt+umfJZSuNAM5PO8Ugl97Mw7tXGjijEkR2a1PSd//k9ih59ys48xR4WPlqlaf6Ca0QkNcuxkU/cRKRMH4UL9he+gBNYPNYhi6ttbM3fGoZjSqDeUbbfEw9LDOVsOOEr9bb54o/V3QbAawIIl81NcbdwaiNmuSRTzaqw/s64YEV1iamfDLk0zSfKCCRnZj0SGJv35EDQ/r7b2xmACwN77HoMVa3nyzw8a4EC+lV59PN7/UJJO/uRKK6L8cAbQW22LqohHyzBHsLfQR3hVj9a1t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdLNwDx2nRteJi4okV2DstDV0Xm2hy8jI9HQABMRdnk=;
 b=EXMHBJzAJaa8npdwanikBoFlpeHBMLLVbiWYXfEYmOCWbrIkBjWRC9TYDUOTAw0eE0jfEpUO5Poj6FSPluvO9sBWGIxafa1sa2lYt0DXSo6ke90JNRduFbIlIRjn/Khu4ydCUm45vlJoWe6H4CUFUnsN6uYJLyPnra/IblF2ZOjYoEilmpbPN9gLuSYUx7UtoeoajQf+TxO0pW4FJdhVJflpG6Io/tKNYzIL4ICJ7GWCMXS60A09R7b8ISQnIoM+YAo3DXSHVw2k9HUr1R7rgQMtGqY6Nn8+hsb5O0CEwB0TcpXOtv3orUgP9i0/a/sNAooM+qy3Z23EYWwn7R0vxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdLNwDx2nRteJi4okV2DstDV0Xm2hy8jI9HQABMRdnk=;
 b=pseAWs5iZEcEsFLtJB6BtXj9qNkraJJz+fzN9keShArQZaiZDx9lxid/eAAIekPVMCz11p29CGOoBsCMrIOaCcED1yu45QixjK+jk+7H3az17fxMycm68tmPaw4HXcEaMQH7delVWifAOGJFCUrt/L24iS15WiruU88btIhsknw8mW1pbmHXe56kEAjre4mCUqRWAznefujH83MU7ZGWDTVzVkYl2Prm9INooef39JeIL6hMhlz1NDTjiS2Zmx2A/3YP7bUDTIrcfRhBht4lVml5F9l2sZrjgxyyZHz9aa49S3OzKMyhAUDtUEP2KhzrsaA+oXQawL94jkBdtUHjCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 12:49:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 12:49:04 +0000
Date: Fri, 13 Dec 2024 08:49:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Support mmapping reset state to
 userspace
Message-ID: <Z1wtPniGY+OVQhqz@nvidia.com>
References: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
 <20241209190125.GA2367762@nvidia.com>
 <f046d3f8-a1c8-0174-8db9-24467c038557@hisilicon.com>
 <20241210134827.GG2347147@nvidia.com>
 <92d90a3b-40e5-b47a-e570-ca63e4e58126@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d90a3b-40e5-b47a-e570-ca63e4e58126@hisilicon.com>
X-ClientProxiedBy: YQXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: b069d4af-9bf8-4693-6177-08dd1b748686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxUkzHSGbin/8yyN79F0phj6T6/ylK4TU5HLJS3K8vfJAH1cftAYCcE73w+C?=
 =?us-ascii?Q?zAWzxe0p/z+8yVn4IJmXjMdUTE947pm43SBBC1zjJyOH5gJWo80pf6RYGFNm?=
 =?us-ascii?Q?Gw2LmcvJiiXD7qiUKQZqwGcTxKGzHDZbsI4h06Queh2BOWA88n64vhopu1pm?=
 =?us-ascii?Q?1O0B+gwsA0n5XDMzVj+2R1l5orTHvDwRqH5tKhOudp16U4+mXdEETC9FXhXM?=
 =?us-ascii?Q?au0ImeA7Gcc+nRY1h6SzhqeuB6qQaafCCMFfArW4HgAg1t96E/Jz1mtrqzku?=
 =?us-ascii?Q?358tR3gAvXhiSId+s5RhB52xZlgVXZokG95BYhI+eC2/eetvYHwf4d1yG3c6?=
 =?us-ascii?Q?navODCSJFvKbw/MVVOcazEjYFhzoRLobgfJXw04zXV5GqYCOLz+da+DqEuZu?=
 =?us-ascii?Q?nq88dmdMJE1W5gEfVwjL/DfTdiyfMX03P+6IbojizIqaaAXq4ZiTNpnDJYoY?=
 =?us-ascii?Q?uTEfU63t2e310CtwnM71FReyi0HLQaWEBq9OZKtoQdkemROxWkwCz4Nfu6ij?=
 =?us-ascii?Q?HzDYs4zsjBDAlCrqBq+zv9Eb0HYuo+iL4B3+s2+EZNL6rjU2aZkv94sa1BtW?=
 =?us-ascii?Q?ta7Un37XjUq9Uxha3I202rJNUs+pZ8GXgzyn0igJmiQ6NCHOOsvnGsHl8e7A?=
 =?us-ascii?Q?hZJgHlCnU6YtiyhsMvVHq+3yupJ7RfuEAo3ciYXUgKUfU2MGCkBrYLsURBtu?=
 =?us-ascii?Q?BFh5IhxYemfFm/6d4bsd0kvp5zkKBB8TxsAawqJyudyHyljF/Zdbkg86b7WK?=
 =?us-ascii?Q?633Gu7x/PJ3KeHczAPHrjgiqU8jl4bI1ZojPNMrXFHgplT1k6a3TPPmES2n7?=
 =?us-ascii?Q?CJFwYFIsSZ8RdJ55mF67KyDfL0trR4pUfAP01O9CQLGcTlDVjBv4KiWQXfHQ?=
 =?us-ascii?Q?aYUI0xsUpN86mC2ifSOTWaGZFNI5zN6tCii+zzYdURn5Qh01yvGwIZo9a8Iw?=
 =?us-ascii?Q?DECCm69yqmK9oIHnBSv+4UhlfJrabO8NQIGRKCygKStGpWQmEMuXnRxkqYW0?=
 =?us-ascii?Q?eaHu+PeLaX/Wz5mqzZUhTU2OM53BA+u3B4d/GUQPSIdzksngRFCzTUwgoXJu?=
 =?us-ascii?Q?5/aHwFXpvk05IyCgDv8haTNQFkiwE9aHLvuR7KRsYRm9rHVrw8BOq0rMyByA?=
 =?us-ascii?Q?n2aThiM480ZiOExYLf0gMsZnCQmUC3rSlTCS2edZ1TlEVAHBgSYduIntzVt3?=
 =?us-ascii?Q?1oDlSteCW23NmcSqdntRa0J4EJq/KDmhK7sFlpmqaRGoy4DCC3UVksvvsnKw?=
 =?us-ascii?Q?N6S1cUxcodzfnapu6AjRTS5E/FgzNOS8xgsjKy6x86sFENx2wACwUzjDVbQM?=
 =?us-ascii?Q?wY9YSGO1orQSthqrDCDEcHVte6hyQ5y7hl5ZIkzftPqXyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8jKzN+PrvF4pBHq6Klunkl80IgXFYHwu2259JUarkjfiViipQn39nrVkjBcZ?=
 =?us-ascii?Q?ZR3MNg0iyJaJI/mTh0ZUc4dNo8RICt6DqnRD595fOuqr7I0m2PH8wPDfI4ET?=
 =?us-ascii?Q?xHvZA0JwDTWrcO27DgBug0iibKDyu3K/U1UX7CVBA/Ftqo28WAsJXI0jvNnW?=
 =?us-ascii?Q?7B5YnHEu8U40v/YwG3zUDXHlOcah7EfM2guSe44C2m+s9vx5wDXBzsMXo70w?=
 =?us-ascii?Q?MmBTW1X68RMStHXFhjLO1K/YEypqdlg4Hz8kT0Jj9OBV94h90aKl3iWSBjF2?=
 =?us-ascii?Q?qRKe2CM7hForVa/ZRFCTTuvP/XaAu3g+aq2fd0FNdtAvDxiQB536lIqLaXsf?=
 =?us-ascii?Q?lCjWBypqDo/mQgjvoS+hc+RyopxBdC4v6oaVPK7/hrFbbux8nwJeHjLWaPGF?=
 =?us-ascii?Q?kctNYy147FiC9q5P1J1RNzpa2n2VyYMJQKU+TFYiA8nPuEeaHCwnV1cNrF5e?=
 =?us-ascii?Q?7zOqRsedo17cC+C4/i27rxCZ8Ts1Y+1Q3KIsTgEUlY+JxpCzeSMSEHeEfBym?=
 =?us-ascii?Q?CvzORh6WO7pyicVO+0+RUhtSFKZ+5wy4NfpwqwPQ+dMTIGI9/JPDqmmz/dKn?=
 =?us-ascii?Q?ohBpzP3KCisbPPl7UfJ/OgkKH2QaI76M5ixKPDGV8CBEda5jOcES451kVp9H?=
 =?us-ascii?Q?iqBBH/LrV9nHHE8FiAfjKCwwPJvyEKv+dA5df/wPpZ2NeyckY/8KaljZGMqh?=
 =?us-ascii?Q?pdGyAZ8IbwOdm/JGU7ZmNgzXd6sNw/6QprP4XyWNBi+wBw6+GaiF0wGuJMfv?=
 =?us-ascii?Q?BmDZqgrgDio8o8l794yCYD9n/zcfuqKUzhNOd2lbgjbUtFi09AARC2C7ce9H?=
 =?us-ascii?Q?4ZUJ+vQ+yfKwSYIhaOU2tQq/hERjAeXyRobG0ISFNI7m9anQ0vHs97jfliPQ?=
 =?us-ascii?Q?+Z0JmnBKs6CBSuSge9JtvBq3w8sgT+je73TJvm03NiZ6xx2I4hIJcza+kFps?=
 =?us-ascii?Q?GF1HT+Hv5HN73WiFEeThjPvo6be+ogW5A5Zb5cVdxeXKWa28YokOOcF0llbX?=
 =?us-ascii?Q?R89BSEcRoRYHuGdilGg8bxy+2ZIMZw/ZGe5kQ8q1jB8b/W1WajRrvvto4RoR?=
 =?us-ascii?Q?WL46c+9Z2OwqQd5FfOFGca0e3H4VaFmmD0j74bX//4goWCWak4xxv8d5jgdM?=
 =?us-ascii?Q?anPECM4OxcpIHTboi4D1Gc8aNOlMcZZX4pS+6iYWSFg2L7WCoJDNTUKpGlOt?=
 =?us-ascii?Q?Ax8EKjk3Gea3h9UmDsKNz4PrnIfdPBL+R685YjLsuXGjsfJFCEzmJ7V8PG59?=
 =?us-ascii?Q?y91BWCTKDiX/UU+RUPIbukFB4g/7o/M+94yR461yfmPfvkmzy2FqQEwTe5a0?=
 =?us-ascii?Q?HvUzZxTwTILhWOMrFgRoidhHhi1rITd/aAW8+Yn+MZq0P7Kg9uzY/ANfmcqz?=
 =?us-ascii?Q?I9yTQgRgyPYH+m5tL4i8Q6VlbyK71/Tddalb1Bn4PZKHct+oXxvL/Z725PIY?=
 =?us-ascii?Q?tRBCwsVA892onQXlhbePLOQkHwMMxauC8g3acx9uC/5xUe367olj7z/SOZ7x?=
 =?us-ascii?Q?ZhZzB6hGM7Jtx6loXnODPGp6gE2g4c7ODsiz07tRNHNl9jbVPFdIWbQIOW50?=
 =?us-ascii?Q?FX+4AeRwlrbWd8iEem6GZ4U5JV17GbBAMKkeR0Ra?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b069d4af-9bf8-4693-6177-08dd1b748686
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 12:49:04.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiQLg1+hmDBGYkLz637HiFeqggbZccjvQdEt2nXWLSltcQaUHQUzuNIW4k6/+0wS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028

On Fri, Dec 13, 2024 at 05:37:58PM +0800, Junxian Huang wrote:
> > But your reset flow partially disassociates the device, when the
> > userspace goes back to sleep, or rearms the CQ, it should get a hard
> > fail and do a full cleanup without relying on flushing. 
> 
> Not sure if I got your point, when you said "the userspace goes back to sleep",
> did you mean the ibv_get_async_event() api? Are you suggesting that userspace
> should call ibv_get_async_event() to monitor async events, and when it gets a
> fatal event, it should stop polling CQs and clean up everything instead of
> still waiting for the remaining CQEs?

Yes, it should do that as well. This is wha the devce fatal event is
for.

I'm also saying that any kernel systems calls, like sleeping for CQ
events should start failing too.

Jason

