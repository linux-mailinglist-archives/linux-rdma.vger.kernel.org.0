Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4DE20751D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbgFXOAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404006AbgFXOAu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 10:00:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05BBC061573
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 07:00:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c139so1827178qkg.12
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pMnIVtcgluMgzuWRgEU28vinoDRilIT0bAv01LQjG8U=;
        b=mv6Lz2UhWGNwqgik4c+TsKLcVfrNPUTQEi7cXFIma0lErFDLkvf2/x5hmip4AzyiRx
         MNzCBxYrvaXd/A7+5VDRVo7oZX9cPxthx25+S+I1xPJGhRkDyzu+/HuuBOmDxnHhuQ5L
         ueAVL5ZigpvJUEGUruM0oIYzgCDNuFe1T3X0M9ZB+XrIVbwat7WZcR1zNqCSiS+XA+wN
         67R9iGjq209oC2XC+yhIfZa+tgg2m8uSFfZS8xJyR9CdcmPB2gXUBFrpn8Iw1KgxiU9B
         TdYmO5TybSyTg7po1aj091fAm1dKjD/zzVMgM8xIoe3uu54L4dilH2hqWIoTfew1CqS6
         q4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pMnIVtcgluMgzuWRgEU28vinoDRilIT0bAv01LQjG8U=;
        b=mbHzYfXnlr1vluf5yLVN7gGn25oeRqtioWbTCtmtHtbzWUBtjDiXpX8OTYzleClyke
         efyOO+Go4GGgIllbEYsXw//u69kToBjurU01yD2hCzp2mt3eR47dyB/ydBNiOd++PMzu
         /XZTlQBav/ZqeZcGYh0jGx09rlK87IqYlSRRPnIJgJBNfqRyzRSbe7hnW396PKpYyIVL
         zJXohQ792KSA8WgZisGZCcDV7Y9mxYxWy5ZAgd1kw2+izgOZjuBqfYvyd09b2yncExyu
         mvGQ+kRCx99kGn4WDSRg+EwYgvY8NQ0kNRooLQe/EuAWU0i4cpDZ9tZ+XRwuSz1vq3Ew
         N+lw==
X-Gm-Message-State: AOAM533RDIKyVDju0Lu2jGMILvITea2h8wM4vr937RCcEBQBEFsbUMCv
        Cfvui4vCg3MRVLz9aP3I7+ks/g==
X-Google-Smtp-Source: ABdhPJzO2eVOmbIaMX9dtKe9CcKXcIn7F3Z6ljcykG35dEEZHyN6rN/5ZwTrGk9ollIpibVtIangxQ==
X-Received: by 2002:a37:7086:: with SMTP id l128mr23700306qkc.172.1593007248991;
        Wed, 24 Jun 2020 07:00:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f15sm2749254qka.120.2020.06.24.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:00:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo5xH-00DVMR-CF; Wed, 24 Jun 2020 11:00:47 -0300
Date:   Wed, 24 Jun 2020 11:00:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200624140047.GG6578@ziepe.ca>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
 <20200623175200.GA3096958@mellanox.com>
 <20200623181506.GC184720@unreal>
 <20200623184940.GN2874652@mellanox.com>
 <d5206962-69ae-48e7-261b-485db71d2a41@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5206962-69ae-48e7-261b-485db71d2a41@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 01:42:49PM +0300, Maor Gottlieb wrote:
> 
> On 6/23/2020 9:49 PM, Jason Gunthorpe wrote:
> > On Tue, Jun 23, 2020 at 09:15:06PM +0300, Leon Romanovsky wrote:
> > > On Tue, Jun 23, 2020 at 02:52:00PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
> > > > > From: Maor Gottlieb <maorg@mellanox.com>
> > > > > 
> > > > > Replace the mutex with read write semaphore and use xarray instead
> > > > > of linked list for XRC target QPs. This will give faster XRC target
> > > > > lookup. In addition, when QP is closed, don't insert it back to the
> > > > > xarray if the destroy command failed.
> > > > > 
> > > > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > >   drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
> > > > >   include/rdma/ib_verbs.h         |  5 ++-
> > > > >   2 files changed, 23 insertions(+), 39 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > > > index d66a0ad62077..1ccbe43e33cd 100644
> > > > > +++ b/drivers/infiniband/core/verbs.c
> > > > > @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
> > > > >   	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
> > > > >   }
> > > > > 
> > > > > -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
> > > > > -{
> > > > > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > > > > -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
> > > > > -	mutex_unlock(&xrcd->tgt_qp_mutex);
> > > > > -}
> > > > > -
> > > > >   static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
> > > > >   				  void (*event_handler)(struct ib_event *, void *),
> > > > >   				  void *qp_context)
> > > > > @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
> > > > >   	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
> > > > >   		return ERR_PTR(-EINVAL);
> > > > > 
> > > > > -	qp = ERR_PTR(-EINVAL);
> > > > > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > > > > -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
> > > > > -		if (real_qp->qp_num == qp_open_attr->qp_num) {
> > > > > -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
> > > > > -					  qp_open_attr->qp_context);
> > > > > -			break;
> > > > > -		}
> > > > > +	down_read(&xrcd->tgt_qps_rwsem);
> > > > > +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
> > > > > +	if (!real_qp) {
> > > > Don't we already have a xarray indexed against qp_num in res_track?
> > > > Can we use it somehow?
> > > We don't have restrack for XRC, we will need somehow manage QP-to-XRC
> > > connection there.
> > It is not xrc, this is just looking up a qp and checking if it is part
> > of the xrcd
> > 
> > Jason
> 
> It's the XRC target  QP and it is not tracked.

Really? Something called 'real_qp' isn't stored in the restrack?
Doesn't that sound like a bug already?

Jason 
