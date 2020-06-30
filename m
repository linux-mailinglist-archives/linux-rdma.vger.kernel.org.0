Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4720F424
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 14:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgF3MGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 08:06:50 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:8396 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbgF3MGt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 08:06:49 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb2ad50000>; Tue, 30 Jun 2020 20:06:45 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 05:06:45 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 30 Jun 2020 05:06:45 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 12:06:34 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 12:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko9gU62OJ6Ipkr1tYDe8oNwm1QeLD04IXj7SI4r07YiNixsFmk49mu1XxaCAT6Ym3Pdkex79rfYngaAzR3ISYZzmeo+uWxTMShEwMg2KkNR8hOQjxcV2xyymsniBXr86vMTdd1//6+raRneVYMHuVEMb9C9lfkui/eymWTS5xDXJHyMjnnsf3mXkR0W2o3Lo2LoTPaWYJNyvXy1FGQBIcH73EImKR9ErXcC2m94U+7ACT128CgPXOFUHUZBTqzpQyL2v46wi0paA9YDpwMbQZmXIZBtbFfbPg2twyMIalbAUzPyAZTC0LrDHlEre6qBZhOzEjYn9Y6ykDIx3e5ZrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOjVYf8haAHEEkgwrjOl8S2Wd60uelMux0UlgPZyeMo=;
 b=Gv8VZPzxPIKPyy6kuZb3yvboEb1GLkBRxyzr/Bj6OQvzqnGjKlbC8hg65O9i+/3aM91AKjet7FJOjAoBMq9imc56d7GCcwwhzqk2/tr34IKwodPm/gLlB+Jy2ulDnH5KiSeHKrlhI84TqG0t2UX5EVdpNVJhs6rqXzbP2/vs3rGu5a1scvkf3s4DzirjbystMm6it4ySZgpYB1wFhyEQfEPj6GegaH3W2Cmv7iBQ97m/CDLXM367LEJUY86WxFrstD43gfxuXuGwwLJo8jQlFFQf59Af8eLFUU+vUtc1cynsnNn+WVKHaFTbvSsHdnoaLzquHO6wdHRU9bIP/iHLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 12:06:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 12:06:32 +0000
Date:   Tue, 30 Jun 2020 09:06:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Yishai Hadas" <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
Message-ID: <20200630120630.GD23676@nvidia.com>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
 <20200629153907.GA269101@nvidia.com> <20200630072137.GC17857@unreal>
 <20200630113729.GC23676@nvidia.com> <20200630115224.GH17857@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630115224.GH17857@unreal>
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 12:06:32 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jqF1y-001Y0x-N7; Tue, 30 Jun 2020 09:06:30 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0551446d-fec8-4a66-91e3-08d81cee073b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR12MB359505E1ADB1632BF736A326C26F0@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqNa3+tS1Ko2DEp1Ze70dRfHxbdFhfmptqzfxJNqiwjEMwuxMhCyqROqKmjjyP2MAKBwI+aXMaGykK4nMDbolwZJXRxzpgUSdZuJBFsMvtEXLu90igIucPIGAIOU0sgTA3L1ZxzveygJnoyZcGAUq3E2cFmlROdbgfYXZTH5kINsPTqMfNZI0iSb1OQxSwZgpt4M2Zu8xTs9B94RTlXWGF6Mfpk3zrKUr4DKFY3BBraK6iwq4XGcqWBD30lLuLzDNhVnEkcag8/28Y3OB1zRTKAvzXfjcbHH1Bcx2sKkeebORuBb2bwkYKXbwpKRNhUJraLnbnwJTrJOmUQQ/LQ9ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(1076003)(2906002)(26005)(66476007)(66556008)(66946007)(5660300002)(9786002)(9746002)(8676002)(33656002)(186003)(6916009)(86362001)(4326008)(8936002)(36756003)(54906003)(478600001)(316002)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DW6D7SE9CCaWf4EoHKW26S6RxmuvOmpqEjfYfpDrSevOoR+2oI1CIVgxX5eLDGxxe3RB2x6BhbLl+XEJBxptFjQxy6lwtL+UYC1tqz6WHS4zjs9MjrJ76dXbvW5Mz3X5d3MhQSn/TQPNTFdoQOVAzhp5LvQzGYfAD4MzeLKRTAjujkXYyoM5H/XwSfX/Mxk41WLHcOk60jnbhPyJAYAnKCQgxVyue4VmJdIVTl6wxKZDq7/qo428/g+GW8ueOwThiYQ1Lln0wTveHP3Pav8nrU7oORXsPm/Y9qlsK7yycQ0Jse45FbpZizhALK6vGkAaD0W/EcPqCsYx+9rRsbj+dTL5EC3kQZZ8AYDLqWJSxLwW4uRnBgjW8Umlc5UntLOtRWzMUu+7aG41wtxuQal2SYnpm3+l64AhKGC5KkBwBHMDd65YK9isXppHk0W2RshMtTfjj8zt92pS6W1o+4q9wP1CAF/VKVnBSVXzCXZCbf8+ka7acQpR8R55wCK4DVNA
X-MS-Exchange-CrossTenant-Network-Message-Id: 0551446d-fec8-4a66-91e3-08d81cee073b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 12:06:32.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1kSh+G+cqd3XBSnbZc79Tjf2ZtiPqYYLtNYIPIwu5JzPInC/Ji0f3Kq5WzGZxot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593518805; bh=mOjVYf8haAHEEkgwrjOl8S2Wd60uelMux0UlgPZyeMo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=CuQLFxchYjXjOyZkmThx53/Sr6PC7cqUC/jY6EHMVhBTxzRuBEjoGjL9MvANO8cqQ
         ZFTduv42zkW+4Lmv7dqD7QwLodoexR5azHvBPC+H89s+ePmo3tBnAKnByz4r5H32hF
         h3RDfw9M7ht6IX25UNo/WT1RvH3EzNHqJkoIOI/y2dFCpfVDXQky6VwdGNBKKeP4KD
         1rf7tGd8Jyqgb3o0TEmmGjiqz6gzLnEr3S+a9Xlz/sSr7M8cmpFiWsJbJCzKGvMuuq
         PRFi0qAxr6K1PDWJ7JgfLbIkGSqO5Vd7zxUvteHcn+Zsxg1JApfxrd34hIEfx7nZ+R
         x7rpTItChRnlw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 02:52:24PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 30, 2020 at 08:37:29AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 30, 2020 at 10:21:37AM +0300, Leon Romanovsky wrote:
> > > On Mon, Jun 29, 2020 at 12:39:07PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Jun 24, 2020 at 01:54:22PM +0300, Leon Romanovsky wrote:
> > > > > @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> > > > >  			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
> > > > >  			ib_uverbs_ex_destroy_rwq_ind_table,
> > > > >  			UAPI_DEF_WRITE_I(
> > > > > -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> > > > > -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> > > > > +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
> > > >
> > > > Removing these is kind of troublesome.. This misses the one for ioctl:
> > > >
> > > >         UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
> > > >                 UVERBS_OBJECT_RWQ_IND_TBL,
> > > >                 UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),
> > >
> > > I will remove, but it seems that we have some gap here, I would expect
> > > any sort of compilation error for mlx4.
> >
> > Why would there be a compilation error?
> 
> I would expect BUILD_BUG_ON_ZERO() is thrown if ibdev_fn == NULL

??

> > And it should not be removed, it needs to be reworked to point to some
> > other function I suppose.
> 
> Why?

The destroy function should not be registered at all if rwq_ind is not
supported by the driver - this is the methodlogy.

Jason
