Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC28C48ABAC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiAKKrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 05:47:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54470 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jan 2022 05:47:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3230D6157C
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jan 2022 10:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D45C36AE3;
        Tue, 11 Jan 2022 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641898064;
        bh=sCXLZwsDJzt7Aza+A2A3tgDyZ4xjtDG/6i8TyH+saag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTB6/2ex2aaO9z9gUnpoo/cetNAWvOrJfrRLN7gO0nBNGZJRfag6z5q9EIzBNBd/B
         u3H75D5NsCFqOptLa7jjDschy8y/6Hk8zwWv+Ge+Ros2LZZINzWOEmoExzSy+qbKuI
         q/7/401A3h1F+W4FEJ4sylydo26z4aa5ImGtETlRSMa/xiecYbEANFX/9ePpx098/9
         dBItWugdY3GCS+0MljgTGwzXaTy5EGs40ynU2msQUw/3+4B8QqviIP8bik6Sn+Y3+I
         6dFQ3Hmlu1z15fqaWsdxUvBnuhwSATFXk85lD1lH1kphfSX4LPNSES6PcE7Y40Zo0d
         wU1w8AtAVBUFw==
Date:   Tue, 11 Jan 2022 12:47:40 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core RESEND] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Message-ID: <Yd1gTDZ7bq/Ixg3y@unreal>
References: <20220111022404.2375531-1-yangx.jy@fujitsu.com>
 <Yd0fpzSbzWPv1TS0@unreal>
 <61DD4BB0.7070306@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61DD4BB0.7070306@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 11, 2022 at 09:19:46AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/1/11 14:11, Leon Romanovsky wrote:
> > On Tue, Jan 11, 2022 at 10:24:04AM +0800, Xiao Yang wrote:
> >> The expression "cons == ((qp->cur_index + 1) % q->index_mask)" mistakenly
> >> assumes the queue is full when the number of entires is equal to "maximum - 1"
> >> (maximum is correct).
> >>
> >> For example:
> >> If cons and qp->cur_index are 0 and q->index_mask is 1, check_qp_queue_full()
> >> reports ENOSPC.
> >>
> >> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> >> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >> ---
> >>   providers/rxe/rxe_queue.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
> >> index 6de8140c..708e76ac 100644
> >> --- a/providers/rxe/rxe_queue.h
> >> +++ b/providers/rxe/rxe_queue.h
> >> @@ -205,7 +205,7 @@ static inline int check_qp_queue_full(struct rxe_qp *qp)
> >>   	if (qp->err)
> >>   		goto err;
> >>
> >> -	if (cons == ((qp->cur_index + 1) % q->index_mask))
> >> +	if (cons == ((qp->cur_index + 1)&  q->index_mask))
> > Please reuse queue_full().
> Hi Leon,
> 
> qp->cur_index and qp->err are introduced for new ibv_wr_* APIs and I am 
> not sure if check_qp_queue_full() can be replaced with queue_full().
> 
> Bob, do you have any suggestion?


diff --git a/providers/rxe/rxe_queue.h b/providers/rxe/rxe_queue.h
index 6de8140c..83eb4a5f 100644
--- a/providers/rxe/rxe_queue.h
+++ b/providers/rxe/rxe_queue.h
@@ -198,14 +198,11 @@ static inline void advance_qp_cur_index(struct rxe_qp *qp)
 static inline int check_qp_queue_full(struct rxe_qp *qp)
 {
        struct rxe_queue_buf *q = qp->sq.queue;
-       uint32_t cons;
-
-       cons = atomic_load_explicit(consumer(q), memory_order_acquire);
 
        if (qp->err)
                goto err;
 
-       if (cons == ((qp->cur_index + 1) % q->index_mask))
+       if (queue_full(q))
                qp->err = ENOSPC;
 err:
        return qp->err;
(END)


> 
> Best Regards,
> Xiao Yang
> > Thanks
> >
> >>   		qp->err = ENOSPC;
> >>   err:
> >>   	return qp->err;
> >> -- 
> >> 2.25.1
> >>
> >>
> >>
