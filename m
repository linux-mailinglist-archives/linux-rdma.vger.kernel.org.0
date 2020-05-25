Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0101E13AB
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388874AbgEYRro (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 13:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRro (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 13:47:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA82320776;
        Mon, 25 May 2020 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590428863;
        bh=9dsJN6DALY4LnqZTMxAlhM/L8YJWZ/9Uj0S00hPFALw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfADdmH1SMNbEuQpPRBMYJi40qURIfiE05ACeT9FCbCB8S9W+/xUGAkf5dazDR+xw
         +lBHJ/pWiiF2gQroc7G/+pNQtEvM6gVZ9GsrMd0Os5nvsWGhS8vr1V2YPD8ja9pihf
         F+E7GsNtQ1yBC0nmzypSsWEgrYEd9dAerFbjloCI=
Date:   Mon, 25 May 2020 20:47:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 3/7] RDMA/ucma: Extend ucma_connect to
 receive ECE parameters
Message-ID: <20200525174739.GH10591@unreal>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-4-leon@kernel.org>
 <20200525174141.GA24366@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525174141.GA24366@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 02:41:41PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 13, 2020 at 05:15:34PM +0300, Leon Romanovsky wrote:
>
> > -	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
> > +	in_size = min_t(size_t, in_len, sizeof(cmd));
> > +	if (copy_from_user(&cmd, inbuf, in_size))
> >  		return -EFAULT;
> >
> >  	if (!cmd.conn_param.valid)
> > @@ -1086,8 +1089,13 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
> >  		return PTR_ERR(ctx);
> >
> >  	ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
> > +	if (offsetofend(typeof(cmd), ece) <= in_size) {
> > +		ece.vendor_id = cmd.ece.vendor_id;
> > +		ece.attr_mod = cmd.ece.attr_mod;
> > +	}
>
> The uapi changes in the prior patch should be placed in the patches
> that actually implement them, eg one here..

I wanted to simplify the series and keep its bisectable at the same
time. Should I squash them?

>
> > diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> > index 71f48cfdc24c..86a849214c84 100644
> > --- a/include/rdma/rdma_cm.h
> > +++ b/include/rdma/rdma_cm.h
> > @@ -264,6 +264,17 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
> >   */
> >  int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
> >
> > +/**
> > + * rdma_connect_ece - Initiate an active connection request with ECE data.
> > + * @id: Connection identifier to connect.
> > + * @conn_param: Connection information used for connected QPs.
> > + * @ece: ECE parameters
> > + *
> > + * See rdma_connect() explanation.
> > + */
> > +int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> > +		     struct rdma_ucm_ece *ece);
>
> kdoc's go in the C files

I know, but didn't know if to follow existing pattern or not.

>
> Jason
