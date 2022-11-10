Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6896624AA3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 20:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKJT3r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 14:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKJT3p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 14:29:45 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFD8450AE
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 11:29:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBoTBgB+5ogg84K8/Jbbt7y37VVN72H77ErltGlOj7GC+10N9NMbJKGSptetIWav2XR1sydiOGkyL0wPB3MGFYGa99qJHlfGnlBK7k9Mh1ZlsfWDmbglqawtk7RMZG83deU02eX4RgUG9/MqmmEzIV4vIPOvy1hY3FlHtIbQnrfDcKKja11Pua7HQO565vzDUmwPv3dPlQrQYeLaaO6TXNtF+OqOC318QfR8Gu3vbccGcdIZo4SUB50k/ZFGGAI5eCuOs4eLzrBdrmPbRKLp/qpdZC524GjKxBUYVrLg2E0tVpkowRaCc93x+kOgI5bFadcLved2XEOizxB2XHzl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOqgvsvP6xp8YDow4GKG5pZxDW+XWoOY7CbmT2DMnM0=;
 b=DKl6Q+Xr4zdP1JUMvLPd7YZYNrwb9qqN24lA18X9C61KBSPGPAGHj9GfCCsIf7qxa0a3XLMfUOE67EJ89eaGiEHBC1KgMFlYMoYSNZ8m/HkXOJkLtocTd935WJg6mzKtqV0BTTfIT+sggL3PB+CdDi7/rldFWaJDoM4qHm7GigtJU3rZIx8VsB1asC2Em0c/9RpraCY5D0ejftzPnBLe30lTzHhQ1QNvxD+AuyvqI+4RvUJ9suiAyQnJfqwxxeQZY68V7JHGjRze/o/CFhYDrPRJdK3CtPNNr6mETBWdjG538r5U6631s0TZHkCn5b8DsBa95OMlJpU8RgSH14gcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOqgvsvP6xp8YDow4GKG5pZxDW+XWoOY7CbmT2DMnM0=;
 b=kDr7U83ZkKV8W/AfSa8DAN+PI4jNyeQGBrXzdFip8khtApzua6hvV2dARUq5hg4VM6sx8EsxFilOQYE3tf0C7P7K5829NJE8icMJj+2q68jkcTBkr2B6OMVmTY6X+Qg7p/QX0qtmKfNN9rpPs4NP2VGGI9TZmLvIi9FaVpZYDIuOd7o9XSFIpBlR6efTr2kVK2ulnrVfiZcb3xgS/w40oSlDgRCXhRKn8QPUF9N6s3oqr2OVrQk8tF2iXSukLlchAuJkz9AcusEOezgh64pYap+BZkJq3RkIR6pE8A9vsSTa1SM7jhOtAMtmMntR5Fi58qVs4pY1R8NTbXswlxMhKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 19:29:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 19:29:42 +0000
Date:   Thu, 10 Nov 2022 15:29:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/restrack: Release MR restrack when
 delete
Message-ID: <Y21RJc2NIiUZw7A5@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
 <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
 <Y2v6sTD8docw5bjK@nvidia.com>
 <Y2zF6c5gs8KObRK0@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2zF6c5gs8KObRK0@unreal>
X-ClientProxiedBy: BL1PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea1bbed-6f35-4726-c1f6-08dac351eacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zis5IGWR4y/2gACybJ5y9vidxO+zzCP2Qdo1KV/0QdkqsL0TJdEVcX9v85y5NzqSZjM7xlfI7mPsCA58w9CBkt2mFFDWlbI/vnx6UxLDkEAzL2In3G/ebI/zznOdbOQWm3a6KBRS246yp1E0WLZcfaNbzge6zEra1cGaFHslK/HdQai9KVWGnNhXPswIceyZ0SdjaTpE6gjPToydv/GFQ4kFBeoXVSgdQgaGWJs4WgvWMc/7YgRDaAU1RnzO4ZQeWaacUDWEibBy3knhJGad4Dl7UjunAgbUYJOdz6XO4EMhIoHUhcxTzSv9TYjB8tJc7aJHEZJM/QnYEoGNa24WHo0nH2OAT7f3Oux3KGGf8OEJki2tat7CUpVfTcTpwov82gyeuseIm5Kr1ekCvjHkbWTNGLtfsiN6jT+Nb5hFB/dGAwdpGbOzMA7r7l6N6pzNPQJxKbeK9a73pISBwk/J6to/NQ7beBRwz5KJYuy6Hcq3FyslZ0htTtSM0KzsJ/4OGRB40rP+Evn5JSod4d0oN4Zo6EamXHnt3wQqz6K5XQU9Yv4Xlz2S4zobLqtQL3RtX88lZ66V7OMgpk181Wy78PgRyfSv5T1lNOkMpnvIlkaxY+BHtby8l71zrrzymow3zxR1viugUWgjIqPvqTBQzMHISfzgYyQXTIJNnzMxz/+b6FUqm5OD9oIyFGTX/ZCebGzJmF6S8aioHKs9b7eZPy9KaVlE1vWMqQFV/ILCOCDZU4Z8pdQ8WYrdfNXYgKEPDGlyDG/bwcEFlTpQZK4evNqkteW8bWTzbYWGTU6rX+8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(2906002)(36756003)(66556008)(6486002)(83380400001)(478600001)(6916009)(966005)(6512007)(8676002)(41300700001)(54906003)(66476007)(66946007)(5660300002)(4326008)(26005)(316002)(107886003)(186003)(2616005)(6506007)(8936002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0VyUJ8SzER8wYqrbTEV9tw4oJ3o2+nAbWBa/QJp0uoHXYb05bvFBRaS5Hu0q?=
 =?us-ascii?Q?7FZnbKK8Tpmot1ZgLtHIs/PNPL4z/C24tgZxWC3U2uaxGPnSzHXhpP8CLftq?=
 =?us-ascii?Q?+8udiZWARNQvqKzt85z8hzsitzbaXl8UFP2IOlvac6U1u5D5ZMN+aou8VBE6?=
 =?us-ascii?Q?4y7GRUGwa4UIf0C2H2etZQK+b8XA0NqlUJvYDyEh3QBvF/zRrkW/+MXOsO7l?=
 =?us-ascii?Q?NlMiB7wi1l13PmcJ61btVB8sXJbybLOaMgXdeU+AJ1RVjvYElz4GK0oksQrK?=
 =?us-ascii?Q?e7G3UPjGeGV9lXfMqPDAQ8Tm7Jbjx7/G4hMafBoL0h+O+jZmkcegE9I2lZ5M?=
 =?us-ascii?Q?FxbfnK1hroJ0FzcAjYIiueTCnkoDArUnwSLBCt0p6XEXqfEd5bDzbibzhVnr?=
 =?us-ascii?Q?+PvctswoApmFLgIngY/7Nr0QppAcIyE3uIFSW5jggbEm/7pnilq7PyLt5qvD?=
 =?us-ascii?Q?1cf6hmjXP09IMVahZDK06ziWVoaQS+BSVVtxcz0QpJXTkJ0MJuY9/HQEkxIK?=
 =?us-ascii?Q?RTUtcepRWNEnoMQ07u7NpbsW5CLaBHvLH8IpREntuhFcmwhH2LXkQCGHqDsv?=
 =?us-ascii?Q?oxZ/36K9pGhAwQlQ0iIMFJO98LfpABt5HUMquM3JxHy+fdMdJmKjU3E7xCgA?=
 =?us-ascii?Q?S3MTxz/OGB3NPOA6TU2tCOWDv07uWjL1osqafk0cANS5wcW1MPCjmTncrS0k?=
 =?us-ascii?Q?On5vESkgHWfaVVO/L75o6xrimU8MxARaNqy3M1gBVDpxyY2MigB7rFYwNEDA?=
 =?us-ascii?Q?lgUEdbwi339/Hky5U7vIN6MASuYH5pvPuLz2pJ7h2CAlL4PlpRmULl5nVv//?=
 =?us-ascii?Q?RF7z2zsT31WkDSaXT8rCaUWluIp5s8ACnCl8uvzOrLzuvq8HIvaFAU0+619E?=
 =?us-ascii?Q?DareItq8UovE3gBdMYySw3YXICMZhxjJTN+gGEoXYMWh7a9JmGyPYHJ/a8pn?=
 =?us-ascii?Q?ZP8fwYNc6IlENjjzKhO/Tbp3Y6XWpk1u6eaxQUg+9tsiFz5EKup5N6R2jkyE?=
 =?us-ascii?Q?VAEe69Z3LEa0Y5vu1i3s3DRlHcLIfzt0FHwPigq6/JgtG0FYct/rYh1tX2S6?=
 =?us-ascii?Q?49UxjavjSZ0uW6eOJ8iDbdri+6irqFSfdDeLdF3ZAyWZvmL1ua+4f8E0iGEr?=
 =?us-ascii?Q?RcSixrcwBTdXmIGUmJXaBEFryE0HpOFuUfhTqsAsSSUoUXv36PofK5E+sOGv?=
 =?us-ascii?Q?hnh5Ew8jl+fJ7CkBMNbBosnm/xsH4EZ8882VM3sV16sMt2rccAn9MYjhswJR?=
 =?us-ascii?Q?WX5lAUVQlHJa1QP5j5bAANCW1VS90dGkJp1aLkVsaXbixMRHlF+FfdbTu3CJ?=
 =?us-ascii?Q?zxVDNHxTt1m0Ah92uZ//HCVWWaaiXUl4yE5j+71WPgZaZkET+R6vJ40RSjuC?=
 =?us-ascii?Q?XB8tY9jYfLp29osEQOELLfrI9WJP6qIDO2aSMeXthgyK9lgJo1faudkhZlw5?=
 =?us-ascii?Q?JZABFv+/GE83iWoeppOSw44nkBh/FWhP56ft60b30eoT29fQdNuQtFXnynQZ?=
 =?us-ascii?Q?u3kq5nI4KZ5X5duGQybciJVfXmrch3UbZN6GJL50vQnEt6JNHzLdi7dquBD7?=
 =?us-ascii?Q?QRc31xPbre1JIApUsl0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea1bbed-6f35-4726-c1f6-08dac351eacc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:29:42.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j26VTNYt2M6tpAryORURoSsrd7BArX9BdaiaH92rhi3h5998SWGOjX+vBRS8uny6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 10, 2022 at 11:35:37AM +0200, Leon Romanovsky wrote:
> On Wed, Nov 09, 2022 at 03:08:33PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 07, 2022 at 10:51:34AM +0200, Leon Romanovsky wrote:
> > > From: Mark Zhang <markzhang@nvidia.com>
> > > 
> > > The MR restrack also needs to be released when delete it, otherwise it
> > > cause memory leak as the task struct won't be released.
> > > 
> > > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/core/restrack.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > index 1f935d9f6178..01a499a8b88d 100644
> > > --- a/drivers/infiniband/core/restrack.c
> > > +++ b/drivers/infiniband/core/restrack.c
> > > @@ -343,8 +343,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> > >  	rt = &dev->res[res->type];
> > >  
> > >  	old = xa_erase(&rt->xa, res->id);
> > > -	if (res->type == RDMA_RESTRACK_MR)
> > > -		return;
> > 
> > This needs more explanation, there was some good reason we needed to
> > avoid the wait_for_completion() for the driver allocated objects, but I
> > can't remember it anymore.
> > 
> > You added this code in the v2 of the original series, maybe it had
> > something to do with mlx4?
> 
> I failed to remember either, but if you want even more magic in your life,
> see this hilarious thread:
> https://lore.kernel.org/linux-rdma/9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com/

Oh, that clears it up

The issue is that dereg can fail for MR:

	rdma_restrack_del(&mr->res);
	ret = mr->device->ops.dereg_mr(mr, udata);
	if (!ret) {
		atomic_dec(&pd->usecnt);

Because the driver management of the object puts it in the wrong
order.

The above if is necessary because if we trigger this failure path
without it, then the next attempt to free the MR will trigger a
WARN_ON.

So, no, this can't just be deleted, and the suggestions I gave in that
prior thread still look like they hold up. As would converting the mr
into core ownership. We are very close now, the mlx5 cache mess is
almost cleaned up enough to do it. Perhaps after Michael's series

Jason
