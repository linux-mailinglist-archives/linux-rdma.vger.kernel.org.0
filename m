Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED271C7354
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 16:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgEFOxa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEFOxa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 10:53:30 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF76C061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 07:53:30 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so1692314qtt.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ae+RhHAxHwcngCNzcjpKqJDoevGOyT+27L5zeZk2JzQ=;
        b=ocKx14IZ1HSo9zhoqQezz0IAQQzmYM6hoN381KppULHnbrsglcNiPxsIjtJyTWmhxA
         U3cgoG0qiyBPCr8P4ga28DXbWl2NT32a4dQ1a7LWkZI9/DGELPXaTr4Qk13ImLe8Dy9Q
         9fypaz6/mlkRVslYczFaOAkvqI41mcdRua0AvPbX6JuR97dhyDWtm8ZBZZ67Yol3l8Bk
         m9PxnMnfTE2OAkbwpN3oNRnsYtdf58Pzy/U2R6nNPsP0dJOnTNS1uC6uI2tFn8gKxZNh
         0RW9XQDTz4O2smqF7mOeGWiCgz76mcorWKPQ/xCPWCmFTIvQlSHp9b4Sy3HfZs6jPGxl
         r6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ae+RhHAxHwcngCNzcjpKqJDoevGOyT+27L5zeZk2JzQ=;
        b=dUJ6oQdLkoHM8QInX022YOBVfrEILQXyJxgX3xt3zmqxxcGvJzlLONCGmaAar+COPj
         s9ex1eQkzWv++x0RBHefSw5lrN/jfyR7BdKru2RxBLkc3zwH2E3ufGmoWJZtACcygBw+
         GgRIBDcILX2MYrIyIjKl3O9qxCxkjaxhxLj+wvoIpaWc3xAyP+D/YAj6dNYefdMHyEQU
         IfhpXy+U7y4rQx8vYWWHyK2m2hr3nraICIJhltG7kAzHcryJ0mItVRpWKPQ/VdOi1bBx
         1lCSh6IxZJ6GB59PzAPfWp5mPR45TvoUMTikMO34jqAsI/YujFbt/7jlXk+HmP2gNkNI
         s/XQ==
X-Gm-Message-State: AGi0PuaNYoyvp6aVLiiYYG7T8qKIScPlRv5Z5McvgVOdYiU/OgH9RVwW
        QHmpvxOEDJe+bO1vlgR7PCdA/XutIwc=
X-Google-Smtp-Source: APiQypKjTsX4A6RFxJvL0v9hCgWGF2wLkx5zWctNyJ/S8ZJs7B3PWLQDBY9YHWM0iwE13lzLLbjigg==
X-Received: by 2002:ac8:582:: with SMTP id a2mr9209142qth.62.1588776808762;
        Wed, 06 May 2020 07:53:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p2sm1798148qkm.41.2020.05.06.07.53.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 07:53:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWLQN-0006LU-Mr; Wed, 06 May 2020 11:53:27 -0300
Date:   Wed, 6 May 2020 11:53:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mad: Remove snoop interface
Message-ID: <20200506145327.GA24360@ziepe.ca>
References: <20200413132408.931084-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413132408.931084-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:24:08PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Snoop interface is not used. Remove it.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/mad.c | 238 +---------------------------------
>  include/rdma/ib_mad.h         |  49 +------
>  2 files changed, 6 insertions(+), 281 deletions(-)

Applied to for-next

Thanks,
Jason
