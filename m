Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755F91A8A65
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 21:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504569AbgDNTAR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504568AbgDNTAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 15:00:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69BCC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:00:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so6481007qkl.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=90Tgv69rBj5juCZjgOb+Srz2hKZI/H0KVL8B8b7TvMk=;
        b=FeAKYkkGz+R8EZASeqiStlgiyXnGmRqif8sybwMCa0eNM1nhCt5v+mprE1C0Rkwgum
         9ahqXOAkrcKfpSh0f3mCjoFu7e+y/xdn11ISeXZdQe5tlzvAmAuBSxVoBqVZOibUxyhQ
         zWqpGsvRvUgv/G0rLECBUpNkFU2Vf51QqbtDYfSynM+G6df7R6XHN0zh20uzywcBZ1cB
         c6fgFs7TemF0OiuEqzr9Pvxi8VVVfkGK5XSO0CWToYQCka1nuab9dB6UYre2wBppjs/H
         GdgdbbKJ6RXqXtj/9C8eYJ4l6vl8NpaFvvEBwYLOsqkl0M+KGe+wDhy7CebMSFSVPg57
         Idvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=90Tgv69rBj5juCZjgOb+Srz2hKZI/H0KVL8B8b7TvMk=;
        b=Ftn0bc6vymdD+zrKGEqAagY+uIQJ3Euu/igMDFAwC1McYHb+Nzzz2FQ71e3oxd7y8f
         EVxIGz1fczlDCv4wjj6k8YOEz+HGU9U6DK+V//hKZjjqpKfEDn8kiyZsFM9zi/hDeJzC
         IJyZfZLbHrooKJj94D4ATr5H/9KpfH3ru1sgtPTqnS7L47BGDmzaXpUS/sXsKo7HpYhB
         v29y4hGmSjsX49CEPlBf0CXhUqg+X5Drqwsb5buF0W0tmYKF+jgV0aKS2rHvUVATIc0j
         Lvq7TA+pMnElB1q1jH8c9JLtsFsu9YhpprlQe+dL1A7POudicZqYUsW5BkqrYYTYQceR
         X8Xw==
X-Gm-Message-State: AGi0PuaCPAwNJfUeKySblYFV7eyOga0KkrbDaJ9coSK/ZbcgWcZrQ7Sj
        nbNDLco9BFTI8oJ5AGpeWuH8vw==
X-Google-Smtp-Source: APiQypJclVKXcDWr7YTnZ9PWOPSWc/RKa771cCWQxkfdLF3rzNN9madTFWJ1N6DXgcZ/vNzxQKvhpg==
X-Received: by 2002:ae9:f70a:: with SMTP id s10mr11094189qkg.313.1586890811021;
        Tue, 14 Apr 2020 12:00:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r128sm11096283qke.95.2020.04.14.12.00.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:00:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQn4-000339-0o; Tue, 14 Apr 2020 16:00:10 -0300
Date:   Tue, 14 Apr 2020 16:00:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Amir Vadai <amirv@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Set default vendor ID
Message-ID: <20200414190010.GA11664@ziepe.ca>
References: <20200406173501.1466273-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406173501.1466273-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 08:35:01PM +0300, Leon Romanovsky wrote:
> From: Zhu Yanjun <yanjunz@mellanox.com>
> 
> The RXE driver doesn't set vendor_id and user space applications
> see zeros. This causes to pyverbs tests to fail with the following
> traceback, because the expectation is to have valid vendor_id.
> 
> Traceback (most recent call last):
>   File "tests/test_device.py", line 51, in test_query_device
>     self.verify_device_attr(attr)
>   File "tests/test_device.py", line 77, in verify_device_attr
>     assert attr.vendor_id != 0
> 
> In order to fix it, we will set vendor_id 0XFFFFFF, according
> to the IBTA v1.4 A3.3.1 VENDOR INFORMATION section.
> 
> """
> A vendor that produces a generic controller (i.e., one that supports a
> standard I/O protocol such as SRP), which does not have vendor specific
> device drivers, may use the value of 0xFFFFFF in the VendorID field.
> """
> 
> Before:
> "
> hca_id: rxe0
>         transport:                      InfiniBand (0)
>         fw_ver:                         0.0.0
>         node_guid:                      5054:00ff:feaa:5363
>         sys_image_guid:                 5054:00ff:feaa:5363
>         vendor_id:                      0x0000
> "
> 
> After:
> "
> hca_id: rxe0
>         transport:                      InfiniBand (0)
>         fw_ver:                         0.0.0
>         node_guid:                      5054:00ff:feaa:5363
>         sys_image_guid:                 5054:00ff:feaa:5363
>         vendor_id:                      0xffffff
> "
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 1 +
>  drivers/infiniband/sw/rxe/rxe_param.h | 3 +++
>  2 files changed, 4 insertions(+)

Applied to for-next, thanks

Jason
