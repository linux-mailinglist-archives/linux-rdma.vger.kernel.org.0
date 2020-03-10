Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1D1804BD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCJR1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:27:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45955 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJR1e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:27:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so7709296qke.12
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3VV+VeONnTZQ2DS3n3yXA+/gPr19IX2+XpmThNOscus=;
        b=AeGr6adRN9RVmK7jv0Fo4g2/gmDBXWAUN+2nBS/RK9xSpl6bArYTRXsZnioAYpy6kB
         ++QgccJJcGKiov3pEdoESoNdCZ9UIQmk0EMnP6ThsuQeP3hW5gNu8p5zm/RwKcHJuNTP
         lkSBB17Di9pWMBUqBJveuw1nRL1t3YwHkxbpHuAzgBPFY36zrwrUx4DCAEcZusRwFbFr
         lJlkgc4gpbgpWNqeaim7O4XhCKEpMMXw6sYMsRxJhhDqqifDbT/DE+4/aSz4OA7UnqkJ
         WZ1udXH+z5/Nq/d7Ypi+KX1tE6+OaFwRH4VwiuatHT13m6a3ro99ApvD0Vj1wyezmNNQ
         auwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3VV+VeONnTZQ2DS3n3yXA+/gPr19IX2+XpmThNOscus=;
        b=faKXrrr1KTEcTweWB/kDbWsGv/dQk09Bi4E/ec+Hy1zTbqSE0XCkSmdofnvsrDCPaP
         x3SAtGES0ruOsXKDDUP08Ki0KJrWZkvnbw8xgEVV4B6s6sBFdsxYoeOq6yYVsGR+Ci8t
         LQAmwJSSvlDAD1jHDLcwNs6g7Pf1YEbWi/hZYowvfC3APDc/QisbFSXc3w0C/97fsnxa
         8ephFDmgV/QMiWrrw4+LWTeS/SqdseRUH88R1YUFmJ2PH53Qjqo3c5IHV7Clpiz0ggWp
         cz4xlWiBuowfyDEzior5hq4qb71ss/Pd7g9yw5m/mHe1u60STEBoBQB1QXiXE41IL+nE
         QpXA==
X-Gm-Message-State: ANhLgQ1ime70+2lACvkPM6FM3mVctistyPmIRpG9Q3s1dAf6FcNQBxU7
        v9Da0Wg6BLaeH8wGLXSsyIuj4uG+Khc=
X-Google-Smtp-Source: ADFU+vvelmSbrdZXPVWkwAHz5q7n7I9IPTHBzx/uKVVfXTLm7RJdRRUr6dKMbO0D8wYffTc5shXhXA==
X-Received: by 2002:a37:9bcd:: with SMTP id d196mr10677048qke.212.1583861251434;
        Tue, 10 Mar 2020 10:27:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p77sm21950259qke.18.2020.03.10.10.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:27:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBifC-0001UE-HO; Tue, 10 Mar 2020 14:27:30 -0300
Date:   Tue, 10 Mar 2020 14:27:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, parav@mellanox.com
Subject: Re: [PATCH] RDMA/cma: Teach lockdep about the order of rtnl and lock
Message-ID: <20200310172730.GA5656@ziepe.ca>
References: <20200227203651.GA27185@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227203651.GA27185@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 04:36:51PM -0400, Jason Gunthorpe wrote:
> This lock ordering only happens when bonding is enabled and
> a certain bonding related event fires. However, since it can happen this
> is a global restriction on lock ordering.
> 
> Teach lockdep about the order directly and unconditionally so bugs here
> are found quickly.
> 
> See https://syzkaller.appspot.com/bug?extid=55de90ab5f44172b0c90
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/cma.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Lets give it a go, applied to for-next

Jason
