Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF03139ACD
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 21:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAMUhT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 15:37:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35672 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMUhT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 15:37:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id z76so9895189qka.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2020 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GC4Mx4WwzibDa9sixjZKnn0BXMp8hBHDVk880J5njTw=;
        b=WeXzHFjn+9MO7L07lz2Vqc4oJ0hfB1WwK9+4sP0eB3XNmEQQGuBe8fEY6HgEPx95vN
         m0a+bjOVl55P3Y7BeJMudazmbOFwyu3wTzxSKGGP1PqKPmgMbNCqKkk1CCvHmNIWm1VT
         nR81Fr8e6DAZQELxrY72rtqrxwX8C8B0Q/x8OVlJRTs8DuUOjsrCxBU5PThOn7XUSNwS
         RHKQLDKU6oHboKwCNRlRBX8kiEznhitB/pIIM905lXcCkZFSfeXJQezq5HaPq31P4nr0
         oVFhFjAdGDkzcc3qQNkiVMJC8RMfIops7oduZUDgH1BdDN3T655RD6NTev+yiY2x0cD+
         9gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GC4Mx4WwzibDa9sixjZKnn0BXMp8hBHDVk880J5njTw=;
        b=RMnDHtZ6QX7YFsVm/IWCIupBh9CSlkPs4udPczN2/VxxOOSh+B4lywrdlsTnA/qHDJ
         Htxc2HS0azqlH4b5zbi4IZbWG5Fdr6HieZ7XQ0ZT6UJ7xjse4b6tJY2fhKCWEgjQVtJS
         FLy18w4t/ynRIKk8pdSf5rf30kQgSZUOeyUeNW95FD2JNZNLdy9vR6BvjB6/GepfAbwH
         QkeqpT+s4jx9/eK4h5cdnnV1tznAb8We2D6HNx7pPHQ/O9VoFaNPtKbX5M5RGbJGbG/z
         Oud2ne386TZoPXgAFOZijOHaqufkwiUX22z46Zg926a0Ztbm7HS5Gkk+qyZYk880cWUI
         OyKA==
X-Gm-Message-State: APjAAAUWvWRprpaJCGn1l33vook+Lyc7RF2X5GC5gfRm8LLO4kKVVIc1
        nhtaZ0b0FkzidXPuWeQEoKfBa0pJqdo=
X-Google-Smtp-Source: APXvYqwsHaqNWbFzcYOo6jJTHkv6VLq/SS9g2b7mBwJ68dIlzynvHOfv0jaBTFbA41u4s5M/373fRA==
X-Received: by 2002:a37:e10f:: with SMTP id c15mr18130919qkm.331.1578947838575;
        Mon, 13 Jan 2020 12:37:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t3sm6421789qtc.8.2020.01.13.12.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 12:37:18 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ir6Sb-0001wB-Lz; Mon, 13 Jan 2020 16:37:17 -0400
Date:   Mon, 13 Jan 2020 16:37:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH] RDMA/uverbs: Remove needs_kfree_rcu from
 uverbs_obj_type_class
Message-ID: <20200113203717.GA7112@ziepe.ca>
References: <20200113143306.GA28717@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113143306.GA28717@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 13, 2020 at 02:33:10PM +0000, Jason Gunthorpe wrote:
> After device disassociation the uapi_objects are destroyed and freed,
> however it is still possible that core code can be holding a kref on the
> uobject. When it finally goes to uverbs_uobject_free() via the kref_put()
> it can trigger a use-after-free on the uapi_object.
> 
> Since needs_kfree_rcu is a micro optimization that only benefits file
> uobjects, just get rid of it. There is no harm in using kfree_rcu even if
> it isn't required, and the number of involved objects is small.
> 
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 23 +----------------------
>  include/rdma/uverbs_types.h         |  1 -
>  2 files changed, 1 insertion(+), 23 deletions(-)
> 
> This should go before the 'refactoring fd usage' series as more
> testing has shown the reworked code can trivially trigger this
> existing bug.

Applied to for-next

Though it seems this might not be an existing problem as none of the
existing kref users can outlive disassociation. Nevertheless it is
very surprising that the kref becomes a segfault after disassociation.

Jason
