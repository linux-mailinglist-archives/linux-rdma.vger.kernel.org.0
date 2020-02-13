Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A795B15C2DE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgBMPhr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 10:37:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43817 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgBMPhq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 10:37:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so6049869qkh.10
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 07:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ifKC7fSoU+fi6otQVLrkXu6Jr4u9UZJbccDmjG6O/Uo=;
        b=IM5HiIeGr7bEkBTgtPy0FRoUL74ace8PxLHG0TclGGdNw5/qifvCyjthOlSA6mVLwO
         gibM9/kFGhldPtf+Jn2zvCXSxTdF/VBo0aHdr4AS/lXtwWHSVRE7x9h0pRGb+JtXL0bg
         Gk2+Ng2T7bDheXnwolj6JSermKvNLKJ5p/3BO5jduJEBaR3y3CL9KWNbJq8TLSxFROLx
         DU3XxNbbYaYHXkg8fOBJbULGs0b+7MsGVVrgGI1wdbQsF/8XQgaW74d54U/QMoezmZ5R
         YbCg0WWHGeCAOq90/mppcKOxNW/jcMz1Y+s59XCHOlSe3rYxJ9nfNsBxNYuAAuOiHmoy
         Fb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ifKC7fSoU+fi6otQVLrkXu6Jr4u9UZJbccDmjG6O/Uo=;
        b=RQ2srT7vnlGW1rnFG1NL865phkbqLmq+SkExIBAnL+Uk0Qr838/f6u7zjjBUiDC5zE
         V2Cx+2p3jtlCuN+D+o7DAHTPgVzEePuGfWMb/qL3mF8L76DcJavHdrAlL4mSXo+tjois
         CKwGLYfMgJZDQYkSg2+E5BHI9x0+FP6Pd6/IcUyZlxiX6qCxJS4Ok686O0E8LQa6wfU6
         3zdcu1nSseg1uc3jIMOol2Nv0krXjNUIUvL0V2rXCzOCayfI/Qd4RTrSbxmutFgACiYI
         0nkrnXRYVC4YXOR7HmPFhzGfloxgn9ql+kYolyaoDn9fsdyBZN1z6ncDLNz/N6IQzZU2
         z2Aw==
X-Gm-Message-State: APjAAAW54NHK1bvKJhkTLvwj4zsLLiA68CG6pBMZE/KL0rzxSVq9ZlBp
        +K4i9Yb8gtmqsF03X3A3sIXm4A==
X-Google-Smtp-Source: APXvYqxUxG0o2NWPxHMKA2WbnhZF5DmFoHYouHXzYXdZ+wlgNEo3u3PJ5k3F7AG/dUZcCXE68Le7sg==
X-Received: by 2002:a37:664f:: with SMTP id a76mr13044734qkc.470.1581608264129;
        Thu, 13 Feb 2020 07:37:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 64sm1492127qkh.98.2020.02.13.07.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:37:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2GYh-0005ST-6q; Thu, 13 Feb 2020 11:37:43 -0400
Date:   Thu, 13 Feb 2020 11:37:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
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
Message-ID: <20200213153743.GA19802@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-5-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212072635.682689-5-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 09:26:30AM +0200, Leon Romanovsky wrote:

> diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
> index 2aa3457a30ce..c614cb87d09b 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib.h
> +++ b/drivers/infiniband/ulp/ipoib/ipoib.h
> @@ -379,6 +379,7 @@ struct ipoib_dev_priv {
>  	struct ipoib_tx_buf *tx_ring;
>  	unsigned int	     tx_head;
>  	unsigned int	     tx_tail;
> +	atomic_t             tx_outstanding;
>  	struct ib_sge	     tx_sge[MAX_SKB_FRAGS + 1];
>  	struct ib_ud_wr      tx_wr;
>  	struct ib_wc	     send_wc[MAX_SEND_CQE];
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> index c59e00a0881f..db6aace83fe5 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> @@ -756,7 +756,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
>  		return;
>  	}
>  
> -	if ((priv->tx_head - priv->tx_tail) == ipoib_sendq_size - 1) {
> +	if (atomic_read(&priv->tx_outstanding) == ipoib_sendq_size - 1) {
>  		ipoib_dbg(priv, "TX ring 0x%x full, stopping kernel net queue\n",
>  			  tx->qp->qp_num);
>  		netif_stop_queue(dev);
> @@ -786,7 +786,7 @@ void ipoib_cm_send(struct net_device *dev, struct sk_buff *skb, struct ipoib_cm_
>  	} else {
>  		netif_trans_update(dev);
>  		++tx->tx_head;
> -		++priv->tx_head;
> +		atomic_inc(&priv->tx_outstanding);
>  	}

This use of an atomic is very weird, probably wrong.

Why is it an atomic?  priv->tx_head wasn't an atomic, and every place
touching tx_outstanding was also touching tx_head.

I assume there is some hidden locking here? Or much more stuff is
busted up.

In that case, drop the atomic.

However, if the atomic is needed (where/why?) then something has to
be dealing with the races, and if the write side is fully locked then
an atomic is the wrong choice, use READ_ONCE/WRITE_ONCE instead

Jason
