Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07B12578A
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfEUS2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:28:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43489 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUS2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:28:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id i26so21626521qtr.10
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VGSY3nub3UnXxPiP6MQqWHrg5ozO0zG/kfqaqlufIdM=;
        b=J+/yjU9L4/oJ4OAfKL6/xC+lZTzm84m1LC6I0O6dJqYxAenwPmLgf4AcJPu0eaCI4g
         /3qcdnlq+FV7EENgt0MfMvP+LdZNFVOFY9QvNeICGw/tH2futVIIZGb1nV0DWPADk740
         8V/e2HOQnuGI4z43AXRuXoGTPAeTnww1qpKlmrc9sruaDzXfrC83hYpSibS4PqjilBDh
         GS+NfW95O0Dscpbdoi/qkySFWtejk9qjvJedskVHmc2ZT5T6fE+Rl/3k6D/80eiZyEK3
         Irja4X7b08jXf7nNK55me5BIarv/M6Egd1q7HuZ6fi7+MZybWA7Gb1SYiSwNML2PKi3T
         XNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VGSY3nub3UnXxPiP6MQqWHrg5ozO0zG/kfqaqlufIdM=;
        b=VyDdst39LuercQgzEEdnEHOdDJC+X3IzKjsFZFDhf0x3g6rRi+aVz7v/tkcw6wKW30
         FHQZAqHCMJI22uGgUjxia0CM0d88DtF1pg8kKcnP/TtdGb3JakanpDFbsx+nPbxCU0f2
         82TtQixOB/Cgj4hIxVrEZ0ZUlFnHIhWy4aqFslWtIag/Y02VLpipHHTJWDvATNhY//3R
         qPlhGyHXyHtHyk/MoExcHia8H+jVh8SArK1EbS+3tW/cQUEFy2hkJvhsyDRg/tVVLU/b
         veNy9N9R11PAMA6yw+3tQT9Ju0U/PAtJQ5eGqVpBh2ELDNLU9rP0MFhCOBulA22Okiol
         jxSg==
X-Gm-Message-State: APjAAAVz4aZ//qXxHVkarfXorzKaifV9o4y42vcE5n4yxr0JlM9v5kcc
        wdP+lKcjKR4YdJIg61Cvwt8uvg==
X-Google-Smtp-Source: APXvYqw2fHuP+ImJf7SV7vG+JNqQVJejltLewlbOW1x3cQG3PWx16IF84koF4DGyJWz+UlxVy4SU1w==
X-Received: by 2002:a0c:d941:: with SMTP id t1mr66752907qvj.204.1558463296906;
        Tue, 21 May 2019 11:28:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d17sm10425367qkb.91.2019.05.21.11.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:28:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9Ul-00048u-V7; Tue, 21 May 2019 15:28:15 -0300
Date:   Tue, 21 May 2019 15:28:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/mlx4: Delete unused func arg
Message-ID: <20190521182815.GA15903@ziepe.ca>
References: <20190519153128.17071-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519153128.17071-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 19, 2019 at 06:31:27PM +0300, Yuval Shaia wrote:
> The function argument virt_addr is not in use - delete it.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx4/mr.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
