Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5452C393C2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 19:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfFGR5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 13:57:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41914 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfFGR5v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 13:57:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so1795546qkk.8
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eah0lY26nouX6jt8kDz/kbBB5NIsRlLHybJGkfwuHUU=;
        b=l7QdhA2zAexmCT8J3YtIfSQtKsEDpkONNlD1mnbvFt2M2psEiAP3rmijzZwVZbYkhE
         94YYbo8DJrrmOHxUUov4NMZWX7ihRN5zTPww1yXboP8LKe31YCkSrGa7dJm8sQPDOWjS
         s25u9b9HHpuXvhOWh8nQvzEvic3tjyTwGxULs9BhGlBaqM7xfRWC5gA+8byHdWXxJKES
         +nsvCWR2l9Otj92Dg7S990sQ9HSJwI8l9qs7Jl3CUUaPrYT4Uc6/PkExcaNdegGRog8i
         DVY/1b0VpH4mUaeEDBtQgT8hi4WePDUnmXEXakcCSAY8znaEucGjBeaYqN9mYpOjtsX7
         bCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eah0lY26nouX6jt8kDz/kbBB5NIsRlLHybJGkfwuHUU=;
        b=RwC9pE/aSnovPiqvATNZPyO1F6ig+fbaejsXJOXbXJL1SHxidzMHz2Q0AVrdUMpXcC
         m+3cJZbSXsu00obXdqPFWE7OJ8zTUZbe8Hpcj3oulWwaWZTqac/RY6iKVPzurLJMJV1O
         FacC9Yv1gmUqwa9foXZCyCA9uBVBwheB4ZV+DCgN85ryxL1arE7gIPdxuWWwaq7jmLxb
         xwYU81wdgtx80/0JOXj8Jhzv+cIs5RkZlDmiYmE0dst0d0uE2i3rEZvcREK+56gcLOqi
         MH9ll/B9pe+IiBbUalJEHXwTdZpgTxrRCbw2aKX0YOWibpu0f5bms8JFGUoc0shLKiIk
         D5HA==
X-Gm-Message-State: APjAAAXtnrb36TnpQpq3mzXPDBffdtWuX8LrnLNqgc/svExrqXpEtJZA
        R3t9LIpCy4/l4afrP71rXn9Nhg==
X-Google-Smtp-Source: APXvYqx2b15MJDyfu3+q8xD+p4RRDwVFsKwGnnXkd4dB1jA2NyFGRpu375PpC/+/rJdRwAxb/Gmycg==
X-Received: by 2002:a05:620a:533:: with SMTP id h19mr45133556qkh.325.1559930270129;
        Fri, 07 Jun 2019 10:57:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm1569499qkb.41.2019.06.07.10.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 10:57:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJ7d-0006Wl-Bm; Fri, 07 Jun 2019 14:57:49 -0300
Date:   Fri, 7 Jun 2019 14:57:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][next] RDMA/hns: fix comparison of unsigned long
 variable 'end' with less than zero
Message-ID: <20190607175749.GB25014@ziepe.ca>
References: <20190531092101.28772-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531092101.28772-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 31, 2019 at 10:21:00AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the comparison of end with less than zero is always false
> because end is an unsigned long.  Also, replace checks of end with
> non-zero with end > 0 as it is possible that the #defined decrement
> may be changed in the future causing end to step over zero and go
> negative.
> 
> The initialization of end with 0 is also redundant as this value is
> never read and is later set to HW_SYNC_TIMEOUT_MSECS, so fix this by
> initializing it with this value to begin with.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 669cefb654cb ("RDMA/hns: Remove jiffies operation in disable interrupt context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c   |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

hns team: Can you please comment on this patch

Jason
