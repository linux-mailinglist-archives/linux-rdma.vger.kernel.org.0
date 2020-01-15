Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3713CE21
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 21:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAOUgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 15:36:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42820 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgAOUgv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 15:36:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so16964152qtq.9
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 12:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAKUDwP/e+r+t9LGTDNQ9rNpiXN3ioEIzxfesocrhDI=;
        b=KvJonJS+Dd0Iz0+3I2Kj9fRb9q3FU6BDpqEfY5leVMoT5F/QO9MUZSIazysdh7j3us
         nk3a76Gs9jPYjrm6iM29FvRdFyd+3nOYz/tirrGsrnX7BAD/a7oUj5EldPv0QOyEPr6+
         GXvo2UF5C2wYkvsaDBU+URYqWdj3Kyi9aqvtvXP0bkCNHLW925pNsQ9K5n7NweUtYJyz
         pW7uqE8xBBpzRAzJ/Kot7TWgLVFJAHTBzL/zpVtflaYalpWKKDtA/EnyIBqMwi5qMmvE
         /7Ka6Cc6HBvVJI+rlXs1zhhGUioFMYxelkxWWuQJC+bDWBPWtho6i0ufMEMYV4MqAT7K
         K+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAKUDwP/e+r+t9LGTDNQ9rNpiXN3ioEIzxfesocrhDI=;
        b=VlKD4F7kN1ZoScU1UMrh9dEkq0Y0h32slQacAtnmLaY5xsvHMXbMLAl8P0WanB3IY1
         CPlBuE+rV1DeVKHREzUOjMmgejYduAv5aZtHZXP5Td/44zjLEuV13KbxdDnfEwFF/kY0
         s5D1GGXhq2Z7B3T817gBP+CBWwOHFQwwbF1io2h5Wo0c4rD+CJGU2/NHoM4R1Hae/NIq
         SauDbRqLQrjLA1B7rs4+9sQ1siRITe4CKTXWAXr1hkaBUdEfmavsXMToEuXa69yxT1NC
         KXBtLZHCv5rAB86ippfNdmTie2E1YQVakIzykHV1N6JKUcEHujrVND7afSkbEMxgmTn0
         9WXg==
X-Gm-Message-State: APjAAAVo6+dUMu25AO9OcRRCZqAt0o/3M9XJ5k8Ro0350D/Xlo3E+F/3
        LzJIvv2RhKAOe5HPesoB8tiLLQ==
X-Google-Smtp-Source: APXvYqxC0Ph+Y/AoR5bEI9/y5gzcaUeyBY6AMwhJR+GAt8K7RQMX4zLW+JPOJzlbzq+RGFKHMulisA==
X-Received: by 2002:ac8:2b26:: with SMTP id 35mr417020qtu.341.1579120610811;
        Wed, 15 Jan 2020 12:36:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g81sm9019830qkb.70.2020.01.15.12.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 12:36:50 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irpPF-0006pM-SD; Wed, 15 Jan 2020 16:36:49 -0400
Date:   Wed, 15 Jan 2020 16:36:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     linux-rdma@vger.kernel.org, monis@mellanox.com,
        dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] SGE buffer and max_inline data must have same size
Message-ID: <20200115203649.GF25201@ziepe.ca>
References: <1578962480-17814-1-git-send-email-rao.shoaib@oracle.com>
 <1578962480-17814-3-git-send-email-rao.shoaib@oracle.com>
 <20200115182721.GE25201@ziepe.ca>
 <93b8e890-c4a9-6050-88b7-3667c023dd34@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b8e890-c4a9-6050-88b7-3667c023dd34@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 11:57:08AM -0800, Rao Shoaib wrote:
> 
> On 1/15/20 10:27 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 13, 2020 at 04:41:20PM -0800, rao Shoaib wrote:
> > > From: Rao Shoaib <rao.shoaib@oracle.com>
> > > 
> > > SGE buffer size and max_inline data should be same. Maximum of the
> > > two values requested is used.
> > > 
> > > Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
> > >   drivers/infiniband/sw/rxe/rxe_qp.c | 23 +++++++++++------------
> > >   1 file changed, 11 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > > index aeea994..41c669c 100644
> > > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > > @@ -235,18 +235,17 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
> > >   		return err;
> > >   	qp->sk->sk->sk_user_data = qp;
> > > -	qp->sq.max_wr		= init->cap.max_send_wr;
> > > -	qp->sq.max_sge		= init->cap.max_send_sge;
> > > -	qp->sq.max_inline	= init->cap.max_inline_data;
> > > -
> > > -	wqe_size = max_t(int, sizeof(struct rxe_send_wqe) +
> > > -			 qp->sq.max_sge * sizeof(struct ib_sge),
> > > -			 sizeof(struct rxe_send_wqe) +
> > > -			 qp->sq.max_inline);
> > > -
> > > -	qp->sq.queue = rxe_queue_init(rxe,
> > > -				      &qp->sq.max_wr,
> > > -				      wqe_size);
> > > +	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
> > > +			 init->cap.max_inline_data);
> > > +	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
> > > +	qp->sq.max_inline = wqe_size;
> > > +
> > > +	wqe_size += sizeof(struct rxe_send_wqe);
> > Where does this limit the user's request to RXE_MAX_WQE_SIZE ?
> 
> My understanding is that the user request can only specify sge's and/or
> inline data. The check for those is made in rxe_qp_chk_cap. Since max sge's
> and max inline data are constrained by RXE_MAX_WQE_SIZE the limit is
> enforced.

Okay, that is fine, it is a bit obtuse because of how distant
rxe_qp_chk_cap() is from this function, lets just add a comment

> > I seem to recall the if the requested max can't be satisified then
> > that is an EINVAL?
> > 
> > And the init->cap should be updated with the actual allocation.
> 
> Since the user request for both (sge's and inline data) has been satisfied I
> decided not to update the values in case the return values are being
> checked. If you prefer that I update the values I can do that.

If the sizes are increased then the driver is supposed to return the
actual maximums.

It is easy, I will fix it.

Also, your patches don't apply cleanly. You need to send patches
against the rdma for-next tree

And subjects should start with some 'RDMA/rxe: ' tag

I fixed it all and applied to for-next

Thanks,
Jason
