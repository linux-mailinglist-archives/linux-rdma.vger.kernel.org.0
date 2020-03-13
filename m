Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9F18493D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMO0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 10:26:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33184 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMO0F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 10:26:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id p62so12769877qkb.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ed5ufMmYWYhcWsqnHeHVcNcvWgP4svSAXSCePEMQkmE=;
        b=pQbI2yDIco+kqBvbVdr0cYN7+LIit5DGX468RJnbdK2GZB1InIFuwtqYUTMoNpFG5R
         j3xRga75hLqUMO4s8mULJVoUae3sTjxpzbvlfvmxybJCAbGhWTo6uAHCzNZgsfSSnRR1
         LjvYf4XIdzBUx9TGZMZ9FzDzniopU9+tXpHdNqOubTq5Z3l47wMYptkVVcX9y7tQ2QwH
         WH6h4aQbe1LYAiRQZoUl4jvCWwctilVnCAzdM7mVEE/FD+eV3pcX9UguqNKho90BHoMo
         /PoMDzYQ/wMrOYj1evyRibIRoV6SuzCWBRhpzr5ISYgfEr0B3FVMNS8JPdNNPiena6xe
         h6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ed5ufMmYWYhcWsqnHeHVcNcvWgP4svSAXSCePEMQkmE=;
        b=iyNRK1TAkxEyghUTga1RzAwffHWnYDCd7aYEQn7+UrrICXiEvRt4E1WUUJn6QB6UG6
         ZDcMMNPExv8q7qtELKMG0BbL33YTv8K5AgAXKyb25MwgOgSmX3v9rtOqnEzT+JZ8609k
         Kgy0IypEMNdnpJoYYPTOw/hYqjrjI1M7Ir8qgtopS4znkwalEU9vBU/4z5wo7Svi+bDu
         Nj79jBviSljUrYLjo+ju2lRtUbiAX29p026O3UnqYuhQvgUMvIEvNgz+KM5HqERl8oEB
         DJ6u+NxMsXVAJXULURXdduGzyWlpB/OfemjcegEuMY7rgmGWo17g5SVx+vPe/Gnf93yN
         pNvQ==
X-Gm-Message-State: ANhLgQ3zVKzYDjQZwf6vU8pCHREUv0IDM/A6XfxcD0Y35B05wJit3zFw
        XuLFFznFUHzhCS6SeNQPtkz3ZC9V7zE=
X-Google-Smtp-Source: ADFU+vvRLR0YxPSuZSeGKlvZFeHvQh1435fC9PFbKa0qSLhKQjQ0vL9lkCZb5gASPGcPkkiuBUuHuA==
X-Received: by 2002:a37:8101:: with SMTP id c1mr2396358qkd.236.1584109563923;
        Fri, 13 Mar 2020 07:26:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w13sm22775661qtn.83.2020.03.13.07.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 07:26:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jClGE-0002UT-83; Fri, 13 Mar 2020 11:26:02 -0300
Date:   Fri, 13 Mar 2020 11:26:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
Message-ID: <20200313142602.GE31668@ziepe.ca>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
 <20200313134456.GA24733@ziepe.ca>
 <20200313135714.GH31504@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313135714.GH31504@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 03:57:14PM +0200, Leon Romanovsky wrote:
> On Fri, Mar 13, 2020 at 10:44:56AM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 10, 2020 at 11:14:30AM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Remove custom and duplicated variant of offsetofend().
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> > > index bf3120f140f7..5c57098a4aee 100644
> > > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > > @@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
> > >  	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
> > >  }
> > >
> > > -#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
> > > -				 sizeof_field(typeof(x), fld) <= (sz))
> > > -
> > >  #define is_reserved_cleared(reserved) \
> > >  	!memchr_inv(reserved, 0, sizeof(reserved))
> > >
> > > @@ -609,7 +606,7 @@ struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> > >  	if (err)
> > >  		goto err_out;
> > >
> > > -	if (!field_avail(cmd, driver_qp_type, udata->inlen)) {
> > > +	if (offsetofend(typeof(cmd), driver_qp_type) > udata->inlen) {
> >
> > The > needs to be >=, and generally we write compares as
> >    'variable XX constant'
> 
> Why ">="
> The original code is
> if (!field_avail(cmd, driver_qp_type, udata->inlen))
> ==>
> if (!(offsetof(typeof(cmd), driver_qp_type) + sizeof_field(typeof(cmd), driver_qp_type,) <= (udata->inlen))
> ===>
> if (!(offsetofend(typeof(cmd), driver_qp_type) <= (udata->inlen))
> ===>
> if (offsetofend(typeof(cmd), driver_qp_type) > (udata->inlen)
> 
> like I wrote.

Oh ok, I missed the !

Jason
