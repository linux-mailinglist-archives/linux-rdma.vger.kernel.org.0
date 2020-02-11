Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E04D159894
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgBKS1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:27:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34660 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbgBKS1E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:27:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id c20so5067284qkm.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=klj0lu1+IZ5J3eWSHjOWgGDJfMxMhG6unixRuvazuXo=;
        b=UuErMkERKxnld00i6cmnqa9b70RJaywo5kWpHWP+Io5ddY1uJk2J5a5/QW3ij0LPMi
         wWbvp9beOxNZ0OOTi718gb8j4Z5H66yoynVJ8/+5IlRHw5yTXtXmmZUWGrsBDvS+Wyo0
         Uui8P9kCxyb7FFYv/Vj5j8ODoaJIM9etGT8Ery6d3ykLP+weUKLHmWmNA2YZobtccJGZ
         b/8YFV9MqTqhuBUKVswOwEKyD1w0lb7QLVnwKSyxLg+eaTBSbyivo7LA2rCPYzi61LJb
         nqgN6h5tLbQ6vRP9WTUwUwCc9zAJUcpBpRu6jrPydlM4yW1CXrIcX6LXpVNqJUvDAyiT
         3BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=klj0lu1+IZ5J3eWSHjOWgGDJfMxMhG6unixRuvazuXo=;
        b=cj/VJcz6XN8aFnx/AolZjz624cv/xcBPy/DZLHzErJpnyoWC9OqaJ3uViDyRHM6J0N
         EHyvhCW1NwmbRxW79m1ZQEMfZ854Zk3O79j++eGu3NCDRs7iePcTB7zlFbtGhjCkiPJA
         x1dvXUKQ67NTrqEfKLWiqypq8ZCmYH+EgqDA9sRWYmXvTBnQg3P4TAvNsfDzD8i7Aev8
         XZeNG/SB+E/1hq58bLfd1heub9JNQqKrr5WLrxuUazwizf/Szzjkml89MZb/Hridhz9+
         WE9pLFGZjnTOfhVS+yzC31HuOwJ8YFDOI1qMBQYJSzzGBdUDBESvhSK3/YwLUbdPfBYU
         BJYg==
X-Gm-Message-State: APjAAAUr3Z2BY7uwBYTxLg7Voy5a3nOD7rGteoA6JFZiPTQjfT83+H4n
        ScWJ3c1hshPaMXwjmKzYHpEYOw==
X-Google-Smtp-Source: APXvYqysbsuCQ4gl9PIjunjhHxZq8vrsaUzRkkZL8KwLvVjF0JIJdfnLwVmQ4lrtXhJRYl9vzdqGuw==
X-Received: by 2002:a37:4b48:: with SMTP id y69mr7556542qka.216.1581445621846;
        Tue, 11 Feb 2020 10:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r12sm2342708qkm.94.2020.02.11.10.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:27:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aFQ-0003Wq-VV; Tue, 11 Feb 2020 14:27:00 -0400
Date:   Tue, 11 Feb 2020 14:27:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Optimize eqe buffer allocation flow
Message-ID: <20200211182700.GA13539@ziepe.ca>
References: <20200126145835.11368-1-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126145835.11368-1-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 10:58:35PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The eqe has a private multi-hop addressing implementation, but there is
> already a set of interfaces in the hns driver that can achieve this.
> 
> So, simplify the eqe buffer allocation process by using the mtr interface
> and remove large amount of repeated logic.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 481 ++++++----------------------
>  2 files changed, 108 insertions(+), 383 deletions(-)

Applied to for-next thanks

Jason
