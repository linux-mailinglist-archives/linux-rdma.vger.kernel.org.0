Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824EB3C6271
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhGLSOC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 14:14:02 -0400
Received: from mail-mw2nam12on2047.outbound.protection.outlook.com ([40.107.244.47]:24289
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhGLSOB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 14:14:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC5mc1chLm0lppY0w+ha7fqBPWEhpAj1WRRowRpVTJLwHkQg4A9oRo49U7aeXw+l9xLN5BrAMWQIJgFIhJ4rUdCcwl9Cdt5eZ9KJ/vLcPo/oDK8LeaJsRjZ8Hw3QBykfKvp+jDFPPWujnUxaVkb2Fw9QwaOyLPpBU3KCkpEZrp45Rw2SkqgKgomJYhnIqV4uGJjBeJYOSM64cAk1DOZHsKQHG6ROZD1qwRtXF3VzzM4wXZ4jW2zqOYMNIe0iprE/aPuuspJ/kTs4LEjP0bugSubBTdke5nm9TlXj1FQJhK57WGGl00BJPhuaVLPH1unfnhTqshirZ0d8kJKIs+o1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpLx5Yd9rbGIvSGG5HKHcESAbHuk1tBlu+F/YwuLMRk=;
 b=FPG6gTXJ6U3Pxy7hWLwXxZIlJOQ+l7w9KUJFsz7eqcy7Rvho1dymGFwam4vvtmIyPfRfTaweB46q2jM+ked+KD2CT/JoGUOVVgOXmkId42wfj9S6QAGAGYYoFn2Ygy6beK3KmyiT9HKsYCNNxf1Mmr2oaIDeelApOt5Cp03CGUV0JS8MqK85m8ZTAwVBCG7QVs6/Ag3WXzp+9rutMUHPlSkD4gy6Ekh06YOAWpBEvWN7+X5jbAjFDd1II/mTv+EsgjUzZy5HxnHQpHq6zbXCKK5yQ0h1p/PcDvsE0z9/h+MMWkoKCQ735IFrMx/p0I0pmiv/ctP3WxhVHZj2ii+HDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpLx5Yd9rbGIvSGG5HKHcESAbHuk1tBlu+F/YwuLMRk=;
 b=E2/DWbbYS9Ss6oab3BmCZHehrypeHuLX2lI14mEySKXv/xA1wQz979fnmpTCXhoOpVG95emo/533zPNhn6A8CPTq44u5Fktx4ni/vXMC/Ki3rHewvjFepw/dY4K7aIyHuaHCIyY1dyG3Jffg1KUYLqRl8HYJd8nZI8mFEB2FhQe/2uQspYh4YEJrJvPsIwcHLNrCjT+ABtadnVdJQDNLOAzZtd4G749SB9YtsXRKnWmTZCTWwPFQBR3NzLZlwa98yrknHcGs7yJi4BENcAJ08gJhHmRjeoBgudu8E9QYLc9wY1GcjwWiREre4ElCNttrhJRs5r6+nE2JGQASpIgwCA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Mon, 12 Jul
 2021 18:11:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 18:11:10 +0000
Date:   Mon, 12 Jul 2021 15:11:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH rdma-next] irdma: Fix unused variable total_size warning
Message-ID: <20210712181108.GB266283@nvidia.com>
References: <20210707211455.2076-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707211455.2076-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 18:11:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m30Oa-0017Na-IY; Mon, 12 Jul 2021 15:11:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5c41d78-cd2c-4d82-3e83-08d945606d77
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB553881BD2A3269B3ECCBEE9BC2159@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJijV9+VcvoIDalsQfJzxw1LJVisuo+ur3rxcK8AcZT6eBjtizprrmslSatMsKyebghCcEriVaKLCfKaU4Tg/BPQxQ1h8dWSvE4S/rYEvZY74bKqhKlOGzJPlqja43jZ78jQN9h+d1qg0eiTxLNuS6PA1C5i1h58kAWoYrHPCq1SYzbNZLk/1ahGAPUqTZsVkM1MlAda28g1mfGOda/Wy4y4uclFNA2uiMtcleYeQIAfLW6obVzFEiCTSiBOYfo3CiiZM2dS/fxaOHmzpvR21lO2axWYKrN/8AP/rAm0glTB2lOjbTAk6zdgqtoqaLaxY0odK8gJ9bxMslyCPyd6TFGDsL7Kzs8LwK71SRe2clN4LfjyFuoVCyo2ZDDTZxOBRpaSIFUw5+LrgAtFCJdkqp4tSKUleDhL8pOP7Kwq+4ooAB/BNPQ8xpIi2XucKcZIL7ZqsQoSa/5rg8EwI8/2I1TjwCKXyMTIvEZLzmYE1XbrQSVQ4uzb6h5huNeMtauVJwTupLqa2qe89tUeAKoLS7tZ9LaMVrCBh2DLrzn1WiCs9qgucWVoUlmu6jlSFxThuMeSf56qFQmXkWnJX81EV1ljCP8OX7XqvXHxKq+r2A9lpDs0qTDehnbGjO85zmTomtPDIE8AM0BQr14aG97IEl3vX9gS/fsFMTx3PW6q+7emE3caPLFEs8Di0hcm57o5IUH33moCGSOyceTXB5fq1jBQqo6YxPdbSnamAuJfVUapHCWLAnxhmxyNnIgURa6u/zMIdqQX6cmuR4YJG9iPXWTgAQn2t5ejm0XEjqNXEaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(86362001)(83380400001)(26005)(66946007)(66556008)(66476007)(4744005)(426003)(186003)(2906002)(2616005)(966005)(4326008)(1076003)(5660300002)(8676002)(9746002)(6916009)(9786002)(478600001)(36756003)(33656002)(8936002)(316002)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmxuOF9rLbKSxt4uvZse6gJBb8cr04ythmAY4Yngl2diqnb6HQIuMTTLYD8a?=
 =?us-ascii?Q?Uao1w5kuUyERM4nSqCLAs0NcQ1TSb3Q7g3nsfh1zD0e9/Qp/3qOPPDe5WVXy?=
 =?us-ascii?Q?tgX4mtrSHrz900yuWIk7sOzyrnjGhM7/haERv7oL7PON2qrHrqQfgi0tz2LW?=
 =?us-ascii?Q?WRb3DRGGZhR7uyothchw6GkDnSqHwauDg8Kr/OQvSaeTmbXlk90xekTlc4Bx?=
 =?us-ascii?Q?busUkpPJgE2dI1adpQPQ7gwDcn4ffX5VsXJR6xFgrdjBzOM4BlrvtApyaNrE?=
 =?us-ascii?Q?W0YwWVmWmVsjj3Ot1NxXkkmEO98G6tpVtLTlNs9GFVfTSMFLCPq1EGjz5Dqc?=
 =?us-ascii?Q?OLaGs+kmkA/MRfnCU6eKf88R1xDesulg+z3MT7n64YiZL8IcVmg92ZMQ1kSE?=
 =?us-ascii?Q?Z4pXub62W4s/LIwnUOK4/2jUyMSs8QQkXLo+wwB9gp3hsqmL45PcquES5CJR?=
 =?us-ascii?Q?GHcJ/odqGTkGj5h8ofq1efltn2I0E84nWGjkY7mVD/tylFP5qDBS0Gb5dF+B?=
 =?us-ascii?Q?t/QCd54xRo/+oqkxplUrRsWjJ43Cjoi2BU3cAIsVoLAeB5cBjAK4265nodrL?=
 =?us-ascii?Q?dQZ8hiLRisWRFuOEVBc0DnR41re5BBb9qNN9CYQIX8fMUCOm0I4K3C83KQbX?=
 =?us-ascii?Q?6YBJBGtOK2JpDTucysZPAcdbbY/18ViL4FcsUXW1hmcUz4CoRZJirQwx2g63?=
 =?us-ascii?Q?RhEh0EHcItnQ81HsvtnzOGdx6qLbnT+qshVZo1YHFT29si7Y+rLrxfJLiCbz?=
 =?us-ascii?Q?Z6Ouk4jsCpYdDUVQn8d5xfhWcMyVrprg1ovCJGRdMNxaqXK0X05YXnFpp+9t?=
 =?us-ascii?Q?qJbX736RdpBVs4ZYLLFYerFWCqAyn8DZKsrczQEc7BByhcUOxQ/7F3X5nsYI?=
 =?us-ascii?Q?8xNhgKG4dZ9czs9vs9Q4MgqTC5Fx7l9CW+E+JBLtXrOo0x0QCOzr8l1Oa/BE?=
 =?us-ascii?Q?qcVCoW9CO/mUZkr26OmC2P+v09/uVc6S+t1qoFSgNRqxMPm4pnenNwwvCLMd?=
 =?us-ascii?Q?B3pAg5dhZBI9ZRSlIvbwWtEGLTok61Ulw0/8NHGwK5d8AIA+h6GHGS2EMZsM?=
 =?us-ascii?Q?BoEiSLipnwc6kxxn9s/gDZD01N1xidslmMOO5COqcb5Mc2Ma8uKKNge86aut?=
 =?us-ascii?Q?LYXC4iIq/CJRyYU1VStuk3S9KdlZCwOVQ8S4e9XCrCzEEAFx3gh+Q7Cnz0qs?=
 =?us-ascii?Q?XpgEdAQ2iICRg7/OAsNzhGM3dGqQuxtzd1ivtb14HYEG5T83ISklteLMLLmh?=
 =?us-ascii?Q?a6WVZCMhk/RFMqC5VCk9VKxmWr0dwQFmtRr0nAaMkB41L3c+g7GwNrAMO8jw?=
 =?us-ascii?Q?OgbRWnBiGpcNJN67L4NprA3/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c41d78-cd2c-4d82-3e83-08d945606d77
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 18:11:10.8500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObejXkBaGq20MLKRwzquOKWluS2yIBoZVmzilK3hUX+C+c83iD19a24IGPSGv77h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 07, 2021 at 02:14:55PM -0700, Tatyana Nikolova wrote:
> Fix the following unused variable warning:
> >> drivers/infiniband/hw/irdma/uk.c:934:6: warning: variable 'total_size'
> set but not used [-Wunused-but-set-variable]
>            u32 total_size = 0, wqe_idx, i, byte_off;
> 
> Link: https://lkml.org/lkml/2021/7/1/726
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/irdma/uk.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
