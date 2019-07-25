Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE07554E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfGYRVz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:21:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40204 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGYRVz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:21:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so49817397qtn.7
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8PW4lcDkHmKbEsx1KOUz0vxBgw9vayGDBp1ZA42ITrU=;
        b=AUDx02aksnFd5OUpuLQe1fXxXEGoMa7AZXkE38S2Kh5l+rIJf/L6ChQOpt7lbDFgN0
         2VaYmHv5od+AChFdDiKZNcTj9SsisF/FwgQFm724ZKpM89eYnNOSWS6KBMOWOMWRzF9I
         xv0xe5/25fU+oU2+RzNePKw7SxwLe8t8ssTnLDKLT/itiwaK3FHWnNe3Yp/ProDi0sVC
         NqFx5Knj70mnUOLCCCaeiCjKMx25OvkspWP34vlRB/Bj/09JVO45iVrB/Ospk1hKz27W
         5WdsMy6RA6a2KrFeMN9s2k0va3XIn+FN1VkOVmRQ7H7PsZRzNHSh6axAcYLJoriaafBF
         K7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8PW4lcDkHmKbEsx1KOUz0vxBgw9vayGDBp1ZA42ITrU=;
        b=t4uPKOMucWSjAFtBWlwtGUFH0QxbvUCOKv6vdXAdTxHYWXaNfKozx3feGa/1pA/Z5Z
         pyOw+mjLEAnFQnvhOAgjg0Q/P8woFEon3MaXvPXnfpgMxdAqSQ7ppsfel8zjdPewI1qN
         5WX+vFObVMdIFLjUnXnCgYm764cuFIJCcdb/wXdwlh0Bnp/vVckyEKVA0JdTD18NQYks
         tJ4tCKmIMtMveCPIl76x3Nnc0v5PYfUZi6aPfvEEKXNJNevD26gjgrVogzsWsxrZzRqj
         NamToacfsNIdT/Y85c8eYGBWBaqkP6x0Lm31yU7BLUdXIoGQUEYMKPSMlAqhkf7RlT0d
         9/3Q==
X-Gm-Message-State: APjAAAVyEfX7Qd3BGS6g6XeJMNZg8EQj7a4jTq1HvGf3YM6JE7Z6u4Fj
        nW2rPdB+UyGRnAnbTLCVTc+A7A==
X-Google-Smtp-Source: APXvYqyJpGgt6lyQbKAGksmNN6vzv16upxJX6Xp5uXEX+OU0UX5DLDjmxk3YI6IxswMXZggPcLaG9w==
X-Received: by 2002:aed:3c44:: with SMTP id u4mr62090814qte.73.1564075314265;
        Thu, 25 Jul 2019 10:21:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n3sm21234823qkk.54.2019.07.25.10.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:21:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqhRB-0001bL-Cq; Thu, 25 Jul 2019 14:21:53 -0300
Date:   Thu, 25 Jul 2019 14:21:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH RESEND rdma-next] IB: Support netlink commands in non
 init_net net namespaces
Message-ID: <20190725172153.GA6093@ziepe.ca>
References: <20190723070205.6247-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723070205.6247-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 23, 2019 at 10:02:05AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Now that IB core supports RDMA device binding with specific net
> namespace, enable IB core to accept netlink commands in non init_net
> namespaces.
> 
> This is done by having per net namespace netlink socket.
> 
> At present only netlink device handling client RDMA_NL_NLDEV supports
> device handling in multiple net namespaces.
> Hence do not accept netlink messages for other clients in non init_net
> net namespaces.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Rebased on top v5.3-rc1
> ---
>  drivers/infiniband/core/addr.c      |  2 +-
>  drivers/infiniband/core/core_priv.h | 24 ++++++++++-
>  drivers/infiniband/core/device.c    | 38 ++++++-----------
>  drivers/infiniband/core/iwpm_msg.c  |  8 ++--
>  drivers/infiniband/core/iwpm_util.c |  6 +--
>  drivers/infiniband/core/netlink.c   | 63 ++++++++++++++++++++---------
>  drivers/infiniband/core/nldev.c     | 20 ++++-----
>  drivers/infiniband/core/sa_query.c  |  2 +-
>  include/rdma/rdma_netlink.h         | 10 +++--
>  9 files changed, 105 insertions(+), 68 deletions(-)

Applied to for-next, thanks

But for future I would have prefered to see the 'add net * arguments'
part as a 2nd patch

Jason
