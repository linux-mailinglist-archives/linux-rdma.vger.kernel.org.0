Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364D27A85FD
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjITOBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjITOBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 10:01:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44DAD
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 07:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUpjHidcDI4GRayO9lLXJrsxM5JQt3sYDRZmgJlbBvB6NED2bqCSxqbmrqXoMu67aWw70Zxr6eVjhHLm/gVumPI5EkHXsiZ/etfdi0043QZfTDGfVoulp4NaVa3r4RzEWiT3X5bzoUF0B4gAjWEwM6lenjoOzDe9JB+gl5Vjuze2P4uyjvNO3WMoWiDXSais7yLp5Lp45mH5aslv8l3T330aSdsQCKwiUDATaSfHKuM8bD93M4xYtemTOtiD6BYK5ULZ+1XuW+ShiodGZY0GCyFFZ+WxuqXIeeaK7khJU/8X2eJxPZ1p5kgx7sMebN8UDcwSPjraeN0adL6yMUHStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvsnhjvdXc6WF+0qRLABb3Ork+WidZ2veWZXIXF1N7o=;
 b=GY4MgyaFzuOjgJngZqdP05Q3aclb8FaAhVRC271d6dMTESomyiPlrpuk8LNUTXsajVDqGyQ/PRR1OH8jNAmWA+N4SCDb+gbWIbdHoroGsMDmIw3KBe3qzPGUQhZZo8QZjVajLxmqH2qbvTX8eMZrz3EG26qFW62i5mIg23kx9rjqGGNsD031ggeav6mVb5OZA0hQY7s79bov82cG22iFbhMPwHaAErgb006YfxjU4DfSsSdOhwddzbIMppH6NIdlSa21nxAu0ujxpP9mtIjvlIhxU8cr0EZSqubnpIp9j4KQLa6Vpgf6Aq7ouzepHeXGDkLHBj/SGIrGHx91bd8MqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvsnhjvdXc6WF+0qRLABb3Ork+WidZ2veWZXIXF1N7o=;
 b=E3jfQPky1glSUYBDHVB0XszwgLWj9R4M4pmbpn+gGANFYxn9YOAi/pkbsaddhyysDtPylJQ8rud1Y9q+/zbQq+qEfMawh8PX7QCrJakStIlmPBetB4zWI1aDhYv6Wtcr1gkcv88jHMazjkZhskYcYWS+aRjp0vXJTPR7qoZ4G1g15KVlzt5/2Di48cMwqXev/OKlB2g83PFfXqsbautkbfKHcJLiSziffOzHpo/iQ5tJpr+On++tPb6l4gEB6axre/GjZ4xU7WqrxTG00zn/sFtKk5BNPWudc1AFNL6f3tM8IzrR8gnR5WeGHNQdWg5F2XXDgdSUr6wraZiQlYo/5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:01:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:01:15 +0000
Date:   Wed, 20 Sep 2023 11:01:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix mkey cache possible deadlock on
 cleanup
Message-ID: <20230920140112.GB13733@nvidia.com>
References: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0452d944a865b060709af71940dafc4aad8b89.1695203715.git.leon@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f1666c-db23-48f7-6e94-08dbb9e20e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FT4+7cDffQCBpW9URsQFhzh2W9stW3t3N9SUku3ajOTTVb2ojwW1LoaU1gy0c/0dQ6B/jdABW7agleVo6L9mpJdHdP14gopXkkaK+JXoeuDujbQHOZzOh12lE2Zlipoee/DElUnr7101gb9iRE5UcGRttj/n8BPFFqBf0mUNtqvbnGJrFmA+OgoN+7uZLJcQX/REw7P2lfyz41yYSBusk9sned+791yHUCMfgcsnXbJZd6y81w1+T+E1HEBIoxWL671LI4pdlBAFcs+PFGuKvS/Bz9o3/N9QgsJpoaI5DpJWD8YykRObcwB8EO9GmxQiA1CLKz8a8NdoMs6tgci/I+IkkB3Q+fXzzIlxeBG7e8iRZrPHWluzmPlxYnZXfQXu7Wd8OnBD7Bajk7xLcjBTaN2ow6vZCAUBHdhWJX5eA6/SCD1q60DBtNxBmEOiu0WJoedBMS3uxiRo0vXpviXc/jL3q0fnbKjv8/OxYffvTPMgy+3QXkrlL2M5uG8jJdIArwD9UHwZj8shyEcegJ/fmkiZubv5LRuFnGZMXwdVoy9CXXevEPFngRlUHNO+8dy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(33656002)(36756003)(83380400001)(5660300002)(6666004)(86362001)(41300700001)(8676002)(4326008)(8936002)(6486002)(6506007)(107886003)(26005)(1076003)(2616005)(6512007)(38100700002)(66946007)(478600001)(4744005)(2906002)(6916009)(66556008)(54906003)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MPsMYWhAhwNpQ9HwklaJvUGXtkaTovUMp5BKIwsXT+v0NDErV7Ca2btLHscU?=
 =?us-ascii?Q?rtP5+LwKZ7BOQ0mEIX75qtUxPoeEyWnLuo2jAdjmB3KMRKjPxt8a3HU2IosN?=
 =?us-ascii?Q?C+z/AiMS+/r59Vv7S3l2mN2q5+rRBLbRJAtD32qYho0m9LZNsEt7ymCrS+Qq?=
 =?us-ascii?Q?X0FLKruSKHKCtcDLOnzj3N60d5wLPKDpHDLTeDewr6iXVKtl69l7+NjTid/a?=
 =?us-ascii?Q?qG1O5OH2XZzbeSApGmHuZnMwPOIy/FNjrk1AJM2xbGaG+sytgeA5sb5w36Nq?=
 =?us-ascii?Q?cTJEfIP0VDUgKahdm+yDoRGCFCAVIT8lBzbkoY9xol2pjx3h4a+eg/imR5Ke?=
 =?us-ascii?Q?PBAb6ERxgvofYsjAKETOshOhHK6yrDQZcvIpQ+sg70aI0Yo7T205ii0CRDm6?=
 =?us-ascii?Q?UVwFLSwrjk4r0diFTHYXkoIfBBVvpnSMfOmBM03dTs3TVvgIKuODPHlToNIN?=
 =?us-ascii?Q?x9cwMX0AkaohHwm7yGYf8jYt6TaEY1DFInePkh5tOewmokm1cAQ6+6aarWhU?=
 =?us-ascii?Q?l0hh5TthZJeIZllEou/DY2OCQZEMDBO13gNKZaLdyz4eb09H9JmAZKC1Qed8?=
 =?us-ascii?Q?VeinSG/zUrZA7CzBIpy/8AudHLLfOQ1G/C77LiHn7SJ0QLrUYI4ElISNJg/P?=
 =?us-ascii?Q?O7KKMbmwkdEz4umPzfE36sR0lDuAGVb5m/bJbd1s4pnwlrFqENlBtB/804Ww?=
 =?us-ascii?Q?qJSFnlHYCvQcYwBsPQpq+1kM1luAyFpBF0oCMFDSH9/KFNjYBISW+Qln5akA?=
 =?us-ascii?Q?R0KYmb46iVFqCx8I4mNalcN9oEkR0h3t1zzy0M4j3WBNxPwWHkmgcCN2Frad?=
 =?us-ascii?Q?cJkjsfWypnbll9kI++1K9keWIdo2Tu5WR/L6K0yeboBs5+N5sC6Z6tfJPo8c?=
 =?us-ascii?Q?lXFEt2GZrndhZuoXz6a3RHsJit7LH1NndFiQbtV3mEAs7aNJ8oMQWs0PjKl/?=
 =?us-ascii?Q?VdFnovsG6R09K7z5R3MMSq8nWkVDoS0nz1LdZAXlmv8MQRJCFIN79MHkUsD0?=
 =?us-ascii?Q?QDfdafP2zWxQRGHoJ6IKkIRCOCBYfZPgW+k2fopSn1+3TtYXuHW/rCZw3VLl?=
 =?us-ascii?Q?PZVEZ9y136spF4mDg/jARHTK2S7JJhlCTrtzdvFn9QbF4LxbqlrtZWJckb5y?=
 =?us-ascii?Q?Nnj1Oj1GftljMmkKWNZ1mn0OHe7NaJ70t40BWDeV2HrX5Rj2nJzB3ze/i9P5?=
 =?us-ascii?Q?e66yQOvBcOIvWh+iWUUJwCwQHiU+8xXAY0mrM8MHtx6dH294wr9xm1mgaNW8?=
 =?us-ascii?Q?HQBVeWhqrd5eL+pJkezkOnuY7ZxSJESHAlC0OucXVi1GYwzEraq5gGavRUxM?=
 =?us-ascii?Q?ZCOVLtOOanMKrE+wWvYbgCO5uo3aEXfHMON27TCszm4/qcX5KHU1d7ciR6ey?=
 =?us-ascii?Q?H28heW5W/fxu6QGC4kDcIztprFqWUZzaE1eftoX4JzPxr40J1bm9tAMWaAfj?=
 =?us-ascii?Q?Kk/gqf6JuHF5G5h98u3WZi9dLYlb0RS8h1X0stp0FvDrqgGnpcVRBeECz+Aj?=
 =?us-ascii?Q?Rk9flRtcbH1ks7QDPEC+Z4VcJ19RClxhQ2FjoQpQdGn+Y4RTCxLGAhfhC57b?=
 =?us-ascii?Q?wEzl1a617oq+S1GgiWoDr9kJgjAvrQ3V/NgehafE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f1666c-db23-48f7-6e94-08dbb9e20e0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:01:15.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dr7PKNTxo8v8E7zMaOPPIby1N8BVGxIQYt5ht1Caw2v2nVWeFrLob93G+e6a7ZWy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 12:56:18PM +0300, Leon Romanovsky wrote:
> @@ -1796,6 +1804,10 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
>  	}
>  
>  	mutex_lock(&cache->rb_lock);
> +	if (cache->disable) {
> +		mutex_unlock(&cache->rb_lock);
> +		return 0;
> +	}


I don't get this.

Shouldn't we just initialize the ent->disabled to cache->disabled if
we happen to be creating a new ent?

Jason

