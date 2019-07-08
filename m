Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA78628E3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfGHTCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 15:02:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34142 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfGHTCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 15:02:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so11502911qtq.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Bv3a+k+weXIsoOIfX6xYLi7BPcDGeL7bSx8Y44AnG0=;
        b=UqVil77bLlZTCF011zC65Jp3jozJ7J5aDO+QvVu/soKylnvcg7KYXcNZB3RcP6wGZ9
         szugoo/ApyXppOTzxzXeRyNMnNWybTlHyqn1tWhsYA2JIrnru8jL06rA24IHvyPlonYW
         oFR+6ziHisJV7FV63r2KhfI6dqCctKdASOXvxP2oKyhGBayvf9zokQob0yEC+RNDJstG
         6YiHGotML9Eosx3WgC7fDM6sp7X5RVo1VvC+PR3LMkAhmPIY22LYcVaP6a9r0al1XG5d
         yewkPotJci3yXTdMYUruQlkYJNqSbfq0FAv+vEmN39sunE4H6lA5qHpT/tXT9KRRZyP/
         O3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Bv3a+k+weXIsoOIfX6xYLi7BPcDGeL7bSx8Y44AnG0=;
        b=k6ciu76hJzoLt4nDDqrKKneKRXFNhjmPY1KD9SvHuTp1XCVgC7S8GD7QMuh0gsLElR
         /5yBNGXAPRPAPLtkXLzadSfIxfYP1fdeWm/t3hqDTT0NTtSfs3ucjhuypC/wPeOPDads
         d6gc4yXieGpuahnhKAH0Z2xSxtgksPf/L3uE5eFblW3an7r2fMQ6vhetfUkFeL+Iw07W
         BtPdSLLQb6Sp1neXXLpSKOrPXbgOVIJ9WHc+dtI+qYNbSIiO/Z8UwXBH50Srvhv5k6ro
         rlVvd/bTqZlJv2N6OFkdfOpW2tcqyMwrXEHYmYhj4qUhgHlEwNm5sYGVK7X0YE5kjSRJ
         Iy/w==
X-Gm-Message-State: APjAAAWe7mX3IAXiuQnstn4ngUpv3ACBSkoNjDIic07cXr1skUFR/5Pp
        sET7ox2zS0Yc4evdbaE3yRn6qw==
X-Google-Smtp-Source: APXvYqw2gjl0N4eIrmelGKvMkv2edMphnYCu/SD/rqHccreC+MOyiOMq8xykfPsIlFvkUFn/MdMhEg==
X-Received: by 2002:a0c:b59c:: with SMTP id g28mr16532451qve.244.1562612542775;
        Mon, 08 Jul 2019 12:02:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s7sm6560737qtq.8.2019.07.08.12.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 12:02:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkYu5-0006XU-Kz; Mon, 08 Jul 2019 16:02:21 -0300
Date:   Mon, 8 Jul 2019 16:02:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next v5 0/4] Use RDMA adaptive moderation library
Message-ID: <20190708190221.GA25057@ziepe.ca>
References: <20190708105905.27468-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708105905.27468-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 08, 2019 at 01:59:01PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This is RDMA part of previously sent DIM library improvements series
> [1], which was pulled by Dave. It needs to be pulled to RDMA too as
> a pre-requirements.
> 
> Changes since v4:
>  * Separated mlx5 change from IB/core changes.
> 
> Changes since v3:
>  * Renamed dim_owner to be priv
>  * Added Sagi's ROBs
>  * Removed casting of void pointer.
> 
> Changes since v2:
> - renamed user-space knob from dim to adaptive-moderation (Sagi)
> - some minor code clean ups (Sagi)
> - Reordered patches to ensure that netlink expose is last in the series.
> - Slightly cleaned commit messages
> - Changed "bool use_cq_dim" flag to be bitwise to save space.
> 
> Changes since v1:
> - added per ib device configuration knob for rdma-dim (Sagi)
> - add NL directives for user-space / rdma tool to configure rdma dim
>   (Sagi/Leon)
> - use one header file for DIM implementations (Leon)
> - various point changes in the rdma dim related code in the IB core
>   (Leon)
> - removed the RDMA specific patches form this pull request\
> 
> Thanks
> 
> [1] https://www.spinics.net/lists/netdev/msg581046.html
> 
> Leon Romanovsky (1):
>   RDMA/mlx5: Set RDMA DIM to be enabled by default
> 
> Yamin Friedman (3):
>   linux/dim: Implement RDMA adaptive moderation (DIM)
>   RDMA/core: Provide RDMA DIM support for ULPs
>   RDMA/nldev: Added configuration of RDMA dynamic interrupt moderation
>     to netlink

Applied to for-next

Thanks,
Jason
