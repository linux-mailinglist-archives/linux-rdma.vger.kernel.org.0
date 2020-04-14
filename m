Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01F1A8AF0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504902AbgDNTf2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504865AbgDNTf1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:35:27 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B230C061A41
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:35:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s30so11290368qth.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXJFZbYBpiO58VUw07gYc4E/OSY8mUkuPUysvFQz2V0=;
        b=cQ+NRduOwAzvm2yDJN6zTbfsK8uOlb1aGIZE4Rc/HmJs9v1y/Y+g6AiQBmU5IUy32c
         RYMD7+e+H1X/23KXbEUYmLDfQGeRzDjoxcCCk08Y6ZbY4+g5OhQvPZEeWE6rJ+KctOoU
         hrOYCozcPd7hx7RgvBIF5nNkhWVOu36xMhQwa/68+sEu9iyeobI2HRYNM+PHxruCZ7dU
         z87qZOb7q2rYKTt4kqErEnVH2ySKdULeHkv/q88foeBc4Y92zQCUkNG0XH8LNqY/s3dl
         gvXnLkr2yryNImzCFGmFYhZtUKDmzpypX0wEoFa2pKEN80h4oWvdRVmeSdMgreqns+Rt
         /+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXJFZbYBpiO58VUw07gYc4E/OSY8mUkuPUysvFQz2V0=;
        b=Wmbf/E9bdZT/GMJGNMFrtcveQ8svKUyqx1CAaqWvoeIizPBj6/PFsT7JeRVm2kFLkV
         o2Hc51Yk5q651FX2tg80UDHTOAzT0zWfAd84Nv8v678rRmB6+JAjLqoHVKe58HKwPbbj
         dzRf9/TNz1cq3+TJ5FVJva6m0CVDVq8rfbzQ6fIJfVaJ3bTAmGXvC3zp0GRhC1HmMNdQ
         OZm9ZCUu/eIkvMJ3NLVloLQPAZjOlr1RdU630upRAA0qVkiDJzJTTU1xcSZl6h5R3/J2
         RPlm0mjyRZHaaCCw+29Uy3+XmKdg6XuZ/Btu2KYlJ5EwQc7/ap/B0HD2JXLWK8wRDHeV
         l3gA==
X-Gm-Message-State: AGi0PubefkkpzC44F4L+ANmyU3L6/AF/kWAy5y96vo8XINwG33ahUow8
        Zc7W8q/P6to2eCMaNsODYsfSsQ==
X-Google-Smtp-Source: APiQypLS//lWANiI1tO5rY6sUH89pCMuYW1DdkcAUQi3ikXObHpKKCSfGooh8Lyi/XQAWLm9n1+W+Q==
X-Received: by 2002:ac8:1a8a:: with SMTP id x10mr17535588qtj.154.1586892925288;
        Tue, 14 Apr 2020 12:35:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 28sm764089qkp.10.2020.04.14.12.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:35:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jORLA-0006rU-Ew; Tue, 14 Apr 2020 16:35:24 -0300
Date:   Tue, 14 Apr 2020 16:35:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/qib: remove unused variable ret
Message-ID: <20200414193524.GA26198@ziepe.ca>
References: <1586745724-107477-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586745724-107477-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 10:42:04AM +0800, Zou Wei wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/infiniband/hw/qib/qib_iba7322.c:6878:8-11:
> Unneeded variable: "ret". Return "0" on line 6907
> drivers/infiniband/hw/qib/qib_iba7322.c:2378:5-8:
> Unneeded variable: "ret". Return "0" on line 2513
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/infiniband/hw/qib/qib_iba7322.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
