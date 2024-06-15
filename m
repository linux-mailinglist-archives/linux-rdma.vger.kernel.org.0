Return-Path: <linux-rdma+bounces-3158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D4E9095B1
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 04:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91E7BB21E92
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2024 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03A8825;
	Sat, 15 Jun 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RN/E9Iwe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EC19D8A6;
	Sat, 15 Jun 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419219; cv=fail; b=S9JHvA9o4MTBDTFAapCFsYiushM+F0RG53+r0DQAtMhAt/XIG0sSZLxZANv51GfMnRng+6DwYIz5xLXrYX/vOPfPAFWFF+UAHNyvNaqgsh+jHnH7E1AoURZDprzXRgsDPDxsoCMu58DOC3gXMaykbJk1kUR+zoMTzw48cI0Zocw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419219; c=relaxed/simple;
	bh=ILm9uxetMRa03HSxmS+o9sXZO8ganQMVSdewScjcqm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T6zuFL+27r+w4Ivr7CCTC4T7FmX5/xdbS0xlep1iDqcu5ATX4jto+f2o99aY4bLGBnyI7yKu+WYYwnDHmfPsZV9BRWFBNDMq+OEawj/07heUMhhdtF57jno5HOy7AB44eY1c63xtVS1EH44qJgG3g83VYKLgSBsKaLLOTaEvRzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RN/E9Iwe; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlgAPK5BHHMcAleQQHET5Gxra0aiRrp7Olag2bG69HWNgXhVYAYxKD3waaAruswOSuMjYUSCb3kVBxstBKbvGc2XUG4Kr9CSA6tS4Uym/J9e/y1owzdkjZg8bMAt15nSkjDsCtU5uZPfBOzOnVGxZNAH9T3BwZpWb8tZSNcyR02x48VdgMyj1aRG6zwu7WmvgHnDJ37KtTx7LZt9vbWBuV84R1N/gnFkcoc6qyq7pHn5H15mKsQuuNfJ9q9YbnZoyylS+WIJ0ogVmRCPGSW8qJvI5QgXUuesvOK9mERnx8nO4xAnvnxnIufeJGBvl7/d1bkWf7ZKOqAU3eMCkDxF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNUSuJTvmgCtsc6GW6Buhovxw3IhOe9neSGmrRoKYfk=;
 b=mq0Y7nAWv34/MoC3jWsYZjgC4Vh94vdeMuIcgt5GOP/JypxfQxMTMsG3KxN0glfNJsh49er2Um+2qVtjGCMnNbMFB7GISupqOvY/ZyZeEHIfPvSAOhoeixY2TYm3BzGWmbKF5dzh2TRe3O20XD8rXFvIx/TIpvn6IyZmEIWAu82f2yuvCnfum0QsbHNHVZ7e/xWH5UtO9+EI2THrHTV+JD/z+pxXbJqjLPzlmi+UvBVW6Kq91hlZNCr4CuaUhXXDyxRVQ8pp1E9X3exJe4cE27rwFH7FFKehaFmkAGr7ZOkqvB9rNOhOtePHT9aIGVnYi1As8qAaEb3ysIRaLgN44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=eideticom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNUSuJTvmgCtsc6GW6Buhovxw3IhOe9neSGmrRoKYfk=;
 b=RN/E9IweVL2pXsyJINDFpiunV/JSe55XmTMw7KlmU5vPI8RxqziSxt7djOPCzwaThDPLTq0FTgfqs2j8+Sud/nxQOE1s5KvP5s7SjcRZNyT+K7ST5KosudR8fy+RpiPBJuFG3gxC6p1+gld+KpG5qhUEpe+EQrocwZ6ktnNw+NkxTUNMnlIi+bUpOekt/36v/LAg39c4j7JiSvy8ErDOtO/IeP1YCjbVP8Nw3WBC16fDJ2oaZT24vtf8iHXrPuD0hBabeV3w+AhGvoKN7pVjQrF4OyGGD4MvBUJslRefZ13zf7jiqtoYEHdJwTzfXH1kA7RqbxKIIyoKqwPD5KL0ag==
Received: from SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Sat, 15 Jun
 2024 02:40:14 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::fd) by SN7PR04CA0114.outlook.office365.com
 (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Sat, 15 Jun 2024 02:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 02:40:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:40:07 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:40:06 -0700
Message-ID: <cc68a062-d44b-4608-a11a-6c87423d0b87@nvidia.com>
Date: Fri, 14 Jun 2024 19:40:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/gup: handle ZONE_DEVICE pages in
 folio_fast_pin_allowed()
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
 <20240611182732.360317-3-martin.oliveira@eideticom.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240611182732.360317-3-martin.oliveira@eideticom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9ee51a-85c4-4678-4969-08dc8ce47c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elpXVVF4cmZyMm1Ud1RJWlBsR0ZaMG9VMFN4OW5ieXB1aGVnYlZZSGNWQjRq?=
 =?utf-8?B?MS9LTWNLZlo0ZmpsbFJRejY3anZmbTlOUTRJRzc5cVhZZmltZkczZ0xBem1h?=
 =?utf-8?B?RUhmMDVSclQ3YTdtUGtzYTBWOEtoV2N2dTlNZnBpVTR4aHJJYXQ0NmdFRXZ1?=
 =?utf-8?B?cldPT3JMdzFtUGUvS0poN0E1ZXNibStxQVNyd2lLb1RvVU1BMFFhMkpwOW5q?=
 =?utf-8?B?ZHFpR1FHSlN0c2VRRVo4WjJsWGphbXQ3Rmx1aFljcHlIMW5rUmVtV2kyS05M?=
 =?utf-8?B?UEhIMFRmQ0FmbDFuamNxMityTE9BaytRL2dtaVM1dVFWV2NwaGJ4NWpGVnRC?=
 =?utf-8?B?dGRibXloTTZVeG5mYzJOZjdZNU55YysyM1lqVGlTQ2xFOTVzL3ZUUXVOa1Ra?=
 =?utf-8?B?L0dtcFZabC9zdGQxVVNhT2dwTXFscm55LytnKys2emNVRlc4RUlCN2RjYXFX?=
 =?utf-8?B?YTNyUWNneXhzS2VwdVJQMVRKbnBGL3R0YnNrS0xjcjZVcWV0M2FpMTJkT2pr?=
 =?utf-8?B?YlVzeU4vV2htUzE4QVVmaERSUFJHeUF5NWNQNzd6N0Yvd0dWNkVmNmFmQldN?=
 =?utf-8?B?U3ZZOXI0YXh4UVlEd0NpZUZ1a2xTTExlcXVFMFJVSG5oWWZwMXdJMm50eFhY?=
 =?utf-8?B?YXRDT20zaVZwYVIrbEI4V2RhTThMK2JsVWVCek52SnlTUmFNcWhwdC93bWx1?=
 =?utf-8?B?bzhPdmI4N25FaU9aZDEwcXlBTS83N0syV1Bndi9nOXk3RlZEaDlKZjNCdlVt?=
 =?utf-8?B?SDNGVG8reDBPWUh6WVNkbWZwdExrZ2lGSkc2WXp5aWdMK3hWd1d3YkVaeE5U?=
 =?utf-8?B?dTNDc1IvWFRBT1FhWWFacFFWUjJCM2YvcnhSQXdCalp2ZmdZNWs0OWNmOHRo?=
 =?utf-8?B?dVU3Z1hucFB4UXlIT282YjVETWVtaDJCNCtMRjZHRS9uREF6TUx0MzRpRk9a?=
 =?utf-8?B?anZyWk9zcHB1S29vU1NxNUZBd1NjVDJpeERZeGFRL0NXZUwrckdRUGg5VlI2?=
 =?utf-8?B?QUExYWtmSjRGZWdZUFZTd0VXc3p3bU4vcjJETFhJYWxOWmlLelltYXhucGhu?=
 =?utf-8?B?TUc0MEtleGg4eURoNHllKy9RVzViT1FUVStLV2NtcEs2RDhxWGdSZWRaWExt?=
 =?utf-8?B?RWpDSC9xRGdmNzA2eGgyMGNJYlZ1NThQMW01ZkZUcVNkZTI1Z0gvS09sN0lL?=
 =?utf-8?B?VEc0bTYwQ1p0dFQ5T1V5MW5VUit4WTZ4NUdkZzlhU1p5WUljdzBQU0F3ZG5v?=
 =?utf-8?B?d1RMa1Era3g4OXNpQmk4cFVaalhOVEtKYlhYbGUzQkt4M3FBMjVLZmNDZ0Z2?=
 =?utf-8?B?Zm1GZ053dGtnSWhNNXpVR3drS1BCU3ZpSlRDQ01YOTI3ZWNpbllWWnJLdjVo?=
 =?utf-8?B?NEFDclRtZ2dLRW03NzNHZVFsSUt4WG4xT28vYjQ3QUxpNW5NZGpzUXBLRXB3?=
 =?utf-8?B?R1pkVXlWd2hpUDFhV1FOR25vVUVqamJHaHA4MGNoQnBTS0M5c0hZZU56d3BZ?=
 =?utf-8?B?UUVzSlVwUmlkQjdkSjhZMHVoY0plUjVLS3pPQXl0MW52Zm50WndhQTEwc0NE?=
 =?utf-8?B?d3dhaXlKbnpjeWdmMnprK1hvSjQxd01yY1piNGVYQXA4L05LS0JFQTVsUlFy?=
 =?utf-8?B?VGRBNXRXeVZ2SzVaelBDMWtTQ2N5Mk5uWk4yQ2FFUHFKYkJwV3pRSTNXcm9M?=
 =?utf-8?B?U21RY1ljNHRxc2plc21UNERYM3FqSzgvZURhZXMxdXhEc29NUWplaTRHeDRr?=
 =?utf-8?B?U3NzRXAvL0R0SHE5UkxEcEF2aEdoUXJlMTlnNGVQMzhacDg0SDlQKzEySGpt?=
 =?utf-8?B?ZEoxVVl5QXNhSFFPQUJ5R0syS3ZyRldFQ2tPOUNoSXhVTEc0WGdxZ0Jtc01i?=
 =?utf-8?B?bG5semdVS3JMWVJ1bDRVS1AyUk1jTnhOb0ZRcW5JYTVNZlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 02:40:14.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9ee51a-85c4-4678-4969-08dc8ce47c3f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

On 6/11/24 11:27 AM, Martin Oliveira wrote:
> folio_fast_pin_allowed() does not support ZONE_DEVICE pages because

s/folio_fast_pin_allowed/gup_fast_folio_allowed/ ?

> currently it is impossible for that type of page to be used with
> FOLL_LONGTERM. When this changes in a subsequent patch, this path will
> attempt to read the mapping of a ZONE_DEVICE page which is not valid.
> 
> Instead, allow ZONE_DEVICE pages explicitly seeing they shouldn't pose
> any problem with the fast path.
> 
> Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
> ---
>   mm/gup.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ca0f5cedce9b2..00d0a77112f4f 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2847,6 +2847,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>   	if (folio_test_hugetlb(folio))
>   		return true;
>   
> +	/* It makes no sense to access the mapping of ZONE_DEVICE pages */

This comment is very difficult, because it states that one cannot
do something, right before explicitly enable something else. And the
reader is given little help on connecting the two.

And there are several subtypes of ZONE_DEVICE. Is it really true that
none of them can be mapped to user space? For p2p BAR1 mappings, those
actually go to user space, yes? Confused, need help. :)

> +	if (folio_is_zone_device(folio))
> +		return true;
> +
>   	/*
>   	 * GUP-fast disables IRQs. When IRQS are disabled, RCU grace periods
>   	 * cannot proceed, which means no actions performed under RCU can

thanks,
-- 
John Hubbard
NVIDIA


