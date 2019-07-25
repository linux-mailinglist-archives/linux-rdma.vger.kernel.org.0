Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1E754CF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfGYQ6b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 12:58:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35916 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388864AbfGYQ6a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 12:58:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so36953626qkl.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ATcDQ4WGQDqhMlOnuVN9hszx95z6CBf+uB6RvpSIK0=;
        b=EAMhUgfFuMhf2nsSU2L5GIwGK9f57Sb/xACUt4ECKjBJpm/HQqZ6/u5e8A8tXTo/S3
         E3W6xJmA+YFzYvj4SCg8GDGMtyc73QKjzKeQ7zeZ+8JGd20fiYcxZNAxZ/DxcnCLMizY
         oyHR8M0fLK/310xgxRE1X7kKREcU5OXmnmX87LVCS0q2/z73W2l7tsc49vAMOmRSjI+s
         dUpcUAsRleTi7YDosx37UbhE0Xy0fEv/cSQKqsCGtQjdHV3n5F2sGst/TSLk1EYys4Be
         iruLCzsaVpM9Jks2yzoVRQ+y0gq7dLugpuFCUxEJ2gNC9sjSFFfqA/DfR/DS5aXbFGXH
         A92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ATcDQ4WGQDqhMlOnuVN9hszx95z6CBf+uB6RvpSIK0=;
        b=lHzV9MdRjlA/1mrScJ8OsPB+544PSSYUKvwCjhPKcokceWi4uvCOyH5E0RYOyVaD5a
         jKAZC30PmfXBuCzP9lVptYGFoJrlsKCVrfRqqxEcXmVvRDB4qDMM7sstpIxognp1lKeF
         h4hdGbtYYrHRELXJ196keHCJCYk5KsB026TzxcqYv6SvFj4wyYXtG77NusRX5Yh/YThE
         +vy4+ey04f6Ub/OXuExthcRKL5WcsZ2M5bYjJJOrCaRqiia5Z4z45NbIavTzmHU0uEA7
         1qft++oZVQmcFgTU9GjgDhKFcGUa6ZbXcRYTfhRh0GuJSegrBYKFlpg467qsUMsGnoBq
         cIIg==
X-Gm-Message-State: APjAAAWHz5MsIme14kuzh5vzkvMS/Hoo87lRVkmz6ZBjTKWZXzkS/PN8
        X9nVmfGbgcVZxavKTe3if/wJHw==
X-Google-Smtp-Source: APXvYqxTDi9HHRYX7j/EoLB/+mI2k7Y0/3qlUqeXTQ/gWE/1YFV3VrGK0iQ1XBh8tmO+bugZXPl4hw==
X-Received: by 2002:ae9:ebc3:: with SMTP id b186mr60322698qkg.222.1564073909961;
        Thu, 25 Jul 2019 09:58:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t76sm23568871qke.79.2019.07.25.09.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 09:58:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqh4X-0007VM-0x; Thu, 25 Jul 2019 13:58:29 -0300
Date:   Thu, 25 Jul 2019 13:58:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw: qib: Unneeded variable ret
Message-ID: <20190725165829.GA28812@ziepe.ca>
References: <20190716172924.GA12241@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716172924.GA12241@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 16, 2019 at 10:59:25PM +0530, Hariprasad Kelam wrote:
> fix below issue reported by coccicheck
> drivers/infiniband/hw/qib/qib_file_ops.c:1792:5-8: Unneeded variable:
> "ret". Return "0" on line 1876
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/infiniband/hw/qib/qib_file_ops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
