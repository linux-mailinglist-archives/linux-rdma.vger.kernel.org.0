Return-Path: <linux-rdma+bounces-3159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC59095B5
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 04:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1C8282CC0
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 02:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991B79F6;
	Sat, 15 Jun 2024 02:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lw48oDgi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D148646;
	Sat, 15 Jun 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419572; cv=fail; b=gLU7f4z7WZlmdRDP0TGqh02rkU+3iQgyTofCr2WoXVrv/B6ahKiEfQxtfuC5lB4qsmj4lUWT3825kwl5VRq8/Lt+IQMzVi6p7Qzt++/l7ymphGfBKKSsetB8W8HdnPgsBoHqk0lsddbZT0PchWndbDiVZ3qgrmXLyxxt8uMofZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419572; c=relaxed/simple;
	bh=ua1QoAYeeO8Xjw7CENThIxw/P/yBSiSw0BtvoHOXhD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iQlFo81+eZ9ZkKTKaTDSEPpl53xW1O7sqEJM4Mj2wSQSeBuvwLy59jLYhfXRltn1HcsZZ0LnJ1NExSLgyGV76hLQWgknnYmb9mEZZOJeXJ8jX5eXwMiAjNs8beuTDvHW0a0kmGnUGtXOqi1aqyTvqvMJWSDPiiII5lF2wmCllYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lw48oDgi; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4iGC06V0e+l0TYzP0dvWNfLs1Xyd3baSxWT2ogljnq/rRTz/qQ3PEcXSOdcbc4JhdzcSFyM4Jh+L1zI24+mcdEYWmy8+/b6aET6ebjHvuLkbPe/MrrbXZdUSCKqygXQ7lfS58ScAczblsH6T+p4Ik2l6YyCGKA+5u6IYvGoZn6QxIvnfgFUY7QbbBWJMdplPJkJlet+tzC+yQJbXch3iehmzL10TU9rjiLnVYARrM8bpWerHfIZkyS4ozoFrHCobgTzXwduOoClnYmbu2Ucj6Cx3FQMNj9og812V5bfrUPsZxU22t55Ahu54vO32kAtluV6YTFeEvdoTXl5zAkGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbbPycdqJLYR8eLlV0/S72oEHUfmBuJDgCP6xr72diQ=;
 b=OzcR8Wq+oqHUYgu2rw+RzAWxJEbgLhH8DCfq1hegalLuh5h5uXyOHJZg+NVig80TuWy4P3vcooTIioizo0oQypnDJK2xewJCq7g8HiBXuQ8XqUC7TFzqrHGJvvG3QUtO/ADFDciyrUsf3wZrtjXQTIel1UDp3mxToVyEs/vutQ6FnNM/7pOY9U/EUcqhgQrCIG1Z93kKlwzYfqeKXh/nWZTB4Mg40lm4PjFAPmvDhaUW4ENzaCflhl+c5q57UiKwfBLon6VUuIJPoN8cyxALE4gase6zkmnyOs1l5DlH1mytK8r/Z7pI5axxq+4ZCIWfCFS1AlzjyVETCpMpG7K9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=eideticom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbbPycdqJLYR8eLlV0/S72oEHUfmBuJDgCP6xr72diQ=;
 b=Lw48oDgi9nG9ZMKCnYo71zBoP46r0aej1gtFMGgfoCwUtMn186/YzFIG6C2d7qzY7+vqfJdaqb+XRq6Kd1lrCw2t7mTKEEKwpRfciIkW76p1hZos3s+IcD6JQwm5qzsh5kUZnHhMTJacFPOewj6mmrWk1KcJ1l7xAVPSZGwazwFc++R+nHhhWHRw0A6FQ4tl3PQ8awuZOjUOv8Y2KhzIwYLRw25f/t34DBnkPLZfJXIhjaojnnnR5ro1aR55i04tR7EeHc1m+KiaDf4llxgIBW2bKbtpntBn/q3KnjPUSZykGJQ8sZSOCVviKkfc6ulxnH7WfG1O3ja4qST2Amldwg==
Received: from BLAPR03CA0060.namprd03.prod.outlook.com (2603:10b6:208:32d::35)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Sat, 15 Jun
 2024 02:46:07 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::73) by BLAPR03CA0060.outlook.office365.com
 (2603:10b6:208:32d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Sat, 15 Jun 2024 02:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 02:46:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:45:58 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:45:57 -0700
Message-ID: <ac470f75-c276-4f15-b386-e88194e17f13@nvidia.com>
Date: Fri, 14 Jun 2024 19:45:51 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
To: Martin Oliveira <martin.oliveira@eideticom.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Logan Gunthorpe
	<logang@deltatee.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, Shiraz
 Saleem <shiraz.saleem@intel.com>, Michael Guralnik <michaelgur@nvidia.com>,
	"Artemy Kovalyov" <artemyko@nvidia.com>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
 <20240611182732.360317-4-martin.oliveira@eideticom.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240611182732.360317-4-martin.oliveira@eideticom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ed1447-964d-414e-1dff-08dc8ce54e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dml1QXRETTgreElBSzRzei9zdFpLYk02NWJWVHNsZUhUZ0FZTjBsR0pkdzhh?=
 =?utf-8?B?SEdBMEs1TnlkZkMvQ0dzOU9hVElHeG1UY2xTcUhvK0hEODlaWmVScW1wOEwv?=
 =?utf-8?B?WThsZUphNys4UVBzTG9TTTNoSjBpVHB1c3BPaFdVRU9CMmtCWXJrSUdDK2ZY?=
 =?utf-8?B?SUluZW01dnpXYlc0ejkySnY2Z1FNd21KdCtOUjRpL2FZRThEU0I2a2QvVHdR?=
 =?utf-8?B?Y1JaRlhPZVJyaCtVVW1xTTRhRUFVam1zUEprdWtVclppVGpsTDM5V3dzL1oy?=
 =?utf-8?B?czBrUzJhcC9CUlZxZkxQNjZyV2QvakNkT3IwQUo4dW1qV1dIaWZIYXQ0RExn?=
 =?utf-8?B?Mkd4RUZoZHBtd2Y1Ty8vRmxEN0psUk1RNUpocWQwdEdnVGFOdGc1bVJ5Y2VL?=
 =?utf-8?B?NkRQQllyUGNNcE56TXN4NEl0UTB2T0l4Ritva28ycVZvQVBrbnBaaFBCR1BV?=
 =?utf-8?B?OVAvbEF1N0lHQmpXbjZudVJkeFdpWENjUnNTaWFMSTlhTHdUR1p3a0FXd09Y?=
 =?utf-8?B?VjJqTVRZdGZZcGlKSi9FM0hjY2pTT1craXJVUmluM1VRaC9vd1BEZ2JPZG96?=
 =?utf-8?B?andEV3pXUGUxVlpmSDUzek0xZFhEWEc3ZFU3UTF2cEtVMER1eHhiemRvbVpz?=
 =?utf-8?B?NmRmbTJFNmRlME0xSFRYeTBvdlZZcEp6czVtSEtYMXlGSzFLM2hoRUxSMk10?=
 =?utf-8?B?bXJzQW1FRkJhbFcxM09iZ2NrTDkvU2FvdnNjUXM1eGhBVmNEaVE2YVI2cmVY?=
 =?utf-8?B?RVlKMUIxWjNNRU9TN2tNam45dmFSOFlLaFFJbEdiTkZPRDRpMFZDQ3cxNGhx?=
 =?utf-8?B?ZHNVTmVTME1IMGJES2k0eGtKZ2hMZHY4d0Z0NDltcmNqRGhxdzJHaDI2a2NM?=
 =?utf-8?B?WUtCSk56VVlLL3owVG5ES0wvTGtlL1RrcVc0eFlncjlVdUp0Tlh5bi9kN3pN?=
 =?utf-8?B?a1RKcXJyZEwyYXFWR08vY0JmekZSYVhlS05XdzZ1emZ6WDVaYTJSRHRyUWpq?=
 =?utf-8?B?RFZzU2ZRSkxPRVdyczBMWWJacG16ZmRCeUREK2RQNERsRmJkdVV6QmlhZHpv?=
 =?utf-8?B?OVdzSkw2UThxampZMExJTkJkQ0ZqTjd6dS9MdUVwa3lJL3pQUG5ualk3d3NQ?=
 =?utf-8?B?c2dXa3U5akpFVzAwMG1TS0xRVTd6cHlFOTNxbXZXaHBxUDdHQXFuNGEyMnUw?=
 =?utf-8?B?QVppOFd2dmhoN3ZISFQzL3dkQzNaVGkwU0VoVVBoelVFRFNzTzhoKy9tOGZB?=
 =?utf-8?B?RWx3eVBPb2xzeGpnRVViSVNweXFONFRTa0JPV2liWHkvN25NOFIrRnBOQzhz?=
 =?utf-8?B?SitJMDZqQldUYjJGVEFzdUhoUkNuSDBsVlRRRHNQNFpUTTdvdlJuSlFhcTha?=
 =?utf-8?B?d3Y2ZFgxcDdYNTRpbG0zd0x2QmMzWFRaeEtHTW52M1YrbUdTM05uVUxwMlJT?=
 =?utf-8?B?Y3UxZHRBT3l3cjlKaU5HTU9IbnlNamxzdGtwZEVNYkgxTjRPSklPdjlFVWkv?=
 =?utf-8?B?VFFoaXBOZXZvK08vTGN5cS9MdjlheU8xVTloNnpWbmdZUzNLRjhNZ3R6M0JR?=
 =?utf-8?B?V2h4TzNyNncyalpBNC8wUUNpaVg5dlJIL0M3bzBSOExMb2RzKzg3NnU4NUJz?=
 =?utf-8?B?aEpIZWsxTElqSnREak8yaW1GMUpCNWhqZ0I5NVJBNmxKWTZFSkpCMFc5MHBV?=
 =?utf-8?B?S29uZ2M4Rno5bUM3VW85ajlKMzk2MkxPTHhlZTAvVjBHSGo3NExpTUc0RUti?=
 =?utf-8?B?bm8rZ0JqWXJLbmpHRWxONTdQTklJWDIwSWtUTlFmMTZYNEhQdWVYR0xOYzdj?=
 =?utf-8?B?RG1zek9RL0NPK09NRUFpMU92Q012Q28vUmcvSThXUGVJUmlwRGZrdWk0bTV0?=
 =?utf-8?B?c0IycWxLOU1ESE52OWpQUjkxL3RCOGgwakhYTm1YZFgvZFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 02:46:07.1122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ed1447-964d-414e-1dff-08dc8ce54e8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032

On 6/11/24 11:27 AM, Martin Oliveira wrote:
> This check existed originally due to concerns that P2PDMA needed to copy
> fsdax until pgmap refcounts were fixed (see [1]).
> 
> The P2PDMA infrastructure will only call unmap_mapping_range() when the
> underlying device is unbound, and immediately after unmapping it waits
> for the reference of all ZONE_DEVICE pages to be released before
> continuing. This does not allow for a page to be reused and no user
> access fault is therefore possible. It does not have the same problem as
> fsdax.

This sounds great. I'm adding Dan Williams to Cc, in hopes of getting an
ack from him on this point.

> 
> The one minor concern with FOLL_LONGTERM pins is they will block device
> unbind until userspace releases them all.

That seems like a completely reasonable consequence of what you are
doing here, IMHO.

> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> 
> [1]: https://lkml.kernel.org/r/Yy4Ot5MoOhsgYLTQ@ziepe.ca
> ---
>   mm/gup.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 00d0a77112f4f..28060e41788d0 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2614,11 +2614,6 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>   	if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
>   		return false;
>   
> -	/* We want to allow the pgmap to be hot-unplugged at all times */
> -	if (WARN_ON_ONCE((gup_flags & FOLL_LONGTERM) &&
> -			 (gup_flags & FOLL_PCI_P2PDMA)))
> -		return false;
> -

I am not immediately seeing anything wrong with this... :)


>   	*gup_flags_p = gup_flags;
>   	return true;
>   }

thanks,
-- 
John Hubbard
NVIDIA


