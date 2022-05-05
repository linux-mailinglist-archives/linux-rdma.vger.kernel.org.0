Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C80651B4EE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiEEBEE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 21:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiEEBDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 21:03:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439A222B6
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 18:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aurr85m9DilWfoE7uAL9eT28SJDu3fbWSIPUIU/MbFmEzK3MpvPMvFhYYniVyVtvg7D8eFg/aZoEFr4Kr2QUnuizRJdSp9ExGQr/R1NmWP0DrKzAOsnEautE9fklMdMzoscSIdujiDbRkk+ChV2MIyvjMJruQlBUNumgKStAnFWITIUasuRSbwpD/I84sFta2tDgVpFymB4rtWS0m2TBkLM10rPEuEZQj4VZL7PQIhPBMvuuJg1uQGhtm4MzOdRITNUJ9CkmBT1NfD3/hAQU5ysn5COPAE7bQT5pGIWSGbAhiUSw4cbcyuCOPpDMDSGv35vXek690IhXLV8zgmrPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te1XBSYOaQetpsKIojn6CkKFyBEO793eTiild/wBFGY=;
 b=jCzzLGuelCDKgEPgE+si6zKaf//LYltEc2NRAuoW9SP09YkqBhG0v9UErT+XAoF9ZXKqx/decrF5eWCAQpmbA4DcN6ARFd/XGa+OqdeyvU9P89h/wbjsoYDePgWOKitqGA8VqKFA+Oz3FBTh+9Rc0CA4jY/B0E5vOjCk08v4yRqd7xdv7EidzznaRF5Byqgu2iIiEt5uyTty5hOdpQTjwwXAs9ntHWUJLCJgmq3Bxq8qiY4kDrO6o4Sbc+jafDb8Z/EXT78/PAFnaARZjAnQLe6u9viIqNtXRAYUieEm3x3D4QWGlN7n4rWIhCUso6R2m9J+uBQQ1f4HoozUl976JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te1XBSYOaQetpsKIojn6CkKFyBEO793eTiild/wBFGY=;
 b=IyfFjMTJXuelA6lXQSvdKbnsiJhoQ3d9/1JV8YR375zgdk7NsWfJZCmYFgjYQBW6X/+8vH4RLAZx9NWKIF82G3XozXLf9Y5hQY65RJ4sXPvqo9K4EAJQJoPx7BeZe4Y/bM0Wc3Cudyf88ZBCZOTeLhPnySc178lFalnpA0kglY/k9OSMzu1WYNJnsIQYIA1uZ2hX5Z2d/ggeT5BmxasZToZ8+Kwfy5qFLFwhqw1U7JrYF7S51qBDFHJ6QV0nYioiTj71YoftMu8MBBr1I30VgVFGjL8UHzXPIvvV/Hco+Mg4VSodHM4h+RPDOV8CwAQxp8l26unw5u4n8LmN/OIQMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2733.namprd12.prod.outlook.com (2603:10b6:805:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 01:00:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 01:00:10 +0000
Date:   Wed, 4 May 2022 22:00:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Remove the num_cqc_timer variable
Message-ID: <20220505010008.GA220614@nvidia.com>
References: <20220429093545.58070-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429093545.58070-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0322.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d2430e3-d3ad-4f54-a544-08da2e329a4f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2733:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2733F59990896BD758DB8D6AC2C29@SN6PR12MB2733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1lYp6Gy+Z+RmEqLWQDRbkyVFBYMvV4162Y54Wk9DgzNKEMP+ZzDBwXVZrs3a0TEaJJOUyUJtDkJg2RxduAo5d1ne0/wvS8J6Ruqhfjm6sQ4usVk6p9fFHe7nv6+uuAGbc7eOOigtcwzaNlejSOoY+Q6wItumOJ4UNQpjPDBL1ovb7nXtbESklsS8Le5VRZTb0svGD6OWxt4HbLjvfZdI7vNHY5SvKttenhygbTU+uIRlCotCIG5nXNUB/k3/ecoNYGZHY9lypfJdNgnYJl3sqqG/FcPTgTNvGAkls0qyJRUWzvnnZ+FMG6+7hYLbxc5uvOVYqwFW3aJQxtZVc/JwXwrco6CnhtTxhzjNNj9i1sUCEG7qb77Ile2p1eSfS/QVQG/aHjha/x0xsI0IroVotgSilGIC0SCiYljYUPAHM7xfAevJ32PEWmFJlHERdQqWmu5eZLjfk9k1M/WbkzwIdf4EMLYx5SWW+RNccRODL6C/FXqkHTs1EllJ9Yg68+EiSLScsibETclMco6nXkwTI4b/dYU1j0nBef4v4wjjbrmk0Mu1gcy5+BJ/VRwesq5/v6vobDFlGOUjQ9puYOVHkLWKX59Q5hSCI0C9sVORvPx3Q4wgE4JSlE8C+MP82SVR4lPT6HBszX1lnBlXD5puXHL0BCgFZ1L5jxLUO9IdR5TS3rpQorlaTUaXNDy0S06bIR8oJD1jCJjcS24g2wLaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(186003)(2616005)(1076003)(66946007)(36756003)(83380400001)(26005)(8936002)(4744005)(6512007)(5660300002)(6506007)(66476007)(508600001)(33656002)(86362001)(8676002)(4326008)(66556008)(6916009)(316002)(38100700002)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gt6XpD+/wuAH1+zXtlvTwR4EPRFPTT3C8LSyTLQwTXP2yeT1fNTg/aMai66X?=
 =?us-ascii?Q?9MTBtRdMRWzMuXLHL3sDWiw1i03bkjqqKA0xLMOGGCKcqMI6BXTX74wcszqd?=
 =?us-ascii?Q?2FuNJSS4/7eLNn8I/ygSTLvpH0X0qyxiGXRBRZsnjQBR5o571Uv/V2LJZxqs?=
 =?us-ascii?Q?IBDjTIIjHc65gvoOQ6b73jTliaKlNnUP2fc/Za8n4PObmYwQHgL/ZJaIa8Jc?=
 =?us-ascii?Q?AeqIBm8hmh/asWNseL7qxnFXlvaO+MmSmAWGHGLfM7l/9YDRgULoLaNBepYQ?=
 =?us-ascii?Q?vjTM874OeGbp6KR0q2L5zsGyw/Xs7DU7I/FFnF1einOOBEGYBBx3MdAS9hXS?=
 =?us-ascii?Q?InkQ8K9Wu8pZVH5pDGseQQGrgKJSwsFFUDdFiqf43cHq2rNDp8L1EPmBZu1P?=
 =?us-ascii?Q?zz2M8xkHwG4m0Ag2+byYRtGVDTlWN7NKrO+ZSeufPqLDMRcQSv59jh69h23Q?=
 =?us-ascii?Q?uYuqNvsFOI7dGnSLQRe4b3tNqCl8GXwEJKUeNynEAu93pQKBmslINbgarb7F?=
 =?us-ascii?Q?3jGQJt6lYAAoDRZbXT44L1pxmbqJ3s67EFM4geOb6qB9XdCmJnIOhCZXNMLt?=
 =?us-ascii?Q?So2tMXvPbXWHS6scmaciZRGcaFIIudZW1ldK2ZoGspHNwppnGN09/UidPN7M?=
 =?us-ascii?Q?bC3sigwt7/JdUvKELcxHgLk1fKBYJB7lcilSu4p92/+98g3VlVOU09MopaIO?=
 =?us-ascii?Q?YuXsT3AL8B04r99O85FIYFxPgS35Rk8kKUPjGXJbiBget4o2rA6E0jxnKmwg?=
 =?us-ascii?Q?tA3gY7aCiYkcyBuMAjZhxdZl8ozjeWEMlapmS3FO/mLNSBYmAyu6ZRCemEc2?=
 =?us-ascii?Q?8Ky6LJ9ZBB45e225O45rhdOCXEWUIps9vhAZKzT6nkemuf7m8+qrvBq3/GWX?=
 =?us-ascii?Q?GadvSElfRXClAMtIt8Z9+Z7aak9X3F7jFe0ivVFygoLmFujUMt1l3l6k2oOD?=
 =?us-ascii?Q?WNlUesEBUi4H6QG8VvIUnYoh0jODd3esu5TAWSI/VoHpNYDphJXjZsYc84sP?=
 =?us-ascii?Q?kOUVKPm61vOE9RlJbM87UlX4L+TVVxswgdeqCnpIIG7KtoE6FYNrb+mxfmjR?=
 =?us-ascii?Q?jTW4gkGm5PjfV7pj0pm7wjiTVEOgQMyzJ5Nv+hdZQYkMd55rMSmFjlWF7bP4?=
 =?us-ascii?Q?bCHwDjbYdHtpKbu2YaQ9MP7DDLLDpCuL6nkXRGzXtHr7sc6+7la9PHCGf0Ka?=
 =?us-ascii?Q?erRrdTEqhcplRlgGpRR1N8fi6JS+1Ori4UhCjObWsMe5RiUrwtzDOKXHZlj4?=
 =?us-ascii?Q?EOlFZv+VdUEAeQZuAgiRbY5u0UzhbYjpkUyc3JCj9MdgCzUbY44bg+0A2iMh?=
 =?us-ascii?Q?wmB75KjiX8D358Efy3mkRgKG4xo6TO14DJFAPszOQEmiOqTyx8TFjqPemtDS?=
 =?us-ascii?Q?CssxadCC1FHPH6hBcIT/rxhUGOoprfMjQD/oV3G79lRQCyeDIYqFYOyMQ2d9?=
 =?us-ascii?Q?37ybf+UE8nnRTRLhe4vTg4NW5Hb+WdzzKGRplu0WkufX4TQAEBUQ8GD1Vd/v?=
 =?us-ascii?Q?ybOyTCnJ8FQdRGLuO1lZwNELABk6Exh0nf1IiI04XMsQo9dvBHOqaArcSD35?=
 =?us-ascii?Q?JJ8gTu7Y1QQuNRHLhDE+54Qz+NGtSLd9gQbz8vd3hAXYJV5dfGSr7MkqE2B1?=
 =?us-ascii?Q?JrV/SjNSz9WzT4/TZdfUUXJYOtRmbCDRgJJSdGnmzyUi5yvkfJczE+y5WXnU?=
 =?us-ascii?Q?PR9j0Vx6pMphgjhdEqx6NDrbi1od2RR0Sv4dSgHKIn9jRS49Pus5Zg3mG/Tn?=
 =?us-ascii?Q?7btDHFZtlw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2430e3-d3ad-4f54-a544-08da2e329a4f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 01:00:10.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrIUbkH+kooennd5iUMzhLrMNYZBiw5mVtFO4qsqZ885hjqoDp7TInPhtdKbyVBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 29, 2022 at 05:35:45PM +0800, Wenpeng Liang wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> The bt number of cqc_timer of HIP09 increases compared with that of HIP08.
> Therefore, cqc_timer_bt_num and num_cqc_timer do not match. As a result,
> the driver may fail to allocate cqc_timer. So the driver needs to
> uniquely uses cqc_timer_bt_num to represent the bt number of cqc_timer.
> 
> Fixes: 0e40dc2f70cd ("RDMA/hns: Add timer allocation support for hip08")
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +--
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 2 +-
>  4 files changed, 3 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
