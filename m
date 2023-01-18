Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08A8671D87
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jan 2023 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjARNUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Jan 2023 08:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjARNTE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Jan 2023 08:19:04 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453080898
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jan 2023 04:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlN7biRqHB7lCnldU6c5S0E9SRHsnkw3uG8r+rx0DA5u7Cv8BM8saAi5Usivm/wEhrjv9AgGR15Xc0NwjQJlXowzB0RuK0Vkblx5eT5gXKM3hqjEDnLv3E9Cu9jc/1ZlNdXAXItMpW0yEYI376wY2U+Dqt4KTwEf5dFsMfIedp1AyxrUqYMaclkeSmEH2Ov1aMUFeogVcyh0q7fySwiidMytG5ZwWznsxn1Gh5EhzibJJVK8q4Xggv4c8xFqZSQzpO27LxnRwBhlL1T2YWnVCbfbkRKOpPreOYfwt8dEqLBtgJpiD1pFylcSmDe7eF008VtvOOorsDndhojXbeeo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsUQWzCChAIkSNBW103tIzpXYaZAk6pCcfovsj1+pwA=;
 b=OMyOmk6qd9F1bZxa6CzqN6kXViuBk9ZX4DDzIYMGqLLDnLbR/pb0avRv7onYc5PDvsde55OfO9s73ALe+qvCtRZgNgkl0+4U3tnvtigf85AES8KLv+NtFRqpYELY+9/AmHHddZniKEnvXTJNZI+UpJRBn1+evk8dbHzemeYQWTba7klQy54guJ7+3R4g5Ob3G6qFECfN5KOuzfuP+0YZUeOVCxKXE+XJruQvWTWK1rz2vsncIupB2toeOVWTS0cwG1gCIhdV7XH5PUFjRL7wmLM9qD2SydLw4qxJyPN6cWJPM1+37aFiV8AVQFyh+fe4gP+S4SYdKXPvwtyzUJpbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsUQWzCChAIkSNBW103tIzpXYaZAk6pCcfovsj1+pwA=;
 b=snDCWCW7VeYo6Wjy93rI2LIHLXiW/lTQbaKYAIlHTmZk57rytObP5peEvYO9qZ1BkxdtM8oM/a44lQ//B90+gvnLQOKrQ+Rm5riFoBjYpSlsF/xR6UTqiKD3xhvVe2bz8ldEk2hFO0q73huJN80vAlEAcX+DRQZ7PSb52Ld++L5R2ihLuybevOWoWHTeRv32qotzoj3xHwKoOFww3uPHsqwt1oBYqtywVsynk5pB0s7QzjgiWyTFrti1MI5pBW12oUdjJpgzR2dP+HKZD47zd1kh9amCJshmWVgq09OOUov59vvJCil0s3YVG/GW2v7NELRSeFv7kDTYCmV3xMXutg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 12:42:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 12:42:29 +0000
Date:   Wed, 18 Jan 2023 08:42:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dean Luick <dean.luick@cornelisnetworks.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        leonro@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer
 invalidate race
Message-ID: <Y8fpNLbRuT3UMhJK@nvidia.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
 <Y8VwHYPYlV459T1j@nvidia.com>
 <a4027240-b711-bd11-1f42-c16d53104f6e@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4027240-b711-bd11-1f42-c16d53104f6e@cornelisnetworks.com>
X-ClientProxiedBy: BLAPR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:208:32a::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 44983204-a3a8-4758-d142-08daf951760a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUHcORnZlmK/cMMP6y8vN/8LdizU3rwDVL7+9YJYtMUE4LeI0SZP7q8oiX2A2NFwqpiLZH3vh7BGqFoVvv0eHS5/jHaZllxGw/ogeJuGCQIr/kUMHequ1yjwtQFIUkgsVMaxD/UrOjoeLS/5+YSQhRHkU5nYmXjKIz1/ZxJJT9cxHMCPwwD2FzUj6sHm4JdphJEzslFtmo7m9rgbwXTof2PM374IZ+lR3AdikH4jrj6ypGmPIPri9fS2782ALSOgb5FN0g9cNRsU9DSsWORazXWyouMkFbujxVcRAAd/nJRiHHfCU9cRNZ4/pMGpFdhSOJCojcLMwKc4wEVuc6+e1hskS+I6lcXFdRe0zB7dWAKTlrJ8dUOHuCiL0qhF/B0QTOwuhcnfUkW512Ksl9ZxufpBVm3oI1+upIt7NdpnPUOBZytIpI2J9usKZUzAtrZLH9G9zW8cEP5zoX0AZ1q89zayilAlGtqQW6Rw6edz202exLGYHJvrey1QnfT11pUBUVWmeIWfVthtY1/vO8xkCHaA2N/qANI46k+Lg6nohF4jmF5MYslzjyymHPr++iB8skyHTFXm0L8QjOTAvzR8t8EyxG42APNVCEN3EUJsCsDmrYopdP6nRcf56126+L5lqF6vyO9HP23kHiq39/W37w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(38100700002)(36756003)(186003)(6486002)(86362001)(478600001)(6512007)(26005)(316002)(5660300002)(2906002)(66946007)(4744005)(2616005)(53546011)(66556008)(6506007)(41300700001)(66476007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FhuBBgKE6KfjaM7NlC2OtBv+uuSHTVLfW5qdjkDe71wn0WrTDapWmhGlSEyj?=
 =?us-ascii?Q?f9RA9un4J/HZUFvHCg8VGKtR2txD4WPXro/qfFTmBal2wdWexdOq7nB9soHI?=
 =?us-ascii?Q?EEjeb0Wq7mGrs1JzsfFS6S0WXntIP+fvU9jhVqJ3CLfLwJKK7hAk6jeKouGp?=
 =?us-ascii?Q?16VyMAffaf6onM02lSluSBE9PN0b5tkyBnVr3wzVOUsdl5FuNepRoqzR3sj7?=
 =?us-ascii?Q?1l6t8regr6KlgodVHjeYpn2HV7xQ04hZcTlYZ0viQrkh65OEvqMF52ih2cve?=
 =?us-ascii?Q?IHyJXl66Eb1ZpAxk/2aY1LfluQgWkOoerfkgpJuhuhfQ7l2ULcpJPVonkRld?=
 =?us-ascii?Q?g6WWU3p1HILC1ncYYnLPzQCsprpJ3rLY0KNRGrp5rRyg7atPNdf5iMLVHCH2?=
 =?us-ascii?Q?+SG3vJVBNgxp8siy7xTYaxFXkIwhYxub6AZ7/7oMePWWZWHcZB+a2i6y7wn8?=
 =?us-ascii?Q?bt+PVSmPz3+SIXEcYrRvJZklslJaN0rc/Rngvf70MdC8S3uQ3hEaoeT6Iz07?=
 =?us-ascii?Q?oLlYL/aKiy2xxj3RyS4QlnSGAH+El5Adh7VvGwp9DPz2+9NFViTjwJuU4B3R?=
 =?us-ascii?Q?iKpUFPHoffTxIKz79mA7PxJsMkq2NjpokzIQOelZVHavrofJeyA/KpoxTuJF?=
 =?us-ascii?Q?HM5DCVhnQIuTdB7IpZ2nUXLwl2R+fJOupCS1866YC4itb4d1kB7k8/iCHVFp?=
 =?us-ascii?Q?Po+Mb83jJKzdoc0Q9OTqxQH0Vr3eDDHboq8RzWPzyGicVe3gPGxiTUxoSxA3?=
 =?us-ascii?Q?7q4/bdceEkuh6DBsFhTMaiNSDSZE3HPslpEk8GSkSI+UZh3kgz9FNyCZkSlP?=
 =?us-ascii?Q?ReG4xwdjfM/tXeZDU3YdgX+lxsX4RZNBH66YgB3DNBz3a+/3KqvKvXV42AVp?=
 =?us-ascii?Q?EJ691BFw3Gii5mPOMOmcffQcscy4hSCbolRJIlr6NfjDGXjfPyjqjgFqbnyG?=
 =?us-ascii?Q?zwU3bD/FcYHkvcJuPrA/WiVEoI9/9x+zmq0kdBFZIFAGIJp4MS9eeuSlayCh?=
 =?us-ascii?Q?pkCqoYIuttRL5kVVStL6OoK8F/ol6d8eKdShSlzX44/Ks3JBQZtqem/dnxX3?=
 =?us-ascii?Q?J5U+I45MnFrfVKrtq0HIxf4MJ7PXDWtvUq3ADDVRX9c3AkwJtKKRPQzVCnVT?=
 =?us-ascii?Q?knoTjBj9d3ztdz2tcCilYUfQW9VonGZBjbXjWIJNCNIOEdgxuymQ04GaOHba?=
 =?us-ascii?Q?08brTIyjWMjD6oJdteuIsR71GHZcEbZxe0ERa3DHNYzdAQ4MSDWyNmPymFEE?=
 =?us-ascii?Q?PJo5zIFC1FtwPxQAE2Q/MhzJDJuJjwD+rEkyhCz2Ogiq1lFvORjGK8vImsej?=
 =?us-ascii?Q?F9gARqsUrhEMvGH8CyY3igSODcMnvPVFjlcREWcYCdhF3xo02W3/A1fcfgAO?=
 =?us-ascii?Q?jcWbo7E+0IVy3U09tdFfevWvcRufKURHPPhrfXeli4pTeau2ASPJJdm76Sf/?=
 =?us-ascii?Q?Mlqu7pQA9WoedEJc4CXqarEEulJfP8lwuZtMZFA7o/m0p3budDoQbGrRyWHf?=
 =?us-ascii?Q?9cmJv0HkEl50p51S8kZ8YKaRzCogszThe3c3yoDgXTiKMNPbuEh5fVDs4UIY?=
 =?us-ascii?Q?1VkuxaTiqvFUKEBnEljFqXJYiMnV3tyNOJWMmbqn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44983204-a3a8-4758-d142-08daf951760a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 12:42:29.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtsO7x/JErr0Dpa2Fa7YHlHxB4zYWEdTubzBU0H6qz//aPEMJqEuDq7Jw7n+9137
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 01:19:14PM -0600, Dean Luick wrote:
> On 1/16/2023 9:41 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 09, 2023 at 12:31:31PM -0500, Dennis Dalessandro wrote:
> >
> >> +    if (fd->use_mn) {
> >> +            ret = mmu_interval_notifier_insert(
> >> +                    &tidbuf->notifier, current->mm,
> >> +                    tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
> >> +                    &tid_cover_ops);
> >
> > This is still not the right way to use these notifiers, you should be
> > removing the calls to mmu_notifier_register()
> 
> I am confused by your comment.  This is the user expected receive
> code.  There are no calls to mmu_notifier_register() here.  You
> removed those calls when you added the FIXME.  The Send DMA side
> still has calls to mmu_notifier_register().  This series is all
> about user expected receive.

Then something else seems wrong because you shouldn't be removing the
notifiers in the same function you add them

Jason
