Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBA25789
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfEUS00 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:26:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39092 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfEUS0Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 14:26:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id y42so21687326qtk.6
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TFSJqOhgsDM0fdpdMCk1pjCmq2Tx6wGOrh0xa1uUEo4=;
        b=NR5GZG0pETSg67ckmgIxfwoRmVywPnKnZmTtxMQHKi5p1XLhACBD9ODrnnmOFIUf2Z
         XzmRFC1c8ty2ve2/KMDSS7z3n5rNNjPuTDvV4n6wiJThZ5bozVqCJNh0PTeEdiS+EqHJ
         v1CxBRhoZrl2qG9JOPdDfwgYYYuNPFuKljhg8+TAoWne48ZVuz1AESwmrrtA1jo8pq2F
         AY/4mXB8cX+sJAJ3GFrxFFE59dZvqaNLtEgv4oo7ATqTLI9oK61oAvxTZcuptXFugzQV
         9GA7yC0UQoQJYqloHq0kBycgTNXpg5zAvn6NLXTWNckTZlIXXKPUQYRtn47xib0vZd1z
         Mwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFSJqOhgsDM0fdpdMCk1pjCmq2Tx6wGOrh0xa1uUEo4=;
        b=kyCoBaCvO7zKRMj7NMw9nnJyNRYrg0e+ILSkVCxqje4kh5CdVdAqaPHQoO8tRKCx/5
         GpcfMscsVT3lNyX6vIbR/cXujylewgY4fPeyjl2LCHzxLncHMYL6tGXBR5no3xhd0X6Q
         75hav1WC5P4OUYqjgD9VaFh0olnXccP67P5LFWAp4H1yVj1byJIoBaI3Oq1K2I6ad9WL
         WAy5k3R3CTR9XvO6XREfy0hSz9r3XmuXoY0N76MmHISA1RiH+elHJNv9HPb3jP+ULqWH
         hsA5GsTUp2t7r1lYr/zjTyPrMlklOUdbG7uuc3+ZnwTSEA9R4VHmmTZccmU9F0bMSLes
         jVHg==
X-Gm-Message-State: APjAAAXlFSIDE6yJAAbT9+KVRHXghI85g8yJotvzmN93G1X59FeJxHQ/
        wbidu6ZHkkVP/Xa9SXHB9cPHAQ==
X-Google-Smtp-Source: APXvYqyMEPjDyyY3osRAO4AbCJoWHD0CDKXCprRva7QfL5Pf9zBGUBTRsR/FhJPXynic3TTchMrvPQ==
X-Received: by 2002:ac8:3708:: with SMTP id o8mr69298728qtb.237.1558463185125;
        Tue, 21 May 2019 11:26:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n22sm12755197qtb.56.2019.05.21.11.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 11:26:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hT9Sy-00035P-46; Tue, 21 May 2019 15:26:24 -0300
Date:   Tue, 21 May 2019 15:26:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/hns: Fix PD memory leak for internal
 allocation
Message-ID: <20190521182624.GA11842@ziepe.ca>
References: <20190520064353.8523-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520064353.8523-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 09:43:53AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> free_pd is allocated internally by hns driver hence needs to be
> freed internally too.
> 
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
