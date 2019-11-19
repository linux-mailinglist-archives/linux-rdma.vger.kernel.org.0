Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACECD102D46
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 21:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKSUJs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 15:09:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37093 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSUJs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 15:09:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id g50so26108929qtb.4
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RAL8NNR1rM8keS4ThbR9nY1psBpTaJFWyRuH5QEBJdU=;
        b=N43j+hEdJD5P+7uCa3f1PHqrZjzLyZTMhQ7V9m3pUV6UjelxNg+CiX0F1gWGHbEfDu
         aB4/mYPdugRO4VtnBXzyZZooTCRVRKxH0GuL83HKHou+wFYBABeh0HL8QWVXDWRnnvc6
         yOBlzX0R8CsIpVmk99sCbFOZpc5OF53rstcGgi27z6JkZFaRj+8uaLY1e6XF4dNvMPzy
         Zc86XKIa4eFVm8S5IeuOFcLVfihtEz+b1uxPFy62a7+Tk/qd+BbvjuPgzdRsSyBAdyPG
         2a/kYgxhEdw17SLimva8LtI9iGAGACQxB9Ple0kckCLpK7tc42yMY0Ix/hjIUn/8QKmv
         vAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RAL8NNR1rM8keS4ThbR9nY1psBpTaJFWyRuH5QEBJdU=;
        b=sXdDuzYROqXTGS7rIrdmCJa1m5pnZBLXY1Q/SpX3K31kHV8uV1++IWZ1k52J9ijdZZ
         Kn/dAAWqO9ygwIXuuXVbFAmS25Yn5BFrkcS/cZDhr2+tZk/Dyi+fsIKNxsQGnXUorVv3
         4QCmHxYn72yu8u8q5tqm+arZgk+p3q7TXEY8/WCXfvonNyH1iWKnOIBiZMnXNAxbvIQm
         jBY41Cly0aH15JbWM7nC3nFx0FE5+Vs3VIKgf6uVqPX2f02bCcAfzCP3MqXWL4YJGg9L
         RTZ2yQuCiTNJtZDP4kfuUjpa1pyzZTtUToTvpkizABbhg6px7YEJwB70YFm/XkIR8RDC
         XZqQ==
X-Gm-Message-State: APjAAAU7x0yapPY71QEFnOKeHKidkQquoBF7EjMVAeYRTB+G55F9H2MJ
        hqSsWTYWV7mN8VwwZbOSQFSd+g==
X-Google-Smtp-Source: APXvYqxePgnamlaJsa1Kyn1QS6km0luWvHRwz47ZZ28NkTEXyNojLmvHREbK3ZzGxjGWWk1IUcuZdA==
X-Received: by 2002:ac8:2f28:: with SMTP id j37mr35221910qta.251.1574194187132;
        Tue, 19 Nov 2019 12:09:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p54sm13342186qta.39.2019.11.19.12.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 12:09:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX9oo-0008Eo-5A; Tue, 19 Nov 2019 16:09:46 -0400
Date:   Tue, 19 Nov 2019 16:09:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Support extended number of strides
 for Striding RQ
Message-ID: <20191119200946.GA31610@ziepe.ca>
References: <20191115154555.247856-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115154555.247856-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 15, 2019 at 05:45:55PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> Extends the minimum single WQE strides from 64 to 8, which is exposed
> by the "min_single_wqe_log_num_of_strides" field of striding_rq_caps.
> Choose right number of strides based on FW capability.
> 
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 10 +++++--
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>  drivers/infiniband/hw/mlx5/qp.c      | 44 +++++++++++++++++++++-------
>  3 files changed, 43 insertions(+), 12 deletions(-)

Applied to for-next

Thanks,
Jason
