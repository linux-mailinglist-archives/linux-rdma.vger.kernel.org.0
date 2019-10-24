Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB9E3AA4
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 20:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504008AbfJXSIP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 14:08:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46447 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504005AbfJXSIO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 14:08:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id e66so24266739qkf.13
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hfi15uNup9N+rbKQwtuaM1czGxGO0YeDURH/evQXz+o=;
        b=j/R7CpVyXlxispVqILKPZLcRxgLXuFKEM5d7er0LKlc01U0gy6yjHs7PmCGk7YYcNN
         6TeEXQSmdPReKd1ZKtSJEIV7fHLUKclbvOsnHzaWG6J2v/3AK8SEqcH/jEOuUzV/esV+
         Y1aHQ43HXosrtes5NALznNCfxoE+f652mwwm97XTZtple7ceNER40PpLCymFZ9X87qG/
         41lht14L6AM8pbst+N9H44tbs1qJo2cKLbToKx5mYI9kw86Y0X3FykDiu/B3jQGc4JPa
         9TbD1poldl+Pk2iUW1qyOnjIJiOULgOqGnVUSJzRR4rfTg9kYpZEU7eZxAA3ZrG9mmMa
         sTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hfi15uNup9N+rbKQwtuaM1czGxGO0YeDURH/evQXz+o=;
        b=ee/E2q/CB2zauDF06tKzL94NMekfcD5T90uf8h9aRYAdBVr6V9P6zh2vh3+zW1eQBe
         1l/OBxRcJ2Ql9C7idxcUoIOA/sN5wFfaHQtPuVfFIrWHfNBAgAJpa/YAQFDyaH736mqK
         CynF06zE3qyqPnf4ewanb6POFd+Cq6isKmLnLORdNxb0+bw+tNP4pTTvrWP8heO/Dz3D
         jUMUJxpN4XZOjOkoUoPGub+QJmd/MFpMiOXyxNzaFbvvt356584A0rBoDZobiNh7lf8v
         8+/9XtUfrJvXZWOpWPk81esuMTjeTrkElxJBNtkDN14DzEEWrHXfHs5fIeoCxGACoY0I
         nF8Q==
X-Gm-Message-State: APjAAAWsRojrJ5uj82ZOB/9Uot9UnJyMaxhufLN5wmwKxxbCaRydIwxk
        /e0ShmthNfiEY82jq+I+2iFAQg==
X-Google-Smtp-Source: APXvYqw/tKDkSJk320fMPgMfFmMHMt+PWFPuWZiA9YEsGK/5jJDNnqaW3fSlYxIQPo3TtNozl79vtQ==
X-Received: by 2002:a05:620a:743:: with SMTP id i3mr7680523qki.268.1571940492234;
        Thu, 24 Oct 2019 11:08:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 44sm16972872qtu.45.2019.10.24.11.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 11:08:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNhWt-0007Np-6A; Thu, 24 Oct 2019 15:08:11 -0300
Date:   Thu, 24 Oct 2019 15:08:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     aelior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v3 rdma-next 1/3] RDMA/qedr: Fix qpids xarray api used
Message-ID: <20191024180811.GY23952@ziepe.ca>
References: <20191024175253.26816-1-michal.kalderon@marvell.com>
 <20191024175253.26816-2-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024175253.26816-2-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 08:52:51PM +0300, Michal Kalderon wrote:
> The qpids xarray isn't accessed from irq context and therefore there
> is no need to use the xa_XXX_irq version of the apis.
> Remove the _irq.
> 
> Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>  drivers/infiniband/hw/qedr/main.c       | 1 -
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c      | 4 ++--
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
> index 5136b835e1ba..432dff95a7aa 100644
> +++ b/drivers/infiniband/hw/qedr/main.c
> @@ -359,7 +359,6 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
>  	spin_lock_init(&dev->sgid_lock);
>  
>  	if (IS_IWARP(dev)) {
> -		xa_init_flags(&dev->qps, XA_FLAGS_LOCK_IRQ);

The xarray still has to be init'd, surely?

Jason
