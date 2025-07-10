Return-Path: <linux-rdma+bounces-12048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71755B00C6E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 22:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B048117EC49
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AF6284B58;
	Thu, 10 Jul 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LaPQTgLz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329D3D6F
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752177874; cv=fail; b=u6R8MqBdxtANWMPSsslMlPW0Ifd2OvQ1Htzf2rFn0nQzyVDa0z4ldbMlKZMSBr+k6eeGTJEo6QwaHHzh02ZDjTLxRra/lHzVph0Lz7QosyVEkeKbHFqxJ0aUm2+3Tyccx4Vk3cFXoz3urWbpEmujD6HlQSiDRug77/WCbb8L97c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752177874; c=relaxed/simple;
	bh=wrm0vOnTuCqR8dBRWxO7tBdUBVxq7fntVYdHyHbJ05w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oz0RQfMf8F+h0CEEHhLAUajO0s45fP0PA15AYMc3M+oqBDm32L9Qao75g+dUAVliUCqGQ0g0hhnXoPHuqMAUYABHXYCN4n9kprSDmcIgCdCRuTUfkzD+YTu2hQ/lSRTGbCH2cxJgy29J5y3oK0ZWYXdpcydaaYtWVvZK399jfpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LaPQTgLz; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MT0ipPqvJQvNyhJSGYlM0DKD8zgDDpoNAwPcRm4dwFCT2TF28AUxdL08i8LJcJGeS71nKRvVPG152Qb2Krf5Zhv0nQhpDjesR2fd/l5vY87Ko8lj8Ay1YnLLBUvOms6GLQpKwWXS0IVUcFeK8DQ/Th4vHEqirGTlFSPHeGna6vcyWwZW6QIGwYEN+tgcvUjZAQPtjdx9rBq7QmVnST+S5RdyIbBVKfBwV+7dwbs8bQGXRRj4bknupnHPI/Ie7OPZD+wWiqLZMjwUJd+TxqtF4a7wh1vxeEv/hSwKUtcvW24x2+sZT5Ggd3rTxbYXVTlsN8V+20SaU8EDy/6NJn4SNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0NqkNq6fc4PsxbFj8Pi6+/cEoQrZQQigbFdVjHBSvM=;
 b=somVYVRn6PdsEcn0aibi3l4xdomJTSNCvcTO4ZE+9Ppi0/U7TAdP9itJc11eLWTJ1r3VUkYCD9sk8PkwEP+QjoaxHQOOXmT8q5pnI5zBEJA/5LzClomAsfIMA8QaSgbI2gMVWWqgUT+dzN3DFo49y/SsLbSC52IWwaOn1Ir24msSuwng6uU+tI1Q3yhpFAHKHJNO4jDuxiX5PXk44NSNSVHridzfq5FkzfTzBmFKZGPEjtDuanNGc436L+uiN1rDRbsVOqrt0AdWRFlzexhYEYrSrUrxEQSqobRG88fev64Ue4MXY/5L0mCWf3/Z8zfaw2329i97L1NeAUSRF9C1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0NqkNq6fc4PsxbFj8Pi6+/cEoQrZQQigbFdVjHBSvM=;
 b=LaPQTgLzIw5uC+iXaskAxbneVSt4CLjX9lN2noXRTWnOveWfpiE2Zzb/RaNJYGoU10IEoT3rXbKcObxVIgvtvwhSgH8SelfJnuGpLx+b9gQ5MdyAA9IxV+0APyGJ2ukwjq5xwePHN6KX0R58654ZuBm3iLAHXgC+LMJxW3OL1GD/wkBervTUjxgY8o/aV7GEZXKdT9siWv3eYVEBSpcGxaTUpY7uf3rh4HPW5jj2V91RRXcIZ7d7HyUPN0msstGUN9oVdOnUyPZQu8IROMd1h7lojuUDX0XeSCatRiz+37HUT01P/4k+Km/KOcF6XghgWFAvtg/J7UNevfehnFazbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 10 Jul
 2025 20:04:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 20:04:27 +0000
Date: Thu, 10 Jul 2025 17:04:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next v2 0/3] RDMA: Support CQs with user memory
Message-ID: <20250710200425.GU1599700@nvidia.com>
References: <20250708202308.24783-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708202308.24783-1-mrgolin@amazon.com>
X-ClientProxiedBy: PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e29a91-e146-4b65-8ddf-08ddbfecf93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0w5BKMD+SIUANiZmqwkofjfSPLrpiF9dtA3w64TaORFfI63nTMH2QKOJ5uCD?=
 =?us-ascii?Q?1nTMMubw1cZ5/kMhb/xMiUjfDaqzONkjb2e+UY5pjZR1Q7ZN150Ry0ot5upN?=
 =?us-ascii?Q?3ZvH2iAxppfTbkaEytaMs9RbTSx2xQaedtR3sGFpA2wdyM+WNpm0Z+cw3b8K?=
 =?us-ascii?Q?kehbJbmcpY2EExf2bh3k45I8gRZD1JnmeAowhFvueNN+/3ERJad72OaKv0OQ?=
 =?us-ascii?Q?P9QjOf/GFZ1xTNzv3abWw5wFCeVR7dv/R1b8F5UMXZ09eemPFFnb9eM2Y5Ms?=
 =?us-ascii?Q?tQ0TpbnFWy831G0rpio01iTz6VbYP+/QFoUptaXM4XNNiEOSsVv4NRuMVM+c?=
 =?us-ascii?Q?4y+cM30piu07H9ODuKQki/ov8L2etr7+l3Ih/CPvYoZDyBAMC1+g1lv4UKu/?=
 =?us-ascii?Q?UfzJDeOFMCwXOiK6dCTj3cDDD/3iLOuv+U38iA1QndDhX0vV8XJKjPBdlcBM?=
 =?us-ascii?Q?CmjJYvNQsC8ln4wY7RSlSyi5d1YeZ72OHlwv1hJCN1fFuMD0AI/IiLAKS2jI?=
 =?us-ascii?Q?c7S7qq8x8pK/jbmkX5JvxuajFXSWlJMV+AWPms7peFGHP0a+dmS/k2NFTGq1?=
 =?us-ascii?Q?u90c6Wltss3DAtZZTcKi4vvoOnO3uzod3bE6NgQ5vLLe9BCo6KB3c+71tDNY?=
 =?us-ascii?Q?9UkeSFOJ8EwvYEbrRHxaBR2ob+5H0hGbx/YbLJta6j0kqllahtWpjk2lkwBO?=
 =?us-ascii?Q?3ns4wydv06M7iCeifTuT5gsv+XBpSFE63w9ZcmTig666hpTaVf/xlyVwL7mu?=
 =?us-ascii?Q?3+bwNw8Y2MDa6+ELIvi4d9f4sru+ccONuf52lAj8xaZ73ybsP69fK31kVJPd?=
 =?us-ascii?Q?CmUPbl8RfL7VR2P5KksI78d4fTlMtzAxbY4gt5E3g8X4NSUe9wnj/V3N50Hj?=
 =?us-ascii?Q?OhdkYsHoYOYK6SZklHGimAq6SyW8BdTGY8zuzb+tPnUT5dxRRZeR8Lvv1YBu?=
 =?us-ascii?Q?pRPOFQVi99fs+Zxlg8JntJXBdDbKPykc8B8ZSLaIrAqb18gw8yFVpMpIkVNS?=
 =?us-ascii?Q?o0yqYEIY9fJhyBl5YUhnKf2rq9ecrCfE/Q5Dftmd7TcE8WDs490vZ++gLqdE?=
 =?us-ascii?Q?dcxAjcMQL5/FrjnBxjtfTfH/ZgMqE75fXbHkjW0uQYWCSA/6+t2FPDh+T6HN?=
 =?us-ascii?Q?NT9d0jOSjFwJEcVgemr0IVHrABfd8aEgplUSFzUIno6zKIOUdFFO2Dnx0dcZ?=
 =?us-ascii?Q?ji3AfoKM+2G7AZ5g0BdzvTmKgkp3FPCk69Cao16xV1ngK35XJ28jNZrW8X+n?=
 =?us-ascii?Q?AAC2Z7bI/wkMWQloOAXwJBg6dmklx1ndSmEhX4k7h8ikYFgQxfCr445ykP9V?=
 =?us-ascii?Q?SAzQcAp/0jwdE+idLt7yvpyrD97o5UawTEelfJSUuNpjQv/bnUPeKh2NXO0p?=
 =?us-ascii?Q?+n7+Lrd8zXlAVtsiDG3CEG9F7O4Za8rXbEJWz+VDpMB9MXDsZn3CiTQlezjo?=
 =?us-ascii?Q?Iu/KNlze+UY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zegyWdGCOJ+q9G7CbvxVniCV4d15b6o4lyz3SNm8ZbQQlvmYeshWPLz64A3y?=
 =?us-ascii?Q?NqOExUxmfdmvPkBJjKy1Tp2AQkHAVpOK57eGt32+VNctpWByPBwouykn6+Vs?=
 =?us-ascii?Q?ejfYSzTyOmJCQdlq86ZNB//4C5wn4oD7BE+sYITnRQyIFDBRRArzHIO56LXr?=
 =?us-ascii?Q?x9j3dxnMTH6cZqD8rTDIX1Y/dt0Q1whyAE3nk0Pq84A9gHSxeBqTc56+74d2?=
 =?us-ascii?Q?nbcFreKWtYCjwdybNMwbThswelFSy1rYaXdNrp3HecblxRMD+E9mynxPKIcC?=
 =?us-ascii?Q?P6tjyOtbB6S/FbiihQBXjnuYUeK4lwGiIGQXgoS3LUV0K+KjgF9Erc1zY4jz?=
 =?us-ascii?Q?r0cPPBYceoigUz/IpDA5FCHXf/0pBnR6EcPKk7Y5exdUEPD1EryHMNVLU0qC?=
 =?us-ascii?Q?rwG6Zqd9p/wV16jHsk7TlsSJvcVW5RUqUPr1j3o3jR4+YsknpgvrDNHsqFO8?=
 =?us-ascii?Q?FGGv49+kngh3PkqpTjhZxrYxmP29u82iMSlmW3jOmvnlWwvbW5ZFOpBiM0N3?=
 =?us-ascii?Q?85OedvsOoWtXVqb5pthPf/7KG8RiPTBN0XNubReFj7scead7rZssUBfhlGO4?=
 =?us-ascii?Q?vONinN+qCraAGkqhxGbN+pO/HlLjQDM0ap409QWulU4WTiESniv9sMWp0ffG?=
 =?us-ascii?Q?iIgcxBe2E7ImfpOiSW1bGTF8txfJMXcVRWa4HFopC0UdZvw/RnR22q4uJwpT?=
 =?us-ascii?Q?D/pB3QFcfWP+0ijAL2OqjKHxp4r1eILrTV+HaL2No6SaqwPwxmIMzD4ikcp4?=
 =?us-ascii?Q?jpKCVPEDUpaXJQnmDm4BNStaukyV678SPmHI26t9jRDy+7rojH9M5WqRKRFS?=
 =?us-ascii?Q?jvmWl1nWbbNSrmeGnr2Yid7R9dzf0ta2IqwKsgrBb9Fux/gzPz/NoeDdJjlE?=
 =?us-ascii?Q?Vh53hDcnxLpU1J4PjNLzfN2VePJcXUDGntJhELhCdtAbSKzWR1JZgNg0jZtO?=
 =?us-ascii?Q?sVN5DD5R89ZVOul9GTJ8SBn8VhL4rsDzbfeobvjVRAnC3zJ4s6IWYcyVHdT7?=
 =?us-ascii?Q?fOGQmODBZD4G1cfWiyS/zgE8F5K938Vx+hYPjQW1joP9tCQ+P/+3nTl+EFfd?=
 =?us-ascii?Q?94KIx5oAxxlbXUqjkU01Gy0sADRbXuWNMxhBgRrq6zo1z1XJy0H7n9V3LuyR?=
 =?us-ascii?Q?+pH/j3xQDxnGn3kkXl2p59XqOQNrdroGFwMNn4Dlz6HZ7dhaaDESTzxtYN1t?=
 =?us-ascii?Q?FLFwUOCLmTnp58k8v/RLc0+lUesBCP1OSR1+gda/H3f3/zufetpzCBq7wsMz?=
 =?us-ascii?Q?bA5IY/ARPq7HV9PHJJ55TElNC6ikc5Se5vOR6/C5YglHECn6swhn/4V/j1oG?=
 =?us-ascii?Q?LqbV4RpDhXMPPbT07nnok4XgSStQ7OzsVqUfCRXIhyaghnBolNHOG0wmrAlU?=
 =?us-ascii?Q?uael6/T2EmgRt5i4tt6gdaP+2PR69bvRKAR1tG6u6qHfTLZFhgCD48HDxXMz?=
 =?us-ascii?Q?1z5anw0eIp5Bc2aLvQ660S231CkOiY0SswZSLdWfaSahrzkUbOf4ghdlCNAh?=
 =?us-ascii?Q?LFlt0OUlK6xiyF03xlRGO7LZhNorAt/0EF0DtUJFEpeVUMoovPk1/gMdxTgo?=
 =?us-ascii?Q?RoDadl16GSUWoxQN0/0xHt/SgfqLz7avuQ/GmjfT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e29a91-e146-4b65-8ddf-08ddbfecf93e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 20:04:27.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr7YBzDbI4tYStiNPewnrkXOFj7xY2JWvqsuOR2ibYpgkGvWSm76Bza/nlMtWJa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

On Tue, Jul 08, 2025 at 08:23:05PM +0000, Michael Margolin wrote:
> This series is adding a common way for creating CQs on top of
> preallocated memory supplied by userspace. The memory buffer can be
> provided as a virtual address or by dmabuf, in both cases a umem object
> is created for driver's use.
> EFA is the first to support this new interface, new drivers or existing
> drivers that want/need to get the memory from userspace are expected to
> use this flow.
> 
> It's follow-up of the discussion in [1].
> 
> Changelog
> =========
> Changes from v1 [2]:
> - Added a new "create_cq_umem" driver op instead of a flag set by
>   supporting drivers
> - Added ib_umem_is_contiguous() and ib_umem_start_dma_addr() helpers in
>   a new patch
> - Dropped references to umem scatter-gather list in EFA implementation
>   and using the new helpers that hide the details instead
> 
> References
> ==========
> [1] https://lore.kernel.org/all/c7d312ac-19a0-45e3-9f40-3e6f81500f83@amazon.com/
> [2] https://lore.kernel.org/all/20250701231545.14282-1-mrgolin@amazon.com/
> 
> Thanks
> 
> Michael Margolin (3):
>   RDMA/uverbs: Add a common way to create CQ with umem
>   RDMA/core: Add umem "is_contiguous" and "start_dma_addr" helpers
>   RDMA/efa: Add CQ with external memory support

It looks Ok to me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

