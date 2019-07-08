Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E346862A0D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 22:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfGHUBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 16:01:16 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46294 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGHUBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 16:01:16 -0400
Received: by mail-vs1-f65.google.com with SMTP id r3so9067561vsr.13
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aM0qdzWAzLMDPjvNQ7kOcf9aVAiCeSLTlwLrWZ0PC1o=;
        b=U+VdRYo7d6jGtWWT1svPDkQU4/YZVOQOG/jx02PUWQcCg2GxRzY9ykQl1UYB75zOXo
         IMR3Lai0BBYApI3gKSzFAyVVYqU/9HKhjE/bnWIQYf5aLc/tVU4MKEI5dYdrxvP81KYw
         Xwm058WVaUTLEklCSOvpcbNz23rpa1Pfs/NtKo7eFvfMSqN+1x7dhP5ZeTo/Tq6Uii54
         WhrOzxquARbsgsCPmZK8uNJgjk63N2TQjiIidRrcX4S0MMAAQ+nTMz+XD0wy6kEjbkiV
         OneYr1kGaQzItEI/splm3aDE1ntUxN0P2+IpPlkt9NFsWkqqCAq/pgn4j5hGg/EtsBuU
         GmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aM0qdzWAzLMDPjvNQ7kOcf9aVAiCeSLTlwLrWZ0PC1o=;
        b=WrjrGka1sI986jSrfCsxsqUfFI/aFwsWVWinXy3PJZuEaRiWTuyIEIyZjMkFJjP6Qu
         fYz8u0e/4lAdv9bW1KQiIFZeXeWH4HH7/lNtQhRDMIwIZJwUwSZH0uiGnYe6my6FfiEK
         udBBg862FNKzl5REIz+4ef0AG87NAeG32Okfnmm809FWwl6LGw0+tAdO5CV6VQn1nVqy
         2X5E2gQz2s8B0HMBMW7tBLD/m0xctRVB/iSKJQkoazQmLfewEmgl7PT5Xvufc2iGH7IP
         VdYdjeBNkGguikUDZkAvJd1f1Eg3AT0FpCiiT82co+4GoRj1uprZAcgVXZlGptmypmiK
         PO+g==
X-Gm-Message-State: APjAAAUJJn5I3bGgaeI4IfcVUmG9fYe0joab3FX2Vc45aWxEVPn6uEfa
        Ai7Iq9Krqzt1c/1huBQxdaJheQ==
X-Google-Smtp-Source: APXvYqxjL+qyNFmmw1s+VG3rlW8n+0MI95KBY4A8zOmbJLqf6FJ7UcAod7mG8KYqvseYEG6IYK/hJQ==
X-Received: by 2002:a67:ea44:: with SMTP id r4mr11741368vso.86.1562616075674;
        Mon, 08 Jul 2019 13:01:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l20sm4510571vkl.2.2019.07.08.13.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 13:01:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkZp4-0006jp-Kr; Mon, 08 Jul 2019 17:01:14 -0300
Date:   Mon, 8 Jul 2019 17:01:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Annotate destroy of mutex to ensure
 that it is released as unlocked
Message-ID: <20190708200114.GA25699@ziepe.ca>
References: <20190704130012.8177-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704130012.8177-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 04:00:12PM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> While compiled with CONFIG_DEBUG_MUTEXES, the kernel ensures that mutex
> is not held during destroy.
> Hence add mutex_destroy() for mutexes used in RDMA modules.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cache.c        | 1 +
>  drivers/infiniband/core/cma_configfs.c | 1 +
>  drivers/infiniband/core/device.c       | 3 +++
>  drivers/infiniband/core/user_mad.c     | 2 +-
>  drivers/infiniband/core/uverbs_main.c  | 2 ++
>  drivers/infiniband/core/verbs.c        | 1 +
>  6 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 18e476b3ced0..00fb3eacda19 100644
> +++ b/drivers/infiniband/core/cache.c
> @@ -810,6 +810,7 @@ static void release_gid_table(struct ib_device *device,
>  	if (leak)
>  		return;
>  
> +	mutex_destroy(&table->lock);
>  	kfree(table->data_vec);
>  	kfree(table);
>  }
> diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
> index 3ec2c415bb70..0a7b5eba2fc0 100644
> +++ b/drivers/infiniband/core/cma_configfs.c
> @@ -350,4 +350,5 @@ int __init cma_configfs_init(void)
>  void __exit cma_configfs_exit(void)
>  {
>  	configfs_unregister_subsystem(&cma_subsys);
> +	mutex_destroy(&cma_subsys.su_mutex);
>  }

There is a missing mutex_destroy in cma_configfs_init's error path.

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 7f4affe8a10d..adf8d93bb42d 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -508,6 +508,9 @@ static void ib_device_release(struct device *device)
>  			  rcu_head);
>  	}
>  
> +	mutex_destroy(&dev->unregistration_lock);
> +	mutex_destroy(&dev->compat_devs_mutex);
> +
>  	xa_destroy(&dev->compat_devs);
>  	xa_destroy(&dev->client_data);
>  	kfree_rcu(dev, rcu_head);
> diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
> index 9f8a48016b41..e0512aef033c 100644
> +++ b/drivers/infiniband/core/user_mad.c
> @@ -1038,7 +1038,7 @@ static int ib_umad_close(struct inode *inode, struct file *filp)
>  				ib_unregister_mad_agent(file->agent[i]);
>  
>  	mutex_unlock(&file->port->file_mutex);
> -
> +	mutex_destroy(&file->mutex);
>  	kfree(file);

The file->port->file_mutex is missing a destroy in ib_umad_dev_free
(bit tricky to do)

>  	return 0;
>  }
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 11c13c1381cf..4827aa3415ff 100644
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -120,6 +120,8 @@ static void ib_uverbs_release_dev(struct device *device)
>  
>  	uverbs_destroy_api(dev->uapi);
>  	cleanup_srcu_struct(&dev->disassociate_srcu);
> +	mutex_destroy(&dev->lists_mutex);
> +	mutex_destroy(&dev->xrcd_tree_mutex);

This file also has ucontext_lock and umap_lock that are missing
destroy

Jason
