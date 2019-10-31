Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50E11EB7B1
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2019 20:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfJaTCw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 15:02:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34542 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfJaTCw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Oct 2019 15:02:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id e14so10026105qto.1
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2019 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hFtamFGnMkFJgVuRpLTeeHxlRIZgJIb4PUnS2wd14q0=;
        b=IB1HraDHOiXpMBJskMnn585/wXT4BDc56s6LJK5DQ97j1dEXF+pdXWEF22Eh98s4ho
         A36VVMqAb9rGdAyxuFOtMiJYFevKhDUKxFgI529sNZuZT8oYaxBFlnViMW9X7EQgQdOd
         Ie3p7Kz8RYgbEGXYrNf0j9ukkNxZUlo8hyx0aNmRxMdJ0jmGijKpEo3Elnd8CpfTQrjE
         XdjmxQoRMv9Xs3F4xS1Mjgzi3NxDFWGUPgSXpLIsZ6UEREpRYZv/VAKvM7DrroHnaYsL
         a12eAv/VT6K/ZErEyAT4yoY6BlWW7KbYM/Wlj5gDdvjODIcrAzXGp3XIo095crz7j/CN
         QOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hFtamFGnMkFJgVuRpLTeeHxlRIZgJIb4PUnS2wd14q0=;
        b=ATIkZp5AICaIaWK8TwDK97PPtObWMTEt1fZYGgBTMNbFZiGoUIVNnAJ+pDjuohZQQb
         0RfUObq1UfWUqePfHjARSQcbVHreRkeZ13HoJfBkBgJOOIo6bj5vtoncC4k6WsC1FFeD
         rTUwJJyx0PIXpzUOGYb5MiSe4vScsX8/NRoM6cpCEBazA9jSL0L7KTPd+FfJ+Qm/NC8U
         KoI02Tid36xI7bj3lcbvXD92IiijQuSkhD7yCS6cGHO7R/rBDmCQPkEhzLKdbWhvpwWx
         7WTOeyF7QUpXToJNBu6x1OhTpzcvYIsOkJ7xUblgTqZaWqkmBZocIfPIhVhmn7icN6+g
         FhSw==
X-Gm-Message-State: APjAAAWylyI/Sv0WsA40xuIypmFrRuqeVNG7mPcOQ8dJ4dbD0mxfFagU
        G6oCZEDesuUkEi9621vRDTFeCA==
X-Google-Smtp-Source: APXvYqxaZ1btUZDEppNxm3RiIrRgXW0Kwdqrnnvv6KHy0yZJxvvnhSeolm+XvruyV8UqR3StEfBZMg==
X-Received: by 2002:ad4:5447:: with SMTP id h7mr6201249qvt.188.1572548571038;
        Thu, 31 Oct 2019 12:02:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f131sm694113qkb.99.2019.10.31.12.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 12:02:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iQFib-0001WH-RS; Thu, 31 Oct 2019 16:02:49 -0300
Date:   Thu, 31 Oct 2019 16:02:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next v1] IB/mlx5: Test write combining support
Message-ID: <20191031190249.GA5707@ziepe.ca>
References: <20191027062234.10993-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191027062234.10993-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 27, 2019 at 08:22:34AM +0200, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@mellanox.com>
> 
> Add a test in mlx5_ib initialization process to test whether
> write-combining is supported on the machine.
> The test will run as part of the enable_driver callback to ensure that
> the test runs after the device is setup and can create and modify the
> QP needed, but runs before the device is exposed to the users.
> 
> The test opens UD QP and posts NOP WQEs, the WQE written to the BlueFlame
> is differnet from the WQE in memory, requesting CQE only on the BlueFlame
> WQE. By checking whether we received a completion on one of these WQEs we
> can know if BlueFlame succeeded and whether write-combining is supported.
> 
> Change reporting of BlueFlame support to be dependent on write-combining
> support.
> 
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog:
>  v0 -> v1: https://lore.kernel.org/linux-rdma/20191020064400.8344-1-leon@kernel.org
>  * First patch was merged, resend second only.
>  * Changed spin_lock() to spin_lock_irqsave() in post_send_nop().

Probably this should just be spin_lock_irq as we are definitely not
already in a IRQ or atomic context at this point.

>  * Updated post_send_nop() current position math calculations.
> ---
>  drivers/infiniband/hw/mlx5/main.c    |  15 +-
>  drivers/infiniband/hw/mlx5/mem.c     | 199 +++++++++++++++++++++++++++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +
>  drivers/infiniband/hw/mlx5/qp.c      |   6 +-
>  4 files changed, 223 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
