Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B913B86D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 17:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391249AbfFJPnB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 11:43:01 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40684 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390454AbfFJPnB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 11:43:01 -0400
Received: by mail-vk1-f195.google.com with SMTP id s16so1754474vke.7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4k4L3/6GEr/roMMy/B5qEXW1uIKHfC5ZPlayonlqWo=;
        b=X3j8pwH/z5WQOZn8o28gYe5pAwt7tBZ9ml/pBNaaJAeA00BnVKQDo5oyo+k4XKsTaK
         esAUjJ0PWZLSH1moquxtMiSfLfx2sjCRd5RYx0uZQSBISy2On+Eg8HQhenJfatK0HDPP
         5lXAp/2mw/HtYan5oBrKBXuY6NSyALWVNtDlH73Tsci8Amlk0ewvAdCa1bBxz3RHaJl2
         eOX8z+/I+GYpljPK/H592k6f4I4xu8XsyZnqMFELS5UCrpWJrN3R8Zk1y+Emg9y2yxkE
         xuv5VcHgSXmFquY9X+VLTfStWGuPe1M9ZbAKoPjVOt8s0W3gHvGNj45zAW07IROqnAkW
         nksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4k4L3/6GEr/roMMy/B5qEXW1uIKHfC5ZPlayonlqWo=;
        b=OtmsYY2MnZW4lVx0CinJmkjTAwkqwJ1oMFZCvHLwb/Xy3Y3riXd/6YwQuTsSYGEZlt
         5AZsgT1np7DyAoantM6uaJaAMY95KAW9fyqf2N+l2lrwNb6l9WvVyI1kM5pUI1lRCJTJ
         /Im3G+lJGLcEnIcGe4Rfqiv3Rak26rEe1BIo6i158GqetyeR0IzMmJJjDY8+awaWAuqu
         vT3zyp1OKMmgX2vj+dwnNAoonnSq7fPq5Vm0NM/K9AkKFp30/4gxJx7XDRNN2mMKavV1
         Q2/WdbbAZ6BZ+d0s68EJfouFGGWrpkJZwpVK8yvso51+wLvbkyH+lvK2rhAc5uZi+6DF
         iA9A==
X-Gm-Message-State: APjAAAW0JggIz/mBcWEdXaX22kgmC8a+O8ss+1Iv+5FCDJS7OwxJkxTV
        /grz8Um3GG2jyPK/JlPMoV/Grh4Q2z0azA==
X-Google-Smtp-Source: APXvYqwNrcNQse6P4AchSHzGIh9WsbIIUw3Ud0dT3YtKouBNZwaFam4CMzZuuju8u6Ow0s/eFgDp7Q==
X-Received: by 2002:a1f:d204:: with SMTP id j4mr6487904vkg.9.1560181380011;
        Mon, 10 Jun 2019 08:43:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o10sm2922283vsd.9.2019.06.10.08.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 08:42:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haMRm-0003Mm-Ky; Mon, 10 Jun 2019 12:42:58 -0300
Date:   Mon, 10 Jun 2019 12:42:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/3] RDMA: Move rdma_node_type to uapi/
Message-ID: <20190610154258.GE18468@ziepe.ca>
References: <20190605183252.6687-1-jgg@ziepe.ca>
 <20190605183252.6687-2-jgg@ziepe.ca>
 <20190610141334.GB6369@mtr-leonro.mtl.com>
 <20190610144535.GD18446@mellanox.com>
 <20190610150544.GG6369@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610150544.GG6369@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 06:05:44PM +0300, Leon Romanovsky wrote:
> On Mon, Jun 10, 2019 at 02:45:40PM +0000, Jason Gunthorpe wrote:
> > On Mon, Jun 10, 2019 at 05:13:34PM +0300, Leon Romanovsky wrote:
> > > On Wed, Jun 05, 2019 at 03:32:50PM -0300, Jason Gunthorpe wrote:
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > >
> > > > This enum is exposed over the sysfs file 'node_type' and over netlink via
> > > > RDMA_NLDEV_ATTR_DEV_NODE_TYPE, so declare it in the uapi headers.
> > > >
> > > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > > >  drivers/infiniband/core/verbs.c  |  2 +-
> > > >  include/rdma/ib_verbs.h          | 13 +------------
> > > >  include/uapi/rdma/rdma_netlink.h | 12 ++++++++++++
> > > >  3 files changed, 14 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > > index e666a1f7608d86..56af18456ba776 100644
> > > > +++ b/drivers/infiniband/core/verbs.c
> > > > @@ -209,7 +209,7 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
> > > >  EXPORT_SYMBOL(ib_rate_to_mbps);
> > > >
> > > >  __attribute_const__ enum rdma_transport_type
> > > > -rdma_node_get_transport(enum rdma_node_type node_type)
> > > > +rdma_node_get_transport(unsigned int node_type)
> > > >  {
> > > >
> > > >  	if (node_type == RDMA_NODE_USNIC)
> > > > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > > > index cdfeeda1db7f31..d5dd3cb7fcf702 100644
> > > > +++ b/include/rdma/ib_verbs.h
> > > > @@ -132,17 +132,6 @@ struct ib_gid_attr {
> > > >  	u8			port_num;
> > > >  };
> > > >
> > > > -enum rdma_node_type {
> > >
> > > Why did you drop "enum rdma_node_type" and changed to be anonymous enum?
> >
> > To avoid namespace pollution in a user header
> 
> IMHO, better to have type safety.

The enum type cannot be safely used in userspace, it is better to have
anonymous enums in uapi headers to avoid mistakes.

The type safety from enums is very minimal.

Jason
