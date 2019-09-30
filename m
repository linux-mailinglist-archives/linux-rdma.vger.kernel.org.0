Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD7C20C2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Sep 2019 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfI3MlY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 08:41:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36030 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730787AbfI3MlY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 08:41:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so7590634qkc.3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfZsMbAz4N9JRh/J41xtgSUOS6pdSAIlt+2TlUaDOAg=;
        b=ZpJGx1+ZVyx2UDAnnQBl/t70N5yc3QUW6avTzf/PoYpUIAWX1dZSyCxPzjaJVlFg4H
         ptb8uHGw9o7ucMafZSc4iAKKT0YbUKvn9g6YpRV9tXuyaVaxk/6TZAeohfj2MuAJU5Xp
         sKiefy8/gBoeT0fkBiRTR2fQ7aHWZeDJGsvyd6GSQgvbfXF/DB7m8GErlQpf9nTleJ8R
         wGFYB7dHafiAdp3iAgZOYQVSHuNynTi15xElXCDxFS039B1FZ2EqK8gMurwD2dA2fRbC
         RcsZ8gG2y23bRAHVDlgaRuGqpUg616FUzuvEV0YBeOsBGwqbKaPOiIH17aIcnpjfLUsU
         bPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfZsMbAz4N9JRh/J41xtgSUOS6pdSAIlt+2TlUaDOAg=;
        b=m2vhqICPyWqfS13H4tQywwOrw11d8FiPlnxL6Zhorx5+QFTI8UFGBl+xYSra4CSsu7
         2zcPnyfXOz6hL09ZQxnbeacOKPTtWywRFSI4lQfUuP1jY/+qfvraPeHI21Ub4UAw/soM
         KcHxBruaHBBsK5wtBVp57xdJvvwlo8lH4mFhqVVbI6k5b3VrQWgnAGexsVpYXX+Saypc
         1b5nnLCU0oEo2IQ82yQF+N4vJilr1c2JrQxK+QpBpzIsYRJw6fCP9pw2HzAvcDfuuk6G
         jaEFp+/HbA4FvnccrYCm6KYyTT4YEG4CfshZEhSLXg3byLLiM35mKG9/qtXkXrC/oKhN
         HEFg==
X-Gm-Message-State: APjAAAWp0keJHTuMBMqn0McdQ58AeckvXN6q1TZJ6VEk/bIAY737tO6f
        b8cgtec1ULhTefZLSht4rjjNDsuZUh4=
X-Google-Smtp-Source: APXvYqw02UBR/5xicgMscgVj48j8a13wugIDUZnupbgaYZem59vvhXWPrspHVqHubAmTWdJWYCbrKA==
X-Received: by 2002:a37:9742:: with SMTP id z63mr18864083qkd.350.1569847283425;
        Mon, 30 Sep 2019 05:41:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z5sm7549006qtb.49.2019.09.30.05.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 05:41:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iEuzS-0007ON-1k; Mon, 30 Sep 2019 09:41:22 -0300
Date:   Mon, 30 Sep 2019 09:41:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Metzmacher <metze@samba.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rdma/core: add __module_get()/module_put() to
 cma_[de]ref_dev()
Message-ID: <20190930124122.GA24612@ziepe.ca>
References: <20190930090455.10772-1-metze@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930090455.10772-1-metze@samba.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 11:04:55AM +0200, Stefan Metzmacher wrote:
> Currently there seems to be a problem when an RDMA listener or connection
> is active on an ib_device.
> 
> 'rmmod rdma_rxe' (the same for 'siw' and most likely all
> others) just hangs like this until shutdown the listeners and
> connections:
> 
>   [<0>] remove_client_context+0x97/0xe0 [ib_core]
>   [<0>] disable_device+0x90/0x120 [ib_core]
>   [<0>] __ib_unregister_device+0x41/0xa0 [ib_core]
>   [<0>] ib_unregister_driver+0xbb/0x100 [ib_core]
>   [<0>] rxe_module_exit+0x1a/0x8aa [rdma_rxe]
>   [<0>] __x64_sys_delete_module+0x147/0x290
>   [<0>] do_syscall_64+0x5a/0x130
>   [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The following would be expected:
> 
>   rmmod: ERROR: Module rdma_rxe is in use
> 
> And this change provides that.
> 
> Once all add listeners and connections are gone
> the module can be removed again.
> 
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/infiniband/core/cma.c | 2 ++
>  1 file changed, 2 insertions(+)

How do you even get here? Are you using in-kernel modules to access
rxe?

Drivers are supposed to declare a DEVICE_FATAL error when their module
is removed and then progress toward cleaning up. It would seem this is
missing in rxe.

Globally blocking module unload would break the existing dis-associate
flows, and blocking until listeners are removed seems like all rdma
drivers will instantly become permanetly blocked when things like SRP
or IPoIB CM mode are running?

I think the proper thing is to fix rxe (and probably siw) to signal
the DEVICE_FATAL so the CMA listeners can cleanly disconnect

Jason
