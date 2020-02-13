Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD415CAEA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 20:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBMTJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 14:09:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34315 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMTJb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 14:09:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so6794163qkm.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 11:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6eedeRBn+q853jsF1S8QD7Jq/mY2BXPruYy+5rOXnTI=;
        b=SacM8oIbWqe79Wqeo8K92Javotzd18waRtbfxm8M/sYZQwhhyLvfdPRBMcFHkruWM8
         ByIIs1WV2wP1Nl9ZTADPyDQtMsOrAbpFtQn1iPoVFyRdS5Mptc9/QfrQTmokAVBTdI+M
         sCb/bvTGXpqz6PcgdwRl77X21WtLpCMN8pPlBHPGq8pYypa8TRkctyZ27n2zD5LKw7W1
         lGdW08yya0iDYmH5mz8xHc3+EaWQ/wznHmWyXxf9fR6E/vEj5XEyOeEQOW2XMXqgo89o
         CVUh1Bpxu4pUWzTbHjrrO09oCOrnG5Vbjsplkb0hyHeSDCYRsErMsQMEid7b7ITjDGnn
         s0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eedeRBn+q853jsF1S8QD7Jq/mY2BXPruYy+5rOXnTI=;
        b=mxuW+oWkxDX3fukC1MgSlzOWljlkh8fJoCzajxmuIBTN2NxcAk/ploD54q+Zu7pQAc
         6Kgcxt76yEC9ANxRWqSkW9PtJGvGxohe3nwkqClArHSMOrPkV59n6/N5sLRy6CoVFQaa
         HVSwBVM1s10oSnoW9ajeTHYcbFeKm8awMQReRzo/2cjUnvUBMlm+SEF4q350x9OtSwPn
         N+sQB0fIGYeXJBsxAiYc2LhvCvw64Z70fpR8L6q5eBVmSBmuVLo/1L9YqmxnVTRTmFpA
         aj9d8p92dchJ/zpG7xOkuxLUEbuWrg2U/0TAir38PTXEK02UnBpaaDrNNIrlmIuFEjpQ
         RGTg==
X-Gm-Message-State: APjAAAX6XvSKQgp9GkBfOtTLUhNX0avcGhGelGF33+ElHMeAefQmhCPV
        jWERqWiHp+a4dSVlUbzutTUubQ==
X-Google-Smtp-Source: APXvYqxKTm7qe05mk7a+8aXFAHTGNrlzqjIdzlEOVuZmGYJWQ/x7AAxDTl3290+C852cYaDHVlKqaA==
X-Received: by 2002:a05:620a:1497:: with SMTP id w23mr13086473qkj.472.1581620970113;
        Thu, 13 Feb 2020 11:09:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d69sm1795336qkg.63.2020.02.13.11.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 11:09:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2Jrd-0002XX-3H; Thu, 13 Feb 2020 15:09:29 -0400
Date:   Thu, 13 Feb 2020 15:09:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20200213190929.GN31668@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-5-leon@kernel.org>
 <20200213153743.GA19802@ziepe.ca>
 <20200213181012.GG679970@unreal>
 <20200213182655.GK31668@ziepe.ca>
 <20200213183622.GH679970@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213183622.GH679970@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 08:36:22PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 13, 2020 at 02:26:55PM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2020 at 08:10:12PM +0200, Leon Romanovsky wrote:
> > > On Thu, Feb 13, 2020 at 11:37:43AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Feb 12, 2020 at 09:26:30AM +0200, Leon Romanovsky wrote:
> > > >
> > > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
> > > > > index 2aa3457a30ce..c614cb87d09b 100644
> > > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib.h
> > > > > @@ -379,6 +379,7 @@ struct ipoib_dev_priv {
> > > > >  	struct ipoib_tx_buf *tx_ring;
> > > > >  	unsigned int	     tx_head;
> > > > >  	unsigned int	     tx_tail;
> > > > > +	atomic_t             tx_outstanding;
> > > > >  	struct ib_sge	     tx_sge[MAX_SKB_FRAGS + 1];
> > > > >  	struct ib_ud_wr      tx_wr;
> > > > >  	struct ib_wc	     send_wc[MAX_SEND_CQE];
> > > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > > > index c59e00a0881f..db6aace83fe5 100644
> > > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > > > @@ -756,7 +756,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
> > > > >  		return;
> > > > >  	}
> > > > >
> > > > > -	if ((priv->tx_head - priv->tx_tail) == ipoib_sendq_size - 1) {
> > > > > +	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
> > > > >  		ipoib_dbg(priv, "TX ring 0x%x full, stopping kernel net queue\n",
> > > > >  			  tx->qp->qp_num);
> > > > >  		netif_stop_queue(dev);
> > > > > @@ -786,7 +786,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
> > > > >  	} else {
> > > > >  		netif_trans_update(dev);
> > > > >  		++tx->tx_head;
> > > > > -		++priv->tx_head;
> > > > > +		atomic_inc(&priv->tx_outstanding);
> > > > >  	}
> > > >
> > > > This use of an atomic is very weird, probably wrong.
> > > >
> > > > Why is it an atomic?  priv->tx_head wasn't an atomic, and every place
> > > > touching tx_outstanding was also touching tx_head.
> > > >
> > > > I assume there is some hidden locking here? Or much more stuff is
> > > > busted up.
> > > >
> > > > In that case, drop the atomic.
> > > >
> > > > However, if the atomic is needed (where/why?) then something has to
> > > > be dealing with the races, and if the write side is fully locked then
> > > > an atomic is the wrong choice, use READ_ONCE/WRITE_ONCE instead
> > >
> > > I thought that atomic_t is appropriate here. Valentin wanted to
> > > implement "window" and he needed to ensure that this window is counted
> > > correctly while it doesn't need to be 100% accurate.
> >
> > It does need to be 100% accurate because the stop_queue condition is:
> >
> >  +	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
> 
> So better to write ">=" instead of "=".

Then you risk overflowing the send q.

The required scheme appears to be to globally bound the # of packets
outstanding to tx such that the global bound is lower than any of the
(many) QP's sendq, thus there will always be a place to put the
packets.

So it must be exact or at least pessimistic.

This isn't a multiq netdev, so AFAICT, the tx side is single threaded
by netdev, and it looks like the wc side was single threaded by NAPI
as well.

The old code used two variable, each written in a single threaded way,
and then read to generate the state. With the missing READ_ONCE added,
it should look like this:

    if ((priv->tx_head - READ_ONCE(priv->tx_tail)) == ipoib_sendq_size - 1) {

I feel like sticking with the single writer packets posted/completed
scheme is better and clearer than trying to collapse it into a single
atomic.

> > And presumably the whole problem here is overflowing some sized q
> > opbject.
> >
> > That atomic is only needed if there is concurrency, and where is the
> > concurrency?
> 
> Depends on if you believe to description in commit message :)

I do.. It is obviously wrong now that you point to it :) Each QP must
have exclusive control of its head/tail pointers, having a CM QP reach
into the head/tail of the UD QP is certainly wrong.

Jason
