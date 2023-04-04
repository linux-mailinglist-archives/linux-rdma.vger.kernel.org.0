Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC296D5849
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Apr 2023 07:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjDDF6J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Apr 2023 01:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjDDF6J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Apr 2023 01:58:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F346910F2
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 22:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DFCD62E7B
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 05:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ECDC433EF;
        Tue,  4 Apr 2023 05:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680587885;
        bh=inq7mYSGGmNHdMHCVdY475GQfAVbZGDg2CwBISmR+14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJJeP1CVX6QubZwQDhjj+EYqrLHkhH8cJcJ3urmaa9F8IGQ8M63kIPl+kH5Y9ugMK
         czwt02q3Va9f2VRcnFrntn5NVd4FknbQVwYXLtRrXwAauwE5gggJCx9gxqm6mt56Nd
         COV0MePgFr6IlIOv2yrxBZiflu7FO1bk/W2cvvXXMmn+x3L85lLDaaUMhZnFLa5OiH
         7j6mpa2Udb680n5bN1hXyy17TACdWEthCwamBYltn/gorvudzyXLZrqLzTnwymdLFH
         KotC55F01nEgZqlTRASsN/vk0UakkT7+aRaPGtQAtGAngXEFdGD9tThptju2gMfnK4
         +FHQFePGZboqw==
Date:   Tue, 4 Apr 2023 08:58:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the error "trying to register
 non-static key in rxe_cleanup_task"
Message-ID: <20230404055801.GF4514@unreal>
References: <095b1562-0c5e-4390-adf3-59ec0ed3e97e@linux.dev>
 <20230401024417.3334889-1-yanjun.zhu@intel.com>
 <20230403181026.GB4514@unreal>
 <8ddeafc2-bc5d-e84a-0abd-9b48ab68e68e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ddeafc2-bc5d-e84a-0abd-9b48ab68e68e@linux.dev>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 04, 2023 at 08:13:22AM +0800, Zhu Yanjun wrote:
> 
> 在 2023/4/4 2:10, Leon Romanovsky 写道:
> > On Sat, Apr 01, 2023 at 10:44:17AM +0800, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > In the function rxe_create_qp(), rxe_qp_from_init() is called to
> > > initialize qp, internally things like rxe_init_task are not setup until
> > > rxe_qp_init_req().
> > > 
> > > If an error occures before this point then the unwind will call
> > > rxe_cleanup() and eventually to rxe_qp_do_cleanup()/rxe_cleanup_task()
> > > which will oops when trying to access the uninitialized spinlock.
> > > 
> > > If rxe_init_task is not executed, rxe_cleanup_task will not be called.
> > > 
> > > Reported-by: syzbot+cfcc1a3c85be15a40cba@syzkaller.appspotmail.com
> > > Link: https://syzkaller.appspot.com/bug?id=fd85757b74b3eb59f904138486f755f71e090df8
> > > 
> > > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > > Fixes: 2d4b21e0a291 ("IB/rxe: Prevent from completer to operate on non valid QP")
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_qp.c | 15 ++++++++++++---
> > >   1 file changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > > index ab72db68b58f..7856c02c1b46 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > > @@ -176,6 +176,10 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
> > >   	spin_lock_init(&qp->rq.producer_lock);
> > >   	spin_lock_init(&qp->rq.consumer_lock);
> > > +	memset(&qp->req.task, 0, sizeof(struct rxe_task));
> > > +	memset(&qp->comp.task, 0, sizeof(struct rxe_task));
> > > +	memset(&qp->resp.task, 0, sizeof(struct rxe_task));
> > IMHO QP is already zeroed here.
> 
> Sure. Exactly. Here I just confirm that req.task, comp.task and resp.task
> are zeroed explicitly.

There is no need to do so. It is quite misleading to read the code and
see these memset() functions as they give false impression that QP is
not zeroed.

> 
> If you think it had better remove these memset functions, I will follow your
> advice.

Yes, please.

Thanks
