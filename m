Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82372E72D3
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbfJ1No7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:44:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46607 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfJ1No6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 09:44:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so14542777qtq.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e9dgRS2bJye9M1KTbvrOhz3cBTbSDDabHPsvuKIWFaQ=;
        b=ionRJxr9PHYBGVzmw5h+grbPskMfDDz/haJhEn6eBxwdOdYcPsI8mDHULFipWSYm1J
         N4lUceXG+996LcbA/jYMouVi1bBsDDHsL5Wmz+C+zBJJCm/0qDc1m8ztnBt2LhcfsbPr
         7NjnfNBysp1T1hA//ZVBnlIHm7gWQRUr00h49mV6Tg7kYKppb2xDyK/5dCoLwu/KFPMT
         L/3lj5Fl6bglSiNeKaundZePVv55BKKcwU+L/fWXmHAsNZJqkybRLMBVbe0vFcObfMS+
         chkOoL3h8j1lL3v0QfiIM5+ueBnGOhBFjNG+KgxLJTuBeoO82b2ZDjON7sUoyz/0W9AA
         uNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9dgRS2bJye9M1KTbvrOhz3cBTbSDDabHPsvuKIWFaQ=;
        b=FOvFnoeVDyvqjvIk3adXHI/tA5BHed8t6Xd0tcvT5U6ARedGhBiuq7K7zS6K8WWveR
         1T07Qbsgp3NgKFxEtT6OHur5y2EpZ761nCMadYFJRJr3hBVX55Ibl+RF1uYXi8o0ZNKM
         uQ7VkIiYtnP0XrkI6igQQPo3zxEvY499Kh6HQmqWPKPy33ekSAhf+DXcxwg1yuIg2rLH
         d+2i8Ypboay4GLMhIW1nJuN7NfEXI5xxI/cjs6AmORIhQ72pgU0WJloyoEmOwJfpRwOV
         1yd5hyaWnmBlfg7rwfI0yfpmgN4q/JfDz1XbTF0wYBpgH9eGSvbqwP4VQMVST0o5OTGj
         7zTA==
X-Gm-Message-State: APjAAAWzccTCvV4tzTNfV/4yzWdX1uDGm3Tg5YLDBctcB+rtBhyLZ/ey
        mLuzBptuCdR8uA91RLbwbymXmQ==
X-Google-Smtp-Source: APXvYqxxkrWl360zrGae1b/DaYLuIueI+/usP3wGA4T3oV8XzLrgKeYuI2lP1ZDoHT29sT4YPuW7ag==
X-Received: by 2002:aed:3baf:: with SMTP id r44mr15276626qte.255.1572270298027;
        Mon, 28 Oct 2019 06:44:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g137sm356451qke.4.2019.10.28.06.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 06:44:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP5KL-0008Px-7y; Mon, 28 Oct 2019 10:44:57 -0300
Date:   Mon, 28 Oct 2019 10:44:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Or Gerlitz <gerlitz.or@gmail.com>
Subject: Re: [PATCH rdma-next 4/6] RDMA/cm: Delete useless QPN masking
Message-ID: <20191028134457.GC29652@ziepe.ca>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-5-leon@kernel.org>
 <20191028125233.GA27317@ziepe.ca>
 <20191028131333.GD5146@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028131333.GD5146@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:13:33PM +0200, Leon Romanovsky wrote:
> On Mon, Oct 28, 2019 at 09:52:33AM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 20, 2019 at 10:15:57AM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > QPN is supplied by kernel users who controls and creates valid QPs,
> > > such flow ensures that QPN is limited to 24bits and no need to mask
> > > already valid QPN.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/cm.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> > > index 7ffa16ea5fe3..2eb8e1fab962 100644
> > > +++ b/drivers/infiniband/core/cm.c
> > > @@ -2101,7 +2101,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
> > >  	cm_id_priv->initiator_depth = param->initiator_depth;
> > >  	cm_id_priv->responder_resources = param->responder_resources;
> > >  	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
> > > -	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);
> > > +	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);
> >
> > It does seem like this value comes from userspace:
> >
> > ucma_connect()
> >   ucma_copy_conn_param()
> >     	dst->qp_num = src->qp_num
> >   rdma_connect(.., &dst)
> > 	if (!id->qp) {
> > 		id_priv->qp_num = conn_param->qp_num;
> >
> > vs
> >
> > cma_accept_ib()
> > 	rep.qp_num = id_priv->qp_num;
> >
> > Maybe this needs to add some masking to ucma_copy_conn_param()?
> 
> Thanks for the callstack, Or pointed it to me too, but I missed this flow.
> Let's create a pre-patch with QPN masking.

You'll need to check all the id_priv->qp_num users, I stopped when I
found the above

Jason
