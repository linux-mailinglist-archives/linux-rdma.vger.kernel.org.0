Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFAD53FAA4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 11:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiFGJ7F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiFGJ6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 05:58:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24714986FC
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 02:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950EC60A55
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820B9C34115;
        Tue,  7 Jun 2022 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654595904;
        bh=Ne0YWqoh7Lm6FcIoKRkt05wKiQiAzNSnH+ScIaZQSnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vdv0Oq/3bWmz2hSOlCFTW/T/w4CGLvfVNXyDiko/KK5on1dQKKtjCbaZUSWk0DxGn
         dYqU9Do738Q36gQ/8YU2mu5bV7JXpcMaVUHOa7agLN2gAEmcYXCBmnILaYrA+K+AKK
         EU3QqX9zcN2ANAasA59MOjBJIJFOflVKdh0WwjpJxVmo6hcLvJnIJDkA9ikw/92nL+
         H+oV+pOrH8msVn0emLnToMHUuaz17eCHTEiQy8p+DL6LNU+CpUMIQqZviy+NeqO2b7
         hdxqv2cfXnbrktSso0K0L0XOQRSs3o7+jkqilbicdEq5cC4B9276g0rGn2M767/jim
         IGva0AH4dfLNg==
Date:   Tue, 7 Jun 2022 12:58:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add a umr recovery flow
Message-ID: <Yp8hO/xGnFFDP69V@unreal>
References: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cc24816cca049bd8541317f5e41d3ac659445d3.1652588303.git.leonro@nvidia.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 15, 2022 at 07:19:53AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> When a UMR fails, the UMR QP state changes to an error state. Therefore,
> all the further UMR operations will fail too.
> 
> Add a recovery flow to the UMR QP, and repost the flushed WQEs.
> 
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c      |  4 ++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 12 ++++-
>  drivers/infiniband/hw/mlx5/umr.c     | 78 ++++++++++++++++++++++++----
>  3 files changed, 83 insertions(+), 11 deletions(-)
> 

Thanks, applied to rdma-next.
