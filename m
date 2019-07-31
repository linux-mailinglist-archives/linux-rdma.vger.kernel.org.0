Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD3AA7C2A4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGaNC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 09:02:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38704 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfGaNC2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 09:02:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so49139089qkk.5
        for <linux-rdma@vger.kernel.org>; Wed, 31 Jul 2019 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q1pmwc8TwiRz5sYswxxLrqE6m0VV5U7E+V0e4P7lrP8=;
        b=nEB+QVzc7pMGnwo7KnfCB7kMeif7Ma4gVJ7zVpIaucDvndJCQHSZ0CfrQL5h4AiAyE
         IFk1Ug2Fz4GPDib2jEJ+rjjrRfqDPSEgsIoIbDgGq4aUHgxZblgmneLVHWduREqyCp8a
         W11BFG+u3ks9klvEBKm5+Ef57eSrbnxdAoIgwhNheGAYeEOdJLPAxRXqdKG6XosQvvsA
         e7Orf33OBaUd1b3K+QWSzmJwALzvnAEyibewr+sqoGQWE7avIOCsHyaHQZoYpzHGOC0K
         8WZAXNwaTU9krjs1TR6lj0AFNhcel74wQA7aheJfBWHrQvfLeRc2c+r+Oyn8NXK6WzVB
         NHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q1pmwc8TwiRz5sYswxxLrqE6m0VV5U7E+V0e4P7lrP8=;
        b=qUMu/Q3++/cbgR1qTitJ17s00gIpsVzHpz49hNaqNhf4/eagpJfKPZghGhR4yvURa+
         +J9iOkk3e4rxODoqOiZni1hXDEtjIRiIklkAcGfvGuRPgp0wMq3Y4wKlDVtgF4ScAGZ7
         VnstovbY+BEQxQRybta6zKs/EhSN3MVjA6dOOisJ4aj05dbdrD+VAsv7SWC6epLXS2Bd
         ef6s2MQkhTn3ktbaWSsZ3wEhqsDwdbftQRoMeoA0mFetrfCPMNXjR10R8+NP/HriaoxI
         cM72PD7G6to3L6fvs5JVnRqHPQeGqpiJpXM588fjIon6zZGDSWHdGGne8iQNIMf1Gx6a
         InZA==
X-Gm-Message-State: APjAAAWfq/fsRkDgCMgLplQWtRRjpE8KgDknFRw8FBfWkwjcQHue769h
        75jcVdQqL/ulXF7oNOuuh6agww==
X-Google-Smtp-Source: APXvYqzxHGELOQ5L3ILIRpKmOdqtz5ghTEx9UKNtR7ESk7R1omCYFQAVSZo/by8xiKAvscfhZzCu4A==
X-Received: by 2002:a37:72c5:: with SMTP id n188mr72728156qkc.181.1564578147925;
        Wed, 31 Jul 2019 06:02:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a11sm26758434qkn.26.2019.07.31.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jul 2019 06:02:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hsoFN-0006mL-EL; Wed, 31 Jul 2019 10:02:25 -0300
Date:   Wed, 31 Jul 2019 10:02:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     c00284828 <chenglang@huawei.com>, oulijun <oulijun@huawei.com>,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 10/13] RDMA/hns: Remove unnecessary kzalloc
Message-ID: <20190731130225.GE3946@ziepe.ca>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-11-git-send-email-oulijun@huawei.com>
 <20190730134025.GD4878@mtr-leonro.mtl.com>
 <aab804d4-561a-2e3a-969c-55a523c6ee0d@huawei.com>
 <20190731074936.GN4878@mtr-leonro.mtl.com>
 <fab1c105-b367-7ca7-fa2f-b46808ae1b24@huawei.com>
 <20190731095901.GQ4878@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731095901.GQ4878@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 12:59:01PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 05:16:38PM +0800, c00284828 wrote:
> >
> > 在 2019/7/31 15:49, Leon Romanovsky 写道:
> > > On Wed, Jul 31, 2019 at 10:43:01AM +0800, oulijun wrote:
> > > > 在 2019/7/30 21:40, Leon Romanovsky 写道:
> > > > > On Tue, Jul 30, 2019 at 04:56:47PM +0800, Lijun Ou wrote:
> > > > > > From: Lang Cheng <chenglang@huawei.com>
> > > > > >
> > > > > > For hns_roce_v2_query_qp and hns_roce_v2_modify_qp,
> > > > > > we can use stack memory to create qp context data.
> > > > > > Make the code simpler.
> > > > > >
> > > > > > Signed-off-by: Lang Cheng <chenglang@huawei.com>
> > > > > >   drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++-----------------
> > > > > >   1 file changed, 27 insertions(+), 37 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > > > > index 1186e34..07ddfae 100644
> > > > > > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > > > > > @@ -4288,22 +4288,19 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
> > > > > >   {
> > > > > >   	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
> > > > > >   	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
> > > > > > -	struct hns_roce_v2_qp_context *context;
> > > > > > -	struct hns_roce_v2_qp_context *qpc_mask;
> > > > > > +	struct hns_roce_v2_qp_context ctx[2];
> > > > > > +	struct hns_roce_v2_qp_context *context = ctx;
> > > > > > +	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
> > > > > >   	struct device *dev = hr_dev->dev;
> > > > > >   	int ret;
> > > > > >
> > > > > > -	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
> > > > > > -	if (!context)
> > > > > > -		return -ENOMEM;
> > > > > > -
> > > > > > -	qpc_mask = context + 1;
> > > > > >   	/*
> > > > > >   	 * In v2 engine, software pass context and context mask to hardware
> > > > > >   	 * when modifying qp. If software need modify some fields in context,
> > > > > >   	 * we should set all bits of the relevant fields in context mask to
> > > > > >   	 * 0 at the same time, else set them to 0x1.
> > > > > >   	 */
> > > > > > +	memset(context, 0, sizeof(*context));
> > > > > "struct hns_roce_v2_qp_context ctx[2] = {};" will do the trick.
> > > > >
> > > > > Thanks
> > > > >
> > > > > .
> > > > In this case, the mask is actually writen twice. if you do this, will it bring extra overhead when modify qp?
> > > I don't understand first part of your sentence, and "no" to second part.
> > >
> > > Thanks
> >
> > +	struct hns_roce_v2_qp_context ctx[2];
> > +	struct hns_roce_v2_qp_context *context = ctx;
> > +	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
> > ...
> > +	memset(context, 0, sizeof(*context));
> >  	memset(qpc_mask, 0xff, sizeof(*qpc_mask));
> >
> > ctx[2] ={} does look more simple, just like another function in patch.
> > But ctx[1] will be written 0 before being written to 0xff, is it faster than twice memset ?
> 
> Are you seriously talking about this micro optimization while you have mailbox
> allocation in your modify_qp function?

In any event the compiler eliminates duplicate stores in a lot of cases
like this.

Jason
