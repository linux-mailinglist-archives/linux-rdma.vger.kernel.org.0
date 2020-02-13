Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EA615CB0D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgBMTU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 14:20:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44926 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMTU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 14:20:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so6773434qkb.11
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYhZF+i35ihqfkBQZ8V4XYJK8LDRWgut/WCEWsnw2Xg=;
        b=X1NqAyqvIAJylcOg1HiEXtYKsgTK7TfqoKPle0psXLpyJ7na7HySwvxgBPwL0rWSi2
         QrD/6oCspoJxvsPqKmz3XXwSj81eaYKHXOembPyuOXpbK9gl56kUzh+zh917x7DGwSps
         3gEpGXNHPsIXJG6iCjfgQ94WqFZtORtoGwjJtisaaiHpISt2EW2sL3aJ0Lo/CnO5eyw6
         IGiJhr20ps0gtZPbjCqFSHU1Q8lcopWWjEDexpQlw6GMqTUuKFMHkaTuVwa3y2nNFW19
         zKAktw8hbVJoifTSrTGlB7FZ4R/I4lnK8zSsbg9p9urKo2BSLdz5WC7mjv9YgUprGgFk
         GZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYhZF+i35ihqfkBQZ8V4XYJK8LDRWgut/WCEWsnw2Xg=;
        b=PtVIN59y0PT8NzH+Zk+3CzQQDYZLsvq5kIWUUP+eEr6CjIh6rJJMyqqNranjypWvPE
         B0TmvNBI+nGV8yNzHq60iDUjX/BcPs1OchHo4UZ9Y9AO4apexnGkv1pqVR9hUzOKrH7Q
         1w0ro6QeM7SX6gItqQLKDUJybsAU/wy2wnrGu7nRdYDmNGnDzp5GrSOxWNaB0Q1ggvq4
         L4+yOz9G10ggGjFyQWZvUXUGrdCZhn8lzrCImdSbk4qt30ToVoxkXdjBs39XGwTAGacG
         yQc+lzYLEjAYm9eQyF2YGt+OfZHdmZ/Sbt0nQ0ujWEFfMeyQqfbM2UElfPCy739L+WOi
         FYtg==
X-Gm-Message-State: APjAAAUioiEdcpHT61fG88YEsDW8AbC1fjnQofhxKQFRQuwXYG90Vhcl
        Fpxd32ds7aka+Qej3cPv+uzZFyX4PnlzZQ==
X-Google-Smtp-Source: APXvYqw5SLEUrPTu+FfUgVwOEWjjMf8xIcP4yzmtzBYVe5u0Dna4mMDds2iX1HBbpM7BxRFzNf3uPg==
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr13367626qkf.480.1581621627155;
        Thu, 13 Feb 2020 11:20:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a24sm1739604qkl.82.2020.02.13.11.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 11:20:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2K2E-0002hw-BV; Thu, 13 Feb 2020 15:20:26 -0400
Date:   Thu, 13 Feb 2020 15:20:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Add weak ordering dma attr to dma
 mapping
Message-ID: <20200213192026.GA10377@ziepe.ca>
References: <20200212073559.684139-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212073559.684139-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 09:35:59AM +0200, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@mellanox.com>
> 
> For memory regions registered with IB_ACCESS_RELAXED_ORDERING will be
> dma mapped with the DMA_ATTR_WEAK_ORDERING.
> 
> This will allow reads and writes to the mapping to be weakly ordered,
> such change can enhance performance on some supporting architectures.
> 
> Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Applied to for-next

Thanks,
Jason
