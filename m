Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F9655DBA1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiF0KXL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 06:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiF0KXK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 06:23:10 -0400
Received: from mail-m2835.qiye.163.com (mail-m2835.qiye.163.com [103.74.28.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF72AC6
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 03:23:08 -0700 (PDT)
Received: from localhost (unknown [117.48.120.186])
        by mail-m2835.qiye.163.com (Hmail) with ESMTPA id CBD938A0201;
        Mon, 27 Jun 2022 18:23:06 +0800 (CST)
Date:   Mon, 27 Jun 2022 18:23:03 +0800
From:   Tao Liu <thomas.liu@ucloud.cn>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, saeedm@nvidia.com, talgi@nvidia.com,
        mgurtovoy@nvidia.com, jgg@nvidia.com, yaminf@nvidia.com
Subject: Re: [PATCH RFC net] linux/dim: Fix divide 0 in RDMA DIM.
Message-ID: <YrmFB2sNH8p/CqVU@FVFF87CCQ6LR.local>
References: <20220623085858.42945-1-thomas.liu@ucloud.cn>
 <YrlfSnNNdjkaajAg@unreal>
 <YrluGtk3wawXlnag@FVFF87CCQ6LR.local>
 <Yrlw+j8dnvCUVa1y@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrlw+j8dnvCUVa1y@unreal>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHRkdVhlJGk4dSExKGh1PH1UZERMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVPQ1VKSUtVSkNNWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTo6Hjo6TDIIPQkPQhM3ISwu
        Ig4aCUNVSlVKTU5NSElOSENMSk9PVTMWGhIXVQ8TFBYaCFUXEg47DhgXFA4fVRgVRVlXWRILWUFZ
        SkpMVU9DVUpJS1VKQ01ZV1kIAVlBSE1KTDcG
X-HM-Tid: 0a81a4afb25b841dkuqwcbd938a0201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 27, 2022 at 11:57:30AM +0300, Leon Romanovsky wrote:
> On Mon, Jun 27, 2022 at 04:45:14PM +0800, Tao Liu wrote:
> > On Mon, Jun 27, 2022 at 10:42:02AM +0300, Leon Romanovsky wrote:
> > > On Thu, Jun 23, 2022 at 04:58:58PM +0800, Tao Liu wrote:
> > > > We hit a divide 0 error in ofed 5.1.2.3.7.1. But dim.c and
> > > > rdma_dim.c seem same as upstream.
> 
> <...>
> 
> > > > Fixes: f4915455dcf0 ("linux/dim: Implement RDMA adaptive moderation (DIM)")
> > > > Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> > > > ---
> > > >  lib/dim/rdma_dim.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > 
> > > I think that this change will be better as it won't change
> > > decision order in rdma_dim_stats_compare()
> > > 
> > > diff --git a/include/linux/dim.h b/include/linux/dim.h
> > > index b698266d0035..69ae238ec2dc 100644
> > > --- a/include/linux/dim.h
> > > +++ b/include/linux/dim.h
> > > @@ -21,7 +21,7 @@
> > >   * We consider 10% difference as significant.
> > >   */
> > >  #define IS_SIGNIFICANT_DIFF(val, ref) \
> > > -       (((100UL * abs((val) - (ref))) / (ref)) > 10)
> > > +       (ref && (((100UL * abs((val) - (ref))) / (ref)) > 10))
> > >  
> > >  /*
> > >   * Calculate the gap between two values.
> > > 
> > > 
> > Reviewed code in net_dim_stats_compare() and rdma_dim_stats_compare(), the
> > crash point is the only place not covered 0 condition. So it maybe not
> > need to change the macro.
> 
> Change in the macro ensures that we check cqe_ratio only when it is
> needed.
> 
> Can you please resubmit?
> 
Yes, I will. Thanks for your comment.

> Thanks
> 
> > 
> > But I am not familiar with the algorithm, and not sure what is the right
> > return value.
> > > > 
> > > > diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
> > > > index 15462d54758d..a657b106343c 100644
> > > > --- a/lib/dim/rdma_dim.c
> > > > +++ b/lib/dim/rdma_dim.c
> > > > @@ -34,6 +34,9 @@ static int rdma_dim_stats_compare(struct dim_stats *curr,
> > > >  		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
> > > >  						DIM_STATS_WORSE;
> > > >  
> > > > +	if (!prev->cpe_ratio)
> > > > +		return DIM_STATS_SAME;
> > > > +
> > > >  	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
> > > >  		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
> > > >  						DIM_STATS_WORSE;
> > > > -- 
> > > > 2.30.1 (Apple Git-130)
> > > > 
> > > 
> 
