Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F6626BF
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbfGHQ6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 12:58:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37795 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfGHQ6h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 12:58:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so13852686qkl.4
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Ebyoxq/yn+DRjEU74h3naMVVQ17vsFmrjVrB5vr7B8=;
        b=XcgeHnse3Si2wTlq+Rk3mfqIfyHt8lSo9WF3Ye21psC0X/7EtD5+fISJKFaCIrRXrZ
         w0bkWGw88++TnELZn3XBIQzzxeGJUZXGAh8r4AaQ/QJUzYX1r8oidbPjIWIMneQCV2KF
         flkRHhksUGDzwGFhv51tjd8chtsT9+ki1yC/tNV469Hr9qKcmv6tQG8sC1/JUVV8MUuZ
         u3J4gQd77DyRHuuE2XvRnZ5FVqW6FVIuuIw9k47ZzWQP9oMTzke0pzlKhKVPMs20EQy7
         NqhOj4Zsrcj7gSUj7A9bfNrYgNfKPPRZthnwhCehMQ0y6lwKuzbhjJFIJXJQvYY4SLLr
         i03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Ebyoxq/yn+DRjEU74h3naMVVQ17vsFmrjVrB5vr7B8=;
        b=mTU1XEjhfPVgl79753ypuX77s2LzuiwLOb8nhIcIBJB00zWZR8SHEAI9qMkFlYInOL
         C7GiVTrQJjLyCI8TYfSJX8FmH3zNRGyhJX3wQeou9QvMINuM2N45t4eP4zS8K/NnY5Jb
         /KHsTtKPPS10KGqU4kDCOebQrCDSzce5gT8Q9n/vkUaVhxXF/uz9wkOO73umhwPqKQky
         1yxCPEL0zdEzFY747Dm7M6azkxR0QqSCqSJy6P8lzqob3EGzDisMBSXWybyLOurj2FIA
         9UJxuNCtDCwRw1NoZy6GQ9f3OSPoH6TVlzKEWx+OwKgxJHFpNsvZY8wz8GhHAII+I1Yp
         iWRg==
X-Gm-Message-State: APjAAAVvgmDf/V128PGajHb/K8aTJM40l7vE9NjBygviZlXxZedwUF/0
        Ow0KxDztRDjDcLSxJeDkqWIPOw==
X-Google-Smtp-Source: APXvYqwiVoKd8WgJppn59ELRHUHd8xrASKJL6VpsuG0lJoacQvAmtko2SeJ4vsGbFTqzqjUWBf8OwQ==
X-Received: by 2002:a05:620a:1107:: with SMTP id o7mr13470563qkk.324.1562605116461;
        Mon, 08 Jul 2019 09:58:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm8781298qta.58.2019.07.08.09.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 09:58:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkWyJ-0004vs-F8; Mon, 08 Jul 2019 13:58:35 -0300
Date:   Mon, 8 Jul 2019 13:58:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/2] DEVX VHCA tunnel support
Message-ID: <20190708165835.GA18937@ziepe.ca>
References: <20190701181402.25286-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701181402.25286-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 01, 2019 at 09:14:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> Those two patches introduce VHCA tunnel mechanism to DEVX interface
> needed for Bluefield SOC. See extensive commit messages for more
> information.
> 
> Thanks
> 
> Max Gurtovoy (2):
>   net/mlx5: Introduce VHCA tunnel device capability
>   IB/mlx5: Implement VHCA tunnel mechanism in DEVX

Thanks, applied to for-next

Jason
