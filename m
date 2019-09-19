Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E23CB71E7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 05:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfISD3Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 23:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbfISD3P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Sep 2019 23:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBE6718CB8EC;
        Thu, 19 Sep 2019 03:29:15 +0000 (UTC)
Received: from localhost (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 285D35D6A5;
        Thu, 19 Sep 2019 03:29:14 +0000 (UTC)
Date:   Thu, 19 Sep 2019 11:29:12 +0800
From:   Honggang LI <honli@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [patch v2 1/2] IB/srp: Add parse function for maximum initiator
 to target IU size
Message-ID: <20190919032912.GA6303@dhcp-128-227.nay.redhat.com>
References: <20190917032421.13000-1-honli@redhat.com>
 <b9a8596d-1d6e-5a90-cc8f-1b52dc33b7c5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a8596d-1d6e-5a90-cc8f-1b52dc33b7c5@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Thu, 19 Sep 2019 03:29:15 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 17, 2019 at 10:44:56AM -0700, Bart Van Assche wrote:
> On 9/16/19 8:24 PM, Honggang LI wrote:
> > In case the SRPT modules, which include the in-tree 'ib_srpt.ko'
> > module, do not support SRP-2 'immediate data' feature, the default
> > maximum initiator to target IU size is significantly samller than
>                                                        ^^^^^^^
>                                                        smaller?

Yes, will fix this typo.

> > 8260. For 'ib_srpt.ko' module, which built from source before
> > [2], the default maximum initiator to target IU is 2116.
> [ ... ]
> > diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> > index b5960351bec0..2eadb038b257 100644
> > --- a/drivers/infiniband/ulp/srp/ib_srp.c
> > +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> > @@ -75,6 +75,7 @@ static bool prefer_fr = true;
> >   static bool register_always = true;
> >   static bool never_register;
> >   static int topspin_workarounds = 1;
> > +static uint32_t srp_opt_max_it_iu_size;
> 
> Each SCSI host can represent a connection to another SRP target, and the
> max_it_iu_size parameter can differ per target. So I think this variable
> should be moved into struct srp_target_port instead of being global. See
> also srp_max_it_iu_len().

Yes, will do as you said.

thanks
