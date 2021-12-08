Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0946DD3F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Dec 2021 21:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhLHUsM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 15:48:12 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:15776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229648AbhLHUsL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Dec 2021 15:48:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzk/alt73P1vEmTN7aOILn7Q4NrtsrcpNuMLy6NvUF/oTWgYb4wRdZa5X9WXb87ThSQ++4olgZXyY4pRzR5IhG6k1wHHgOrDFo3Yi9gU7+TqSmRO5IX4FppeDGxCh+BDSCzlka53ga8CDsX9Iyrb/rXFDyGu/DSktD/bJUoUCOlVQe98GQkm2af3w2xszPMCs4DViSGFdYiPoGNf1yyZSMEjJ2DxSg7yScTS3/y+e7yrHN58fqCOeM0odgeXhNtgIzhAxusD2MfeotnP7oNp72zoryaNt0HwRXfphpfHcpxhvEsedmUSbE97DOVqAek6F+QiRGrGtB8GIVs9sR4N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWMBHW0jCdBNpT/Ch2VzMICzUBh0hxeheya6AZeIDF8=;
 b=oKNmVbmWnqUcAoZ/mntCbFTkDl0A5sKqJoa4fiU5bsW9stdjD3TOsQT699f1m6I/k7Ru/XNp0GK1OpkvbPILkZVGsqjUcIn52UOKOi/8QD8OwEHhFCp2cgn5iS1M1t8n1KeKF8Sey0lzLQxEE5ATp6bMTAAW2I2z9LTm435DelJnO1oy0MlYV7pCmjxD321ylYjrLJyZdRno+iTBJvXJmsqUYTQD+QDHty83zgQM+4JfkLfq+1//9IC+hNIkqyYnw8YU9axE5SFc8ywRH94a4wzZg2DeI0A3AbRF6unozaKpcIRvqgifKBHryf9wW3ccBUkOmpsqbk27QSn7d2hOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWMBHW0jCdBNpT/Ch2VzMICzUBh0hxeheya6AZeIDF8=;
 b=biILeHxSUUsIdmW6BjpIRhDevG5b+y7k8NlVvh5qjcuNvkmQBNnVbVLHGubGHdHhq4HKymn+tCuulpkyIV4qBqfyS8za6m/cYQF8BbJiEkxZLGbMQq8lRGaJXJuiHzdaJ5FAPGgnV4MDvfBFgLjVDkceyEWahSbUbNk+qNxjemySnvAtxYiPZebzgPAb7YA9u8XAm103ImPo3wfMe7BG46PEkOgbhmRNVpLPwNjxSPbDEG4EDiSXMxk1rAAx4fXtxcOffzRoWWeJuJgBFMAOLNvRS1eIXU+HaHN2kz9YZz7BiVmoVkhgeWHTxzGN9fOdghgllGCBSWMpFDlQiAHMjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 20:44:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 20:44:37 +0000
Date:   Wed, 8 Dec 2021 16:44:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/7] RDMA/mlx5: Store in the cache mkeys
 instead of mrs
Message-ID: <20211208204436.GG6385@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
 <5b5c16efea1cd0d8c113b13e1f2d9fb4e122545e.1638781506.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b5c16efea1cd0d8c113b13e1f2d9fb4e122545e.1638781506.git.leonro@nvidia.com>
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16b83d60-0813-40c9-b023-08d9ba8b8cdd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5175047144EF24DD5CFC1AD9C26F9@BL1PR12MB5175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApXetQO/PV0ivVPsAuPZcv9Hj0CEL+SljLMWieDkNnndfAbLcJE3RmeuQr8Q0HgfGVFDSJMtGazITbpAYvvuVGNz8zpJdem1S+UZWUQ4MCCUKJakS/oLi2MtE4aRUh2rLxo0hSKmlAYoRWE32f89u3SlSAXnIPkVDGn0i07PD+ZA7/yUeAi5B5ilugHDTXEzC5VvT/5Jxfzb2nJLjM5wAtZGcTio7XndKyOQWygHaJtD2LWr/OOQFWeEnkBUk1BLHxJGJCgllcOvfZRgSQt/xB7TFvG5zUGFLLLx5NnJgVZVGW9W/7PqxF1YziUu58T+cfNwVDB5YC5noSNV7iczrBnBZAAHlwp6bo5AyZ9ue2Ney1RYbd8Iycimb2nOzrZpRBoesJhvMy7KQrG+Z5uuykFA9Yd/doBDnROsTfptCgDYIo8HWzFQI7sETh5ywZgTxDNHgHns5gAbgkxj8kqwvVm0p99vD47d+RQ0A82D80tJVn3JsjGZjLCoW1s4Iacfy/uzzzRtAtxI6G9vdJhRxDBZ0YqbrxhMwd0wch8LN66iBlG93vw+6Ed/5jNNKFaraQff/ivn4dRyQ1pQtzlG7BQGD110czOmEcxJv7AUqFqut0PHZV9NRq/4pTupBO86BvRj9HqaPUW/wGDsN/yLpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(86362001)(6512007)(26005)(8676002)(66946007)(66556008)(4744005)(186003)(66476007)(1076003)(6486002)(4326008)(2616005)(2906002)(36756003)(6506007)(5660300002)(316002)(38100700002)(6916009)(33656002)(508600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Oe8txF/GmjJDZcAr6AbFo3RPot2693zHEL3x7MH5p5j2RCzbZia+eO+4RmY?=
 =?us-ascii?Q?qMvGh2UEhN3fMzYBeGCoqHg0fMa8TN1mhKHtMgMVOoQm7dqLehDX1H9Gb/n5?=
 =?us-ascii?Q?IFxYekHQjh3pbkYcIu2+ogO7AfelUHrdt4dN/+WysdxuUjdqj7a/bYvenBB6?=
 =?us-ascii?Q?tEZMezDCwmAp6UY0gFkGLjZZACuguwywTznWKOMI4vw9ang08bxGlpKz0zdU?=
 =?us-ascii?Q?0Gfa3FhsaQqajHz6kKAUqWqHGNUnvYK5FcOtzb8Ku7OtUa40Wh6Es7Ntguof?=
 =?us-ascii?Q?dMfodHOf/zjc2Pgj//vSOX0lAebxS4v+Psxs05QChB3qO7RU9WWZqJIg1vzr?=
 =?us-ascii?Q?Nbilpa9yMetvLQzl5g0nTimbetBEIUvfxBw+zHEY/OlASEjH4fGJ+mOdkxRy?=
 =?us-ascii?Q?mFrzzjJukfKsM5/D7kGQITFT0A9uMQFEHGe5SHTmFutkuL+DTHNBaQj31nBq?=
 =?us-ascii?Q?g2qCYazplyCsUWfoOSHG47sKa1P4S0pqlDSyzQ+LiQ5qwQWh4MOEou48zZRp?=
 =?us-ascii?Q?5QjsAlMcz2VuoOsPs6G9Eb4hyRp2HyLHyIz42oDH25df2MSWSbdGxz3m1kn4?=
 =?us-ascii?Q?/PLFs4DXdaebe/eDHqKpzMVG6oHVmArLndJ+2YoIactzMgTkCuD+Hv9mkM8q?=
 =?us-ascii?Q?L6txVksG6g3owOES1rr3lbmadBL9guAOOyAW5BibA7PRxJy/byVQQnOJr5sk?=
 =?us-ascii?Q?4oaVFaBIt1CsO/7NQZmaMtKKy+i7kLJjcfx5FCtgZ/71yLArcjFxw5CwRYKd?=
 =?us-ascii?Q?bZvs0kBLWRT6/9IXoFS3ZvUhL7MTJCU4foLis0IUrdixvw5lEljLuy7cPjNh?=
 =?us-ascii?Q?TuLME8I5mjw52Xvl6XMEZnEDhLV1tv8cOzA89AtL+1gKkouSluvfCphkG6UO?=
 =?us-ascii?Q?PVog/9DmcefDlsKhn6TFvCHCZtmVNZaYIE5bCrTc+cym4k9+ZZ+G5N95t8mb?=
 =?us-ascii?Q?N6s7apBsPknWe9gt50ghXhIRKHZ7tt8AZCi9pEk2r6+ToB8dT5AXP5xUGB2t?=
 =?us-ascii?Q?5ItXKU4zq7wQesCNVJ7EfyO9sbw0/UawfrCSwEV29GBCStSML68rp2Iy9yjs?=
 =?us-ascii?Q?oC25/mVPXjIwHsMeT4E7+TUALefW1COf5sQSaI56nF1Og6DPX6nCKdyXTho0?=
 =?us-ascii?Q?ecdTFk8TlCPcxTXMiRCYZnZOoVHVf3gdCHOK6/T9tjjpe/ovmnbO4MigVlvx?=
 =?us-ascii?Q?6qS1IwcDhWxGBGtfN4FVb/5NQ4W7NfZOGINkQrQZjhbKunpH9/e4M6HxZv5S?=
 =?us-ascii?Q?1/9p9fqP0wYEp6TLkoSgJk2RwO5QLLoqmlAHK2JMViSROSH6Ny3Fxxe+ixEi?=
 =?us-ascii?Q?iCDFqK2wLce7g95Rlj2yodWafNMH81De9MFjD690RZnpCdjKZBIfakWBDy2n?=
 =?us-ascii?Q?nyngD/AmGGhfeMFDeu/6sFEy4SOhdcSAFxcFiKoTTdyIcX6H+79z/S4h9+Hv?=
 =?us-ascii?Q?rxD1mnpqBkH3s3AjRGeTc+yg0z6IUCH8J9bBArdnACgZUozjbhDO+GmqzbuT?=
 =?us-ascii?Q?QiocLzrynB3ISqfoyiOpu52LCs9bWt0Wd8sThhdBfgRlzYPB8G+7VWzfFgL0?=
 =?us-ascii?Q?f7NT0i70z78qJfBycZQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b83d60-0813-40c9-b023-08d9ba8b8cdd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:44:37.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbcSnYqw3wirKFCmq4VElQcO+cG8MUnTj6KwXafEq/lzNuPRwvamjkDywaSrqay8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 11:10:48AM +0200, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Currently, the driver stores the entire mlx5_ib_mr struct in the cache,
> although the only use of the cached MR is the mkey. Store only the mkey
> in the cache.
> 
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  21 ++---
>  drivers/infiniband/hw/mlx5/mr.c      | 135 +++++++++++++--------------
>  2 files changed, 71 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index d0224f468169..9b12e970ca01 100644
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -668,14 +668,6 @@ struct mlx5_ib_mr {

Shouldn't this delete cache_ent too?

Jason
