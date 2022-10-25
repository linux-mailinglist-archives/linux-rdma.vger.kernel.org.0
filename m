Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B260D1A5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 18:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJYQbI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiJYQbG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 12:31:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A805E337
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 09:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHkTyGMX1VtDkFVUWjYVx/gbFldZez5X920ICClHG2OzrIGamz78NzA3SqTZFvxa65QY/5aYt3APGzOU+BXVdhBF+crXOKeQAJtQITs6cTJWU9nqm7YOhNeTwYj7a4JtBdiRq05F7XGH9nyLFzyhtDgaZZd1KPDARwUwg1evOwMr1DCIPrV3FbrSQ7fL04wixFBehVc97ir+nlT6QBj80ZuVQk/Wl37cIR0g5ImeS56mXVlawWXxoF88XVOozyqJsaB1dNGeTQAF2eVpj3FYlZn+BtII0IAffYfTMKsHe/t+ltPz8A6gRHN7j1RYKy4kwSEB91usq4ilA903F42HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PArufDnnAiJmHUN9YmA0QVMvT96U/ZPP2ibS/OeaszI=;
 b=ROqzp3BWzCR9yazTVLzZDtHok+wk8fB70Yk8bqW8z6sspyIkV7EpFdewnX1oMxqjT3ND9Y2SxaT/5Ulqqb7le8ZghBTEF0+4IOEH1h+cpzuaLSnDb9uWucAuLlpYI1RY4ePcOsHJsI1VEEOZa5+BaBBZSSYBulmpuwcnnqKGn1o1wI815wZ5Pp8KQa6Q18RbNvKxLYXac/uadUXjd0uPGXW38QwSEF6zJtINoYHHV15XMOPSLgxbscb99S69dIYu3PBODudXJGtOZMb7i8z7bzwjNi2mVHuwXrXJ1662PwzE9FL2Sb/PdtEVN/LVauArJ5I1kCT4MMjtdiKZiICjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PArufDnnAiJmHUN9YmA0QVMvT96U/ZPP2ibS/OeaszI=;
 b=PAQZ2dV/AWbahPdnWPZZeEp7ycwfpCoP1+KsRSy93+jkGFlAmM+aAxSz9WvZEzPhTf+NmqtWY+uCS1AeUAvaVyIHt5GXc+AyISIa82TvXtsjloFeY04yeafKR/7i9K2zIJ4ue9h6z36WdLVs5ZI6fLFVc4MMlSlCeEVrcep5p1yhWTJ5Iefd6x0MGUeSFqinTqEtx2SxsS9U3N3hYToYmNVPk/L3nRTn3uj/oEoyLgM5T8YBIvjb8mK9UrGlZmhmPYMpxhrJnkU6V+DVxImNpIkN6iozotIOetRk4c9xCmh+VQtL0MTBtGqlksjo4LeyCeRrblm5Gk0p13//YBy39Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 16:30:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 16:30:51 +0000
Date:   Tue, 25 Oct 2022 13:30:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Remove rcu attr for
 uverbs_api_ioctl_method.handler
Message-ID: <Y1gPOUIaKOVmK0Ok@nvidia.com>
References: <20221025152420.198036-1-yhs@fb.com>
 <Y1gIAnr5jFRn74c8@nvidia.com>
 <20221025162909.GG5600@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025162909.GG5600@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: BL0PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:208:51::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f84051-ab16-4d8a-66b5-08dab6a647a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TFUmmRxQQIa1DWl6ml8qpZ3xqCkkoLLgeNCw2DvOaH/HRJcxtBvLQuyAx0fAqfIbrTwk5GQjGLdHLDYv0PG76VfoIDa0c81kTh2LoujObfSCMbDwhS2OdS7xsvarGeyYV2SrvMiHT+ZpVl/9SVjXMLoQsewn+HTVRfE23K4fwGYIo8ubOuHGSc/YRGuOuoZ+yxD1874b33WdyuMLqASQ8gPJzGzZ2gBDg/aIDqGn1y6aL4Unfuq0VUDi/2PoGhlLh5o4MU41qudPWQXE9xkZ3ig7kN9fkUE1UVS9SECNeSMQ7XS1rIZjlyV04VrtH7vtuWR9IPa29ke+aAs9NMqvQf8RPxv3S+MHzYyApA0hxV5E5R83HSpb4xPgTKryNtYiwQE1BW2hp8xJg1T8yHxoPdyLMA9nkHoK4Ekq7QhJ8QSWk+EPxHXYUCpr8+ySjBPcGzESc9Qa6jtlIdtuHcc87/5oKUrpdBUHA6nBXI4jKACTL1jJaGHPk4DKFquoICn474eTrSwMI5yNk8flMXHugyZnYj/MvqWZhIRN13I6tCFEBRL+G8+MyQ8KQefVtoGpxFZQrXd1NrbrlJjBUfgCukE7t44kE2xCK5ihrqXvpELGXzcmv9eFrLQzZ+e51ea8oV/cC4f2xTSu7ASxmfzJtl+uNzsjl6EeiKKy4jZKBgj37cn75dLBcKI0O0bkbf3ieOJK6xMrF4OeYjnEh0nwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(66946007)(6512007)(36756003)(86362001)(2906002)(38100700002)(186003)(2616005)(8676002)(6486002)(4326008)(26005)(6506007)(6916009)(316002)(66476007)(66556008)(5660300002)(54906003)(478600001)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkhRxt1X7puDAQBXa+cZ83XNB2G9MrO9GwI3lnrOZWRBOzybJp+XJSHOpNA9?=
 =?us-ascii?Q?Ixq0ZtbXPDm4yxCkA4860sR5+6pU507Z9cwYrpcHlKGN7yPUKtGh75grQX6B?=
 =?us-ascii?Q?tEM044kQMQUD59I9kmnlHBE+LnTCxDB2T3Wrl3W28CXgBODDvbX8X2Q/lC0R?=
 =?us-ascii?Q?wgUhcaPT5MAYX9ETbX6v6fOkfHR9lnSta1P5/0/o5bXGp3733NhWbSpQj2wA?=
 =?us-ascii?Q?WwTL5+kR1OyauHNlbtlU47+NkZC/Ty79yToPrYHQIP/YgX7TiVApsv0Mbqe+?=
 =?us-ascii?Q?TOUqStfFxSyvJjYpYcJjhPc9p+HRaz/UfqN2cZmYgfHBKh1VrFOwf70DJACS?=
 =?us-ascii?Q?ez9m3DGrnClEH5vw3rnKnRcIJb8IhACtTjCtr6T2wBOuPZCnvqsM31xdOF3i?=
 =?us-ascii?Q?Rwe68clTKfG3c66L0pkckJNVn4i8N6IwlokqNgCYw6pruxJLW0FyT4rDFSZu?=
 =?us-ascii?Q?dBGFJb9IO1irLxlSyLNsJx50o5MefFXoBiTMOKxnkmxtP61RDHsoeFpzcAO0?=
 =?us-ascii?Q?epyWqle6Fn2kJ7llooC67VQfum14BoGh3+eONA4yFmfmQZlelE2ukwtYOsFT?=
 =?us-ascii?Q?dX+AyBQ565eg69uZq7EKsQgE9yTow1mrdVFWK4neBRGSPnIKJx6nJPzWcef2?=
 =?us-ascii?Q?9YlXZUL00yVs/rA3O8Qij153G+2m0RtddPGgoXKoSDVbfvCkjHpKjhgHH2w6?=
 =?us-ascii?Q?Gn2d3jKFB+Cbmy7AVAaZDNOe/XQmlfaIuypiUlcktGsxFf3toZo+3qiSADjr?=
 =?us-ascii?Q?Xza904/JU8liO6EzTAbplKnQR4Iz5yxG0vHq3kn/5YdQGMEa5mjS/2n64Lse?=
 =?us-ascii?Q?MqcrrUEIDBd5xLgHMc9/kNDGgsA1aQGCJBHFfOcehamnUEFLIuofg3fi3q6b?=
 =?us-ascii?Q?3oBq7WD8sFW1iNa0ca+jbl979kLyBqeXNuqNNGL65fbJNX97YN+PwONmI6fF?=
 =?us-ascii?Q?bftoz0WGzUkxyCKY/RKDfczwYp6qbjDRnQBWBZEEhWdijTigyiXzdXnOjnQe?=
 =?us-ascii?Q?Mpzmbnmrj1ELR77FrBNGFJBmrrghZupjp4cyUHyFhhp9De/8oUjcHS9YW4OI?=
 =?us-ascii?Q?+xmm9ErxWUo6wjiH9Hr1YPlFxd5qQmBnR/J7agET5FBa+z4aPfK3pzAKGmy+?=
 =?us-ascii?Q?9I0U1reiY8Tle/7IdiAnOdqldanVBf/rhaO2PQcfPzjp8nUIq6bYPI4qq4zf?=
 =?us-ascii?Q?vuQxLyB/sY6iHsW2hzCB7SlFR4tH720q3THbNrFEqItsVrQxlujOEJLy6Wxg?=
 =?us-ascii?Q?R7mD8cRWp9Vwf8aFbLJFhaLA6WPWIxiDhl9oN4eP6yoHpc4Ufe5/XFh3BC6l?=
 =?us-ascii?Q?4EIzn92BS8Xc4FvFKeB2C/otyRijgLS86L5dAWsMIvBuaI2kgZ1PZJLPoxo4?=
 =?us-ascii?Q?psYI5bGR3hxjCECzqCa0YwrmpExaCMs52/3BDVdbE+RxDzU6tIEwGJ+diBjc?=
 =?us-ascii?Q?NKZUttcqpW9smb82U2EANTCIJDFdtRd9+0QMRKiSjhHoGhAFke+UvkzoeY96?=
 =?us-ascii?Q?YRQZiodMBFqRsydLMXrRkztSfSogNxNAJk+w7hkX55La20DG6GOeLABEYdsd?=
 =?us-ascii?Q?JOHy2YJabVqAvNkIL98=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f84051-ab16-4d8a-66b5-08dab6a647a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:30:51.0575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDp2bImov/SnPAmx/81RHzwbLm7o68nSLHodYvbkywHOwjv3VJKrNa9i7SL5LVXb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 09:29:09AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 25, 2022 at 01:00:02PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 25, 2022 at 08:24:20AM -0700, Yonghong Song wrote:
> > > The current uverbs_api_ioctl_method definition:
> > >   struct uverbs_api_ioctl_method {
> > >         int(__rcu *handler)(struct uverbs_attr_bundle *attrs);
> > >         DECLARE_BITMAP(attr_mandatory, UVERBS_API_ATTR_BKEY_LEN);
> > >         ...
> > >   };
> > > The struct member 'handler' is marked with __rcu. But unless
> > > the function body pointed by 'handler' is changing (e.g., jited)
> > > during runtime, there is no need with __rcu.
> > 
> > Huh? This is a sparse marker, it says that the pointer must always be
> > loaded with rcu_dereference
> > 
> > It has nothing to do with JIT, this patch is not correct
> 
> OK, I will bite...
> 
> This is a pointer to a function.  Given that this function's code is
> generated at compile time, what sequence of changes is rcu_dereference()
> protecting against?

Module unload. We set the value to NULL and then synchronize_rcu
before unloading the code it points at.

Jason
