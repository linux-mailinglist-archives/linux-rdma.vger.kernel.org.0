Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3429042A2EF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbhJLLSb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 07:18:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232771AbhJLLSb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 07:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634037389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMHiyzyJjXVhzhg0cTh0LW9oKsDVObYUCPUOFXh30gg=;
        b=FinNHiUKBH372GQd5fBmsqvGj4N0TTcIb1/TLWbk8JKI1Q+sJquzJOPjc712uE2HsJJ9oF
        lzNq5yGlcIuuFFrpiFHU9sTvLsnwiphNwp/iXIm441nkUiH4NC8Bemn4QrYOo3Mtxsey/m
        s8tuViHDD5aB7zpRnMEvnMFXOBWOOFk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-XjHmF4qZPhC5jh8ECR5GEw-1; Tue, 12 Oct 2021 07:16:12 -0400
X-MC-Unique: XjHmF4qZPhC5jh8ECR5GEw-1
Received: by mail-ed1-f70.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so6195435edb.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 Oct 2021 04:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AMHiyzyJjXVhzhg0cTh0LW9oKsDVObYUCPUOFXh30gg=;
        b=U5z1y+85Zc7HRFmbmUlW5ZCOXupXHU3qoUD1rffERAzt1NvUEu4IS6Ova7TUJTYJ9S
         uJAyD1dtA9sixQ/4Jxb5pSkM8OXzIgNT3dcqW2tYDPNr7+d4BHqy1/pwd1WtexL518Dm
         5MA/dn5WMEk7mmSw0dxLwFPVeZPf5FQNjumgEBKRkJ5b+JuWK9o1XspQg6AKJGY5HVNX
         grAmzAwRnjU4qJRpjgG9L1fhYv+uNg6AQUqWBhsTMcud8h1We/ytusiIRW2hZ8oEk3h1
         BQ1UjWAFWdtk+S/bTmVJQ4zEjgAkKyXoutkr0rhM0V2pxBPz9NfOLuAQciyf7QMfS9Dp
         1WEA==
X-Gm-Message-State: AOAM5334C9DqGWcO8O/xbMjLI/extX8DUrqhsmJikpPfyPBDzRSMxQsl
        JSbRVEaT0N4Vf8ac/pJQPxvZXkrlt/zg07ivmgnX5skq7rIsGDhqNYUviURKsvj0shVmPleu7sK
        nDxRZBrITJyjkr6oPvBGIEA==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr9292185edt.136.1634037371072;
        Tue, 12 Oct 2021 04:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd/URL5pw6izXClolZNFJ+6uNDxVtrZRO7cbO0TSudUpwyflf8/yGeb3BNrZM4At2dztwdvw==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr9292158edt.136.1634037370890;
        Tue, 12 Oct 2021 04:16:10 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id o12sm5673421edw.84.2021.10.12.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 04:16:10 -0700 (PDT)
Date:   Tue, 12 Oct 2021 07:16:05 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH mlx5-next 0/7] Clean MR key use across mlx5_* modules
Message-ID: <20211012071555-mutt-send-email-mst@kernel.org>
References: <cover.1634033956.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634033956.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 01:26:28PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is cleanup series of mlx5_* MR mkey management.
> 
> Thanks


Looks fine superficially

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Aharon Landau (7):
>   RDMA/mlx5: Don't set esc_size in user mr
>   RDMA/mlx5: Remove iova from struct mlx5_core_mkey
>   RDMA/mlx5: Remove size from struct mlx5_core_mkey
>   RDMA/mlx5: Remove pd from struct mlx5_core_mkey
>   RDMA/mlx5: Replace struct mlx5_core_mkey by u32 key
>   RDMA/mlx5: Move struct mlx5_core_mkey to mlx5_ib
>   RDMA/mlx5: Attach ndescs to mlx5_ib_mkey
> 
>  drivers/infiniband/hw/mlx5/devx.c             | 13 +--
>  drivers/infiniband/hw/mlx5/devx.h             |  2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          | 31 ++++---
>  drivers/infiniband/hw/mlx5/mr.c               | 82 +++++++++----------
>  drivers/infiniband/hw/mlx5/odp.c              | 38 +++------
>  drivers/infiniband/hw/mlx5/wr.c               | 10 +--
>  .../mellanox/mlx5/core/diag/fw_tracer.c       |  6 +-
>  .../mellanox/mlx5/core/diag/fw_tracer.h       |  2 +-
>  .../mellanox/mlx5/core/diag/rsc_dump.c        | 10 +--
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en/trap.c |  2 +-
>  .../ethernet/mellanox/mlx5/core/en_common.c   |  6 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 13 ++-
>  .../ethernet/mellanox/mlx5/core/fpga/conn.c   | 10 +--
>  .../ethernet/mellanox/mlx5/core/fpga/core.h   |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/mr.c  | 27 +++---
>  .../mellanox/mlx5/core/steering/dr_icm_pool.c | 10 +--
>  .../mellanox/mlx5/core/steering/dr_send.c     | 11 ++-
>  .../mellanox/mlx5/core/steering/dr_types.h    |  2 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  8 +-
>  drivers/vdpa/mlx5/core/mr.c                   |  8 +-
>  drivers/vdpa/mlx5/core/resources.c            | 13 +--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             |  2 +-
>  include/linux/mlx5/driver.h                   | 30 ++-----
>  25 files changed, 147 insertions(+), 195 deletions(-)
> 
> -- 
> 2.31.1

