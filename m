Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9DBB8094
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbfISSHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 14:07:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34255 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403976AbfISSHs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Sep 2019 14:07:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so2960542qta.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2019 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gh3VtycczRg1l2zZldGQwelhfibhx2/yHrIoVWYGvPI=;
        b=YUIfhaf2HHDtg5AKMRbYZrZ9latGblViNfQGp+K3abfibmMFbs1ioTz8P83+E6JvV1
         0oit7gP5VUxZG9WXz7YhSjT750qmsyTmbePV9vUykfuQ0hRHgGy9N/tzKgqAUG57jPNc
         3+iY4v86i4OqjfPGydtVxo4usIWq5E0gX7P50otYUhWeHOZRtxho/QsIcX5uv6GkDKkn
         3HJr805j9c2BfawzgYtMP6yMKEZcrfzFx8rPMuSwv0izPFnFakyyqeICilPndL25M9Kk
         /7T1wWTFEXgGk+vGQd1Ddwz0aCMupn4vruFaEIlOIy8F30e/lbsFKC2pe2dm3muDu5sk
         DepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gh3VtycczRg1l2zZldGQwelhfibhx2/yHrIoVWYGvPI=;
        b=GT27w4MVg47Uys9zXXYTqrWRb91BIYlJkG3uKNtbzxq/bd0oqhIWqPWnBT+DwvARB2
         FEUtIg0MaISga0Zn0r0HeJE1Rxf0kiWEs/x/jIdLRha9I0PODShnChSCNQs8eo6A4xRZ
         4+NIJH+KEnm1JfBqIIR2jW9qUMpfAN0KfWprPJV6E2lWaPyd8cJ+eGa4POVZt6KsK+WK
         mg9JvRrUDN7U3rjXLRUf7p2PFQQTuk1TKx8Td5/HuepT7qrDMBTTokPkCI+pAvynSS3i
         dnzGb3MJZR4Dpy2fWkzfup454qoo/MiMfDRaKUUNR94jhMr5r0W1EBwZvrWJzC//qLZU
         Pcdg==
X-Gm-Message-State: APjAAAXZxeLbjMBnuV/s0RoskrNyXzCPUF1jyVcBD/omU10b74RnTqX4
        jSiDEUULTBVSZhEDoo7V6JvG/A==
X-Google-Smtp-Source: APXvYqyjg6rykJaq+y/7LrAQbm39C+HvPnFgiWneA+zoe0yr+5bQAvCoxU52jHJ0aO8Xxr4VE51qKQ==
X-Received: by 2002:a0c:d60b:: with SMTP id c11mr9056388qvj.179.1568916467613;
        Thu, 19 Sep 2019 11:07:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id w131sm5685515qka.85.2019.09.19.11.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Sep 2019 11:07:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iB0qI-0002b3-MK; Thu, 19 Sep 2019 15:07:46 -0300
Date:   Thu, 19 Sep 2019 15:07:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, galpress@amazon.com, sleybo@amazon.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
Message-ID: <20190919180746.GF4132@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905100117.20879-3-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 05, 2019 at 01:01:12PM +0300, Michal Kalderon wrote:
> +/**
> + * rdma_user_mmap_entry_remove() - Remove a key's entry from the mmap_xa
> + *
> + * @ucontext: associated user context.
> + * @key: the key to be deleted
> + *
> + * This function will find if there is an entry matching the key and if so
> + * decrease its refcnt, which will in turn delete the entry if
> + * its refcount reaches zero.
> + */
> +void rdma_user_mmap_entry_remove(struct ib_ucontext *ucontext, u64 key)

Since the struct rdma_user_mmap_entry already has both of these,
doesn't it make more sense to pass in the struct pointer to _remove
than store the key?

Ie replace things like ctx->db_key with a pointer and make the
rdma_user_mmap_get_key() into a header inline


> +/**
> + * rdma_user_mmap_entry_insert() - Allocate and insert an entry to the mmap_xa.
> + *
> + * @ucontext: associated user context.
> + * @entry: the entry to insert into the mmap_xa
> + * @length: length of the address that will be mmapped
> + *
> + * This function should be called by drivers that use the rdma_user_mmap
> + * interface for handling user mmapped addresses. The database is handled in
> + * the core and helper functions are provided to insert entries into the
> + * database and extract entries when the user call mmap with the given key.
> + * The function returns a unique key that should be provided to user, the user
> + * will use the key to retrieve information such as address to
> + * be mapped and how.
> + *
> + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not added.
> + */
> +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> +				struct rdma_user_mmap_entry *entry,
> +				size_t length)

The similarly we don't need to return a u64 here and the sort of ugly
RDMA_USER_MMAP_INVALID can go away

Jason
