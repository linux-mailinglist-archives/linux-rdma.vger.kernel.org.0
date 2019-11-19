Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E055102D2F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 21:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKSUEE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 15:04:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34756 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKSUED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 15:04:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id i17so26107053qtq.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PodOj0qUviilSXm7iODX+8IMAnaDn/ZQM+tJUjz40F0=;
        b=N3gB6KPC5yfTt7UXsDpEALHuOVeURjUtaiMipAVjDXBoVVopYPBt9l5qb7XzfAVv7p
         vMocNBuh6ae1ZUyKgv40FJY8eqJnmX5ycTzGRH9r28NdVGJQZX3Ze7IvKRHod8VZ4Usq
         u4rmOqZZ1YYnRNZ80uV4aGX5ee/7lAI/NS7je2bAS2RZz1NwcakRQ28U5jzZEMO+3ZEK
         w5BucGj4THUDcc+IT/pGtBesEb6PhkiSRZX9TX4hwmWChRcycIVvg7OfZRjmUuGcQGAw
         2SHZdKf4UIpvUgvXA8EqM33wzr4NyH/qIrfXzdsj65IDw8OxatmgOwVpNNa/v+m++0gL
         sD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PodOj0qUviilSXm7iODX+8IMAnaDn/ZQM+tJUjz40F0=;
        b=oNGeQlxq14Kw1bPgk/53S4lhOH/Roio2mjLg9ib7oY7sUTTc37Ia9E7m2l3fCnbovR
         lB1faazYEnsntS0xQ6MBvw5ll8FelHBNcR9cCK5HLpHgLHPA0XZbS3VKl6bcdyNSCXUC
         bQu/yrppcqgCSFMYDWZGF7/YvR30zL2MNGkGYu5GyiWazm0G6C+lePI5HjYVgqXm7PUH
         Op2hjEQudvtqmHxhyAHTo28qOq3gbVmp5UxXyhrPU/5CGMdJxSXXHGYuCDayxFeMmbX8
         XhmVDSeiKVN4NzaqrgI5Xdu5t4G+54nKMqQQbJnyGIQpd6AfpYZMpNL0ueXVQZygkOVV
         v2tg==
X-Gm-Message-State: APjAAAURdQOvLN5ycCz/wtz/1UF4ryWIR+hQRdRaG6lnmelQJmpV5DtL
        yYAQGg2kWr4ek+USWv6N/sJwMK5CofA=
X-Google-Smtp-Source: APXvYqwhraNr+cpuQMo1XOwkrlx0+Oj8S4puu7zNQJTXXXyvy8xrJtwNBZUOamjb5KS688vQQl+FFw==
X-Received: by 2002:ac8:1410:: with SMTP id k16mr33624924qtj.27.1574193842880;
        Tue, 19 Nov 2019 12:04:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h186sm10664968qkf.64.2019.11.19.12.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 12:04:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX9jF-0006Uv-T0; Tue, 19 Nov 2019 16:04:01 -0400
Date:   Tue, 19 Nov 2019 16:04:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx4: Update HW GID table while adding vlan
 GID
Message-ID: <20191119200401.GA24934@ziepe.ca>
References: <20191115154457.247763-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115154457.247763-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 15, 2019 at 05:44:57PM +0200, Leon Romanovsky wrote:
> From: Danit Goldberg <danitg@mellanox.com>
> 
> While adding new GID, besides comparing GID and type, compare also vlan
> id, so vlan GIDs will also be updated in HW GID table although they
> have same GID as the default GID.
> 
> Signed-off-by: Danit Goldberg <danitg@mellanox.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c    | 9 ++++++++-
>  drivers/infiniband/hw/mlx4/mlx4_ib.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)

I'm going to apply this because of the bug fix, but this design in
mlx4 looks wrong to me? The core gid cache is supposed to manage the
gid table completely, and the driver should not be doing searching
when the core says to change a table entry. What is going on here?

The core code already removes duplicates

Parav?

Jason
