Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFCC15D905
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 15:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgBNOIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 09:08:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43205 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgBNOIH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 09:08:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so9269144qkh.10
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2020 06:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cE4+cJtLg8SO8s7fUOAgQZjhtpee9zXtt7bTEOZHgvE=;
        b=CHZEP5TgEdpZ2FvLRqqKS/I9SBT9fOixTqwkaghRwfVB//pRvgIaRKvppmBATNxlNa
         N4GaTrsfJOp2G0clr5GUbhKIdb1UAiMAyuQ76Ua0FRxbNaoGwesAsX7BOGs3gD7iGz5x
         pvVsqvypaiBRum2sBPUEollPRpqhvsTsLq5OEp1jrfN4gy+e2ZTMBPBcKqQchynyBA9g
         0WPAn6OzJ/wkr5k0jn77e408aW9nhUoE0Tmiqnj0JczIT2GtTqy5yyXiYQBBCWkfEilQ
         ANKBN7w/idbHwQJSvza9bTVX94oQG72fVquiBSgsN6WgnNe/eAK3E4h9+ryZhhLIQGre
         W5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cE4+cJtLg8SO8s7fUOAgQZjhtpee9zXtt7bTEOZHgvE=;
        b=E+U2/8F6vynd7V53aecXC7mcjLkTVrN9l3wpmyXkrmTRDdcvoJ2jA/mqxwgidA0LCP
         U9rrWGJ8k47dQS08BFrzi8jvdilPOtz2bFbW5AF3rothvULgV+ccyvZTM6ZlPfccUPvk
         gHgC2AuxRWk6jnqxmsGxtFx7Btcvc9dPAi9BZ2YSzvhrPTjBbLTCVtIK9x5Ffx6YPR6p
         +JT+pVlEq06r6FANMj/DkgcVhBRJR5g0O7IC7oRdrmSbRXHi1U2Heb1Mo5Z8hwtswi9K
         ZNvEG7pZ9EBb5k2iu8Yh+I1WzrcFuQm/AfzncH8W+NgnPLAaEZpatc6cvvQjBe7ZIPdz
         8sGQ==
X-Gm-Message-State: APjAAAXoEjNZYDaTx/dTo+sDGbcEJX2jPxf3+icojfyPexZdVe1tiq9V
        /WSy6Stb2v0MTOALY3iiEt70Yw==
X-Google-Smtp-Source: APXvYqyvteGkK4eMVJCXZmML4RK0PmOyZodaTL5BdBSMgiUuWkbZsxoNgxyM+XIuo7Quw9ZNJ75DCQ==
X-Received: by 2002:ae9:e207:: with SMTP id c7mr2599678qkc.128.1581689286713;
        Fri, 14 Feb 2020 06:08:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k7sm3301338qtd.79.2020.02.14.06.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 06:08:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2bdV-0003Ui-CP; Fri, 14 Feb 2020 10:08:05 -0400
Date:   Fri, 14 Feb 2020 10:08:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Yonatan Cohen (SW)" <yonatanc@mellanox.com>,
        Yanjun Zhu <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 3/9] Revert "RDMA/cma: Simplify
 rdma_resolve_addr() error flow"
Message-ID: <20200214140805.GS31668@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-4-leon@kernel.org>
 <20200213133054.GA10333@ziepe.ca>
 <c0e73246-a421-5619-a7e6-f955612fd1b9@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0e73246-a421-5619-a7e6-f955612fd1b9@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 14, 2020 at 03:11:48AM +0000, Parav Pandit wrote:
> On 2/13/2020 7:30 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 12, 2020 at 09:26:29AM +0200, Leon Romanovsky wrote:
> >> From: Parav Pandit <parav@mellanox.com>
> >>
> >> This reverts commit 219d2e9dfda9431b808c28d5efc74b404b95b638.
> >>
> >> Below flow requires cm_id_priv's destination address to be setup
> >> before performing rdma_bind_addr().
> >> Without which, source port allocation for existing bind list fails
> >> when port range is small, resulting into rdma_resolve_addr()
> >> failure.
> > 
> > I don't quite understands this - what is "when port range is small" ?
> >  
> There is sysfs knob to reduce source port range to use for binding.
> So it is easy to create the issue by reducing port range to handful of them.
> 
> >> rdma_resolve_addr()
> >>   cma_bind_addr()
> >>     rdma_bind_addr()
> >>       cma_get_port()
> >>         cma_alloc_any_port()
> >>           cma_port_is_unique() <- compared with zero daddr
> > 
> > Do you understand why cma_port_is_unique is even testing the dst_addr?
> > It seems very strange.
> 
> ma_port_unique() reuses the source port as long as
> destination is different (destination = either different
> dest.addr or different dest.port between two cm_ids ).
> 
> This behavior is synonymous to TCP also.
> 
> > Outbound connections should not alias the source port in the first
> > place??
> >
> I believe it can because TCP seems to allow that too as long destination
> is different.
> 
> I think it allows if it results into different 4-tuple.

So the issue here is if the dest is left as 0 then the
cma_alloc_any_port() isn't able to alias source ports any more?

Jason
