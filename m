Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE551797BE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 19:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgCDSWA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 13:22:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42620 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbgCDSWA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 13:22:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id e11so2588972qkg.9
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 10:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4oBCo1SOwXr1MHZyhksSaHd9zEYq/LD2Cidf4MvMvtk=;
        b=ah17YP2ZRz8Z5ZJiT5PURtTdtHu5m3DhEhPufKjfoeeGt1Xf15/EIsa/HiH48dQOVJ
         dQqGG6XZSAz/IrXehxF4+aMfyhWk/R/T6gOWtZiRuj76iWyieW0m3dEgkpt4rCQtIeA8
         I6CzPSGmjp5ll3wtaJ7BkBCvpRpLW7sp9yWOG/DY1zFOGfrbUF+nur0wB3C97yFRQMgl
         NH/COqlJ+zx5VPYKcfD6SRhwK0KnJd/BMdQmVU/iKbWK97BLwopS6a7gAiZAzle2ca2S
         K9f+J3g2/ytMVHg5VdUVtRy8oFhKSNZ+yz6fy1w1a5OdLHlt4KKDiddTuiMxNQ7ly48L
         qRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4oBCo1SOwXr1MHZyhksSaHd9zEYq/LD2Cidf4MvMvtk=;
        b=G2bPsGnpVwqRdzAJME1muBoL4He6BEgM6GKMvJMoqyutMazHth1AANgXeguJDDMUkR
         Uou2S8EMsfYLroETySacgBMiiquXEQ5M2cIgNtt6B8rXcUTsJom87+vA7vMvhzWfCx+L
         mV3OW1+HugP0ImiYDR/gctJdjs4Pq2aOjw8owrrSwGwbSjntoXmj13FGlkBweMVT/YkT
         f6S+VCjD3Yo4KMwtb3wovDLUNMDqeRjSsov7dU4qkqZdiDZA8VHeo8CZl0G4A92WCuSJ
         cWRpxxO8AGKzSpm4fLRgLd0iJy+mzqnwVJEjOS5nTqC3HtPvICFH5ez14bcWur+9M+ot
         nRlg==
X-Gm-Message-State: ANhLgQ1oAr6LC/4b6mCutycCaD8pbbFFWQZIHUVOtRR/6hZh/rX49H8S
        u3r0UJALjCF496tNsBLs+8J2sg==
X-Google-Smtp-Source: ADFU+vs32RdzFV8eb/4jy56VBTL8/Hz6qRZ9s6qoVbVHu+it6JpfWAF8fDvJkwq+ekesr0rJ9LgSKQ==
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr4389203qkk.285.1583346118968;
        Wed, 04 Mar 2020 10:21:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p14sm15064902qtk.50.2020.03.04.10.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:21:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Yec-0000FK-32; Wed, 04 Mar 2020 14:21:58 -0400
Date:   Wed, 4 Mar 2020 14:21:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/mlx5: Add np_min_time_between_cnps and
 rp_max_rate debug params
Message-ID: <20200304182158.GA916@ziepe.ca>
References: <20200227125246.99472-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227125246.99472-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 27, 2020 at 02:52:46PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Add two debugfs parameters described below.
> 
> np_min_time_between_cnps - Minimum time between sending CNPs from the
>                            port.
>                            Unit = microseconds.
>                            Default = 0 (no min wait time; generated
>                            based on incoming ECN marked packets).
> 
> rp_max_rate - Maximum rate at which reaction point node can transmit.
>               Once this limit is reached, RP is no longer rate limited.
>               Unit = Mbits/sec
>               Default = 0 (full speed)
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/cong.c    | 20 ++++++++++++++++++++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
>  2 files changed, 22 insertions(+)

Applied to for-next, thanks

Jason
