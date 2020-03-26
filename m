Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4149194601
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCZSFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 14:05:53 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46614 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZSFx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 14:05:53 -0400
Received: by mail-qv1-f66.google.com with SMTP id m2so3499065qvu.13
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zPQVdK6oZX4cEZTC40z1MokVsqKFhAbw9MqIeIMMxJo=;
        b=IfsZRu5JqCqNUEZVefu7PTCCNwWPj1/9XekkayTWLuwEnJh6UJ7NqWMJwqKYIBiYd+
         rnhMHDpoMN0+ITu2vxkOhR+pp+zZsk8eogVgM+Gz2DRRrjOM83hJSD3HjWQicFcfuiHk
         YxqTBuIgZYneznEgXvwbM5kxAuvVC7daV0sSmkUUtIvKyO552gzZdmlsnC6MGBAEqMP5
         Zd9+KhaJcmFooxBIGZj8JGhrdpEhlTSTqKJAw9NOo5lvPrZdef3PjJZxdvjjvojp7U3k
         NAOPxCndo7yUPae4PhopQSyupfxiQEN0753uJqCbv20oWsTXQ9jFwosDOqVj3E4FlAnu
         WRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zPQVdK6oZX4cEZTC40z1MokVsqKFhAbw9MqIeIMMxJo=;
        b=lx6wev0xgigUVyClXT4Q5w1AMEhrfbVLsfpDJv62ur1KBXnVX/unlrWw4o7WMk93yM
         NzZxTkA70CZtCe+8sDNCSqn7a1CFFKPQ0QmCHOQmPF3FI/WqrU9euD1nQy9Rxx5uo6/i
         9xp9RU1MiNyQVdpMxB0wypWbIRp80GXHCrBjBkk+VMZosFydjN+hOiAlnYCH8vU00/Fn
         p87yPv1w58DUips01oROY8p0rFZSTkna3yN2UesSxf9moSiN8YblogX6KerCvjVdpnvP
         rZGWP7Z0UBhpIQIxgFIqYk5a3m3A+mLGRTKQblXedAX9feDqwkfpTRGcHkrlW8qBv+du
         8CgQ==
X-Gm-Message-State: ANhLgQ0XKz8EflXJzNT4v8I/UBV9Y1RhDth3gFLYlxXu0r/bM57yv+7k
        e4tCSyL2vrhJ7O8Jp1cSihycCA==
X-Google-Smtp-Source: ADFU+vuk3yQDzEA7CU+SYaXfsmGVkOf8t0857l6YDBQF90m/z2fDC/wGoTTncKXs8YBIMqVBpm7EhQ==
X-Received: by 2002:a0c:d601:: with SMTP id c1mr9724833qvj.164.1585245952524;
        Thu, 26 Mar 2020 11:05:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c14sm1990726qtv.32.2020.03.26.11.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 11:05:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHWt5-0002k8-2v; Thu, 26 Mar 2020 15:05:51 -0300
Date:   Thu, 26 Mar 2020 15:05:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@mellanox.com>,
        Eli Cohen <eli@dev.mellanox.co.il>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH rdma-next] RDMA/cm: Update num_paths in
 cma_resolve_iboe_route error flow
Message-ID: <20200326180551.GA10496@ziepe.ca>
References: <20200318101741.47211-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318101741.47211-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 12:17:41PM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@mellanox.com>
> 
> After a successful allocation of path_rec, num_paths is set to 1,
> but any error after such allocation will leave num_paths uncleared.
> 
> This causes to de-referencing a NULL pointer later on. Hence,
> num_paths needs to be set back to 0 if such an error occurs.
> 
> The following crash from syzkaller revealed it.
.. 
> 
> Fixes: 3c86aa70bf67 ("RDMA/cm: Add RDMA CM support for IBoE devices")
> Signed-off-by: Avihai Horon <avihaih@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Applied to for-next

Thanks,
Jason
