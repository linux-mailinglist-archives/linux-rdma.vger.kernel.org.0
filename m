Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE21797C0
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgCDSWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:22:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43539 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDSWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 13:22:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id q18so2588555qki.10
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39bqVJm6WCXA8xPzUQhAgAl9Mr6W6dRQSG3rhnBdT/Q=;
        b=pEima1PfWeXjYUh1N6zZFfYfPhYyeNTbjCNMk96YvyMj4JOwZ0HJmstMfAf8x8lt1e
         jvI70kWZvS1W6b3jxE4btniF13SowwI6v7E8zg3eCZK/0P2mcHkEbrckYgw/omvUjwQR
         wI/rmIwUEk4S42R6YMpo4tCDQ1bIY5i9zHURKcUXc0sG3VmTH6I0tfjZzd+qAmOCxpxV
         Oq1YfxH5jylxZzW09kZWLLDJe887krNrBHlRw97Y+CVflDIjIj9U9nZmJv6iwM/ZRbDh
         yM3D3lGxO5hx9+zvNazc5PSnG7qgaTivrO1OLWf4CqBR0gEljecFkYVkJhZs9tVNDW7e
         P+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39bqVJm6WCXA8xPzUQhAgAl9Mr6W6dRQSG3rhnBdT/Q=;
        b=O6tZN4ZZF8RtO43H2OeSciVcqgSxphkoXgMFSEmoCHcnHvXDmv2UOWmpn4nCFiQnlX
         KHuWdX/ZSZN74vcA7v57G4BuoI6UX1kZemNnUphQAWkWJgzLMlTiY5WUYQFzUpuM+3/y
         IgXFEvoU31Bw8qQnYS/Hucx+wEjZPdX0ibLxBiIuBryi7rTFZnO+VyB+1S4rP373JhWN
         qUnJA1cfd7z9axNHS8sqRZuaBI/GjAXN8IsdSZ1R5x7WTyw/pjiWr1jLiKiM9/3stQRD
         IKLNVa8BmDQwEeePk7Y9QwX2RxBJPwO2ywrtDT7RsAFMgQdQLngII5CoyLc75PKJrs7f
         d2YA==
X-Gm-Message-State: ANhLgQ3yUi5mzdsohKCTKn/F5V3xlKdtSvL4BB2Ub2q/wD5LzdQv0cBP
        unJf0xKcollObkjkPPIeV8CalA==
X-Google-Smtp-Source: ADFU+vvBLoVyrCo6V8DdWqIHKcE7yeW62Y81lUxWpBXsA1DUZsfGLDnpYXyirrSasUfjiR1ve4dqoA==
X-Received: by 2002:a37:664d:: with SMTP id a74mr3804214qkc.256.1583346133860;
        Wed, 04 Mar 2020 10:22:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e15sm10636992qts.12.2020.03.04.10.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:22:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Yer-0000Ff-2V; Wed, 04 Mar 2020 14:22:13 -0400
Date:   Wed, 4 Mar 2020 14:22:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Fix missing congestion control
 debugfs on rep rdma device
Message-ID: <20200304182213.GB916@ziepe.ca>
References: <20200227125407.99803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227125407.99803-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 02:54:07PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Cited commit missed to include low level congestion control
> related debugfs stage initialization.
> This resulted in missing debugfs entries for cc_params of
> a RDMA device.
> 
> Add them back.
> 
> Fixes: b5ca15ad7e61 ("IB/mlx5: Add proper representors support")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Mark Bloch <markb@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-next, thanks

Jason
