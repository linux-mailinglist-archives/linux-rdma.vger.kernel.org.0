Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179BE1D6DE4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 00:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEQWwP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 18:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgEQWwO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 18:52:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30E9C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:52:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r3so3891766qve.1
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zgk4nyC2KPjArKxjtaQr9iDr77fcMNtcG0fq6rx6dJc=;
        b=Xq5TnNSF3TbdBEyFtF+UHdXX7UNLagLgQCub2gdb+UwhT5gUZ2CI5k+R7E+tHJxG6A
         H3rf7AvyKg5PjcWHo8f66RxRMItMJ0BeNTup+NMzPjlQ1ftD6zm45X7UE0BxObzZqNDV
         bKHENVyDyZ4jvylTiHMvMJkcXcc8i/iw8SqeqjRJqNR1nAmkYsnCSr0DmBN15RoTzs5J
         rYW/hGCdlnVndlw5SlBFDYxuDKNB2GjRw+Zn59RwLW/9DEBEbJ1N9S5u0OduofUA1ar0
         HFbXNZIKJF/WXB4hnFxaMrk1lQz+asMxPyEu4nRUdrfspg2h8EVZjn4TA6Do7W1Dy427
         zchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zgk4nyC2KPjArKxjtaQr9iDr77fcMNtcG0fq6rx6dJc=;
        b=QxCzymNxcXUOKw55nHmNIvCJMsTNNIFDiuHZ1cEwPLfJTGHT3ymVWgI4EAXw6TUoqx
         7oU0FDgAAujWDRs1BUqs4oamfw9bWiNQqS761fS5AH/uFWbA0zoM9ie5EioaXeKAquum
         WSp9az8N6Mr8YwmkBoEzk9CY2tlQCd146x3Bq2xo/9xUCLd1frmbT/pzIZQoxBBjMgBH
         GYaIdR01uTBSV4gqMRjd86zc5XOTc4dXYVEx0+6Fe6cCiA9WkhMCbgBmtS/D05HcM1BD
         zKqa488kP/vo8GfJhxLVEVPduSx5Y0HGrwvaFsXToz1ArnNZlMVseBVI6CROBKB432JY
         j54Q==
X-Gm-Message-State: AOAM5319Nwe9EWXBWNJf3EJf7QCQcBFqwUchG/g2BkzC9VmSVPWf1f7l
        A6dyY6mQ8OAq9m7kqrwVDaFgLWx2MkA=
X-Google-Smtp-Source: ABdhPJwLv8gU7UxvDQ4ZIaSE0NAsxHpO6DcOOyHvfxI+9EF9C4iIp376yeBLv5XuEX3xox0AdjOY7Q==
X-Received: by 2002:ad4:5284:: with SMTP id v4mr2419961qvr.167.1589755933933;
        Sun, 17 May 2020 15:52:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n68sm5522702qkb.58.2020.05.17.15.52.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 15:52:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaS8i-000842-LZ; Sun, 17 May 2020 19:52:12 -0300
Date:   Sun, 17 May 2020 19:52:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 02/10] IB/uverbs: Refactor related objects
 to use their own asynchronous event FD
Message-ID: <20200517225212.GA30888@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
 <20200506082444.14502-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:24:36AM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 7959f618b8a5..1d147beaf4cc 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -1051,6 +1051,10 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
>  		goto err_free;
>  
>  	obj->uevent.uobject.object = cq;
> +	obj->uevent.event_file = attrs->ufile->default_async_file;

default_async_file always has to be read with READ_ONCE since there is
no locking.

This repeating pattern should probably be in ia helper function like
was introduced in patch 3 for the ioctl side.

Jason
