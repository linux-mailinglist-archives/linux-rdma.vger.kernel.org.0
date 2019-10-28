Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6787E72CF
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfJ1Nnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:43:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36457 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ1Nnx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 09:43:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so8480332qkc.3
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YK6I3EI2xzeW3aVU7of71J5VAEzgVJFGrgc26KP1Fuo=;
        b=WJY78f/lcHhzaX5V4/NVjNRBryxz0rgCa+KLD4os+YX9SDTYFEAdQK9qGVviFEgySN
         MIlqp/k8aLIGXrIKz2f+B1c5Ogj8jArKsVSjmi9FSbUNkq3HP8WV9hq//OAGq+ImzDXx
         IHAPYn4IgEZjM+u6tuI/0bVajrvf5CtRrDhjSJyM3bfihm7vb6bNlCS3d4gmzEAsQu+W
         lKBihqVav8Ix+uLfYOsBx/1UYrW4FK9vGusPWrKjhsLJWoBRg46VlYLCvwbbtNdyp+Px
         0clu+HOExNh+fpvkJuisoi3fUpa+Es36DXKb2fvaYCzoT9EGzsDRp6wpJJqrdbRhYrc0
         xhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YK6I3EI2xzeW3aVU7of71J5VAEzgVJFGrgc26KP1Fuo=;
        b=majmZPLENI8hBQ0XhPEH/8boKyAZM3y8OOnR+lZMB3rA1qMHt6/t+ZSyVdODhq0/I3
         7RXxCFPITDU+m8RMzBB3zCEOnfC/11PgcBM1eMn/bpVnXus4qbjITRWsn9cvuPpc4TNc
         EKNrudNic/f/rdpRmyyc+YoJtwzOs3y4wXr6wu8GbQL17/u1Sk+EeqT7dnmbIDMRNUWm
         WGRroD/B2FgKUaiB7YE9p+QaFX+iFjPDkEHeYlQ+MxMZBovVbJpFoZnmjv2aFzoL/aml
         apdRiX2+K3x/xyM32HT3TvMsVHev9lhC2yhyhmTMKn62S15A8Y+lbDzERj1Ut31NL5VM
         tX7g==
X-Gm-Message-State: APjAAAX9bxX4N6PAtzPSrJODUiraJ1A8fMdFDE/jm1YFwIc2v5R8w9Zm
        YACVSGBD6d/DPmJc4vAD5TqXlw==
X-Google-Smtp-Source: APXvYqxLilPQ2XUzs072ErTovaH6No7TkW5HtfQG3hKhEE/qHb2Dqn1D8Y3kv0gT3as/55NgaM9l3w==
X-Received: by 2002:a05:620a:2115:: with SMTP id l21mr14734246qkl.407.1572270232104;
        Mon, 28 Oct 2019 06:43:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x39sm6741648qth.92.2019.10.28.06.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 06:43:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP5JH-0008Ox-Aw; Mon, 28 Oct 2019 10:43:51 -0300
Date:   Mon, 28 Oct 2019 10:43:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 6/6] RDMA/srpt: Use private_data_len instead of
 hardcoded value
Message-ID: <20191028134351.GB29652@ziepe.ca>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-7-leon@kernel.org>
 <20191028131319.GA15102@ziepe.ca>
 <20191028131917.GE5146@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028131917.GE5146@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:19:17PM +0200, Leon Romanovsky wrote:
> On Mon, Oct 28, 2019 at 10:13:19AM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 20, 2019 at 10:15:59AM +0300, Leon Romanovsky wrote:
> > > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > index daf811abf40a..e66366de11e9 100644
> > > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > @@ -2609,7 +2609,7 @@ static int srpt_cm_handler(struct ib_cm_id *cm_id,
> > >  	case IB_CM_REJ_RECEIVED:
> > >  		srpt_cm_rej_recv(ch, event->param.rej_rcvd.reason,
> > >  				 event->private_data,
> > > -				 IB_CM_REJ_PRIVATE_DATA_SIZE);
> > > +				 event->private_data_len);
> >
> > So, I took a look and found a heck of a lot more places assuming the
> > size of private data that really should be checked if we are going to
> > introduce a buffer length here.
> 
> But we are not interested to make it dynamic, "private_data_len" has
> constant size according to IBTA spec, I just don't want users to be
> aware of this.
> 
> Why should we add the below checks if it wasn't before?

Why are we doing any of this then?

Jason
