Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1253C59F027
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Aug 2022 02:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiHXAWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 20:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHXAWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 20:22:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1E4F18C
        for <linux-rdma@vger.kernel.org>; Tue, 23 Aug 2022 17:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euaVrb/5tY7Xu/5fT55FYNzN2LfDV8VgQWMcw1L2vfTXz2kzrTBNbM6z+s1PwQx4FIkyxuYj7zs9IkxqSHnAS1gYZk8rQHoRcJoKyFZkNhLeWiKIZ4YXtNu0O/AJFGVfHArdiTXqHXe0xpnuGs8f2e8VNW6kC37e/m6NgkDkZ8f0p11AuINkPB2aw547mf7517cTr+wq/XN5yITscUxBL4z+6cF1aAJYfrlZ7DGIXpfaHnQmOW9DVv66YzQfCyqc40DNuoAK/RTq6tAxdnapTKeoSFkGkvY+R63CFNtvPDqu7XQAuv98i91X8Q2voo07CoD8mbF7C81dKxOwsdbBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrXtjiK4RdDSXDbs7SMO6EhfEApddo/M5r0HXz8CY7I=;
 b=KwA3iBSBauHMfdQ9qQLaBiiF9Mv05jNIIAc279mKQdZfGEb1vU/dQqNquOeujj9GXi+yGeouKed4PUuCqYtMY0IC24Y7hi2vaMGCdiFzo6ofvmh58ZyxSn2RS1IM0O0THsI//JstgJe/GVmNfb0aeB53qqSjvbUUbsUuh3WG3vr/5L9vU68A+SMPjj4ZnziEW/r+uHxibjoNDV0d6i7K9aLd3ZTO6ppbzE2PqtAsDYiXt8dSK3Aw55dcg/AKafsnee/L0FdQGJr3TjWW74suqMNGWH3UC8EL9q+KaR6bhF7FseO0JIDq//JlRnM8AnUCIOZlnRE13zS64xxGPlWuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrXtjiK4RdDSXDbs7SMO6EhfEApddo/M5r0HXz8CY7I=;
 b=mhgqmLTK+6+2M/t9zm1ziG8RZ02RXoYbuhiho9oZ+KwwKTgFv86ktdE3nMLl62GKtmK7PM7dFhMFqVvxJRoo1RPi87CAIFmPV2AAs1OUocyEMWFu4oTCdLjJKKYE+/sZ9cd15r2P4H31G08CbaJVRYagWC71iLi3k73cEQXhBTX7DCS1lnSctxWu8luurgOOS1fiCr39SMwcVZBBNyshEuF7qqMX7vDx5klgSUXAy1+p8DYW6FUzxJESOrsD16kAhN5vqgS5Ok9lHzmmcoCEL9DYg7l5+tWxD+UI19bwYy1yHM9ycqpAvWP3bXROl16V+qD0ukMCWAl4K9SlnKZAuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 00:22:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 00:22:34 +0000
Date:   Tue, 23 Aug 2022 21:22:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc] IB/core: Fix a nested dead lock as part of ODP
 flow
Message-ID: <20220824002232.GD4090@nvidia.com>
References: <74d93541ea533ef7daec6f126deb1072500aeb16.1661251841.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d93541ea533ef7daec6f126deb1072500aeb16.1661251841.git.leonro@nvidia.com>
X-ClientProxiedBy: YQBPR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfa8b63b-21c8-4213-2ada-08da8566bdcb
X-MS-TrafficTypeDiagnostic: PH7PR12MB6561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zen5gr5HZ1C/cOPwR2qW1+oNNOItkkwtYgQilJChSkNqK5tcDQlNrD0w/70Ujna9DqP0iTHb5FJ5kNySonnscGnANHcslDfTtIaqIke3zjDPlKxjOCxn3Yx+WVCaWDnbuu4+dlnp+6JKY1RTyHZHarkhs3oaVf+t98BghqtVp7mM12Vf+nsI0lIs6zM83ikyeCqJ4JQN9WSkc4b/gLvnEiN+NjgRb+mXZ8W9i0MCP7Xa/lHk9IJi3W54HhuJ+CNnd8YGtYsXhbmv/Rav7v2QEp5X/gbyHc1r3A+eoZeQ7lHL1S52Zm/ouMIpRLIywbwzhcZniwytXuZblm2ONiAvhHFih+AZ48Xra6osYQ/IO/QjwOA74xU3ygM5k4+J0SU/H9izlcmItpZ3IM0XdJ6aN21pgQ6yRGpaHjGJQmNGLNYAUmyNZ8lptZmsndhm0XE2Hs8Hr/xOKYuzSnndn+hqqP00Y9l0sHLJZzTVRwKVcQJnYnffO5cjkc+V3bNJlNTGez7pHJAkm+c6uSjRkejBM0yExtpR09N0Npm5cuvnRFQSUxGj+4I4LtcsLQwalVhTOwC186rX4qXdyoRTM7JVJt51bZMEIjfFgFIQmQiDHRy4btxeyj9BKkc5Rb+qUK+//87QRcdaWxeAa5iS/HG6HYB87uhDaotFW8S6uGwdKz+Zq2uZ7P1dadILY56YU8vlSecgI31p+J7tuOzNjcnQbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(41300700001)(107886003)(6506007)(36756003)(33656002)(86362001)(26005)(6512007)(2616005)(478600001)(186003)(1076003)(6486002)(316002)(66946007)(66476007)(4744005)(6916009)(66556008)(54906003)(38100700002)(4326008)(5660300002)(8676002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxVc0saZb9siPsSHlLXcRJL1xv6rVSpgYTsy40L+9QWbW9RAkeYFoxrcU2xC?=
 =?us-ascii?Q?ybHESEniDP4vH6FicNZaCYgAwrz8XpJBosEr4v0VlOdwlaoYp//rZ0HFV/zW?=
 =?us-ascii?Q?qYfdrKggwYSHNSktSACS5ygKj2gh3j8hqPwH/SDWUJ1n2YQaug0Cb4VqdtOa?=
 =?us-ascii?Q?4+LeCoKLU9zkVC2+iYACzg4LNUuci7wjV2/PbQidGvGKVrpvVZ/d8h1edJdl?=
 =?us-ascii?Q?OV+r0g/y3xN8y9sEnZDexC1gwyYXMEhq7ER5p6UMfFlz8ohbjPHuCYkQCWYh?=
 =?us-ascii?Q?jLHfPiHMysPxmz2APvdKUcLUwScGe1BZ/j0ciFpih4/kFLid/M3tOyynBCVU?=
 =?us-ascii?Q?6mNnWITVx0K1rVHcwSrWvjLqPPhAYIqPZEygSf1JE0i3aRX05/HMZL/+X/22?=
 =?us-ascii?Q?amQ+ro31yQQVkahLFfK/OYUEG1s9MCruljhXDrJLoea49THWq6C8Z+AFoQOg?=
 =?us-ascii?Q?Wjb8P8q8r+WV7ZewWtIqsEitSX6fSsMMJa1u22Xr5JkBXc5QvrSbXdnf9Mr4?=
 =?us-ascii?Q?0+jRdunQaRP/+sgPywrGwa9jV26XGvJjpWRG7iyMkYpHZyH5yRa2Ouwvxybp?=
 =?us-ascii?Q?Q3+CDt1vuJWkYdAMLKHu+ZS6a3XXw9rQstPY/eMKafmomHTmRBCLpctNO/Fq?=
 =?us-ascii?Q?Ej2anu3Bqk4mcBwDclTODwmyIE0vqMYRzy9CNSxmoNnyaaY4ChF8ul4zi7Ao?=
 =?us-ascii?Q?UKv8Qf+u+Kien8Znrd8c/1OmdFaLdXIOSw0+/BzP/Q9OYnt2VjuaJijXy9Op?=
 =?us-ascii?Q?RWGTgy42uq4d7UNG693Z/f9PrPkIjxJv8MPr6XCJ2oyLlts6PXyMci54/CxV?=
 =?us-ascii?Q?7KREtPDJY97yPCPY4B8rASVydFf2Pm1YpehKbcKRdFVAHqk9mi71E76zgEh/?=
 =?us-ascii?Q?tEvRsm0RGvitwaDQnVlCZG0MzUPduKVvF4YiLYMyc1xXd+ZK5kT3KnQLFL25?=
 =?us-ascii?Q?LbP4RAAyS2ynRE6VfMcBCVyr3pKGUqKoAdUTmtmF5rwa6vMTtycYi9Pboow9?=
 =?us-ascii?Q?ozDfsoGyswdmT2/dHos4RFfYr+ZLv7w1Fl+JGmSrpZLnC4Du6ON24wcf9auo?=
 =?us-ascii?Q?zdoAJtUlQ2tz9s9o9Tufwe9bFnBiSyza9UuCzXHNTIyGC1BVufTxHvZEaAqB?=
 =?us-ascii?Q?6So+c12Vd6YEiFXaUU2VKMH8dyCxhyki1KBTlYOUPobcSFrGjVE2iOgq5TZ+?=
 =?us-ascii?Q?163b+1JjrvVXDshk8wozBlMtV6C7nPv1qUkgNg3GfM6aMvWFel5Th7FOy9PI?=
 =?us-ascii?Q?5H8/sgyLx8eHCczRv2ODiW5KZXBSP/5my0kss/F3K5E3yiDW8HXrpDT58uT9?=
 =?us-ascii?Q?UvQoQj9JSPTT7PNxQi8z4PgRbGn+/EDEwSmPCBprQh6qAac5zqKh7kuh7v8C?=
 =?us-ascii?Q?40OcHglWUestp/Yhb7IZNJkLFFQtZN9ZNa8U4mEfprr4SK2pVvWF6UkJRYXv?=
 =?us-ascii?Q?vv3OCuLpWVfpHU5x64N2QSiXLWR0Cz8a/ZU8DXEPFPm3RFsCtYho5pi/a+tw?=
 =?us-ascii?Q?sAIQQ8F4zApQ44EcynSSgo1KKr+iA0AdH1ZwwGDygHiKf0o/h7G7ki0D/KgJ?=
 =?us-ascii?Q?/yv4SP8+7cCs9pZoTA53087jF+uGi0Z+pPJXE6Qc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa8b63b-21c8-4213-2ada-08da8566bdcb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 00:22:34.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYUeVLXma2ZlsS86qvdEEqmoSyRZemqM/0OUpv3Ilt/4TVR4SnqwUnaVyRYI1yln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 23, 2022 at 01:51:02PM +0300, Leon Romanovsky wrote:

> index 90c85b17bf69..8a9e92068b15 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1225,6 +1225,7 @@ void mmput_async(struct mm_struct *mm)
>  		schedule_work(&mm->async_put_work);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(mmput_async);
>  #endif

This needs to be cc'd to more lists

Jason
