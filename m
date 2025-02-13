Return-Path: <linux-rdma+bounces-7737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C786A34C85
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F1C3A3E97
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAD23A9BD;
	Thu, 13 Feb 2025 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="in+Klweu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0223A9AE;
	Thu, 13 Feb 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469343; cv=fail; b=UbWJJ48zwMmhgvFy7qVHpfhuphIaXhFpr1PinXQl90fA1XZ/e4xkLfZ+jrZhsqbYwC/Vw3HA1rotfmAWDx1y+35fDvecRvUx+q+65bQy0FisDwGI2ZDt/h6snPA7crtsNr5dTtgp8G4ULbkLrgp9aK+XxFfln+gFr95UFa35MPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469343; c=relaxed/simple;
	bh=wY4saom0hYvufB7O1XjPOauktc2h2sXJe6KlCTA2ZpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rJt+TYRRFbEgc0Dvq53RH2W60CbjAZA8HrIqjDYi9tRd7cg4ZIdrR/MOb0VmjYWqkuoFAILh8D4bh1oCbKZKB/Xk2iGUll/lLJKW6FgGNVLnsyg2m+2M1EYPAslF9Cd4bSK6k504Uq83XKgylAVt98lM4AYX4fvw3hZ/PODgLrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=in+Klweu; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/0dDwM0WNafjVgzbQu6xAKPW6EWVVuGv8kYnj+aCTO/BOyF1OnYeOPCDbiXfLQzOHDUci6v3scc7UK9kVAlVcGo9weRuGH8nLgqBKhtjpQ1wByaZaV/7fMCtRZGA7GKGl7+xMzbKQ0vZIZP4wpGiNf7QIK4XTioccOQ7bh3LOgjXx3KTL61CgAnTdkiUs5k814PBx5lOCd0SjzHkMOtkZQzewEz6NW0BeJUYyiA3AY0ttoxTQ9y3LSnTOpcjiKjF1NJDuqQ7+H0FR/6RrhB57IUavGUQZgU2LS5AUOKiW1sadsLw0NHB/ytbaT1xLNUjJ3++AdfPO3UNzXo6inXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ynbKgbSX5W0yMNcDouB4u36xzXtkXthxBJmts36O+U=;
 b=svCOpTAayM+1ixZdUlZNhIvTGEINAMSHDZ2dWrEAU7myzW+bhjUU6RIJdpgqU0JP6lrZWXXcxw3ycAfSxUqslbTVyR2R0+vX/Q/p30qtZ0sxz4LTEadOe3ARL5WBivhS9IFOU4D1C50/JhcTQwGbAxCOI5fp7UsjxaryiEJ4ocloDkYxDzhA668bjKw78NUBqcF6UjkrVktXtA3T97fdGQLn4tb76b5FjyzdXhFrDe+L/VjGaw2R6hcFRN7INfkrAD1IBFUzRnMvtC70arCIax+LBiTXx+nADEabgGWbfnMJPUXnjZmI/pszTwg1Pn2ha3VkWZAy8acnjVEORFjjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ynbKgbSX5W0yMNcDouB4u36xzXtkXthxBJmts36O+U=;
 b=in+Klweu8CzutiGk1TupDC5FsgNXPaCjO2Cnl6aV7ntbZTEyWWdDPcT4WvCT5sLLEViXiURMKMo0FTGjZBPJtDTkqeAOVe+GVBUCfXN292y1hhuIj9r0zsVCV4oMlTAKOy023O3S6y/yOgwVffWVEc3xDY9LfRhakcTy2uzO+zbsDcRGF4uFLqNqWx9abx//o/IKUI+78bUUlX1j7xaTMl+iasyOYMJVjXhkUJc6xQlzHYW22Ead8LJLMBORZz0DwX1Ov4SIP6UAV3wFfGXwd2xCLN/9JhPj7EHQBiIritB387TXZ+LeqKJIe8e6i9Ab2QCt8W7PoAwq1GCDMtl9QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 17:55:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 17:55:39 +0000
Date: Thu, 13 Feb 2025 13:55:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
Message-ID: <20250213175538.GB3885104@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <a0f1648f-eefb-455c-b264-169cb67a7486@intel.com>
 <20250211093329.00000b95@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211093329.00000b95@huawei.com>
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 34301d81-a4fe-4844-2b48-08dd4c57a021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gxi7DV1MNIdlX0pWrG8Qse2IYYmlXV/Dp/yVk4l58yPULRgfSM42i6FmUjtK?=
 =?us-ascii?Q?5Mp1mD7xpSkviIn5UG9YoaQ5K0Y3V81V/1Q8yqPPXp72S6VbcuxOzN6EN2MV?=
 =?us-ascii?Q?oqkaIGqxAjaHwOJWd0bO7IoBbNwwgFyLn8f35DktkSej3tk8RU/fW3Jw6wch?=
 =?us-ascii?Q?2ESan9alQEJDE5aOgK2MKFRkQo6S18R9lA6+sErwvh3jzDGrlR0/1/juHciP?=
 =?us-ascii?Q?frkJKOBjyy2g9PFpJQbxRzvETUlXNU2QYaUaaIAnpoFSBaN4b9+2IyK3bH6q?=
 =?us-ascii?Q?MRUaOP+HNHM3MEQHTpzP/6GkbbD8Lon7m4tu1wb8Cf0liFimadi51MjTKkhD?=
 =?us-ascii?Q?QLC2AtHen7+/iQYZumeozvmiRDHCekUmMt3sjXQsgmQgNFr2G+M0B3IWLLif?=
 =?us-ascii?Q?mFVlGtltVkl5yqkc04ylK9IbsW/2+Ugo/CXVu5T+UfaFsb1cZ4ob5gAXnoRj?=
 =?us-ascii?Q?Z9+24VzkTYRx3Tygz/KbJ20GJI4m91ncJzFvk82g0bacEj2DuUL0Ct9FXlN9?=
 =?us-ascii?Q?QZ6wIQ51vfYKD7nVYsWuDKt+Gub0uw+Xyt6kk/p6FTdiGkZqjLlI/zqG8fZJ?=
 =?us-ascii?Q?LCHzLVTgeXl/I7DIWf8GdhfqtvcQVwiAsbluW6r1lNu8kezfPi0IwB5sgi0n?=
 =?us-ascii?Q?U5Fbtnjd9uc8uO3RMaL6dLRgeIOCQlHwmHnuFuWiEQiLf+XPLTxlMw0X1X7C?=
 =?us-ascii?Q?2HxyNU5obwYGbk4Cd9zvp3z0IDjvAPV5GsnX9Ej9GRKcG3rQh5rg2F4XAdNQ?=
 =?us-ascii?Q?bogqc5R+DoasOcdUDKDqFUrllP5178kFFhtXRJ2GTiCakpmKkqVKoZq5Hs7X?=
 =?us-ascii?Q?VIj7kBA8jruF4AKq9uxp3rfUcOLl1zDSL2NtzqJ1KlR1ZDyLAlWDUUvd05Ug?=
 =?us-ascii?Q?BEzfY7fJdurDNpHCjiYTRuxkg/xktZj7RCKN4WPrIzGGxOjeI8B4b7dHcrNd?=
 =?us-ascii?Q?P45FSMOmsFfPes60htCdi6izrzwAG1sT7/6oeWDqmc/LU6gECpyuEM0rdtqG?=
 =?us-ascii?Q?1BluyT2nWu1z9MzdKLchcK3AsFj8yKThOcqpdDXWMQTfDBYbD2qKDtWuXKq4?=
 =?us-ascii?Q?dyWmxdTirnUSBtG6e5FOvmvQOR8hhsPoSyd5f4JDkctdOuEVYxjYNm0QihXy?=
 =?us-ascii?Q?ZEni/JYIb7efbg5bWoJBuTNJLPTiRu4ZkZUuFDpwJCcr2xGZOlW7uOf0jKK7?=
 =?us-ascii?Q?KOAnaOxos8opupQe4I1XbOQk09f5yoeiuS745O/EcTs0Qkus5RtgE/7aECs+?=
 =?us-ascii?Q?ybGYLz3k4eXDU1alOssQhBEbIjcT6eYs/65nA7D/gjdfGGOgXEPLDjTBWX1P?=
 =?us-ascii?Q?NG1JmxexfAgUMuqsDY2VARPaGWtjP0vqluHaAo6FGWZo4yeYz49yqelRKHxs?=
 =?us-ascii?Q?4m54eWG/AEYSQvJb2nD4nlFMumTP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SAj+phymw1lX8y8/cfM3i5MLNdEzkzcG7SuL9dC8L+3GyQXTISWt0SpbbbuU?=
 =?us-ascii?Q?PJ+5f0Q9opIxavhb8TghACUaaW6HhCaW1IsYDYRtyCX+6jpKH60HIugcn5rl?=
 =?us-ascii?Q?/b/2MvzLQEZZycpFfg4VY61P9cDwJdvhRNkRJojMAbn7wpnoVZi3oyK258Mo?=
 =?us-ascii?Q?rAttLgPOGXnx8OWkawfpIsExoKWtoYNWJOwfHZJmGfUgwdra60BPX6acsPpB?=
 =?us-ascii?Q?LQWgwLRiWBmHgpatEZ5SM/vHAb8JXYX9WhduFu/Nq6l2WevayS4csNHTcrPg?=
 =?us-ascii?Q?/aiN9LsWMMsoPd9MMV72nxK5JLOxu2IbmN1WLpquPfDsSe0rPujQGt0oj+V+?=
 =?us-ascii?Q?wjuEZ4CXExFRNy1j2WepHmUSoRvQQ3Q9CbD9bSbAw2VH59qXVnOnmnU2nlg9?=
 =?us-ascii?Q?Jm1erWv032rEwfnfQUm1OY2B+yjyhhUhfPwc00sBPgaIUd/SLcbYJCm5hQ5w?=
 =?us-ascii?Q?WlCL9P9ixdOGCogdqy+Si1d3cG/9djHxIpPl8Bz716fSlJl6GREeWqA3SHlS?=
 =?us-ascii?Q?q2o58Cg62HzedfDogFOX6BRZOcx7B2RjtOg9FVJey5vhowXIxZ0UvARsD7l/?=
 =?us-ascii?Q?VgTZk58wwoV5SLccVWWbsVnSQRlTC/+ASjXHN1g6H9FP6ehIM+A4bIbyYGAc?=
 =?us-ascii?Q?3rRMIQiBXpU2JMUoxDfDSnHs9gCYF5o17Btfhg8+dx8cma9t5Flp8n4tfzfI?=
 =?us-ascii?Q?O+ih/Zv9zhndDKNIq3hnKdzXnDNqCZ2Wt1NZ3UHRYB8XgGZuIYc2gANdSRWS?=
 =?us-ascii?Q?nBiHhtkcX9mbJe4rX/oo6xHo7ubhVgEHD9OopbwDF6r1QP+DAhFUrhB2CHs/?=
 =?us-ascii?Q?4dF3VbFoWihnMGrsS69DMvUny1OR5AFuEekBiK9oQBFhopQS4JyXh0C7Agoe?=
 =?us-ascii?Q?+pFPDdwE5md8XL8o2iXA6LBn25f2IJFTO1ziNN2gxeAdinsUoHILV+bh2yFO?=
 =?us-ascii?Q?w16Xanr8ctV3VoMuQFD+oARQ7Sb8eRYf2LJaLxykL1NqKAWXGif8sIyLqtW0?=
 =?us-ascii?Q?/3D8/hCnlayJiHuSzTAy5IGNw1wMN7jqLkIuM5uEu6Ncib4W039RQoIR+TsU?=
 =?us-ascii?Q?P+gC+24DET2AxYjNOsSN26INLv56X20Uz2SuMk1FL55RuN98422CdFljd/vH?=
 =?us-ascii?Q?j4u6ELrJwPbr3Eqdbkbw1iBOYFf8qqjvMX2n3SnQBDXibnOToCWiYxcaYqyp?=
 =?us-ascii?Q?gLVc1lInSjThhWbzXZNizlSUHNGaDXyZ2qUV4/RiJ3sf/ZED3wyDNUCbboHZ?=
 =?us-ascii?Q?o46Dc2886Ryi3BD5zQnigev4g87V3XCbPcVbKgCDTFR2ur/SSo5l9+ssLg5K?=
 =?us-ascii?Q?2zMx87j//LhMIRhKtbwLJxsWC+bgwJrVqiFsd0LuCgOMQoguhWtgyeWX+8uV?=
 =?us-ascii?Q?2C+2lMij3KXZT6qLvaHFfOqi77x+6qJw5WzclaOAdGtOIDXOeMcVuEdRvwbP?=
 =?us-ascii?Q?8aq/tEklGI2TrS1qxxq/IjwvLfn2WaW7OPjSDZILAml8ds6jOB9KCOsWCU0C?=
 =?us-ascii?Q?LkqEtViNjSbpsdHykFnw82fAcDVqImttUoEBsPvjPAy3Yj1nwXQH7DVmuV1N?=
 =?us-ascii?Q?1LlK+/AHA9frkhKslS2DEdAoezbbUmd26Ue8Uh32?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34301d81-a4fe-4844-2b48-08dd4c57a021
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:55:39.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpjPMJdfQN2ot/4uk5IPFzZ3VNBxO0P0scRcwllrwu+On75gR6t3uKDCq3kOzpTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545

On Tue, Feb 11, 2025 at 09:33:29AM +0000, Jonathan Cameron wrote:
> This is an area I plan to keep reviewing (and adding more use cases), so feel
> free to add me as a Reviewer or Maintainer (depending on how guilty you want
> me to feel if there is a backlog to review :)  Will save me making sure to
> track these down as they get posted in different subsystems.

I'll put in R for now you can upgrade yourself to M later if that is
appropriate. I'm hoping it will not be too many patches

Thanks,
Jason

