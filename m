Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF604E3B2B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440136AbfJXSkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 14:40:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37902 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440123AbfJXSkl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 14:40:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id o25so25976780qtr.5
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 11:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eLHmFx0PTyoFlLSunsNVvB5p4KpwuGbFh0oV+Cldyfk=;
        b=Z4sxAa7JBgARFSPSFyXu7yVI0vJts5ZCvmmWdIpD2tNYywmWcbuGjWDMcPmXityt+2
         k/JlYXHIMzj1uiNZ5CUC1um30yf1B+uEhmCNr3ONS/semFyQ50rHO+sGmehQSf9mAGe4
         r/Kw9D84gCyHj6gKIMrFjKEsLPqosvEbmkgx87mVhMXN22i5vjNn9NMA7rG2aFfQEJrA
         SPf5A3bxojtlzgAyJLUQClAd63W48qLJf+4LOhyTNqEOdX+DXcKN9orUKPOiHgrprTqI
         xArdthguZgPhJlTKJuEZ5d7hdkTHjFhEZ7maG09IXUivd1wMA+kCs+K4nKVyyQ9hMATH
         Cy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLHmFx0PTyoFlLSunsNVvB5p4KpwuGbFh0oV+Cldyfk=;
        b=JtAPM/b9Bsw85/cXWGKY8stK0EPoVAv4bZATPRPRZmquDxDibJwADWZzOZ+exBGb/U
         HRZOa+OghkSYiHrRb3N4RbyIXPC73341mnuP+/bcxrA6b7t9YC5MHMMuFycxOlOUcW57
         TyxK9Qxsr+C7TGB5zhPDEIZINUO9Sle/tnfJf5n0cc8uFveCaq0syKXQNRukdmt64lN9
         zbGQWcahA2RbKaIoM4pEO2BhLFrxl+JVSEHTQWhZHvtnRhLGfEy6lBaoR2m+fuA87c6J
         I7Yc+IGy3Fkvifq7Fjpbita4/oOUYT4PK0jxhJcG78j5IUPcUY1Rr/BewMZ66pqao6sq
         PsfQ==
X-Gm-Message-State: APjAAAWaNHWU9F73DybPGkcM7iPxEw3oZY2Z6FAtve0nllYHYSajRlpr
        ksWDC84/S16VNTg9lp2XO/gaWg==
X-Google-Smtp-Source: APXvYqxBv2C1yV/nT7JTEtHgNZ04dLJPLyDgQ8TQZPToJpHknw9qTWB/QDeMzFvK6q5WqCgaqyT20w==
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr5513995qto.334.1571942440502;
        Thu, 24 Oct 2019 11:40:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j4sm13229606qkf.116.2019.10.24.11.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 11:40:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNi2J-0001oX-IP; Thu, 24 Oct 2019 15:40:39 -0300
Date:   Thu, 24 Oct 2019 15:40:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Skip counter if port doesn't match
Message-ID: <20191024184039.GA6944@ziepe.ca>
References: <20191020062800.8065-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020062800.8065-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 09:28:00AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> Counter resource should return -EAGAIN if it was requested for other
> part. Such situation can occur in multi-port systems.
> 
> Fixes: c4ffee7c9bdb ("RDMA/netlink: Implement counter dumpit calback")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
