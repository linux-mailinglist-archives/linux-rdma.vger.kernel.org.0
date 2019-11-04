Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7638EEAA5
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 21:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfKDU7Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 15:59:16 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36615 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfKDU7Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 15:59:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id d13so19076975qko.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Nov 2019 12:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+vMMxPE1zexTcBhTUQBjEnFM7QQdjaq1YW9R4l5ACA=;
        b=nvMSvlw7biiZ1pfK6nWpGeRxjb/qLlEauXWsgVsLny68w5JLO2+t2ewQPQN3UIteT1
         9AVnanYTlL/rrDlez5ywA1Kaa/mczmwuDWP12nBYhMuz7Nmm8w6lnnyd300GrRTqIAo1
         7nDV1Iqkm3knt5ctGYIZhW9CAXLKCduL7zDzAZ7iF27wNUkRDUQpN5PLka1RQqkU7+sp
         T6p9nUtq3wLGv9ktG6iWDlFLOz+2/STeW7loSzMyFrYmNCxmyP+D5bE7mw10kLZ5shg+
         1SeWkIvK8IIyrBK6CSyqaSXqhcumwxZw764yIfljS491asYLDOKsdG5XP4jEnrf91XN7
         aCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+vMMxPE1zexTcBhTUQBjEnFM7QQdjaq1YW9R4l5ACA=;
        b=T2wT7TkOwZ+gg/SmrS1QuawH8EUgDzEccvJ7MgMDzu+g3YJrc1X4E/SZ1ydY84CXuk
         qn5fXrhXOv6L9rgaajIzDvvFr7Z6XhG7bjl+oafQcXe6A3Q0+T7W2JhnhNsr+tgPqwJ5
         Ug650RRnl7wevFhwpHeqSx5+FQtrBAMZM+S0WB18lvRNrQLNHFZxu326MnIwjY350hoy
         W3nMUFtTZElfh/mz5Ve1Xn05Q1AiJCVgeLXHDfMlLMKePcpodzuUOm6k2AwSZ4x3RD7X
         8TJXdMaQQdFIlrpRjMjXof3JAfYDfxRyp2RXnFOf/oCg3PiZWZdgArIppsUl9NLbhMqW
         21dA==
X-Gm-Message-State: APjAAAWVBzj27P3IU5ohh9pSzidx4mU2Ip4W78oERno3VMkvKsjTwxf4
        e8WAKHEJyhV3kfbfOfmw86q6FA==
X-Google-Smtp-Source: APXvYqw06wJFhqmxOjr9eue9Dc9+rxRZAZhQ7+cOKahyrSjjB8BXMcXir5KPt1owPT+levPxyNpcow==
X-Received: by 2002:a05:620a:5e3:: with SMTP id z3mr1237806qkg.160.1572901155408;
        Mon, 04 Nov 2019 12:59:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q1sm6435433qti.46.2019.11.04.12.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 12:59:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iRjRS-0000aI-FF; Mon, 04 Nov 2019 16:59:14 -0400
Date:   Mon, 4 Nov 2019 16:59:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB: mlx5: no need to check return value of
 debugfs_create functions
Message-ID: <20191104205914.GI30938@ziepe.ca>
References: <20191104074141.GA1292396@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104074141.GA1292396@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 04, 2019 at 08:41:41AM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  drivers/infiniband/hw/mlx5/main.c    | 62 +++++++---------------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 +---
>  2 files changed, 16 insertions(+), 55 deletions(-)
> 
> Note, I kind of need to take this through my tree now as I broke the
> build due to me changing the use of debugfs_create_atomic_t() in my
> tree and not noticing this being used here.  Sorry about that, any
> objections?

I think it is fine, I don't forsee conflicts here at this point.

To be clear, the build is broken in your tree and in linux-next?

> And 0-day seems really broken to have missed this for the past months,
> ugh, I need to stop relying on it...

Yes, I've noticed it missing a lot of stuff now too. Not sure why

Jason
