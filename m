Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4162BC4E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 01:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfE0XKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 19:10:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40659 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfE0XKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 19:10:10 -0400
Received: by mail-vs1-f65.google.com with SMTP id c24so11569607vsp.7
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ezp1Hn9AbIO4hckSeW5sCUSNd2N5pmPnDQddQvNKSGo=;
        b=gsqyniXyUF19E5m7ZfASYYRkQqwsEiWGcrX1exwgyHwe0duQMvMgHhjrROSH9eSqKm
         HfY+xOwrVNAe2FSV+KQGKDl51AWaeooKEBhgJBlKGYwSLTZhCKOiRxZOX96VxDyleN2c
         mS/HrTAogDyiY3afza9sJrDi7rKB8jPoh+Sfri67UBb8HoWuumrz1keCworfE5KElZmm
         AIfhTyWfi1t5Mysr0fBtzjyb5+ud3V+GnDw7KGKnxBqgkTozlZiB1gJGnXTW/m1cbIUJ
         fswxzRqMogSyA6in/9J/B844lYmtAmzkrkC94Iv0uHaeAbvwmQraJ5t5IcUVcuwOA5S8
         GiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ezp1Hn9AbIO4hckSeW5sCUSNd2N5pmPnDQddQvNKSGo=;
        b=YUM9LhWklmrkL5N9kGlsPhzBoaoUwJHRPFYB4YtP9VF8eMRPodJW5S9TWUP1GfMA9R
         BWf7Mcq3jRvMEU6jSNA/Ge9FzXZZ5W5Y1nHDihRqL01fFxppVTksW7mcpog+9BkDaEE1
         abUk7W1mY4SAUYYBjnCVwTe47DFyDs6PD61MHV9trOKKuR+PWZT+Byrl9tBc7HyUrPZT
         SGgny79l7zE6emFtiWCzmz4KgWe7e0yYsqFr5j6pAE8STconyTXXssRTWA/x+GoHXxig
         fio2kqPE2ukD+9qpfZSPR/WH8JASxkDnUn1uOaWoe2h4uzd0g180L+w5Ywp2WMa0Fa3l
         OJ8g==
X-Gm-Message-State: APjAAAUIpka5VQ5DSwbgK5GKvf30hBkBQVp+flbgKq31IxaRl03upK9T
        mOByDM6vky2CMrS949qqU/ALmA==
X-Google-Smtp-Source: APXvYqyXbk8qBnXm89jGFjwmZfJXulmQsoFfKI1jbjPGbbMOPxp7WHfYcvwefmI02uAlama9XdnuEg==
X-Received: by 2002:a67:e905:: with SMTP id c5mr16598554vso.97.1558998609740;
        Mon, 27 May 2019 16:10:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 126sm3269179vkt.14.2019.05.27.16.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 16:10:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVOkq-000551-H5; Mon, 27 May 2019 20:10:08 -0300
Date:   Mon, 27 May 2019 20:10:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/hfi1: remove set but not used variables
 'offset' and 'fspsn'
Message-ID: <20190527231008.GA19493@ziepe.ca>
References: <20190525125737.15648-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525125737.15648-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 25, 2019 at 08:57:37PM +0800, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/infiniband/hw/hfi1/tid_rdma.c: In function tid_rdma_rcv_error:
> drivers/infiniband/hw/hfi1/tid_rdma.c:2029:7: warning: variable offset set but not used [-Wunused-but-set-variable]
> drivers/infiniband/hw/hfi1/tid_rdma.c: In function hfi1_rc_rcv_tid_rdma_ack:
> drivers/infiniband/hw/hfi1/tid_rdma.c:4555:35: warning: variable fspsn set but not used [-Wunused-but-set-variable]
> 
> 'offset' is never used since introduction in
> commit d0d564a1caac ("IB/hfi1: Add functions to receive TID RDMA READ request")
> 
> 'fspsn' is never used since introduciotn in
> commit 9e93e967f7b4 ("IB/hfi1: Add a function to receive TID RDMA ACK packet")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/tid_rdma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-next

Thanks,
Jason
