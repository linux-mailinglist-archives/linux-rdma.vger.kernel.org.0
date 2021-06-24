Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08A23B2EE7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhFXMbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 08:31:40 -0400
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:24288
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhFXMbk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 08:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJrE/aa6knSlmuZY9oZQC0EqI70pousH/S0N+ZMOCAtcGwrXyDeQmd5CSkQLb27wD6y9DbyBJ38ojEBF6lT8PPBj5CxZx2L3JxYL3FP//JTluSN2mMdQKsPGeYkHrV615Nu3fLZpF3qlQzneD+hhgRNnUR59aXZm2rYFzyIkKShCN0JdFG8Mq+FXUO0Il5cq5X7gAJ5jmanS7kqON4jw2MrES1vpTLzyvDY4le8W+t/2Jwrf5X/83HnSZns3pS8YPRundg2Xwi84iAQimxXbRn394EDrqq5v5cDbrjaK8eD7G3wEdBGFOz8ZKEFZncXJoUHsMMDMVgZiC3Agw/CdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAd79ViHllq+0Lp/PWkksxsvr+sJD9bvSde/xEC9SZM=;
 b=BMEwD+XbLAVemx0VcRoEYGiXuV3x/ogpQKXtLPUGBXfsGctt7y1xLLGB5L0Fli8KYJiI9nE+tgScCxGM0e/cL9DiT7yu8Fvx0mlEEj3UvltMN0WPs+cIJrvinj3ZBz/3b0HtY4SoNux5/Ah/wjXf2pLaE3gnGFUWwJWxUyE+N49plAA8ivPs1dDRRXrbc5ixB06A/9UD3FUKb1p102ITOq/xVVXAHq2FoLj82/EfX8m09mLdtDS6/JaibS69Y+5JyfAjQTa78dpjZuRRtCWCIP0lULRKS6irxL3k64hH18jhuUk+DnNYEZXMDyGJK8rKupf1n1oo1JxQ8SSbcFaRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAd79ViHllq+0Lp/PWkksxsvr+sJD9bvSde/xEC9SZM=;
 b=n6T8xZETEVg0Qi9350OSMICvyqs+qbkduDo4COfSHyrjb5epr0b9j2u4GsYGD5kzY84Y30KNvky3EXQfp+qiEb2mIE54HLHkqXXPA6Z7It5+hFbq4AB/YQyM7BGcApCUAcdaqdSk26cFQnIJwg/eyogJ77LjoLlO3GOCXc6PP5gTe4/EzBsfCEDvIW2ZuQZ5Jo3VJhdG2JXxJVZjhECwA6jN0SFFCQZed1ARyGsHCq0+p/1eRAfdOuis6U3oDDz+pPbDwhLPMl9sM7d/jpejR7nPQtMKqbbc8YfrA8vO0YL2PNeCEUFnsTR71IKXFxtbQoNzznS9Csp1IJwepU8Zbg==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 12:29:20 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 12:29:20 +0000
Date:   Thu, 24 Jun 2021 09:29:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, israelr@nvidia.com,
        alaa@nvidia.com
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
Message-ID: <20210624122918.GA2879335@nvidia.com>
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524085215.29005-1-mgurtovoy@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 12:29:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwOTu-00C53j-TY; Thu, 24 Jun 2021 09:29:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 183f5f7a-8d7e-442a-f244-08d9370bb0a6
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB531993B2F3D297E7158E44C0C2079@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hu4JjEe6uqX6wIiXrARX6Qs+kTi45yRW3ufXMLhgndfXQQHMph/3NsGzYyrDCpatCxRFOyJXvsgwtzNNK0Wcq9Ht2uuiPdJoYCB7sqfKhyxGkneIydM6Xe9brFPdplpe1Jv36RxpkLJn2HfoBG/dyOP8pcYIZ05Oy/sbajE1UfbgklYXOmcmCjf9HVsZ9FkO8eMXFmwMsZ7US31ZzewfK9mTB0iBpLoyMVxYLxHMzj7MFPuowBZtPqvBQmmQsS9j1oVm2jjY9khcQ1MQY2JT1hbQj+DYPTgTk8HavyPglxvxdpZBwBwJqyg3zUCV4sWuMgSTlFuJdujfvsNnpXUcgKNmzwlUak23zxtJGq0mh/AxEqvaaSwa0G3sgZjDI9jaFrZSibPCtuG42ocPk4jdfclyPzEa6NDNDJGKLpWUmhjLEfW3kgQfRMKJs0Gs1O4Jbfqd2kDjdrnI90ZpqwQG7o9DrDvAAcOGTHLKdPL0FSKKOpT1nstMZgk/xNYqyLN4e49vMthGcuUnKKDu1sPF/iy8KmEFP2ejUZEo+IZt9DnM11xRRkA3ppc9B8vkTfaIKyZDD1WI2YVQzdohthp8Hb5zszlHB7APWBvJY3lB8Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(346002)(376002)(366004)(396003)(9786002)(6862004)(316002)(9746002)(33656002)(107886003)(6636002)(37006003)(38100700002)(2906002)(478600001)(4326008)(83380400001)(86362001)(26005)(66476007)(66556008)(66946007)(36756003)(8676002)(4744005)(2616005)(1076003)(8936002)(186003)(5660300002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1hRT38/g3o7/vy/vHFsM0tbPtO1NActIbZZanmWyNVrlDLBMmYprXXYHdmE4?=
 =?us-ascii?Q?QHHcru4n3qIjH2FddlR3BOc6AhKy2H3zyYiY+lV+X3xyJwvYh9KxftH+VaP4?=
 =?us-ascii?Q?EMfhPuwSHOZb6sNa2G91Br8UArN4qfWlVRRG76nBhHK/mYpQWDzXnJ0MG1dI?=
 =?us-ascii?Q?9oZCRwTX+J29enTvh7LvApcZOqdF0a9ENEEn1bh9WBTQJFGxZppYWWJQn1Xe?=
 =?us-ascii?Q?aLE4U9B9ZI9dTZJYoTOKfTm4SIhbWnRl8ofhgkvrsd+Wqyrw0116UH04V+Iq?=
 =?us-ascii?Q?g/tWF1HUpmE1r+o1N9YgJtjbS1SuQjv1KDYegJZZ26bBTXRTGbE3WKe2sQJJ?=
 =?us-ascii?Q?wJ1DSrTdWCrraC3cSlpg+Jomg83xTDa1VFzKC3IZvfdScnEpefYcUsjIiXy+?=
 =?us-ascii?Q?XZq703XhAwLtbbXAq4fJE/8zAYwd5ie1wCzI8L7fIYlkxaumCGqoqlQNnR7u?=
 =?us-ascii?Q?Quirl0keIiQ58fbeWQKYSceqIxfAeUlsgkn4SeBnBVsW85BEo/yfjCmRocik?=
 =?us-ascii?Q?bvbKVKqzpDJu/sxXkX5trBdw/uWglmsy0XQ0+en97Bpb/fDhl6foAhiQCPu1?=
 =?us-ascii?Q?4ff1RYOTwfNJJuhGCJ3PyXqsrITpBlQ9NoYrrcPzY7EGzehZgJBXD1aCncR0?=
 =?us-ascii?Q?ilptfOqnDi2TBq5rwuynFfop7qDvAoqSQJfQgHdwZIQat/qE/DesbPygW54B?=
 =?us-ascii?Q?Ao7Xit6HNvdjF8I3IMR+OT1VdpG6zSyZI9jFLQcVbRgk1MXT9r7IOv8ZTr6Z?=
 =?us-ascii?Q?/ALc+Dl3vTZ6kbSQFZ1xJTsq0MN4+BgZS6/Egs1ndH9RcbWKVALOyRotPcgs?=
 =?us-ascii?Q?pQbKUDn5yBg6ZF+IMEwfA40IwAXAYqM91n6qNV+mLniDWCC8ef5UNFARY18A?=
 =?us-ascii?Q?f9bNU21adRrrZMiCFnqgsJFW2B03gBR0bpfExjB4IEAYth3nsCo+/VCoAw+a?=
 =?us-ascii?Q?LB1czJv1x1swPOXbxCj4FJZJhquvkkNOOj1EQ/1+agLf5erwxb7Wqe3xJgWj?=
 =?us-ascii?Q?loQgF2qVl5k2xVp5XY7sf+DRl9PF5KYLHyx4jJB4LCYP8prvTYPCaeIm0kVb?=
 =?us-ascii?Q?RRAQh0VpCZ8JClJVErShxD+QYPezemtSFh8ScqN+CJv2lNCEdeVqRZbXy0di?=
 =?us-ascii?Q?uxPb05XKs6E+XvI9fFadtcHV31l7axo/G2wCxCXSqT/k+G9VIVUyQW7sedVF?=
 =?us-ascii?Q?QJ6xajmsWdSHPOJjPPGMdHas2acLUXssgghAv5knhOHt24lww6Oo2jgIFr0R?=
 =?us-ascii?Q?6SAX7NXTq+dV/aLMd+XWbf48plx8Bs8yiY6ttl00/9PkIFdsOlKEN+0N3NQl?=
 =?us-ascii?Q?hdqykSRCEVtl6omNHdnS7m3l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f5f7a-8d7e-442a-f244-08d9370bb0a6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:29:19.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgb07pwB8IzNjByQ40rTn2CXvWnneSC9/3CYCsdZI2iuuF4oApTp1oLcJB8KkyzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 24, 2021 at 11:52:15AM +0300, Max Gurtovoy wrote:
> Since the Linux iser initiator default max I/O size set to 512KB and
> since there is no handshake procedure for this size in iser protocol,
> set the default max IO size of the target to 512KB as well.
> 
> For changing the default values, there is a module parameter for both
> drivers.
> 
> Reviewed-by: Alaa Hleihel <alaa@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
>  drivers/infiniband/ulp/isert/ib_isert.h | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
