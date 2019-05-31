Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2531518
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfEaTLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 15:11:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44283 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfEaTLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 May 2019 15:11:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so2177315qtk.11
        for <linux-rdma@vger.kernel.org>; Fri, 31 May 2019 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgYbKJApp0nEJKVXjdXddAaP74wwjBOcIbnpyinSdxA=;
        b=bLmKCp65t4u088eHtkgsteMVLgqeGR6EcoQt3865M+lYaC0agiwzZL68cUsJfpaw6r
         T3cIp1GjCYSaT9I+JAz1t/Dn3Vh+tt7RihqcP+pG5PO0ajs2+KOo4y1n9Lz+lkKk9+So
         4F1NdUu5StDh0CrNoTWhZQ2rlOILhNB53rLxlT+yhoofAWfx7yXfPJ3mkhXfelmT+XrV
         fyZoeMsvDQsz3P79YzGd0AYSm9N/b2yCgyRyRGBVQYlPTDJdPRt4fKp9AzfCbizoE9J/
         mFDzVjmD9Kc/tWW38jC5InpW/9/FoW4yE3GstnfSxmmcgTBmKRakb54o+c4TPtT0a46p
         XyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgYbKJApp0nEJKVXjdXddAaP74wwjBOcIbnpyinSdxA=;
        b=GY++X78NLr/rcweTnr4fUfF/S2NwIJC0R7P8DjMnXDbMOqbp5QOraSz9O3Hydez4QU
         GAHA+z9UrJGUU1fVRZcAlEj98xZOWXIRko5VtWVBadeiXtJsdwqr8Jcdedapqw8jI6JZ
         rpYfos3K13OUWvVY9nmYvnNxnkzMSSC/5beXP79fKWweghvROfNkdO24yVYladiJHkhr
         hPtjfEDy3AD8Lty1AhiCNmA+zQTT58oviANNmls8J2EGxfR2dxEi2XKQX8+1r/wpnuP5
         iKJiNBqRdQWG+7AUWmdxLfv+Sl9HDeDWGKem+4Ml7wzGqwIcb7Svg3dmCsIIya4IoKkF
         zZIw==
X-Gm-Message-State: APjAAAXJ6TO5G85SlYZ1G0UZJe8LIMsgaVNs9RaMficUIngK4hwMczx5
        JTm7ZkXTEExNt9eFCvGpDlMrYdO5pkE=
X-Google-Smtp-Source: APXvYqym9+irSV5qAppbF8jlQtwxhN14yrUhQgtXoS25hR7CclJfmE2tYm90Y4N5rENHf871KU+H3Q==
X-Received: by 2002:ac8:13c4:: with SMTP id i4mr10402980qtj.63.1559329898642;
        Fri, 31 May 2019 12:11:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s74sm1283463qka.91.2019.05.31.12.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:11:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWmwD-0006VM-B1; Fri, 31 May 2019 16:11:37 -0300
Date:   Fri, 31 May 2019 16:11:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Consider the bitmap full situation
Message-ID: <20190531191137.GE8258@ziepe.ca>
References: <1559298484-63548-1-git-send-email-oulijun@huawei.com>
 <1559298484-63548-3-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559298484-63548-3-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 31, 2019 at 06:28:04PM +0800, Lijun Ou wrote:
> We use a fifo queue to store srq wqe index and use bimap to just
> use the corresponding srq index. When bitmap is full, the
> srq wqe is more than the max number of srqwqe and it should
> return error and notify the user.
> 
> It will fix the patch("RDMA/hns: Bugfix for posting multiple srq work request")
> 
> Signed-off-by: Lijun Ou <oulijun@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I squashed this into the last patch, thanks

Jason
