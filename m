Return-Path: <linux-rdma+bounces-15056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A144CC9806
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 21:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 210CE301DE32
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE6309EFA;
	Wed, 17 Dec 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EY4+yrxs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC3309EE4
	for <linux-rdma@vger.kernel.org>; Wed, 17 Dec 2025 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003865; cv=fail; b=Pysbu18jp12Qie3Ni2EF30bzI/7GLAjDKhNu3WcZhjEOX7zEeNUjteNwRVVPAbixEDEfoHaysXVzgJfnTIyY21yPlf9qzUvb9HWuGms8UJJOsoNvr7wKwkDPAmdw9/km100r/IJqJs/853Ls3kAkvWoPX2pmzDI5ybKq+PK6CzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003865; c=relaxed/simple;
	bh=AkQeUAKL7Gi+7uKCdQPo39Wvz/tDdHWnOtGiVx4YDjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ChSBjsr23KHVufDtMHPv68V2eUfyg3kz6qPpb+b2ZSx32NJV+/wccw7ONRBd3MTBmKQrTQIMEj6zPTeJW5errgDjDUZkqL0BKtY+cjFueAV/AddKLBtpQixuauYF8Im0N58NSgLBAv9fio5EAgM1L944U+s3T00ZADTetHhMmWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EY4+yrxs; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFWV8Jh3qzIpOuGWpLFMvQfZUMZIbNsdPtP8MkFhP9/5H4d7Bh7fPYm2wDel/4b7gmC5SaDugP6u+Isl5VzJhtt+v4UZrKmcKS4CNzYiPl00sJlFPrN6/XmSQgs9IyZ8Y7WqZYum8VLWQWfOrxXTgZOfrz64c0Lh7kGHPgSzUuAfxX/Ify1Zf+W+wS8DvIqn8PqtE7ofycaRciEWGP3fWEcFvTpF0I7gMsPbIF+NWBIbFtrTw3Uj+ctKymadU35W/u09O7W7CVPl9Nkz8DpPsQbJ58v+mFYNU1hM8O3TTdYtOvEY8hPDHfu1nfXgC76Eh2rKLLhKsjCCNysK+rkhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfwoW4sPS1bjYGlhxaXyg3cEmt4EyqSURfdW8UnP4RQ=;
 b=W7AKXC/8P3B9k9WgDPnz46feBNNFT5NZj0la96/6klJgGwvIS5E/AQaWc+QCbMZmycUXsVW8De0WgJVncUi/U6nuBssGbfUPk7qfYySZHCoNHbxkYYcswyWFdixZT10ZEZ14jVrgDebIko9odENk+B1uw7Pe+dcP4G/oj3MNok2tUhUDhqt1cW/sRnDEa+SzStFViDZB6PHsuoz7Tkw+I9/hHmGcMlZ4aP7UXj+znoMWMb9JNJ4JSLHmEcUAj4POoKL4gaKDH7PxEX7i5yAICbxqmVpobJyGUU63hBLVkzoshkOXKy9FiyufTmjl0LA/4IdK3a82dqkrHrC8XsOg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfwoW4sPS1bjYGlhxaXyg3cEmt4EyqSURfdW8UnP4RQ=;
 b=EY4+yrxs/fM6n9/VH5vKevMSMRDbWk9m10Zr8/B1BxPycNYAWcNdJ0XtX10YGMKc/Z+JiGeOvzVnfqtx5IyWlF8z7LPMDlmKwIcYLQdaBpUAAYqj75MeJUUzvAfNuffrb3LG3HQtypMtw3drTPlQRJu/GWyFugD/TdFKrLZNVql1BM2b2qpllNGq6xl0k76nIhNLSXLf+rJzhuED4SL2xPLKkxkHtx+AKVrakhFyOZ59MX3WmUOhufXQA0yKGY+EopHTprsfVlWG0HQzUMXGPkWbbBKRv5Z0LPSOYPpZcng0LdmS2nK/ai7MJboxKuS3FbraI6fS3Zr8F9JbP0WABw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 18:04:26 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 18:04:26 +0000
Date: Wed, 17 Dec 2025 14:04:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Tom Sela <tomsela@amazon.com>, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Remove possible negative shift
Message-ID: <20251217180425.GD211693@nvidia.com>
References: <20251210173656.8180-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210173656.8180-1-mrgolin@amazon.com>
X-ClientProxiedBy: BLAPR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:208:32e::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 469c7690-7c2f-4c24-97c7-08de3d96b71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?moQuiN0+Xdb06t7UFAwgT/tp5uwQkxqkM/yBjrV8UgCdkxtyaqEr+PbaZ1kK?=
 =?us-ascii?Q?IkCcuCk3XKTeEdMQT6kDrhsVBbrX9pvkap7CiZVoFgF3I9olsHNjAkZGx5Yo?=
 =?us-ascii?Q?7pve/ocT1GddOCRJLZTl9MUxMXEPcfiEVxymJlKJHzD9iA2Q5SYihYfLbIaI?=
 =?us-ascii?Q?v9NmVnUDOb4XLU5CHzxd73zR5aTEYKDiLPH76+gRNNQ8BXQlDgt+fuICAe6d?=
 =?us-ascii?Q?0sbSVcp4/iXLytaS+/4Q03597B4kXBjD1o6ZkCaxKo8LNf071na1tC905WbD?=
 =?us-ascii?Q?oqQu/DrYjNmvkPX1rxKELm46YmBot0r90hWT/mFLbWHhqNNscT92rLUJVpmN?=
 =?us-ascii?Q?SRbxO159+n24JlDhxdME5tY7G6D5V19N5/NxdYEOvhVVvM3m30eMDQ11n7Gg?=
 =?us-ascii?Q?pkTpw+P91MPq94o86XASlJkXXKO39IXI1b2kJXDXQGCmp0ydfHZyRP8FihxH?=
 =?us-ascii?Q?hxbkxvbb3IhFClPWU4C+/OjwelpOUYuzhkTaLZLQkiuEFdAYICOiWv095UB3?=
 =?us-ascii?Q?yglKCGRG9HYbZLgd70Mv7DhPLCSSBci3Nh8ZYxH8Psh+4QPcIcYrv4G8vz8N?=
 =?us-ascii?Q?Woqvqcf7lmFl2djbc1iLP0tOvBEfNJjwkyGvqeg2aCLiBknCUYCLmOuWfs59?=
 =?us-ascii?Q?rLlW6kgDBvAtIWDBrIkI5buNk5l9/N0DN9B/nGvL204ByBYlhBazW3rNu4KG?=
 =?us-ascii?Q?BOvm6DmP7O9rgxsb0rBkPkIrC0oHZp6pUJ9KzBfp8iVENthh0Z9KoPCLnHPZ?=
 =?us-ascii?Q?NcpPEowNhDxzhaR3xkty+k/Oktn4WFI0m71pktwAK5u8O431duk2C0yJkRmy?=
 =?us-ascii?Q?oSUX0KA03PhgzgCp+ewjkBC/dpXT3Ev/h/cOLdxlNCiNgkmFB8BFDEMvF4T8?=
 =?us-ascii?Q?k5Wp6GQSiXdZO4hyQ8l5aZQq3NVgC3Sd6Q+2AhLe3ZzqvN4S32R/2nHzdWiw?=
 =?us-ascii?Q?5zKZZGpmLV6oHN3Ez5xGMkaawLRK1+GHojurkK7CMQrtRRSQn25WhCFFW4hO?=
 =?us-ascii?Q?IoLtuTkciozATbKBSAAAzFhlOLxRfIDG5rxVC8RBGXZ/Eg1q8njCoSB46T3f?=
 =?us-ascii?Q?eM6XOguIgWhtPRaK2keQcX2835td2xzyGqEXYsjqzZrA2/ciz7lFDtrGajai?=
 =?us-ascii?Q?MQCph0L2iQl3nu0ug5U08CcsMcShpoXiojjFVxJIjwr5MSAElCtsEHdzHUrc?=
 =?us-ascii?Q?KXuYBsWMKsobhGEVB0hJyjQRl8Dfiumi65Vk+h24ebKcTFTg9ldiOa4InOQJ?=
 =?us-ascii?Q?rFS7kN9SQq99gFRqqcad+28tIVaK/SFV1Wue4EbilIGwXs3xBq8jnnYXOZGm?=
 =?us-ascii?Q?n/ztlaIbYJPZ1fxJqMvSzayNnRrQTRCIV8bqz1iFSlqw8EnxnZCGQylGoU6M?=
 =?us-ascii?Q?x7dQaHTBDAN0ir7Uh4VTh9Emx2d0UUC/B8GRoMdzuaLDEkNH0vrbmZVjsN+A?=
 =?us-ascii?Q?0E6e/v08RIGNbKexhAjxkmRPJhfBpei9?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?kT58t6nmYUNa4PsKmNfl8KANYbWluPRPQ/N40nIPhyMEZIMDtguRVWIv+sPw?=
 =?us-ascii?Q?EHSPpj600mCdEzLQOjXyLm0cXWtY+O6+E2SP1ndI2dMc2hpXAVUuG+rvxuXJ?=
 =?us-ascii?Q?KveHvVpdWSwJTMNZ+3eoK08Wu2AxCF4hOjAfqWH6arwt44UUiwDwZc8Sdw5I?=
 =?us-ascii?Q?p/cgglGCBZtw/WW8XrIukHadhueVLARmXzItMQumlBSWynoSx5mTtu0lh/fi?=
 =?us-ascii?Q?v6m2g9wfEin1AvFKwbaUemK/XXq51Z4O0nzUvA3IJwV3vMLOTIL2PuD98CZt?=
 =?us-ascii?Q?/kKYs1zF/UfV7ODpz/fFYySuy4L/vMI30KHyuSQ2OwHD96QWAVqXMAs5iaxA?=
 =?us-ascii?Q?Z3fqu87gcsGiiGqvWb6xYgwjBAhc5nEo0OPowxAcxiykqQeXco73Q0xtXR9m?=
 =?us-ascii?Q?0zMCg/zvZZ1ODOZPkyCgiRLbasJRom662ZWawohUnJbPlyD1ZiglbCVCOFal?=
 =?us-ascii?Q?ZTcM5lclUyuXqktrUSdUFW9oxWNkb93QbGtGIj1SvCBguaNo6fhvFBt3MZr7?=
 =?us-ascii?Q?iAK2WlhIQTcN9y0ZnpGLsZS5d/9cEH7sx5uU54Z4uxljh5l6trSHa1gG/9io?=
 =?us-ascii?Q?SU61K1Gwk4oIfTWbB+OxDEcPxNq9b8ku4PllOkf/ajUkNx4doHQyM/SG8ppq?=
 =?us-ascii?Q?z1I7vLrYVdJM82hELnIap5ka4wlad0q01uBoE5rTgFxKiSS9l7oVMUewx1Ib?=
 =?us-ascii?Q?hS2vX4IwPbDYY+RKgWFecqy7WOdgvOIf5Gm7jwJYF90+ayfUgiur9gjVfgTl?=
 =?us-ascii?Q?Yy7NcFQAPkahveOR8njODTbo+uv3DSbvnUT8piRdvZG2irrONREDqOmAkEiC?=
 =?us-ascii?Q?Krx1jvYYZVfpZI8fKfk2HXIKRSXTo7JTtH0gcH1JYQHSJM2Bz8ToKz2B39C1?=
 =?us-ascii?Q?NaZd/lBIYQMFb3YoQmrS1VD7YNGAmdFrY7t1kuhKSySwDjJRUBOKgYz/A5DE?=
 =?us-ascii?Q?4OODkkhLa/Wy3dVBsKj5/UDvGyHQ3jWrBPAXAe1lbylln6ahOmlGzMAmxDA9?=
 =?us-ascii?Q?c41TXGqYyIJTswqbRKUlIL5E9SPToaD4PLGOok1gQ9gGqe2+UeMDQMaiquww?=
 =?us-ascii?Q?EHTYdA+UbMgcl+QfPOawSMPLzTwOx+LlXOwAp63SKID+MEUfUtbR6JJGJS/K?=
 =?us-ascii?Q?OJCRY3vfqciMCQWAwYByocNcNbQGRM3n9A8SehwPDHJgauYFB5Q90TWyHzQZ?=
 =?us-ascii?Q?eMrpf08dPFSBMLcoLVd50JMmKDdwpu6+OmSux0ElHZPi7A+bonGkg/EOh8RX?=
 =?us-ascii?Q?bRlI9LPBdgUnBvqSwq/QAcwpCIXl/5bFW6i+va/USE3tCz3xeK/yucJjl+0Q?=
 =?us-ascii?Q?fYVyaZr1qx+2+qfGkdNwfNG4FenhOx++MqTqNIPV9jyiLUCqvH/nxCA7RoFf?=
 =?us-ascii?Q?3UgkZT2zsMYxtltbqGEowGvwEQUD0BpJMvSWtyRsGvKQPZbNDZlNGKIANfPT?=
 =?us-ascii?Q?cme2nrIkO5bzSStwceUEsoA/jmA+ditoX5itRTkkFaTHqk27nj7fRyKGhCZi?=
 =?us-ascii?Q?4e4RxYTAFSo3Z3v0J2xmyJkClxRA2j9c8oPJ3yGbpCOBD+5mc6FMWumiC5v8?=
 =?us-ascii?Q?XdudeQ8Ph5+m5Z3ezvQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469c7690-7c2f-4c24-97c7-08de3d96b71d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 18:04:26.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EzOadQ1rnLehvj7LtS+k5bts9nDMZC20EIjn8Zhg9ESJhtvd3TpvOtV5eSQoVwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

On Wed, Dec 10, 2025 at 05:36:56PM +0000, Michael Margolin wrote:
> The page size used for device might in some cases be smaller than
> PAGE_SIZE what results in a negative shift when calculating the number
> of host pages in PAGE_SIZE for a debug log. Remove the debug line
> together with the calculation.
> 
> Reviewed-by: Tom Sela <tomsela@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> Reviewed-by: Gal Pressman <gal.pressman@linux.dev>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 4 ----
>  1 file changed, 4 deletions(-)

I added

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")

Jason

