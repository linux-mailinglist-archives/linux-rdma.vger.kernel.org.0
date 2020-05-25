Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8BE1E13C1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbgEYSCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYSCf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 14:02:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5356B206DD;
        Mon, 25 May 2020 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590429755;
        bh=ybP8LEXQc/S6o3x5L2lrmGshU1soOi/Hlyr+k6P5m9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxwZWQ6TJ0vmdJfjZY1g0B7CVdbQQlVoctoFuwuuPz+3V8JXYQy+AtZ6Qdz3BiMvO
         PpAJrcS10449gEpDdU8s6SqPPhXNQZ4+eVz+htm3KdBZIs5ipDYKBSmUR0SZ823nnm
         r7Gq3IWc7Qmtp2LxROT+AFJEsiBHrqoJox6v3T6U=
Date:   Mon, 25 May 2020 21:02:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 5/7] RDMA/cm: Send and receive ECE parameter
 over the wire
Message-ID: <20200525180230.GJ10591@unreal>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-6-leon@kernel.org>
 <20200525175812.GB24366@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525175812.GB24366@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 02:58:12PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 05:15:36PM +0300, Leon Romanovsky wrote:
> > @@ -2204,6 +2220,12 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
> >  		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
> >  	}
> >
> > +	IBA_SET(CM_REP_VENDOR_ID_L, rep_msg, param->ece.vendor_id & 0xFF);
> > +	IBA_SET(CM_REP_VENDOR_ID_M, rep_msg,
> > +		(param->ece.vendor_id >> 8) & 0xFF);
> > +	IBA_SET(CM_REP_VENDOR_ID_H, rep_msg,
> > +		(param->ece.vendor_id >> 16) & 0xFF);
>
> I'm pretty sure the & 0xFF isn't needed?

vendor_id is 32 bits, but IBTA spec uses only 24 bits. I preferred to
write it implicitly, but of course IBA_SET() will mask it properly.

>
> > diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> > index ed2c17046ee1..b67cdd2ef187 100644
> > +++ b/drivers/infiniband/core/ucma.c
> > @@ -362,7 +362,6 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
> >
> >  	uevent->resp.ece.vendor_id = event->ece.vendor_id;
> >  	uevent->resp.ece.attr_mod = event->ece.attr_mod;
> > -
> >  	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
> >  		if (!ctx->backlog) {
> >  			ret = -ENOMEM;
>
> Extra hunk?

Right

>
> Jason
