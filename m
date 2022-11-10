Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA66624AE3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Nov 2022 20:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiKJTrb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 14:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJTra (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 14:47:30 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FB815732
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 11:47:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCfq+M71mj+f0gCAvOkZYmJZGdZmjuDj4hlRGx+Dg8RMPUPbAydg3i4zqluJ6MDV62FaGT1Om6u7JnpSa95YfSqtbAzCpY+Bo2JRBHkfj3NOisYC0zsUK/lq227nqhueW2474339SEhv1qfl30BeV1fm3UI3UrUba7hSsBTHsKCKsgmK/m8VSKzuZQ7PWEJQ8D4cGIJt+75tyQ7gvExsurH56uehajZbpXu8L1WvpFCFmCsaOSG1TguMfiAVOn2055XU6M35Chl01wAVkt5zO0VlfWUZSXDEl43GN+9XSzoL6codLQOQg586GjUgRAI8vuXlsXlEfXWrzCKGOuuAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1s6/N3fWnsmDXC9kMLSXfRBwpjOYbwbX/FoBNAgoCE=;
 b=giHoOOsgx9hydCCQ1m4x9NeYSvjlpEwWQ+bOcpSuPH7OWQnvEl6ij1HlTwjwUzjpCpCOJxU6O+B0MMUyXFTctaZl7G6gFC4quVQ+R9djcfKn4KkVqWWFy0ibHM+HWto5kfOmlrcMeQ6R74fF94ix7z3eMY2MBeMA5Lu9wIma1sQjECKqmbO3AFtw2qyIONlYXam91HltIk5qmYvqKYGVzzw4aNkaOePnZ4Y7q4i52p5+OlrpKwZXatbrBiEIfRFMDBXi2uuutiep+CQ44Oo34aQ8gpSdE0nPmaCL2u/gpFJgRMXbq64MKEf6OV8xb9q2RBlgZcPkv+WYLwUpGf06Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1s6/N3fWnsmDXC9kMLSXfRBwpjOYbwbX/FoBNAgoCE=;
 b=JnJWS0guhg3jPxrJxW0xrFpeeYGc06uG2EnPTs2eN8+IX17iM5LwPW+2wQ+UfOGFqv91Dc9cFw5ljMZQXXimXAm1VpPyU5s3+/WBSbFfS093hjVQWOM32aS5e6Boqxp5WC4JF4V8whYt44zGQ2H1U2uDDOTOYYF2cZ06bPKShjPfADC285JbwsYAOGWG1iVbyaVPTR408tshQP7mkZLnQsZpruI1i5n0Tc9BXjY1ZkJkvxAQD0sWMS9K5/K16cmJxiCvEqxcyvLHwJN2xMC8sllp9ecWNIlvY9DtVLhfwn5oXi1ic5Rxt57akseOeizjiJCBIgqsQmf+yrPNPbq6Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 19:47:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 19:47:27 +0000
Date:   Thu, 10 Nov 2022 15:47:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next 2/4] RDMA/restrack: Release MR restrack when
 delete
Message-ID: <Y21VTnmxK62As0Xt@nvidia.com>
References: <cover.1667810736.git.leonro@nvidia.com>
 <703db18e8d4ef628691fb93980a709be673e62e3.1667810736.git.leonro@nvidia.com>
 <Y2v6sTD8docw5bjK@nvidia.com>
 <Y2zF6c5gs8KObRK0@unreal>
 <Y21RJc2NIiUZw7A5@nvidia.com>
 <Y21Th3bG8gaARGuZ@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y21Th3bG8gaARGuZ@unreal>
X-ClientProxiedBy: BL0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:208:91::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 79984ee8-69d7-4202-c5c9-08dac3546547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7Yfg0DoZClvl/HZN3HZSPlXyupQQvHEEUSXHPNr//1p5ztqApuxFYakOKMHZLGxZmqdoRBpgs3SNP7Cpxyc5hBCKvjpgXEz9zboWpk+quxz0/cAwWirVy5qSXifCR6THSw7E6YpyZrn5cInBmDhYcqxZDSfotXSUTQF2H3ytYKTzkPewZs2dFq7lfsr+GYzZh3O8NqhPsTWmhGfiBY/pNIsxKgg4K1am+VkH5GVaVFLAvVc6RALe+cvkc8wG4dLVagpV4Yh22WA5jYLOtFi2IoU+Xeyip7Jhq7NtB+6Ss2KKqe7yDvQNfdiULsszkOor3yIaiJ30STi/IduEilewhPU7Cv/04k+TLvYarcfUJdr8V7HUFaW+QqPt733jN27YEGoWPOs52ckvDwoHjrv0wtKb2gRqqpuCD3CIu+2e4gi6vqk61EdOXdHGWqLbXoFEOBG0cB7xJFJ+4bQM3DuH3Cj5e6UjYoGQZ72aC78YOrAzCEOddL6qhKlYfn7qAPHya7eBn5BM0Spom37ca4FgkuFPqBXVx10AhIpDTHvZ4vHoRQbmjc0f9jMqc9Dj9Gfug6G+Tf5+gdobNy1GYiGcXZCywGGV5iKreLx5zNIZNefh+4XtHT87eIm0me4fbv/pzSiMdIeb24ym6t38cjUxItJbcSmt6Pf0Wsj+3Q9SBVNP782h5iISd5LggTrDacnlZcy3ESyqKu8WHalOOpe2hxGH+xSsBKN+oouw7WAFv5nOiG9FeUvtxE2gElJziaLJgy9SulI1MmBQrXlGxDu6+t/rDTPzwbG8mClnEiOMPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36756003)(66556008)(86362001)(26005)(2906002)(5660300002)(83380400001)(38100700002)(6512007)(186003)(6506007)(8936002)(8676002)(66476007)(2616005)(4326008)(41300700001)(6486002)(316002)(966005)(66946007)(6916009)(54906003)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G3AM3n0f5Hba6TpYhqkckWlNOdUA8PgG6XWArAxvNzJD30LVUbjxd2dhVEAB?=
 =?us-ascii?Q?w52364AnD/IheMnW6C4HaMqFIdRrmC1n/yOWKgybVLY9BzMI++et0y31sVyM?=
 =?us-ascii?Q?V+R75ggC8Wpk8GdFEmXVGDlpY0wTsngXKPOPEKo7iC9hspdxpZjM9go9DKYO?=
 =?us-ascii?Q?12aoJ4ojPiLdaIXPXq0/bRW5ByzzryvEOnHMn9zsVKlQNC9l7w4LoCDtv3BG?=
 =?us-ascii?Q?bpEiFJnWdWBqujNlUONN36XRXqNfWlrh5k1lueyIC8XGZ+PkvLAL08TBh2KR?=
 =?us-ascii?Q?ctIbYx7wu/yK0Klv6f49mVWXUBlfY2Bp/pETSLN04bBKfcNMG+JpDjx9Lf3F?=
 =?us-ascii?Q?PFc7hIIGxUeMG5pYGkQG7BjBYBaxvCYr6LOG0X+zwWuw1QmylkxwK4TZb6ga?=
 =?us-ascii?Q?L1PLUw2CoVAj+T3zIp/pUUEF+d05j0KApjuJkgcpC5pL6a7TB4glxQ44cbDE?=
 =?us-ascii?Q?dnGETBV1uk5nKDBeMx6+lNbGnpRyYZTeKMqtSw+N2Nj4yE3uY4rb2NEc3/CC?=
 =?us-ascii?Q?EzTiUyxxUwg+tUoiCrG8BldeanWJeXqqiG8IQnG7fColDze3PbbAriXMS6t8?=
 =?us-ascii?Q?lksGwQhCbwgjhnQ+iAQyGwBT/JARzn6dTMMgCeg9qa52CkX1tus0TR6Flzfg?=
 =?us-ascii?Q?WjjflPA4GmGKab4zxysWN+y5I8W/MzUknOsMQRC/fw94Qlh+ub2KZls8yVPg?=
 =?us-ascii?Q?q2lOy7sFsoUDlN5uMALi5Et5+5tpQhjioWIwXQwD6q8F5FzVn2ZOMWNSzS+F?=
 =?us-ascii?Q?q88DZImxgNHoM5yXS72FjigxFds4lyFdQY0aZU+SJBvyJk1DJYaN0cIoQbzq?=
 =?us-ascii?Q?U5t2npjKmhHShhfSMCyF2FYzlbcZ7HrNv8IeIWcpW+Ibyo+hU0wKAbZU0c8V?=
 =?us-ascii?Q?CR4BFG5S5OmfqZWaiPZb2z9jK+CIKMuAms2JrPDOxZCqYnQ+tDlHjMP3eWJ9?=
 =?us-ascii?Q?nnk0Clh5jXVotiY88pDDULl3dWPYQxDdm3eLIqgy18mN1Pjv3SCUMU6XL/z7?=
 =?us-ascii?Q?TQvhOrgI/Rk9IQuqi1vVK75Oj8lToCAPLyr8jRzSZhUoP3McwybIsTPQ+DEu?=
 =?us-ascii?Q?t0ug1wda30beJzG/RzVIfVvN8xp9Oy+BTdgOMPHCYK1shdr2D1oZYZU32+rx?=
 =?us-ascii?Q?lkHxVoh46MlimNCyeNxoR1bLTt19fjcaL7uN7JtrZcy0aMhoXq+C/4l6tFBH?=
 =?us-ascii?Q?F8L3f6nq6V8EWVPFrSlDsbZpCt/Qx+V3SSPgwLe3zLra1p4I9Q3qkpuyjkDu?=
 =?us-ascii?Q?XQHi+6cnwOaY6yq8yzIHeZYKdTVW0nRvAt46AvYDHXmefVTTGyLSL1740OYz?=
 =?us-ascii?Q?2P86Q2t8Wcbvi6hHP+xdQM5JXCKf+JXwVE0bOXlCYEFj/Jg2xJqi/2CPNvUU?=
 =?us-ascii?Q?mtCkteoE527/DxLdN7Qzw2ja1ga8PMLb8812JvjmufVaaJSzuYAvnkxMDa3K?=
 =?us-ascii?Q?dja1UnaVFTHjGFIOIHsJIq4Rc3380Ak7twKCSp4CUfUWZmsAuAB4kDHfyqvs?=
 =?us-ascii?Q?vPVg0R9jY7Rc3/dXRZpkmXeG4zEz4cHyoxoZVvbIznxv9iRfW4TA24N09z3z?=
 =?us-ascii?Q?xxOtI+Z9mCjINR5MB1A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79984ee8-69d7-4202-c5c9-08dac3546547
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 19:47:27.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbLg4rgTdEmDfcEicJe5FrFzDDk4hj9khcmXF40KniwirHP3MH02gatGEbIeWibQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 10, 2022 at 09:39:51PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 10, 2022 at 03:29:41PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 10, 2022 at 11:35:37AM +0200, Leon Romanovsky wrote:
> > > On Wed, Nov 09, 2022 at 03:08:33PM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Nov 07, 2022 at 10:51:34AM +0200, Leon Romanovsky wrote:
> > > > > From: Mark Zhang <markzhang@nvidia.com>
> > > > > 
> > > > > The MR restrack also needs to be released when delete it, otherwise it
> > > > > cause memory leak as the task struct won't be released.
> > > > > 
> > > > > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > > > > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > > > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > ---
> > > > >  drivers/infiniband/core/restrack.c | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > > > index 1f935d9f6178..01a499a8b88d 100644
> > > > > --- a/drivers/infiniband/core/restrack.c
> > > > > +++ b/drivers/infiniband/core/restrack.c
> > > > > @@ -343,8 +343,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> > > > >  	rt = &dev->res[res->type];
> > > > >  
> > > > >  	old = xa_erase(&rt->xa, res->id);
> > > > > -	if (res->type == RDMA_RESTRACK_MR)
> > > > > -		return;
> > > > 
> > > > This needs more explanation, there was some good reason we needed to
> > > > avoid the wait_for_completion() for the driver allocated objects, but I
> > > > can't remember it anymore.
> > > > 
> > > > You added this code in the v2 of the original series, maybe it had
> > > > something to do with mlx4?
> > > 
> > > I failed to remember either, but if you want even more magic in your life,
> > > see this hilarious thread:
> > > https://lore.kernel.org/linux-rdma/9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com/
> > 
> > Oh, that clears it up
> > 
> > The issue is that dereg can fail for MR:
> > 
> > 	rdma_restrack_del(&mr->res);
> > 	ret = mr->device->ops.dereg_mr(mr, udata);
> > 	if (!ret) {
> > 		atomic_dec(&pd->usecnt);
> > 
> > Because the driver management of the object puts it in the wrong
> > order.
> > 
> > The above if is necessary because if we trigger this failure path
> > without it, then the next attempt to free the MR will trigger a
> > WARN_ON.
> 
> Not really, after first entry to rdma_restrack_del(), we will set
> res->valid to false. Any subsequent calls to rdma_restrack_del() will
> do nothing.

Uh, that does seem OK

So I'm back to I don't know why this if was put in.

Jason
