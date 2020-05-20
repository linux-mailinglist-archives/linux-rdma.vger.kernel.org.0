Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388C1DD564
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgEUR7U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 13:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUR7U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 May 2020 13:59:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7864520759;
        Thu, 21 May 2020 17:59:19 +0000 (UTC)
Date:   Wed, 20 May 2020 12:32:26 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200520093226.GC331541@unreal>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <CANjDDBgPQBOuBNQE=3PqsAtNgSzVbnDDt6wYNrS8iC-gAYzHJQ@mail.gmail.com>
 <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 12:23:01PM +0300, Yamin Friedman wrote:
>
> On 5/20/2020 9:19 AM, Devesh Sharma wrote:
> >
> > > +
> > > +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
> > > +                       enum ib_poll_context poll_ctx)
> > > +{
> > > +       LIST_HEAD(tmp_list);
> > > +       struct ib_cq *cq;
> > > +       unsigned long flags;
> > > +       int nr_cqs, ret, i;
> > > +
> > > +       /*
> > > +        * Allocated at least as many CQEs as requested, and otherwise
> > > +        * a reasonable batch size so that we can share CQs between
> > > +        * multiple users instead of allocating a larger number of CQs.
> > > +        */
> > > +       nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
> > > +       nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> > No WARN() or return with failure as pointed by Leon and me. Has
> > anything else changes elsewhere?
>
> Hey Devesh,
>
> I am not sure what you are referring to, could you please clarify?

He is saying that dev->num_comp_vectors can be 0.

Thanks
