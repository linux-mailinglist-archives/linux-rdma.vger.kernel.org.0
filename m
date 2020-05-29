Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9F1E867C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2STQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2STQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 14:19:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16522C03E969
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:19:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so2670712qtv.12
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+6FCOAcgWy6nvzbpA7EI+pr34p50cBGF9Mgfw6PmW1M=;
        b=HfdNrS1UuLZRGWjQgw8xAxT13LCI1iqFQ8/uK4Z4QPNQBRguwlhHwBgKmYyQWEeYQf
         jiRQeRT5ezFygCXHC+Jkbnz5gUEo7Iu5SdHp5hNDNOpJB0zN2aRYawoeYX3x1/NDU21J
         tc3ak52AACpfRKWY/UW1SLB98/AG2V2uRtDmBXGYMWb2AgGc4V+aTKgs6V8XrSKAZwFk
         Hk9YYpoy3Q5h2X2pf+jRtd40fdjQmsqjKtVTr0dQAEHq6UDvqd3Dg7yiWhQIePMTCCwv
         c9NcmdOr6UJjHwxz7V858VXwagfZNJdmMne6gRUPNp91g3w3zpAQKsTYjw+6OlyH1cGg
         ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+6FCOAcgWy6nvzbpA7EI+pr34p50cBGF9Mgfw6PmW1M=;
        b=QYea1MSkFg99CFVDyXvRWhsWViI2JaRtxSnxRJjX8G/2wznA9avGRgFsJbz3rbRlZx
         I/Jt5OpG/6V6zD2Wnqq+YRzsdUddB0T3n+cbYNdLCu6Zf053YwRXw11w8K4FPc4/rGwY
         hZvGcoF5Ifb9fIBJqMhRZ2LdlJlaazd6Q5lvYy/d55TnUd0496CyYHflM8auow9uvSld
         DA9RkQGkp+NUx/j9Lu7pXjjHSv9S2wIM8bnbASiKFOKcoXANCTunS9vja+JDB6hlKOmw
         3dalpT6Lhw3S+PbtKf2yiCVNe7EKltDM3w1zM2sDSi+LXVOataFVI/M/p0KZ9bSSdd7Z
         YeNQ==
X-Gm-Message-State: AOAM533PhBZkVfXgH2gMDB5ZUZP3y96c0nuOTivgE+YsBh3i9B8v18gY
        VG00NDlT8GXbg31K/TV/98PlPg==
X-Google-Smtp-Source: ABdhPJxVqEsOsbuhh0JBxosawiR7F2JoqTntaNJTiZew09/lEjSJrgnGi4m+4rWVkDdqf5aJSieu0Q==
X-Received: by 2002:ac8:468d:: with SMTP id g13mr9351669qto.47.1590776355331;
        Fri, 29 May 2020 11:19:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k190sm7681866qkf.40.2020.05.29.11.19.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:19:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejb7-0001Wx-Rn; Fri, 29 May 2020 15:19:13 -0300
Date:   Fri, 29 May 2020 15:19:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Support TX port affinity for VF
 drivers in LAG mode
Message-ID: <20200529181913.GA5839@ziepe.ca>
References: <20200527055014.355093-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527055014.355093-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 08:50:14AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> The mlx5 VF driver doesn't set QP tx port affinity because it doesn't
> know if the lag is active or not, since the "lag_active" works only for
> PF interfaces. In this case for VF interfaces only one lag is used
> which brings performance issue.
> 
> Add a lag_tx_port_affinity CAP bit; When it is enabled and
> "num_lag_ports > 1", then driver always set QP tx affinity, regardless
> of lag state.
> 
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Changelog
> v1:
>  * Fixed wrong check of num_lag_ports.
> v0: https://lore.kernel.org/linux-rdma/20200526143457.218840-1-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/main.c    | 2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 7 +++++++
>  drivers/infiniband/hw/mlx5/qp.c      | 3 ++-
>  3 files changed, 10 insertions(+), 2 deletions(-)

Applied to for-next thanks

Jason
