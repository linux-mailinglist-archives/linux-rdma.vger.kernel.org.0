Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2BEB720
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfJaShi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 14:37:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35332 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfJaShi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Oct 2019 14:37:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id h6so8092049qkf.2
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2019 11:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrILTC4+bcaln3eoSPhoO4YXMnF7rgx7O9TO7VWdqRc=;
        b=T8Ur9yA6nvu/zeGkPfLa5iz7+lhoUksy/BPE9DR3AnsWbIrsW1hLNtO7HGF7BIqgqv
         ztTZTTeJS31GQZExZEL0CdKYGPH+GKk9+1p5ctNG5pz+cEAZO2bqnVpOma7tFy3tUCz/
         2s/6LskFH4g3niORqWoePKXdlei1LjieYkudSG4grGCKbuga5ZF/5O4aVVUClRg1aiRV
         ftIuwKbH2kl5Y0HjGqtufQ45KuIJGESsV4LJFmWxssi0qU1w1vgsb5KNobKgHui3J4hX
         78VYyiuP81ES2T6x7Nu8szk0uY0kGwmE7vy5vfHFj09833mncrjqOa7wXv8HNLXeRtdt
         hkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrILTC4+bcaln3eoSPhoO4YXMnF7rgx7O9TO7VWdqRc=;
        b=DqBd1dRyEBVp6OaHcwKl1gV6mZNaG7ZEej6/GuU3IE0d8VBA5fViG497QD+Kxr7jYk
         +BpPUdFmhIOxJIeGJB8ImquKTY89xECF4vl8ci4mryTK87KjTyFQ1YGxe4MLKN3SdxB/
         CEiEjbc9+A+AWzRdzqkK5BqkIQbnq0zFKGTIJGuo31GgFBX/DVmTmRxHjk+hRIcEyGbE
         AiUYkV92+atj9Y4lvXQ9jALCl6ktzfjlfscbRhT4Ozyp69+ghzPVjeH8Lo7MWBZ4BrcJ
         f5nRtjAbq1XgeHJ1BMJfdhqvJBPCEjickVMVojRAVHI5K16jWXzeaMFu+a479NNmB2Au
         Gwpw==
X-Gm-Message-State: APjAAAWQhXymej6Eg4s1lGpXOaz+LhNIDmPcNc5SPhMTqi3wrAU+YToj
        +kSJHO+D1tX62xhuIRRku32GiQ==
X-Google-Smtp-Source: APXvYqyS+kQv8oZWHMs0krMORKlC0DhL11G64Qz8lztLz485lOZ6ORo46DEJbwR3VQJlp5rXgZ6oeQ==
X-Received: by 2002:ae9:ec0b:: with SMTP id h11mr2198300qkg.27.1572547057267;
        Thu, 31 Oct 2019 11:37:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r29sm2705156qtb.63.2019.10.31.11.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:37:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQFKC-0007P3-5b; Thu, 31 Oct 2019 15:37:36 -0300
Date:   Thu, 31 Oct 2019 15:37:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Return proper error value
Message-ID: <20191031183736.GA28423@ziepe.ca>
References: <20191029055721.7192-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029055721.7192-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 07:57:21AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Returned value from mlx5_mr_cache_alloc() is checked to be error
> or real pointer. Return proper error code instead of NULL which
> is not checked later.
> 
> Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
