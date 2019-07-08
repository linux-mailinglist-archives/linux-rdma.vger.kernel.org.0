Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF56275C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfGHRjP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 13:39:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46238 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGHRjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 13:39:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so16669105qtn.13
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6FdEO85zToCfNinS1VQ24nTJwTSvaH+iiq01eEx8eqw=;
        b=J2SOwIJfnHGkivdjn99tuAlbDgLzFDZAwuX3BVkM1TMlKGfShNMn3/qmsBJ8iJnCzy
         L8ir1qPBy8LK1JY+TMwH3kkaiU+1fkSt9U9qYDaV1tQoHWbZcaoRdybeTIGPZvEpaR1V
         jxo7dQysNoEbtAC/r6k6J0getDNgS17g00yQw6d/0aiTEPvhFLM3Wp65N9UEfBAPG+LN
         ocbh0eJlLIQIX1Yn1QcUMxuXSkyHLhrd7+i0bVCPPC8HFwVaPQ8YzE9xz4qoNaV0dUQS
         naRsTx6nqKmD+0+XsDXtV8hZeyHzUS5y0kBqx87VHrVMakc0pKFRfNAIO82S9ZYsMuD9
         hiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6FdEO85zToCfNinS1VQ24nTJwTSvaH+iiq01eEx8eqw=;
        b=XRDirgZ4I9iBabgUh9p7ZanYzCPW4TAuPVRx0dJt5IOYtS/ZeNm4aLiaIGMKN0Zjrs
         6P8LIU9aolZUr+C+qF3YZYGCyMfwrPcfJPsSrZuoAPd676S6hWhHjAifK9JLq/rJ+W6L
         JuXecUe5Pu8QSCOYrTHXoVKmJctdKji8knxT9hpLI8AQ/8ipVH14wtllq9aMpghgp/je
         +M49ssGzT4wHYFTopwQO+vmk0SEgf7TrdwaLh0O34LLP8avQe1PKes6ZNv1fCWr8/0Mz
         Ic+xokuzXVQOMC3QFaufE/OWragY5fIIAgBQUwMrzV0z1LQTVcyYW6JjCauTschHhRuT
         T28A==
X-Gm-Message-State: APjAAAXgubPLlt0cLgeH6HAA/nLFwzGIRxJ2TRz2o+bj16TM9nPONNPZ
        +K4BOESxZkm7coiQ6xYy8P8tXm4OSy4v2w==
X-Google-Smtp-Source: APXvYqwCLdh86K7fvdpv4BIjADgu8N/IA0a1/Ur3cjzxTqBPjYue6AybqrwNO1yZ+VpP+vbhatUxkg==
X-Received: by 2002:a0c:b148:: with SMTP id r8mr15730905qvc.240.1562607554433;
        Mon, 08 Jul 2019 10:39:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n184sm7792224qkc.114.2019.07.08.10.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 10:39:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkXbd-0007Za-HP; Mon, 08 Jul 2019 14:39:13 -0300
Date:   Mon, 8 Jul 2019 14:39:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Report correctly tag matching
 rendezvous capability
Message-ID: <20190708173913.GA28971@ziepe.ca>
References: <20190705162157.17336-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705162157.17336-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 05, 2019 at 07:21:57PM +0300, Leon Romanovsky wrote:
> From: Danit Goldberg <danitg@mellanox.com>
> 
> Tag matching with rendezvous offload for RC transport is controlled
> by FW and before this change, it was advertised to user as supported
> without any relation to FW.
> 
> Separate tag matching for rendezvous and eager protocols, so users
> will see real capabilities.
> 
> Cc: <stable@vger.kernel.org> # 4.13
> Fixes: eb761894351d ("IB/mlx5: Fill XRQ capabilities")
> Signed-off-by: Danit Goldberg <danitg@mellanox.com>
> Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 8 ++++++--
>  include/rdma/ib_verbs.h           | 4 ++--
>  2 files changed, 8 insertions(+), 4 deletions(-)

This is a bit late, but ince this is for stable, applied to for-next, thanks
 
Jason
