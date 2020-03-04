Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC0E1796B6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDRbA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 12:31:00 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33372 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDRbA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 12:31:00 -0500
Received: by mail-qv1-f65.google.com with SMTP id p3so1153240qvq.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 09:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YksQVa/8FMxgGLBNu/AvBj0jLn8mcBO2XxWjyoFpWgg=;
        b=gcDlAQx/+z1dqqxO+f969u+FC4dczZrqt2XN5tfaPVLf7ilI+WBfYQU4mEDgw1JkTc
         IPLXEAw76pra44sLc8dHqftbtPj7aHySu4x9BSsIUUiCDrJvBNIzXV0cEDSf1YJx78V5
         shVHoiMUEef+6hMjngeV5dpHdOb4QvrwrGfQ6mXQgQuI4+YzAZUXB2HZ+AEv9I0GPiEU
         +L1kbvNUDQfO2Gc/nV38pLzXEwe4dIzxeSzZfscCQhibbncA4+6genn5RtG3SqxZhLgV
         pARpaxPJMdKt1QinuNvU8ymhnW6ulV3vjyh771mDD7UKMRB9UBUaQJwteI4macmBAC4j
         rOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YksQVa/8FMxgGLBNu/AvBj0jLn8mcBO2XxWjyoFpWgg=;
        b=OOQoKexdBDnxB9uhfFg0x2JgpgJjmKJ6BtAd/5h4H5VT1awQqln0xfcuhYjnLJxCRa
         b+iz9UovU68OuD/Pkl6DXO7OFPxIY9s+87Y3fsGQ1O/DLE6e0TwWdCBPRRcaqSr5dVN0
         0F5TlBgFI4FHasc8kj3pewMTKkb8rINFRXimzsZAtzdRA/HULcxB63paJwbfSnCEQLGl
         qz+DJJ5RJpwFpUEeXkVa8rXz12DQt16KFueS0HR9sITkfQswg/f4HCZBSKE2ckTwOoXj
         9SogJnFj6AhfACl4/uFDLPmhuzF0WG1gdVewl28nMZpVkR2UiWG0B4H2dckNXYEkAjO+
         XMPQ==
X-Gm-Message-State: ANhLgQ3NAIeZVDhmyUHGCxIMi29oA++UI2ydrVobdhThfN3qBM2caxaV
        ZzQ1Hb7yb7hreMnpY9cAZcAtkQ==
X-Google-Smtp-Source: ADFU+vvdOler5iphNlJ3atBBMj3EKMtNYPqL9K3AwMjrKFLFo8fAR4KcNxc0v+f6HFlerxRmYh+iog==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr2832195qvu.155.1583343058912;
        Wed, 04 Mar 2020 09:30:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a14sm14040784qkk.73.2020.03.04.09.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 09:30:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9XrF-00013f-UT; Wed, 04 Mar 2020 13:30:57 -0400
Date:   Wed, 4 Mar 2020 13:30:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix implicit ODP race
Message-ID: <20200304173057.GA3963@ziepe.ca>
References: <20200227113918.94432-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227113918.94432-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 01:39:18PM +0200, Leon Romanovsky wrote:
> From: Artemy Kovalyov <artemyko@mellanox.com>
> 
> Following race may occur because of the call_srcu and the placement of
> the synchronize_srcu vs the xa_erase.
> 
> CPU0				   CPU1
> 
> mlx5_ib_free_implicit_mr:	   destroy_unused_implicit_child_mr:
>  xa_erase(odp_mkeys)
>  synchronize_srcu()
> 				    xa_lock(implicit_children)
> 				    if (still in xarray)
> 				       atomic_inc()
> 				       call_srcu()
> 				    xa_unlock(implicit_children)
>  xa_erase(implicit_children):
>    xa_lock(implicit_children)
>    __xa_erase()
>    xa_unlock(implicit_children)
> 
>  flush_workqueue()
> 				   [..]
> 				    free_implicit_child_mr_rcu:
> 				     (via call_srcu)
> 				      queue_work()
> 
>  WARN_ON(atomic_read())
> 				   [..]
> 				    free_implicit_child_mr_work:
> 				     (via wq)
> 				      free_implicit_child_mr()
>  mlx5_mr_cache_invalidate()
> 				     mlx5_ib_update_xlt() <-- UMR QP fail
> 				     atomic_dec()
> 
> The wait_event() solves the race because it blocks until
> free_implicit_child_mr_work() completes.
> 
> Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
> Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>  drivers/infiniband/hw/mlx5/odp.c     | 17 +++++++----------
>  2 files changed, 8 insertions(+), 10 deletions(-)

Applied to for-rc, thanks

Jason
