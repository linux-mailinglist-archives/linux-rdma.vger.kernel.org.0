Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C3A194796
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZTkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 15:40:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44268 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTkP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Mar 2020 15:40:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so8136810qkc.11
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2020 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJaweeV50YsVvjC+ZI/s4TAzELRgfc9W2M5rapVdFHs=;
        b=FxQNQHrHsLxzAQyzOHP5wZK8NzihpGEQ1wMD/H4HMiol3mt/5tpmayn8IspngX8LRa
         fOntiXysXhdO/4e+bAb5MePaubxdfCzpHC8nzpPao5gnBmvu8NKa5L1nn9ybfIb924Ql
         ENgOxsBw2eFsoF8ywZstlsV++sF9m8xr3yVCoRPrbRkTZ5t9Agrt4TM+VRj8WFy0Ied7
         WOzjmSVQRo0ry5guwDuLjSruZa9V85hd3RaaOX1no4Q7nnPkYOZVU+Vk3iSJ3E7E3Tan
         qCmngnhOQdwKTJNGne0/3gp7UGHg1p2C7lRt3gRW5cheY83lvP2vLC4JlZqwMwphbyIr
         5lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJaweeV50YsVvjC+ZI/s4TAzELRgfc9W2M5rapVdFHs=;
        b=qWb33FeSRaipsKEAIxo4ONVeAcv8mMZpI7IA81mMggSu50ygjOsq9PkRfBjhtXl/VU
         F5MICAEWd2U+MIE1+20+kjVKVwPiRBoRtcsZXsoyBzCjIqszud5nLlhf6f07WS2H2Nqj
         M6LbXxFAdyPHiafPhdRawcBT6CKp7IqG/VtB4hO/UzRkE4P9lcSx4bK4aDUtnjXihFW2
         KRArhM0fP3t0ZPozwG+xzPWBPpxb/oQMX8aQVWPRZOEd/n4yeq6cAqSn2xckyX/TeY68
         BXFjYbYxGS9mJCnxnPtQ3BZGthx7mHkXWRP9XW+YV/wlQwH79wEuvPYPExmjnqz4/GOj
         OIKQ==
X-Gm-Message-State: ANhLgQ3xbkF3Ogs/2O8N8+mT8IU928GVrsDTlmi9+YZVoZp/nCH/su33
        3YIoXXFAKLhz60RTcDqQVVHmMQ==
X-Google-Smtp-Source: ADFU+vullxJX5MWam/zZgUDdvoMF0vor8Smj69afteESgLGFjB6HRG36FOlDExKKUEyG6ZxXrzqv6w==
X-Received: by 2002:a05:620a:120e:: with SMTP id u14mr9332445qkj.23.1585251614003;
        Thu, 26 Mar 2020 12:40:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d19sm2070672qkc.14.2020.03.26.12.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 12:40:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHYMO-0005W9-1o; Thu, 26 Mar 2020 16:40:12 -0300
Date:   Thu, 26 Mar 2020 16:40:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/mlx5: Block delay drop to unprivileged
 users
Message-ID: <20200326194012.GA16623@ziepe.ca>
References: <20200322124906.1173790-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322124906.1173790-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 22, 2020 at 02:49:06PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Since this feature can globally block the RX port, it should
> be allowed to privileged users only.
> 
> Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog:
>  v1: Changed permission from CAP_NET_RAW to be CAP_SYS_RAWIO like in
>     the devx code.
>  v0: https://lore.kernel.org/linux-rdma/20200318100223.46436-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 4 ++++
>  1 file changed, 4 insertions(+)

Ah, this was merged into rc and is already in linus's tree

Thanks,
Jason
