Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB23D1D1E70
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 21:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbgEMTBh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 15:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTBh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 15:01:37 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92CC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 12:01:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p12so706555qtn.13
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=imC7sySPq9HcLWXyoVI9V+FV5GlIDi9E/0K8/JZJJIw=;
        b=iSFGEMgeAXB/LiFl5jkHz+lO/wVgk1yYSwH7C/VyDFgU+vGtTr8HjlVihszGMj5THC
         EhNzOWP6ipdnd9L1jf0JHVZuEd8R/JK69M16hj6D4plsvZilgLqNlzDFMJqGZ2FleGO/
         W5g6ILPsrz51z5tw+fNRzLUsiFfAkzuRXI22fW5kvxJjsHlTOjcb/uM1DButPWR6k9ve
         L4VaA2XAbRUXjo5Z5rLKnAqOP0C9+evN7YLETV0cH5vDkN/0sl/PljmjM6kmvKQGUzWI
         qq6YbIZMA97cfb81nfxm4ysojntTF06aLGNOV6rh+WDfbSogKk/P93JC6XPnOv58ryM5
         IHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=imC7sySPq9HcLWXyoVI9V+FV5GlIDi9E/0K8/JZJJIw=;
        b=PRWRkzDyrAjbDV3u+RvNkkmoZVVNyZa9Cr/xTBQ8MKE/SZSjXHCACKx2kC6/PmtzRc
         lwfmc2JLGtJl3wFHuGujULyEfPOyaGq9pRcYT8P6jpPqdvZ3AcQwfP54mBlxGCSVODbe
         htErslIORRsufkp1ZxcX7mrG0/FYsjNLQEusYYlWSxVyA7RGnS+5JhId2TrsNpgC6UiV
         jwcVfRfoUaL668ETV9aTrRAcyMn75hXtBDWoJKC6ONQ0iHGvjw8oFustrX7JuiioP6V7
         zTan/0fqkjxCi19v4W/WSfAQFM41VeJKXyVr3sJ4gU+bSgciqWAqTSfBg4ePKIAmv9Ry
         49JA==
X-Gm-Message-State: AOAM531yJf55drOVx+0h5vkNAu2Q4U/dqRRxGz3UqONAFlYN+3vJhcHr
        OOwfgo1BUEnAR9Ee1I+XQJ3RXw==
X-Google-Smtp-Source: ABdhPJwAgOzsTfbEqkfMPJ172kU/C0MaR+GpP8jvT5FAF+fvahybrwpdb4UCw/BUIfttR4szwbcmKA==
X-Received: by 2002:aed:27ca:: with SMTP id m10mr601052qtg.115.1589396495269;
        Wed, 13 May 2020 12:01:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j45sm502123qtk.14.2020.05.13.12.01.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 12:01:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYwdK-0007DE-4N; Wed, 13 May 2020 16:01:34 -0300
Date:   Wed, 13 May 2020 16:01:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Add support for drop action in
 DV steering
Message-ID: <20200513190134.GA27687@ziepe.ca>
References: <20200504054227.271486-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504054227.271486-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 04, 2020 at 08:42:27AM +0300, Leon Romanovsky wrote:
> From: Daria Velikovsky <daria@mellanox.com>
> 
> When drop action is used the matching packet will stop
> processing in steering and will be dropped. This functionality
> will allow users to drop matching packets.
> .
> Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changelog:
> v1: Rebased on top of https://lore.kernel.org/linux-rdma/20200504053012.270689-1-leon@kernel.org
>     [PATCH rdma-next v1 0/4] Add steering support for default miss
> v0: https://lore.kernel.org/linux-rdma/20200413135328.934419-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/flow.c        | 35 ++++++++++++++----------
>  include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
>  2 files changed, 22 insertions(+), 14 deletions(-)

Applied to for-next, thanks

Json
