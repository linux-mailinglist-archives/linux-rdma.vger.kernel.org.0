Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF5E8F87
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfJ2Ss7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 14:48:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36821 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfJ2Ss5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 14:48:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id x14so11436495qtq.3
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mBUiIVf6q/rDqLGc4EbfJoNVg3DysopyacsfY5Sz0rU=;
        b=Xo7LHzaW43U8o6mcJCauwekkaCS8YEhpkpkagMIwN/jZ0apzbn5nHima/pnzMZua/+
         JStfCOUTVbXR3bIf1ilcPakL9HLApdoJEJvc4ijJDOWp+8nJ7AvwqNQrhJE9FcBqjsRd
         ZzFHoVV5Xd1fGLtG5CueYXxz7V1nlaJHV7+6msXJH28FQMQ3Ex6w7hfPH5oiZcuvAM02
         FK0dpSepSjOE+Qa5hCmSJ2R2PHIlqaudY+IN90GWYEVLgj5H5xlr7e+hSq9hM1QrL0O2
         QC/ajDfQw9nSTmBwT5mF75IamIsioqf8neBaTwDvCef8SV+e/ph85Rf4XHc/+7/J+xc5
         Iz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBUiIVf6q/rDqLGc4EbfJoNVg3DysopyacsfY5Sz0rU=;
        b=QZcvOkXgIi5J4vizrkvCK4SyZu7VWmesuy2STJbHYdlqw3u/s7ycWoHqAfAucCuiaf
         e2LY6Vn1tHxMj0Pgn2kWJf3Jp+FFjdGpRrmbmaaGlHc4jKftjACTZd41va5m2q3g98e0
         jsbfvX2H2EzM02GEH15Pmk19ORf3IJy4A5qiPtE6pwV1DDaN4f6XVWN2izwAKmIaKDAD
         zK0cStZL37HaZGIPgGuMNSp8TJ7TINwPGy8bvZnU5MjrJlgKZusBXKWLlrBdlu9LkyqJ
         eDmzQPY0ClXp5s+bzAJfD960ZHkD6ZSNWT/8WuduskzrV95i2mPN+02G5yHujZZVQh03
         CInw==
X-Gm-Message-State: APjAAAWcRLtDxMeiekMXBjgzmWrZaKgjMDU96VQ5qugR2u7xxyv02rvF
        /Pg2x93g0uwgARmahUGe8XbZzw==
X-Google-Smtp-Source: APXvYqxbq8sEpBANn34j7OgqEdFYPUH4UG0c5lXSYLMQHHWzdbk20oOcrI1SuaPPaI+VL1EC8bBI5Q==
X-Received: by 2002:ac8:524e:: with SMTP id y14mr596415qtn.172.1572374936686;
        Tue, 29 Oct 2019 11:48:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t16sm746715qkt.99.2019.10.29.11.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 11:48:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPWY3-0002OO-LR; Tue, 29 Oct 2019 15:48:55 -0300
Date:   Tue, 29 Oct 2019 15:48:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+57a3b121df74c4eccbc7@syzkaller.appspotmail.com>,
        bvanassche@acm.org, danitg@mellanox.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, mhjungk@gmail.com, parav@mellanox.com,
        shamir.rabinovitch@oracle.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: KASAN: use-after-free Read in cma_cancel_listens
Message-ID: <20191029184855.GH6128@ziepe.ca>
References: <20191024115700.11852-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024115700.11852-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 07:57:00PM +0800, Hillf Danton wrote:
> Detect and avoid repeated cancelation.
> 
> +++ b/drivers/infiniband/core/cma.c
> @@ -1747,7 +1747,9 @@ static void cma_cancel_listens(struct rd
>  	 * additional listen requests.
>  	 */
>  	mutex_lock(&lock);
> -	list_del(&id_priv->list);
> +	if (list_empty(&id_priv->list))
> +		goto unlock;
> +	list_del_init(&id_priv->list);
>  
>  	while (!list_empty(&id_priv->listen_list)) {
>  		dev_id_priv = list_entry(id_priv->listen_list.next,
> @@ -1760,6 +1762,7 @@ static void cma_cancel_listens(struct rd
>  		rdma_destroy_id(&dev_id_priv->id);
>  		mutex_lock(&lock);
>  	}
> +unlock:
>  	mutex_unlock(&lock);
>  }

Hum, it seems like a harmless change, but the real issue here is that
cma_cancel_listens() was called twice at all.

It seems pretty clear that the intent was it would be called on the
state, and the state is transitioned away before it is called. Ie see
how cma_cancel_operation() works with the 'state' argument.

So the only way to trigger this is to race two state transitions,
which means this is the usual syzkaller bug, the 'cma_exch'
synchronization scheme is just totally broken.

Jason
