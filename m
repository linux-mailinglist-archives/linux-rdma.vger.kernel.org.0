Return-Path: <linux-rdma+bounces-3002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53920900B29
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 19:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E493628721F
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75219AD84;
	Fri,  7 Jun 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4R3D8Kl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CB19066F;
	Fri,  7 Jun 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781060; cv=fail; b=FCuGxzL7bpRHy81c7KIO/lIsLKv5YBbHgONZCZW7GimWYr+Pu4S3xRejIa39kRYOHmfe5pOLcK0jy4N3aprMJ7b6mbByPlpiQDadNE8MFXIgb7LyK13GrzNKpgrWmY8lT+uV6gpJf3rQdB6k+2j8Dpetq/lbR0QEMlhCbo5T3Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781060; c=relaxed/simple;
	bh=4oig7KjM+7UcQTZeOhNDCdsFulk840mwMtx2xRkDO58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WN7YgmzW125PgefLjf8lqsc8zttvVvyrulJgaPGBw3LOJKm3Rl/8OWdQG5wjnq+mtS4Pu/5ecoSicMP/V8reqnKsuCJ3SpCw4uE3+zr2qXNZrdMsY9kOo++k4jDA7Demyrb4ou2cF0SZkHJ4GtuCTX+PuGZpe+UhEVmTivAob9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4R3D8Kl; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIlHhPtPG1yiNZXeSAllmxGw7nxHuP9UYFon++m7OQ+xDLuCZWk0bStmxIooCR1QbmK6B63G5QSKZtQSDInl1DpKRpUFEFdTzCcjdQVQ1q2RtKplimzGS57BIyziqz9DSRlwTyuP3SS+FLxwo6aCSDjwNRkvq5S/bFuePkbZ6NBKAQM9g/ZGUdOak7787ofzzv5zUIo/4T+2GNudy59BFaae3egkFQtFxu4Sftgbx8g20HFQjijoPtd6gGHGlRH8VXu8KvfzA6DKJLCuaQbneAX9ZwzzQWa+iWI3+Yw+KZkJQjtjNruxBly3KxpJFA0IIF+M4puDMXhqDtlH3UxW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pDipMFNylyfpxe+YGA+zQbf3TokCQcFeRcnodmCCco=;
 b=TT4QZkgHrEj4Xez8UmvSZ8YmquYeQLnjJsdAXsqQ93HlDovXx2swNjU4BI1VaDrvCXcgXwEZUz9NRumSBsD/H87xpllO7yf+2Xdbm6JffYK3ZkZpOxAz3n4cIARpxwDkBT6VH/AKn1ulOUsZm+AdxWlwq/rRvkhe2wdsMa7l56EKcxBsrMExJRJRUFO6PwxYk93fCsTU5w4MyLuJ7+otzv01Lcgns5bGElnp0HovKjllRMrhHYMoq/M/dg8y2BJ1J3J5hmVPXvM8i7in/HJyu4XaGe9zCYBOcnl8VNLuQn39+KFIYqHzFSkBNz8KFbsVDfERFk1AITNAKAEOeWG2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pDipMFNylyfpxe+YGA+zQbf3TokCQcFeRcnodmCCco=;
 b=F4R3D8Kllrnf5BfTrmeFcBfH0mzajjueG6Axv7+w+ed4cRAc+tvvBNJCRpGrY9TjrBtYiEH81nlQmtjGVvlqPBqocNqTkMeOpZ9nRixrF3COWQJA0ejkVelQr4XhCnColLeqTCbLyPV/YO/SQp5kSRE+Lf0fS4BNfNmlpQk2XKX24tp3Ast+TUeyVhmTKvewI5CEuqzvykPBBlt//WiBnFderu5VwDV0wGBXclMmfs8DBZcO9n42xp+yALdkpXYfepaRJhlvP45mGGADlKc9qziayK8MU8rbL6+YchebTFhHEOOwPiZ4rQfQX3ZBX1h1i0ekVACZnGBnHUrUIbTIIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 17:24:13 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 17:24:13 +0000
Date: Fri, 7 Jun 2024 14:24:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240607172412.GM19897@nvidia.com>
References: <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
 <20240606144818.GC19897@nvidia.com>
 <20240606080557.00f3163e@kernel.org>
 <4724e6a1-2da1-4275-8807-b7fe6cd9b6c1@kernel.org>
 <ZmKtUkeKiQMUvWhi@nanopsycho.orion>
 <887d1cb7-e9e9-4b12-aebb-651addc6b01c@kernel.org>
 <20240607151451.GL19897@nvidia.com>
 <ZmMsUYFvUOndiX8g@nanopsycho.orion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmMsUYFvUOndiX8g@nanopsycho.orion>
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e662add-1c8f-4dda-1e77-08dc8716a6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvjlB+ZX3J3gUtSZP6HxqwnBvwLdxeVwLd+4a0iFGhT7lhVs6Swlq+sW4Bki?=
 =?us-ascii?Q?dgS/q5Tz6NYcPEc00JySU254X2CsGA2IFT4V9V5WkNt2DZiZmXsHJrK2j0Ep?=
 =?us-ascii?Q?0etR+Xvb7ln8Mb9mdnbIS3kAw6avncSl1BgjMLdKcMUJwN+kVUN54OpY/zs8?=
 =?us-ascii?Q?8W6mlGOY+BEShjIdJqY4pyHo19O0YXk5rXjjn0AxYb9LXxa8xHme/SnChq2J?=
 =?us-ascii?Q?k1poK1AnDDuj4PunNLSouWIzkmUdUByIqYSygRo1CumgJQK/O/wzluLGJ/jy?=
 =?us-ascii?Q?2dKoQAQXBovofVt0P71whLO+w4jkzGEzI5AEbAJ5eT0BnzJb8XGp3/TxO/me?=
 =?us-ascii?Q?v+X4+kT94OjE7qREmo56X6ymSc3pikCUj6Cl83lYAzPadMq3bApEIS1Uxxd7?=
 =?us-ascii?Q?uwEz6rBqKkhy49tooKoSxQuMwlRm18oyg4a9IWn7IDAM2L4JHSm64T+N59wY?=
 =?us-ascii?Q?sfwqY3jdNEi1UL5T4wHrg7nYKyssMI/ResChdY0WJ4Q3zrDsSQ63JLYIk3xb?=
 =?us-ascii?Q?tHrreQ0nZojfzZuJQTE/uXpZ3NUISdmQcbjwU4X00VQIILnnbk7bxVn4sOV/?=
 =?us-ascii?Q?RsIrFyoTKSrntK33S4cgVYzecCO7SxaF9Tt/GgjaBYuuP8XMPEGhFFf7fVZS?=
 =?us-ascii?Q?EJXKboKKX7lkDbujvq8uxiwN18WCzjKj2RBXEX6YO2uWzhcPEwQFV3hoEDW/?=
 =?us-ascii?Q?kmZXLQjnRMxGFu5319P4bcC9AO9HZXScsC0J8knawp7suRNui5PRgD7ZaS5t?=
 =?us-ascii?Q?vXKf1nWzJwtXXmSksbWZH/tkm+6Kr3yoDNxDeASLj8IyArif8q5Pp96wM8Le?=
 =?us-ascii?Q?qMjOU8ZZ3aqL1Sy+ZyPIDAlAEtYWd+BtV1vyH7mVrGOswmIgr+13KnemWiQK?=
 =?us-ascii?Q?JnuVkdnDw99vcsMKngdIjVJ/UPdrz/kMq9/5mXWQUjzr/rqdPRNu8eYsEo4a?=
 =?us-ascii?Q?WAXv7AXSDuDW2+AVAmZuLKZ8wRwcRjo7JNKbur00prYLfYpUpndlmg7m8YfL?=
 =?us-ascii?Q?Wvh69s2xZnUPsnXLPEadSnhsNeKKvXwVx2vOrmkOZ/vyzaEBm+sGpUWRP62E?=
 =?us-ascii?Q?lsvlxqMLx19X7217GpJDp/Y5D6SfMOEgbvjFCzfmXWpzZulIDnBeHjE89wUB?=
 =?us-ascii?Q?9SJJJ5iS0rEo3g9UoTjKQqe5GLzvxv8lJBfy61P7ZdOSeY4tvyu2tlcMlgvh?=
 =?us-ascii?Q?Ygh/mgHnq8x7wI0xxJ6dnrx/Y7NWR0eRXVf5qHnl89dJTC0f6nmttFFms3bv?=
 =?us-ascii?Q?DyuXLU6Vl60slb1KNXBocV/+GBFAMRGe9EZ1QVD4oZKB/hGApkp3T2WywWkU?=
 =?us-ascii?Q?mfNIV8hR06DspLC5bS3nJfHP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hXwhym85/VDjEQDUFrZJ81nahM5ieo29LcMNXwqkcq3C9iMnZTGmilB4yYyL?=
 =?us-ascii?Q?ZpW2IQaxNLNhxfmHIft+u3MnjP+xdbdFwnT3khH0O+1NIRanOJT8cL0GISLi?=
 =?us-ascii?Q?auNatevR8wX/ouQWm2QqGo2xzYFy+fYnc03w9GhCBCRv4bj7F7maHbJDwB7g?=
 =?us-ascii?Q?Ii33/C2/5VyIvrispTU99g1iLCe2lwUC6nIHkaAcjY4t8mGd5a17dqPXSh3A?=
 =?us-ascii?Q?3A00heJ/xsvRWblDo/C9euVwsPAc+AUsjew81V9mpBYtBqMXUkd6AsX43x5z?=
 =?us-ascii?Q?Eaz3H1i+IG2TiMDQmJe6FFzYuX1w6JNao/FIb/G/WRpdkeneFCkWJaELK6ao?=
 =?us-ascii?Q?RRhfVzHLR6L+sRFLpjOqqK5yeDAHrJHEGhrp3hiVgUVFRFcO+64zfJzIzwJU?=
 =?us-ascii?Q?fGWFcawklUDHeiN1A4jhwU55Dog3yxRdufseKAy09wGp2m4aukQ5QzJaLIBT?=
 =?us-ascii?Q?jeLASC991d+DY/GnA/riARErHQPTCD6oOuyCBvuOV01+S8XtTEWdXj3mngMB?=
 =?us-ascii?Q?UuTU2K+SYkBVYX9QuA0zI1n+3mW6tayhvyMNN+/QbJqoEw5RNuPsEbVVALao?=
 =?us-ascii?Q?288EewcTH2Tz/esD7Nv0Iu0sDSORv95L32NEQ/7gRtlNFPDQrg1CmtF2vwD0?=
 =?us-ascii?Q?BwbdaJXLpek8yUQBfh2+GvSn9i6SVo6hgy2JXt982Lm2afWABEWcvl/hooXQ?=
 =?us-ascii?Q?nrn1IZNW0gCMjPauDsJNIb/wfZA3OK7duAJNhj045WNXNASsxCm0bmVYiyB+?=
 =?us-ascii?Q?bxX1SLkZFSoNIugO2Jlh2KndYm0inaTq4bLMh5aDALkjL7g0hVbxWQAto7J1?=
 =?us-ascii?Q?eL8HhTJfcOMGUHLGyzu/H/77W4+8Ds+4eJ2whQBPJ2KiL/QfTXvptCDubMw3?=
 =?us-ascii?Q?F45D06pm5JULjuBpjYjzZw7mEwziTvmr4WDdjYMvhT7d5IjNBU+4TB4NoTB8?=
 =?us-ascii?Q?6rL1/YgAyLZgR2syiw2Xqy3DDy5LtmL0EWmkHPIpidZkRTnPHD5HLG+cn1mX?=
 =?us-ascii?Q?ba6v4pVT9fOTawaGGFYut/6zmanMiZ8tH3LtGZfHfZ8+Yr07yWxMPoKP9f/g?=
 =?us-ascii?Q?z2E+ph+haj+kcAmK6LSrczopvxDZQHT3v0Sy8pvUJew5wYo6FF95ppdh8CUn?=
 =?us-ascii?Q?XGMeqBQevzYniCetrGI2dxw4iiscxzRpt68ZJ5TsSNjO6xP6UYXHJ41ihXgJ?=
 =?us-ascii?Q?XixREVvbSpUPrRSIypkFFknLxtWwSKOpfQZuHV1YyHsCBnyF4/xoJrCA6zFB?=
 =?us-ascii?Q?FNBp9ZVB2zAEqK71dkjLrDI8RqmNumJVCyBHr9NRQ5rfEQIdo8GBsdUybX7x?=
 =?us-ascii?Q?b9l1tEyKMahK8ORCD3BdHRzUNYKbmrjVloumDAwYBO8u2SbEwkPMVVK+SUYW?=
 =?us-ascii?Q?0vTfxvQCCFqZZpwyIlDaxXbK6dk33uxZ2rhedCs8fwaybYDGdQq4/ZwyTYXK?=
 =?us-ascii?Q?Q5aEZ8mB4enVjuv2q4vlNfNt3e+VIRxeqLqbktzv1KiqMEZKYS7KLtmx2qqe?=
 =?us-ascii?Q?LbCRsKeUmciwQsVawmvGAc4ta+nefGroPLpBIx9JYH5Jp6QI9RVP5moWDI31?=
 =?us-ascii?Q?tf47XCpgLxjLZoOWOV1jou7j5sLtlf8o9nAEZM7X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e662add-1c8f-4dda-1e77-08dc8716a6c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 17:24:13.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peG+0D3x4ohYtcRsgE33KqZ7jG4zqktkYjtHynr4gIWuvh6DKy5YXNCIWiKtqoiv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

On Fri, Jun 07, 2024 at 05:50:41PM +0200, Jiri Pirko wrote:

> >But to repeat again, fwctl is not for dataplane, it is not for
> >implementing a switch SDK (go use RDMA if you want to do that). I will
> 
> switch sdk is all about control plane.

Ah, a poor tearm. I ment any involvement in the data flow of the
device including reaching into the so-called control plane of a switch
to manipulate data flow.

Jason

