Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35493C388E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJAPHd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 11:07:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33281 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfJAPHc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 11:07:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so11584664qkb.0
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2nQjvTbwJ6uRdgVS82DId2qxs8AnlBlut4BlU59GnCg=;
        b=MTPbUjxTULu5CNlj7bTLWHAng5KIyDtxxwtcNi9lQqBoSLhFWpgia6d8wa/uINg+99
         5DDaEn2bmP6jXSOvC9TsBwm4z+ocIceT6W7cCNtfQBOVtWmciOKO1jhZeixHCXylhMrp
         +TNPtM4kThlCHc0jNA/9neE7srFcoo797irBs4Qd/axdI75xW8fmaMLR1Utvvzo8Q/rJ
         5IY34mn+0od3Uw18aqLXjP8F+X2KHmAY/L4H9ukWI4nLSD5HvDHNtx3RbjR7dDci49oK
         dfkbkI3fN9iLLb0nF6kYkCaR4VRlOiquvyYszoFGZlnGhVmdmygxhx9m8yJCCDbrlJGj
         Sflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nQjvTbwJ6uRdgVS82DId2qxs8AnlBlut4BlU59GnCg=;
        b=kdJF4hxbaLT1ZWYEMTd/s9GKAYQoQFpDGbrtWzFYHNkX6R8r/b74PwapYhIpu7vLEk
         j0d8D/Drz54qdKcSGDo6b54h3dPlMETCmu3nXVC4yVTk8VDn3biUJz495uMjgy3u5V5Q
         c59XC7tmp33y0YRKAofbPnvXIAw6H1vMxBsG8gAp9Co2Tuxj/zWKwBGX+To3mmQPD98d
         9F5IcynlQJzT8SkCInkXjIXqOITFfF4dkr8M7nOnQbi12lPBCF60o/NMt/a5b6ESc4Ww
         b478KT8i0l+9ecEIrwlU2P7U/Hff3spumXACphBgsG+x5C7N+6AYA/zrd7081bbc/pF/
         cMMw==
X-Gm-Message-State: APjAAAVXIJzj5LPngpy7j9Ahc7mrZ8QqDi8Yke8TpDke11LdQUnE/JFf
        6fv2dFlWHkuvW/5YntykDhr3IQ==
X-Google-Smtp-Source: APXvYqxwDjYq7GDHR/0mgmXiSjJTuZUR2DJENVD+lLIVy/tDKfawUf9LJY/k0UtpCrp2asV6Ga1+Gg==
X-Received: by 2002:a37:bc84:: with SMTP id m126mr6412389qkf.196.1569942451846;
        Tue, 01 Oct 2019 08:07:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 62sm8283688qki.130.2019.10.01.08.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 08:07:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJkQ-0000BK-Ny; Tue, 01 Oct 2019 12:07:30 -0300
Date:   Tue, 1 Oct 2019 12:07:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 01/15] RDMA/ucma: Reduce the number of rdma_destroy_id()
 calls
Message-ID: <20191001150730.GD22532@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930231707.48259-2-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 04:16:53PM -0700, Bart Van Assche wrote:
> Instead of calling rdma_destroy_id() after waiting for the context completion
> finished, call rdma_destroy_id() from inside the ucma_put_ctx() function.
> This patch reduces the number of rdma_destroy_id() calls but does not change
> the behavior of this code.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>  drivers/infiniband/core/ucma.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
> index 0274e9b704be..30c09864fd9e 100644
> +++ b/drivers/infiniband/core/ucma.c
> @@ -160,8 +160,14 @@ static struct ucma_context *ucma_get_ctx(struct ucma_file *file, int id)
>  
>  static void ucma_put_ctx(struct ucma_context *ctx)
>  {
> -	if (atomic_dec_and_test(&ctx->ref))
> -		complete(&ctx->comp);
> +	if (!atomic_dec_and_test(&ctx->ref))
> +		return;
> +	/*
> +	 * rdma_destroy_id() ensures that no event handlers are inflight
> +	 * for that id before releasing it.
> +	 */
> +	rdma_destroy_id(ctx->cm_id);
> +	complete(&ctx->comp);
>  }

Since all the refcounting here is basically insane, you can't do this
without creating new kinds of bugs related to lifetime of ctx->cm_id

The call to rdma_destroy_id must be after the xa_erase as other
threads can continue to access the context despite its zero ref via
ucma_get_ctx(() as ucma_get_ctx() is not using refcounts properly.

The xa_erase provides the needed barrier.

Maybe this patch could be fixed if the ucma_get_ctx used an
atomic_inc_not_zero ?

Jason
