Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B285FC42
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGDRJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 13:09:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37191 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfGDRJR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 13:09:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so6018813qkl.4
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PcNHJO+DyNXec7VeG94zSU7RC+oyPOojTaNMYrM5m3Q=;
        b=NUOhcMhgc2VvjDtgz+X3HvTTzzs64jPI31OsFFLA57x2M+EqRjkq9qxltyAt/v2lX1
         UASf6bT2Ii4M8e/YYD7uBlT16FlT8b7SDTMqMBnqkJQqEcxOwHYPGcsvC1135qfh6LKW
         GXOKjavuHIxAfzrBpVpFnW9vahaDo+zkw0emYF+tD5ED/duIjc07ovETa2fyKY99z5Yw
         ZxWTJMAskxaoIKry1DGBJO7AphxKvF6zA0Dx+EkR+6GU+vCZbrLuBUuqn5hhtPuGlr2M
         fo0FBDYYN3mSLwT5if0Jci9Cc7GPdCdenU05lRNX5nBT295XeGXWaPsH4aecSe8Dc8Ma
         +Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PcNHJO+DyNXec7VeG94zSU7RC+oyPOojTaNMYrM5m3Q=;
        b=EalOJ7GOFuvSg7gj7WTGoorgIfwkqlMupIaUjeRk24YzWtfLeaAiI5iMYuzuJVWhYl
         Vqn8+zggARUAFldzSrsnqfMYbF92GW+s0aAKWr5/8/DSbxPLgnUD1U5A1+V4BP/UeUFD
         muNKy6H7nB9CHvzbxwFSwfHDg3rj0lTsD17VB3+wRu9EJdfcjGZDstOI4mf2snktdan5
         UDhc/jqWrpStqSMiHLGYWQzMXgkK3hIboXuooGJLRIXr3zEEV20GHoybrHyRjhTW4N02
         kecWJJxaKQAtUlah7XRlj9ZUa7rU7kmA0Oroe0oRx98C/3i32gK/5wlPx/qndefgDg+p
         n8QQ==
X-Gm-Message-State: APjAAAWOFPOnMEXPG8imnLcMmmtG1uLAsP/B4ofmCyMp1anU6G5+07PM
        9VL7+gc7AyS3DMTv1xvvl74ZlQ==
X-Google-Smtp-Source: APXvYqz7iVDOl+wVbfiGHqys4KV4I8AKUyQu4EZ8e0hzGyC1SvXXvE4viFIcpymm9Sy4LZejqvXu3Q==
X-Received: by 2002:a37:9144:: with SMTP id t65mr37726033qkd.367.1562260156360;
        Thu, 04 Jul 2019 10:09:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y194sm1003201qkb.111.2019.07.04.10.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 10:09:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj5ER-0003Aj-JM; Thu, 04 Jul 2019 14:09:15 -0300
Date:   Thu, 4 Jul 2019 14:09:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Use proper allocation API to get
 zeroed memory
Message-ID: <20190704170915.GA12160@ziepe.ca>
References: <20190630154832.21388-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630154832.21388-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 30, 2019 at 06:48:32PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> There is no need in custom memory zeroing, because it can be done
> by using kzalloc from the beginning.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
