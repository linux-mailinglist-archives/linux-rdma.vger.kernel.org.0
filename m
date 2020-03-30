Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5752D19747E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 08:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgC3G1k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 02:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgC3G1k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Mar 2020 02:27:40 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080D120732;
        Mon, 30 Mar 2020 06:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585549659;
        bh=UPmaYQE/JY+TF/CTQ3W+w14eEAN6TItastTu2iVLRBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKje8GuhDUFgIFL2SKhXauRTg6/Z9wK8qcSsGxk00ARr907mGQuaQpI8EfCu7hdJj
         YDub1V8UK2AkBVnMDkoojiTH2n5Sg5SojBgZ//AjKLKuo3O9r63HlcQPe4hxeMizW1
         HfV1rLqBbhRkIGkt3sVeYb43No6BQaFWosYS5+CI=
Date:   Mon, 30 Mar 2020 09:27:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1 6/7] RDMA/cm: Set flow label of recv_wc
 based on primary flow label
Message-ID: <20200330062722.GG2454444@unreal>
References: <20200322093031.918447-1-leon@kernel.org>
 <20200322093031.918447-7-leon@kernel.org>
 <20200327123733.GA6821@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327123733.GA6821@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 27, 2020 at 09:37:33AM -0300, Jason Gunthorpe wrote:
> On Sun, Mar 22, 2020 at 11:30:30AM +0200, Leon Romanovsky wrote:
> > From: Mark Zhang <markz@mellanox.com>
> >
> > In the request handler of the response side, Set flow label of the
> > recv_wc if it is not net. It will be used for all messages sent
> > by the responder.
> >
> > Signed-off-by: Mark Zhang <markz@mellanox.com>
> > Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cm.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index bbbfa77dbce7..4ab2f71da522 100644
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -2039,6 +2039,7 @@ static int cm_req_handler(struct cm_work *work)
> >  	struct cm_req_msg *req_msg;
> >  	const struct ib_global_route *grh;
> >  	const struct ib_gid_attr *gid_attr;
> > +	struct ib_grh *ibgrh;
> >  	int ret;
> >
> >  	req_msg = (struct cm_req_msg *)work->mad_recv_wc->recv_buf.mad;
> > @@ -2048,6 +2049,12 @@ static int cm_req_handler(struct cm_work *work)
> >  	if (IS_ERR(cm_id_priv))
> >  		return PTR_ERR(cm_id_priv);
> >
> > +	ibgrh = work->mad_recv_wc->recv_buf.grh;
> > +	if (!(be32_to_cpu(ibgrh->version_tclass_flow) & IB_GRH_FLOWLABEL_MASK))
> > +		ibgrh->version_tclass_flow |=
> > +			cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL,
> > +					    req_msg));
>
> This doesn't seem right.
>
> Up until the path is established the response should follow the
> reversible GMP rules and the flow_label should come out of the
> request's GRH.
>
> Once we established the return data path and the GMP's switch to using
> the datapath, the flowlabel should be set in something like
> cm_format_paths_from_req()
>
> If you want to switch to using the return data path for REP replies
> earlier then it should be done completely and not only the flow
> label. But somehow I suspect we cannot as this could fail too.

Jason,

We can drop this patch, it was added to provide same sport in REJ
messages, but it is not needed due to the IBTA section
"13.5.4.3 CONSTRUCTING A RESPONSE WITHOUT A GRH".

Rest of the series is fine.

Thanks

>
> Jason
