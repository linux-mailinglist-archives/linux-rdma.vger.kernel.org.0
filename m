Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB812FD59
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 21:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgACUBH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 15:01:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41950 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgACUBH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 15:01:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id x129so34670219qke.8
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A56UC0w5GLRc6XImLwZB7Svehfi5E2iCOac3oz+4egQ=;
        b=eBdvlKXe8GaxBJQX/G4csG9ZdMY/64O11qqgYWNPuXh3wqho3raAuCgAh9kCCpq2g0
         7j1XotvkfcxEohD0N3dqehlZ7GBmRa5J2WHyXuQPLd/7qbTYFOfRh49L55jzFOZwQAZy
         u62PGHppFudekxHvPtLgod9F8bBDIdEYROW8v2Fz+m+L+1apm8mxHTFAtMNAlC0vviGq
         7KFS3sLs4L4ecxsPnRWuSDXoKxWMrG+7KtPj/KTeZAfhuuFGPrvRSx+6Ni0Ysyu2AlEL
         BxkTHeozSqVxc0BcN3QhTWWpX/t7SbKWWemF7EHdAXhLokexWY55HBeytvQPG3oTwOp5
         xlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A56UC0w5GLRc6XImLwZB7Svehfi5E2iCOac3oz+4egQ=;
        b=hIYacceDhAA7dEJLhTy4xN4eI2ammjmtNPJ6n+wUBZgmyzIYTxO5OBJpANvtNRziUa
         s+yLkswyyUg62KJb4qoncL3yhNpnnoa0q48cqbGe9Qt3f0HiU/2Rrk/vpUtGI/ux1WY/
         H7FFdZYh1pchnh5ic97wp7vPNPPVu7xVEhyLhFmqougj/bOfLp1BT0owlIqVJnSIe/sC
         j817DkHXxysHn2qsRoVYH/rk2CJHA/WgU3yfQfV/W7iRW5WAs/BtWAotL2pAgVjZKS7N
         OmdHN4l6vX5PopoypJJ6G1jB39NiySI6Hf1yCFbsjNp6qn+SMjUXAukcDDCXjFGb21CR
         zr+Q==
X-Gm-Message-State: APjAAAUfRW9LMJG8J6/WwW3TCXz7iDSlG+Y6VT45GyedoouPOO43vuC1
        iEHdFCTNb4j6A8/tGAdQjTwwaA==
X-Google-Smtp-Source: APXvYqypm/JpMqcucNPfB12FjbVXHsbFsRwkB1xsS4u8ZlUIlgCQmEPJNMow8LKqUpKg1OdwMcnMmg==
X-Received: by 2002:a37:6545:: with SMTP id z66mr75273804qkb.367.1578081666057;
        Fri, 03 Jan 2020 12:01:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p19sm19280745qte.81.2020.01.03.12.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 12:01:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inT85-0000kn-4l; Fri, 03 Jan 2020 16:01:05 -0400
Date:   Fri, 3 Jan 2020 16:01:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Prabhath Sajeepa <psajeepa@purestorage.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, roland@purestorage.com
Subject: Re: [PATCH] IB/mlx5: Fix outstanding_pi index for GSI qps
Message-ID: <20200103200105.GA2761@ziepe.ca>
References: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 05:11:29PM -0700, Prabhath Sajeepa wrote:
> b0ffeb537f3a changed the way how outstanding WRs are tracked for GSI QP. But the
> fix did not cover the case when a call to ib_post_send fails and index
> to track outstanding WRs need to be updated correctly.
> 
> Fixes: b0ffeb537f3a ('IB/mlx5: Fix iteration overrun in GSI qps ')
> Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/gsi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next with an updated commit message.

Thanks,
Jason
