Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5299EF6D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 17:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfH0Pvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 11:51:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38575 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfH0Pvm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 11:51:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id q64so10091889qtd.5
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyOqqZfVXaCdrCD6D2ADnklikXRFi8MLAZgK4YpK3lU=;
        b=K/bbIrpgxbhTbNLLQ8Mbof1XU5jsCZUBILQwYFjwIw1Jm+QwosYS+qs1o/fHLIT86V
         7ng6HsAiMP5hq7rEGv6g0xDYI/afW50y2v0IjNTBAO9tk12JAGWnsBX9AfqiurTEDXVt
         hModd6XprgX65JEkeKN9FhmlxSIql7qa+Y3ekPNXdto6jIkuLfFcH/biv7KJg2zj/Sr+
         SP1AL7QvQPkZZUxUqcCbhI9Z+F+u/BnTWMrWlx/XZFDbJ0s4I/bDbp3BC0K3gbxL3JRu
         RLy8/4rEr01lrJM5sfQHSf6mQ+PiNq8JayhMo1Alt1yMixuHE2WjUz0nxxQcea5ulJHT
         klKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyOqqZfVXaCdrCD6D2ADnklikXRFi8MLAZgK4YpK3lU=;
        b=Ln8PuEXa3GLiLx88ZbJPdgR0gkwTTpt7dwIuZWAjWHe2ulwhoPKqHZmowQ2CJb6tm/
         mBBCceWyx/WH4FY7RAr2QbFo74Av6QRk7yleXYLGclOvCAtPOk5BYoZXOOrJiZfxRpVt
         cAeUgKYSO7BbYBvdjzpAD2FGrF3jmqHObKZe8OSBEuScBvhj8xBqCf1yaJ0mMglsWOEP
         X2q/yeisnEy2fvRX2NDF6R7V3j/6i2qK95NrxkdMwHhXjjwJMjyeB4+aftbkKhmSTPa3
         i08LTXKqvCVR6jskosDgaIbf0L+33Fn45BsvlmQ6yo/LbAfzgH8k+OiIo5UoXSJPcwGo
         NwSw==
X-Gm-Message-State: APjAAAWZ/HGsz6egRYpy8BIPSVzSTkLyVoQqLx8ff2acy3cRMl5dlakE
        SCjIzfpomC9NO9oAE1qTKD/Izw==
X-Google-Smtp-Source: APXvYqxC5++4GwpcvpfYV8bMDOpFXrgbxlYFkTLHLhOEWerw6Sv4yfHLnjFTy4ys4vDT4qhURjcK+Q==
X-Received: by 2002:aed:27d1:: with SMTP id m17mr23681669qtg.111.1566921101686;
        Tue, 27 Aug 2019 08:51:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id w24sm9840661qtb.35.2019.08.27.08.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 08:51:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2dky-0003wu-NZ; Tue, 27 Aug 2019 12:51:40 -0300
Date:   Tue, 27 Aug 2019 12:51:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3 0/3] ODP support for mlx5 DC QPs
Message-ID: <20190827155140.GA15153@ziepe.ca>
References: <20190819120815.21225-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819120815.21225-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 03:08:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog
>  v3:
>  * Rewrote patches to expose through DEVX without need to change mlx5-abi.h at all.
>  v2: https://lore.kernel.org/linux-rdma/20190806074807.9111-1-leon@kernel.org
>  * Fixed reserved_* field wrong name (Saeed M.)
>  * Split first patch to two patches, one for mlx5-next and one for  rdma-next. (Saeed M.)
>  v1: https://lore.kernel.org/linux-rdma/20190804100048.32671-1-leon@kernel.org
>  * Fixed alignment to u64 in mlx5-abi.h (Gal P.)
>  v0: https://lore.kernel.org/linux-rdma/20190801122139.25224-1-leon@kernel.org
> 
> >From Michael,
> 
> The series adds support for on-demand paging for DC transport.
> 
> As DC is mlx-only transport, the capabilities are exposed
> to the user using DEVX objects and later on through mlx5dv_query_device.
> 
> Thanks
> 
> Michael Guralnik (3):
>   net/mlx5: Set ODP capabilities for DC transport to max
>   IB/mlx5: Remove check of FW capabilities in ODP page fault handling
>   IB/mlx5: Add page fault handler for DC initiator WQE

This seems fine, can you put the commit on the shared branch?

Thanks,
Jason
