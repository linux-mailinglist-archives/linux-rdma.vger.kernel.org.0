Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF211805E0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJSKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 14:10:03 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45783 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJSKD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 14:10:03 -0400
Received: by mail-qv1-f67.google.com with SMTP id du17so5942071qvb.12
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 11:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XB3JmSWgoBFZrd2LuQSCBQTp1UW7odwacKL0wQvjGjQ=;
        b=AyWsvBH0MZh2Qwyeu6lAMROUHI1059iIdVdbxEaaQcLHCcwQZJKSuymCAtf3fbVqx/
         B1vm25vVIkNBVcGNFc4MiiYREDdvd6vqSQV3C1TVJ0ajFFh6mJ9COY6LqJPYPShB4U2s
         T8z+dV0lmWamiqSk74vKhkkZg/NAUhqOAZIT9mOoTiCc+eA+ZbcdETWnTwtdIZGvPCPG
         k+UQ50gk0CAGmBs4wEaJzP2l9/MhXO8jD+E6mlNGYTea30BRMhvgjxOBfUQkVrozt+GQ
         cfO/zLPs5olQyB8ipeJqg4HPoETryeAS41WPA5TIwS/1eesG2jADtSOYOkHnjaSKwrCy
         1AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XB3JmSWgoBFZrd2LuQSCBQTp1UW7odwacKL0wQvjGjQ=;
        b=aXFEZQYvoKIj3zhUWuvg/umgvEd4ZLQ07KC10bIV2g1sIFfn82qnZRj+AEq0qB0Ayt
         Q/0zFlNKSHVKOuH0gQDKYh4dq8stBQbXT5gc6Aydr77Cstoo097b/T9O4rebQB3Zw0r1
         MOL3C/ljdH4OOqVs8IEXBjQzh+4DfkjSCWsUkHUzV6RpidfoBb0kBAfTBmorDm+uJGeF
         hvDElfFk3WijSSvLJruh2/QzUCAps3K1DmXGuXxP1mcszDTxQNW4fJQKalIsZlRcLCKG
         9l1g8uQjt3SfNI4AC27erHZf+tDfVDQtgf89t/ytWvZBC1FPvg5fmCm07b8hJfmwPfR9
         +i6w==
X-Gm-Message-State: ANhLgQ2BD8b+LRk3DkozPDxpJa2solRz3aDE96piu4hgfG/Ni81NH7AQ
        JehDw/GthNlXjisYaZZTLslUa27AbB0=
X-Google-Smtp-Source: ADFU+vufB++3xQG2vw1OGFQecZRBxO7tuTl8C0f5wZM/yAuJm+3CMPp1PFD/wBdct5rDvOXBf0v2Zw==
X-Received: by 2002:a0c:fa03:: with SMTP id q3mr3420204qvn.228.1583863801932;
        Tue, 10 Mar 2020 11:10:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g9sm11191298qkl.39.2020.03.10.11.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 11:10:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBjKL-00023H-37; Tue, 10 Mar 2020 15:10:01 -0300
Date:   Tue, 10 Mar 2020 15:10:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Alex Vesker <valex@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>,
        netdev@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Replace tunnel mpls capability bits for
 tunnel_offloads
Message-ID: <20200310181001.GA7735@ziepe.ca>
References: <20200305123841.196086-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305123841.196086-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 02:38:41PM +0200, Leon Romanovsky wrote:
> From: Alex Vesker <valex@mellanox.com>
> 
> Until now flex parser was used in ib_query_device to indicate
> tunnel_offloads_caps support for mpls_over_gre/mpls_over_udp.
> These inaccurate capability bits will not work on newer devices.
> 
> This should not brake backward compatibility since tunnel_stateless
> caps and flex_parser_protocols caps were added together.
> 
> Cc: <stable@vger.kernel.org> # 4.17
> Fixes: e818e255a58d ("IB/mlx5: Expose MPLS related tunneling offloads")
> Signed-off-by: Alex Vesker <valex@mellanox.com>
> Reviewed-by: Ariel Levkovich <lariel@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 6 ++----
>  include/linux/mlx5/mlx5_ifc.h     | 6 +++++-
>  2 files changed, 7 insertions(+), 5 deletions(-)

Compatability with future devices is not really a -rc thing

Applied to for-next, thanks

Jason
