Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308A61331A2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 22:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgAGVCc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 16:02:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43788 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgAGVCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 16:02:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so698260qke.10
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 13:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YlR54bznHbnq3XdTLU89rJg/VCVnE6n2xQRXYHY3Ohc=;
        b=n6QAurFzyHzEBCrQqQnGss4SURbvXGzSRf8xOCZGNsZgHUCaFXB/q+Z5Lsr02yi4uG
         5ghb0LOMCeVO2xQVUq7qX8Kjm2E/miN7K9dMUzHqZFxp0w+VnVds12aGhYTgXcICKOpf
         M+clK3aPxMM8QcFQERZOx7UvnwQJ1s0VJyoX/5NJuGs/FUcBRmAqmZX2LXsIl8ZSaXLi
         Qup6bXtiJZmJqgrVHuX+bex3TdtpcTdvACPxzLZkujwNoHHd8bi3R8IF/hG2gAt28s9K
         uqdBCD3OUSEy9TxVJKcCQDbzOXNJ6IfdmyNMSOFkce5s3DoMrQPUSMtFT71fww5Yd/7F
         rgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YlR54bznHbnq3XdTLU89rJg/VCVnE6n2xQRXYHY3Ohc=;
        b=OdQ/wPuNH+CW/AP47md7kS2D37sGmkmheFjvYwYlGODedtZHTaHXPbFGo1ebMQVyNS
         k55Lzhf/mUD6Xf+1IE3I2d8Uqa+aonY+6DYLcJK2iSea3NW8vi+kkh0YwmqaksaA7keG
         hWP3aQgYHKi0hcdrf6sxifMEA5EsqrHOl7yAddA+6kfByr1/uwMSmx55ja9m0Zbrrcp4
         /6VH8/HRZQh2t4b2BndyQOKpdwXwnbK6GlcmsgiCOBDVxopqdSgU7Pg3v072KILgDwKY
         oN8EDF5MZgZqvuNotSQSVb3qv3DLjNThQtvaaiLWXTyUEDnCiQhn3IzisZvSAoXR3w4f
         pS7A==
X-Gm-Message-State: APjAAAWxPf3muCDNhrEQO4BPPy6VA3TfIaNRkF7WOMcdFcABaH+gpldz
        kDmBeorh/CY4y+rtrjQ1pwAgZA==
X-Google-Smtp-Source: APXvYqzOx4o73gdj1vQHK7EJarwY3UMH8MFyOZ9Z9G1ET7RDsvP6ucPe9n04IVQqq7Jm5eEfIr+WLQ==
X-Received: by 2002:ae9:c003:: with SMTP id u3mr1213273qkk.133.1578430951151;
        Tue, 07 Jan 2020 13:02:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g52sm503486qta.58.2020.01.07.13.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 13:02:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iovzi-0002FT-7J; Tue, 07 Jan 2020 17:02:30 -0400
Date:   Tue, 7 Jan 2020 17:02:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next v1 2/4] IB/core: Let IB core distribute cache
 update events
Message-ID: <20200107210230.GA7774@ziepe.ca>
References: <20191212113024.336702-1-leon@kernel.org>
 <20191212113024.336702-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212113024.336702-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 01:30:22PM +0200, Leon Romanovsky wrote:

> @@ -2627,7 +2626,11 @@ struct ib_device {
>  	struct rcu_head rcu_head;
> 
>  	struct list_head              event_handler_list;
> -	spinlock_t                    event_handler_lock;
> +	/* Protects event_handler_list */
> +	struct rw_semaphore event_handler_rwsem;
> +
> +	/* Protects QP's event_handler calls and open_qp list */
> +	spinlock_t event_handler_lock;

This only protects the open_qp list really, the event handler call
doesn't need a spinlock. So lets name it properly. open_list_lock ?

It is sort of weird that we globally serialize all the qp event
handlers? ie that this lock isn't in the ib_qp.

Is this deliberate and relied upon or just something random?

Jason
