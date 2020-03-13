Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E331848A0
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgCMN7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgCMN7H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 09:59:07 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF319206B7;
        Fri, 13 Mar 2020 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584107947;
        bh=c/5+KdewFLBGNZtT2UyA0nqc7u8kMlpAalIqivjSxAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zsptsZdXsSC0aHo5wb26FxmP4Fn6ZwfAMngKAZPZzUIH43G5jxSAkHOy/u2IOdASJ
         jTmJtfNP86ZAXNPLTHPzMXjzxmIM92fg2WTBY8fv7ecOFoN6eQ+Dsi5rIOX3PdN/Jv
         5ZGATGp7QXTik1e3uqA/W6KElG6uFh3Y14qp/tEQ=
Date:   Fri, 13 Mar 2020 15:59:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/cma: Provide ECE reject reason
Message-ID: <20200313135901.GI31504@unreal>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-12-leon@kernel.org>
 <20200313135430.GA25517@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313135430.GA25517@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 10:54:30AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 10, 2020 at 11:14:38AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > IBTA declares "vendor option not supported" reject reason in REJ
> > messages if passive side doesn't want to accept proposed ECE options.
> >
> > Due to the fact that ECE is managed by userspace, there is a need to let
> > users to provide such rejected reason.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cma.c    | 14 ++++++++------
> >  drivers/infiniband/core/ucma.c   |  7 ++++++-
> >  include/rdma/ib_cm.h             |  3 ++-
> >  include/rdma/rdma_cm.h           | 13 ++++++++++---
> >  include/uapi/rdma/rdma_user_cm.h |  7 ++++++-
> >  5 files changed, 32 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index f1f0d51667b7..0b57c15139cf 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -4191,8 +4191,8 @@ int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
> >  }
> >  EXPORT_SYMBOL(rdma_notify);
> >
> > -int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> > -		u8 private_data_len)
> > +int rdma_reject_ece(struct rdma_cm_id *id, const void *private_data,
> > +		    u8 private_data_len, enum rdma_ucm_reject_reason reason)
> >  {
>
> Let not call something like this rdma_reject_ece, pass in the
> ib_cm_rej_reason directly and update callers

The problem that no one is interested in the reason, this is why I
decided to go with special API.

>
> Jason
