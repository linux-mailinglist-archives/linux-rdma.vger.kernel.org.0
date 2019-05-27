Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC12B972
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE0Rjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 13:39:39 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34000 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfE0Rji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 13:39:38 -0400
Received: by mail-ua1-f67.google.com with SMTP id 7so6766742uah.1
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saetweN31X4d/2+5ymlONgNuDyerHs77DoiSB7GRSQ4=;
        b=gB0r4kjheGmjR7Ed1uZrvsiPuhkZt9c6CR2NFQO/JTZkfEg9YlhvBLDr+0XGcFztUQ
         V3bIhPFimpaIWGpLN88qVkQIe8VHSRcWVX5csHxWlbLTM7u4BGik8CReJ89KCIKcfwgA
         cLUlNvDGPHbavtSuq0jZMNI7FSokhpaa7scV7I/q/7cCQA7rGdF18PB2Y2kApYJ96R2k
         tUEAAwKmBE7q7vqHjRu56TNJ+LxgBfpEFD54CP8uNPHb2ueWf6tUuSeAyiVNs5FXr18j
         lUEMec/+HYoiuup8Bm/WMA+liEDjKVVaKvgiycCbXfPhhEwiM/NLmZ3XUnJLj5eAIr/R
         CA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saetweN31X4d/2+5ymlONgNuDyerHs77DoiSB7GRSQ4=;
        b=k2v5D4oF2fpo/sDrjxTtEL9W72hMmM8uHwUm8HUE1Ivz7tbdImtQ4cbOAJ8q2KGpsN
         xsJPtn1yhFJQyL2BljN9QSReMdQK1k10Y+BLA57RVKs0Mvi6czSczC1nhvHwKlKJ6ohr
         ra2jxnO1ZpBOplizSleF9vnCi2hKYbfdTs8n8J+QLMKJFgAwyvA0QnCVTYZpSOh2VvqP
         gRMMfq2k0oIbksV1Y1tFVSxc9Ib/liQ+pxFFAXHoI7x37JgcvLxqeAs5kE/SirghTYx6
         r8nLjXCUI01gQ2xHFz5IwUSbmHqcxwRtkv8hTN8ZABf+dHKxvB5yB1SOjxu1cHSw9ZIq
         o6fg==
X-Gm-Message-State: APjAAAWZYkRezOqnyQch/pik18KEPEh9QPV0XLqOtf4m+9JCRpdYQipt
        4ZGlf3zEymXIPu5YT7Btb01R0qApl90=
X-Google-Smtp-Source: APXvYqwx+F5shmWJYFQ7HNqwSL8XyxxpCiWL9uCVoTM7IIpguBhH8nF/kJ2rkND6o7qSW5ZROZVqgw==
X-Received: by 2002:ab0:413:: with SMTP id 19mr63128121uav.93.1558978777620;
        Mon, 27 May 2019 10:39:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b4sm1250156vkk.8.2019.05.27.10.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 10:39:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVJay-0008Jw-HA; Mon, 27 May 2019 14:39:36 -0300
Date:   Mon, 27 May 2019 14:39:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/core: Clear out the udata before error unwind
Message-ID: <20190527173936.GA31960@ziepe.ca>
References: <20190521175515.GA12761@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521175515.GA12761@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 21, 2019 at 05:55:22PM +0000, Jason Gunthorpe wrote:
> The core code should not pass a udata to the driver destroy function that
> contains the input from the create command. Otherwise the driver will
> attempt to interpret the create udata as destroy udata, and at least
> in the case of EFA, will leak resources.
> 
> Zero this stuff out before invoking destroy.
> 
> Reported-by: Leon Romanovsky <leonro@mellanox.com>
> Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/rdma_core.h           |  2 ++
>  drivers/infiniband/core/uverbs_cmd.c          | 21 ++++++++++++++-----
>  drivers/infiniband/core/uverbs_std_types_mr.c |  2 +-
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> Fix for that thing Leon and Gal were talking about.

Applied to for-next

Jason
