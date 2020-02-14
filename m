Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8315F6BD
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBNTYN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 14:24:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34800 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgBNTYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 14:24:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id l16so3055141qtq.1
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2020 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ha43rM3KNl2ywTmmquarsRVleo66vDOJWPO8lRx+MyE=;
        b=aqGNfI4aJe6xDeKXsjDHuhKN9r+mjkz/Rst3N5oxOuWvENMfU9cGCfvUBhz8S+Kb8Z
         cHLKkkZ5Qh7lQo5mHL05Lh1s8w24MZx53if6/eOzvv9nVn493wbVZeebMd3KSvdOgagl
         2DBQgZjfupeuiQh4RqLF5ipSNH3I3cDNM8d+OvM9XIEnNIShIkQHrPLGTjQLyThumlJK
         CIf4biddyc8fOzHgf5d84F0YCqoX+1I3Zrmcq4ai/wc/qEnandR7j8j3eutDqZO0K1Hb
         KskAziz6xoiiJJwaym5T4gK5l4L4KwX2BalnxcEz/1hbQx6lApRZlGlumjDKwtgDJX8g
         19YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ha43rM3KNl2ywTmmquarsRVleo66vDOJWPO8lRx+MyE=;
        b=dQU9YEgM0dD7Oj2jEnuGP646rjhc7Pm8dWdqMfx252nvyhj8NYeLPOoguUVuw9v1d6
         FLvjczcZ2Hx4m197g1PF1XM6pkxGyYI+JMaG1fu5bbFlQYPceEmoUhcTMbUWahz7oS6L
         Co/4IcGUhMpkWd9JZ6iQvZnz+vps05T/HEevzvN6kWe8DqZgvoorDWAw9PjP4CFpG+XL
         /7p52xbJ3tbzB9HHGJuPg24wBgcD8S8fqXVzaIBP2l65XcfbyJemsJSrb0c8HPe9DnnT
         p0vv3sMlRb6PMOEmbNU8eXSXLDXcNy6eY9phzecxKhFvl/W8kCXEBCoK3+Y+63TxDBT+
         PR6Q==
X-Gm-Message-State: APjAAAWn4BsG3lbEzoCs6ZQ7U830V5c6BS6GubYUee9gWwAsRzdnIvF4
        v9m/kMej3XedVLImcTao+dAfYEnh/sNDbQ==
X-Google-Smtp-Source: APXvYqzIjwU2zk+OXOdGkNzQF9DtBBypx0WIlzO3OgwdyiDOqj+uG9Kxjxczfd0IY7E7oPNg/GMF5w==
X-Received: by 2002:ac8:4a16:: with SMTP id x22mr3825965qtq.339.1581708252247;
        Fri, 14 Feb 2020 11:24:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q6sm3726913qkm.46.2020.02.14.11.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 11:24:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2gZO-0000bY-GB; Fri, 14 Feb 2020 15:24:10 -0400
Date:   Fri, 14 Feb 2020 15:24:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Lobakin <alobakin@dlink.ru>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma] IB/mlx5: Fix linkage failure on 32-bit arches
Message-ID: <20200214192410.GW31668@ziepe.ca>
References: <20200214191309.155654-1-alobakin@dlink.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214191309.155654-1-alobakin@dlink.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 14, 2020 at 10:13:09PM +0300, Alexander Lobakin wrote:
> Commit f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> capabilities") introduced a straight "/" division of the u64
> variable "bar_size", which emits an __udivdi3() libgcc call on
> 32-bit arches and certain GCC versions:
> 
> error: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined! [1]
> 
> Replace it with the corresponding div_u64() call.
> Compile-tested on ARCH=mips 32r2el_defconfig BOARDS=ocelot.
> 
> [1] https://lore.kernel.org/linux-mips/CAMuHMdXM9S1VkFMZ8eDAyZR6EE4WkJY215Lcn2qdOaPeadF+EQ@mail.gmail.com/
> 
> Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR
> capabilities")
> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Randy beat you too it..

https://lore.kernel.org/linux-rdma/20200206143201.GF25297@ziepe.ca/

But it seems patchwork missed this somehow.

Applied now at least

Jason
