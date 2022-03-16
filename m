Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAD4DB1BC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 14:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbiCPNnq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 09:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243280AbiCPNnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 09:43:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D6427C2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 06:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6RxwcFOVG6DSB7IYu7E79YOn7YTrdL9wmLKz909l8kxv7Sk2Xnbq0g+dOhEDwy7oM9rq3t9tXxnY6n02ifV6A+J94hSg6k3FWxf6ceTP9f+uL5zYztj74Ckw5qTXS5biHHv0B88kNE+J/ftrbMjQo4MwDCsYoouqSN3NbskuMoraRwDSNO85kwRq32b3mggW4NR5gLZmiKf4BIYGeHggnwgD9hSL39MZwsi6We3xdzVniNHhbOCcJRwLxf1rCdel/urDJAIHiZjrA3c0/q2V87wyto10JWtOk2+Km/Ls9BfK6n9cRtjSoEFXw1QH/Lnlq+laK9CpIefGpAtAj6yNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCZcNv9551j9oUZg/EuyI/nXn5FvI0E0sz1mHXH3Q1w=;
 b=dYttP8VBW1CVYPD0SlWh0LcwUlzcoieivVcZCs+OjEYLHIgvqzmTF4OJJOzqZDvcrHdXGPqcUUh4tNsP4ipGBf+yrPrbKrT+gBo+r0pfkFshgecZTJGgukhOhXc3FVyJBUME5/+IKkRnLknbe/5dgoYSA3iPdXsjzyyX52WpQoD9q6w9gab0BBO6uFXpSP6z5cmV64FPgHW9AtPBpojt6TWzHFnRxtbWQkIZMCh5XUlgEsQ7lhYLkJFmSibxVcEOjfp9ykq2QbrWLIXvmdL/y7V3UqKEAp2cacMLSl1RZnWWM4PNTY/SVSrci4ieg6UjCSY0qeuVpz6i6udEHqGMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCZcNv9551j9oUZg/EuyI/nXn5FvI0E0sz1mHXH3Q1w=;
 b=ap+qNQlnNrJd7Wt5XReFhtkFqu3Q0bFp5+X8iVACjkIjNu3lX7PxMUuyYQ/98VVZHs14U+Fxub6WO9Ie0fOAkjtwRHtjBwRviOy+KM2CV6P8dWRXNq4DYhrnXBYK0phqaxCi36lGH+Kd839TVxHMWSme0E8D+ZYU6x9LBKuDDXRjN2La6WvUSZ+YzyxyopuQsmPTqRBlaEqmTQV45bwslpCzScXmCIYoh/zeqPmDYnIZKB8/cMUDUdr0G+aCvL9HlukPFtiJ5ltqOadagc2BYrYeuguGrpGCc7smVC/O6dlYMukkdICbCPqlqn1CC3JlBUDAZQwDHr2sRWByTpWuJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2886.namprd12.prod.outlook.com (2603:10b6:a03:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Wed, 16 Mar
 2022 13:42:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 13:42:29 +0000
Date:   Wed, 16 Mar 2022 10:42:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v11 10/13] RDMA/rxe: Stop lookup of partially
 built objects
Message-ID: <20220316134227.GD11336@nvidia.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-11-rpearsonhpe@gmail.com>
 <20220316001655.GV11336@nvidia.com>
 <8aa69cff-2871-3015-fd2d-7279d8f3ddac@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa69cff-2871-3015-fd2d-7279d8f3ddac@gmail.com>
X-ClientProxiedBy: BL1PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c5c9a9-2062-477f-e861-08da0752d025
X-MS-TrafficTypeDiagnostic: BYAPR12MB2886:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2886809A953FAD19F0F03B5FC2119@BYAPR12MB2886.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VO1jtilhWncRGeTfmnvAnTST1OyjBw/Q5NvIG437YgpNoz0TbtLoE9jCUnmT7yKPKJOTynYbsz939gFuUMD+fQh1hcCSw+4jpSFbgt8aBnAZlUwVM0L4zkhEzkcFGjiFLKmukCXUx9/80bgw2JrelRQKg7mR3btd8F+gO8MmxTuPQt78DIXBFnFWxMVO6M8KW7sDUqMiC4MJZzCThHQIzNLWZbN5+Bdr5wNrbvuDzGlUcCzhvwcL10IPs8TclgRZhfKqm/sAOeYH64KEyV5zgh8t/RwsGC2M4RPggIy2co3/rX79V+EU8DhjJj+PDR3R7M+JZo61dyMqrMMiUJvCYCPUYxrwCXEolhFNs+2kiCax/cDQICQWZCVj2y6b/zd9Hi+BqpnHTrs7ZJir4SOXAZr5lLTKilyCW8e1EDhGKJe0t4hLbp0wYwvJOJr6+l4M7RbJxNsfYLQewj6L1Woz203xHTa0pmbbWPxvjWdnla/GU6ybrWHP0EgGmuER1wTDFYQjqEfrR+Vt+/4YtX+COkUlROzKETmorCcIsSUYyevqISDdU4tN0Ah/dDsKt30YeCTSI78IyVqsZot4tyeKNVJBwplH13jBttG2k7SrjeQeOI55ZB4F2rw2/3VxCS1X3t/NSkBKuJ4zUDFAU5NEow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(38100700002)(316002)(83380400001)(8676002)(26005)(186003)(4326008)(1076003)(6512007)(6916009)(86362001)(6486002)(33656002)(5660300002)(2906002)(66946007)(53546011)(6506007)(66476007)(66556008)(508600001)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MkdKPwK8TKk6A03CLCRwW2AzwhzBLyqyzKlt452HwCLpa/7/lutaORjMxo8t?=
 =?us-ascii?Q?72tu7VLYP1aTOY2HWihBYtFtkybxf9YmSdFqDpiv4DsDI8q8xPCicC33RhBw?=
 =?us-ascii?Q?pqRgIkGKMG+L+y8Uq7MFdMDSnMnl/1jHkkmqPSzPtQ3snQkoaZJp0o0X3xn5?=
 =?us-ascii?Q?Ri4KLeXWiPJJhXn7HJtN4xoS98xdd05w48rxlRjnYiAaJq1PIVJbODVM0Crs?=
 =?us-ascii?Q?RPw4kU0kNtHnzNzfGa4WjLARi9jlQ6vCLJB6xQyXUwk4lpXaK7J4/65gNU1X?=
 =?us-ascii?Q?GhiPzuWPyBQsdbH1OYF+EKBnvW0GRsifgqG02J9g8e4uDepiid1yxvjBtIWR?=
 =?us-ascii?Q?3xl4cEtHiU873NG9VCICDUg3fHgyiab4GR1/B6qkvNzBPp59rRjD9OT/wo14?=
 =?us-ascii?Q?iN8oHT1o2glTTUrlrxdAu7JHfvAZa8rdONcvz+Z0OO8qEhMMZvKC3ilEbiFw?=
 =?us-ascii?Q?nUDFKQlHxog7lB0MQlLMUwhRwa8p/0fXxuIfFnzpvxniGFfqwsj8zgjlnBUy?=
 =?us-ascii?Q?MyCC7gF+nCjwbNYC7VoCHp1v0Ud6Fl7/kD18m3OvqM1f84XHy5XB6KlkN1bV?=
 =?us-ascii?Q?JusHH3/EDp9Du9QzFlxMNz2UjZxSUkOSy1oRNc6p5OZpv5G1qsuODQg5/7m6?=
 =?us-ascii?Q?206fsCkFIdbG2I0AnMPr9gMex3FbVtOgsiN/0hIIFyBnk0R/+/rEaL31MJdI?=
 =?us-ascii?Q?uJOEr6PadAQA15dmOgeln20SVJrpELRsl6JVsK6JuA88ob8Mo6Q9cEutAf/0?=
 =?us-ascii?Q?V1lHaiLWsBua1c4Ix6zGydteahLaAYrMR4f/U6wvXEflNKb2D/OOo0n1n4+9?=
 =?us-ascii?Q?xq9XDAJ/B5lOzrUcEiln6UMt6jGZdqV54LxVUBQr8w21y/AMFig1/44v+BJy?=
 =?us-ascii?Q?eSuYtOjc8rd2iDUZTMhC4OMBPAneEYq46xhsTKYsFTij1/CgHrYQaG8i+48D?=
 =?us-ascii?Q?pgN7PiCICUV5f4DxBeGt8AQ3T/yT8Eks9a2tDFSVVIlA6EuK6Ir7wG8i282G?=
 =?us-ascii?Q?Md2r59z5PTErv8SRcF/hEi959elJUJjEBwssghUY4nU+eXzvFyW19hRt/rEy?=
 =?us-ascii?Q?1hYB+x1mszUzd/VxD3KMyzDrCna97p+xRT/t242sIFVhiXdhqm0Gxo9V44/2?=
 =?us-ascii?Q?kC3sZqU0yib23pGco46k1VyAllXLOXOyiAf+iUTGtCvsbggB64dnfUspeSmV?=
 =?us-ascii?Q?afbkYb1KyjlXSyOZmOOuUJFnTSjAZW/qb4fHBwpczq+Xd8OQ52oJQyFtzfkk?=
 =?us-ascii?Q?G1A+JutAhUDQW0Td4Bd8ozqT0iciTqJQE/4gwekPKne2n84PmDQP10It72sp?=
 =?us-ascii?Q?m5UihB4q2VmzZhVXt+vT73dbyZ+46bQTVVPForBj2iog5BjxaeKP349tAzfL?=
 =?us-ascii?Q?dRcv8TevY6YhZDQLu1Th7sSu3lGvVD8J4t6DhzT1qU4e90cGuS68DMJV9NQT?=
 =?us-ascii?Q?8Mgb5yhGZBma2i1Gg/YepSTUuHaP5YUe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c5c9a9-2062-477f-e861-08da0752d025
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 13:42:29.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wdQUw+Gv4KT0Ys5Frrph/VWLapnpbr+FpR8yk3JQW2ODnke+hKmy05pEo6q6sI+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2886
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 15, 2022 at 10:55:01PM -0500, Bob Pearson wrote:
> On 3/15/22 19:16, Jason Gunthorpe wrote:
> > On Thu, Mar 03, 2022 at 06:08:06PM -0600, Bob Pearson wrote:
> >> Currently the rdma_rxe driver has a security weakness due to giving
> >> objects which are partially initialized indices allowing external
> >> actors to gain access to them by sending packets which refer to
> >> their index (e.g. qpn, rkey, etc) causing unpredictable results.
> >>
> >> This patch adds two new APIs rxe_show(obj) and rxe_hide(obj) which
> >> enable or disable looking up pool objects from indices using
> >> rxe_pool_get_index(). By default objects are disabled. These APIs
> >> are used to enable looking up objects which have indices:
> >> AH, SRQ, QP, MR, and MW. They are added in create verbs after the
> >> objects are fully initialized and as soon as possible in destroy
> >> verbs.
> > 
> > In other parts of rdma we use the word 'finalize' where you used show
> > 
> > So rxe_pool_finalize() or something
> > 
> > I'm not clear on what hide is supposed to be for, if the object is
> > being destroyed why do we need a period when it is NULL in the xarray
> > before just erasing it?
> The problem I am trying to solve is that when a destroy verb is called I want
> to stop looking up rdma objects from their numbers (rkey, qpn, etc.) which
> happens when a new packet arrives that refers to the object. So we start the
> object destroy flow but we may hit a long delay if there are already
> references taken on the object. In the next patch we are going to add a complete
> wait_for_completion so that we won't return to rdma_core until all the refs
> are dropped. While we are waiting for some past event to complete and drop its
> reference new packets may arrive and take a reference on the object while looking it
> up. Potentially this could happen many times. I just want to stop accepting any
> new packets as soon as the destroy verb gets called. Meanwhile we will allow
> past packets to complete. That is what hide() does.

But why not just do xa_erase? Why try to preserve the index during
this time?

> Show() deals with the opposite problem. The way the object library worked as soon as
> the object was created or 'added to the pool' it becomes searchable. But some of the
> verbs have a lot of code to execute after the object gets its number assigned so by
> setting the link to NULL in the xa_alloc call we get the index assigned but the
> object is not searchable. show turns it on at the end for the create verb call after
> all the init code is done.

Show/finalize is a pretty common pattern when working with xarrays, it
is fine

> >> @@ -491,6 +497,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
> >>  	struct rxe_qp *qp = to_rqp(ibqp);
> >>  	int ret;
> >>  
> >> +	rxe_hide(qp);
> >>  	ret = rxe_qp_chk_destroy(qp);
> >>  	if (ret)
> >>  		return ret;
> > 
> > So we decided not to destroy the QP but wrecked it in the xarray?
> > 
> > Not convinced about the hide at all..

> This particular example is pretty light weight since rxe_qp_chk_destroy only makes one
> memory reference. But dereg_mr actually can do a lot of work and in either case
> the idea as explained above is not to wreck the object but prevent rxe_pool_get_index(pool, index)
> from succeeding and taking a new ref on the object. Once the verbs client has called a destroy
> verb I don't see any reason why we should continue to process newly arriving packets forever which
> is the only place in the driver where we convert object numbers to objects.

I think once you commit to destroying the object then just take it out
of the xarray immediately and go on and do the other stuff.
 
> There is another issue which is not being dealt with here and that
> is partially torn down objects. After this patch the flow for a
> destroy verb for an indexed object is
> 
> hide() =	"disable new lookups, e.g. xa_store(NULL)"
> 		"misc tear down code"
> rxe_put() = 	"drop a reference, will be last one if the object is quiescent"
> 		"if necessary wait until last ref dropped"
> 		"object cleanup code, includes xa_erase()"
> 
> If objects are still holding references you have to be careful to
> make sure that nothing in misc tear down code matters for an
> outstanding reference. Currently this all works but if any change
> breaks things we have had to defer the change to the cleanup phase.
> It doesn't work by design but just debugging in the past.

I'd say this is not good, the normal pattern I would expect is to
remove it from the xarray and then drive the references to zero before
starting any destruction. Does the wait patch deal with it?

Jason
