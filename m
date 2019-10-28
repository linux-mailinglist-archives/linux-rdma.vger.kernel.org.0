Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1EE7353
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfJ1OGc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 10:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbfJ1OGc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 10:06:32 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC24B20659;
        Mon, 28 Oct 2019 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572271591;
        bh=09//CB9mKg5QcFDL/DWtlAVWqNhKE56X8VGRD4tFgLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpzaL1ZpjpuiOajot4F9bizcl8IcBhO5LqwNKpq3AGthZenfRt5aPOjlXuI7NewAN
         QsB0DRisEN34s2UVxyNp9ZfAz6nMsrq4tmojC4Ke3xtud/+Nh028XFvIO+R/lDjRxa
         8ivIW2I03qpCGb55vONTSCWBPLiwkfaB8yZ3itZM=
Date:   Mon, 28 Oct 2019 16:06:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 6/6] RDMA/srpt: Use private_data_len instead of
 hardcoded value
Message-ID: <20191028140628.GI5146@unreal>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-7-leon@kernel.org>
 <20191028131319.GA15102@ziepe.ca>
 <20191028131917.GE5146@unreal>
 <20191028134351.GB29652@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028134351.GB29652@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 10:43:51AM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 28, 2019 at 03:19:17PM +0200, Leon Romanovsky wrote:
> > On Mon, Oct 28, 2019 at 10:13:19AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Oct 20, 2019 at 10:15:59AM +0300, Leon Romanovsky wrote:
> > > > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > > index daf811abf40a..e66366de11e9 100644
> > > > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > > @@ -2609,7 +2609,7 @@ static int srpt_cm_handler(struct ib_cm_id *cm_id,
> > > >  	case IB_CM_REJ_RECEIVED:
> > > >  		srpt_cm_rej_recv(ch, event->param.rej_rcvd.reason,
> > > >  				 event->private_data,
> > > > -				 IB_CM_REJ_PRIVATE_DATA_SIZE);
> > > > +				 event->private_data_len);
> > >
> > > So, I took a look and found a heck of a lot more places assuming the
> > > size of private data that really should be checked if we are going to
> > > introduce a buffer length here.
> >
> > But we are not interested to make it dynamic, "private_data_len" has
> > constant size according to IBTA spec, I just don't want users to be
> > aware of this.
> >
> > Why should we add the below checks if it wasn't before?
>
> Why are we doing any of this then?

The final goal will be to present all CM messages as binary blobs with
access through specific GET/SET helpers, those including access to
private data. It is needed to completely eliminate be32 madness in
IB/core code.

Thanks

>
> Jason
