Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7352EE26
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiETO1I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiETO0x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 10:26:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6413D5B
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 07:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwEUDnser4DeooHNmYYTlo5i9ODThN+zgCJaKFwdi/7vvTEP9m2+ZyUxX1Ks/UYbAHh8pXPziKgZmNph6VH2+TwbkJIA4msU10LAHWCeQasy/BfdkbeC0U1jt/a9Mxz8nExf0Zf8vJ59eUGp9UlPLlMvunpm5zr9s83KkA9EXTUM537o7FqGseAgJ8m1Cy03wrLuOasDjrcb2hAY/GGdtm6fBMcLaY/T/C/nM9+nw5cUR/1dHATMC573IPQ2jh29bbtfbJiy1xfNZPj/mkiR6N6VXC/NT7DXnBOJ63+q7x15Isc4rC/yoWZ8X1toAkVpLrMvmly6IESWzJvMyiZ7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNfHrBQRZhOKrlmRkhCK3k4oQ9dBbBXKmI5DIxQmWEI=;
 b=E6xtgNtWksUZMD2EgLc4SfqyJqajyDMY0uAMhxV3A21EDXBle0zikTJbUKUz6SXyTMXoGM+8KoSvmcHqJDuCEVQp9tkLQo6ZxueMvEsAVSE3LaQ1A8GJKiLhGOlXymz14IQTLTknm2D5y9jmDBRE2YegILxD+1ay5uRn3rf5mutI76u6YfuE8fOiPaVNCWX9IKM9ceDHUozMyaTLYGcQOqNGh+KhYCwChx40+lH754Dbm98iuz/JPmdnMXSrQkJjRBu5Gb4aQDsY3Bhlr05VtaRuCrhv/MyrOhjfMQi5YY6zIFJAn8Taa2L36LftJVhJX/05CHrJZGESi1R+7AIXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNfHrBQRZhOKrlmRkhCK3k4oQ9dBbBXKmI5DIxQmWEI=;
 b=S0b1L5PPeTckRzZ1FjmsNxSIXkTvl3R+D3OHbH49vYAp9Czy0UbazGtILsN8Yup4goBBH48noxNNj8U7UJ7Z9h57ow7DPSNIfJQ4XtUNCR1LWNlFqGW9teNE0C68bu4U3qQn7/X3D7XaCuJh7wFb+xGphNG9M/OrVART4FWiTWGurCdvKng4JwbUiq764jS6mCWmdorwZZqwgioaaAsJsr7amU6aiGuelP+/W06EKcXufzLqd83Cg3GJuTrs1oPUeos5pS7K0h/WHsJIh6V7ubdBQt6O6Aa6e6K9eokGH6jdRWLVLsQGaT/4IBcXCzPx/2Q7TK4ccuvZ5ZQ5z9I1wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 14:26:49 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 14:26:49 +0000
Date:   Fri, 20 May 2022 11:26:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx4: Avoid flush_scheduled_work() usage
Message-ID: <20220520142648.GA2301949@nvidia.com>
References: <22f7183b-cc16-5a34-e879-7605f5efc6e6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f7183b-cc16-5a34-e879-7605f5efc6e6@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: BL1PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb166b2-47a7-43c6-2c23-08da3a6cc6f5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4133:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41338BD149EA355DF8E36568C2D39@CH2PR12MB4133.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxnvhd36fUL6pfoq7+7RYrXkVxK0RpMWNS7Hzyw0t3v7YB1d7a4meejs9/u4TRQFUzu7aXVTjhAkWxBfeCgBSKhH4WCO5GjIuFCcsTkHD3j9l7h7hoBbD9Ozraj8iDc/o+v7LVocJge+eElg3H2CvM0PjZcXTtLqELUIzumgSbykZZNuLdkBemYqpq2j/2+89ZZLXy8fk6hbVsygVzN4VqQLCqV03pMKJ7yD8CFncQNsPJcy+tZjJ6Ots369cMp1vww+m+7JYCaoFKJbiyTI99Ipo6lYa3JjBPVgSKmtlNBbTeQs2OeVxI0NepP5EK1v+KgayBuJ3QcxjVAQ4OKoSaQJqoIsQriBPmd+bz9p8NQHPTs7g05LoyV/rwaQdy/m6iLZYjcS/OTycKKzAc3tx6v1/s7UowynDKgaY38KoHISgaGhiRQnnm0AdIZ6/GuogJJKxyGmYMhO7NlrBCEfkdm49F10/H6yGE5zie/hJCwJs1vKbUiIVvCvJsM4Pc6xRkeJH9Eaa03HbWESuUpm3/tYcO2kfVGph9OzSlR3ws9Bh8YfMd8M+VeSa1AQM3VEDgsQHP4IG3SnBVM7umpbZAyrl6h8QDSgQdOpgkNfY13b3RtDk7itk6OKnznv3rHQOL8c86+wu39BlF7+fVym1zvudAUDWDL0MuUV12N+qP7MYh18aW8rG6ube+js7xm3Rav5iK5ndYCXeQ2a13sNRbSknVk6vym4umoNTh1h3eI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(1076003)(6512007)(8936002)(66556008)(66476007)(186003)(36756003)(5660300002)(6506007)(26005)(4326008)(8676002)(66946007)(4744005)(54906003)(6916009)(316002)(33656002)(2906002)(508600001)(83380400001)(6486002)(966005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14gfHewi66cygxtsfOJfF7Nx1oo0LhWxq4NQYGMvCodg4QA1DjHYSB5E40yl?=
 =?us-ascii?Q?o6N96RPzvnw59/7wxFjdkGGOWfxdkBJx82ydr5E867Rpwtq9EgEi5RSFKx+g?=
 =?us-ascii?Q?ckSggrXj1eUQC0itrf+QEYbPGfAiplOX4d3f67qZuZjJV7cE0USQhryVM7rK?=
 =?us-ascii?Q?nTBFbfTFd2gyaVmZnRRFYX2E6RvrS0obq8U3CsCY0hKs0SMocQdscnAtOsfQ?=
 =?us-ascii?Q?yFLhTKsLLe+jATrVXLIYJW9t6LYcekRUHsGuGtrzTeZvrNAf7rMYZ0jqtsAY?=
 =?us-ascii?Q?QTyfoPY8N3N77qpIWupOdbjpzxY3NF8+lIow8UfHWFEgaHnp4u5kv3fJzVPx?=
 =?us-ascii?Q?X/ZQtkMhhE9gc+S2zxhrH4YXONGIp4F1/y0KFqFU0I2tcwi2zg9v9xFECSs5?=
 =?us-ascii?Q?dF9hbIBdg/TNQftG0dK9tyOkMh/NE46KyXGoDxZeKusgew01+jbLyKu6ZnOc?=
 =?us-ascii?Q?MKdiJXpwAfzTPViAZPS31DCOZ7guqmrrG1jg2vziDU9j9qhnJCVlaWzfHET0?=
 =?us-ascii?Q?Qf7c/vYie8pR2MN0/TjfdQwlgcvvIwdrx617a8hshAIj//XbPwfop4Ch6aK1?=
 =?us-ascii?Q?D8AxUB1gSFgsGgzjGRuZIDyn1c7O2emyTg/uPisX1TrzFQXqwI1Mz4ts5P4h?=
 =?us-ascii?Q?2WpkuIBEMKss+LEpaqnvFt0ApjqlWOeK3uweD6dw399DSJv+K2DPy5OIBTrZ?=
 =?us-ascii?Q?Ezd1R7y51Nh4VwauBtpIn1+6AicHoZZwYur8X5q6RFtiy3rB4h5DT0hSRy8/?=
 =?us-ascii?Q?tMftUvwVQJUDKO4arzfmtsXQAOWApx0Q6Jm/so0CKYhCrReRJlHsHDCxnPKG?=
 =?us-ascii?Q?y4RX61tUQ3ivtL/7fonvYWHwvLJVw7GBeEcrHpeEwNC7fozkDuEyeF0Ti7r6?=
 =?us-ascii?Q?GK7Tww4WcvFzt7S7yq/UGB6e3VUNCN96ssgj3xu+Tua2i2HPMH0GXLk0Q/0p?=
 =?us-ascii?Q?s++VIF3QaAekGJqYlnDDAWINR5vIVfAz0dF746G34t9/1M56X8a5VqGWQ9XM?=
 =?us-ascii?Q?qFtu3Vy5lqzC9i4SzpZB5Mp6uBr2dd/hrxk3TtqH34wW+bnhUrdT7UyOkvou?=
 =?us-ascii?Q?MbciNG8/lA3Tuz4n9jrIxJrRylUKc8Sn3wxWVJosrwpBo/FKe8TazaKnG8+8?=
 =?us-ascii?Q?Ss6c5h/HuK2MtJPOYhj2oNtHfUl/YZnj98gRhuOQ8NtyYDSWCo3oOBuZ0P1S?=
 =?us-ascii?Q?uctTwKcHLJoJupUUcaGWwPKGetOaQ9A+FQ04Ovloi8WNGPqFRu6x6HKjSjWc?=
 =?us-ascii?Q?qHouMP9RgSpqW5QnYnOVyJBvub+PPYiAFsC6GYiMzOlei41T/xzqs4FzBjdE?=
 =?us-ascii?Q?WAbsFUJwBxz4y3T1nWaHjoDOP1AJTLpPIvGmwbOU5M32EzncqphQ7Fxg96tC?=
 =?us-ascii?Q?B+9193CtF9PxB26vpqYwUB2uEVq7vYveTjOerSPRfNqUt/JO1BfgfGnR35s/?=
 =?us-ascii?Q?Zqrj7kptHji0CqkCERr/SuppcmayXc7si5EW4GGQQeeEK/Adc1QkyjKZhtOW?=
 =?us-ascii?Q?qsLYPZ58a3xHOyAIsz5N0B3V9KQ/w1EWyusxKCNLqeKdU0vbnh6scibMTzTE?=
 =?us-ascii?Q?mW7RqnQZuEr9+J4dooqeZGIHGXXcoOx6hEKvD1xjler6gzNpoB0AweqlRDVv?=
 =?us-ascii?Q?xbYRBPQS1ZX7fFYXzHI1tS/32TvR0Nnv1aGKKM8fSMKriv8jwa5Gjh4zWL34?=
 =?us-ascii?Q?Xt+h3XMC7mG9ns0mlwyacb5sjQJcagLFckiUPrxQ8sXFK2DjRIv1j5IjWP4o?=
 =?us-ascii?Q?QsMEkT/GBw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb166b2-47a7-43c6-2c23-08da3a6cc6f5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 14:26:49.7993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJjkLh3CC/65u6MQSHrqHnliuuLMlSNVl3qhuRsXgtAMfA1m+j07E/sk/cnHJPt9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 06, 2022 at 10:50:13PM +0900, Tetsuo Handa wrote:
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_wq with local cm_wq.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Note: This patch is only compile tested.
> 
>  drivers/infiniband/hw/mlx4/cm.c      | 29 +++++++++++++++++++++-------
>  drivers/infiniband/hw/mlx4/main.c    | 10 +++++++++-
>  drivers/infiniband/hw/mlx4/mlx4_ib.h |  3 +++
>  3 files changed, 34 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason
