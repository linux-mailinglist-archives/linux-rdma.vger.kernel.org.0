Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1B5EAF68
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 20:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIZSQM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIZSPt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 14:15:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365C214088;
        Mon, 26 Sep 2022 11:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsKRXh8nrzbExYTwri2VRc5twcUwJAoHKASIJqIfbBktJ3s9pPt7uUqZLQNe8x0R4zkIJu4lowTsmYACO9TaT1pxuNo31uSK8jSH4SPQyqkgfm4CEbRax9BOn3CQMR9/59UjQ/+KqVF8nBWd5g+dVrCgZihqj61Hpd5PBMzM+TGbESq6FWX0NY9SX8JcOftF9/ssou/mgACV5GAED6C008wPJic8+8ELJ4KQT/Qqq8aNKIBa/QfEZy2Tkizaa5oTU7xckL73ZKOxsOgt9rBQwRX9ATh8qxwynnsnkiUNt68487IMLQG/GloLLE+GNeGUYGRlOxOSu1UEGobT2F7fLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Urqqy8QarMKdi+DHIPdgLXSUkb9ZKE+qojIcjhG4yg=;
 b=VEvgGlRjB/ChBPm6WLqJ2WUUlxFH4o71t5j4PleJFh5pOlAL+9IJrXgSe7ptjL+SwNh+/Gzj3BvZK20x+LbFm/7u9GDUbT/iahQQBUZ0O4LYQKsOZ2/F9rgJFj07v026dEWeStqOAZb3+QkITlby2LSTc1cG2QF4A+NjG6t9jO8pNP6U6fL+NMUSP5E+QbAUUVnAqdb22KJxvojui3y9NRVpDxItBQLsWKTOZDSLvryBB11Paz2vtBSbnCcSnzB4Bexm/WsATWoTvN+12mrGn648OgpJ8vmmzYC6lYy1YKnTBML6ZiPqDJJlriGJmlcvCmfsZGMfJSyLRoJ+1kmbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Urqqy8QarMKdi+DHIPdgLXSUkb9ZKE+qojIcjhG4yg=;
 b=fNC0ahdRU769fo1PTWToxLlwtuVRsa081XGhEh4Ozf4Xekouaf+r5yikchHNUTrE61A0iyo4UO3MBoLcMUuZr6mZ/sD/lK5zNTNu4ObYmw/UIJMfRK2yMvP4OhxktIRK1mVv6EuRSmni39Q+YEp37HtJPNu1uUG0T1YacE9FguzeJakPCXPg+tuVWMMdu6NlhTH7RWfzCSq9VWwlMOeu217/sEeBm9hZ+jKMuOkLWXBrqsWe7E4MYMS7BKKiMiHmHQ1PmgH9HIxdB3d6v1NbsRvgraEFzxRnv745pZAfKyLcr3vIGTuyguPO3C5m1buuXQmSjdaxa5exxm9/KI9GuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 18:05:45 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 18:05:45 +0000
Date:   Mon, 26 Sep 2022 15:05:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: Add __init/__exit annotations to module
 init/exit funcs
Message-ID: <YzHp98LRi5bwHMGM@nvidia.com>
References: <20220924091457.52446-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924091457.52446-1-xiujianfeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 797b695d-7e2d-4157-1733-08da9fe9bba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxi3eioE6XhPEdPBt2if+eRZvZG2FlOtF1wvT8l6Osb3jKYUbpDGPUh5Te14MlRRlnOq06hsETJo6PMzv8/QQRt9bnAeLS5RNlAI5ptj9mkgtwoOVl4Nt7PxnGwJXyfO1VGUMSXhjWCNODfPJnTYFfdBPLFTCh+ijprURAEdnGBOX2TDLlAvVcfYHPDhhfgiMAZnl/DMnKNbBFUliRV7KjmRcW9jymAjEFVoNlAxiKyg1B3PKshWS1QIKbvBC7lDy3A2Pt8pOWzkVoKI5nq7amwgqSP96ZlpGRJlD13ktu++naFDcVq9MCRoScsXry/gTOoQ0KBv32EX7y2/HYBN37qWO38zVuarmWIj4BhCvdiysUD9BBGcyg99W7lvnmTQ41lYKbquqIZiGbNgCIYemzgRCC2GHkXLpIXFKz0fiEOxXu8DNNhdiOc5ayct0anMbPYxarvejKPITtjGtfjuKas5eguAxyvGiVVvBxdIhkpvRA3ZGjTxc2uMDLk0gBrI5ClCDeU6vw4ngDP0UZErYlyT9OvhkBXwOjtj7XGgcwrssgdoTNZKVZrLzZN29wm1putv/I+/bhF37ffQesIHBekic1stCZPcime7xeC7PkRd2/80yEy5fOCLKfh4P10VMyWKeo2IZzUdGARQwcYgBO3TQjpFgYA0mZQ+eS3J5UBI2682Nk+g2AKo3V1MS5c2ThSXqNJsBgprMyQja8+dTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(36756003)(5660300002)(4744005)(2906002)(8936002)(41300700001)(66556008)(38100700002)(66946007)(4326008)(8676002)(478600001)(6916009)(316002)(6486002)(66476007)(186003)(2616005)(86362001)(83380400001)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xyPu20+WyUtEC+yTt/Li6ii4B7zWBDddsgVgrSlTjKqZaX97RqyPn3gOJKOx?=
 =?us-ascii?Q?mwm+tkeLNgDYZeBTcmnl95Ytu0p9OBzGFRIeVWPGX7SY73E8xjbmMgNi3oX0?=
 =?us-ascii?Q?3JpHei6I0ehPiSuzUYX8dWRLRh7MBH8/P6RdfV409WxoeFzlVrv+dzlhdsJC?=
 =?us-ascii?Q?MLaC4rxWcLlld7yVf8BR4nKjiu1LYVeZxw1tglt/UQS0X6AirxCDs5jKw3Fk?=
 =?us-ascii?Q?UE5t+Wrnr7DPSWcbdkla9OFiWEwDMiuR30DU2yKAwIm0eP51EaXBcZGSU2dA?=
 =?us-ascii?Q?bGZfB1Y01QGUJ7LsUXOfm6Z+qy6Jt17BDt4pWkI0ebmeXxovUo8z1HZ+WSRl?=
 =?us-ascii?Q?ascEA71qZmLopykqfQMyTmgb340a9waA7B0e/GX/+tgFji265RzM0sA1gTkM?=
 =?us-ascii?Q?j7kJFTuA9nIpKHUuq7WL4MzH3klSkJ9c9Sbpiwfjr34PpOsamEDf7jsobAia?=
 =?us-ascii?Q?ccP6kZ+uU0W7WaikeeJ/VQyTsNBAsukVU9SaPOMQv3JiYn6hmMEaYHFcacZ4?=
 =?us-ascii?Q?UFhSdxbHLwN+s3I7h+VBykhQyxe+K8ZPT3Jslua+HnfbBUtGtu9Rs0tlYLDr?=
 =?us-ascii?Q?n4zUQh5oI+riZqR3Npf0wVNwQuYIdU4JKoeXegMlfJP9HTIsVVdXq3uGM4Xl?=
 =?us-ascii?Q?8W+QeOMNo+Il69F2tjBLU4TOGBwzFixZMo9OV2RFIEuMAAE6ky4MH0t80lws?=
 =?us-ascii?Q?DRrbxDHdaY1NcDxFoZKkypmrh2FPRSKx0XCZk+5tUKku3WFLj2qLPIMZ9Ift?=
 =?us-ascii?Q?TsGsCHLmd4j//CKIoLWp6x9f9cDOGXF8Mg3gwh9afqCvWuDuKSz+jA3/DAhw?=
 =?us-ascii?Q?CycM26/FPeeQHKLbb3SijOyZyivZZXZKW7xdAHZ8QN56INgptWVAg6lw7JnL?=
 =?us-ascii?Q?X7csGr7ScamqAc+nP4yNlYLb0mJrg2R90la4tDgwa79un7eVgmTDrrQPS0AI?=
 =?us-ascii?Q?L97qvTPJgFa7O0A5J+tyQPD5CAXlavV/8NHsffwEK+XE48MC+TvKWL6s3Klu?=
 =?us-ascii?Q?AA5j28miUYf27dJwOccp+Fy1ISXpLc7E9RneeFWoxTEnekkaOiInlY/ZAxWR?=
 =?us-ascii?Q?AyERkvhHnIhJXgimiFnTxq5YFsmPtC1cYGHhr5tf01XphnJz8+LgI1Z03mNq?=
 =?us-ascii?Q?aYZbYWv6woQrY3n8cRxc9+BbDlZaD7qaob9im6p5pZjTBEb8Qd2irUfBOlZ/?=
 =?us-ascii?Q?qEp/S2Wrk55nH2sjwP8oIwdZeRfwdiOPe34Si2yuTLUdEgbwReggsZz9DAC+?=
 =?us-ascii?Q?EvDCa7VDV64L72MqeWwp4vdLas9et2hV8t/+Y+jW9g0LECag2v3rq0y8wy8A?=
 =?us-ascii?Q?hA5+/7IoketrD8M3Zh23Mh5UY/+E1BrSu8nVCDn6+2APaCVkvtMsVETVFo92?=
 =?us-ascii?Q?u5tBudQwP7qP/9aah6PlCPOhackaUr8vCHg2JwgL6kuGQMNTdFWYYz8u8ytw?=
 =?us-ascii?Q?JECgp8b3o8Gk5ERTo3U+e2i0SlOTVNmACkajJ5jPNun26G3HpkYplrbpaBTN?=
 =?us-ascii?Q?aMu9ODR9IpucOzdWZnifzMu96bXXaQkX0EIUz54RrPDEQaCY5x1lZ3avBHvI?=
 =?us-ascii?Q?fiYilFu3gcl7kqk/RyQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797b695d-7e2d-4157-1733-08da9fe9bba7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 18:05:45.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4ILMhFwY/TP8A0FFos+NiprjdSLmXmd9nlogiFHzjMlDvTP37soYWDZjb4sr+Kb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 24, 2022 at 05:14:57PM +0800, Xiu Jianfeng wrote:
> Add missing __init/__exit annotations to module init/exit funcs.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  drivers/infiniband/sw/rdmavt/vt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
