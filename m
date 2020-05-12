Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABF91CF444
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 14:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgELMWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELMWJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 08:22:09 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA62C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 05:22:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id 59so6232891qva.13
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2020 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wNx9MdnZl2jfC++4y5XQOE8FYVVfyB9TzJr3YerVOpk=;
        b=TPVxxOxOCoQPK57x/MDyNULRi+QtBlaFvPfFKAWZk4YA3ChrtIQY9T9wnpW9Jx64lK
         cpBCcjB4iCpO4xc8bHCHjNVLHEbI2udhgY9QaaCO0Nn3P0xNSzmXg0EH1iHmBqB79ib+
         qo5l6BfsbBnQBEH56mpE7r97mRqcOJ+2VAucJzrXn1wCirjdTW3kl9s1A3N9pom5k7EN
         IiTe4A5cIUnopZ464fpWak8lnxuZ7hN+rLC6lVgmS/SGyXA7KzGLv8DKFNv6Fd7QM2ZI
         5Y5wVopbS0zvcRDx5INhfNwrwN6oO+PDOnnT1+JHQZbkPt/8MB4kkf/qCUsal6HdK+kR
         QvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNx9MdnZl2jfC++4y5XQOE8FYVVfyB9TzJr3YerVOpk=;
        b=r9tjvE7lQvZ5MpBpwU7YHZ3XgtTkm+LGfpJNrHJQIirx+lxpWsuQSZ2IIaYMXUAcut
         qyn9wEYlfWRssqYhowJT7UpDB0ev2WoctTYeIA2hhlqFmy0z9ehdVY2Hj5MnysHN3p5C
         tcq6ILtEqJDndDmX0jfpax2hKyS+G5wnpvNRsbISllBRxf0Cuzjlhd9xsCOEKYOX7nuD
         WZMW9a7Xdy+E5fXyJ4KAVVKRWkgb9K26ccdP8X3SJFOqpOx45bgqLQSynGAniOcCxx9D
         4C4ZLbkt19SLI98B3KmFZ2QkOq6Hy22AzzbUtFWuvvWy0YgwtGg0cmw57/jz9mIyfIHd
         lgsg==
X-Gm-Message-State: AGi0PubhhAtky5PTRpmBKSeol0cyHEMkJwUwnHgEo9wEbMNvaVQo0+/r
        +mblenJDaWKBzcHV/QvbSTAIigU+kxY=
X-Google-Smtp-Source: APiQypJgyo+reJ8XD79X566lv7iFy3+rO64wn+FIgGtsVRyE8ONgZYZrTUiiVSKsJnHczBR2nfEkKA==
X-Received: by 2002:a0c:99d3:: with SMTP id y19mr20426216qve.72.1589286128372;
        Tue, 12 May 2020 05:22:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h9sm1311163qtu.28.2020.05.12.05.22.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 05:22:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYTvD-00049k-GU; Tue, 12 May 2020 09:22:07 -0300
Date:   Tue, 12 May 2020 09:22:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/core: Fix double put of resource
Message-ID: <20200512122207.GA15945@ziepe.ca>
References: <20200507062942.98305-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507062942.98305-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 07, 2020 at 09:29:42AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Avoid decrease reference count of resource tracker object in the error
> flow of res_get_common_doit.
> 
> Fixes: c5dfe0ea6ffa ("RDMA/nldev: Add resource tracker doit callback")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
