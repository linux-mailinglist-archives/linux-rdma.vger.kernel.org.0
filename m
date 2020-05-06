Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5771C1C7B25
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 22:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEFUXb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 16:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgEFUXa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 16:23:30 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28767C061A10
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 13:23:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id t8so1507159qvw.5
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PLct8H8ECvP/P4KfFI7cH6fd3M4Zp5H05eJnTKTr5g8=;
        b=J5zEJX4X2mmPLS5YyEgzW6kCR+x+K5MsaR8QE0Vdoa7v/1wavYPFZ16tjvw58Ww7Nf
         wj6XDDEN6tDV4hQK93SOwDYDIDINAmbbPVzDRAo4Z/4EiXW0gv9yw9nwnCdP/OvAbabc
         nIN65vaQWVMZ0vB2Odf+8Jmzh3IxtVQDmpO/DIe0/IbiWe8a0CFAwu/4SAu0gIGkiwGd
         +YZcoblwMlXj+peTk4yquXrbbUd1Y5t8afLHnIp/olo7bpj1QRQuP217UasshWycW68/
         hRWZnwTV98qgXkzlpq2MMrRWZvA85YOHM2bYljCF2PvhTsFwj8C+OShZhqZSkbD5qpt3
         sfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PLct8H8ECvP/P4KfFI7cH6fd3M4Zp5H05eJnTKTr5g8=;
        b=CYgVbPpd6BRrkAabaa+xCKkVFuJ3fHyBXt9ynH9qG/QW3SenLiaVzu23HatOxpc57H
         IBHNChUvGeOaaZxmUnu7WKE+oyjZc/o3NJwFzqwvBCI8Evxp/bse9y9Wmr749Gd10yLT
         0yU/+vZ5bWT0nz83Jxt5VncXqdaA7gmmIYbyhTb+GU5DIQxrbXidUVuKuyCyDz41vWV/
         lsXnSJTpUNLjqZtzA10qTqK0MxCHIJvgp4LNTju5qfWQeYVXidKbUhCfvAS2pih9vJUs
         xNs+sDjWpiN4aYOzdNCxkhAgVb7q79qC8mqEOUjg3ymwj8/L1dUUy4ZhkHmaejRZz0wA
         D8PA==
X-Gm-Message-State: AGi0PuYndC8tU07cwWDuXRZqo4+NRRPr/yrTSH7QVBP2TRKmwvwvzj8p
        oww8NLquidsbXqa4LNFxW/n4Rg==
X-Google-Smtp-Source: APiQypLAv1bx6J8cI0qtP4yk44iiYlqFI/i8y4DdyPjbJ7WO16ikzFspNyhmWY9JoDHp2r3QjLyp+w==
X-Received: by 2002:a0c:c28b:: with SMTP id b11mr9609965qvi.112.1588796609287;
        Wed, 06 May 2020 13:23:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i43sm630792qte.37.2020.05.06.13.23.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 13:23:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWQZj-0000XF-Rt; Wed, 06 May 2020 17:23:27 -0300
Date:   Wed, 6 May 2020 17:23:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next v3 0/5] Set flow_label and RoCEv2 UDP source
 port for datagram QP
Message-ID: <20200506202327.GA1996@ziepe.ca>
References: <20200504051935.269708-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504051935.269708-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 08:19:30AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
>  v3: Rebased on latest rdma-nex, which includes HCA set capability patch
>  and LAG code and this is why new patch from Maor was added.
>  v2: https://lore.kernel.org/linux-rdma/20200413133703.932731-1-leon@kernel.org
>  Dropped patch "RDMA/cm: Set flow label of recv_wc based on primary
>  flow label", because it violates IBTA 13.5.4.3/13.5.4.4 sections.
>  v1: https://lore.kernel.org/lkml/20200322093031.918447-1-leon@kernel.org
>  Added extra patch to reduce amount of kzalloc/kfree calls in
>  the HCA set capability flow.
>  v0: https://lore.kernel.org/linux-rdma/20200318095300.45574-1-leon@kernel.org
> --------------------------------
> 
> >From Mark:
> 
> This series provide flow label and UDP source port definition in RoCE v2.
> Those fields are used to create entropy for network routes (ECMP), load
> balancers and 802.3ad link aggregation switching that are not aware of
> RoCE headers.
> 
> Thanks.
> 
> Maor Gottlieb (1):
>   RDMA/core: Consider flow label when building skb
> 
> Mark Zhang (4):
>   RDMA/core: Add hash functions to calculate RoCEv2 flowlabel and UDP
>     source port
>   RDMA/mlx5: Define RoCEv2 udp source port when set path
>   RDMA/cma: Initialize the flow label of CM's route path record
>   RDMA/mlx5: Set UDP source port based on the grh.flow_label

Applied to for-next

Thanks,
Jason
