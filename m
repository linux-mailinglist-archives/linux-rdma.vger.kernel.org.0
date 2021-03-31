Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D553505A7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhCaRjd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 13:39:33 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:37600
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233473AbhCaRjM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 13:39:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjSaLgNVupnMQ8JwGeTvurGm+y7R3ZnD6FGksfRqu5ndF+RPRFqxU2eznCR4lRivg9FxYNr3BSJbDn1zGcQkAVSk3ah9nAK7fTZmSRx4Nol1gXKU3y6HsLX2yX/RnDgGXDmjtbEcPGKvhdpRP5hZRxb+kmKLFWhXxQmhBRdLABzsGQf4egsIL0GHJxpTLj1kmw5IPIW8rjMuOE7HX81BCyXVqLdACXNCEhiqTJ7ZtBSq4Qvo+y2dcNsCS7f6vJMTB2Cdolkxjp+fjXiDe1m+7WSc0vWWehFsidT2JOJzP0P1smHTFROXzY/ZJg3k0Ud0uzLQNaLP9qKLDJdNGvQJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26n44pLcyXCZ9JCubiG1E1QUbIUvUxE/LZTdXRZ1L3U=;
 b=P1Ary+al26kUP06n9OM+Go2tBPbX12k6p56iSHruiGZbak9huxc31l7q2SB7TnOJj3iii2hKoftgwVo6fR0KdnFrp1LeXf3hiBtCcyAkCD/b8xOTbYPSmzmW3CESlrv0decTX321+HTh1rZP5X9NZEBeHpSoy5UEoyWWlTkhTKrnRnxzWwYzMPLhq3h1/+Xk6oce1rl561HjcgAwsl3YqWYz5f8XS5WvhA9FJmnpGSnJpTlTqZqtOyBG2RicUiD4IZ0fB8G790aX5gJBj95wrWNLHN80n3dVR5zVFoT5F+FhpIRNXlkwMlJU7Jo5e+YjDi31XaoYVYFBbIwfIjSfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26n44pLcyXCZ9JCubiG1E1QUbIUvUxE/LZTdXRZ1L3U=;
 b=AV13WNENrYIF2clQDMRj3dChLcPgTdzBl6cNddE28YYIouYHU2pgXunk7F4Bf30pgUx6friE4RWIovGZ/zkQfNW84AjjSqWjygE9oTJXghnQLYJ7nZJxUbCPJi+3gm+q8nWaECZHCCS5MnX4m5QfkMV+V15sL7IgXSy1BTmOw3CdhYcDBIdjqRAHDs6sJIJiPN9HM1IVQv73a735/sM2l5Y3TIG/3mF3p7HuYrhPozLligQe83i5COX5Dn8k3J/s7In4YrGmwm8PRu9CchYybcRZjzERg4x5qsdI7ikBYHmuCBr81v9Vd96Ot6psm564UT6Gi1d45Krdm6h1yBilBw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 31 Mar
 2021 17:39:09 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::4c46:77c0:7d7:7e43%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 17:39:09 +0000
Date:   Wed, 31 Mar 2021 14:39:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Message-ID: <20210331173906.GP1463678@nvidia.com>
References: <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
 <20210331120041.GB1463678@nvidia.com>
 <2A5F5B02-4745-4EC1-974A-DE089F9FBE2C@oracle.com>
 <20210331131525.GH1463678@nvidia.com>
 <111062EB-22A4-4AE3-A31B-498445D344A7@oracle.com>
 <20210331133518.GJ1463678@nvidia.com>
 <E76F07B9-F222-4D0E-889A-712502DE0376@oracle.com>
 <BY5PR12MB4322EB01D0A22E6806B6F195DC7C9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20210331173514.GO1463678@nvidia.com>
 <2BA07D00-E144-4547-8F7F-77DB0C197706@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2BA07D00-E144-4547-8F7F-77DB0C197706@oracle.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::20) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Wed, 31 Mar 2021 17:39:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lReo6-006P5c-QP; Wed, 31 Mar 2021 14:39:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c876012c-5a62-4304-4814-08d8f46be39c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB274399ECC05B5AA3979039B8C27C9@BYAPR12MB2743.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfGJVmwYDjuzOrSF5o+0sZF/ivIdhSVbkhAFjJSJOZp5Gw3rnzUwD7n/ul1GXBCI2boOBRB3KU/6DZhTSvvQ+LQ9pmJQzzP+lmw0Mmvxh2Ki7g7BldciXafwzzhh6ybSq53vYEy86sOg843Zj3BOG8yba3uEvvlgu2/bQz1kzLc0f//iSEl/lTy1+3rIb+hN38I8hhPe43xDT7LGYvnyLGTh6kTfxa9KQJl+wznFdtkA4/CN09w2CYCY85YFFFh4POqMGC9S/Pg3+KkUGl09JgzSw5EN976yARtdVRh9rqaCqRaF+4WjtwGlWhazX3jh7R6XaeZ8El8G83PgnUaWBZ8RdYocD4MAp8x7bLNPUbDtqbHOGixsPE/YSG/aDdVl6nzemGjKBpbu2fqUIVPJyV+xJWDGT7VR2DBCPXL39K19yXsdhtrKCNSYLUtBnwXliJu/gWGg+dgq7cnw+uyJbEgq7PQGogGdijbtoC20+Rk+WOp/O4LYmTAbpWtoEmClNupGCN6pxgxHgLgfvYamAQFiHVXV3WCe0L7J4JgIygl/e+4lOKcqkxMz8UYUuqKgqyOPER/ZtzuKBhnXDY6d8k+eeIdAne84+VwGObdwHciUgeUvO0DSwGULyb66hKp57qyInfTxCFL1gXIb8efuWnw+jzPDG371GsgJkZHid+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(66476007)(1076003)(478600001)(53546011)(86362001)(2616005)(2906002)(186003)(6916009)(38100700001)(54906003)(36756003)(316002)(8936002)(426003)(9746002)(5660300002)(8676002)(9786002)(83380400001)(4326008)(66946007)(26005)(33656002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MczQkIYkNspHMCz0mIUtldkNrqhogFCRT1dQzkN8N6T4ei5ilD1QfDysGoQO?=
 =?us-ascii?Q?NpiKy/Ulhmj+JMHszmwi8Yx1N/RUBbgtVrSA0SpPnxrhzo3v8ROAtaEbUy4c?=
 =?us-ascii?Q?7Eenj4kqZc+gU4xYeKpX2GvvJ61myjqSV8SUfF/WvGcl6zPrZ0Vu3TyicUCS?=
 =?us-ascii?Q?vj4LthK/WBauV/hQ6MdAT5BWIEdBwnXCgrngIZYp+qB5M47CHEXKScLCHgj+?=
 =?us-ascii?Q?M4awfW4tt8BRDyEDblQLTsl1fZFsKUn3IKfbm6H/16g6hF42q7ZDriC/sszK?=
 =?us-ascii?Q?BqgdM6kgWQkfmArTZoGIAhzcZlENRgH2i2eLOkWdhVm29vVgrhDF0+CW11JN?=
 =?us-ascii?Q?lOQBzT+lYKlPgoExRi6gxCcaY2b+mCmCqWZRYIfcXSKKDJx1MHEM910yew0Q?=
 =?us-ascii?Q?tvJuJeR8P43usKN24KjAK8LbM4F69jbi+lUGxZ5W9d7CzCkMbqtU8I6aGkkN?=
 =?us-ascii?Q?RQKXIiYQfHcics1lL4msVxwiPBIofSe8HftauUSYiz6rgapOS30Pxzc6GJF7?=
 =?us-ascii?Q?tXvxMFtw5ZNqbir//EFhBLfr9KpsOgXNQpZh+aXgAM4ltfKkKXQqGthDenO0?=
 =?us-ascii?Q?pe20VRi1cSj5uFem6CGoI6srFztoRmXReI9yie856E41xCP49rjAWNNIFhkF?=
 =?us-ascii?Q?2URH9tkY7w07oVxrU8vYNs14wGKc44C6i4bzd8DuKpXZIxb0nZEhT7bMekqn?=
 =?us-ascii?Q?KwBt+L1os0EnSdHANcw79G6B4Dpt+pHaEKP0qwljEK6jLt7EWNeilUnGSGFF?=
 =?us-ascii?Q?8xSf+p9yGbM7szGTybtzAyTNG1vHP8pQ7bedlRkTeZpkuF8vEEtyZZU+bB7l?=
 =?us-ascii?Q?zsVZY/3qvvsfQLgOoCwaJpA0tWEw5oncF5Z1ReESUOYU2Ub+A3g0s3lsTgsq?=
 =?us-ascii?Q?sQnsXl43KumcyjcyQFjTxrQ9Zi55Ht0poYPa7L47ZocmgsO964xkHYKgutj/?=
 =?us-ascii?Q?OhqknUIS/NXgsyYg7oKfibDdd39M3B8Nud7Mdu6w8V7MZkuSSX72GJtU73oq?=
 =?us-ascii?Q?9G6xNKtxnYlEdoT7P2278ftdPrUmor/bOSrGZ/H/Q9tKWe1NB759Q9yx4W0W?=
 =?us-ascii?Q?dLzxpJ4HZmyQmAvlKRpf03ylBgpNhwQ9RQ+PlWo1VkQlEx0IWdjrthekBjR9?=
 =?us-ascii?Q?rk6vgH+nuC52S6Nnw2gG8psb0dXz0sgnNWl3aTacF8KlLujyPz3J/GFXpDFz?=
 =?us-ascii?Q?ekUw2DLogyMgpdFeeNsbQaBcGl3/tnxQCZ3JY9wKL0vKUWkgbezGmNOpr7DD?=
 =?us-ascii?Q?HUdaUYMb+/kziEl/dSLLbC53oUWoasXU2sEKiUXFNsZge9woBhWPztL9C+vp?=
 =?us-ascii?Q?KNyEAWRN8s4UoBqWSfNCUE/SF4tbPRn7NuX5KwOsAiXe/w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c876012c-5a62-4304-4814-08d8f46be39c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 17:39:09.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAQCPK5kaH8IrYjL9/K7eBYWv4KytLnOYo3SHSAtSC34A57w/J65wLtlCUS7bjCJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2743
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 31, 2021 at 05:38:26PM +0000, Haakon Bugge wrote:
> 
> 
> > On 31 Mar 2021, at 19:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Wed, Mar 31, 2021 at 05:09:27PM +0000, Parav Pandit wrote:
> >> 
> >> 
> >>> From: Haakon Bugge <haakon.bugge@oracle.com>
> >>> Sent: Wednesday, March 31, 2021 8:20 PM
> >>> 
> >>>> On 31 Mar 2021, at 15:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>>> 
> >>>> On Wed, Mar 31, 2021 at 01:34:06PM +0000, Haakon Bugge wrote:
> >>>> 
> >>>>>> Actually I bet you could do this same thing entirely in userspace by
> >>>>>> adjusting rdma_init_qp_attr() to copy the data that would be stored
> >>>>>> in the cm_id.. ??
> >>>>> 
> >>>>> This will definitely not solve the issue for kernel ULP, e.g., RDS.
> >>>> 
> >>>> Sure, that makes sense to have some rdmacm api in-kernel only
> >>> 
> >>> Let me send a v2 doing only that.
> >>> 
> >>>>> Further, why do we have rdma_set_option() with option
> >>> RDMA_OPTION_ID_ACK_TIMEOUT ?
> >>>> 
> >>>> It may have been a mistake to do it like that
> >>> 
> >> Timeout value goes in the CM request message so setting it through
> >> the cm_id object was likely correct.  This reflects into cm msg as
> >> well as in the QP of the cm_id.
> > 
> > Ah, yes if it goes in the wire in a CM message it has to go to the
> > kernel.
> 
> But does it go on the wire? No. The RNR Retry timer is not part of
> the negotiation with the peer.

I think Parav was talking about the ID_ACK_TIMEOUT

Jason
