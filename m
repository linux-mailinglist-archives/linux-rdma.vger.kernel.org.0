Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6F15C9FE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBMSKQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbgBMSKQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 13:10:16 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F6320659;
        Thu, 13 Feb 2020 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581617415;
        bh=er/ZtHxjh6K6tbrAykjbBfVWbrOvuckfXY/raMCNqXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heE1WLdKHKXrmmiXtLwHeFJJIuSXrQvU+kVMrNb59I4WWDcFGr+45mfBg29xa+zQH
         BixnjEY5yFbcay2B4m6ykYaVf7wq3Vf41Z+bPCjZ+EBqfV4SnjWCIcgm3MdLdcyyiB
         AcH/FXnQ1RWziDSMJJ66/9xACR+QOyxCJd73eB4w=
Date:   Thu, 13 Feb 2020 20:10:12 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 4/9] IB/ipoib: Fix double free of skb in case of
 multicast traffic in CM mode
Message-ID: <20200213181012.GG679970@unreal>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-5-leon@kernel.org>
 <20200213153743.GA19802@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213153743.GA19802@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 11:37:43AM -0400, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2020 at 09:26:30AM +0200, Leon Romanovsky wrote:
>
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
> > index 2aa3457a30ce..c614cb87d09b 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib.h
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib.h
> > @@ -379,6 +379,7 @@ struct ipoib_dev_priv {
> >  	struct ipoib_tx_buf *tx_ring;
> >  	unsigned int	     tx_head;
> >  	unsigned int	     tx_tail;
> > +	atomic_t             tx_outstanding;
> >  	struct ib_sge	     tx_sge[MAX_SKB_FRAGS + 1];
> >  	struct ib_ud_wr      tx_wr;
> >  	struct ib_wc	     send_wc[MAX_SEND_CQE];
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > index c59e00a0881f..db6aace83fe5 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > @@ -756,7 +756,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
> >  		return;
> >  	}
> >
> > -	if ((priv->tx_head - priv->tx_tail) == ipoib_sendq_size - 1) {
> > +	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
> >  		ipoib_dbg(priv, "TX ring 0x%x full, stopping kernel net queue\n",
> >  			  tx->qp->qp_num);
> >  		netif_stop_queue(dev);
> > @@ -786,7 +786,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
> >  	} else {
> >  		netif_trans_update(dev);
> >  		++tx->tx_head;
> > -		++priv->tx_head;
> > +		atomic_inc(&priv->tx_outstanding);
> >  	}
>
> This use of an atomic is very weird, probably wrong.
>
> Why is it an atomic?  priv->tx_head wasn't an atomic, and every place
> touching tx_outstanding was also touching tx_head.
>
> I assume there is some hidden locking here? Or much more stuff is
> busted up.
>
> In that case, drop the atomic.
>
> However, if the atomic is needed (where/why?) then something has to
> be dealing with the races, and if the write side is fully locked then
> an atomic is the wrong choice, use READ_ONCE/WRITE_ONCE instead

I thought that atomic_t is appropriate here. Valentin wanted to
implement "window" and he needed to ensure that this window is counted
correctly while it doesn't need to be 100% accurate.

Thanks

>
> Jason
