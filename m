Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9116643E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBTRV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Feb 2020 12:21:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32820 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTRV1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Feb 2020 12:21:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so3429727qto.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2020 09:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d9kg6e2fdLGoluvMa74R9Mb2vIDezXYW6p25lGdQ8dc=;
        b=d6Uw9419jB8+bUDpm4lj8p4U0VRbNIGu7qAF3C41ao6Gm3+yu6BPrpx0zcOSGczEGO
         hw/WMXF+l5ppRGEdAFtB9VznBV+sJ7R90JBJuIyl87V2+PtAdLWDjYp4xDLte3EdPPdl
         UspaN5YMdPi1SX/ROtJe1gv88HhSLdruAteCg0h4t/XL/dHss0mcQg0JeYksTmW1KXih
         +TH+nsxqoQ87X8wZCxR7IzU2MmrWQFmL2M8mEDpUBnm+MRzEwUpt6l4gA4ZxSBzW2xgA
         IidxdSWnNzn6zhr0EK4PAj+KBm3UzgAfMzm6ev1XINUQ5VVlEgDtZTqN3/tOusYDXJM/
         wRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d9kg6e2fdLGoluvMa74R9Mb2vIDezXYW6p25lGdQ8dc=;
        b=mWHir5gBUW+IQs2AaX6MFBY4KVUvjNhc6KPWmbOyZgNuXkDRvraiO0mxaeMqEZrBZU
         QlLeYOCWDR4JiiHUXBGAr+ASJM5+WY3Pk5mCkrssD+ZXC5DCsjj81fYXkCLCcF0L0Wys
         XcwN7vEgk62C6dMnSU7iTvUJyliYUl6cUryBOsPya1vHWO0bsOCQqB6fJ9I9zH5BzbZ7
         Py7cDIHj0JgfBAlHj+HUNoCyhSbEaQ+K2dXOdU4ugHJ/RwgSCOZF8ujv1ntkiNX+kUPH
         SAGIOMrQp/drvsGMbP8piRi16J6jAs9Ocq3lJFYlqC4v4qhFn2mnsHiCtTYnBE3dCLvW
         XM2w==
X-Gm-Message-State: APjAAAVP+6f/NF+VJ/8ZI8o/e98TAy/Za8P7QLd6SImlpm6k7LXAM7fV
        ARsSO+JDTxFc1m2vr6zkulHP2Q==
X-Google-Smtp-Source: APXvYqzYFYw4k4mNVvg2x21gTw+TPb77Zw+MbRGj9HF+5jdXWXBlJADllfdFGpUs1MJlj0Ue3gRtSA==
X-Received: by 2002:ac8:1308:: with SMTP id e8mr27818791qtj.242.1582219286316;
        Thu, 20 Feb 2020 09:21:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o17sm55989qtj.80.2020.02.20.09.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:21:25 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4pVt-0006Mp-BS; Thu, 20 Feb 2020 13:21:25 -0400
Date:   Thu, 20 Feb 2020 13:21:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, israelr@mellanox.com,
        logang@deltatee.com
Subject: Re: [PATCH v2 1/2] RDMA/rw: fix error flow during RDMA context
 initialization
Message-ID: <20200220172125.GA24403@ziepe.ca>
References: <20200220100819.41860-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220100819.41860-1-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 20, 2020 at 12:08:18PM +0200, Max Gurtovoy wrote:
> In case the SGL was mapped for P2P DMA operation, we must unmap it using
> pci_p2pdma_unmap_sg.
> 
> Fixes: 7f73eac3a713 ("PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()")
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/infiniband/core/rw.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Applied to for-rc. The other one can go to -next in a bit as there is
no current bug

Jason
