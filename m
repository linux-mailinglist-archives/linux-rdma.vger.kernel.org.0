Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61B034F1F3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 22:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhC3UEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 16:04:54 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:3735
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233305AbhC3UEY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Mar 2021 16:04:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS9Jnu4JFh0bqm6GBRvlM5Xj/ZuiuYd8GomuqTCbLc0DRzUHeycqck13Jesd4O9bJJ++hAnrR3RAb5I0CoCtKaGkzfJszhynNznT/0QDFjTf9EOy5eK8hPuxuLb1D4z2yndY8ftpWo9ItKyghCgU50sShBqZwjz/FZzKwTnDBzbgohFmJZEP0v5uiFVfBlTrfSW2Pp3X5aRKG3ewYVlycePCaXgRfoITK4BdIHVEVyypUY43v5lvgZklPZPPnH/qXHHNRNnjoptyFGnjmV2Oi6L9isrwZo0+YQ479MDSj0rC4cgFd4n6aCZ58xBt4tpJyvvpBJ1k8yMnjydOBnvb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD/tqq4vOnApDLMfKehwlhYCt2yi3zfiEyDBBhc4Jd4=;
 b=jNeEZyLYc6URuF4z7K5BE5Xtm35VOPNXuXHXmeoXBwjUa8AQw1eiS52rBHXIvgK8vPci7njbyhK+iJdvqc53UGW7rZzyCfxTLF25uphKB01TB547GtA+5ykg/4i92DZ+ga5AN7GxLndpIBJTzViA6/G/mMdbnLayjEFlp6wXX1YuAPEZMiY2F5gjlpslNyr/aZlNjJ1Gr1qiprJiZz3xaGGqCIx9xBEUF1fw/65slxhtNC/nR2POn2O9U6fDS8oUsa4x2rEWqdxHyCFUXV0xlWFfX0IvdjLIsU7Qg9fQ3hyywLRg+BWshUWpX73M4sycd1p34a31lZKrApRQfQfarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD/tqq4vOnApDLMfKehwlhYCt2yi3zfiEyDBBhc4Jd4=;
 b=CjjVopyikS28JqJ2GzJ04piwxMtvZUpvE1KofODMgbLdfCRbZuGjudHGy+NvAopMeK1S83N8hzegCovvk1+wLyh1GAgbO2tZPaPWR+/40tub035J6NTLoG0jz4yGuAYX3uTRmEMQ9QpsihY0Z8obsO+8TAf/kIsTTMw3miKhYlAn28Jq/MbB6KS9HnhqaffUijMpLyEy0GNDxB8pa/aNM0jorJA+7EE3GJhdDb32OLmP7vyCqOMPPU9ysg/w+J1xbUWWogZGe/nuRT5wylX3nf8yDuEP9J3siglJLFxaYyirxfvOwssRC6K+J+frsAwo5CaWgWpyoOzR1pDGOBe7pQ==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 20:04:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 20:04:22 +0000
Date:   Tue, 30 Mar 2021 17:04:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v2] RDMA/efa: Use strscpy instead of strlcpy
Message-ID: <20210330200421.GA1435812@nvidia.com>
References: <20210329120131.18793-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329120131.18793-1-galpress@amazon.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:208:120::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0009.namprd10.prod.outlook.com (2603:10b6:208:120::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Tue, 30 Mar 2021 20:04:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRKb7-0063G5-4I; Tue, 30 Mar 2021 17:04:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c64e21f4-a523-4236-5b7c-08d8f3b702b6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01069869CD876B04A196FE89C27D9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76DRSFglYeZkdeg7w5YOqkPWO3dQsJO48S+haUetvTidef/M0K4QxL8JsyGB8jFzsDwzRbfNUArzJEIzXrBNtSOhIp3VBgUh8LrJnkeGkbX/2VNBIflhMMbtsf7Myfu0E2NUxsVdo/MKIPbEjOnCFOqYHytxPYzr+Qed2Uwb9vJxxCriAFIsVYvjucivA92//gfyQYCM1UeNSc9xG6EIYSbWvgKGUU44xJKMvrK0eOSn20ewnQwwRnifuWAx1krmEiXeB+ejglnv1YegWjLj0TGWIcVTWp7c2rsCQf2ewkGbgTgggs3khxdaqBJ8sKwqmJo/Vf6eyv2sp2D0ibgYDnQIpUf5eaVipJvcDvMMgdjfwZoKxKgeJBMtJFtb1o2Wjq3CY5ay9bJioMfNn/aeX9XmYdODLpIV7d08m7xwOt+FPgxsghLC349xQ2cIp7fo+I3Ake0KJLmNdcI0N4+v+BUwo2frknelrP0vJDPeux5+EwwH3KENhQv5Gx8GkMfA1sniGr7x9jkBlLh/F548109KIsU2Lohq2d0c/oi4GYTpB2Wd/gp3BH7AA6OemtjTfaN9Ln7nt3lK09+yB93qSzNP+Nd8uOX9I9f/RgttcxQ6xRYpUafb4lFqYGNI5AnCh14pas4xZUDoUCztFv31jAQDURhU4w6QCn6FcWOyM27Po4j4CMbKMLxw7eMKhz/EMq2sUa20QjdUWzi25CgKwn49cxjegv0q0U4yGQ9MbgmH0ERbJZOaKIczfgaOGUEAPGUcBXomV9F7cpBhk482Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(86362001)(66476007)(186003)(66556008)(1076003)(33656002)(8676002)(966005)(38100700001)(2906002)(426003)(5660300002)(4326008)(36756003)(2616005)(83380400001)(66946007)(8936002)(54906003)(6916009)(9786002)(9746002)(316002)(478600001)(4744005)(26005)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0szjl4UvaDWpZnXGCVGApdaRtjo5aHf1K1bpaExcGOD8s4s2JJSzIKdpOBub?=
 =?us-ascii?Q?cLwMfYm/33w/H4IZCgMTu9/59v5WMb7WBQZ5wGOnOYyKCs253Hpo7xqJw1aD?=
 =?us-ascii?Q?V6QtcZJVIfj2CoW9rqMYkmEbqc5X7dCIJZ7bq7cbGA0vTOooPr7a6WbpxQ82?=
 =?us-ascii?Q?JCilIOaoZ0qxjNqIdFfxpS6YmXAv5V+oaZv0jTyofcPjDWesVIlcmyrsi+UZ?=
 =?us-ascii?Q?ir/qZ85b4QWOFosE1Gx965icO4F+Qg3SxF0qd9ohoVYZ3uuxs3slU1kyLjD8?=
 =?us-ascii?Q?cJ+r2/i851VgWckkwGAw80fnvZISLDCVN6LTiP8Y/pPpZHWww95TZ3NJm+/T?=
 =?us-ascii?Q?w5gVv6OLy4D8l3EG98g9atfcU7OrABL/otPfvcH2+MOpn97MOVHtoEX0Ofoe?=
 =?us-ascii?Q?+naNeoy3/Uqn8cckRCKeuZ23OQBILyT6wflmxht4fGAIkuOQN8ls8VjRDE7r?=
 =?us-ascii?Q?3kOPaXlgrGHj8yuYq3xZxLZZqrZZLxfSMSy+d1N3M+Fd+WpB3k8Em/HberuB?=
 =?us-ascii?Q?bUqk0d7iQ1jgOS8sSVw47Dxk5d2bhVdImaIiOUkdzXn6UsJS2oOZNtU59pYk?=
 =?us-ascii?Q?a+c8lW4ik3hxeekO8kWBbkMzyxuYLKjzNjqSsTVcPyx2rrfWXmabIGGbBY99?=
 =?us-ascii?Q?VCzqUt7lSYiR9Fwvw1MBeYRDtufhzFDTvVENKPt3vc2d9qUd2u/n7zRdXPi7?=
 =?us-ascii?Q?8fXX6nQ6Yp8Bzgk2LBBgoyNHjHHiZTQINtvEDGwfDfTpa1wH7KR2NN8VUu7X?=
 =?us-ascii?Q?az+l0ezpBqZCC8AaDOdpEW0hZK12JZNo4gDzciW1Rg0rXVMlruJvYOCoxwo2?=
 =?us-ascii?Q?nXq5B4sGkMn4S43bBUFHs70XHWXpieNEBhf4nYfgnc8skXBDNZ3zMH8wBVmB?=
 =?us-ascii?Q?TDYKrNdBn1esHs/SxuSMj8q2gxlCe+WfwklGcPrmxGHl/umTy77mcD7+dsxG?=
 =?us-ascii?Q?4TCR1HrvsOj5pRMHMQriWc6TB5JjALHhbceqoNHe+hPPP6lsNW8rSgPVza3W?=
 =?us-ascii?Q?+eJIr/0C/BtGbzSZ2QkdbdIJ3NM+94cR5OvKv5PV+TSpNerN3qcewPV7kayW?=
 =?us-ascii?Q?jZdfx5BTDZeoLyz7QbU45R7RbuSwXdeFUOpOpSlZDcvyMXDxhH5rlHZIZRRp?=
 =?us-ascii?Q?I3/NTFAQ4QO4lPI5h9F4K91hHw6P3ptCNYgdAqQ6nJun6xsjoQVLXrQ8VJY4?=
 =?us-ascii?Q?3ibp1k8Bz5qwyHBEbmQKNzQhwULmbxxkGiaDEyIJaO6J90eRqGjkuJeLJaeZ?=
 =?us-ascii?Q?f8RYsPHX73Rw5rw4ftXzoW/Rp1/g27si4NTFujPE8ie0b0boan24IMD3YLrj?=
 =?us-ascii?Q?sWokgwNISDZGAhJNpTZ+8WaOdOvaTwFnU6Fjwbz+scRtEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64e21f4-a523-4236-5b7c-08d8f3b702b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 20:04:22.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgFzhhdI2EovYY6jMc9rcRxW47E+3WFIEGly8+ZTeqJ6SHnloNa7X/pFRzDGyfZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 29, 2021 at 03:01:28PM +0300, Gal Pressman wrote:
> The strlcpy function doesn't limit the source length, use the preferred
> strscpy function instead.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> v1->v2: https://lore.kernel.org/linux-rdma/20210316132416.83578-1-galpress@amazon.com/
> * Remove the min() in the length argument (Jason)
> ---
>  drivers/infiniband/hw/efa/efa_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
