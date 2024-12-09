Return-Path: <linux-rdma+bounces-6343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C513E9E9F52
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B3282EC3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9020F198851;
	Mon,  9 Dec 2024 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QR330rvP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F3140E5F;
	Mon,  9 Dec 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771996; cv=fail; b=m/0GhlyJf/6+2mfyYt7+E2hcEyyN/lp/RBYnlJoEy+HfUfo4zypjoo/XovKTv7Jb1UPreDlDdat9bt7J2Jh1FlJ9+Wyd9ZY85Cqreq/wIvQA6h+ttOU7f8KyN7l19zk2bP1oOUXQ993G8SyHfv6LUJvfRLB+ASUS3gJjt8fXYc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771996; c=relaxed/simple;
	bh=OysSzPC5gBa9cechcpsmM0FOoOMJiOYxp3qgyCfT7CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NUmsjCjIvwscOGTKOrutAmm+WvR189JmfYzoQuGT7V8gpeCi7vL7v6GOM37GsjqQekovZPcND1W+oRMnIvHl/fKKC8moTT2k8qL6RuoAT6nbHxwliupBRvUh+oYozLRUPdhT1owVDyo5gwgTJFf1SKnWy7FvZvUnRIn7zUk5Sbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QR330rvP; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBy6shiCatEG8E8nYnlBVb9qcRNkI7gkTB0Q6iQ+sVxCqv5pg+5CsjSRDEHttQEdmj56yJRSXG/ZEn35HLvqFObUKr91Q8HlpVJ2L3vxgEnL3NdzcJgAW3DZQWjZNEm/W0Zqnb8jQsdOKJZECl4qJ5yVExEOE/KfLFMFvl3JUHpsCCzJQgkLb+3SSok6Ew+PaJDmuW6+PJ4hxys+mbVWKpLJNb3tKsPjHVmrSTGVsUyFlySo1HGyaMKJe4TSzWTzrtjivjR8VsLvvDgC8hfI4x7A9SsB3pDANsXrErpyqaVPzV613WVCFzGAdVACVpYuocK5l7gf2Xv6jshtrPZGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd+V5qn/LJGanQPQUKhwueCbfBJcmAPdl3UZkooBgvg=;
 b=tIUJsw9KxFaEsBtMhv7iaG/t2bXhb0bTrVrMSCox+lKvGIagATqwxfv5Y0t0f9ebfyLoGBKqWGoSWWg4vcWiSVXFLmilOek0KTMu21JZ13FEG36BKCkmfx0cmE89jh3nwZpBMKlKCTYNdkYdyRZUtLR1BZwc8oNZ+FxfDMztWtzmH0nzAZ3CZOFtdlcX5dCeq7aF5YjCMO8BbayMUarVxgGNjGzjhcoqBowCno03IRaKJfpR6TDnIV4rn3sAiFQy9XETITyQMems1tvMwxkVUfSsX2gvTVmNbAa67Luirf2119l5+NYCtQoCE4WsQ2kGEBcym9s08oIYBaaBrXbPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd+V5qn/LJGanQPQUKhwueCbfBJcmAPdl3UZkooBgvg=;
 b=QR330rvPj6bufAcBsYODeJX5kOyDTb4u3/YyoBQVpr2wzRYRjqe46vn15v/8Z2FDxiAieb2260NBZSr9lbPad3EYYQtnjjote00Y+uDkXbfameRKG8AGWU60mvtOmpQZTallRJZJqPoT87zEzeHoNZXDPavdBRU5XAe62PtI41NRVmSGgw6p7JXMV8ZFl7LFoK0Yi6eNqFqrqExK30vpd5nYZZgvXhF/2QDs3pCPy19Ogb1dMTtv0lPVj/IVB6L2TaRBa5/7ipgVyDV70+IhqcLkRxxIUu4jrfIGXnta8baCjUtreg/iJ6IkowFqrbemVSJWgKpdkzC4teh9R/TAhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 19:19:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:19:50 +0000
Date: Mon, 9 Dec 2024 15:19:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 1/6] RDMA/rxe: Make MR functions accessible
 from other rxe source code
Message-ID: <20241209191949.GA2368570@nvidia.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-2-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BN9PR03CA0709.namprd03.prod.outlook.com
 (2603:10b6:408:ef::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e6fe4e-c6cc-43f7-0023-08dd18867390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+gOTKP4r1G6bz5B6268hFIFm+Kq62DKez/TSjvbwmQ+opajCSojT3Koqyr+m?=
 =?us-ascii?Q?VO0mFKw3LyOZnbmPr1NRTPBiPd6drC0rd+N1C6geNrRaf3tFp2Ck+NZDFGMx?=
 =?us-ascii?Q?coJHhj4TrRsVYd/DxndBbioOzwHHVhEdrP5Pd4wcc/QJzrFPQFCQCvQ7S1jl?=
 =?us-ascii?Q?XeACBe4vhgKJSX5pVyF/M1iMOvnZIYTJfH1oXwQ6ASHSLefitPooZ+c/YVDh?=
 =?us-ascii?Q?BSH9znUiWQzjNx/hqO+Z2He7ItZ1K+GloTnhTIj/CBuoMQbZuWTOyCXbanBf?=
 =?us-ascii?Q?cHdK1s37O6Jv2GRvk3aj1gpB3TiBYwqAsGzwTLQcgISDtEFR/OPycZp7RTLh?=
 =?us-ascii?Q?1Fr9zt5C9AMA7IBsHYz6y79XhnsRsQ9LCvnsyF8pkJ+TW3+Pk0vtklOyfzw7?=
 =?us-ascii?Q?vXmFSKpRlwdn/TZCwEncAuxC7hjPMizC00Yz5xReczxQZ24wW/yBXzE4A3zW?=
 =?us-ascii?Q?9+TlfPixdHDEnkon2+u3HI8zv5V9WiY/xDyV7+0hdSkge7+Ao0ProWOR81zT?=
 =?us-ascii?Q?gcg7VSD3v9APv+BZU/H2jsNZh5BQ5xJ/5YsfD5k9c6AVNQDX+qHx9sU/3nhV?=
 =?us-ascii?Q?0Aw203O6CGIHKQXYqx7CRhFohQvxNeidSDUusBajMZw4LAwXlcPPiZpX5rG9?=
 =?us-ascii?Q?W9Yos20cUkOcsbaSyDN0kKJl8eRh6tZeet82fpmTiZO6N9TfU9fXxGmMMwVm?=
 =?us-ascii?Q?P9oE2V//4hP2fI8J4muXE/fwxrQVoAjcKPwEeXpgb0frDNapD7ZYIskeWf1Y?=
 =?us-ascii?Q?vweIQL8BBBHPO4OQRePq9u6w/rJ7FS7LTMCExaZzEmSTYA8iwy9mTq4UPkOk?=
 =?us-ascii?Q?+piyq9RsfA7qaB82rXcA5qqx/PyLem9a0QQDgn2H6pkR9b1NfT7wZevQTjVk?=
 =?us-ascii?Q?hFCTRZ/8Sq6safYcApR2wNZhUYduaFfiMufQ0PGtG6Dt44d8Mvypn5c6rCwH?=
 =?us-ascii?Q?4OavtqnRFMDiJatvMesZU9OKEo5dC7USP9geGRVk0cRJivc7MITgkTUFbApa?=
 =?us-ascii?Q?MMiQ+UsfizqbH0hSRjRlA9IzpP9elzhpI7duEX26BZmxqCX3DFAwxO52d7I6?=
 =?us-ascii?Q?CbmIGvxuDxthSFyR5zLJz9ctlk9BnzSCyg+xyJzi5G8O82ATz3Oqp3KC62ye?=
 =?us-ascii?Q?CYMOYlU9ZbksOazDZDwxLZsGPG2C5B76Q7r6ZEcByzsTK6FEJcJK9z1SeUst?=
 =?us-ascii?Q?bdp3OTFNNYUrb0HjPl8YSQ9rgAeED9Ps+c73UBnaEhS+sMnWIuKn5pzFbcSu?=
 =?us-ascii?Q?3oekJSVfmGfyX9Wuj6i6f80LVP1e5tIVW6Tiv/UHuwGcwlkL928us2sVQygb?=
 =?us-ascii?Q?Vj+tfeWDOD1C9aKyKyChhJf/Z2OluZ8zz2FbBXWA9i1S5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0T0GDlPMtIzpcfXAy124ntM1/COM4d6CK+nF2fNcLDObr03RiE5P0l284yjR?=
 =?us-ascii?Q?5t/dS8ocrrEj05MNqvdg25k+NE/wN2n4iSvmKeIhti1BWrJL94yNarS1VS8a?=
 =?us-ascii?Q?51amz7Qj9+tRX6vVG9gdHjb73bhjqOTwcROrxzkUDiv8zKPTiUNEsHyy5Q62?=
 =?us-ascii?Q?p0uvL2UxXu/qV+2Ff+yOg2NMFB1IspBF6jOEqq7c/OzmYxtxAW3wWCxrSror?=
 =?us-ascii?Q?Plf00HEd45k+kNEA4pqWHjBzdzJdG6aw5QlomVZsC/q8alyU/CyuL/FIaMHW?=
 =?us-ascii?Q?3Q/l1v6nT7mNAhuLr/In7av5hICvs8B0fBMW7MOrAdIRTwKoVNmKf3cLK51o?=
 =?us-ascii?Q?j0D1k8XYEnUK1UZlaSqSendp5RgAwrEVuTts9VpGh3yKhzStVbbaXEttp0Rq?=
 =?us-ascii?Q?nqGr9C6YEn40L5cpMZfHfPtCmEJtxAo3Dtk6sMpjq1mexzBsKSAsLjT9/uYo?=
 =?us-ascii?Q?RunuhT2PQxySOvRy4axqK+PdhfDEsjXso+YCgu9FhlaXBodk8Wxd1Xp3yrrj?=
 =?us-ascii?Q?+N3t3lXduNWcu5a2a97JrXCEDlzYQNv80gQlKYfeOHqffnlV6vvAPCF3xLNh?=
 =?us-ascii?Q?TMP+ke67tbZGoO1uXRJzLYVVtjot3QbfcxATn/KJMghjh9uoDuOt5Tqlt0HY?=
 =?us-ascii?Q?mcyPw9WrpW0ZQzRGhCUC6bpIga57zm/HwiQYZ8v+qF4jjBgBlmtNZKuKqX9H?=
 =?us-ascii?Q?eupesXF24k9eK6y1GhDrKQsE5Gcpi5KJClPriU2zrUbBDGVfpEXExmwznbkV?=
 =?us-ascii?Q?L++EmFn+Yca3jJl+oq2Qt4iRR/ri79bQ1pA3a7eWSoBYpAIf/JGjfiyMVtGm?=
 =?us-ascii?Q?MwMoMkim+1AZM7UwcdfXlZb7YdDUTD71bS7nm7S/EcQKayqVn6HJNbx5jhLa?=
 =?us-ascii?Q?2ORY1kPMBulOxvOuFHtCgB3zik84dJnRqEjXTdL6AV40TseHbgUxXi5qu2BB?=
 =?us-ascii?Q?MSvNCXyJT2cMyRTGJN3NV1DK9XvR2Hmn+yrgYM5akvF0gP5g0Rh1IpXIgihy?=
 =?us-ascii?Q?anJ6i9JlJ2SdlOUXf3Iu95PSraWs1uKhgwiqiSFIXTR/7EqMq0OZiSE+y0/D?=
 =?us-ascii?Q?fMdSKiZZxUkiq9N6Dn1BCkCHct/r5lB8Hz3OksMoLW70oKYTsBvZflU5hkjs?=
 =?us-ascii?Q?YDIMwTkIi8pZIXeRmvkSA/Qz+v7M5aLvJSvIAXGKqedOY9IB8xlKO1U2lkpp?=
 =?us-ascii?Q?JUi9ic3IHfDSouxcx18fnljMPxxB6/yi1v79QOi6X1n9DMtsEYXmVrWUl4U1?=
 =?us-ascii?Q?P9AbF1jkWK/jZWgYKpZ/Fiqp8sHeRGPS4A258dIbjvozq+H7bRMyP21c0NfY?=
 =?us-ascii?Q?aIV1h4hIl/jGW3fLv0XbW2i95JbBp9PO9xU6w3yGHIIvqED3D8sZqL/dF4wN?=
 =?us-ascii?Q?LjRTvWw7fZOVN9muHXM8/0mrf7YYIp1qR2DQxy0RfwZixFoiD6t5FZu7LUFI?=
 =?us-ascii?Q?dumKf5QenCaNggtuAmncoH+wr9L+NlRCPDWVOjwIPmKgeNHfjeChEv8gtsZL?=
 =?us-ascii?Q?pBuSnyUhJ5Uo/S7X7x1+iKx15/YFl5t9i3Xb9ljue+61WNunBWLe/3YUC0wa?=
 =?us-ascii?Q?0nqFQ/4V+ZkqhCBtcYDpPkYCSdKxA6ltl+iJPbXx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e6fe4e-c6cc-43f7-0023-08dd18867390
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:19:50.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUo8y2pT3Hoe9GzQl4qwOOdl7s+LOwY8xuf0YB60eSeMwinDRqKjHyKis8XzJ3ZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581

On Wed, Oct 09, 2024 at 10:58:58AM +0900, Daisuke Matsuda wrote:
> Some functions in rxe_mr.c are going to be used in rxe_odp.c, which is to
> be created in the subsequent patch. List the declarations of the functions
> in rxe_loc.h.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  8 ++++++++
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 11 +++--------
>  2 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

