Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C89F102
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 19:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfH0RAR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 13:00:17 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35666 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfH0RAQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 13:00:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so17626027qke.2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kYPGDUj5sH4SCUP1lHKgm5YKw8keIudyH7NDu4pQAdc=;
        b=ks/YCDjWuxdseUyu1rZdsbddlOLt7LPQU/UhYXinHw2NsTKTqTrznA5c43DZXOhn8m
         U6uy0u8yB4o2IpW40kY1tF8l79FmqdQBOaNk96dWLzJnFG8TXUJtNuS0kEDG1osBYo1X
         MOuuVabxN9xgm0kQJiz8iDIeV5azCoSxH92t0MuIbgOdXX9X0afYi8FiMoO4s/U/KnLi
         OeMA6cq8lSygxDW/4B66zV5KtWlv3AVS0plx9XbaK6UOjXrt3MGrlB9/XP3+Fdlsa4Un
         jg1pEmMhwiZPGwxVRE/hZUOAan9ZMzYwuwb+svPDOVPbfjlcmuKEvjkg+Mt+9ZUhwx89
         EBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kYPGDUj5sH4SCUP1lHKgm5YKw8keIudyH7NDu4pQAdc=;
        b=Dj0W+Mb0ct4F9qDxNmFuG+aO+Pc4iVYhiGcnosIbiwmOWauDCXklkT6snQHp3MKuRK
         7vb4T5Lfbj8RfnwZ+zO7FZzowCMMQJBuL09YSCGpvdFqwy8ShyD7CoAzBJy8zcK4wvO8
         PG9PQ1rFt0YKNfRax6Cst3/pzLIfBcUC5HWxsYCudXklcBxRbzKj1d7jjWydSdul8VZR
         LxX8ZO+dq7+tC2jSbD9nPRn0M4PwJG3RBqMmy14+9nYoZCzANuA4YklNfjF6YxR36ABU
         9jDti4pohqr0E4yyihFAypeGvQR8xgE8nJimuIMhbyiMdW2RrBJJd64N1t+qWfcHnMhF
         AkTA==
X-Gm-Message-State: APjAAAXmfwM5dlCVB2y4yo0xgIf1i7IIhJJfioewlEn0Hu8Em/C+9St5
        Tc/s9IRwd2duLrNd95RqYbuYnA==
X-Google-Smtp-Source: APXvYqx8camKj4IS5lBSNcLQf3zjZzTN2+rHGB68UuSJooPY4VqMUAPKuBYrCPxKbxqFAaBdVGetVQ==
X-Received: by 2002:a05:620a:16a9:: with SMTP id s9mr20832064qkj.48.1566925216014;
        Tue, 27 Aug 2019 10:00:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id f20sm10760842qtf.68.2019.08.27.10.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 10:00:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2epK-0005Z7-Qb; Tue, 27 Aug 2019 14:00:14 -0300
Date:   Tue, 27 Aug 2019 14:00:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, dledford@redhat.com
Subject: Re: [PATCH v2] RDMA/siw: Fix IPv6 addr_list locking
Message-ID: <20190827170014.GE7149@ziepe.ca>
References: <20190827164955.9249-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827164955.9249-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 06:49:55PM +0200, Bernard Metzler wrote:
> Walking the address list of an inet6_dev requires
> appropriate locking. Since the called function
> siw_listen_address() may sleep, we have to use
> rtnl_lock() instead of read_lock_bh().
> 
> Also introduces:
> - sanity checks if we got a device from
>   in_dev_get() or in6_dev_get().
> - skipping IPv6 addresses flagged IFA_F_TENTATIVE
>   or IFA_F_DEPRECATED
> 
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>  drivers/infiniband/sw/siw/siw_cm.c | 33 +++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
> index 1db5ad3d9580..c145b4ff4556 100644
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1962,6 +1962,10 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>  		struct sockaddr_in s_laddr, *s_raddr;
>  		const struct in_ifaddr *ifa;
>  
> +		if (!in_dev) {
> +			rv = -ENODEV;
> +			goto out;
> +		}
>  		memcpy(&s_laddr, &id->local_addr, sizeof(s_laddr));
>  		s_raddr = (struct sockaddr_in *)&id->remote_addr;
>  
> @@ -1991,22 +1995,27 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
>  		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr),
>  			*s_raddr = &to_sockaddr_in6(id->remote_addr);
>  
> +		if (!in6_dev) {
> +			rv = -ENODEV;
> +			goto out;
> +		}
>  		siw_dbg(id->device,
>  			"laddr %pI6:%d, raddr %pI6:%d\n",
>  			&s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
>  			&s_raddr->sin6_addr, ntohs(s_raddr->sin6_port));
>  
> -		read_lock_bh(&in6_dev->lock);
> -		list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
> -			struct sockaddr_in6 bind_addr;
> -
> +		rtnl_lock();
> +		list_for_each_entry_rcu(ifp, &in6_dev->addr_list, if_list) {

If not holding RCU then don't use the rcu list iterator..

Jason
