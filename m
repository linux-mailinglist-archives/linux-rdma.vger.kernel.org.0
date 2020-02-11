Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 721A7159792
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgBKSBz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:01:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40522 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgBKSBz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:01:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so10974850qkl.7
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcBMCv8c87BU+PkaUG9zQKTyYZCyxHbTLsEhYi4ZpfE=;
        b=OEEkPwmirCUP5AFsKcy3t2l+OwJjUv04Y090o6PEw9V7rBz6Gu3toYe461BvTha0cH
         oeUduFCtTrcnacX9Hwm/wYEpRq+1nwpWeokgyWc2TK3JXnoicr5ferkezL8UU6qEO1xy
         vP0boeIzLpERkYrz8PYbeYOswZxGXFnaNRcTkCwjjP/q3TlbFV0lWMr0wyqQ0Z1tt/SF
         wlAjs4eBHXv+XZ2NtUUb+j/BQg/sI3oOkJQy1dwGXYmMDRY6kbZJ+xFSqp9Yk6lsn+lc
         h7m9VVuInvXURzouF9rOZQTfd4mdAPmcQLxwNL93Aik+/BIrha3ELisuzvkHf565bA9F
         K7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcBMCv8c87BU+PkaUG9zQKTyYZCyxHbTLsEhYi4ZpfE=;
        b=LiHRh4I7Awxggio7llwpahzYd9jbA/NUskhYgb7/WaookL+7WvI3C/JknOhINpQu5R
         5DX+Z2MQ6vdRmbBa4yYIABVI3Dw7RUQxyJhzTZzUf+1ltHI2qVP/Y9PqQV8rcLx0keKL
         GVHJ4qTbGbNNL6tMDI9pGphykMZLXRqKhWI5gyFdyFztzc/8gf2WDdffmojsEe3pJWUB
         1uu0k6AdHavScXqooZYfzk8Ivtp3ir8ODd3he/68sTIOJ9Ty1Qp/J7kWdMcrWgU9Sdoc
         8WTUQE2uAtyZcEUBOOhZFFPtwWYexr9wIhZgPY5Q5OwcZF61nOhRFaXizuMV+p6l/k38
         fYTQ==
X-Gm-Message-State: APjAAAWY1mZaKtQ0O3wNUR4sLG63Rpq345oYJlGBdQ8lYEC2nddlU81w
        I8a92IJs4Rnexujtb8Y5BXA4H+M6NnblXA==
X-Google-Smtp-Source: APXvYqzOc4QVWDjDux6r7hr4qPcMd1v3/KxdQzPDfiJsszt4Oz9rXvQQHErPV+V/5jW9QMAMVJNZ0w==
X-Received: by 2002:a05:620a:6d4:: with SMTP id 20mr7227055qky.81.1581444112899;
        Tue, 11 Feb 2020 10:01:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h8sm2495031qtm.51.2020.02.11.10.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:01:52 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1Zr5-0007V8-Li; Tue, 11 Feb 2020 14:01:51 -0400
Date:   Tue, 11 Feb 2020 14:01:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next 0/7] CMA fix and small improvements
Message-ID: <20200211180151.GA28599@ziepe.ca>
References: <20200126142652.104803-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126142652.104803-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 04:26:45PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> >From Parav,
> 
> This series covers a fix for a reference count leak and few small
> code improvements to the RDMA CM code as below.
> 
> Patch-1: Fixes a reference count leak where reference count
> increment was missing.
> Patch-2: Uses helper function to hold refcount and to enqueue
> work to avoid errors.
> Patch-3: Uses RDMA port iterator API and avoids open coding.
> Patch-4: Renames cma device's cma_ref/deref_dev() to cma_dev_get/put()
> to align it to rest of kernel for similar use.
> Patch-5: Uses refcount APIs to get/put reference to CMA device.
> Patch-6: Renames cma cm_id's ref helpers to cma_id_get/put() to align
> to rest of the kernel for similar use.
> Patch-7: Uses refcount APIs to get/put reference to CM id.
> 
> Thanks
> 
> Parav Pandit (7):
>   RDMA/cma: Use helper function to enqueue resolve work item
>   RDMA/cma: Use RDMA device port iterator
>   RDMA/cma: Rename cma_device ref/deref helpers to to get/put
>   RDMA/cma: Use refcount API to reflect refcount
>   RDMA/cma: Rename cma_device ref/deref helpers to to get/put
>   RDMA/cma: Use refcount API to reflect refcount

Applied to for-next

Thanks,
Jason 
