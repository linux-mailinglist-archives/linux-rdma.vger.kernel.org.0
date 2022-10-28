Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFD611806
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJ1QtK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiJ1Qsy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:48:54 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA721347F
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy5i1ShTRdJL1Bp+KXcUV5LkwzMimftOJk3EYjo2kgRIlEwL7zixG6EQH1GEWuA10wUvW2zsNJZEF2RZellXSsd9zzH/Nhfv6pLtw/ayPlw32bEwUrRoHpBXBt3YHnFeynbd11xLVnk0CJThKj4v11QpvHtzzGYVlqEZ+hrofFPnkL5Rmu716YNSFnKymTXH0uMI0/yujYbtsm/iBy/K0ZL6OhWn6WhO0FvTxsw3xmIYALezBQxWSf7CYoOOUiQi+4GVnvtUMMvc6aWwNS5pPhb/KP6hHnHJs/fpIVlbvDZagK5HAEJYDeU2It2+DZSLYQgCSfUOsdHh9XXl7vqh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m6fbY3qhiRXzXmeprIiaS29acx5j96MkbXWm7n5woc=;
 b=ZdqGUVFuM82bfRL/ohiRtrUTJjWH1Di4a5Ugg0dZhEjgqyuuaNcKSrBlP/v0bImNxEd6dj8nlFUCxZVaik1PfBveMIRdUtEEnbnV6H606x5UP5r+8tH9SgF4ff9YIW2GeRx6ePvgQXfULcPCU3giruXOX8jPRjr+I7VVMvJZUF61eTnrEupaysiXhFqupPYGZU/79qJHj9lUlOx9ywmqZzx3yX2vasMNptI1pgGOBBqpmyDnPBkOlkGVmmOZdYR5OYD3xQyykOrhaXJoCzqgV6qP/MC0DZmmQqY0xBH7ivzkKaeIiVvpRCC1sTwHUdKwAwFZb4VLWf2xEldMguWm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m6fbY3qhiRXzXmeprIiaS29acx5j96MkbXWm7n5woc=;
 b=WRQLBSSRq5yn0mnIGslJAOizRzI1pBs53qfm9tjA4XXOpElD5Rd9saDKbFSvdl5Lrb2tF52skiGn84hgSIjcfpn2P3whijCYv7A2+GAZq7r2U0SwXe/lCnTk0H09q40Uwknaa2kgmEwAlCMbyrNOoXz5Lkaw60eF3emLOJyGhz8SDh5xj6Gn++z9ARB9dIQG3QUUVKXM2z8jLK55fUVDJ/M8XOR75ifNlyJnd3imIUeAWGh6dnCA/itwvvHIBoJacXbU4xO24hOARKB8wfVTeG8idAyIg+Dyy42qIazKWrASZ9ZPI6yVkp0iC2dyxFRRvAHSfjrkDSnGLXM74MH43A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 16:48:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:48:47 +0000
Date:   Fri, 28 Oct 2022 13:48:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for
 nldev
Message-ID: <Y1wH7Yls7ld66Vl/@nvidia.com>
References: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
 <Y1v8m0HliWscL6bT@nvidia.com>
 <Y1v/2ArL1wyaoB8S@unreal>
 <Y1wAFOfdSMEU6+kB@nvidia.com>
 <Y1wBGFHsAEgbMPhA@unreal>
 <Y1wEsfU3pJo3ztXy@nvidia.com>
 <Y1wHudga/a912vsE@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wHudga/a912vsE@unreal>
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef52c0a-e2b3-42c4-db00-08dab9044841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tFoCMJ2xYdNUqr2y7Bc1MMsGSrNQaCI+Uw1GEQt1IvHJ4nQtZ9TZ4JKGDKCQkRpJ+Xv+e6ysaLjzb15ABT3BCvY3QGts/7XNkm/NoaPZ/xIv53Qoic5KhXdSkfpvsxV4bEP9ij1cGsJDXtV35mx45zZhUakj1Yz85xQQmQDfxf4z/br8cAjUD9KkqrHB1bhUoEDUnyTQ9c4N4hR+EeKBdtnSmJk8gbLFC7gBF6td5iagsJnmxCv5CY3wnOJueAbmsc7ojePIIl4JBsqvd8SOFlYFfFML3/6uQtKPBOzxfnnCJIQZJRcCIZvLk3CcmGHNZQLkd1USyYao6nU/mSvNsvoL4xp2DzEYPhs/GDELyMDbNOSu1ZWbmJ6upa2PMCgrdoxccxOFhLu9MH8lek6RCDWxwVBRBPZFXwa39ShnmycfZaTLaYUU61oBObvubabnjin+KF296pSbx8hkYKr5CWppcVhPVcpzxlgCYHzAKP/johHhXzA6jqwGfb682TSEeaB8NTXPlV4vFAoilGuvcXYYKF8vujPDUJ7bjejZox/5gYKFststpAToDAjfIC1A0UxiH7GpqO3QuGLnrKq7LoUqt37LHFEVJ8ryOHkMuZlnVXiCuFWtenQd4SYfXA0i/56zezxidkOEEBGF1szaTfkAyp8IC8uBzYdknZ+dYWDq4Yg0XaXfq6XlEy3hK90ZHYqdVzSOiEXv2Ip5JISXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(6916009)(26005)(5660300002)(6512007)(41300700001)(8936002)(66476007)(2906002)(4326008)(8676002)(186003)(66946007)(316002)(6506007)(86362001)(36756003)(66556008)(83380400001)(2616005)(38100700002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTDqOZ3tVRkLjfD+07ypbWsZGRjuAkd+ffLwQ9EEiBmfgX/pXFV+Yt7gsu/a?=
 =?us-ascii?Q?Hu24InTFTSZqz2vs+4mhX3AUNMsoaqTLGGXA5d+4Kpt69K4GOdzeYz2yXFNy?=
 =?us-ascii?Q?HUl2ueSK9Ed7DGXXJnnl7PpyEWeclWP0vjvdH/6oKm7CmwIQspMZg4io8PF7?=
 =?us-ascii?Q?XxXhpbriv2vkVS43SbVekt9/aZNJUlim546c8sjuiAwhgo7SmyC5DnrO7ZYH?=
 =?us-ascii?Q?nzhpWNCUrZYYyLBH6RmTgguTabAK6110YPVxpDlvQjkUcvCQkOlNBcN+q1NT?=
 =?us-ascii?Q?w5hTmI9Mqj8z78tcrD4FiV1yCpQHRl0TjMFdka+NE6NhBRPV5T70zC4h9mHj?=
 =?us-ascii?Q?5h3r9Z9DSqS9xNz9P/bwMSj3m+1Grc8W8eKQVfHlK53w/Q/HN7qkaUAwueeh?=
 =?us-ascii?Q?1zNmP4uug6szrNbT+TEftqNYIuUaGHD5447+Fz7AoGwrUHJEvWpZ2XS0NjNe?=
 =?us-ascii?Q?gtv/Xhh/WvW5BAPHfy/TNGHVnJhWJTVNPptDidemkVxhuiIhxxzaMkkXNmPD?=
 =?us-ascii?Q?BGH0itmjoXOaktQXMb7qPxNgMhEzqyaVHbFSVvEv+P8I203NMa9iJFrpc/s7?=
 =?us-ascii?Q?WWNJhDj1nZGdC27K37VRcTm92py6HxGt2hKMx6VK8y7fuKlARDRXCzOTlTN1?=
 =?us-ascii?Q?5swM1BNusccK66Y7yZ4g4xPX6MVwjxQuD4ZyuKb2NBydlJdn/egdBbwGDlXJ?=
 =?us-ascii?Q?nqWOO0dhUs1mSuVngE4hd7AzEbqbmEeqp46hy/ko4OM5EGVIYqReevrOosGa?=
 =?us-ascii?Q?p3ZKCOiA8rxM+r9Kkh/o/jLYDkjMvv6vRm/Dc81gx9obYaCuDWf3FVxOTrY/?=
 =?us-ascii?Q?oBSiFNr2AbIS3vxrkAwbnTS8mQPOAHMjRlG3rarxIOLiMD8cU0q1Zvb7/kzj?=
 =?us-ascii?Q?NX3LAf6JvevLGZazv4nNbl5DZ38T4RKxSOmRwLPT//9WGvgPKAI251BH6SKU?=
 =?us-ascii?Q?6bP1yxLNwOt99a70mP7PkFoFiUEk9PTEhtPnmg679J2nVwJNrpkF77N6u6p0?=
 =?us-ascii?Q?CLpMw1luBvBqqpUiX+pfaR+8RRVHWK2cwAyiAKClrRlzrjJWeNoEEQBUKh6/?=
 =?us-ascii?Q?+9SBXxwgCBsZ0zzPLGOP46f1SFh6xjpaFTxg1qkoQCx/Sy5LTZEniDSQtEqE?=
 =?us-ascii?Q?s/4JcP5bRYKOjI8CPgKNPiUnUc3M41uZww7yPtZtkC/WIUSvqD1rb8ZoLx3Y?=
 =?us-ascii?Q?W7lVPdMG7PLxozhBvPfgubW13MQT4A/Q0GBj1E5Pr3jqEcgOjXafLS9mhs12?=
 =?us-ascii?Q?DH5YfyX+ObDyYK/GpdGxvWoZ4mTBE9Owol5U0Je5tqvdu8oG2ZIPbvTGaCGz?=
 =?us-ascii?Q?by4urVcFLJkMR4XN6zKaejiARR2wfd28FEUYzYVElw+6Wzol+waxCckiV693?=
 =?us-ascii?Q?d5swCUeO8qgoekb+emIn9IFWlU8uk00Tyi9ZL/USkOHuMLyLKNvzT4ufeiUQ?=
 =?us-ascii?Q?cujlf2rxnW8IDoUwQUnPtbq/fNtcYYROsq5SC6pQKLn92H4El3f7K6UdtqzK?=
 =?us-ascii?Q?XFYq65DSWy8WRAXVpgizkbwZE0rA7hYyiYXLeOf2bmgzGsf7v1zfrlzqKZuY?=
 =?us-ascii?Q?bTgmkd/1nOTa+ILbnHs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef52c0a-e2b3-42c4-db00-08dab9044841
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:48:47.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWfZy3FAERZX81De9cg+0D9p5mdMkPUcUURoPjrY9/9S7Hf8vJfqU8i9G3sLbf7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 07:47:53PM +0300, Leon Romanovsky wrote:
> On Fri, Oct 28, 2022 at 01:34:57PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 28, 2022 at 07:19:36PM +0300, Leon Romanovsky wrote:
> > > On Fri, Oct 28, 2022 at 01:15:16PM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Oct 28, 2022 at 07:14:16PM +0300, Leon Romanovsky wrote:
> > > > > On Fri, Oct 28, 2022 at 01:00:27PM -0300, Jason Gunthorpe wrote:
> > > > > > On Fri, Oct 28, 2022 at 09:58:56AM +0300, Leon Romanovsky wrote:
> > > > > > > ppc64_defconfig) produced this warning:
> > > > > > > 
> > > > > > > WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> > > > > > > 
> > > > > > > Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
> > > > > > > and as such doesn't require any special notations for entry/exit functions.
> > > > > > 
> > > > > > This isn't what the problem is, the patch Stephen reported:
> > > > > > 
> > > > > > commit ad9394a3da33995dff828dbfd4540421e535bec9 (ko-rdma/for-rc)
> > > > > > Author: Chen Zhongjin <chenzhongjin@huawei.com>
> > > > > > Date:   Tue Oct 25 10:41:46 2022 +0800
> > > > > > 
> > > > > >     RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
> > > > > > 
> > > > > > Adds a call to an __exit function from an __init function:
> > > > > > 
> > > > > > @@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)
> > > > > > 
> > > > > > +err_parent:
> > > > > > +       rdma_nl_unregister(RDMA_NL_LS);
> > > > > > +       nldev_exit();
> > > > > > +       unregister_pernet_device(&rdma_dev_net_ops);
> > > > > > 
> > > > > > Which is not allowed
> > > > > > 
> > > > > > All that is required is to drop the __exit from nldev_exit, 
> > > > > 
> > > > > This is why I dropped both __exit and __init. I see no value in keeping
> > > > > __init, without __exit.
> > > > 
> > > > __init works just fine, it will cause the code to be unload after the
> > > > module registration is compelted
> > > 
> > > The code will be unloaded as part of ib_core unload. It is not different
> > > from any other function call in ib_core_init() which is marked as __init.
> > 
> > Huh?
> > 
> > Only things marked __init are discarded after module load
> 
> nldev_init() has single call to rdma_nl_register(), which part of ib_core_init() too.
> There is nothing to discard.

It discards the one statement function since it cannot be inlined.

Jason
