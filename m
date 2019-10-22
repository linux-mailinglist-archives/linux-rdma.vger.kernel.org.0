Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEECAE0CAA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfJVTiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:38:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45811 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbfJVTiv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:38:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so28553170qtj.12
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3gOQxJoSrM0to6WFjC7j2iBNL8Qf/KpYOZJqz+pNJ38=;
        b=UQwYhB+iOmBri2Y4WVpxZIkdDu8sU1+4vXLi5w+Hl3eNe8ETwA9kX8blEK4MDhCMOj
         BG6gT8q6avOtQ1xrpKk+a9ocRmCQOMwDZjSakFZVTLRDvosA0oRcZbnY5eeiygEZOf3j
         DZxHJNqzLu7fS+aA5s6JO5uavzrncsDFbic4sSmtMH9IdhWUm/1VRf7lsQh4u4TwEs9n
         QDyl4TYSjjsoMXDqzfaXPLliTPMPzbsMX3hTCUHT2tmfav0TM9c93pO6qV/HJbK5dfMx
         eFW8yqeLQoJ9woY0eEkdSudPoa4p7JE6ybkYbyz7Lb6Q32w5V5mfYXGv1yN1cxKD8I2F
         0+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gOQxJoSrM0to6WFjC7j2iBNL8Qf/KpYOZJqz+pNJ38=;
        b=UXXofD6CXrrJPIRjs2JhI3iuSdtzMTFekMnTLiBRGO/B01332eEuftly3M95bJ0DqH
         /p1gGSHiAovnaxZ1zQzCc9GHlo59hGrIz603i8wQ+z9SxU2hmkmRo5YKGgg+R24C7Byi
         BXWDz4yvVdxTQp7lEMg/pEtrqK7876XCyNMi8wFsKugnDF5rod0LjNn2GLuhmx2jK+jP
         TN8g2K4CK5+HLiZL6+UWc9jdyG7Z4TU4/rC4KWRqH73JSxDFbhOb3nwOinOmNxSlWn/h
         dBu9mcOLRie19r7HZTs60vntVmvUnyo8DMrpDxuTJv6Q2sDRxwBw5lof55vtexMbsosu
         XVqQ==
X-Gm-Message-State: APjAAAXwXxCSlBOwcgNRiIKmWkHGtEvaWC/pRS1x2Lju/wJ/GJriXFlu
        UBn7PMfk9sA8VKwZhizwjFbt0QEBg7M=
X-Google-Smtp-Source: APXvYqy8jGMukSjRZhIjTVWW4nKdk7Mp3KpjLmVnqD1Nmq9uqZG0Pul5CWqqtpQ3ejWAaHNaXcTgwg==
X-Received: by 2002:ac8:3849:: with SMTP id r9mr5122528qtb.370.1571773130611;
        Tue, 22 Oct 2019 12:38:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r126sm8792896qke.98.2019.10.22.12.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:38:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzzV-0003Bg-Lb; Tue, 22 Oct 2019 16:38:49 -0300
Date:   Tue, 22 Oct 2019 16:38:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Ran Rozenstein <ranro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Remove dead code
Message-ID: <20191022193849.GA12221@ziepe.ca>
References: <20191020064454.8551-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020064454.8551-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 09:44:54AM +0300, Leon Romanovsky wrote:
> From: Ran Rozenstein <ranro@mellanox.com>
> 
> mlx5_ib_dc_atomic_is_supported function is not used anywhere. Remove the
> dead code.
> 
> Fixes: a60109dc9a95 ("IB/mlx5: Add support for extended atomic operations")
> Signed-off-by: Ran Rozenstein <ranro@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 15 ---------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
>  2 files changed, 16 deletions(-)

Applied to for-next, thanks

Jason
