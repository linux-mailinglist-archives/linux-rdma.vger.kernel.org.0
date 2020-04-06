Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABB19FD52
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 20:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgDFSiz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 14:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgDFSiz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Apr 2020 14:38:55 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89408206C3;
        Mon,  6 Apr 2020 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586198334;
        bh=LOm2Y/gpIjOzxdFeCY/ogY3FKcsGKIMqCD8tHeNzHck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w8jxfqB93aPE9sABJILMLG3p/4/71WAUTvstVJxdBjHr+5AJHR0F+nYtI+qV68H1z
         4QZY2u+Q+o69Q9s2Rews+CZWbWvkZJVV9Xm7D9UX858RzWTEmPkEBb5MO0f5O+H5Mh
         oylrDVtkJwbz0GFJNVoNCZpnOTQygeSxV5rtApOk=
Date:   Mon, 6 Apr 2020 21:38:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/cm: Fix missing RDMA_CM_EVENT_REJECTED
 event after receiving REJ message
Message-ID: <20200406183845.GK80989@unreal>
References: <20200406173242.1465911-1-leon@kernel.org>
 <20200406174556.GS20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406174556.GS20941@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 02:45:56PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 06, 2020 at 08:32:42PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The cm_reset_to_idle() call before formatting event changed the CM_ID
> > state from IB_CM_REQ_RCVD to be IB_CM_IDLE. It caused to wrong value
> > of CM_REJ_MESSAGE_REJECTED field.
> >
> > The result of that was that rdma_reject() calls in the passive side
> > didn't generate RDMA_CM_EVENT_REJECTED event in the active side.
> >
> > Fixes: 81ddb41f876d ("RDMA/cm: Allow ib_send_cm_rej() to be done under lock")
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cm.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > index bbbfa77dbce7..06f8eeba423a 100644
> > +++ b/drivers/infiniband/core/cm.c
> > @@ -1843,11 +1843,9 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
> >
> >  static void cm_format_rej(struct cm_rej_msg *rej_msg,
> >  			  struct cm_id_private *cm_id_priv,
> > -			  enum ib_cm_rej_reason reason,
> > -			  void *ari,
> > -			  u8 ari_length,
> > -			  const void *private_data,
> > -			  u8 private_data_len)
> > +			  enum ib_cm_rej_reason reason, void *ari,
> > +			  u8 ari_length, const void *private_data,
> > +			  u8 private_data_len, enum ib_cm_state state)
> >  {
> >  	lockdep_assert_held(&cm_id_priv->lock);
> >
> > @@ -1855,7 +1853,7 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
> >  	IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
> >  		be32_to_cpu(cm_id_priv->id.remote_id));
> >
> > -	switch(cm_id_priv->id.state) {
> > +	switch (state) {
> >  	case IB_CM_REQ_RCVD:
> >  		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg, be32_to_cpu(0));
> >  		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
> > @@ -1920,8 +1918,9 @@ static void cm_dup_req_handler(struct cm_work *work,
> >  			      cm_id_priv->private_data_len);
> >  		break;
> >  	case IB_CM_TIMEWAIT:
> > -		cm_format_rej((struct cm_rej_msg *) msg->mad, cm_id_priv,
> > -			      IB_CM_REJ_STALE_CONN, NULL, 0, NULL, 0);
> > +		cm_format_rej((struct cm_rej_msg *)msg->mad, cm_id_priv,
> > +			      IB_CM_REJ_STALE_CONN, NULL, 0, NULL, 0,
> > +			      cm_id_priv->id.state);
>
> This can just be IB_CM_TIMEWAIT instead of cm_id_priv->id.state

It can, do you want me to resend it? Or maybe you can change it while
applying?

Thanks

>
> Jason
