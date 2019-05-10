Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8119DDE
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2019 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfEJNKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 May 2019 09:10:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39706 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfEJNKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 May 2019 09:10:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id y42so6466204qtk.6
        for <linux-rdma@vger.kernel.org>; Fri, 10 May 2019 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UOKF47HJu2JuX7gI/SipAYpNlu6con13Zk+N5cJusI0=;
        b=gn1IRzHqA23diQxfaISVbAnDyLB7V8DcGySfoOSEm7FEtxrlpoBHVfOoalkbc6Yk3y
         4pfe0WFafaMy+OJcFQ+Id10S6MzWB6UKc42PSNyRY/Os/K5BjnzSAPWmJSCG7uWZwCeU
         BEippNV3bvC4ef22K0fJwNuuMtWr6f08Rk9iSCM0da3gyyTesNpqFkliY+5SShsYCrl6
         E6iOu6f+U5oESq3W2xZ2loYFCLgqRmOdZPzQlB03jrgkMCQxPACMzOt8sEHlm8c8WeLK
         QVEnntkYh3F3uyShB+lScKZmqKn8QcJokFizanyeqeyrRcBzZIiG3wjtJXPmnFEfJPYr
         s7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UOKF47HJu2JuX7gI/SipAYpNlu6con13Zk+N5cJusI0=;
        b=D4J093nsWdAg2srSRg3fm8tqKFD3p1fyox0FA7hm1oHPEYcwQvN0p+dOXS7byJgXp3
         F6ZhiM99SciL9IungmRIQ15Q97ynG7EeSlK8mP25VxeTP4d/Z9v2dwVza69mExuiGhC/
         jIUbmpTBVkbBDFJeRXh5kKRHHdpNb7ZGP8RkM1bQSCYPlEHd5jB380pD8zKRalboLUAW
         6PuvY/1XGXfD1a4NEaltC/zAXfxqNwvM2flknlyPkEPJWOY/Pwu44DUXxAWkpmmzKCNX
         sL0f+Vnf/B4F3aqlCRMfuJioeW46n9g2XwSndJ2h+ZHXRAy4YBdFH5dnvVAJNB7eIF4R
         j5Tg==
X-Gm-Message-State: APjAAAWQVcT/Jrs0xWigGwXtzJ7avlz5oQNa+YGkKQFbLlEexEWfEZh5
        RVy8vUgRfCBZy6C7euwhb/OF1w==
X-Google-Smtp-Source: APXvYqxO/8Uxr8djCfIhbSIBDEMkKdAf6d/r6crFMV4Kv7pPnwqVdyFx/0Yps51UuUgkOrA3FP5S/w==
X-Received: by 2002:aed:3501:: with SMTP id a1mr9441038qte.265.1557493851327;
        Fri, 10 May 2019 06:10:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id j123sm2784494qkf.23.2019.05.10.06.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 06:10:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hP5IX-0004Y5-9B; Fri, 10 May 2019 10:10:49 -0300
Date:   Fri, 10 May 2019 10:10:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] infiniband/core: zero out bind_list pointer in
 cma_release_port()
Message-ID: <20190510131049.GA13038@ziepe.ca>
References: <20190509100358.114974-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509100358.114974-1-hare@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 09, 2019 at 12:03:58PM +0200, Hannes Reinecke wrote:
> After calling kfree() on the bind_list we should be zeroing out
> the pointer, otherwise a second call to cma_release_port() will
> crash.

Why would there be two calls to cma_release_port? That is a bug.

Jason
