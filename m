Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F6D1B7F5A
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgDXTva (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 15:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXTv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 15:51:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D758C09B048
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 12:51:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j4so11429739qkc.11
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k2nipV407gbAu+zBhZImJwGgH5R8UB/KpgVIcSh9rzw=;
        b=YasLr8mFVsQXuDAAdJOtFXy12ViysWYWGb4rDFOHmnLZSAvLOlAf4rU5tv3XnBebhe
         iS6+PA0KVMMVHV0lkY2M3d+Nc/vuIfvDQ3cQYiY7SEyzqpeQYGChbK4HLO9e4vzIEFAJ
         d+sjL8VPDq+JJrccGMqdQopjM1KFUB8ulwwSiUdodq8jQQIZhgTvEKl4YmO5goBsDlf6
         ukeJ6z5gBDmDVDBmAaiIYxKZ6J1fw20OcMu3qP7oekLibD2YyJACdf+ODnSK1I67dgAr
         azmHzfYbRWyXsrRcTFKzPZdD/s+g9/j2WMfAJNQCDVhOM53/O5jsw8Q8SUHtAHH0Dpvw
         LX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k2nipV407gbAu+zBhZImJwGgH5R8UB/KpgVIcSh9rzw=;
        b=GN8w8IXZ662OEQdzIBQ9ElmxzMXQUJAG4gzLgJl5T35pgnelZ074t4Fq0oXaPPCPR0
         6TMMvoX+wJR0KhfoHhGdpZ309wXAJ84OiuJQIv4hJHwND3x74z7k7tND53OljAY/C+Yv
         i1XLIjp2bn62MS/6f1HsdS/55iFdI68HEG24/bmGNf62PFhDIS3xXlVk2fOpG9BTnnY+
         q6xzpJhE4phHAIkF2XBTt3R4IDUxcipBmndHhDk4rzTu73uV0Jjmqdf9OUIUrC0tk7RN
         VSrxaebN7FDmINstX9/RW6v+cjkYkdbRpI1vU/qzmuSvhePxbgdLTFSEcxQnyP0/iXM8
         Djnw==
X-Gm-Message-State: AGi0Puad0XwreIuRGlutd7Zqp8uVispZ88RlkaqkzIaxplXA73ga5izE
        g+ADfafoLpq1FzERRAX9egE8rA==
X-Google-Smtp-Source: APiQypKMsH95Hec/hWoTKj0HTmRPGkRZmGBrDczhce/Z02Q7yhFVQiBnN0RqiKkXGBjjIn2GXBP55A==
X-Received: by 2002:a37:71c4:: with SMTP id m187mr10559944qkc.4.1587757888755;
        Fri, 24 Apr 2020 12:51:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j92sm4560257qtd.58.2020.04.24.12.51.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 12:51:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS4MB-0007Xc-GE; Fri, 24 Apr 2020 16:51:27 -0300
Date:   Fri, 24 Apr 2020 16:51:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 14/18] RDMA/mlx5: Process create QP flags in
 one place
Message-ID: <20200424195127.GA28751@ziepe.ca>
References: <20200420151105.282848-1-leon@kernel.org>
 <20200420151105.282848-15-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420151105.282848-15-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:01PM +0300, Leon Romanovsky wrote:
> +	process_create_flag(dev, &create_flags,
> +			    IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK,
> +			    MLX5_CAP_GEN(mdev, block_lb_mc), qp);

This only applies to datagram QP types

> +	process_create_flag(dev, &create_flags, IB_QP_CREATE_CROSS_CHANNEL,
> +			    MLX5_CAP_GEN(mdev, cd), qp);
> +	process_create_flag(dev, &create_flags, IB_QP_CREATE_MANAGED_SEND,
> +			    MLX5_CAP_GEN(mdev, cd), qp);
> +	process_create_flag(dev, &create_flags, IB_QP_CREATE_MANAGED_RECV,
> +			    MLX5_CAP_GEN(mdev, cd), qp);
> +
> +	if (qp_type == IB_QPT_UD) {
> +		process_create_flag(dev, &create_flags,
> +				    IB_QP_CREATE_IPOIB_UD_LSO,
> +				    MLX5_CAP_GEN(mdev, ipoib_basic_offloads),
> +				    qp);
> +		cond = MLX5_CAP_GEN(mdev, port_type) == MLX5_CAP_PORT_TYPE_IB;
> +		process_create_flag(dev, &create_flags, IB_QP_CREATE_SOURCE_QPN,
> +				    cond, qp);
> +	}
> +
> +	if (qp_type == IB_QPT_RAW_PACKET) {
> +		cond = MLX5_CAP_GEN(mdev, eth_net_offloads) &&
> +		       MLX5_CAP_ETH(mdev, scatter_fcs);
> +		process_create_flag(dev, &create_flags,
> +				    IB_QP_CREATE_SCATTER_FCS, cond, qp);
> +
> +		cond = MLX5_CAP_GEN(mdev, eth_net_offloads) &&
> +		       MLX5_CAP_ETH(mdev, vlan_cap);
> +		process_create_flag(dev, &create_flags,
> +				    IB_QP_CREATE_CVLAN_STRIPPING, cond, qp);
> +	}
> +
> +	process_create_flag(dev, &create_flags,
> +			    IB_QP_CREATE_PCI_WRITE_END_PADDING,
> +			    MLX5_CAP_GEN(mdev, end_pad), qp);

This one is datagram only too

> +
> +	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_WC_TEST,
> +			    qp_type != MLX5_IB_QPT_REG_UMR, qp);
> +	process_create_flag(dev, &create_flags, MLX5_IB_QP_CREATE_SQPN_QP1,
> +			    true, qp);

I wonder if these are excluded from userspace someplace, seems like it
is worth a udata test here just to be clear

> +
> +	if (create_flags)
> +		mlx5_ib_dbg(dev, "Create QP has unsupported flags 0x%X\n",
> +			    create_flags);
> +
> +	return (create_flags) ? -EINVAL : 0;

Since there is already an if, avoid ternary expression

Jason
