Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9243F7AAD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhHYQfG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbhHYQfG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Aug 2021 12:35:06 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A4C061757
        for <linux-rdma@vger.kernel.org>; Wed, 25 Aug 2021 09:34:20 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id z2so245283qvl.10
        for <linux-rdma@vger.kernel.org>; Wed, 25 Aug 2021 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36MIO5C4PfqOVOJlv5grTM2lIS78XuJLicCO0EKKj/Q=;
        b=G8VgxzDl5Bi52T7zRG98U6tZTrnd8fVTfdDOuo52pAtNLEGBDxeuXH7w25e91+0qsR
         SqPi54uKckqWKi7Pc36H5gSlf3j2JtKG2pLQQbbzi3UBxb4F8niSGfpp41M6+MA4Iqru
         y4s7skuQzJMoBppDmbaPnFKOD24ZaLaXVnMwT4WcOEXkMVzLwrB8jXdhmUsWjqOiRAg1
         2GudBA6HehJUf7ehDzPJf6+ivGHdtsGfZNFZdJ3FYNEQRZpBJiJGY7Gt6fSCD/4N9LJH
         1ey8w7BOxrwvGUaC9q1OP8pao9uUkU7IDJ9XTz2OQT+2lfZ03WR9qNruWFHQ68kcro/B
         bLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36MIO5C4PfqOVOJlv5grTM2lIS78XuJLicCO0EKKj/Q=;
        b=cLvfr+Oh/kz1LR/jNzbuaE0DhKtGS73m/1JttkMXuxKAzVy9g8UHcePZyqKcXexzHt
         TmVdSt2l7NccKID/yHGIOEl3uXHacnTWLo+2c/sSIkRFl6UO1j/mfhwpg0RwJjRSJh5G
         Wuv8a2EnhATuuc5J2NfUVEbzUIuaYTk5AQtbeRfSgAXrbDklM7hHTb6665lz4Kwj3BxJ
         YuVj06dqi73QCjwuSusQnMdLcrP04TJtfNlSD6SjWICGFONV1zAhAmCi1cQl4wBsUHSY
         wE496WNd9zFIc2OO+q78k2svLQrlmZheymXfr6zREizzXq5on/Vf2a1NeOPe0luiYQtp
         sKiA==
X-Gm-Message-State: AOAM530Gu4/W2xig4KS0Y2B8yco3eLIUf8y8chjkWcqN442N8R1P5SmU
        HnV1nVJKSIeVqWRFKgaV2kEsrQ==
X-Google-Smtp-Source: ABdhPJzd4aTWwbHgLiVehRwNu/Aww9ldlPDvwXMqq5Fbgr6Ede34sqCa/CxjNtH/W7wHm0dhAn0xbA==
X-Received: by 2002:ad4:5247:: with SMTP id s7mr13638736qvq.58.1629909259570;
        Wed, 25 Aug 2021 09:34:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q184sm365040qkd.35.2021.08.25.09.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:34:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mIvr0-004zVb-Ks; Wed, 25 Aug 2021 13:34:18 -0300
Date:   Wed, 25 Aug 2021 13:34:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/devices: Re-organize device.c locking
Message-ID: <20210825163418.GZ543798@ziepe.ca>
References: <20210810085252.GC23998@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810085252.GC23998@kili>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 10, 2021 at 12:18:42PM +0300, Dan Carpenter wrote:
> Hello Jason Gunthorpe,
> 
> The patch 921eab1143aa: "RDMA/devices: Re-organize device.c locking"
> from Feb 6, 2019, leads to the following static checker warning:
> 
> 	drivers/infiniband/core/device.c:712 add_client_context()
> 	warn: missing error code 'ret'
> 
> drivers/infiniband/core/device.c
>     689 static int add_client_context(struct ib_device *device,
>     690 			      struct ib_client *client)
>     691 {
>     692 	int ret = 0;
>     693 
>     694 	if (!device->kverbs_provider && !client->no_kverbs_req)
>     695 		return 0;
>     696 
>     697 	down_write(&device->client_data_rwsem);
>     698 	/*
>     699 	 * So long as the client is registered hold both the client and device
>     700 	 * unregistration locks.
>     701 	 */
>     702 	if (!refcount_inc_not_zero(&client->uses))
>     703 		goto out_unlock;
>     704 	refcount_inc(&device->refcount);
>     705 
>     706 	/*
>     707 	 * Another caller to add_client_context got here first and has already
>     708 	 * completely initialized context.
>     709 	 */
>     710 	if (xa_get_mark(&device->client_data, client->client_id,
>     711 		    CLIENT_DATA_REGISTERED))
> --> 712 		goto out;
> 
> Hard to tell if ret should be zero or negative.

It should be 0, this collision is success, the xarray has the correct
data, it was just put there by another thread.

Jason
