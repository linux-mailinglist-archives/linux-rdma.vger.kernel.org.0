Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E241CE0BB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgEKQjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgEKQjQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:39:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00F120720;
        Mon, 11 May 2020 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589215156;
        bh=SwKmLfJwFPINoyZ6PcjUP6iYtwTKBxXM6G3SWIcIOjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTDgyMsbI+3rOcHFaIS3Miu9iUy9f4QxotmxooTQmFNiZ5996InxuOUky+0+iSRGU
         p6EayYml4Can35HsjTi49AG9ly2yCt8sGeULkp4KMH/VJYuwF6HvdBrGij+/lw49HC
         WmDDTzxNAS2XGTj/0TeFUqNv/4QvSv3dtdZPULSg=
Date:   Mon, 11 May 2020 19:39:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200511163912.GD356445@unreal>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <20200511050740.GB356445@unreal>
 <345890f8-52d6-1aef-dd63-b3115384def5@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345890f8-52d6-1aef-dd63-b3115384def5@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 03:08:45PM +0300, Yamin Friedman wrote:
>
> On 5/11/2020 8:07 AM, Leon Romanovsky wrote:
> > On Sun, May 10, 2020 at 05:55:55PM +0300, Yamin Friedman wrote:
> > > Allow a ULP to ask the core to provide a completion queue based on a
> > > least-used search on a per-device CQ pools. The device CQ pools grow in a
> > > lazy fashion when more CQs are requested.

<...>

> > > +	while (!found) {
> > > +		spin_lock_irqsave(&dev->cq_pools_lock, flags);
> > > +		list_for_each_entry(cq, &dev->cq_pools[poll_ctx - 1],
> > > +				    pool_entry) {
> > > +			if (vector != cq->comp_vector)
> > > +				continue;
> > > +			if (cq->cqe_used + nr_cqe > cq->cqe)
> > > +				continue;
> > > +			if (found && cq->cqe_used >= found->cqe_used)
> > > +				continue;
> > > +			found = cq;
> > Don't you need to break from this loop at some point of time?
> In order to find the emptiest cq it loops over the entire list. If you think
> it is better just to find the first one with enough space I will break once
> one is found.

Does it matter to find emptiest CQ as long as you find one with enough cqe?
If yes, please document it, if no, this loop can be simplified.

Thanks
