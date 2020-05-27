Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683BB1E4DF8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgE0TOo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbgE0TOn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 15:14:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539B2C08C5C1
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 12:14:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h10so27332609iob.10
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/LyIXax8ojmidoGcCgb4SrFybK4Cj9Ao48/94qITCf8=;
        b=dU0xEYJhyGvKKOMD5IriF8FlOFxGrrgPx5SowmIk7Bu09cSGSRBh+ErCffThGEjZzL
         49URZ3JtjgGeP0pOkst8SBzsth30otVZfrfpER64ia+R0VWsxQ2ufDiBnd/J94hjf7bN
         HAPSeiaCtXZuPegow13jbJpsN/o9dAvGpz9S+Kz2NHeghQcPcsHF0SPkBZe9huizFQ9A
         /s6O6e4SRe2ISqGIehsVOQMKUwIae7k0wdl9R04FXm58RRkfTQxypk210IKgazpshKle
         FpHYQU/H+7RulYLmI8pRHwVPeQqhXhoi0gNQJK5DjbmYbwc608mhMGrY/tjE19hw0ggY
         Ydsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LyIXax8ojmidoGcCgb4SrFybK4Cj9Ao48/94qITCf8=;
        b=L8ijDJ4WNrqLysYgbcDwXsRxjMyGZ8auDdxzwe5b+P45YoIL18doCZdQ2lAn043LNf
         YC6yVsey9y/j8dwi08cNA6s8q0/S26RFNZ2235wN3bCUtbC9NL0CC5kZ26f4wVFZac5l
         nVWsPhz0O3deeBUxFcr65EK8N9HbDCCpwLmH+aZ5ER30UBDjWohVHcwsf8WNhncD076H
         rpolzAvjbhNwbqxU8byUbTGkGZDWfd61J6YMB5E3/fAUGlvC+wEArUoFlBn3YIZH9Yv9
         XzIQQDyrOC3jJq5qImt/DpEXnx51+od/hhsfKFz2YVKFmyvQWhOdoGaeXNrAa2XU7JQv
         KZuQ==
X-Gm-Message-State: AOAM533lCfoqUwm64vcMEFhj6WvCWTovE2PEOyoNwxKoNmenWxkglHLx
        RYyZYRLVm9Pv78OXjtW2TI8O2Q==
X-Google-Smtp-Source: ABdhPJw49faPPr0w7sTkoGxcuY4JK3ypYb0AJBBaamDL920cZTbTpo185VABlk95/KbRcuzhc2l52g==
X-Received: by 2002:a05:6602:cc:: with SMTP id z12mr22083743ioe.190.1590606882713;
        Wed, 27 May 2020 12:14:42 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t17sm1966186ilo.60.2020.05.27.12.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 12:14:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1je1Vh-0005Q2-Jl; Wed, 27 May 2020 16:14:41 -0300
Date:   Wed, 27 May 2020 16:14:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 0/8] Driver part of the ECE
Message-ID: <20200527191441.GB20778@ziepe.ca>
References: <20200526115440.205922-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526115440.205922-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 02:54:32PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
> v3:
>  * Squashed patch "RDMA/mlx5: Advertise ECE support" into
>  "RDMA/mlx5: Set ECE options during modify QP".
> v2:
> https://lore.kernel.org/linux-rdma/20200525174401.71152-1-leon@kernel.org
>  * Rebased on latest wip/jgg-rdma-next branch, commit a94dae867c56
>  * Fixed wrong setting of pm_state field in mlx5 conversion patch
>  * Removed DC support for now
> v1:
> https://lore.kernel.org/linux-rdma/20200523132243.817936-1-leon@kernel.org
>  * Fixed compatibility issue of "old" kernel vs. "new" rdma-core. This
>    is handled in extra patch.
>  * Improved comments and commit messages after feedback from Yishai.
>  * Added Mark Z. ROB tags
> v0:
> https://lore.kernel.org/linux-rdma/20200520082919.440939-1-leon@kernel.org
> 
> ----------------------------------------------------------------------
> 
> Hi,
> 
> This is driver part of the RDMA-CM ECE series [1].
> According to the IBTA, ECE data is completely vendor specific, so this
> series extends mlx5_ib create_qp and modify_qp structs with extra field
> to pass ECE options to/from the application.
> 
> Thanks
> 
> [1]
> https://lore.kernel.org/linux-rdma/20200413141538.935574-1-leon@kernel.org
> 
> Leon Romanovsky (8):
>   net/mlx5: Add ability to read and write ECE options
>   RDMA/mlx5: Get ECE options from FW during create QP
>   RDMA/mlx5: Set ECE options during QP create
>   RDMA/mlx5: Use direct modify QP implementation
>   RDMA/mlx5: Remove manually crafted QP context the query call
>   RDMA/mlx5: Convert modify QP to use MLX5_SET macros
>   RDMA/mlx5: Set ECE options during modify QP
>   RDMA/mlx5: Return ECE data after modify QP

Applied to for-next, thanks

Jason
