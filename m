Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762761D6E1B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 01:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgEQXlJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 19:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXlJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 19:41:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB29C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:41:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z80so8520674qka.0
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xvfum/kmjdbcsxYSHkAW0qVZZOcyYEQ457bJOy9hREk=;
        b=imEcbhMzPjr2e4yEWvUTUqzRv0bhPyhXhuSRDNzpvYv9VHfuoaDeBx2EBHPlEnFpkR
         a89RQFPYhtJJmDY0EndUqqU484ayjHYOe+upWIo9v5Jf2rp/9N5Q88X+pN3FvfxgqcG8
         UZM2XI1MHuZFwgvlMLvXKpE4D3kzucaVm90wrvpCNtZ/oBnOyam8W+WPhYcSGAwVhxE7
         aY0GxRnyZgzPGGQ2pexa9taDN2038A81TYm1U+2vWX85UDWhMgaNikIg4ZgH9RjFptj6
         dwLBCSUm9V1qdyz34SF3p8EH6JvJqK50LjaAFkTitDy6/FauYL1TTiGXWD8nuZoGi2NY
         3igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xvfum/kmjdbcsxYSHkAW0qVZZOcyYEQ457bJOy9hREk=;
        b=jqnjy5Dr0ae0/OKzrTtY5oMQI+C5Kg4RCwYtO0KXM78WYvEbrkejeoHoN04sesHdX5
         KWRO5z8LfNz8AlF6rKXF+Cngq+xtbFp3iNcpMlzgLXPCz+VpGAnvzS9Zf59f3KdQn4sY
         kFm+cXcEonXxq4IxMR08dEmvCoLoSMP5yQ15VAqfFiey6Wv2R330unR7YQ3lYxQAHQQ6
         nUJdUzIIp6Oxij6YJrFRUHOqO8KCWNPJmSzNaTy/kyclM8BMpT5nrq3QZ6RF0/eSoo9Y
         ZD5/9LakPmiSkgL54/EJBaYnlWjOyFJftAUduHGt8j5Fjvy5u8PSxNFSQOQz8gwiEHWJ
         nuGg==
X-Gm-Message-State: AOAM533AOba3X1W4hXMzmON5OXQQuj09Kc0c/7L4yoSzVrtTevr0yFsa
        EMVJjNBAznu09Xsqh049J2GBFNstfeo=
X-Google-Smtp-Source: ABdhPJxj+/0Qu4Y8db2tcOFXWPOs/W6wpAsGTcOe4ccV6bSWBDt8S4P3HJL7tpPWTvfWNU0fNvGYDQ==
X-Received: by 2002:a37:a08c:: with SMTP id j134mr8739499qke.200.1589758868243;
        Sun, 17 May 2020 16:41:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g57sm8114303qtb.48.2020.05.17.16.41.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:41:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSu3-0006zo-EL; Sun, 17 May 2020 20:41:07 -0300
Date:   Sun, 17 May 2020 20:41:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Shay Drory <shayd@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Update mlx5_ib driver name
Message-ID: <20200517234107.GA26854@ziepe.ca>
References: <20200513095304.210240-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095304.210240-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:53:04PM +0300, Leon Romanovsky wrote:
> From: Shay Drory <shayd@mellanox.com>
> 
> Current description doesn't include new devices, change it
> by updating to have more generic description and remove
> DRIVER_NAME and DRIVER_VERSION defines.
> 
> Signed-off-by: Shay Drory <shayd@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Applied to for-next, thanks

Jason
