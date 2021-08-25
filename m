Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D383F721F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbhHYJpC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 05:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239638AbhHYJpA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 05:45:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF03661153;
        Wed, 25 Aug 2021 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629884654;
        bh=EcXTSg4v+DooFRFJCzTs3wn3E8EhXif8cyJUl4VW21E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fN6npZA/bbcT6FP8ITe59m9/SCT1XPwtGQ6QbJKye3tFhi9JZPju13haWT3AfJCw6
         A/Ro675HKPOI5upr5QKURFyltWrFnRTJDSOSSvkBCNE56eYgkkbsdh/DAd/UV2ckAB
         zOsDRhRPeRR8tuCBi5+jwjnVxkvrDyqA3ALdMdSNXs7KBo1aHvfKsygaXDOCdsHEi/
         xVisoh1SJ9cXOSF+4KHr3nGu8935CrxKkRDiEjMqwHZ63kw5gOpR1b/tNWfWShYa1Y
         7C3l/WQ+h7ZRCk7Bfec18pjloTPU3KStrlXoEsXshBftRUxgyKZlBZbQv6KZyTZ5d+
         fevEqjJ6q5yWQ==
Date:   Wed, 25 Aug 2021 12:44:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] providers/rxe: Set the correct value of resid for
 inline data
Message-ID: <YSYQ6hLAebrnGow6@unreal>
References: <20210809150738.150596-1-yangx.jy@fujitsu.com>
 <7279c618-d373-d7ce-c67c-97e519b48e94@gmail.com>
 <CAD=hENc2gt98YyhOC=EsSTsN0=-EZ7Pz1Kht96HYNA+qvdfWyQ@mail.gmail.com>
 <324764c2-4f41-0106-70e0-aaccb3c50c15@gmail.com>
 <6122FAE1.4080306@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6122FAE1.4080306@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 01:33:24AM +0000, yangx.jy@fujitsu.com wrote:
> Hi Leon,
> 
> Could you review the patch?

There is no need, I trust to Zhu's and Bob's review.

Thanks

> 
> Best Regards,
> Xiao Yang
> On 2021/8/17 2:52, Bob Pearson wrote:
> > On 8/15/21 10:55 PM, Zhu Yanjun wrote:
> >> On Sat, Aug 14, 2021 at 6:11 AM Bob Pearson<rpearsonhpe@gmail.com>  wrote:
> >>> On 8/9/21 10:07 AM, Xiao Yang wrote:
> >>>> Resid indicates the residual length of transmitted bytes but current
> >>>> rxe sets it to zero for inline data at the beginning.  In this case,
> >>>> request will transmit zero byte to responder wrongly.
> >>>>
> >>>> Resid should be set to the total length of transmitted bytes at the
> >>>> beginning.
> >>>>
> >>>> Note:
> >>>> Just remove the useless setting of resid in init_send_wqe().
> >>>>
> >>>> Fixes: 1a894ca10105 ("Providers/rxe: Implement ibv_create_qp_ex verb")
> >>>> Fixes: 8337db5df125 ("Providers/rxe: Implement memory windows")
> >>>> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >>>> ---
> >>>>   providers/rxe/rxe.c | 5 ++---
> >>>>   1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
> >>>> index 3c3ea8bb..3533a325 100644
> >>>> --- a/providers/rxe/rxe.c
> >>>> +++ b/providers/rxe/rxe.c
> >>>> @@ -1004,7 +1004,7 @@ static void wr_set_inline_data(struct ibv_qp_ex *ibqp, void *addr,
> >>>>
> >>>>        memcpy(wqe->dma.inline_data, addr, length);
> >>>>        wqe->dma.length = length;
> >>>> -     wqe->dma.resid = 0;
> >>>> +     wqe->dma.resid = length;
> >>>>   }
> >>>>
> >>>>   static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> >>>> @@ -1035,6 +1035,7 @@ static void wr_set_inline_data_list(struct ibv_qp_ex *ibqp, size_t num_buf,
> >>>>        }
> >>>>
> >>>>        wqe->dma.length = tot_length;
> >>>> +     wqe->dma.resid = tot_length;
> >>>>   }
> >>>>
> >>>>   static void wr_set_sge(struct ibv_qp_ex *ibqp, uint32_t lkey, uint64_t addr,
> >>>> @@ -1473,8 +1474,6 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
> >>>>        if (ibwr->send_flags&  IBV_SEND_INLINE) {
> >>>>                uint8_t *inline_data = wqe->dma.inline_data;
> >>>>
> >>>> -             wqe->dma.resid = 0;
> >>>> -
> >>>>                for (i = 0; i<  num_sge; i++) {
> >>>>                        memcpy(inline_data,
> >>>>                               (uint8_t *)(long)ibwr->sg_list[i].addr,
> >>>>
> >>> Signed-off-by: Bob Pearson<rpearsonhpe@gmail.com>
> >> The Signed-off-by: tag indicates that the signer was involved in the
> >> development of the patch, or that he/she was in the patch’s delivery
> >> path.
> >>
> >> Zhu Yanjun
> >>
> > Sorry, my misunderstanding. Then I want to say
> >
> > Reviewed-by: Bob Pearson<rpearsonhpe@gmail.com>
> >
> > The patch looks correct to me.
