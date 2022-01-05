Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0002D484F9B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 09:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiAEIzH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 03:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiAEIzH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 03:55:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA372C061761
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 00:55:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A1BB8196E
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 08:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CEEC36AE9;
        Wed,  5 Jan 2022 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641372904;
        bh=n50CCH9Tly2dsWmIqs7sCcg2i94BmbDfYgaDBEJRBWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6VtIZsN7GEOovWxwsyVHH002Rbe+t7lrKrbcqiJ7PApvJCJxYX6O+KShAKn+znkr
         QbLrpbLYUSWHiXsNAiY05Fir2w1GlqPXj5gnxobp2/YYrM7L6m6TiOQRI3h6fnhy+1
         PUBYfIj7VXjInoohbLXhTbMyWDciitUWBNhOU5zufZ/v/KU07Pjs+uE0FIIxLlk+WR
         AyASgL0+28lSPgcj5YyUWMhsYJ4rNjALpm4l0Kji+sJt7FruKL6ucZGtoAWxCth+68
         ilZtClzIdt3dWlUV02cjoqpdrMfJGWwdA4+YiO+ACqTCJbFyZQf1p/c7Qe7tgMgJws
         1Qk4ViyDcuoDA==
Date:   Wed, 5 Jan 2022 10:55:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     yanjun.zhu@linux.dev, liangwenpeng@huawei.com,
        Jason Gunthorpe <jgg@ziepe.ca>, mustafa.ismail@intel.com,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 4/5] RDMA/rxe: Use the standard method to produce udp
 source port
Message-ID: <YdVc5BMAaOh2aO2C@unreal>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-5-yanjun.zhu@linux.dev>
 <YdVONs32Ue7R0kk1@unreal>
 <CAD=hENeUv_7GjgDrZWr5wUmECtGY8=a=sPmbRanmh4zxLWzecA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeUv_7GjgDrZWr5wUmECtGY8=a=sPmbRanmh4zxLWzecA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 04:27:38PM +0800, Zhu Yanjun wrote:
> On Wed, Jan 5, 2022 at 3:52 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Jan 05, 2022 at 05:12:36PM -0500, yanjun.zhu@linux.dev wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > >
> > > Use the standard method to produce udp source port.
> > >
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > index 0aa0d7e52773..42fa81b455de 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > @@ -469,6 +469,12 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
> > >       if (err)
> > >               goto err1;
> > >
> > > +     if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))
> >
> > You are leaving src_port default and wired to same port as other QPs
> > without any randomization.
> 
> Hi,
> 
> I do not get you. Why do you think I am leaving src_pport default?

Because in original code, you randomized src_port without any relation
to mask flags. 

       qp->src_port = RXE_ROCE_V2_SPORT +
               (hash_32_generic(qp_num(qp), 14) & 0x3fff);

After patch #5, if user doesn't pass "proper" mask, you will leave
qp->src_port to be equal to RXE_ROCE_V2_SPORT, which is different from
the current behaviour.

Thanks


> Thanks.
> 
> Zhu Yanjun
> 
> >
> > Thanks
> >
> > > +             qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
> > > +                                               qp->ibqp.qp_num,
> > > +                                               qp->attr.dest_qp_num);
> > > +
> > > +
> > >       return 0;
> > >
> > >  err1:
> > > --
> > > 2.27.0
> > >
