Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC76BAFAC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 12:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjCOLwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 07:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjCOLv6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 07:51:58 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DC733AB
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 04:50:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id nf5so16087264qvb.5
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678881054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIhw5TKqO9mTYKFemZbRpq7iDCkZNqVFLva/m8xHOzg=;
        b=waNm/Unrsfng4WDuQSr20zp5Ams7+pYpWM90E+gaO4TrMWxivrOTrq/aAcN6iY8xch
         aQVWfoLUgoLqh+/khtH8Dps79O1dLU7XnMwVac1GtbeIlB6olJSNI6Hen1PTn9TVcW0L
         5Ul2V4oA32dF3XebYgdkXK32ZX1gBrZewBE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678881054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIhw5TKqO9mTYKFemZbRpq7iDCkZNqVFLva/m8xHOzg=;
        b=Lzv/DCgPp0ciGF8JYP1X8ctBwrOAHGv40ZnoQW5lvXlL7R64gBtnFoRiRD87zlK1Zv
         yhvFMZdjzDf24ZNFLHjTmA3M8xQRMFT+JLgmNtrSqXwcQHc13VCyZL85uPUAo5+VMUiI
         DXdfowsI1McsOAfJ9pYS0HFEDXWcDziuUpPmzsblE5t0pp22Gq/rODvzoWRdIUfCgl09
         OGTDbYYssN9GTrtFHafhBwvlhdWGMyn/wgODkM61DNDoRlMewirKkLgoFPKDzjw07zOP
         cV1mtbTHfncGGFhkdGVuLFQGOTR8T4w4TzNp5xYfIE6zIa7x3rhQFe4bx5flnGi1hh91
         6DZQ==
X-Gm-Message-State: AO0yUKUSfSQc4l3twgI7E0GRaHXof9rFebnVIFC387HVuqZ2HiY+W3dv
        iqjRxNTngccgKD1tv+m8lmSXMA==
X-Google-Smtp-Source: AK7set/HGERichkdCGc8V5hGUWnrdJVEw1/aY6DvqL/rGnqLrjxBvexv0saeYel2bNqXVs0YW3jM5w==
X-Received: by 2002:a05:622a:1208:b0:3d2:90b1:d161 with SMTP id y8-20020a05622a120800b003d290b1d161mr9397483qtx.48.1678881054440;
        Wed, 15 Mar 2023 04:50:54 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id x7-20020ac87307000000b003b63b8df24asm3585728qto.36.2023.03.15.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:50:54 -0700 (PDT)
Date:   Wed, 15 Mar 2023 11:50:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 07/13] RDMA/rxe: Rename kfree_rcu() to
 kfree_rcu_mightsleep()
Message-ID: <20230315115053.GA3784687@google.com>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-8-urezki@gmail.com>
 <ZAnjnRC1wY3RIFhM@pc636>
 <ZAnpdKV/VvvX0TZz@pc636>
 <20230310005529.GA339498@google.com>
 <67fbe385-3682-be4e-15fe-f26cc56fd56b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fbe385-3682-be4e-15fe-f26cc56fd56b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 13, 2023 at 02:43:43PM -0500, Bob Pearson wrote:
> On 3/9/23 18:55, Joel Fernandes wrote:
> > On Thu, Mar 09, 2023 at 03:13:08PM +0100, Uladzislau Rezki wrote:
> >>> On Wed, Feb 01, 2023 at 04:08:13PM +0100, Uladzislau Rezki (Sony) wrote:
> >>>> The kfree_rcu()'s single argument name is deprecated therefore
> >>>> rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> >>>> underline that it is for sleepable contexts.
> >>>>
> >>>> Please check the RXE driver in a way that a single argument can
> >>>> be used. Briefly looking at it and rcu_head should be embed to
> >>>> free an obj over RCU-core. The context might be atomic.
> >>>>
> >>>> Cc: Bob Pearson <rpearsonhpe@gmail.com>
> >>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
> >>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >>>> ---
> >>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>> Could you please add you reviwed-by or Acked-by tags so we can bring
> >>> our series with renaming for the next merge window?
> >>>
> >>> Thanks!
> >>>
> >> __rxe_cleanup() can be called in two contexts, sleepable and not.
> >> Therefore usage of a single argument of the kvfree_rcu() is not correct
> >> here.
> >>
> >> Could you please fix and check your driver? If my above statement
> >> is not correct, please provide Acked-by or Reviwed-by tags to the
> >> path that is in question.
> >>
> >> Otherwise please add an rcu_head in your data to free objects over
> >> kvfree_rcu() using double argument API.
> >>
> >> Could you please support?
> > 
> > Also this one needs renaming? It came in because of the commit in 6.3-rc1:
> > 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
> > 
> > It could be squashed into this patch itself since it is infiniband related.
> > 
> > Paul noticed that this breaks dropping the old API on -next, so it is
> > blocking the renaming.
> > 
> > ---8<-----------------------
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index b10aa1580a64..ae3a100e18fb 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> >  		return -EINVAL;
> >  
> >  	rxe_cleanup(mr);
> > -	kfree_rcu(mr);
> > +	kfree_rcu_mightsleep(mr);
> >  	return 0;
> >  }
> >  
> I just got back from a 1 week vacation and missed all this.
> 
> The "RDMA/rxe: Remove rxe_alloc()" patch just moved the memory allocation
> for MR (verbs) objects outside of the rxe_pool code since it only applied
> to MRs and not the other verbs objects (AH, QP, CQ, ...).  That code has to
> handle a unique situation for AH objects which can be created or destroyed
> by connection manager code in atomic context while all the other ones
> including MRs are always created/destroyed in process context. All objects
> other than MR's are created/destroyed in the rdma-core code
> (drivers/infiniband/core).
> 
> The rxe driver keeps xarray's of pointers to the various objects which are
> protected by rcu locking and so it made sense to use kfree_rcu to delete
> the object with a delay. In the MR case ..._mightsleep seems harmless and
> should not be an issue.
> 
> However on reflection, all the references to the MR objects are ref counted
> and they have been dropped before reaching the kfree and so there really
> never was a good reason to use kfree_rcu in the first place. So a better
> solution would be to replace kfree_rcu with kfree. There is a timeout in
> completion_done() that triggers a WARN_ON() and this is only seen if the
> driver is broken for some reason but that is equivalent to getting a seg
> fault so no reason to further delay the kfree.
> 
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

Thanks, I am planning to send the following patch for 6.4 consideration,
please let me know if you disagree. Still testing it.

----8<---

From: Joel Fernandes (Google) <joel@joelfernandes.org>
Subject: [PATCH] RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()

The k[v]free_rcu() macro's single-argument form is deprecated.
Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
is to avoid accidental use of the single-argument forms, which can
introduce functionality bugs in atomic contexts and latency bugs in
non-atomic contexts.

There is no functionality change with this patch.

Link: https://lore.kernel.org/rcu/20230201150815.409582-1-urezki@gmail.com
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: 72a03627443d ("RDMA/rxe: Remove rxe_alloc()")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b10aa1580a64..ae3a100e18fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -731,7 +731,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 
 	rxe_cleanup(mr);
-	kfree_rcu(mr);
+	kfree_rcu_mightsleep(mr);
 	return 0;
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

