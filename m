Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63ADC3725
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfJAOWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:22:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42005 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfJAOWu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:22:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so21774152qto.9
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MF6eOLSLZ8lwbWG8kHX11tnJ9w5DbfOJryC7gC6tu+Y=;
        b=JZWEOgJSU7Fx6SLt3budYwiLekuNd2lvYzBAbo/OTSoK33XqU1HuehvvmXKU86e253
         ZKWxfLcHi9/k73ea++stko6L/JZHCcKz8YVtTsTiQb3C5rZ4+OGWAqGUYSasb9IFO6pM
         C4kzizWQmadlsp93QG3U05edgO8RIhbDM6Op+kUpzYxM7poBRpOpLpJI0qUBsztDPixP
         3qZKIwPhfxgkrGN9BWELMy19mPrvoBsntb96SporvMkqdaQLsJ/6LPslzCKvP4QZ5lO+
         Tatf4y/77zSccEojIvN+bnKrq3ycSYfWMMluVEKTHnqbS46iYW7e4B8uaiLhQZ2FTXWK
         AOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MF6eOLSLZ8lwbWG8kHX11tnJ9w5DbfOJryC7gC6tu+Y=;
        b=BrpT+XkRvFwDs+Th19IAUUSL0fwMc83I3tG9HMQuhSPZFYnvFvGfq4guhI402/pRGA
         bgLT+1GgB7MtNCVRtB4UUJzAecpAqMMHE2cIMHRWfHIp+36umqVs3fHqs4NZpMfQ8a0Z
         hQknNrajTJ4F8KY8+oJEl9VHGzD/Y+t+0PFMInJP8KvQRU93/tTSo1Zj5K6iEnNDfI3Q
         flNasLIcJVKomo36tt6aWSXf4DCM3JPEHV8Wem0JKEjM2fjEKEagIhACuhr0grMUQiBH
         rMlHnerwoPMHz6lmM6U3ZTJxbQIPSDoOGFNLiVZIkFam0Ge3ZrUi7naYaILLYKmfl30L
         ogLQ==
X-Gm-Message-State: APjAAAWR45F3Yzn53ecbUddYU8ccIUFsnjHdhFD4rbqT8aDzByyRT6L6
        SUH7hjHCVvXk9XslRa4hT/pimLBYBFA=
X-Google-Smtp-Source: APXvYqyqoB19+HnoPlA++EAgwxU3Ps0qnlW/M2Bnl0bixfwROn1NKyQeuz11JwKOelqNvbeSffiIGw==
X-Received: by 2002:ac8:5399:: with SMTP id x25mr30748186qtp.144.1569939769300;
        Tue, 01 Oct 2019 07:22:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 54sm10324380qts.75.2019.10.01.07.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:22:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJ3A-0000rW-6o; Tue, 01 Oct 2019 11:22:48 -0300
Date:   Tue, 1 Oct 2019 11:22:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH 2/4] RDMA/counter: Prevent QP counter manual binding in
 auto mode
Message-ID: <20191001142248.GA3219@ziepe.ca>
References: <20190916071154.20383-1-leon@kernel.org>
 <20190916071154.20383-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916071154.20383-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 16, 2019 at 10:11:52AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> If auto mode is configured, manual counter allocation and QP bind is
> not allowed.
> 
> Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration support")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/counters.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied to for-next
 
> --
> 2.20.1

This line ended up in a weird place

Thanks,
Jason
