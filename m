Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA441EFEC
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhJAOrk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 10:47:40 -0400
Received: from mail-co1nam11on2078.outbound.protection.outlook.com ([40.107.220.78]:17248
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231862AbhJAOrj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Oct 2021 10:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEdZANO1AlvYsGWWw63QKDeW8wCzoO69jtTsp8TcZDnmCWfmaja4m4NXVQk74pUDbBHKwG11iUzLwt2Id2EjjTwMWhwtM11j+px8jzxnwDb+9xN8giSjrG+t879EVDZ75bolWLY95L9K9xBQzGGAkpz2aSOBAjb+7vnaCLkNphEZHiw2sZemgm0uwuUSmmogiE2hkwiJ4tRgRHFobhVI5XbyoYEg34eyPTJOrM59anG+pNCHdPLnusMZry3e818tnmOgD51KhdOle5rXapJvpMIpaPh6R+Pubg+gejqOsFHctD9jQr27cbKLIqaZFU8Xl0vSJ8f++c8wpKd13KUV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBaAqdpzFm2a1/Jb+ybRc1hT2yIk15kh6F7qhviqYIw=;
 b=hUfyj11GWFAQvjpyu1y9pQ0kPd2RF/EqzBrJdNhw3psr0YDhtXt93kgcHpqs1FP8WeK+OZ7YlFBy6eDSP5EIkNXOONrzaxlgABd7cW30tzwCfxc9vbHuw/Cvv7HHFDstxFH4+XaTpCK/iMoBgzYia7OSuy8aGjXR0nZotA4WZSE5Zc4vie4Sdshiuh6GYrtCQGvjMTRt9nMOMi9dufyj7oS76H/h769aiq0UqlqxI/HquPpH+Fmn2Cm3QsxfhVhQeM813N5PxbmWBAp87FSp7nvjJiFBJSYrGLA1Wr7TC/x7zF6fQeGNhXVQKOsFoWAktMZ6avHSV9PLuwJox3ZKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBaAqdpzFm2a1/Jb+ybRc1hT2yIk15kh6F7qhviqYIw=;
 b=ZwvHBVxmBpnOSQI1LDpVhbD3asp56iLKJ8/R+52M0YfJyRjuyT2C2Swwse97YBZT13HQAoFffSV9wvIPA4iOVAGwAJaOEHYMf7sltOxhnTO9Rhjt1nJZdm6MW3kanhHoaw6Mx7MoYcQWtYEbptjdtIekCQgPafbUbSniFIF+NsRb1rjIepNJfpfgarMZJUeRIsWpyplOo+fiilfsj0vE2MZXw83jT9vpsdG1KjlwoLxxFVMKXiTB4gcA9D0ohNLNxI3QGiyuad4rR/K5bEiYLtEdGz+IGrLWIPwcxwD9/4IhjZGk57apehOTMoyQYmIdWgvIh7HaQkDgLPdofXYoMQ==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Fri, 1 Oct
 2021 14:45:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 14:45:52 +0000
Date:   Fri, 1 Oct 2021 11:45:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx5: unify return value to ENOENT
Message-ID: <20211001144550.GV964074@nvidia.com>
References: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
 <20210928170846.GA1721590@nvidia.com>
 <ea12fb42-97e4-0321-da0d-049a0650db9f@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea12fb42-97e4-0321-da0d-049a0650db9f@fujitsu.com>
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:208:1a0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 14:45:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mWJnK-008btT-Lx; Fri, 01 Oct 2021 11:45:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 896021a2-268e-412c-ac8c-08d984ea2a72
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5377C34785BC4949B3250779C2AB9@BL1PR12MB5377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+JFqAPbgegCLWj84m4uGXI3q9EwDCLg26FH7qLsn4Ckq4O3oYWAbI1pw+pNOQLyIeGKtpDJJP8yONAvHgaJDYvijOW5hQhWmWVqQZ0enEa97loax5+nsK2arNeLhhcX2C6pmfg10GaizWwDe9gKVqC7FVrk+kEKcjujPAku+/gi+NfKiyyCC468J23FWy7SIcR3D6yImpN5qOqLBJGS2mWjS0/W0ziw/HM1wLMTnuw0ZG+rs+XMeLQ5Or2oZHgY8sJn3aZUkqZVmu4fZcBOWLB0WXFi6Ks/1OG3CWS1m3it/UmLRRo/ZjpzISU3E/FLdWMPD6S8RcAs57c3JLnePntDEjS6HGTSWyq1N7zoyPwOGlm6ONQCmF66moooAgu5TKaDRUB/hwhx4DFkoFtG3BfDbJGEjH0YptS4rvhKQyCMYdQTCsd2Mgkw/vJzf+B5poTafjNWwcnmAgbj4JfiMVm4SY/0YU6gu2JGTjYp31nKfd+WtpKTupPgbyeIUdaZvUwh96jc1b9o7+pN15FuFpceYgy0XPedhgS7ht5AJHI8YEERqVCIdPyNSxHByVCGtZVhIlfm6UlS+AQUHuQyPoNRZdDnC7cw0LzPwc8FoGiLMv6p+dscNL2RjsdzFzke67X6w/tYt2qGjYPE5iVkPOOypFKe0k4SByfMKowC9qbEqYlVGh8vtykJt2rq+HI7GqiSUoQh0bVOwTzfyOHDmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(26005)(33656002)(1076003)(6916009)(54906003)(86362001)(4326008)(53546011)(5660300002)(8676002)(316002)(66946007)(8936002)(36756003)(2906002)(9746002)(66556008)(4744005)(66476007)(9786002)(426003)(2616005)(186003)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aX0OuzdBDYndWH8sUzCVoneQSGlwm2QHZ/ImxUgxQU9y5G0Ff+AqrYDRcQm9?=
 =?us-ascii?Q?No5AYkG2CML7urDyzHbcaP2i1Z8RR2C01lJNUMGYnO+POr+a2CJx2s5ieigD?=
 =?us-ascii?Q?b82+og9eVebUj4lR/8wtEtGhGLWY3NKb0ShpI1aFRVU2d++nY+kr9knH8hfo?=
 =?us-ascii?Q?9mw4HMlEYK8xTpp7dOYc964T33Hdi+K+dgB12o4N5mGzUJ95P3BOrgOyahbK?=
 =?us-ascii?Q?T0mGWh5DVj84BUn0wzzd3JJYOubAv2ccWrvWo1wKQ1ynbKrcWK97djRttry7?=
 =?us-ascii?Q?HesWlr7l8lxQOJQy7jz/UUCFxs9t+83+WAsLCjWSRysDcMdAul6MlNYDvEyj?=
 =?us-ascii?Q?fu6TGQ2JnDiaHIU/80zT5hazSyC73IA4D9oWlUrOsc4vOWjGm0qTlqYtERBb?=
 =?us-ascii?Q?0nn7ikXV3hZEOsY1o1tg7+6ieLdmnEagVbdIvcwzB70sqclbEp42eV/go21M?=
 =?us-ascii?Q?3FPO5oYCZBTD9yael8jTtjoX+x/Q7dLLUE6qQPoCQ5nGe2J+0OpsJatZl90D?=
 =?us-ascii?Q?hVPsKyQvFfJ1CPScjXd1SZiVe74tPOv4QCZ7ndnXPrRyQg0J0VA3CJoqb9F8?=
 =?us-ascii?Q?mDtPJaXuDakdDc44yQsyCuRToX5hMUnQ2dI8OwJyxq7DvOg5+cYCAhbPOBFq?=
 =?us-ascii?Q?CdBjNLpdvU+IKlFT+94MnlMkc9yzO7BZweqUyaNI9x8oe6nEVN1+Skr5FYBy?=
 =?us-ascii?Q?v0iifxLcPok7ecjzyu6U/a960BNEH71aJ1RpO7CsOA0rdevOgFk2ycIp4Dk3?=
 =?us-ascii?Q?ZZJG7gXUwuUgET8AqHd+OsOSf+8ROXi79FbrrIRsFZXCfLsRtrcVVnXQ0Cul?=
 =?us-ascii?Q?nY4Us1dldq6zJE/z4sDrNoxVVnG9OQl8Zyu4V1p/bTrkY3ztOw40GTnaiwio?=
 =?us-ascii?Q?NptsGTZ5riaan/CMnPH8Lc33DcVaqVQEPKs7ux0ntdNkRzbqhUthCqXjfgxK?=
 =?us-ascii?Q?7s0VovmEhNAxKc48SZ9Xr+D1fSaCqwAa0420EbvFBC5BJQ9UtjWcrXuZ84DR?=
 =?us-ascii?Q?UQksoNwMO3/nqYZiwYnBptwwXCtHu1yXONFxQfrKanrMGiXd75YbIk8FEYiv?=
 =?us-ascii?Q?RR2PCvUL7oB+6riBlCyzyf6t0WQu3+x54bCWYumoNpibmRAczV20o3+MuOTz?=
 =?us-ascii?Q?+TZ7qpYLdLi1i8RKwvA7I/m47rVYL8l5Lvh9Z4AM2ny9R7iDEdHS3btozo1n?=
 =?us-ascii?Q?DLeNz6RsvtOyOul6MyWTCVJMMDwlg7g5L0sHrUqU61Z1XunrgUDkrFIbW9xo?=
 =?us-ascii?Q?+zSJ/C2xZvQkGUL9iVDSI1iqeGiPJveurvupm78Koaz1QaVoG7qFshwRimDp?=
 =?us-ascii?Q?67YhUbNuBCwtYy3F3GprPUCPjVavfD3Xr3F5KNthdvN+og=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896021a2-268e-412c-ac8c-08d984ea2a72
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 14:45:52.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1QFqqoa84W+9/haF7XEc/y8tWuTffLt3Oq+1zXbXI77uoKRLIWHmDcXvzc7p1Si
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 29, 2021 at 04:37:22AM +0000, lizhijian@fujitsu.com wrote:
> So sorry, I missed this reply at previous ping
> 
> 
> On 29/09/2021 01:08, Jason Gunthorpe wrote:
> > On Fri, Sep 03, 2021 at 04:48:15PM +0800, Li Zhijian wrote:
> >> Previously, ENOENT or EINVAL will be returned by ibv_advise_mr() although
> >> the errors all occur at get_prefetchable_mr().
> > What do you think about this instead?
> Thank you, it's much better.

Ok, applied to for-next

Jason
