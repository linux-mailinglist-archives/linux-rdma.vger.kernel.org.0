Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6D15CA4F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBMS05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 13:26:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32869 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMS05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 13:26:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id h4so6675251qkm.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HaepWwzBSrtdGvqUT2P5Ig/4AtbX+pXcRII+VsNJ3hg=;
        b=Z8ndanwQ4lb2U1pc+R9EZs9baLOioAh4KrODwtefPtXDcRx84eyKCyHlE6I+UAkrWw
         kju1QZmea9wuVDonKdCPopPNjyrU1/ByZ3BKov0KXB77Ulcoq9X0h9CIrIFAKWF3AlQi
         09ToEYkzZH/WxjUC5VunmkCArNWHHybgX5lO1uj6s+5NKSNgAq9u2nqFMB3zuCgKuF4n
         moS3aovq+F16Hfvh53Np3xD9nPeB/2/sTjX9XJ0IkokayxgMiTt6kXfc4E872Y1bF+JE
         vDBe3c4bAEN2/WPlI1tseJbxydCPkC7sCOmiAZeDFqjNgrgqcW+r3l7Js3AkYlzKl/1J
         39/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HaepWwzBSrtdGvqUT2P5Ig/4AtbX+pXcRII+VsNJ3hg=;
        b=c4vjjGo36dvlyeRcfJTnQwTtBlDpkMFkXi4uHqxocalWlDcVO3dueNzsHARCg8m4jy
         AE41UV7rYKSjrHaNgU+X9LErjZDM+J1g0pfKT9RssvY72q9R59hKIv87+9MPji5VVxLr
         nvEaZw+MDiRkMonE/QZkQqt6AxuS7m5oOuAdXZYgB0pM5k6reOM9EgXmS2pWKMFLUpKv
         cnI05HrGdl4Z/knMrhPw0TLq6LIAQChKos7iXTjTRf4f9EfAjSX5NsD8t5zQO1U4WVIy
         1UaXE6ic3tvXjVTYrtnbA+fQ6QbW9xKPAdW5YwYZpwgQHP811LJTtgS31CWH4C8phN4S
         VWVQ==
X-Gm-Message-State: APjAAAX96wSGlpd7a222yogCBw/wnlbDDwHUIvC4ESoasCn1p1Evb3Uh
        JJg/8LzeUMKOSeJ9ZboSB4MeuQ==
X-Google-Smtp-Source: APXvYqwenO2yclhms9O3yKVkEEV2CX253xrp8OTxM9D0Q6wyWrty+amLcc0RrmxXAMjaJuM95g3n7w==
X-Received: by 2002:a37:9c0d:: with SMTP id f13mr8603171qke.463.1581618416107;
        Thu, 13 Feb 2020 10:26:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p8sm1805821qtn.71.2020.02.13.10.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 10:26:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2JCR-0008Vg-2d; Thu, 13 Feb 2020 14:26:55 -0400
Date:   Thu, 13 Feb 2020 14:26:55 -0400
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
Message-ID: <20200213182655.GK31668@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-5-leon@kernel.org>
 <20200213153743.GA19802@ziepe.ca>
 <20200213181012.GG679970@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213181012.GG679970@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 13, 2020 at 08:10:12PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 13, 2020 at 11:37:43AM -0400, Jason Gunthorpe wrote:
> > On Wed, Feb 12, 2020 at 09:26:30AM +0200, Leon Romanovsky wrote:
> >
> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
> > > index 2aa3457a30ce..c614cb87d09b 100644
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib.h
> > > @@ -379,6 +379,7 @@ struct ipoib_dev_priv {
> > >  	struct ipoib_tx_buf *tx_ring;
> > >  	unsigned int	     tx_head;
> > >  	unsigned int	     tx_tail;
> > > +	atomic_t             tx_outstanding;
> > >  	struct ib_sge	     tx_sge[MAX_SKB_FRAGS + 1];
> > >  	struct ib_ud_wr      tx_wr;
> > >  	struct ib_wc	     send_wc[MAX_SEND_CQE];
> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > index c59e00a0881f..db6aace83fe5 100644
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > @@ -756,7 +756,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
> > >  		return;
> > >  	}
> > >
> > > -	if ((priv->tx_head - priv->tx_tail) == ipoib_sendq_size - 1) {
> > > +	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
> > >  		ipoib_dbg(priv, "TX ring 0x%x full, stopping kernel net queue\n",
> > >  			  tx->qp->qp_num);
> > >  		netif_stop_queue(dev);
> > > @@ -786,7 +786,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
> > >  	} else {
> > >  		netif_trans_update(dev);
> > >  		++tx->tx_head;
> > > -		++priv->tx_head;
> > > +		atomic_inc(&priv->tx_outstanding);
> > >  	}
> >
> > This use of an atomic is very weird, probably wrong.
> >
> > Why is it an atomic?  priv->tx_head wasn't an atomic, and every place
> > touching tx_outstanding was also touching tx_head.
> >
> > I assume there is some hidden locking here? Or much more stuff is
> > busted up.
> >
> > In that case, drop the atomic.
> >
> > However, if the atomic is needed (where/why?) then something has to
> > be dealing with the races, and if the write side is fully locked then
> > an atomic is the wrong choice, use READ_ONCE/WRITE_ONCE instead
> 
> I thought that atomic_t is appropriate here. Valentin wanted to
> implement "window" and he needed to ensure that this window is counted
> correctly while it doesn't need to be 100% accurate.

It does need to be 100% accurate because the stop_queue condition is:

 +	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {

And presumably the whole problem here is overflowing some sized q
opbject.

That atomic is only needed if there is concurrency, and where is the
concurrency?

Jason
