Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE93B17977A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDSEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:04:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42736 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDSEh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 13:04:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id r6so2048007qtt.9
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 10:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yI/NPhVc9lrsTXtg6F6h1UJGzXm/NwvSl7ufzxc0DCY=;
        b=K3JppSiCJJ7+N8Clyo1I88o4AmcdQzXrjZzyXiFIY621IhLsa/wcc0XGDCPxk/CKZ0
         RN4o85cWKKR5AgCuJL2VJ6qW5u25bwDx0E0xRLldJ40jOpXdzsyNQjv/fSdjY/uuF0VP
         tOuWRHcAKZ8AGwj2O7hKZLMxZzY3rH6IagANQ4wDqxehpNuSQXzTZ+eW9Ejpd1SF06mv
         SQdzXn9EWkv1HL2fvPZwGzHR2PcY+1dND0OtKeb/x+CX3N6SjbwZnbXbnNV/z2wHCCaP
         mvjwL8evtlRzpkYbOx9QbW40hrTti8oD6Hduj0nHdxh+1EP+HziG2C+eblQZBm/AxLg9
         Puzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yI/NPhVc9lrsTXtg6F6h1UJGzXm/NwvSl7ufzxc0DCY=;
        b=uU3C3iyIINdkKTyove01hhKV3xYuF/0q2Xqmy9EsVXi60Jpf/wSLS5fyiAAK6gvv4x
         28vSDaiHAXHLmUVrABCL3o+WZnqdPZ2wki6gMbLp+4tvIJAYU+9q8TDchHK5M7l1YoWn
         ApcNy+OBCjJJxKJBmHTXpQnJZMQQa70r9qpH25Go6SyTm1wKJKwH2K/PKUqk1KXar2m5
         KDpDVpnOjaqE6q2692FY6oJlfhHPZEdWPcgERqdehJBFyXOTNgD1Vg3qDL1eC2QoVDuQ
         KJ1dneU8ZIb6pKsCM4c8QGghViwCBCzKK5ALP2Mp4HWcgqphsMIiZ7CsvU97C/Ih0ZSZ
         JF9A==
X-Gm-Message-State: ANhLgQ3eOu+l5mYK/I2ac5VBxHtVfhQQ0F2lQAbqqXpNyndHXEHkx0wB
        H9thnGg9Mwuy/ooqxtXV0oFK6Q==
X-Google-Smtp-Source: ADFU+vtWZr/LX7B1Xc3pDAe6OAlz+48V4PLQieyZR7LP89Zq4HZ45TSg8VE18DL/4BO+ll8IdwpnIA==
X-Received: by 2002:aed:25aa:: with SMTP id x39mr2167523qtc.20.1583345076505;
        Wed, 04 Mar 2020 10:04:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o17sm14759386qtj.80.2020.03.04.10.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:04:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9YNn-0005aP-BX; Wed, 04 Mar 2020 14:04:35 -0400
Date:   Wed, 4 Mar 2020 14:04:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/odp: Ensure the mm is still alive before
 creating an implicit child
Message-ID: <20200304180435.GA16338@ziepe.ca>
References: <20200227114118.94736-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227114118.94736-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 01:41:18PM +0200, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Registration of a mmu_notifier requires the caller to hold a mmget() on
> the mm as registration is not permitted to race with exit_mmap(). There is
> a BUG_ON inside the mmu_notifier to guard against this.
> 
> Normally creating a umem is done against current which implicitly holds
> the mmget(), however an implicit ODP child is created from a pagefault
> work queue and is not guaranteed to have a mmget().
> 
> Call mmget() around this registration and abort faulting if the MM has
> gone to exit_mmap().
> 
> Before the patch below the notifier was registered when the implicit ODP
> parent was created, so there was no chance to register a notifier outside
> of current.
> 
> Fixes: c571feca2dc9 ("RDMA/odp: use mmu_notifier_get/put for 'struct ib_ucontext_per_mm'")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
 
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index b8c657b28380..168f4f260c23 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -181,14 +181,27 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
>  	odp_data->page_shift = PAGE_SHIFT;
>  	odp_data->notifier.ops = ops;
>  
> +	/*
> +	 * A mmget must be held when registering a notifier, the owming_mm only
> +	 * has a mm_grab at this point.
> +	 */
> +	if (!mmget_not_zero(umem->owning_mm)) {
> +		ret = -EFAULT;
> +		goto out_free;
> +	}
> +
>  	odp_data->tgid = get_pid(root->tgid);
>  	ret = ib_init_umem_odp(odp_data, ops);
> -	if (ret) {
> -		put_pid(odp_data->tgid);

This put_pid got lost, I put it back before applying to for-rc:

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index b8c657b2838048..cd656ad4953bfc 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -181,14 +181,28 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
 	odp_data->page_shift = PAGE_SHIFT;
 	odp_data->notifier.ops = ops;
 
+	/*
+	 * A mmget must be held when registering a notifier, the owming_mm only
+	 * has a mm_grab at this point.
+	 */
+	if (!mmget_not_zero(umem->owning_mm)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
 	odp_data->tgid = get_pid(root->tgid);
 	ret = ib_init_umem_odp(odp_data, ops);
-	if (ret) {
-		put_pid(odp_data->tgid);
-		kfree(odp_data);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto out_tgid;
+	mmput(umem->owning_mm);
 	return odp_data;
+
+out_tgid:
+	put_pid(odp_data->tgid);
+	mmput(umem->owning_mm);
+out_free:
+	kfree(odp_data);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(ib_umem_odp_alloc_child);
 
