Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E071475137
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfGYOcS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 10:32:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36762 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfGYOcS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 10:32:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so36554057qkl.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ICNqjCM6BTk0YdbaUQAN22wRCFc++MdqOWy7YbXCHPM=;
        b=ca4dKT1VkMiyi593db759K8yuIsRrp2QKQmVIndy1m5YU5QgQZSDKbirT5mWMZ9CO7
         Cbd9U9m4zUD2IXcakLbJXC4iN7q6hD1DH67RiDJLsuYHcc0UvVDRfIeX7F8NPtiQzQOS
         P2BkSy6AxlwhtH+mfXkANQNlI7/B8UcGJuknBZapGE8t2a52m4sAWOCb+G7b1fszFvHX
         KxVg9FLi67c63QnBFnQEhCLfqdVhZ89Z6a6x8238NbtULX4PK5SBoqn5NovoB7zDp0pi
         epi20FIvS95jJoxWWYq5gN6jQFc3t69nuBUnuJZj3uzlUSkGVZEXeAjzpNue1mhJkAR6
         hkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ICNqjCM6BTk0YdbaUQAN22wRCFc++MdqOWy7YbXCHPM=;
        b=dq8yCSeaZ88L8OrpZC9gDlcUmISqS8RHU+XCulvd/kFFzrInv5DZUdf56U3Dw1m8IP
         iIKlAJg9RCpzREwhgpQG4TuKxCCmfbNXqYAxCcQ2BZEcQQW8wWNT6wM7utH34DWZa2so
         6Z9i0/ha7HFvDsijIjCz+6XyBD9Rown9ewoauomC5gWrGD3gp1mYzb+/zf6UQG9xPTqc
         qL9iIqnEVKnJ+G5uAB5r0YYWmUcITqrk8z7QH8pksDk2uhrAyStkZ2/v6JW/0eYmC92Z
         Tynoj1Zy5bidUAkQA0aRaqrzo14A88nC6A6hc7Q1LUpv2HQPYZJ3ftGiBy7/Dtqr1pfs
         3hEw==
X-Gm-Message-State: APjAAAXvi/UsGr1QGr7AUyiMzTgjQo6Bex4zxzyD+DGjzCW0xzosaeGM
        0aDjMJEVPtYtkjof7uhIDDHe4g==
X-Google-Smtp-Source: APXvYqwuvzaKrcrsDhMpQ8dMHToa/cOUbIjDnDvh3gbcHksbADU30nYhauaKoISOLDW6HwzltSuxhw==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr59326285qkg.51.1564065137619;
        Thu, 25 Jul 2019 07:32:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k74sm25187210qke.53.2019.07.25.07.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 07:32:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqen2-00047M-6L; Thu, 25 Jul 2019 11:32:16 -0300
Date:   Thu, 25 Jul 2019 11:32:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 10/10] IB/counters: Initialize port counter and
 annotate mutex_destroy
Message-ID: <20190725143216.GA15793@ziepe.ca>
References: <20190723065733.4899-1-leon@kernel.org>
 <20190723065733.4899-11-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723065733.4899-11-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 23, 2019 at 09:57:33AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Annotate mutex_destroy for port counters during counters release
> operation and during error unwinding during init flow.
> 
> Also port counter object should be initialized even if alloc_stats is
> unsupported, so that other QP bind operations can avoid call trace
> if they try to bind QP on RDMA device which doesn't support counters.
> 
> Fixes: f34a55e497e81 ("RDMA/core: Get sum value of all counters when perform a sysfs stat read")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Reviewed-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/counters.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Don't put two things in a for-rc patch, I split it.

Jason
