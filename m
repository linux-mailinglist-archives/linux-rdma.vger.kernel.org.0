Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B641E4CA0
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbgE0SBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388238AbgE0SBV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 14:01:21 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AA2C03E97D
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 11:01:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 18so25023064iln.9
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=247gUuoarQGDzfxQzwAAi0kM5fnBksq5KV5Xjg+xsLQ=;
        b=SgtBQvCyOYwUitRLdNCLawoWuP90+hA+5n1iVEEgDPvJ/8AacXd8zCk9J7IwrMA7Mq
         IPATJgcAaAVUtU7iHfGCeh+M14ZeMMNitSAN4xgbmeXzpWgPAqde5xvGqboxB18NG5K/
         6/Ics5YVcHd6/CxwvAwLbtOM6DnCHjjlXUvop2OmUbBHeWnRHptGsaGfkaUICMAYHgaR
         2cNWLXrafqtH/eDvEb2OXccdbkHPCUY3/Tw9IAQ7kB0KimeQA6ZtHs8JSIfrxxCc/jNe
         /adz0DaLp6xruOCsVgcVxMBZ4uLhGGEsd035ykHsbwRHQH0Gyx/5i+KE3Cy2zE9Z4MyI
         91LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=247gUuoarQGDzfxQzwAAi0kM5fnBksq5KV5Xjg+xsLQ=;
        b=Y4el2Q+GAx9lxpnZdF96kzcdsv4rxhPmEWTBnsu+CrDhWxr50bNYRy6/xtI7lq8jNa
         zurwVGjxqYyqYclgP5A3YdphiaDI+NwtpoXo2Spb/kDYg1NLXlMGv9LFFylNAUZLQK4U
         HK/YIIEJ27HnpejG1R8+pmWmCigXwuYtj2Ysmeh8JE9gWDktEU8ezz+lCWU7T+CTV6wi
         MhK7XwutoGuSMWZDaFsFZFbsZKKdnDrLfIe0mDBygWzdviRCgaoQ6qdI3e5zU22crw3Y
         Jf24mI3kNdoxN0pDVbwRQKh/DJK5R9ZgylhASD6b+zIuGRWmrPOslRxrlrsXBTLd+00j
         bocQ==
X-Gm-Message-State: AOAM531iYqLzXs1IYZ1i81fhfC0DgM2xpO6y0oQsnvrOsK0OJHI40D3w
        vKg0V8GdIHPP36bzobVGe3v9yg==
X-Google-Smtp-Source: ABdhPJzp20LKRffIUH5c5oNkmsM93LPx1jH1IqKF2QQFCyqRa36nPqnSYU4K+GVoQqCzPttZZ0LD2w==
X-Received: by 2002:a92:1fc7:: with SMTP id f68mr3331959ilf.133.1590602480734;
        Wed, 27 May 2020 11:01:20 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id e184sm812798iof.44.2020.05.27.11.01.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 11:01:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1je0Mh-0006WC-2o; Wed, 27 May 2020 15:01:19 -0300
Date:   Wed, 27 May 2020 15:01:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        Aharon Landau <aharonl@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Fix DEVX support for
 MLX5_CMD_OP_INIT2INIT_QP command
Message-ID: <20200527180119.GA25028@ziepe.ca>
References: <20200527135703.482501-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527135703.482501-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 04:57:03PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> The commit citied in the Fixes line wasn't complete and solved
> only part of the problems. Update the mlx5_ib to properly support
> MLX5_CMD_OP_INIT2INIT_QP command in the DEVX, that is required when
> modify the QP tx_port_affinity.
> 
> Fixes: 819f7427bafd ("RDMA/mlx5: Add init2init as a modify command")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to for-next, thanks

Jason
