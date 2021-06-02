Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9F39930A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBTCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 15:02:23 -0400
Received: from mail-bn8nam08on2058.outbound.protection.outlook.com ([40.107.100.58]:38049
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229489AbhFBTCW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 15:02:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh/jrMPTHfiz+/bxPWwFKc/uGn2s16wbKuxuFMRzkcVggQ5bzCklPjDqrSi4ZJ/8EbBXI9XffXhZKgUkGqq6+OidJ0a/T19/HE8BKZeG6vCigRLE62lhSW04HU1bhkQf1AymbI+BTVmL69Qnx7S/WM8NQ2KnksooEpkzFkq0qZRxruv4QnWJqbn7AYfPs7KRl3zgVnoHC9wZAuh2jc79gZPVtK2GiKy4VbcTIM8Feylnv5qWbDwiHqU48RGvpwHcbwK/JOeZTiETzctcNlSAm1RVrnX1iu7cvy6Vn+nzxNdkp4lBu17W7Dkk4hAQsd3guXoBH14a+eKoV648qh97iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yjjfltbxTW1ACHVKAGkewF2D+DYNepyqlu9k+MErW0=;
 b=P4e9UCzUrgkTnKZ8nG/ZaLvvmgkVUEX2ZSMaQfoIVBy2HhOhL0Y/4gkX5dJ9bdBOFSUV1Fc6oMvyOgsicUqepr+L6uPyEwSCeAclowOe9PxYjTBLJF+g/ziGukPziA3kuPjDeCKHu8JinW5N7+/VAwz/QKFT4/RNzuSpKFFfbEFNgvD3FvZoJtUSuuPXT3oKQBHLDdAcNzIEuDUb/lofS9NAY92OjIl/2kpSUp8NH6S5SkqGD0+DHpYJhYl4ba5bAgEFFYLc6HjCbR+rX5YfRvbqbbiVrbIZaw9GVxGV+XUr6ZEGYTFgZJK/4hycak+1bj7Vhx16FvR2KpzGmorxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yjjfltbxTW1ACHVKAGkewF2D+DYNepyqlu9k+MErW0=;
 b=kHkO9DXIVUkKWpD2swX/XCKoprsTDtaqXJXKTm0TvfMQXFiGxJm7fqflungHhMZlW1w/dYw8u9qBKHHNRHDH2mAlmHj2F3dKrqA6aJ3gbuuozlf+kq90NTaiAA5KGDBZmwfouiHTfs0dndisgL+BhJSVAaanj0CjcZdCHevUdCE1nzvYz2ru0ow9ZMzewIu+Xq8T1N8fb5115srR4gTLtdw2R7KVin5vh0ZoBn3ggOJzGw91ldiOmkN1+u1muDu20wV5cbsF5tmJB9exsoEbc+5r5yLjIs03YCIQXaIxTeFdY5CLYA3YwN/th3hj9ZwDccr/pYgXuBZEu92/nUqS/g==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 19:00:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 19:00:37 +0000
Date:   Wed, 2 Jun 2021 16:00:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v4 0/8] Fix memory corruption in CM
Message-ID: <20210602190035.GA140508@nvidia.com>
References: <cover.1622629024.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622629024.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Wed, 2 Jun 2021 19:00:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1loW6V-000aYv-OG; Wed, 02 Jun 2021 16:00:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d0fa92-c26c-4cc5-8b5a-08d925f8b4ff
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB553885BEA940290ECF05839DC23D9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y58VtlLtakPqrqfVj2l82vrtHhYemVRdGkHvPri6UT0XL+MU2u0rS1w3Vpjqmcn6z1h5TaiFoUFzChneQUbYqhrwKLscoNi79UMaFRKqD+qwR7sJIFIWkCgVRtMBSZhDj6zfJEX5RlxuHmhh1EdZO9Ld0/EE3waJOMelSIMplFW9xbIr8RkN6WdPc3GT3vQEFLyY7dotiIQ1wlJtMwhyYIwesQeHD1oPE9tDtgIL3BS8B0MEHnOwW0ZsvVntZa/O8iUhqsjOYMb0zRnKPRNm1oSOpttZnekSCsAU94gzqcZWJFidc8CllIJNMgBSP7+t0vbOCbkkqGGyH1faQCgKf10eRSfDCYhTgMezGXPOvpYXhGUbFRDt6CatR8m75r9IG/1jqcufgV6Nkmprnki8MsbA7FGJlqks7MZYzY/Efi84Z4NeCXb3Ch1rNMwVKs+el2jEd/2QA0fsX8AdEkLRPSYsZP4+Iry3WeTUBcYjC2uC7PHwQdEFMVPBDEa5j/t2Kk64TTB3Tf///K30L0KZNEQP46kp9Z3Lu7yL+tu7HANfuQ+DDblC/2CWSk2ojE6Y0W3mEFxpDf+iYQ5c/NU3afUPNbX3ueck5WXsl5A/2lR5f5AJReWpG1I5ox0Px0OY2MKfBtzap+cCyY0wjIt/cHvJNEaP8RR8C1XhdNWozZTqcxrQ9j78i5q3Iv6pMyM11B/R+z6FCV8QbnnmVKTc4mrr5DfSNlKrIZG5mnzT6kARoPyp+Ds0LWRHO/++y0gIRs1opsMSIq7iqq1joGvvE6H+GYwBE5NmE7oXdWnkZgMisX7WP+ByDKFvcOFhXzqn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(366004)(346002)(9786002)(86362001)(38100700002)(33656002)(9746002)(1076003)(6916009)(36756003)(8676002)(4326008)(8936002)(2906002)(316002)(426003)(54906003)(2616005)(478600001)(5660300002)(966005)(83380400001)(186003)(26005)(66556008)(66946007)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZByjz0m1tVJ7ckuyki2B7j8kH08FM2C4UomR9vOG6X48uAQbyLVmVJXUwldWjTYTW0BL4Zv/jQJsuHeJIPsh9KSl3CHbNiUVV+MkhxxDJz/9H/aLieJxNTDMKcYtAQAR5ItlM2pKddLfW1I221LRdWAGV8626CFsDhZ+TODSo7iYf2eJ9fv2DMMIhS7P3fbEyzBGMDSYvbx1yN8e/7zTzuStnk24pRzVfR/WVVQ9HBeWAKtOey54LZjCKixy96StDWgNunaNsCpvaUJcvupSJlBw1zj1cxICt/V1LR160NxRzni0i1kNLVsMFaUHEthQDAiIpkpEag6fZJoav78HbJcQeJRupWi6MCdyNsHxx9EDhX/Vbua+N8fJBPi72ViYtq6cafwg8kJIbyu3tG1FgmOQzG+jlD43ToHsEgTJNgC2P8EuJw+QaWPMp5ZXz6VGtLfS+rpBfA2jWPExAvx9dq0+nNQEb6YqcBEJpVAtmR661opLpVRp3wAavc+Po+dV0kMxNqySP1Ix4D7qIzk3vbCNPTYXP6KZfVTJAfpk1LLmJ9yLgK60EWyY2cvf/IqCACAgeOP7CYPsZhFizUMXqzVNgqvBfaySN0x3reTePU0jJMaMGk79jN34xOwuLJXTrSA8wyWptFw5UjPvPlcpssxq+QUHkpotc5Hjh33rMZOcuxNx0aWjqGyZ6a1lJTJ/VfIbvpi995KfuNUm63rIGs1PzBx3XIQh5/UYny0VMtOXIIYHev6I9tVLWBCgXxKc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d0fa92-c26c-4cc5-8b5a-08d925f8b4ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 19:00:36.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBJtjpSNKPGPNKwdfhUNsqfQew+rucxAyTyEDkFuxU4bZ/EU3ru8HYiYXLBZiFAW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 02, 2021 at 01:27:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v4:
>  * Added comment near cm_destroy_av()
>  * Changed "unregistration lock" to be "mad_agent_lock" in the comment
>  * Removed unclear comment
> v3: https://lore.kernel.org/lkml/cover.1620720467.git.leonro@nvidia.com
>  * Removed double unlock
>  * Changes in cma_release flow
> v2: https://lore.kernel.org/lkml/cover.1619004798.git.leonro@nvidia.com
>  * Included Jason's patches in this series
> v1: https://lore.kernel.org/linux-rdma/20210411122152.59274-1-leon@kernel.org
>  * Squashed "remove mad_agent ..." patches to make sure that we don't
>    need to check for the NULL argument.
> v0: https://lore.kernel.org/lkml/20210318100309.670344-1-leon@kernel.org
> 
> -------------------------------------------------------------------------------
> 
> Hi,
> 
> This series from Mark fixes long standing bug in CM migration logic,
> reported by Ryan [1].
> 
> Thanks
> 
> [1] https://lore.kernel.org/linux-rdma/CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com/
> 
> Jason Gunthorpe (4):
>   IB/cm: Pair cm_alloc_response_msg() with a cm_free_response_msg()
>   IB/cm: Split cm_alloc_msg()
>   IB/cm: Call the correct message free functions in cm_send_handler()
>   IB/cm: Tidy remaining cm_msg free paths
> 
> Mark Zhang (4):
>   Revert "IB/cm: Mark stale CM id's whenever the mad agent was
>     unregistered"
>   IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
>   IB/cm: Improve the calling of cm_init_av_for_lap and
>     cm_init_av_by_path
>   IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock

Applied to for-next, thanks

Jason
