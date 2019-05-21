Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6025798
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfEUSbg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:31:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44319 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEUSbg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:31:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so21653425qtk.11
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIBImMm+XIZvLjQAQ59T6vfsejnX0b3UR02HLl7ZN3A=;
        b=Ues/eTZIBHC7EeoRNBTa4W0UmEssVNDqpKxEDuxmh5rkQMB7zUY8revd/+31B1+taz
         zuIA9lYPsHJ2jXazzFWmki8JczqAphZgbWpN5YPY6bpI2iDGs2cAd3B4eNpZ1nKCgLUd
         PDeoSO3i4C+vyQXQQbgcYUNDV/TPiZZR40H5gB95bCgLW+J4uO12OGMAHv3Yi2D438Tq
         FJca6x/DpAUx+ZjNYqGpyOFG2Z/r0Wn/5PytIZgH6uPWbM9D/hfQQwxOgqk4Ocq4H2Y5
         7FHLXDJz5pUnbSSuCmxXZ6B39ri62ugk7vA3rv/mIF8Ez0nTKM9iS7SmWfqpk1opf8TB
         UjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIBImMm+XIZvLjQAQ59T6vfsejnX0b3UR02HLl7ZN3A=;
        b=loyWcMXNNO8YdQ9ciY8jQC/8EG4u0fEjJEKuKdj76rY8O8/rYMPuojbkBLln6UKxmq
         +Vjbq3KqYvQYd5jRnXekTSEGw+hj/LY3zUxsvfc+YPOxiB90e5cWzSAw7nkulhzbYehI
         paEnuavDU6oNnygK62iU967iRndzn3v36xX8SPspr0C1U/vwc0VnVlUrIy/sZoaNj85B
         VR6W20OajxId+oPIUezLh8a+zicu78RFyTgGg0V+Xmcnc0CYZ91XV+YqCdEdTL4MYQXk
         ZfTTYXDJW0oL0KvkEkyr1kXAKz//wt60lWdoIIIBwG8M8K4vwGjV01EvAGzE7DJfr5V9
         H14g==
X-Gm-Message-State: APjAAAWoSQgyXYYb61QQrGn9rDFQ6/rmiRHoHFkS5FqWKv+RRgs3kCku
        JdcT7ZpvzONec4Eflch+/t5CwA==
X-Google-Smtp-Source: APXvYqzD83Lj53/ZpJNf4T/Qth6IzoXkqU1E3u7Zp02eWKFEn6XCkb8qlxN2FzdTw82I+6iw3vr4IQ==
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr58510861qtn.215.1558463495628;
        Tue, 21 May 2019 11:31:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v22sm13916299qtj.29.2019.05.21.11.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:31:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9Xy-0004Dy-Qv; Tue, 21 May 2019 15:31:34 -0300
Date:   Tue, 21 May 2019 15:31:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH for-next] RDMA/core: Return void from
 ib_device_check_mandatory()
Message-ID: <20190521183134.GA16208@ziepe.ca>
References: <20190521070507.16686-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521070507.16686-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 21, 2019 at 10:05:07AM +0300, Kamal Heib wrote:
> The return value from ib_device_check_mandatory() is always 0 - change
> it to be void.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/device.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Applied to for-next thanks

Jason
